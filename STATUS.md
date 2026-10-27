---
localization: not_applicable
translation_en: not_applicable
translation_fr: not_applicable
settings_audit: not_applicable
mod:          Pomeranian - A Dog Said Patch Renew (unofficial)
packageId:    nelim.pomeranian.adogsaidpatch
repo:         Rimworld-Pomeranian-A-Dog-Said-Patch-Renew
remote:       https://github.com/vbardales/Rimworld-Pomeranian-A-Dog-Said-Patch-Renew.git
visibility:   public
detached:     no
workflow_stage: playTests[1.0.0]
licence:      silent
licence_at:   "2026-10-15: no licence and no reuse permission on the original patch page (2020237999, akairo, 2020, never updated) nor on Pomeranian Continued (3682979759, Bernau31); author offline, no stated position"
upstream_mod_remotes: N/A      # akairo's original (Workshop 2020237999) has no linked git repository
dependencies: declared
showcase:     missing
tested_on:    never
workshop:     none
published:    no
remaining:
  - defect: installed Pomeranian Continued still includes the broad upstream recipe patch
  - unverified: in the real game, order of akairo.Pomeranian (loadAfter ADS2, modDependencies of this mod) against this patch and ADS2 (the game reads `forceLoadBefore`; plain `loadBefore` and `modDependencies` ordering not read from code)
  - unverified: current upstream permission and source-page review beyond installed files
  - unverified: full patch integration, including optional XML Extensions branch
  - unverified: Pickle suite (Tests/Pickle, 2 passes, 4 scenario blocks) written and checked offline 2026-10-27, never run; real-game ticket belongs to playTests
  - unverified: never seen running; final EN/FR, logs, new-game and existing-save scenarios pending
  - "2026-10-27 note: stage reset from writeTests[1.0.0] to setupRepo by Virginie's request after a full re-audit; stages 2 to 6 not found unmet, to be replayed in order"
updated:      2026-10-27
protocols_read_sha: 43dd90d4b7873c500347fba1be01275a48d5795b
---

# Pomeranian - A Dog Said Patch Renew (unofficial), status

## Workflow audit, 2026-10-15

Stage now `declareDependencies[1.0.0]` (3.a to 3.d met: no `feature` entry for this version, no build for an XML-only mod, `[Unreleased]` in `CHANGELOG.md` up to date).

