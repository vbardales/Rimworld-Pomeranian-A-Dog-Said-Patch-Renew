# Pomeranian - A Dog Said Patch Renew (unofficial): publication

Draft. Only the gallery plan and the subtitle lines exist so far; the Steam description and the checklist come at `writeDocs`. Nothing below has been played or captured yet.

## Gallery plan (draft, 2026-10-16)

Story: one day at the Sanctuary infirmary. Nelim, the only colonist, is the surgeon. A small pomeranian arrives with a hind leg short, gets a peg leg, then later a bionic leg, and trots out beside her. One place for the whole series (`infirmary-animals`, with one outdoor frame at its door), time advancing through the day.

Mods to mount (all in the scenario `-DepMap`): Pomeranian Continued (`akairo.Pomeranian`), A Dog Said... Animal Prosthetics 2 (`SamBucher.ADogSaidAnimalProsthetics2`, the integration this mod is about), plus the Sanctuary's own set (ScreenshotStudio, Facial Animation, EyeGenes3).

| # | Place and time | Subject and composition | Living things | What it says |
|---|---|---|---|---|
| 0 | none | The Preview, byte copy of `About/Preview.png` | none | Header image, no subtitle. |
| 1 | `infirmary-animals`, 08:00 | Wide, off-centre: the pomeranian lies on a bedroll, hind leg missing, Nelim standing by the door, afternoon-warm palette kept low | Nelim, one pomeranian | The patient arrives. |
| 2 | `infirmary-animals`, 09:00 | Health tab of the pomeranian open on its operations list (ADS2 surgeries): interface capture, no subtitle | the pomeranian | The surgeries this patch adds. |
| 3 | `infirmary-animals`, 12:00 | Medium: the pomeranian standing, facing the camera, wooden peg leg visible, Nelim beside it | Nelim, one pomeranian | A first step on a peg leg. |
| 4 | outdoor frame at the infirmary door, 17:00 | Wide, low sun: the pomeranian walking with Nelim, steel bionic leg visible, no limp | Nelim, one pomeranian | Later, a bionic leg. |

Open choices, not yet worked (to settle against the empty-place photographs of `infirmary-animals`, `GALLERY-PROPS.md` and the other places before any scenario is written):
- Nelim's outfit: contrast with the orange-gold coat, a deep teal or blue tunic over the fixture's trousers. Hairstyle: not chosen, no hair mod picked yet; decide after the empty-place photo.
- Nelim's expression: the fixture default (`Nelim has her own face`, smirk smile, blink) for 3 and 4; a more serious face for 1 is unproven without Moving Vanilla Eyes (only `LidGeek`, `LidNormal`, `LidSharp`, `MouthNormal` resolve), so it may stay the default.
- Animals face the camera in at least one capture (frame 3).
- The pomeranian must be spawned with the animal step (`aka_Pomeranian`), its missing leg and its two prostheses applied as hediffs; whether a step already does that is unchecked (inventory of Pickle Tools, then Pickle, then `Elsewhere/`).

## Gallery subtitles

Planned lines, one per scene without an interface window. Files do not exist yet: names are provisional and the lines are replayed with `scripts/Add-Subtitle.ps1` on the clean originals in `Art/Gallery-clean/` once the captures are accepted and the indexes are final.

| index | file | line |
|---|---|---|
| 1 | 1-arrival.png | A small patient arrives at the infirmary, one hind leg short. |
| 3 | 3-peg-leg.png | A peg leg, and the first step back on its feet. |
| 4 | 4-bionic.png | Weeks later, a bionic leg and no limp. |

Index 0 (the Preview) and index 2 (interface capture) carry no subtitle.
