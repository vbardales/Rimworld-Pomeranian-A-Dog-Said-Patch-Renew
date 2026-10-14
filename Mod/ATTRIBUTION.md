# Pomeranian - A Dog Said Patch — attribution

A 1.6 rewrite of **Pomeranian - A Dog Said Patch**, by **akairo**
([2020237999](https://steamcommunity.com/sharedfiles/filedetails/?id=2020237999)).

## Standalone decision — 2026-09-13

Public / silent under the project workflow, with the title
**Pomeranian - A Dog Said Patch 1.6 (unofficial)**. The Steam source page
https://steamcommunity.com/sharedfiles/filedetails/?id=2020237999 was read again:
its version tags are 1.0 and 1.1, matching the installed original About.xml.
The description says the patch has been built in since 1.2. Neither the description
nor either of its two displayed comments grants reuse permission or expressly
prohibits it. The installed original has no licence file or repository link.
This supports the workflow classification; it is not author consent or a grant
of rights. Existing author credits and the removal commitment remain mandatory.

The original Preview was removed from the working tree before this migration.
References below to that image describe the historical package, not the current
payload. It remains excluded from MIT, including in preserved Git history.
New local artwork is separate work in progress; this migration does not establish
its authorship, licence or visual approval. No artwork was published by this step.

The standalone repository is
https://github.com/vbardales/Rimworld-Pomeranian-A-Dog-Said-Patch-Renew, verified
public on 2026-09-13. The existing pushed history is preserved. The local checkout
is C:/Users/nelim/Documents/RimWorldMods/PomeranianADogSaidPatch.

## Historical status: public

The source mod is **dead** — it declares 1.0 and 1.1 and nothing further — and **no licence is
declared anywhere**, checked at the four places one could be: no `LICENSE` file in the mod, no
mention in its `About.xml`, no linked repository (`<url>` is absent entirely), and nothing in the
body of the description on its Steam page. That last check is the one that matters: it is the one
that was skipped once on たたら製鉄, whose ban on redistribution turned out to be a sentence in
its description and nowhere else.

This is the usual convention for ports on the RimWorld Workshop: republished with **credit by
name** and **removal on request, without argument**. The `<author>` field reads
`akairo - 1.6 rewrite: nelim`, and the removal clause is in the description.

## What came from akairo

The **idea** and **`About/Preview.png`**, which is akairo's own.

Nothing else. The mod's entire content was `1.0/Patches/patches.xml` and `1.1/Patches/patches.xml`
— two byte-identical files of four `PatchOperationAdd`s — and every one of those operations has
been thrown away rather than corrected, because what they targeted no longer exists. What ships
here is one operation, written against A Dog Said 2. The `defName` it inserts, `aka_Pomeranian`,
is akairo's, and belongs to the animal mod rather than to this patch.

No def, no texture, no assembly, no translation, no DLC.

## Whose the pieces are

| | |
|---|---|
| `aka_Pomeranian` | akairo's, defined by **Pomeranian Continued** ([3682979759](https://steamcommunity.com/sharedfiles/filedetails/?id=3682979759)), maintained by **Bernau31** — a dependency, not redistributed here |
| `ADS_Cat1` / `ADS_Cat2` / `ADS_Cat3` | **SamBucher's**, defined by **A Dog Said... Animal Prosthetics 2** ([3238353862](https://steamcommunity.com/sharedfiles/filedetails/?id=3238353862)) — a dependency, not redistributed here |
| `About/Preview.png` | akairo's, reused as it stands |
| `Patches/ADSPatch.xml` | written for this rewrite |

## What was wrong with the original

Two faults, and either one alone was enough.

### The predicate matched every recipe in the game

Three of the four operations were written like this:

    /Defs/RecipeDef[defName = "InstallPegLegAnimal" or "OldWoundsAnimalBase"]/recipeUsers

That is not the test it looks like. In XPath, `or` converts each of its operands to a boolean, and
a non-empty string literal is `true` — so the predicate reduces to `… or true` and is true for
**every** `RecipeDef` in the document, whatever its name. The operation adds
`<li>aka_Pomeranian</li>` to the `recipeUsers` of every recipe in the game and in every mod loaded
that declares that element.

That is not a harmless no-op. `recipeUsers` is how a recipe reaches `ThingDef.AllRecipes`, and for
a pawn that list is what the operations tab draws — so a pomeranian is offered every recipe in the
game, cooking and human surgery included, as an operation.

**Measured rather than argued**, by loading the target XML into a `System.Xml.XmlDocument` and
counting, which needs no game launch:

| document | `RecipeDef`s | broken predicate matches | correct predicate matches |
|---|---|---|---|
| Core `Recipes_Surgery_Misc.xml` | 4 | 4 | 0 |
| ADS 2 `Animal_Categories.xml` | 3 | 3 | 0 |

This is the same defect as the one found in
[Dalmatians Renew](https://github.com/vbardales/Rimworld-Dalmatians-Renew), and the two mods now
carry the same corrected form. The fix is to repeat the test on every branch:
`[@Name="A" or @Name="B"]`.

### The names it targeted are the old ones

The five recipes the patch named, checked against A Dog Said 2's 1.6 defs:

| recipe | in ADS 2 1.6 |
|---|---|
| `InstallPegLegAnimal` | present |
| `OldWoundsAnimalBase` | **absent** |
| `InstallBionicEyeAnimal` | present |
| `InstallPowerClawAnimal` | present |
| `InstallSimpleProstheticTailAnimal` | present |

So most survived — but naming recipes one at a time is no longer how an animal is enrolled, and
the one that did not survive is old-wound treatment, which the mod's own description advertises as
the point of the patch.

## How it is written now

**A Dog Said 2 keeps three abstract `RecipeDef`s** — `ADS_Cat1` (medieval replacements), `ADS_Cat2`
(+ simple prosthetics), `ADS_Cat3` (+ bionics) — in
`1.6/Defs/AnimalCategories/Animal_Categories.xml`. Their `recipeUsers` are the animals allowed each
tier. Enrolling an animal is one `<li>` in those lists, and that is what every file under ADS 2's
own `ModCompat/` does.

**All three categories**, because a pomeranian is a trainable pet. ADS 2 states its own rule in the
tooltip of its XML Extensions setting, which is the closest thing it has to documentation:

> Category 1 … Rodents and other tiny animals … Category 2 … Livestock and other animals which
> can't be trained or can't carry extra mass in caravans … Category 3 … Pack animals and trainable
> pets

`aka_Pomeranian` declares `trainability Advanced`, `petness 1` and the `AnimalPet` trade tag — a
category-3 animal. The three lists are cumulative (a category-3 animal is also in 2 and in 1), so
it goes in all three, which is exactly where vanilla's `Husky`, `LabradorRetriever` and
`YorkshireTerrier` sit, and what ADS 2's own Dinosauria patch does for `TyrannosaurusRex`.

**The guard is a `PatchOperationConditional` on `ADS_Cat1`**, whose `xpath` is inherited from
`PatchOperationPathed` and whose `ApplyWorker` is a `SelectSingleNode` followed by `match` or
`nomatch`. With no `<nomatch>` declared, an absent A Dog Said 2 means the operation reports success
and logs nothing.

**It is deliberately not `MayRequire`, which on an `<Operation>` is read by nothing.** This was got
wrong here first and is worth recording precisely, because the wrong form is indistinguishable from
the right one by eye. `Verse.PatchOperation` has three fields — `sourceFile`, `neverSucceeded`,
`success` — and no `mayRequire`. `ModContentPack.LoadPatches`, which builds each operation, never
reads the attribute. `DirectXmlToObject.ObjectFromXml` *does* load the `"MayRequire"` literal, which
is what makes the inference tempting, but at IL offsets 1440 and 1459 of a 1700-byte method,
immediately before the `RegisterObjectWantsCrossRef` call at 1525: that is the path for a **def
reference inside a field**, not the root node being constructed. So the operation applies whether
A Dog Said 2 is loaded or not.

The attribute is honoured on a def node (`LoadedModManager.ParseAndProcessXML`), on every `<li>`
(`DirectXmlToObject.ListFromXml`) and on any ordinary field element. A Dog Said 2 uses it correctly
in exactly that last sense — on the `<li>`s inside the category lists, gating DLC animals with
`MayRequire="ludeon.rimworld.odyssey"`. Copying that vocabulary up onto the `<Operation>` is the
mistake, and live 1.6 mods make it; nothing in the log says so.

There is no native way to gate an operation on a `packageId`. The alternatives are this conditional,
the older `PatchOperationSequence` + `PatchOperationTest` + `<success>Always</success>`, or
`PatchOperationFindMod`, which compares the display name shown in the mod list.

## The load-order requirement, and how it was established

**This mod must load before A Dog Said 2**, and `<loadBefore>` says so in `About.xml`.

The three `ADS_Cat` defs are abstract and nothing inherits from them. What connects them to real
recipes is ADS 2's own last patch, `1.6/Patches/z_Category_Patches.xml` — named `z_` so it sorts
after every one of its `ModCompat` files — which copies each category's `recipeUsers` onto the
surgery bases:

| from | onto |
|---|---|
| `ADS_Cat1` | `SurgeryInstallMedievalBodyPartAnimalBase`, `InstallDentureAnimal` |
| `ADS_Cat2` | `SurgeryInstallSimpleProstheticBodyPartAnimalBase` |
| `ADS_Cat3` | `SurgeryInstallBionicBodyPartAnimalBase`, `SurgeryInstallMiscBodyPartAnimalBase` |

with `PatchOperationAddOrMergeCopy`, which takes the list as it stands at that moment. An addition
made after that copy lands in a list nothing reads any more.

ADS 2's own compat files are safe because they are inside ADS 2, where file-name order settles it.
An outside mod is not, and the order that decides is the mod list. **Checked against the 1.6
assembly rather than assumed**: `Verse.LoadedModManager.ApplyPatches` is a `SelectMany` over the
running mods followed by `PatchOperation.Apply` — patches run mod by mod, in load order.

`<loadAfter>akairo.Pomeranian</loadAfter>` is deliberately **not** declared. It is not needed —
RimWorld merges every mod's XML into one document before any patch runs, so the animal's def is
present whatever the order — and declaring it would close a cycle, since Pomeranian Continued
itself asks to load after A Dog Said 2.

## One upstream fault, recorded and left alone

**Pomeranian Continued ships akairo's broken patch inside itself.**
`Patch-ADogSaid/Patches/patches.xml` in
[3682979759](https://steamcommunity.com/sharedfiles/filedetails/?id=3682979759) is byte for byte
the dead standalone mod's file — same SHA-256 — and its `LoadFolders.xml` loads that folder
`IfModActive="SamBucher.ADogSaidAnimalProsthetics2"` for 1.4, 1.5 and 1.6.

So the always-true predicate is not a museum piece: it fires today for anyone running Pomeranian
Continued together with A Dog Said 2, and the pomeranian collects every recipe in the game on its
operations tab. What it does *not* do is deliver the surgeries, because Pomeranian Continued
declares `<loadAfter>SamBucher.ADogSaidAnimalProsthetics2</loadAfter>`: its stray addition to the
`ADS_Cat` lists arrives after ADS 2 has already copied them. Both halves wrong.

**This mod cannot clean that up**, and it would be dishonest to ship something that appeared to.
Removing the stray entries would have to happen after Pomeranian Continued's patch and before
ADS 2's copy — that is, `akairo.Pomeranian` < here < `SamBucher.ADogSaidAnimalProsthetics2`, which
contradicts Pomeranian Continued's own `loadAfter` and cannot be satisfied. A best-effort removal
that fires or not depending on how the user happens to have sorted their list is worse than a
plainly stated bug.

The repair belongs in Pomeranian Continued, where it is small: delete `Patch-ADogSaid/`, or replace
its contents with the single operation in this mod's `Patches/ADSPatch.xml`. Bernau31 maintains it
and is active.

## What was dropped from the published folder

`About/PublishedFileId.txt`, for the obvious reason: it names akairo's Workshop item.

The `1.0/` and `1.1/` folder split, and with it the accident that kept the mod loading at all — it
has no `LoadFolders.xml`, and `ModContentPack.InitLoadFolders` falls back to the highest
version-named folder at or below the current one, so `1.1/` was still being read in 1.6.

## Adoption

If I do not answer within a reasonable time after being contacted, anyone may freely update this or
any other of my mods, including publishing a continuation of it. All credit must be preserved.