Dependency audit (4.a to 4.g), 2026-10-15, read from the installed Workshop copies:
- 4.a Used: `aka_Pomeranian` (Pomeranian Continued, `akairo.Pomeranian`, 3682979759, supports 1.0 to 1.6) and `ADS_Cat1` to `ADS_Cat3` (A Dog Said... Animal Prosthetics 2, `SamBucher.ADogSaidAnimalProsthetics2`, 3238353862, supports 1.4 to 1.6). Both declared with the right id and Workshop id.
- 4.b Pomeranian Continued is technically required (without it the patch writes an unknown def into `recipeUsers`). ADS2 is not technically required (the operation is guarded and does nothing without it); kept as `modDependencies` because the mod has no purpose without it. Owner's call. `loadBefore` ADS2 is required (its last patch copies the categories); `incompatibleWith` the original patch is consistent. No `MayRequire` on an operation.
- 4.c No DLC, no `LoadFolders.xml` in this mod. `supportedVersions` 1.6, supported by both dependencies.
- 4.d DEFECT: cycle, see `remaining`. `sort-load-order.py` run on the three `About.xml` (also with ADS2 removed from `modDependencies`, and with `forceLoadBefore`): same cycle, same result, the patch ends after ADS2. Cause: `akairo.Pomeranian` is a `modDependencies` entry (sorted first) while Pomeranian declares `loadAfter` ADS2. Fix options need the owner's decision (About.xml dependency declarations change, 8.m reopens the review).
- 4.e The patch is guarded by `PatchOperationConditional` on `ADS_Cat1`, silent without ADS2.
- 4.f Not applicable: this mod adds no animal; it is itself the ADS2 integration of another mod's animal.
- 4.d decision (Virginie, 2026-10-15): option 2, the mod keeps its declarations and the sorter is the one to adjust; the case was sent to the Audit workflow session through the Ticket Manager. ADS2 stays a hard dependency. Pending the answer on `sort-load-order.py`.
- 1.a Duplicate search done, 2026-10-15 (`Search-Workshop.sh -p aka_Pomeranian -i '*.xml'` over the installed Workshop and local mods, 61 hits): no other mod enrols `aka_Pomeranian` in `ADS_Cat1` to `ADS_Cat3`. Hits: original patch 2020237999 (dead, 8), Pomeranian Continued 3682979759 (43, its embedded `Patch-ADogSaid` is the known upstream defect), Dogs mate 2441132298 (9, adds the animal to a mating group, unrelated), this mod (1).
- 1.b Steam page facts, read by the Audit Workflow session on 2026-10-15 and relayed here (not read by this session): original patch 2020237999, "Pomeranian - A Dog Said Patch", by akairo (also author of the Pomeranian mod), tags 1.0 and 1.1, published 12 March 2020, never updated, creator offline, requires the old A Dog Said... Animal Prosthetics and Pomeranian, description "This patch is built-in since 1.2", no licence, no reuse permission; akairo's comment of 13 March 2020 says a built-in patch would give a red error without ADS and asks for an XML-only solution, Tyrant answers that the mod only has to test for A Dog Said in the load order. Pomeranian Continued 3682979759, port by Bernau31 (offline), tags 1.0 to 1.6, published 11 March 2026, 154 subscribers, "I do not own or claim the content of this mod", all content akairo's except the German translation, notes "Fixed the 'A dog said...' patch", no package ID changed, no licence, no reuse statement, no position from akairo. Original Pomeranian mod 1.0-1.4: 2020233722. Consistent with `licence: silent`.
- 4.d update (2026-10-15, NPT answer): NPT read the sorter (not run): the cycle rule drops the soft edge pointing at the latest mod by input order, which is our `loadBefore`; `force*` is read as plain soft today. NPT plans to keep the force flag and to prefer dropping an upstream `loadAfter` over the owner's `loadBefore`, once the running Pickle ticket is done (NPT edits after `RUN_DONE`, needs Virginie's commit order). Asked of this mod and done (Virginie, 2026-10-15): `loadBefore` becomes `forceLoadBefore` on `SamBucher.ADogSaidAnimalProsthetics2` in `About.xml`. Expected order once NPT's fix lands: Pomeranian, patch, ADS2. Checked in the installed game, 2026-10-15: `Assembly-CSharp.dll` contains the names `forceLoadBefore`, `forceLoadAfter`, `ForceLoadBefore`, `ForceLoadAfter` (so `ModMetaData` reads them), and Core's own `About.xml` uses `<forceLoadBefore>` for its DLCs; the English UI strings `ModReorderConflict_MustLoadBefore` ("Cannot move {0}: It must be loaded before {1}.") and `ModMustLoadBefore` ("This must be loaded before: {0}.") exist, which points at a hard constraint in the mod list (inferred from the strings, not from decompiled code). Not verified: the exact meaning of the plain `loadBefore` in the game, whether `modDependencies` orders mods in the game, and the sorter result after NPT's change. `code_review_sha` is not set yet, so the `About.xml` change reopens nothing (AUDIT.md 8.m applies later).
- 4.d resolved (2026-10-15): NPT committed `7bafac7` in the protocols repository (`sort-load-order.py`: a forced edge is dropped last; a forced `loadBefore` wins over the same mod's `modDependencies` edge, logged). Rerun by this session on the real three `About.xml` (this mod's, 3682979759, 3238353862), `--rules none --version 1.6`, three different input orders: same order each time, `akairo.pomeranian`, `nelim.pomeranian.adogsaidpatch`, `sambucher.adogsaidanimalprosthetics2`, exit 0, no remaining cycle on our edges. Logged drops: the `modDependencies` edge ADS2 before this patch (we force the opposite) and the soft upstream `loadAfter` of Pomeranian on ADS2. Remaining unknown, in `remaining`: the real game's behaviour.
- 4.h Passed 2026-10-15: 4.a to 4.g done, 4.d resolved (see above); stage moves to `settings[1.0.0]`.

