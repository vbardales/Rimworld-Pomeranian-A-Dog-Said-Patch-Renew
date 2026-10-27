# Pomeranian - A Dog Said Patch Renew (unofficial)

UNOFFICIAL. This mod is published without the original author's explicit consent.
If the original author contacts me to request its removal, I undertake to take it down promptly.

Rewrite of **akairo's Pomeranian - A Dog Said Patch** for the latest RimWorld version.

**I am not the author of the original.** akairo wrote the Pomeranian mod and this patch for it -
all I did was rewrite the patch against the A Dog Said that exists today. Credit goes to akairo;
mistakes in the rewrite are mine.

Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=2020237999, declares 1.0 and
1.1 and nothing further. The page is still online; the mod is abandoned, not withdrawn.

## What the mod does

Lets a pomeranian have A Dog Said's animal surgeries: old wounds treated, peg legs, simple
prosthetics and organs, bionics and a power claw.

One file, one guarded operation (`PatchOperationConditional` around a `PatchOperationAdd`), no def of its own. No assembly, no DLC, no texture, no
translation.

### It needs both of these

| | |
|---|---|
| [Pomeranian Continued](https://steamcommunity.com/sharedfiles/filedetails/?id=3682979759) | `akairo.Pomeranian`, defines the dog. akairo's, maintained by Bernau31, declares 1.6 |
| [A Dog Said... Animal Prosthetics 2](https://steamcommunity.com/sharedfiles/filedetails/?id=3238353862) | `SamBucher.ADogSaidAnimalProsthetics2`, defines the surgeries |

Without A Dog Said 2 the guard finds nothing, the operation reports success, and the mod does
nothing at all, no error line, nothing logged.

### It must load before A Dog Said 2

`<forceLoadBefore>` declares this, so any sorter will place it, but the reason is worth knowing because
it is invisible from the outside. A Dog Said 2 does not attach animals to recipes directly: it
keeps three abstract recipes, `ADS_Cat1` to `ADS_Cat3`, and its own final patch copies their
`recipeUsers` onto the real surgery bases. A mod that adds an animal to those categories *after*
that copy has run is writing to a list nothing reads any more.

## Why it needed rewriting rather than porting

The original was four `PatchOperationAdd`s. Three of them were wrong in the same way, and all four
targeted names that no longer mean anything.

### The predicate matched every recipe in the game

```xml
<xpath>/Defs/RecipeDef[defName = "InstallPegLegAnimal" or "OldWoundsAnimalBase"]/recipeUsers</xpath>
```

In XPath, `or` converts each operand to a boolean, and a non-empty string literal is `true`. The
predicate is therefore `… or true`, true for **every** `RecipeDef` in the document. The operation
adds `<li>aka_Pomeranian</li>` to the `recipeUsers` of every recipe in the game and in every mod
loaded that declares one.

That is not a harmless no-op: `recipeUsers` is how a recipe reaches `ThingDef.AllRecipes`, and for
a pawn that is what the operations tab draws. A pomeranian ends up offered every recipe in the
game as an operation, cooking included.

Counted rather than argued, with `System.Xml.XmlDocument`, no game launch needed:

| document | `RecipeDef`s | broken predicate | correct predicate |
|---|---|---|---|
| Core `Recipes_Surgery_Misc.xml` | 4 | **4** | 0 |
| ADS 2 `Animal_Categories.xml` | 3 | **3** | 0 |

The correct form repeats the test on every branch, `[@Name="A" or @Name="B"]`, which is also what
A Dog Said 2's own compatibility patches use.

### The names it targeted are the old ones

| recipe named by the original | in A Dog Said 2 1.6 |
|---|---|
| `InstallPegLegAnimal` | present |
| `OldWoundsAnimalBase` | **absent** |
| `InstallBionicEyeAnimal` | present |
| `InstallPowerClawAnimal` | present |
| `InstallSimpleProstheticTailAnimal` | present |

Most survived, so this alone would not have been fatal, but the one that did not is old-wound
treatment, which the original's description advertises as the point of the patch. And naming
recipes one at a time stopped being how an animal is enrolled when A Dog Said 2 introduced its
categories.

## What it is now

```xml
<Operation Class="PatchOperationConditional">
  <xpath>/Defs/RecipeDef[@Name="ADS_Cat1"]</xpath>
  <match Class="PatchOperationAdd">
    <xpath>/Defs/RecipeDef[
      @Name="ADS_Cat3" or
      @Name="ADS_Cat2" or
      @Name="ADS_Cat1"
    ]/recipeUsers</xpath>
    <value>
      <li>aka_Pomeranian</li>
    </value>
  </match>
</Operation>
```

**All three categories**, because a pomeranian is a trainable pet. A Dog Said 2 states its rule in
the tooltip of its own settings: category 1 is rodents and tiny animals, category 2 is livestock
and animals that cannot be trained, category 3 is *pack animals and trainable pets*.
`aka_Pomeranian` declares `trainability Advanced`, `petness 1` and the `AnimalPet` trade tag. The
lists are cumulative, so a category-3 animal appears in all three, which is where vanilla's husky,
labrador and yorkshire terrier sit, and what A Dog Said 2's own Dinosauria patch does for
*Tyrannosaurus rex*.

**The guard tests for a def, because nothing native gates an operation on a `packageId`.**
`PatchOperationConditional` selects `ADS_Cat1`; if it is absent the operation reports success and
logs nothing. The obvious-looking alternative is a trap: **`MayRequire` on an `<Operation>` is read
by nothing.** `Verse.PatchOperation` has no such field, and `ModContentPack.LoadPatches`, which
builds the operations, never reads the attribute, so the operation would apply whether A Dog Said 2
is loaded or not. What makes the wrong form so convincing is that the attribute *is* honoured
everywhere else: on a def node, on a `<li>`, on any ordinary field element. A Dog Said 2 itself uses
it correctly, on the `<li>`s inside those category lists. Live 1.6 mods ship the useless form, and
nothing in the log says so. The remaining option, `PatchOperationFindMod`, compares the display name
shown in the mod list, which is a different string again.

## Known: Pomeranian Continued ships the broken patch too

Pomeranian Continued carries a copy of akairo's original inside itself, at
`Patch-ADogSaid/Patches/patches.xml`, byte for byte the same file, same SHA-256, and its
`LoadFolders.xml` loads that folder whenever A Dog Said 2 is active.

So the always-true predicate is live today for anyone running both mods. The pomeranian collects
every recipe in the game on its operations tab, and still gets no surgeries, because Pomeranian
Continued asks to load *after* A Dog Said 2 and its stray addition to the categories therefore
arrives too late.

**This mod does not and cannot fix that.** Cleaning up would have to happen after Pomeranian
Continued's patch and before A Dog Said 2's copy, and Pomeranian Continued's own `loadAfter` makes
that ordering impossible to satisfy. A cleanup that fires or not depending on how a user sorted
their list is worse than a stated bug, so there isn't one here.

The surgeries this mod adds work regardless. The stray recipes come from Pomeranian Continued, and
the repair belongs there: `ATTRIBUTION.md` says what it is.

## Compatibility

- **The original standalone patch** is declared in `<incompatibleWith>`. Run one or the other.
- **Save games**: this mod adds no def and creates no thing. Adding or removing it mid-save costs
  nothing beyond the surgeries it enables.

## Credit and removal

akairo declared no licence, no file, nothing in `About.xml`, no linked repository, nothing in the
body of the Steam description. Republished under the usual convention for abandoned mods: full
credit, a link to the original, removal on request without argument.

`ATTRIBUTION.md` records what was taken, what changed, and how each claim here was checked.
`LICENSE` covers the rewrite only.
