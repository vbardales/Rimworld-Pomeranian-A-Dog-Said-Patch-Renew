# Pomeranian - A Dog Said Patch Renew (unofficial): publication

Draft. Only the gallery plan and the subtitle lines exist so far; the Steam description and the checklist come at `writeDocs`. Nothing below has been played or captured yet.

## Gallery plan (draft, 2026-10-16)

Story: one day at the Sanctuary infirmary. Nelim, the only colonist, is the surgeon. A small pomeranian arrives with a hind leg short, gets a peg leg, then later a bionic leg, and walks out of the animals' room into the pawns' room beside her. Two rooms of one building (`infirmary-animals`, then `infirmary-pawns`), time advancing through the day. No outdoor frame: around the building are dense bamboo and orange smiley carpets, where an orange pomeranian disappears.

Mods to mount (all in the scenario `-DepMap`): Pomeranian Continued (`akairo.Pomeranian`), A Dog Said... Animal Prosthetics 2 (`SamBucher.ADogSaidAnimalProsthetics2`, the integration this mod is about), plus the Sanctuary's own set (ScreenshotStudio, Facial Animation, EyeGenes3).

| # | Place and time | Subject and composition | Living things | What it says |
|---|---|---|---|---|
| 0 | none | The Preview, byte copy of `About/Preview.png` | none | Header image, no subtitle. |
| 1 | `infirmary-animals`, 08:00 | Wide, off-centre, the green pawns' room showing through the west door: the pomeranian lies on a bedroll of the left column, hind leg missing, Nelim standing near it in a dark outfit (the room is beige and dim, torches at the corners, so the orange coat and a dark figure carry the frame) | Nelim, one pomeranian | The patient arrives. |
| 2 | `infirmary-animals`, 09:00 | Health tab of the pomeranian open on its operations list (ADS2 surgeries): interface capture, no subtitle | the pomeranian | The surgeries this patch adds. |
| 3 | `infirmary-animals`, 12:00 | Medium: the pomeranian standing, facing the camera, wooden peg leg visible, Nelim beside it | Nelim, one pomeranian | A first step on a peg leg. |
| 4 | `infirmary-pawns` (green room, `(202, 52)`, zoom 6), 17:00 | Wide, torch-lit: the pomeranian walking between the hospital beds with Nelim, steel bionic leg visible, no limp; the green floor makes the orange coat stand out | Nelim, one pomeranian | Later, a bionic leg. |

Open choices, not yet worked (to settle against the empty-place photographs of `infirmary-animals`, `GALLERY-PROPS.md` and the other places before any scenario is written):
- Nelim's look (director's decision, 2026-10-16, GALLERY.md: the session decides everything): deep blue tunic over the fixture's trousers, so she contrasts with the beige room and the orange coat; dark hair tied up, short enough to keep her face and the dog readable. The exact vanilla hairstyle def is picked when the scenario is written, from the game's own list, and checked on the first capture. Her hair colour is set dark so it does not compete with the dog.
- Nelim's expression: the fixture default (`Nelim has her own face`, smirk smile, blink) for 3 and 4; a more serious face for 1 is unproven without Moving Vanilla Eyes (only `LidGeek`, `LidNormal`, `LidSharp`, `MouthNormal` resolve), so it may stay the default.
- Animals face the camera in at least one capture (frame 3).
- The pomeranian is spawned with the animal step (`an adult animal of kind "aka_Pomeranian" named ... is spawned at (x, z)`). Checked in `PickleTools/docs/steps.md` (2026-10-16): no step adds a missing part, a peg leg or a bionic leg to an animal. The debug menu has `Add Hediff` (`DebugTools_Health.AddHediff`), an action that needs a pawn, so its code has to be copied into a step of this mod's suite, then reported to NPT for `Elsewhere/`. Asked of NPT.
- Place, checked on the empty-place photographs (`SanctuaryBacklot/evidence/sanctuary-full-1/screenshots/manual--infirmary-animals--step0.png` and `...--infirmary-all--step0.png`, 2026-10-10, local evidence): `infirmary-animals` is a large beige room with ten bedrolls in two rows, torches at the corners, lit 50 percent, a doorway to the green pawns' room on the west. Good: empty floor for an off-centre patient. To handle: the photographs are older than the 2026-10-14 gallery rules and show the interface (no presentation mode), the interior is dim, and the room is beige, so Nelim is dressed dark and the dog is kept near a bedroll, not in the open floor.
- For the tests (`writeTests`, not for the gallery): Pickle Tools has `the recipe "<recipe>" is offered for the race "aka_Pomeranian"` and `... can be applied on a "<part>" of a "<kind>"`, which prove what this patch does without a game screenshot.

## Gallery subtitles

Planned lines, one per scene without an interface window. Files do not exist yet: names are provisional and the lines are replayed with `scripts/Add-Subtitle.ps1` on the clean originals in `Art/Gallery-clean/` once the captures are accepted and the indexes are final.

| index | file | line |
|---|---|---|
| 1 | 1-arrival.png | A small patient arrives at the infirmary, one hind leg short. |
| 3 | 3-peg-leg.png | A peg leg, and the first step back on its feet. |
| 4 | 4-bionic.png | Weeks later, a bionic leg and no limp. |

Index 0 (the Preview) and index 2 (interface capture) carry no subtitle.