Full pass from `setupRepo`. Moved to `workflow_stage: code[1.0.0]` once 2.a to 2.g were met (target version 1.0.0: nothing was ever released, no tag, no Workshop item; the former `[1.0.0]` changelog entry was merged into `[Unreleased]`). Checkout `C:\Users\nelim\Documents\rimworld\PomeranianADogSaid2Renew`, distributed folder `Mod/`, junction `Mods\PomeranianADogSaid2Renew` to `Mod/` verified, no old junction left. Before this commit local `main` = `origin/main` = `ee77436`; remote repository `PUBLIC`.

Fixed this pass: `.gitignore` gains `build/`, `Art/.render/`, `*.dds`; `PROMPT_POMERANIANADOGSAIDPATCHRENEW.md` deleted (illustration received, 2.f). The stale lines of the 2026-10-14 section below are superseded: first push done, no `Preview.png` in `Mod/About/` now, gitlink backup gone. The empty folder `..\PomeranianADogSaid2PatchRenew` could not be removed (in use by another process); delete it once released.

Delivered art: `Art/ModIcon-source.png` (1254 x 1254) and `Art/Preview-source.png` (1672 x 941, redelivered 2026-10-15 21:45 after a corrected prompt), both owner's, untouched. `Mod/About/ModIcon.png` (128 x 128, 28.7 KB) and `Art/ModIcon.ico` regenerated after the source. `Art/Preview.ico` is stale (derived from the deleted upstream Preview) and is rebuilt at `mountPreview`.

Preview-source checks (2.e), directly inspected on the redelivered image: 1 hue family (`Measure-Palette.sh`), mean value 0.60, one readable face (the dog; the colonist is seen from behind), subject readable at 268 px, no halo, no lamp, table seen as a flat top without legs, no vignette, left two thirds calm for the title. The earlier 1254 x 1254 version (halo, textured fur, table legs) was replaced.

Folder name decision (Virginie, 2026-10-15): `PomeranianADogSaid2Renew`. Display name and repository keep `A Dog Said Patch Renew` (literal equality not required, PUBLISHING.md, Nommage).

Protocols re-read: `AGENTS.md`, `AUDIT.md`, `CICD.md`, `GALLERY.md` (gallery subtitles), `scripts.md`; none changes this mod's current state.

## Test status (writeTests), 2026-10-27 (7.f: revision tested = `c40e9e9`; Mod/ unchanged since `a129013` except About description and docs; Test-Xml 9/9 replayed on it)

7.a `TEST_SCENARIOS.md`: six scenarios, one per behaviour promised by the About description. 7.b/7.c `Tests/Test-Xml.ps1`: 9 tests, 9 passed, 0 failed, 0 skipped, replayed on `75a2231` (the revision tested). Each test was also run against a mutated copy of the mod (broken predicate, guard on a wrong node, MayRequire on the operation, wrong animal, `forceLoadBefore` back to `loadBefore`, ADS2 dependency dropped, version number in the description, `(unofficial)` dropped) and failed as intended; a first version of the version-number test let `1.6.` pass and was fixed. The shared `Check-ModBasics.ps1` is called first: its one finding, the missing `Preview.png`, is tolerated until `mountPreview`. 7.d open: no `Tests/Pickle/` yet, the game-only checks are listed in `TEST_SCENARIOS.md`. 7.g: the three translation fields are `not_applicable`, justified below. The local script `Tests/Test-Xml.ps1` was declared to the Audit Workflow session for `scripts/LOCAL_SCRIPTS.md` (no answer yet).

