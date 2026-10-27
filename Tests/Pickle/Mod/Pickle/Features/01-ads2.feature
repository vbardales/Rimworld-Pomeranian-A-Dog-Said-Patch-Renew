# Pass 1: Pomeranian Continued, this patch, then A Dog Said 2. English only.
#
# S1 and S4 of TESTING.md. The offline suite (Tests/Test-Xml.ps1) already proves the patch writes
# three entries into ADS_Cat1 to ADS_Cat3. Only a running game shows that the recipes reach the
# animal after A Dog Said 2 copied the categories onto the surgery bases, and that the load
# order the game kept is the one the About.xml declares.

@requires:SamBucher.ADogSaidAnimalProsthetics2
@requires:akairo.Pomeranian
Feature: The pomeranian beside A Dog Said 2, in the declared load order

  Scenario: the load order is the one the mod declares
    Then mod "akairo.Pomeranian" is loaded
    And mod "SamBucher.ADogSaidAnimalProsthetics2" is loaded
    And mod "nelim.pomeranian.adogsaidpatch" loads before "SamBucher.ADogSaidAnimalProsthetics2"

  Scenario: the pomeranian is offered the A Dog Said 2 surgeries
    Then Pomeranian Patch Renew the race "aka_Pomeranian" offers the recipe "InstallPegLegAnimal"
    And Pomeranian Patch Renew the race "aka_Pomeranian" offers the recipe "InstallBionicLegAnimal"

  Scenario: loading the colony logs nothing from this mod
    Given the save "test-colony" is loaded
    And I close all dialogs
    Then no errors were logged
    And no warnings from mod "nelim.pomeranian.adogsaidpatch"
