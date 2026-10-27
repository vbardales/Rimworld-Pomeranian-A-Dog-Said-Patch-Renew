# Pomeranian - A Dog Said Patch Renew: Pickle suite

Development only. Nothing under `Tests/` is part of the Workshop payload. The suite is written for the shared WSL runner. **It has never been run.** Nothing here claims an in-game result.

## Scope

The offline suite `Tests/Test-Xml.ps1` owns everything provable without a game: the About declarations, the patch structure and predicate, the guard on an absent A Dog Said 2, the three entries written, the animal's defs.

Pickle is limited to what needs a running game: the operations the animal is actually offered once A Dog Said 2 has copied its categories onto the surgery bases, the load order the game kept, and a clean log.

## Passes

| Pass | Map | Feature | Language | What it establishes |
| --- | --- | --- | --- | --- |
| 1. A Dog Said 2, declared order | `wsl-deps.avec-ads2.map` | `01-ads2` | English | Pomeranian Continued, this patch, A Dog Said 2: the load order is the declared one, the pomeranian is offered `InstallPegLegAnimal` and `InstallBionicLegAnimal`, the colony loads with no error and no warning from this mod (S1, S4) |
| 2. No A Dog Said 2 | `wsl-deps.sans-ads2.map` | `02-sans-ads2` | English | The guard finds nothing: the surgeries are not offered, the log stays clean (S3) |

The mod has no player-facing text, so no French pass is written (`STATUS.md`, Translation audit).

From the collection root, once `scripts/Pickle-Status.ps1` says the machine is free, file a ticket (`Submit-PickleRun.ps1`, see `docs/PICKLE.md`); a session never launches the game:

```powershell
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod PomeranianADogSaid2Renew -DepMap wsl-deps.avec-ads2.map -Filter '01-ads2' -Language English
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod PomeranianADogSaid2Renew -DepMap wsl-deps.sans-ads2.map -Filter '02-sans-ads2' -Language English
```

## Tags

`@requires:<packageId>` skips the scenario when that package is absent. It does not stage it: the pass map does. A skipped scenario is not a validated one.

## Local steps

`Source/RecipeSteps.cs`: two steps, `Pomeranian Patch Renew the race "X" offers the recipe "Y"` and `... does not offer ...`. They read `ThingDef.AllRecipes` of the live game. No Pickle Tools step offers a recipe check (`Check-Steps.ps1`, 2026-10-27). Declared to NPT for promotion once a second mod needs it.

## Offline validation

```powershell
dotnet build Tests/Pickle/Source/PomeranianADogSaid2Renew.PickleSteps.csproj -c Release
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/Check-Steps.ps1 -ModRoot PomeranianADogSaid2Renew
```

2026-10-27: build 0 warning, 0 error; `Check-Steps.ps1`: 2 feature files parse, 2 patterns compile, 17 step lines each resolve to exactly one expression. It cannot prove a step does what its sentence says, nor that Pickle's runtime accepts it.
