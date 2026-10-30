<#
.SYNOPSIS
  Offline tests of the Pomeranian - A Dog Said Patch Renew mod. No RimWorld running, a few seconds.

.DESCRIPTION
  The mod is one XML patch (Mod/Patches/ADSPatch.xml) and its About.xml. What can go wrong is therefore
  narrow: the patch does not reach its target, reaches too much, fires without A Dog Said 2, or the
  declarations in About.xml drift. Each test below computes its answer from the real files rather than
  from the mod's own prose:

    - the predicate is run against A Dog Said 2's category defs placed among Core's own recipes (strangers),
      next to the broken form the original shipped, so the test cannot pass on a document of three recipes;
    - the guard is run against a document with no ADS_Cat1;
    - the add is applied by hand to a copy of the categories: exactly three aka_Pomeranian entries, a control
      recipe untouched;
    - the target animal is looked up in Pomeranian Continued's own defs.

  The generic checks (well-formed XML, XPath compiles, About rules, the two licence files, the images) are the
  shared scripts/Check-ModBasics.ps1, called first. Until the Preview is mounted (`mountPreview`) its only
  finding is the missing Mod/About/Preview.png, which this suite tolerates and says so; any other finding fails.

  Needs, read from disk: the installed game (Core recipes), A Dog Said... Animal Prosthetics 2 (3238353862) and
  Pomeranian Continued (3682979759). A test whose input is absent reports SKIP, never a pass.

    pwsh -NoProfile -File Tests\Test-Xml.ps1
    pwsh -NoProfile -File Tests\Test-Xml.ps1 -ModRoot <copy of the mod> (to see a test fail on a mutated copy)

  Exit code 0 when nothing failed, 1 otherwise.
#>
param(
  [string]$ModRoot = (Split-Path $PSScriptRoot -Parent),
  [string]$Protocols = (Join-Path (Split-Path $PSScriptRoot -Parent) '..'),
  [string]$Steam = 'C:\Program Files (x86)\Steam\steamapps',
  [string]$AdsId = '3238353862',
  [string]$PomeId = '3682979759'
)
$ErrorActionPreference = 'Stop'
$ModRoot = (Resolve-Path $ModRoot).Path
. (Join-Path $Protocols 'scripts\lib\TestRunner.ps1')
. (Join-Path $Protocols 'scripts\lib\PatchEngine.ps1')

$mod       = Join-Path $ModRoot 'Mod'
$aboutPath = Join-Path $mod 'About\About.xml'
$patchPath = Join-Path $mod 'Patches\ADSPatch.xml'
$adsRoot   = Join-Path $Steam "workshop\content\294100\$AdsId"
$pomeRoot  = Join-Path $Steam "workshop\content\294100\$PomeId"
$coreRecipes = Join-Path $Steam 'common\RimWorld\Data\Core\Defs\RecipeDefs'
$adsCats   = Join-Path $adsRoot '1.6\Defs\AnimalCategories\Animal_Categories.xml'
$pomeRace  = Join-Path $pomeRoot '1.6\Defs\ThingDefs_Races\Races_Animal_pome.xml'

function Load-Xml([string]$p) {
  if (-not (Test-Path $p)) { return $null }
  $d = New-Object System.Xml.XmlDocument
  try { $d.Load($p); return $d } catch { return $null }
}
$about = Load-Xml $aboutPath
$patch = Load-Xml $patchPath
$ads   = Load-Xml $adsCats

