-- Updates and Fixes for Utgarde Pinnacle

-- Skadi and Grauf Normal
UPDATE `creature_template` SET `InhabitType`=7 WHERE `entry`=26893;
UPDATE `creature_template` SET `InhabitType`=7 WHERE `entry`=26693;

-- Skadi and Grauf Heroic
UPDATE `creature_template` SET `InhabitType`=7 WHERE `entry`=30807;
UPDATE `creature_template` SET `InhabitType`=7 WHERE `entry`=30775;

-- Svala Normal
UPDATE `creature_template` SET `InhabitType`=7 WHERE `entry`=26668;
UPDATE `creature_template` SET `InhabitType`=7 WHERE `entry`=29281;

-- Svala Heroic
UPDATE `creature_template` SET `InhabitType`=7 WHERE `entry`=30809;
UPDATE `creature_template` SET `InhabitType`=7 WHERE `entry`=30810;

-- Correct Avenging Spirit Factions
-- Alliance
UPDATE `creature_template` SET `faction_A`=14 WHERE `entry`=30756;
UPDATE `creature_template` SET `faction_A`=14 WHERE `entry`=27386;
-- Horde
UPDATE `creature_template` SET `faction_H`=14 WHERE `entry`=30756;
UPDATE `creature_template` SET `faction_H`=14 WHERE `entry`=27386;
-- Apparently the AND did not want to update the faction correctly.

-- Update InhabitType for Statis Orb
UPDATE `creature_template` SET `InhabitType`=7 WHERE `entry`=26688;