## Settings audit

Confirmed 2026-10-15 at `settings[1.0.0]` against the sources: `Mod/` holds only `About.xml`, `ModIcon.png`, `ADSPatch.xml`, `ATTRIBUTION.md`, `LICENSE`; no hit for `MainButtonDef`, `ModSettings`, `Keyed`, `DefInjected`, `label` or `description` outside `About.xml`. `settings_audit: not_applicable` stands (analysis and automated checks done; no in-game check, the mod never ran).

Prepared 2026-10-15, to be confirmed at `settings` (`MOD_SETTINGS.md` read in full). Files read: `Mod/` holds `About/About.xml`, `About/ModIcon.png`, `Patches/ADSPatch.xml`, `ATTRIBUTION.md`, `LICENSE`. One `PatchOperationConditional` adds `aka_Pomeranian` to the three ADS2 category recipes: a fixed compatibility enrolment, no player choice, nothing to configure. No settings class, assembly, settings Def, `MainButtonDef` or shortcut exists, so there is neither an empty page nor a shortcut. Applies at mod load. Result: `not_applicable`. No in-game check made (never run).

## Translation audit

Prepared 2026-10-15, to be confirmed at `localize` (`TRANSLATIONS.md` read in full). Inventory: the only payload is the internal defName `aka_Pomeranian` inside `recipeUsers`; no label, description, message, key, grammar rule or injected text, no `Languages` folder, no C#, no extra `LoadFolders`. `About.xml` text is metadata outside the gate. Result: `localization`, `translation_en`, `translation_fr` = `not_applicable`. `FRENCH_REVIEW.md` generated by `Make-FrenchReview.ps1` (states that the mod adds no player-facing strings); no French review by Virginie needed, no text to review.

## Workflow audit, 2026-10-14

Update, same day: repository reattached (`git init` + `reset origin/main`, old gitlink kept as `../.git-gitlink-PomeranianADogSaid2.bak`), original Preview.png removed (198b081), six `(2)` duplicates deleted (stale pre-2026-09-13 copies), `Mod/ATTRIBUTION.md` and `Mod/LICENSE` resynced, `About.xml` given `(unofficial)`, the `UNOFFICIAL` paragraph and the final `Source code on GitHub` line, `upstream_mod_remotes: N/A` added. The defects listed below under 1.d to 1.h are fixed by this update.

Previous status: `stage: dansMonoRepo`, no `workflow_stage` (audit of 2026-09-13).
Retained: `workflow_stage: setupRepo`. The first transition (setupRepo -> makeSources) fails on 1.f.

Checkout: `C:\Users\nelim\Documents\rimworld\PomeranianADogSaid2PatchRenew`, distributed folder `Mod/`.
Revision: no local revision readable (broken gitlink). Remote `main` = `8fdf01517bad114d6a188119866ea85bef14da3c` (`git ls-remote`, 2026-10-14).
Local modifications: not measurable without a repository. Only `STATUS.md` was edited. No game launch, build, image generation, commit or publication.
Protocols read this session: `AUDIT.md`, `PUBLISHING.md`, `STYLE_RIMWORLD.md`, `MOD_SETTINGS.md`, `TRANSLATIONS.md`, `AGENTS.md`; `Mark-ProtocolsRead.ps1` run (protocols HEAD 583ce12).

