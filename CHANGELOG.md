# Changelog

All notable changes to this mod are documented here.

## [Unreleased]

First release (1.0.0, not yet published). Rewrite of akairo's **Pomeranian - A Dog Said Patch** for the
latest RimWorld version.

### Fixed

- `Patches/ADSPatch.xml`: the XPath predicate `[defName = "A" or "B"]` is replaced by one where every
  branch is compared (`[@Name="A" or @Name="B"]`; it uses `@Name` because the targets, the abstract
  `ADS_Cat` defs, carry a `Name` attribute and no `<defName>` element). The original is not the test it looks like, in XPath, `or` converts
  each operand to a boolean and a non-empty string literal is `true`, so the predicate reduced to
  `… or true` and matched **every** `RecipeDef` in the document. Three of the mod's four operations
  were written that way, and they added `aka_Pomeranian` to the `recipeUsers` of every recipe in
  the game and in every mod loaded that declares that element. Since `recipeUsers` is how a recipe
  reaches `ThingDef.AllRecipes`, and a pawn's operations tab draws that list, the pomeranian was
  offered every recipe in the game as an operation. Counted with `System.Xml.XmlDocument`: 4 of 4
  `RecipeDef`s matched in Core's `Recipes_Surgery_Misc.xml`, where the correct predicate matches 0.
  Same defect and same fix as in Dalmatians.
- `Patches/ADSPatch.xml`: rewritten to target A Dog Said 2. The four operations named the recipes
  *A Dog Said... Animal Prosthetics* used up to 2023, `OldWoundsAnimalBase`, `InstallPegLegAnimal`,
  `InstallBionicEyeAnimal` and a dozen more. **A Dog Said... Animal Prosthetics 2**
  (`SamBucher.ADogSaidAnimalProsthetics2`, which declares 1.6) enrols animals through three
  abstract categories instead, `ADS_Cat1` to `ADS_Cat3`; of the five recipes this patch named,
  `OldWoundsAnimalBase` no longer exists at all, and it is the one the mod's description
  advertises. The four operations are replaced by one, adding the pomeranian to all three
  categories, where vanilla's `Husky`, `LabradorRetriever` and `YorkshireTerrier` already are.

### Changed

- The operation is wrapped in a `PatchOperationConditional` on `ADS_Cat1`. The original had no guard
  at all. With no `<nomatch>` declared, an absent A Dog Said 2 means the operation reports success
  and logs nothing.

  It was first written as `MayRequire="SamBucher.ADogSaidAnimalProsthetics2"` on the operation, which
  is **inert**: `Verse.PatchOperation` has no such field and `ModContentPack.LoadPatches`, which
  builds each operation, never reads the attribute, so the add would have applied with or without
  A Dog Said 2. `DirectXmlToObject.ObjectFromXml` does load the literal, at IL offsets 1440/1459 of
  a 1700-byte method, immediately before `RegisterObjectWantsCrossRef` at 1525, which is the
  def-reference-in-a-field path, not the root node. The attribute is honoured on a def node, on a
  `<li>` and on any field element, which is why the wrong form reads as correct; A Dog Said 2 uses
  it properly on the `<li>`s of those very lists. There is no native way to gate an *operation* on a
  `packageId`.
- `packageId` changed from `akairo.Pomeranian.ADogSaidPatch` to `nelim.pomeranian.adogsaidpatch`.
- `<supportedVersions>` set to 1.6.
- `<modDependencies>` now names **Pomeranian Continued** (`akairo.Pomeranian`, 3682979759) and
  **A Dog Said... Animal Prosthetics 2** (`SamBucher.ADogSaidAnimalProsthetics2`, 3238353862). The
  original pointed at `spoonshortage.ADogSaidAnimalProsthetics`, the pre-2023 mod, and at the
  original Pomeranian's Workshop id.
- `About/PublishedFileId.txt` dropped: it names akairo's Workshop item.
- The `1.0/` and `1.1/` version folders dropped. Both held byte-identical files, and the mod ships
  no `LoadFolders.xml`, so `ModContentPack.InitLoadFolders` was falling back to the highest
  version-named folder at or below the current one, which is how a mod that declares 1.1 was still
  loading, and misbehaving, under 1.6.

### Added

- `<forceLoadBefore>SamBucher.ADogSaidAnimalProsthetics2</forceLoadBefore>`, which the original had no need
  of and this rewrite does. The `ADS_Cat` defs are abstract and nothing inherits from them; A Dog
  Said 2's own last patch, `z_Category_Patches.xml`, copies their `recipeUsers` onto the real
  surgery bases with `PatchOperationAddOrMergeCopy`, taking each list as it stands at that moment.
  An addition made after that copy goes into a list nothing reads. Cross-mod patch order is mod
  load order, checked against the 1.6 assembly: `Verse.LoadedModManager.ApplyPatches` is a
  `SelectMany` over the running mods followed by `PatchOperation.Apply`.
- `<incompatibleWith>akairo.Pomeranian.ADogSaidPatch</incompatibleWith>`: the two would both add
  `aka_Pomeranian`, and the original would still be matching every recipe in the game.
- The ` (unofficial)` title suffix, the `UNOFFICIAL` notice with the removal-on-request commitment,
  and the source-code link at the end of the English description.
- A standalone repository for the mod, keeping the existing GitHub history.
- A ModIcon and an own Preview illustration source.

### Removed

- akairo's own `About/Preview.png`, replaced by this rewrite's own image.

### Unchanged

- The `defName` inserted, `aka_Pomeranian`. Confirmed still current in Pomeranian Continued's 1.6
  build, in `1.6/Defs/ThingDefs_Races/Races_Animal_pome.xml`, for both the `ThingDef` and the
  `PawnKindDef`.

### Known and not fixed

- **Pomeranian Continued ships akairo's broken patch inside itself**, at
  `Patch-ADogSaid/Patches/patches.xml`, byte for byte the dead standalone mod's file, same
  SHA-256, loaded by its `LoadFolders.xml` whenever A Dog Said 2 is active, in 1.4, 1.5 and 1.6.
  The always-true predicate therefore fires today for anyone running both mods, and the surgeries
  still do not arrive, because Pomeranian Continued declares
  `<loadAfter>SamBucher.ADogSaidAnimalProsthetics2</loadAfter>` and its accidental addition to the
  categories lands after A Dog Said 2 has copied them.

  This mod cannot repair it. A cleanup would have to run after Pomeranian Continued's patch and
  before A Dog Said 2's copy, `akairo.Pomeranian` < here < `SamBucher.ADogSaidAnimalProsthetics2`
 , which Pomeranian Continued's own `loadAfter` makes unsatisfiable. Shipping a cleanup that fires
  or not depending on how a user sorted their list would be worse than saying so plainly. The
  repair belongs upstream, where it is a deletion.
