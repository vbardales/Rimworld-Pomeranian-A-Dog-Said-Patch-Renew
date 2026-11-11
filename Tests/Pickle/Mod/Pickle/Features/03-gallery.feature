# Pomeranian A Dog Said Patch gallery shotlist, 2026-11-11 (write-shotlist, director pass by an Opus sub-agent; scenarios written, drift check pending the first run).
#
# MOD: the patch gives the pomeranian (aka_Pomeranian, Pomeranian Continued) the animal surgeries of A Dog Said 2: peg leg, bionic leg, power claw. The mod adds no animal.
# No prosthetic is drawn on the animal sprite: the Health tab (Operations list, then the "peg leg" line) is the proof of the mod. Not proven in game yet.
#
# STORY: one clear day at the Sanctuary, 20 degrees. Nelim, daily look all day (LTS_Tunika rgb (31, 122, 92), Apparel_PAESmallEarrings, Roo_HD_Hair_Highpony,
# her own face, smile, no sweat), carries Biscuit, a pomeranian who lost a hind leg, to the animal vet room. Soren, the healer, medic look all day
# (LisaWork_ApparelScrubs rgb (70, 110, 150), LisaWork_ApparelLabCoat rgb (240, 240, 240), LisaWork_ApparelStethoscope), shows what A Dog Said 2 offers and
# operates. Biscuit then trots in the garden on a peg leg and walks the terrace at dusk. One `I set the hour to N` per image, 2,500 ticks per game hour.
#
# SHOTS (index, place, hour, type)
#   1. workshop-1-carried-in  infirmary-animals 8h (centre 213, 52) wide, opening, root size 3.5. AnimalBed at (213, 52), TorchLamp at (209, 50), (217, 50)
#                     and (213, 55) lit, PlantPot with Plant_Daylily at (209, 52) and (217, 52), Shelf near (216, 49). Biscuit (aka_Pomeranian, missing its rear left leg)
#                     lies on the bed at (213, 52); Nelim holds MedicineIndustrial and stops at (211, 52) facing east, smiling; Health tab open, "missing hind leg".
#                     Instant: she has just come in, she is about to kneel. Foreground Nelim, background torches and plants, soft morning light.
#   2. workshop-2-the-offer  infirmary-animals 9h (centre 213, 52) medium-tight, root size 2.8. Same decor. Soren stands at (214, 52) facing west, MouthSmile;
#                     Nelim at (211, 53) facing east; Health tab on the Operations list (install peg leg, bionic leg, power claw). Instant: he is about to start.
#   3. workshop-3-surgery  infirmary-animals 10h (centre 213, 52) tight, root size 2.5. Same decor, Stool near (211, 52). Soren operates on Biscuit (bill
#                     InstallPegLegAnimal, Anesthetic, game paused at 60 percent work left), MouthNormal written (focused), Nelim neutral mouth (watching).
#                     Instant: just after the first cut. Progress bar and "installing peg leg" in frame.
#   4. workshop-4-first-steps  flower-garden 15h (centre 155, 110) medium-tight, root size 2.8, from the front. Biscuit at (155, 110) facing south with
#                     PegLeg on its rear left leg, Nelim at (156, 110) facing south smiling, Shogun at (154, 112) facing west. Plant_Daylily at (153, 111), (157, 111),
#                     (153, 109) and (157, 109) fully grown, PlantPot_Bonsai near (152, 110), DR_StickLantern at (152, 112). Health tab open, "peg leg".
#                     Instant: Biscuit has just taken his first step on the peg leg. Long afternoon shadows.
#   5. workshop-5-dusk-walk  calm-zone 18h (centre 200, 187, free cream square; statue-garden and the terrace were refused: statues, indoor veranda) tight, closing, root size 2.5, frame centred on (199, 187). Biscuit at (200, 187) facing south with PegLeg, Nelim at (201, 187),#                     smiling. DR_StickLantern at (197, 185) and (203, 185) lit, Brazier at (198, 189) lit, PlantPot_Bonsai near (203, 189), Stool near (199, 190).#                     Health tab open, "peg leg". Instant: they are about to leave for supper. Lantern and brazier light at dusk.
@review @timeout:900 @requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.camerazoom @requires:nelim.pickletools.stagedecor @requires:nelim.pickletools.colonistrace @requires:nelim.pickletools.clearscreen @requires:nelim.pickletools.inspecttabs @requires:nelim.pickletools.clickdiagnostics @requires:nelim.pickletools.coatsteps @requires:akairo.Pomeranian @requires:SamBucher.ADogSaidAnimalProsthetics2
Feature: Pomeranian patch gallery

  Scenario: gallery-1-carried-in
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the hour to 8
    And Nelim's Sanctuary: the animals are removed from the sanctuary "infirmary-animals"
    And Nelim's Sanctuary: I am at the sanctuary "infirmary-animals"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the resource readout is hidden
    And Nelim's Pickle Tools: the alerts are hidden
    And Nelim's Pickle Tools: the main bar, the speed controls and the mouse-over readout are hidden
    And Nelim's Pickle Tools: I move the mouse to (10, 10)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: the colonist "Nelim" follows an apparel policy that allows everything
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Tunika" made of "Cloth"
    And Nelim's Pickle Tools: the "LTS_Tunika" worn by "Nelim" is dyed rgb (31, 122, 92)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PAESmallEarrings" made of "Gold"
    And Nelim's Pickle Tools: I place the decor "AnimalBed" at (213, 52)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (209, 50)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (217, 50)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (213, 55)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (209, 50) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (217, 50) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (213, 55) is lit
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (209, 52)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (217, 52)
    And Nelim's Pickle Tools: I place the decor "Shelf" near (216, 49)
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And Nelim's Pickle Tools: an adult animal of kind "aka_Pomeranian" named "Biscuit" is spawned at (213, 52)
    And Nelim's Pickle Tools: the animal "Biscuit" is missing its "rear left leg"
    And Nelim's Pickle Tools: the animal "Biscuit" lies on the bed at (213, 52)
    And Nelim's Pickle Tools: the colonist "Nelim" holds "MedicineIndustrial" in hand
    And Nelim's Pickle Tools: "Nelim" stands at (211, 52) facing East
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: I frame the area centred on (211, 52) at root size 3.5
    And Nelim's Pickle Tools: I select the thing of def "aka_Pomeranian" at (213, 52)
    And Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: I open the "Health" inspect tab
    When Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: the "Health" inspect tab is open
    Then I take a screenshot "pomeranian-1-carried-in"
    And Nelim's Pickle Tools: the decor is removed

  Scenario: gallery-2-the-offer
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the hour to 9
    And Nelim's Sanctuary: the animals are removed from the sanctuary "infirmary-animals"
    And Nelim's Sanctuary: I am at the sanctuary "infirmary-animals"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the resource readout is hidden
    And Nelim's Pickle Tools: the alerts are hidden
    And Nelim's Pickle Tools: the main bar, the speed controls and the mouse-over readout are hidden
    And Nelim's Pickle Tools: I move the mouse to (10, 10)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: the colonist "Nelim" follows an apparel policy that allows everything
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Tunika" made of "Cloth"
    And Nelim's Pickle Tools: the "LTS_Tunika" worn by "Nelim" is dyed rgb (31, 122, 92)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PAESmallEarrings" made of "Gold"
    And a colonist "Soren" exists
    And "Soren" is 30 years old
    And Nelim's Pickle Tools: "Soren" gender is male
    And Nelim's Pickle Tools: "Soren" hairstyle is "Roo_HD_Hair_Tidy"
    And Nelim's Pickle Tools: the colonist "Soren" follows an apparel policy that allows everything
    And Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "LisaWork_ApparelScrubs" made of "Cloth"
    And Nelim's Pickle Tools: the "LisaWork_ApparelScrubs" worn by "Soren" is dyed rgb (70, 110, 150)
    And Nelim's Pickle Tools: "Soren" wears "LisaWork_ApparelLabCoat" made of "Cloth"
    And Nelim's Pickle Tools: the "LisaWork_ApparelLabCoat" worn by "Soren" is dyed rgb (240, 240, 240)
    And Nelim's Pickle Tools: "Soren" wears "LisaWork_ApparelStethoscope" made of "Steel"
    And Nelim's Pickle Tools: I place the decor "AnimalBed" at (213, 52)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (209, 50)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (217, 50)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (213, 55)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (209, 50) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (217, 50) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (213, 55) is lit
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (209, 52)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (217, 52)
    And Nelim's Pickle Tools: I place the decor "Shelf" near (216, 49)
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And Nelim's Pickle Tools: an adult animal of kind "aka_Pomeranian" named "Biscuit" is spawned at (213, 52)
    And Nelim's Pickle Tools: the animal "Biscuit" is missing its "rear left leg"
    And Nelim's Pickle Tools: the animal "Biscuit" lies on the bed at (213, 52)
    And Nelim's Pickle Tools: "Soren" stands at (214, 52) facing West
    And Nelim's Pickle Tools: "Soren" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" stands at (211, 53) facing East
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: I frame the area centred on (211, 52) at root size 2.8
    And Nelim's Pickle Tools: I select the thing of def "aka_Pomeranian" at (213, 52)
    And Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: I open the "Health" inspect tab
    And Nelim's Pickle Tools: I open the Operations list of the Health tab
    And I click button keyed "AddBill"
    When Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: the "Health" inspect tab is open
    Then I take a screenshot "pomeranian-2-the-offer"
    And Nelim's Pickle Tools: the decor is removed

  Scenario: gallery-3-surgery
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the hour to 10
    And Nelim's Sanctuary: the animals are removed from the sanctuary "infirmary-animals"
    And Nelim's Sanctuary: I am at the sanctuary "infirmary-animals"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the resource readout is hidden
    And Nelim's Pickle Tools: the alerts are hidden
    And Nelim's Pickle Tools: the main bar, the speed controls and the mouse-over readout are hidden
    And Nelim's Pickle Tools: I move the mouse to (10, 10)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: the colonist "Nelim" follows an apparel policy that allows everything
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Tunika" made of "Cloth"
    And Nelim's Pickle Tools: the "LTS_Tunika" worn by "Nelim" is dyed rgb (31, 122, 92)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PAESmallEarrings" made of "Gold"
    And a colonist "Soren" exists
    And "Soren" is 30 years old
    And Nelim's Pickle Tools: "Soren" gender is male
    And Nelim's Pickle Tools: "Soren" hairstyle is "Roo_HD_Hair_Tidy"
    And Nelim's Pickle Tools: the colonist "Soren" follows an apparel policy that allows everything
    And Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "LisaWork_ApparelScrubs" made of "Cloth"
    And Nelim's Pickle Tools: the "LisaWork_ApparelScrubs" worn by "Soren" is dyed rgb (70, 110, 150)
    And Nelim's Pickle Tools: "Soren" wears "LisaWork_ApparelLabCoat" made of "Cloth"
    And Nelim's Pickle Tools: the "LisaWork_ApparelLabCoat" worn by "Soren" is dyed rgb (240, 240, 240)
    And Nelim's Pickle Tools: "Soren" wears "LisaWork_ApparelStethoscope" made of "Steel"
    And Nelim's Pickle Tools: I place the decor "AnimalBed" at (213, 52)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (209, 50)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (217, 50)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (213, 55)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (209, 50) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (217, 50) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (213, 55) is lit
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (209, 52)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (217, 52)
    And Nelim's Pickle Tools: I place the decor "Shelf" near (216, 49)
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And Nelim's Pickle Tools: I place the decor "Stool" near (211, 52)
    And Nelim's Pickle Tools: I place the decor "WoodLog" at (212, 50)
    And Nelim's Pickle Tools: an adult animal of kind "aka_Pomeranian" named "Biscuit" is spawned at (213, 52)
    And Nelim's Pickle Tools: the animal "Biscuit" is missing its "rear left leg"
    And Nelim's Pickle Tools: the animal "Biscuit" lies on the bed at (213, 52)
    And Nelim's Pickle Tools: the animal "Biscuit" has the surgery bill "InstallPegLegAnimal" on its "rear left leg"
    And Nelim's Pickle Tools: "Nelim" stands at (211, 53) facing East
    And Nelim's Pickle Tools: "Nelim" waits in place
    And Nelim's Pickle Tools: "Soren" mouth is "MouthNormal"
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: the colonist "Soren" holds "WoodLog" in hand
    And Nelim's Pickle Tools: "Soren" stands at (212, 53) facing East
    Given game speed is normal
    When Nelim's Pickle Tools: "Soren" operates on the animal "Biscuit"
    And I wait 120 ticks
    And game speed is paused
    And Nelim's Pickle Tools: I frame the area centred on (211, 52) at root size 2.5
    And Nelim's Pickle Tools: I select the thing of def "aka_Pomeranian" at (213, 52)
    And Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: I open the "Health" inspect tab
    And Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: the "Health" inspect tab is open
    Then I take a screenshot "pomeranian-3-surgery"
    And Nelim's Pickle Tools: the decor is removed

  Scenario: gallery-4-first-steps
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the hour to 15
    And Nelim's Sanctuary: the animals are removed from the sanctuary "flower-garden"
    And Nelim's Sanctuary: I am at the sanctuary "flower-garden"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the resource readout is hidden
    And Nelim's Pickle Tools: the alerts are hidden
    And Nelim's Pickle Tools: the main bar, the speed controls and the mouse-over readout are hidden
    And Nelim's Pickle Tools: I move the mouse to (10, 10)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: the colonist "Nelim" follows an apparel policy that allows everything
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Tunika" made of "Cloth"
    And Nelim's Pickle Tools: the "LTS_Tunika" worn by "Nelim" is dyed rgb (31, 122, 92)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PAESmallEarrings" made of "Gold"
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (153, 111) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (157, 111) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (153, 109) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (157, 109) fully grown
    And Nelim's Pickle Tools: I place the decor "PlantPot_Bonsai" near (152, 110)
    And Nelim's Pickle Tools: I place the decor "DR_StickLantern" at (152, 112)
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And Nelim's Pickle Tools: an adult animal of kind "aka_Pomeranian" named "Biscuit" is spawned at (155, 110)
    And Nelim's Pickle Tools: the animal "Biscuit" has the hediff "PegLeg" on its "rear left leg"
    And Nelim's Pickle Tools: the animal "Biscuit" faces south
    And Nelim's Pickle Tools: the animal "Biscuit" stands at (155, 110)
    And Nelim's Pickle Tools: "Nelim" stands at (156, 110) facing South
    And Nelim's Pickle Tools: the animal "Shogun" faces west
    And Nelim's Pickle Tools: the animal "Shogun" stands at (154, 112)
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: I frame the area centred on (153, 110) at root size 2.8
    And Nelim's Pickle Tools: I select the thing of def "aka_Pomeranian" at (155, 110)
    And Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: I open the "Health" inspect tab
    When Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: the "Health" inspect tab is open
    Then I take a screenshot "pomeranian-4-first-steps"
    And Nelim's Pickle Tools: the decor is removed

  Scenario: gallery-5-dusk-walk
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the hour to 18
    And Nelim's Sanctuary: the animals are removed from the sanctuary "calm-zone"
    And Nelim's Sanctuary: I am at the sanctuary "calm-zone"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the resource readout is hidden
    And Nelim's Pickle Tools: the alerts are hidden
    And Nelim's Pickle Tools: the main bar, the speed controls and the mouse-over readout are hidden
    And Nelim's Pickle Tools: I move the mouse to (10, 10)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: the colonist "Nelim" follows an apparel policy that allows everything
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Tunika" made of "Cloth"
    And Nelim's Pickle Tools: the "LTS_Tunika" worn by "Nelim" is dyed rgb (31, 122, 92)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PAESmallEarrings" made of "Gold"
    And Nelim's Pickle Tools: I place the decor "DR_StickLantern" exactly at (197, 185)
    And Nelim's Pickle Tools: I place the decor "DR_StickLantern" exactly at (203, 185)
    And Nelim's Pickle Tools: the decor "DR_StickLantern" at (197, 185) is lit
    And Nelim's Pickle Tools: the decor "DR_StickLantern" at (203, 185) is lit
    And Nelim's Pickle Tools: I place the decor "Brazier" exactly at (198, 189)
    And Nelim's Pickle Tools: the decor "Brazier" at (198, 189) is lit
    And Nelim's Pickle Tools: I place the decor "PlantPot_Bonsai" near (203, 189)
    And Nelim's Pickle Tools: I place the decor "Stool" near (199, 190)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (199, 185) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (202, 185) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (199, 189) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (202, 189) fully grown
    And Nelim's Pickle Tools: I place the decor "PlantPot_Bonsai" near (196, 187)
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And Nelim's Pickle Tools: an adult animal of kind "aka_Pomeranian" named "Biscuit" is spawned at (200, 187)
    And Nelim's Pickle Tools: the animal "Biscuit" has the hediff "PegLeg" on its "rear left leg"
    And Nelim's Pickle Tools: the animal "Biscuit" faces south
    And Nelim's Pickle Tools: the animal "Biscuit" stands at (200, 187)
    And Nelim's Pickle Tools: "Nelim" stands at (201, 187) facing South
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: I frame the area centred on (199, 187) at root size 2.5
    And Nelim's Pickle Tools: I select the thing of def "aka_Pomeranian" at (200, 187)
    And Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: I open the "Health" inspect tab
    When Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: the "Health" inspect tab is open
    Then I take a screenshot "pomeranian-5-dusk-walk"
    And Nelim's Pickle Tools: the decor is removed