| Step | Result |
| --- | --- |
| 1.a Duplicate | `Search-Workshop.sh` not run: unverified. |
| 1.b Source, licence, visibility | `silent`, `public`, upstream 2020237999. Carried from 2026-09-13, not refreshed. |
| 1.c Names | packageId, repo and folder consistent. |
| 1.d Status mentions | Defect: `About.xml` name is `Pomeranian - A Dog Said Patch 1.6`, no ` (unofficial)`, description has no `UNOFFICIAL` paragraph. |
| 1.e GitHub repository | Exists, `main` present. Visibility not checked. |
| 1.f Local repository | Defect: `.git` gitlink targets a missing path; `git status` fails here. |
| 1.g Initial docs | Present. Defects: six `(2)` duplicates; `Mod/ATTRIBUTION.md` and `Mod/LICENSE` differ from root. |
| 1.h `STATUS.md` | `workflow_stage` added, `stage` and `session` removed. `upstream_mod_remotes` missing. |
| 1.i, 1.k | Not established. |
| 1.j `Check-Status.ps1` | Before edit: 1 ERROR (`workflow_stage missing`), 2 WARN. Rerun below. |

Independent checks kept: `ADSPatch.xml` reread, one guarded operation on `ADS_Cat1..3`, all predicate branches use `@Name=`, no `MayRequire` on an operation, consistent with `About.xml` dependencies and `loadBefore`. `ModIcon-source.png`, `ModIcon.ico`, `Mod/About/ModIcon.png` (26.3 KB) and `Mod/About/Preview.png` (10.9 KB) are present; Preview not inspected visually. Localization and settings fields stay `not_applicable` (no assembly, no Keyed text, no settings), not re-justified against current protocols.

Unverified, not defects: in-game behaviour, EN/FR, logs, tests (`writeTests` not reached), current Steam page and permission, optional XML Extensions branch.

