# Pass 2: Pomeranian Continued and this patch, no A Dog Said 2. English only.
#
# S3 of TESTING.md. The guard is a PatchOperationConditional on ADS_Cat1: without A Dog Said 2 the
# patch must do nothing and log nothing. The offline suite proves the guard selects nothing in a
# document without the category; only the game shows the log stays clean.

@requires:akairo.Pomeranian
Feature: The pomeranian patch without A Dog Said 2

  Scenario: A Dog Said 2 is absent
    Then mod "akairo.Pomeranian" is loaded
    And mod "nelim.pomeranian.adogsaidpatch" is loaded
    And mod "SamBucher.ADogSaidAnimalProsthetics2" is not loaded

  Scenario: loading the colony logs nothing from this mod
    Given the save "test-colony" is loaded
    And I close all dialogs
    Then no errors were logged
    And no warnings from mod "nelim.pomeranian.adogsaidpatch"

  Scenario: the pomeranian is not offered the A Dog Said 2 surgeries
    Then Pomeranian Patch Renew the race "aka_Pomeranian" does not offer the recipe "InstallPegLegAnimal"