Write-Output "Pomeranian - A Dog Said Patch Renew: offline tests"
Write-Output ("  mod {0}" -f $ModRoot)
Write-Output ("  A Dog Said 2: {0}; Pomeranian Continued: {1}; Core recipes: {2}" -f `
  $(if ($ads) { 'read' } else { 'NOT FOUND' }), $(if (Test-Path $pomeRace) { 'read' } else { 'NOT FOUND' }), $(if (Test-Path $coreRecipes) { 'read' } else { 'NOT FOUND' }))

# ---- Group 1: shared checks and identity ---------------------------------------------------------------------------

It 'the shared basics check finds nothing (the missing Preview is tolerated until mountPreview)' {
  $out = & pwsh -NoProfile -File (Join-Path $Protocols 'scripts\Check-ModBasics.ps1') -ModRoot $ModRoot -Unofficial 2>&1
  $lines = @($out | ForEach-Object { "$_" } | Where-Object { $_ -and $_ -notmatch '^(FAIL|OK|PASS)' })
  if ($LASTEXITCODE -ne 0 -and -not $lines) { "Check-ModBasics exited $LASTEXITCODE with no finding line" }
  foreach ($l in $lines) {
    if ($l -match 'Mod/About/Preview\.png is missing' -or $l -match 'Preview\.png is missing') { Note 'tolerated: Preview.png is made at mountPreview'; continue }
    $l
  }
}

It 'About.xml keeps the identity that must never change, and the order declarations that make the patch reach ADS 2' {
  if (-not $about) { 'About.xml does not parse or is missing'; return }
  $r = $about.ModMetaData
  if ($r.packageId -cne 'nelim.pomeranian.adogsaidpatch') { "packageId is '$($r.packageId)'" }
  $deps = @($r.modDependencies.li | ForEach-Object { $_.packageId })
  foreach ($need in @('akairo.Pomeranian', 'SamBucher.ADogSaidAnimalProsthetics2')) {
    if ($deps -notcontains $need) { "modDependencies lacks $need" }
  }
  $fb = @($r.forceLoadBefore.li)
  if ($fb -notcontains 'SamBucher.ADogSaidAnimalProsthetics2') { 'forceLoadBefore does not name A Dog Said 2: the patch would be sorted after the copy of its categories' }
  if ($r.loadBefore) { 'a plain loadBefore is declared again; the sorter would drop it on the Pomeranian Continued cycle (see STATUS.md, 4.d)' }
  if (@($r.incompatibleWith.li) -notcontains 'akairo.Pomeranian.ADogSaidPatch') { 'the original standalone patch is no longer declared incompatible' }
  if (@($r.supportedVersions.li).Count -lt 1) { 'supportedVersions is empty' }
  if (-not ($r.name -match '\(unofficial\)$')) { 'the name no longer ends with (unofficial)' }
}

It 'the About description names no RimWorld version (AGENTS.md, owner rule 2026-10-13) and has no em dash' {
  if (-not $about) { 'About.xml does not parse or is missing'; return }
  $d = [string]$about.ModMetaData.description
  if ($d -match '(?<![\d.])1\.[67](?!\d|\.\d)') { "the description names a version: '$($Matches[0])'" }
  if ($d.Contains([string][char]0x2014)) { 'the description holds an em dash (U+2014)' }
}

# ---- Group 2: the patch ---------------------------------------------------------------------------------------------

It 'the patch is one guarded operation that adds aka_Pomeranian alone, with no MayRequire on the operation' {
  if (-not $patch) { 'ADSPatch.xml does not parse or is missing'; return }
  $ops = @($patch.SelectNodes('/Patch/Operation'))
  if ($ops.Count -ne 1) { "expected 1 operation, found $($ops.Count)" ; return }
  if ($ops[0].GetAttribute('Class') -cne 'PatchOperationConditional') { "the operation is '$($ops[0].GetAttribute('Class'))', not PatchOperationConditional" }
  if ($ops[0].HasAttribute('MayRequire')) { 'MayRequire sits on the operation; nothing reads it there' }
  $added = @($patch.SelectNodes('//match/value/li') | ForEach-Object { $_.InnerText.Trim() })
  if ("$added" -cne 'aka_Pomeranian') { "the patch adds [$($added -join ', ')], expected aka_Pomeranian alone" }
}

if (-not $ads -or -not (Test-Path $coreRecipes)) {
  foreach ($n in @('the predicate is a real test and not a tautology', 'the guard selects nothing when A Dog Said 2 is absent', 'applied to A Dog Said 2, the patch writes exactly three entries and leaves a control recipe alone', 'the pomeranian joins the categories vanilla dogs are already in')) {
    Test-That $n { 'skip' }
  }
} else {

It 'the predicate is a real test and not a tautology' {
  # ADS 2's file holds exactly the three defs, so on that file alone both forms select three. The three are put
  # among Core's recipes, the situation RimWorld really presents (one combined document).
  $doc = New-Object System.Xml.XmlDocument
  [void]$doc.AppendChild($doc.CreateElement('Defs'))
  foreach ($n in $ads.SelectNodes('/Defs/RecipeDef')) { [void]$doc.DocumentElement.AppendChild($doc.ImportNode($n, $true)) }
  $strangers = 0
  foreach ($f in Get-ChildItem $coreRecipes -Filter *.xml) {
    $x = Load-Xml $f.FullName; if (-not $x) { continue }
    foreach ($n in $x.SelectNodes('/Defs/RecipeDef')) { [void]$doc.DocumentElement.AppendChild($doc.ImportNode($n, $true)); $strangers++ }
  }
  if ($strangers -lt 10) { "only $strangers Core recipes gathered; the comparison needs strangers to mean anything"; return }
  $xp   = $patch.SelectSingleNode('//match/xpath').InnerText
  $pred = ($xp -replace '/recipeUsers\s*$', '') -replace '\s+', ' '
  $broken = [regex]::Replace($pred, '\[\s*@Name\s*=\s*', '[@Name = ') -replace 'or\s+@Name\s*=\s*', 'or '
  $hit = @($doc.SelectNodes($pred)); $bad = @($doc.SelectNodes($broken)); $all = @($doc.SelectNodes('/Defs/RecipeDef'))
  if ($hit.Count -ne 3) { "the predicate selects $($hit.Count) of $($all.Count) recipes, expected the 3 ADS_Cat defs" }
  foreach ($n in $hit) { if ($n.GetAttribute('Name') -notmatch '^ADS_Cat[123]$') { "the predicate also selects $($n.GetAttribute('Name'))" } }
  if ($bad.Count -ne $all.Count) { "the XPath 1.0 quirk behind the original's bug no longer reproduces: the broken form selects $($bad.Count) of $($all.Count); this test proves nothing" }
}

It 'the guard selects nothing when A Dog Said 2 is absent' {
  $xp = $patch.SelectSingleNode('/Patch/Operation/xpath').InnerText
  $empty = New-Object System.Xml.XmlDocument
  $empty.LoadXml('<Defs><RecipeDef Name="SomeoneElsesCategory" Abstract="True"><recipeUsers><li>Husky</li></recipeUsers></RecipeDef></Defs>')
  if (@($empty.SelectNodes($xp)).Count -ne 0) { 'the guard fires on a document with no ADS_Cat1' }
  if (@($ads.SelectNodes($xp)).Count -ne 1) { 'the guard does not find ADS_Cat1 in A Dog Said 2 itself' }
}

It 'applied to A Dog Said 2, the patch writes exactly three entries and leaves a control recipe alone' {
  $doc = New-Object System.Xml.XmlDocument
  $doc.LoadXml($ads.OuterXml)
  $ctl = $doc.CreateElement('RecipeDef'); $ctl.SetAttribute('Name', 'ControlRecipe'); $ctl.SetAttribute('Abstract', 'True')
  $ru = $doc.CreateElement('recipeUsers'); $li = $doc.CreateElement('li'); $li.InnerText = 'Human'; [void]$ru.AppendChild($li); [void]$ctl.AppendChild($ru)
  [void]$doc.DocumentElement.AppendChild($ctl)
  # The real operation (guard, then add) runs through the shared engine, not a hand-made copy of it.
  try { Invoke-PatchFile $patchPath $doc -RequireMatch } catch { "the patch does not apply: $($_.Exception.Message)"; return }
  $n = @($doc.SelectNodes('//recipeUsers/li[text()="aka_Pomeranian"]')).Count
  if ($n -ne 3) { "expected 3 aka_Pomeranian entries after the add, found $n" }
  $c = @($doc.SelectNodes('/Defs/RecipeDef[@Name="ControlRecipe"]/recipeUsers/li') | ForEach-Object { $_.InnerText })
  if ("$c" -cne 'Human') { "the control recipe changed: [$($c -join ', ')]" }
}

It 'the pomeranian joins the categories vanilla dogs are already in, and ADS 2 does not already list it' {
  $mine = (@($patch.SelectNodes('//match/xpath') | ForEach-Object { $_.InnerText }) -join ' ')
  foreach ($cat in @('ADS_Cat1', 'ADS_Cat2', 'ADS_Cat3')) {
    if ($mine -notmatch [regex]::Escape("@Name=`"$cat`"")) { "the patch does not name $cat" }
    $users = @($ads.SelectNodes("/Defs/RecipeDef[@Name=`"$cat`"]/recipeUsers/li") | ForEach-Object { $_.InnerText.Trim() })
    if ($users.Count -eq 0) { "$cat lists no animal at all; the parity check is empty"; continue }
    foreach ($dog in @('Husky', 'LabradorRetriever', 'YorkshireTerrier')) {
      if ($users -notcontains $dog) { "A Dog Said 2 no longer puts $dog in $cat; the parity claim is stale" }
    }
    if ($users -contains 'aka_Pomeranian') { "$cat already lists aka_Pomeranian: A Dog Said 2 now ships its own patch for this animal" }
  }
}

}

# ---- Group 3: the target animal -------------------------------------------------------------------------------------

if (-not (Test-Path $pomeRace)) {
  Test-That 'aka_Pomeranian exists as a ThingDef and a PawnKindDef in Pomeranian Continued' { 'skip' }
} else {
  It 'aka_Pomeranian exists as a ThingDef and a PawnKindDef in Pomeranian Continued' {
    $d = Load-Xml $pomeRace
    if (-not $d) { 'Races_Animal_pome.xml does not parse'; return }
    if (@($d.SelectNodes('/Defs/ThingDef[defName="aka_Pomeranian"]')).Count -ne 1) { 'no single ThingDef aka_Pomeranian' }
    if (@($d.SelectNodes('/Defs/PawnKindDef[defName="aka_Pomeranian"]')).Count -ne 1) { 'no single PawnKindDef aka_Pomeranian' }
  }
}

Complete-Tests