Next transition: (1) attach a real repository by cloning the remote and keeping the working files (needs Virginie's go); (2) resolve the `(2)` duplicates and the `Mod/` vs root copies; (3) apply 1.d to `About.xml` and the README title; (4) add `upstream_mod_remotes`, get `Check-Status.ps1` without ERROR, run `Mark-ProtocolsRead.ps1`, commit and push.

## Workflow audit, 2026-09-13 (replaced on 2026-10-14)

This section supersedes the historical sweep below without erasing its record.
Previous stage was empty (not a validated preview stage); retained stage is
`dansMonoRepo`, literally the first state of the requested nine-transition workflow.
No legacy code mapping is used. Later independent checks do not promote the cumulative stage.

Audited checkout: `C:\Users\nelim\Documents\rimworld\PomeranianADogSaidPatch`.
Distributed folder: its `Mod/` directory. `git rev-parse --show-toplevel` returns
`C:/Users/nelim/Documents/rimworld`; no standalone `.git` exists here, and no matching
checkout was found in `C:\Users\nelim\Documents\RimWorldMods`.
Monorepo HEAD: `75c3000e1833d325cc7626a402981e4aa881d47a`.
At audit start, STATUS.md already had local additions of three unchecked translation fields.
During the audit, `Mod/About/Preview.png` was deleted outside this audit's actions;
the deletion was rechecked and preserved. At final verification, an untracked external
`output/imagegen/pomeranian-a-dog-said-patch-v1.png` (1,266,414 bytes) also appeared.
It is outside Mod/About, was not visually audited and does not validate the delivered Preview.
Only STATUS.md was edited by this audit.
No game launch, build, image generation, development, commit or publication was performed.

Protocols read: parent `PUBLISHING.md`, `STYLE_RIMWORLD.md`, `MOD_SETTINGS.md`,
`TRANSLATIONS.md`, and `AGENTS.md`. The supplied prompt overrides the older requirement
for runtime settings tests before options when settings are not applicable.

| Transition | Result and evidence |
| --- | --- |
| dansMonoRepo -> horsMonoRepo | Blocked: checkout is not autonomous. GitHub existence and a pushed HEAD were verified by `git ls-remote https://github.com/vbardales/Rimworld-Pomeranian-A-Dog-Said-Patch-Renew.git HEAD`: `8fdf01517bad114d6a188119866ea85bef14da3c`. Initial sandbox network failure was followed by a successful read-only retry. Visibility and content equivalence were not checked. Absence of a monorepo remote is not a defect. |
| horsMonoRepo -> ModIcon generated | ModIcon absent. Build is not applicable: only one XML patch, no source project or assembly. Full development completion cannot be certified from the limited checks below. |
| ModIcon generated -> Preview generated | Preview absent at completion. Earlier direct inspection is retained below, not counted as a current delivered artifact. |
| Preview generated -> preOptions | English description exists, but the final formatted GitHub link is absent (a raw URL occurs earlier). Public `silent` title lacks `(unofficial)` and the prescribed opening notice in About/README; STATUS title mirrors the actual unchanged metadata. No current preview composition can pass. |
| preOptions -> options | Independently passed as justified not_applicable; see Settings audit. |
| options -> l10n | Independently passed as justified not_applicable; see Translation audit. |
| l10n -> preTest | Both mandatory dependency IDs and 1.6 support verified against installed About files, animal and category targets verified. Patch loadBefore ADS2 is consistent with category copying; no contradictory loadAfter Pomeranian is added. Installed dependency defect and optional branch remain separately recorded below. |
| preTest -> done | Not established: limited XML/XPath audit checks passed, but no stored executable test suite or structured functional scenarios exist. Full merged patch behavior is not tested. C# compilation tests are not applicable. |
| done -> tested | Non-verified: no in-game execution, logs or FR/EN interface review, new game or existing save validation. About's historical claim of human in-game testing is not evidence of a passing run for these files. |

### Packaging and rights evidence

README, ATTRIBUTION, LICENSE and CHANGELOG are present in English. Root and Mod copies
of LICENSE and ATTRIBUTION have equal SHA-256 hashes. MIT is explicitly limited to the
rewrite and excludes akairo's original and dependency content; no new third-party licence
is inferred. The existing `public` / `silent` decision is preserved, not freshly certified:
installed original item 2020237999 declares only 1.0/1.1, consistent with the workflow's
abandonment criterion. Current Steam description/comments and permissions were not refreshed.
Attribution and removal commitments exist. Folder, repository and packageId identify the
same patch; literal equality is not required. About has a `name`, not a packageName field.

### Settings audit

Inventory: one PatchOperationConditional wrapping PatchOperationAdd, adding only
`aka_Pomeranian` to existing ADS category recipeUsers. No configurable policy or numeric
player input is introduced; this is a fixed compatibility enrollment. Enabling the mod
controls its presence. ADS2's own settings remain owned by that dependency.
Full file inventory and XML inspection found no settings class, assembly, settings Def,
empty page, MainButtonDef or shortcut. Thus settings_audit is not_applicable.
Defaults, input boundaries, persistence, shared routes and RIMMSQOL integration tests are
not applicable to this mod; no integration is claimed as tested. Effects apply on mod loading.

### Translation audit

The only payload is an internal defName reference in recipeUsers. No owned label,
description, message, generated sentence, key, parameter or injected text is added or changed.
No additional load folders, C# or language resources exist. Existing surgery and animal
texts remain dependency-owned. About and documentation are metadata outside this gate.
Consequently localization and EN/FR coverage are not_applicable; DefInjected path and
parameter checks have zero applicable entries. This is not an in-game translation pass.

### Executed technical checks

PowerShell/System.Xml parsed both distributed XML files successfully.
Loaded installed ADS2 `1.6/Defs/AnimalCategories/Animal_Categories.xml`, appended a control
RecipeDef with Human recipeUsers, selected the exact delivered patch XPath, and asserted
three matching category lists. Imported `match/value/li` into each and asserted exactly
three aka_Pomeranian entries and unchanged control: PASS. Against a document with only the
control recipe, the guard selected nothing: PASS. These are XML behavior checks, not an
execution of Verse.PatchOperation or its absent-branch return/log behavior.
The first test harness attempt failed because PowerShell unwrapped `.li` to a string;
rerun using `SelectSingleNode('match/value/li')` passed. No mod change was needed.

Installed dependencies were read under
`C:\Program Files (x86)\Steam\steamapps\workshop\content\294100`:
3682979759 (Pomeranian Continued) and 3238353862 (ADS2, modVersion 1.3.7).
Their About files, LoadFolders, animal Def, category Def and ADS2 final category-copy patch
confirm the referenced identifiers and normal copy order. XML Extensions is an optional
ADS2 branch, not an extra mandatory dependency of this XML-only patch; its full behavior
was not exercised. No universal integration pass is claimed.

The upstream defect is currently reproduced at XML level: Pomeranian Continued's first
Patch-ADogSaid XPath selected 4/4 recipes, including the unrelated control. Its 1.6
LoadFolders activates this patch with ADS2, and its About declares loadAfter ADS2.
This establishes the overbroad selection in the installed dependency, not an observed
in-game operations-tab result. The documentation's historical warning is retained.

Audited SHA-256 fingerprints (unchanged runtime XML):

- Mod/About/About.xml: `542CA9CF11E76570E05BEF8D0CAB04914214FA64F93938A28060E23E16206FCE`
- Mod/Patches/ADSPatch.xml: `F480EB80A18FA0CD4B3FE7AE849ED8B46818D2FB59BC18C836BF01AE1DEB3FCB`

### Historical visual inspection during this audit

Before its external deletion, Preview was a valid PNG, 640 x 360, 11,156 bytes,
SHA-256 `5B3ED9728BAF5CBCDE6E3124047FF46ED6B14AD58C766075194D3BBD68B9CDE7`.
Directly viewed: yellow background, large pixel-art dog portrait, small dogs and orange/brown
title. It was under 1 MB but not the prescribed 896 x 504, and was an upstream portrait
composition rather than the prescribed high-oblique scene; no current version badge or
workflow overlay was present. No missing historical generation report or unrecorded camera
comparison was used as a blocker. These findings concern the now-removed file only.

### Next transition and optional notes

To reach horsMonoRepo: establish the autonomous checkout outside the monorepo with its
GitHub remote, verify its existing pushed content and visibility, and resolve the mandatory
rights/naming documentation checks above. Creating another GitHub repository is not required:
the declared repository already responds. Later image and testing work does not belong to
this immediate transition. This audit does not authorize carrying out those development steps.
No additional optional recommendation is needed for the immediate gate.

## Historical sweep, 2026-09-12

Read by a sweep across every mod, rather than by asking each thread in turn. It lives at the
root, never inside `Mod/`, so Steam never receives it.

The fields above were read off the disk on 2026-09-12. Four cannot be, and wait for whoever
holds this mod:

- **`stage`**, one of `port`, `showcase`, `preTest`, `done`, `tested`, `published`. Filled in
  from the session group where one exists; confirm it.
- **`tested_on`**, the date of the last run in game. Empty means never.
- **`dependencies`**, `declared` when every mod this one needs is named in the About's
  `modDependencies`, `to check` when a non-vanilla `loadAfter` suggests a dependency that is not
  declared, `none` when the mod needs nothing. An undeclared dependency is not cosmetic: on
  2026-09-11 Reequilibrage animaux took 47 vanilla animals down with it, Muffalo included, because
  the class it injects belongs to a mod that was not declared and not loaded.
- **`remaining`**, what is left, in three kinds: `feature` for something missing from a first
  release, `defect` for a known fault left unfixed, `unverified` for what could not be checked.
  The line already there is true of nearly the whole repository; replace it once it stops being.

`licence` vocabulary: `open` an explicit licence, `silent` no licence and a dead source,
`alive` no licence but a living source, `forbidden` a written refusal, `original` owing nothing
to anyone, not a name, not an idea traceable to one mod, not a value derived from its assets.
