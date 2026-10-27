# Functional scenarios: Pomeranian - A Dog Said Patch Renew (unofficial)

Not shipped: it lives beside `Mod/`, never inside it. Written 2026-10-16 against revision `a129013` of the mod.

`PUBLICATION.md` has no Steam description block yet, so the behaviours below are the ones promised by `Mod/About/About.xml` (`<description>`). One scenario per promised behaviour. The mod is XML only (one patch, `Patches/ADSPatch.xml`): no assembly, no def of its own, no text, no settings. A scenario therefore asks one of three things: does the patch reach its target, does it write only what it says, is it silent where its target is absent.

Legend for **Run by**: `Test-Xml` is `pwsh -NoProfile -File Tests/Test-Xml.ps1` (offline, no game, needs the installed game, A Dog Said... Animal Prosthetics 2 and Pomeranian Continued). `Pickle` marks a check that only a running game can make; no Pickle suite exists yet (`Tests/Pickle/` is not written, see "Pickle, not written"). Pickle runs are filed as tickets with the Ticket Manager, never launched by a session.

## Scenarios

### S1. The pomeranian gets the A Dog Said 2 surgeries

- **Source**: description, "Lets a pomeranian have the animal surgeries of A Dog Said... Animal Prosthetics 2: old wounds treated, peg legs, simple prosthetics and organs, bionics and a power claw."
- **Preconditions**: A Dog Said 2 and Pomeranian Continued loaded, this mod loaded before A Dog Said 2.
- **Actions**: apply the patch to A Dog Said 2's category defs; later, in game, ask the race for its recipes.
- **Expected**: `ADS_Cat1`, `ADS_Cat2` and `ADS_Cat3` each list `aka_Pomeranian` once; vanilla's Husky, Labrador and Yorkshire Terrier are in the same three lists. In game, `InstallPegLegAnimal` and `InstallBionicLegAnimal` are offered for the race `aka_Pomeranian`.
- **Run by**: `Test-Xml` ("applied to A Dog Said 2, the patch writes exactly three entries", "the pomeranian joins the categories vanilla dogs are already in"). `Pickle` (planned): `the recipe "InstallPegLegAnimal" is offered for the race "aka_Pomeranian"`, same for `InstallBionicLegAnimal`, and `the recipe "InstallPegLegAnimal" can be applied on a "Leg" of a "aka_Pomeranian"`.

### S2. The patch writes only the pomeranian, and only into the three categories

- **Source**: description, "Four XML operations became one" and "WHY IT NEEDED REWRITING" (the original matched every `RecipeDef` in the game).
- **Preconditions**: a document with A Dog Said 2's categories among Core's recipes.
- **Actions**: run the patch's predicate and, for comparison, the broken form of the original (`[@Name="A" or "B"]`).
- **Expected**: the patch predicate selects exactly the three `ADS_Cat` defs; the broken form selects every recipe of the document (proof that the test can fail); a control recipe is unchanged after the add.
- **Run by**: `Test-Xml` ("the predicate is a real test and not a tautology", "applied to A Dog Said 2 ... leaves a control recipe alone", "the patch is one guarded operation that adds aka_Pomeranian alone").

### S3. Without A Dog Said 2, the patch does nothing and says nothing

- **Source**: description, "wrapped in a PatchOperationConditional that looks for one of those categories - so without A Dog Said 2 it does nothing and says nothing."
- **Preconditions**: a document with no `ADS_Cat1`.
- **Actions**: run the guard xpath; check the operation carries no `MayRequire`.
- **Expected**: the guard selects nothing in that document and exactly one node in A Dog Said 2; the operation has no `MayRequire` (nothing reads it on an operation).
- **Run by**: `Test-Xml` ("the guard selects nothing when A Dog Said 2 is absent", "the patch is one guarded operation ..."). `Pickle` (planned, lower priority): a pass without A Dog Said 2 shows no red error and no patch line in `Player.log` for this mod.

### S4. The patch loads before A Dog Said 2

- **Source**: description, "MUST LOAD BEFORE A DOG SAID 2 ... declared in the mod's metadata."
- **Preconditions**: the three `About.xml` (this mod, Pomeranian Continued, A Dog Said 2).
- **Actions**: read the declarations; run `scripts/sort-load-order.py` on the three files.
- **Expected**: `forceLoadBefore` names `SamBucher.ADogSaidAnimalProsthetics2`, there is no plain `loadBefore`, both dependencies are declared; the sorter returns Pomeranian Continued, this patch, A Dog Said 2 (checked by hand on 2026-10-15 after NPT's commit `7bafac7`).
- **Run by**: `Test-Xml` ("About.xml keeps the identity ... and the order declarations") for the declarations. The sorter run is not automated here (it needs Python and the protocols checkout); it is recorded in `STATUS.md`, 4.d. `Pickle` (planned): the surgeries are offered in a staged pass, which proves the order only as far as RimWorld itself reads `forceLoadBefore` (unverified for the game's own sort).

### S5. The original standalone patch is declared incompatible

- **Source**: description, "The original standalone patch is declared incompatible above. Run one or the other."
- **Actions**: read `incompatibleWith`.
- **Expected**: it lists `akairo.Pomeranian.ADogSaidPatch`.
- **Run by**: `Test-Xml` ("About.xml keeps the identity ...").

### S6. The target animal exists

- **Source**: implied by every other promise; the patch writes the defName `aka_Pomeranian`.
- **Actions**: look the defName up in Pomeranian Continued's own defs.
- **Expected**: one `ThingDef` and one `PawnKindDef` `aka_Pomeranian` in `1.6/Defs/ThingDefs_Races/Races_Animal_pome.xml`.
- **Run by**: `Test-Xml` ("aka_Pomeranian exists as a ThingDef and a PawnKindDef in Pomeranian Continued").

## Not promised by this mod (recorded so that nobody tests it here)

- The extra recipes on the pomeranian's operations tab when Pomeranian Continued and A Dog Said 2 are both active come from Pomeranian Continued's embedded copy of the original patch (`Patch-ADogSaid/`, 43 hits in the duplicate search). The description says so ("A NOTE ON POMERANIAN CONTINUED"); this mod does not fix it and has no scenario for it.
- Translations, settings, a settings page, a MainButtons shortcut: none exist (`STATUS.md`, Settings audit and Translation audit).

## Pickle, not written (7.d)

No `Tests/Pickle/` exists. What only a running game can show is S1 (recipes offered and applicable on a real `aka_Pomeranian`) and the S3/S4 log checks. They need a `-DepMap` with Pomeranian Continued (`akairo.Pomeranian`, 3682979759) and A Dog Said 2 (`SamBucher.ADogSaidAnimalProsthetics2`, 3238353862), and the Pickle Tools steps `the recipe ... is offered for the race ...` and `... can be applied on a ... of a ...`. Each `@requires:<packageId>` will name the map that mounts it. The suite is written with the gallery steps at `shootGallery`, not here: this file states the plan, it does not claim a run.

## Figures checked

- Three categories, `ADS_Cat1` to `ADS_Cat3`, read from `1.6/Defs/AnimalCategories/Animal_Categories.xml` of A Dog Said 2 (3238353862) on 2026-10-16.
- `InstallPegLegAnimal` and `InstallBionicLegAnimal` are `<defName>`s of A Dog Said 2 (`1.6/Defs/HediffDefs/Prosthetics_Medieval.xml` and the bionics file); the recipe names are quoted from the installed files, not from the description.
- Core recipes gathered as "strangers" for the predicate test: at least 10 (the test fails below that).
