-- Rotface:
-- Remove conditions (target selection changed from TARGET_UNIT_NEARBY_ENTRY to TARGET_UNIT_TARGET_ANY so doesn't need it anymore)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=69508;

/* backup data
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 0, 69508, 0, 0, 18, 0, 1, 37986, 0, 0, 0, '', 'Rotface - Slime Spray');
*/

-- Add script
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_rotface_slime_spray';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(69507, 'spell_rotface_slime_spray'),
(71213, 'spell_rotface_slime_spray'),
(73189, 'spell_rotface_slime_spray'),
(73190, 'spell_rotface_slime_spray');

-- Fix targetting for Ooze Flood ability in encounter Modermiene / Rotface in instance / Instanz ICC / Eiskronenzitadelle / Icecrown Citadel
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceGroup` = 3 AND `SourceEntry` IN (69783, 69797, 69799, 69802) AND `ConditionTypeOrReference` = 33;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES
(13, 3, 69783, 0, 0, 33, 1, 0, 0, 0, 1, 0, '', 'Rotface - Ooze Flood, not self'),
(13, 3, 69797, 0, 0, 33, 1, 0, 0, 0, 1, 0, '', 'Rotface - Ooze Flood, not self'),
(13, 3, 69799, 0, 0, 33, 1, 0, 0, 0, 1, 0, '', 'Rotface - Ooze Flood, not self'),
(13, 3, 69802, 0, 0, 33, 1, 0, 0, 0, 1, 0, '', 'Rotface - Ooze Flood, not self');

-- Add immunities to Little Ooze / Big Ooze in encounter Modermiene / Rotface in instance / Instanz ICC / Eiskronenzitadelle / Icecrown Citadel
UPDATE `creature_template` SET `mechanic_immune_mask` = 650853247 WHERE `entry` IN (36897, 36899, 38138, 38123);

-- DB/NPCs: Little Ooze (Rotface in ICC) can not be taunted, 2012_09_10_06_world_creature_template.sql
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|256 WHERE `entry` IN (36897, 38138); -- Little Ooze

-- Rotface should not be interruptable. 10N: 36627, 25N: 38390, 10H: 38549, 25H: 38550
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|33554432 WHERE `entry` IN (36627,38390,38549,38550);

-- Volatile Ooze - Gas Cloud Movement Speed
UPDATE `creature_template` SET speed_walk = 1, speed_run = 1 WHERE `entry` IN (37697,38604,38758,38759,37562,38602,38760,38761);

-- Deathbringer Saufrang Event
UPDATE `gameobject` SET `spawntimesecs`=-25 WHERE `guid`=80494 LIMIT 1;
UPDATE `gameobject` SET `spawntimesecs`=-25 WHERE `guid`=80311 LIMIT 1;
UPDATE `gameobject` SET `spawntimesecs`=-25 WHERE `guid`=80033 LIMIT 1;
UPDATE `gameobject` SET `spawntimesecs`=-25 WHERE `guid`=73886 LIMIT 1;
UPDATE `gameobject` SET `spawntimesecs`=-25 WHERE `guid`=73382 LIMIT 1;
UPDATE `gameobject` SET `spawntimesecs`=-25 WHERE `guid`=73381 LIMIT 1;
UPDATE `gameobject` SET `spawntimesecs`=-25 WHERE `guid`=73364 LIMIT 1;
UPDATE `creature_template` SET `npcflag` = 1 WHERE `entry` = 37200;

-- Fly Fixes
UPDATE creature_template SET InhabitType=7 WHERE entry=36853;
UPDATE creature_template SET InhabitType=7 WHERE entry=37955;
UPDATE creature_template SET InhabitType=7 WHERE entry=37533;
UPDATE creature_template SET InhabitType=7 WHERE entry=37534;
UPDATE creature_template SET InhabitType=7 WHERE entry=37200;
UPDATE creature_template SET InhabitType=7 WHERE entry=37830;
UPDATE creature_template SET InhabitType=7 WHERE entry=37187;
UPDATE creature_template SET InhabitType=7 WHERE entry=37920;
UPDATE creature_template SET InhabitType=7 WHERE entry=38004;

UPDATE `creature_template` SET `ScriptName`='npc_highlord_tirion_fordring_lh' WHERE `entry`=37119;
UPDATE `creature_template` SET `ScriptName`='npc_rotting_frost_giant' WHERE `entry` IN (38490,38494);
UPDATE `creature_template` SET `ScriptName`='npc_frost_freeze_trap' WHERE `entry`=37744;
UPDATE `creature_template` SET `ScriptName`='npc_alchemist_adrianna' WHERE `entry`=38501;
UPDATE `creature_template` SET `ScriptName`='boss_sister_svalna' WHERE `entry`=37126;

-- Purctide Traps
SET @ENTRY := 38879;
UPDATE `creature_template` SET `ScriptName` = 'npc_putricide_insect_trap' WHERE `entry` = @ENTRY;
UPDATE `creature_template` SET `unit_flags` = '33554432' WHERE `entry` = @ENTRY; 
UPDATE `creature_template` SET `ScriptName`='npc_flesh_eating_insect' WHERE `entry`=37782;
DELETE FROM `creature` WHERE `id` = 37782;
UPDATE `creature_template` SET `type` = 8 WHERE `entry` = 37782;
UPDATE `creature_template` SET `dynamicflags` = '0' WHERE `entry` = '38879'; 
UPDATE `creature_template` SET `flags_extra` = '0' WHERE `entry` = '38879'; 

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) 
VALUES
('201399','37782','631','15','1','0','0','4355.25','3118.92','376.2','0.245031','86400','0','0','1396','0','0','0','0','0'),
('201611','37782','631','15','1','0','0','4353.55','3119.04','376.246','3.47438','86400','0','0','1396','0','0','0','0','0');

DELETE FROM `gameobject` WHERE `id` = 201818;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`)
VALUES 
('5495', '201818', '631', '15', '1', '4149.65', '2779.59', '350.962', '0', '0', '0', '0', '0', '604800', '0', '1');
UPDATE `gameobject_template` SET `faction` = 0, `ScriptName` = '' WHERE `entry` = 201818;
DELETE FROM `areatrigger_scripts` WHERE `entry` = 5647;


UPDATE `creature_template` SET `ScriptName` = 'npc_val_kyr_herald' WHERE `entry` = 37098;
UPDATE `creature_template` SET `ScriptName` = 'npc_severed_essence' WHERE `entry` = 38410;
UPDATE `creature_template` SET `ScriptName` = 'npc_korkron_primalist' WHERE `entry` = 37030;
UPDATE `creature_template` SET `ScriptName` = 'npc_korkron_defender' WHERE `entry` = 37032;
UPDATE `creature_template` SET `ScriptName` = 'npc_skybreaker_vindicator' WHERE `entry` = 37003;
UPDATE `creature_template` SET `ScriptName` = 'npc_skybreaker_protector' WHERE `entry` = 36998;
UPDATE `creature_template` SET `InhabitType`=7, `ScriptName` = 'npc_icc_spire_frostwyrm' WHERE `entry` = 37230;
UPDATE `creature_template` SET `InhabitType`=4 WHERE entry IN (38058,36725);

-- Areatriggers Script
DELETE FROM `areatrigger_scripts` WHERE `entry` IN (5630, 5628);
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES
(5628,'at_icc_land_frostwyrm'),
(5630,'at_icc_land_frostwyrm');

UPDATE creature_template SET mechanic_immune_mask = "2145367039" WHERE `entry` IN (36609, 39120, 39121, 39122); -- Valkyr Shadowguard
UPDATE creature_template SET speed_walk = 0.7, speed_run = 0.7 WHERE `entry` IN (37799, 39284, 39285, 39286); -- Vile Spirits
UPDATE creature_template SET speed_walk = 0.7, speed_run = 0.7 WHERE `entry` IN (39190, 39287, 39288, 39289); -- Wicked Spirit
UPDATE creature_template SET speed_walk = 0.642857, speed_run =0.642857 WHERE `entry` IN (36609, 39120, 39121, 39122); -- Valkyr Shadowguard
-- Fix Spirit Bomb Speed
UPDATE `creature_template` SET speed_walk = 1, speed_run = 1 WHERE entry =39189;

-- Before Sindragosa - Gaultnet event
UPDATE `creature_template` SET `modelid1` = 25455, `modelid2` = 0, `unit_flags` = 33555202, `flags_extra` = 129, `ScriptName` = 'npc_sindragosas_ward' WHERE `entry` = 37503;
DELETE FROM `creature` WHERE `id` = 37503;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(37503, 631, 15, 1, 0, 4181.54, 2551.65, 211.033, 4.72777, 604800, 0, 0, 27890000, 8516000, 0, 0, 0, 0);
UPDATE `gameobject` SET `state` = 0 WHERE `id` = 201373;
DELETE FROM `areatrigger_scripts` WHERE `entry` = 5623;
INSERT INTO `areatrigger_scripts` (entry, ScriptName) VALUES
(5623, 'at_icc_start_sindragosa_gauntlet');
UPDATE `creature_template` SET `minlevel` = 80, `maxlevel` = 80, `exp` = 2, `faction_a` = 21, `faction_h` = 21,`mechanic_immune_mask` = 8388624 WHERE `entry` IN (37228, 37229, 37232, 37501, 37502, 38197, 38198, 38362, 38134, 38137);
UPDATE `creature_template` SET `difficulty_entry_1` = 38134 WHERE `entry` = 37228;
UPDATE `creature_template` SET `difficulty_entry_1` = 38137 WHERE `entry` = 37229;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (37228, 37229, 37501, 37502);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (37228, 37229, 37501, 37502) AND `source_type` = 0;
INSERT INTO `smart_scripts` (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
-- Frostwarden Warrior: 37228 / 38134
(37228, 0, 0, 0, 0, 0, 100, 30, 5000, 15000, 10000, 25000, 11, 71323, 3, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frostwarden Warrior - Cast Frostblade'),
(37228, 0, 1, 0, 6, 0, 100, 30, 0, 0, 0, 0, 11, 71203, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frostwarden Warrior - Cast Soul Feast On Death'),
-- Frostwarden Sorceress: 37229 / 38137
(37229, 0, 0, 0, 0, 0, 100, 20, 15000, 20000, 20000, 25000, 11, 71331, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Frostwarden Sorceress - Cast Ice Tomb (25 man only)'),
(37229, 0, 1, 0, 0, 0, 100, 30, 10000, 15000, 10000, 20000, 11, 71320, 3, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frostwarden Sorceress - Cast Frost Nova'),
(37229, 0, 2, 0, 0, 0, 100, 30, 3000, 5000, 3000, 4000, 11, 71318, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Frostwarden Sorceress - Cast Frostbolt'),
(37229, 0, 3, 0, 6, 0, 100, 30, 0, 0, 0, 0, 11, 71203, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frostwarden Sorceress - Cast Soul Feast On Death'),
-- Nerubar Champion: 37501 / 38197
(37501, 0, 0, 0, 0, 0, 100, 30, 3000, 5000, 10000, 15000, 11, 71801, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Champion - Cast Rush'),
(37501, 0, 1, 0, 6, 0, 100, 30, 0, 0, 0, 0, 11, 71203, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Champion - Cast Soul Feast On Death'),
-- Nerubar Webweaver: 37502 / 38198
(37502, 0, 0, 0, 0, 0, 100, 30, 3000, 5000, 10000, 15000, 11, 71326, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Webweaver - Cast Crypt Scarabs'),
(37502, 0, 1, 0, 0, 0, 100, 30, 10000, 15000, 10000, 20000, 11, 71327, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Webweaver - Cast Web'),
(37502, 0, 2, 0, 6, 0, 100, 30, 0, 0, 0, 0, 11, 71203, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Webweaver - Cast Soul Feast On Death');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (37011, 36724, 37012, 36805, 36725, 36808, 36807, 3681, 36829, 37022, 37038, 10404, 37023, 36880, 37664, 37595, 37663, 37901, 37571, 37662, 37666, 37665, 37132, 36811, 38125, 37127, 37134, 37133) AND `source_type`=0;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName`='' WHERE `entry` IN (37011, 36724, 37012, 36805, 36725, 38058, 36808, 36807, 3681, 36829, 37022, 37038, 10404, 37023, 36880, 37664, 37595, 37663, 37901, 37571, 37662, 37666, 37665, 37132, 36811, 38125, 37127, 37134, 37133);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(37012, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 10000, 10000, 11, 70964, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ancient Skeletal Soldier - Shield Bash'),
(36724, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 6000, 12000, 11, 71029, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Servant of the Throne - Glacial Blast'),
(37011, 0, 0, 0, 2, 0, 100, 0, 5, 30, 15000, 20000, 75, 70960, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Damned - Bone Flurry at 5-30%'),
(37011, 0, 1, 2, 6, 0, 100, 1, 0, 0, 0, 0, 11, 70961, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Damned - Shattered Bones on death'),
(36725, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 69887, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Broodkeeper - Aggro - Cast Web Beam'),
(36725, 0, 1, 0, 10, 0, 100, 1, 0, 45, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Broodkeeper - OOC LOS - Attack Invoker'),
(36725, 0, 2, 0, 0, 1, 100, 0, 2000, 2000, 8000, 8000, 11, 70965, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Broodkeeper - In Combat - Crypt Scarabs'),
(36725, 0, 3, 0, 14, 1, 100, 0, 5000, 40, 5000, 5000, 11, 71020, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Broodkeeper - Friendly missing 5k HP - Dark Mending'),
(36725, 0, 4, 0, 0, 1, 100, 0, 5000, 5000, 5000, 5000, 11, 70980, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Broodkeeper - In Combat - Web Wrap'),
(36725, 0, 5, 0, 9, 0, 100, 1, 0, 5, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Broodkeeper - Target at 5 yards - Set phase 1'),
(36805, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 8000, 15000, 11, 69405, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Servant - Consuming Shadows'),
(36805, 0, 1, 0, 0, 0, 100, 10, 2000, 2000, 3000, 4000, 11, 69576, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Servant - Chaos Bolt'),
(36805, 0, 2, 0, 0, 0, 100, 20, 2000, 2000, 3000, 4000, 11, 71108, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Servant - Chaos Bolt'),
(36805, 0, 3, 0, 0, 0, 100, 10, 3000, 5000, 15000, 20000, 11, 69404, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Servant - Curse of Agony'),
(36805, 0, 4, 0, 0, 0, 100, 20, 3000, 5000, 15000, 20000, 11, 71112, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Servant - Curse of Agony'),
(36807, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 8000, 15000, 11, 69391, 0, 0, 0, 0, 0, 9, 0, 0, 30, 0, 0, 0, 0, 'Deathspeaker Disciple - Dark Blessing'),
(36807, 0, 1, 0, 0, 0, 100, 0, 2000, 2000, 3000, 7000, 11, 69387, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Disciple - Shadow Bolt'),
(36807, 0, 2, 0, 0, 0, 100, 10, 5000, 10000, 8000, 10000, 11, 69389, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Disciple - Shadow Mend'),
(36807, 0, 3, 0, 0, 0, 100, 20, 3000, 5000, 5000, 8000, 11, 69389, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Disciple - Shadow Mend'),
(36808, 0, 0, 0, 0, 0, 100, 0, 6000, 6000, 6000, 6000, 11, 69492, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Zealot - Shadow Cleave'),
(36811, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 3000, 5000, 11, 69387, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Attendant - Shadow Bolt'),
(36811, 0, 1, 0, 0, 0, 100, 10, 5000, 10000, 5000, 10000, 11, 69355, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Attendant - Shadow Nova'),
(36811, 0, 2, 0, 0, 0, 100, 20, 5000, 8000, 5000, 10000, 11, 71106, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Attendant - Shadow Nova'),
(36829, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 69491, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker High Priest - Aura of Darkness on Aggro'),
(36829, 0, 1, 0, 0, 0, 100, 0, 2000, 2000, 10000, 12000, 11, 69483, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker High Priest - Dark Reckoning'),
(36829, 0, 2, 0, 7, 0, 100, 0, 0, 0, 0, 0, 28, 69491, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker High Priest - Remove Aura of Darkness On Evade'),
(37022, 0, 0, 0, 0, 0, 100, 0, 4000, 4000, 6000, 6000, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blighted Abomination - Cleave'),
(37022, 0, 1, 0, 0, 0, 100, 0, 10000, 10000, 20000, 20000, 11, 71150, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blighted Abomination - Plague Cloud'),
(37022, 0, 2, 0, 0, 0, 100, 0, 5000, 5000, 12000, 20000, 11, 71140, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Blighted Abomination - Scourge Hook'),
(37038, 0, 0, 0, 0, 0, 100, 0, 3000, 20000, 20000, 40000, 11, 71164, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Vengeful Fleshreaper - Leaping Face Maul'),
(37023, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 8000, 12000, 11, 71103, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Plague Scientist - Combobulating Spray'),
(37023, 0, 1, 0, 0, 0, 100, 0, 2000, 2000, 2000, 3000, 11, 73079, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Plague Scientist - Plague Blast'),
(37023, 0, 2, 0, 0, 0, 100, 0, 8000, 12000, 15000, 20000, 11, 69871, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Plague Scientist - Plague Stream'),
(10404, 0, 0, 0, 2, 0, 100, 1, 0, 15, 0, 0, 11, 71088, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pustulating Horror - Blight Bomb'),
(10404, 0, 1, 0, 0, 0, 100, 10, 2000, 2000, 15000, 20000, 11, 71089, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Pustulating Horror - Bubbling Pus'),
(10404, 0, 2, 0, 0, 0, 100, 20, 2000, 2000, 15000, 20000, 11, 71090, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Pustulating Horror - Bubbling Pus'),
(36880, 0, 0, 0, 0, 0, 100, 10, 5000, 5000, 15000, 25000, 11, 71114, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Decaying Colossus - Massive Stomp'),
(36880, 0, 1, 0, 0, 0, 100, 20, 5000, 5000, 15000, 25000, 11, 71115, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Decaying Colossus - Massive Stomp'),
(37664, 0, 0, 0, 0, 0, 100, 0, 9000, 12000, 15000, 18000, 11, 70410, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Polymorph Spider'),
(37664, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 15000, 25000, 11, 70299, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Siphon Essence'),
(37664, 0, 2, 0, 0, 0, 100, 10, 10000, 15000, 15000, 20000, 11, 70408, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Amplify Magic'),
(37664, 0, 3, 0, 0, 0, 100, 10, 8000, 10000, 10000, 20000, 11, 70407, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Blast Wave'),
(37664, 0, 4, 0, 0, 0, 100, 10, 2000, 2000, 3000, 4000, 11, 70409, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Fireball'),
(37664, 0, 5, 0, 0, 0, 100, 20, 10000, 15000, 10000, 15000, 11, 72336, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Amplify Magic'),
(37664, 0, 6, 0, 0, 0, 100, 20, 8000, 10000, 10000, 20000, 11, 71151, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Blast Wave'),
(37664, 0, 7, 0, 0, 0, 100, 20, 2000, 2000, 2000, 3000, 11, 71153, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Fireball'),
(37595, 0, 0, 0, 0, 0, 100, 0, 4000, 5000, 32000, 37000, 11, 70450, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Blood Knight - Blood Mirror'),
(37595, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 15000, 25000, 11, 70299, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Blood Knight - Siphon Essence'),
(37595, 0, 2, 0, 0, 0, 100, 0, 2000, 3000, 3000, 4000, 11, 70437, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Blood Knight - Unholy Strike'),
(37595, 0, 3, 0, 4, 0, 100, 0, 0, 0, 12000, 15000, 11, 71736, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Blood Knight - Vampiric Aura'),
(37663, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 20000, 25000, 11, 70645, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Noble - Chains of Shadow'),
(37663, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 15000, 25000, 11, 70299, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Noble - Siphon Essence'),
(37663, 0, 2, 0, 0, 0, 100, 10, 3000, 5000, 4000, 5000, 11, 72960, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Noble - Shadow Bolt'),
(37663, 0, 3, 0, 0, 0, 100, 20, 3000, 5000, 3000, 4000, 11, 72961, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Noble - Shadow Bolt'),
(37901, 0, 0, 0, 0, 0, 100, 1, 5000, 5000, 0, 0, 11, 41290, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vampiric Fiend - Disease Cloud'),
(37901, 0, 1, 0, 0, 0, 100, 0, 10000, 10000, 10000, 10000, 11, 70671, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vampiric Fiend - Leeching Rot'),
(37571, 0, 0, 0, 0, 0, 100, 0, 10000, 15000, 15000, 20000, 11, 72065, 0, 0, 0, 0, 0, 9, 0, 0, 40, 0, 0, 0, 0, 'Darkfallen Advisor - Shroud of Protection'),
(37571, 0, 1, 0, 0, 0, 100, 0, 10000, 15000, 15000, 20000, 11, 72066, 0, 0, 0, 0, 0, 9, 0, 0, 40, 0, 0, 0, 0, 'Darkfallen Advisor - Shroud of Spell Warding'),
(37571, 0, 2, 0, 0, 0, 100, 10, 2000, 5000, 10000, 10000, 11, 72057, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Advisor - Lich Slap'),
(37571, 0, 3, 0, 0, 0, 100, 20, 2000, 5000, 5000, 8000, 11, 72421, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Advisor - Lich Slap'),
(37662, 0, 0, 0, 0, 0, 100, 0, 8000, 10000, 15000, 20000, 11, 70750, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Commander - Battle Shout'),
(37662, 0, 1, 0, 0, 0, 100, 10, 4000, 8000, 10000, 15000, 11, 70449, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Commander - Vampire Rush'),
(37662, 0, 2, 0, 0, 0, 100, 20, 4000, 8000, 10000, 15000, 11, 71155, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Commander - Vampire Rush'),
(37665, 0, 0, 0, 0, 0, 100, 0, 8000, 15000, 10000, 20000, 11, 70423, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Lieutenant - Vampiric Curse'),
(37665, 0, 1, 0, 0, 0, 100, 10, 1000, 2000, 25000, 25000, 11, 70435, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Lieutenant - Rend Flesh'),
(37665, 0, 2, 0, 0, 0, 100, 20, 1000, 2000, 25000, 25000, 11, 71154, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Lieutenant - Rend Flesh'),
(37666, 0, 0, 0, 0, 0, 100, 0, 5000, 15000, 15000, 25000, 11, 70432, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Tactician - Blood Sap'),
(37666, 0, 1, 0, 0, 0, 100, 0, 2000, 3000, 6000, 6000, 11, 70437, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Tactician - Unholy Strike'),
(37666, 0, 2, 0, 0, 0, 100, 0, 1000, 2000, 15000, 20000, 11, 70431, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Tactician - Shadowstep'),
(38125, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 15000, 25000, 11, 71298, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Banish'),	  	
(38125, 0, 1, 0, 0, 0, 100, 0, 1000, 2000, 25000, 25000, 11, 69929, 0, 0, 0, 0, 0, 9, 0, 0, 80, 0, 0, 0, 0, 'Ymirjar Deathbringer - Spirit Stream'),
(38125, 0, 2, 0, 0, 0, 100, 0, 1000, 2000, 25000, 25000, 11, 71303, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Summon Ymirjar'),
(38125, 0, 3, 0, 0, 0, 100, 10, 10000, 15000, 15000, 25000, 11, 71299, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Deaths Embrace'),
(38125, 0, 4, 0, 0, 0, 100, 10, 1000, 2000, 2000, 2000, 11, 71300, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Shadow Bolt'),
(38125, 0, 5, 0, 0, 0, 100, 20, 5000, 10000, 15000, 20000, 11, 71296, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Deaths Embrace'),
(38125, 0, 6, 0, 0, 0, 100, 20, 1000, 2000, 2000, 2000, 11, 71297, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Shadow Bolt'),
(37127, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 3000, 5000, 11, 71274, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Frostbinder - Frozen Orb'),
(37127, 0, 1, 0, 0, 0, 100, 0, 1000, 2000, 25000, 25000, 11, 69929, 0, 0, 0, 0, 0, 9, 0, 0, 80, 0, 0, 0, 0, 'Ymirjar Frostbinder - Spirit Stream'),
(37134, 0, 0, 0, 0, 0, 100, 0, 5000, 30000, 25000, 25000, 11, 71249, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Ice Trap'),
(37134, 0, 1, 0, 0, 0, 100, 0, 10000, 15000, 25000, 25000, 11, 71251, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Rapid Shot'),
(37134, 0, 2, 0, 0, 0, 100, 0, 1000, 2000, 1000, 1000, 11, 71253, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Shoot'),
(37134, 0, 3, 0, 0, 0, 100, 0, 5000, 10000, 15000, 25000, 11, 71252, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Volley'),
(37134, 0, 4, 0, 0, 0, 100, 20, 1000, 2000, 25000, 25000, 11, 71705, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Summon Warhawk'),
(37133, 0, 0, 0, 0, 0, 100, 0, 5000, 15000, 12000, 20000, 11, 41056, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Warlord - Whirlwind');

-- The Damned pathing
SET @NPC1 := 201107;
SET @NPC2 := 201146;
UPDATE `creature` SET `position_x`=-175.160233, `position_y`=2180.252441, `position_z`=37.985165, `orientation`=1.621184 WHERE `guid`=@NPC1;
UPDATE `creature` SET `currentwaypoint`=1, `MovementType`=2 WHERE `guid` IN (@NPC1,@NPC2);
DELETE FROM `creature_addon` WHERE `guid` IN (@NPC1, @NPC2);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(@NPC1,@NPC1*10,0,0,0,0,''),
(@NPC2,@NPC2*10,0,0,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` IN (@NPC1*10, @NPC2*10);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_Z`,`orientation`,`delay`,`action`,`action_chance`,`wpguid`) VALUES
(@NPC1*10,1,-175.160233,2180.252441,37.985165,1.621184,0,0,100,0),
(@NPC1*10,2,-178.473145,2245.945801,37.985241,1.621184,0,0,100,0),
(@NPC2*10,1,-170.416,2180.83,37.8201,1.36136,0,0,100,0),
(@NPC2*10,4,-173.728912,2246.52336,37.985241,1.36136,0,0,100,0);

-- Vengeful Fleshreaper pathing
SET @NPC1 := 201373;
SET @NPC2 := 201389;
UPDATE `creature` SET `position_x`=4370.501953, `position_y`=3063.313477, `position_z`=371.682373, `orientation`=4.678616, `currentwaypoint`=1,`MovementType`=2 WHERE `guid`=@NPC1;
UPDATE `creature` SET `position_x`=4342.688965, `position_y`=3062.161133, `position_z`=371.673218, `orientation`=4.695860, `currentwaypoint`=1,`MovementType`=2 WHERE `guid`=@NPC2;
DELETE FROM `creature_addon` WHERE `guid` IN (@NPC1, @NPC2);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(@NPC1,@NPC1*10,0,0,0,0,''),
(@NPC2,@NPC2*10,0,0,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` IN (@NPC1*10, @NPC2*10);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_Z`,`orientation`,`delay`,`action`,`action_chance`,`wpguid`) VALUES
(@NPC1*10,1,4370.501953,3063.313477,371.682373,4.678616,0,0,100,0),
(@NPC1*10,2,4370.446777,3041.886475,372.798065,6.239988,0,0,100,0),
(@NPC1*10,3,4431.955078,3040.562012,372.796875,1.515033,0,0,100,0),
(@NPC1*10,4,4432.262695,3079.419189,372.941071,4.673120,0,0,100,0),
(@NPC1*10,5,4432.354004,3041.560547,372.790863,3.114890,0,0,100,0),
(@NPC1*10,6,4370.663086,3040.779785,372.800293,1.551947,0,0,100,0),
(@NPC2*10,1,4342.688965,3062.161133,371.673218,4.695860,0,0,100,0),
(@NPC2*10,2,4342.340820,3041.446533,372.792023,3.113284,0,0,100,0),
(@NPC2*10,3,4281.295410,3040.479004,372.788544,1.588826,0,0,100,0),
(@NPC2*10,4,4280.906738,3073.233643,371.702759,4.732776,0,0,100,0),
(@NPC2*10,5,4280.291504,3041.645020,372.785004,6.281582,0,0,100,0),
(@NPC2*10,6,4342.137695,3041.630127,372.792053,1.557411,0,0,100,0);
UPDATE `creature_template` SET `ScriptName`='npc_deathbound_ward' WHERE `entry`=37007;

-- Argent & Ebon Champions SAI
SET @ARGENT := 37928; -- Argent Champion
SET @EBON := 37996; -- Ebon Champion
SET @SPELL1 := 53625; -- Heroic Leap
SET @SPELL2 := 67939; -- Icy Touch
SET @SPELL3 := 66023; -- Icebound Fortitude
SET @SPELL4 := 66019; -- Death Coil
SET @SPELL5 := 66047; -- Frost Strike
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@ARGENT,@EBON);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ARGENT,@EBON) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ARGENT,0,0,0,9,0,100,0,8,40,7000,10000,11,@SPELL1,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Argent Champion - Target at 8-40 yards - Heroic Leap'),
(@EBON,0,0,0,0,0,100,0,5000,7000,10000,15000,11,@SPELL2,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Ebon Champion - In combat - Icy Touch'),
(@EBON,0,1,0,0,0,100,0,10000,15000,7000,8000,11,@SPELL4,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Ebon Champion - In combat - Death Coil'),
(@EBON,0,2,0,0,0,100,0,10000,15000,10000,15000,11,@SPELL5,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Ebon Champion - In combat - Frost Strike'),
(@EBON,0,3,0,2,0,100,0,0,80,60000,60000,11,@SPELL3,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Ebon Champion - 80% HP - Icebound Fortitude');

-- Aura of Darkness spell difficulties
DELETE FROM `spelldifficulty_dbc` WHERE `id`=69490 AND `spellid0`=69490;
INSERT INTO `spelldifficulty_dbc` (`id`,`spellid0`,`spellid1`) VALUES
(69490,69490,72629);

UPDATE `creature_template` SET `ScriptName` = 'npc_val_kyr_herald' WHERE `entry` = 37098;
UPDATE `creature_template` SET `ScriptName` = 'npc_severed_essence' WHERE `entry` = 38410;

-- Areatriggers Script
DELETE FROM `areatrigger_scripts` WHERE `entry` IN (5630, 5628);
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES
(5628,'at_icc_land_frostwyrm'),
(5630,'at_icc_land_frostwyrm');

UPDATE `creature_template` SET `ScriptName` = 'npc_korkron_defender' WHERE `entry` = 37032;
UPDATE `creature_template` SET `ScriptName` = 'npc_korkron_primalist' WHERE `entry` = 37030;
UPDATE `creature_template` SET `ScriptName` = 'npc_skybreaker_vindicator' WHERE `entry` = 37003;
UPDATE `creature_template` SET `ScriptName` = 'npc_skybreaker_protector' WHERE `entry` = 36998;
UPDATE `creature_template` SET `InhabitType`=7, `ScriptName` = 'npc_icc_spire_frostwyrm' WHERE `entry` = 37230;
UPDATE `creature_template` SET `InhabitType`=4 WHERE entry IN (38058,36725);

-- Spells
UPDATE `creature_template` SET `unit_flags` = 33554564, `flags_extra` = 2 WHERE `entry` IN (37044, 37041);
UPDATE `creature_template` SET `faction_a` = 1801,`faction_h` = 1801 WHERE `entry` = 37044;
UPDATE `creature_template` SET `faction_a` = 1802,`faction_h` = 1801 WHERE `entry` = 37041;
DELETE FROM `creature_template_addon` WHERE `entry` IN (37044, 37041);
SET @KORKRON := 37044;     -- Kor'kron Battle Standard
SET @SKYBREAKER := 37041;  -- Skybreaker Battle Standard
SET @HSPELL := 69809;
SET @ASPELL := 69808;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@KORKRON, @SKYBREAKER);
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (@KORKRON, @SKYBREAKER);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@KORKRON ,0,0,0,54,0,100,1,0,0,0,0,11,@HSPELL,2,0,0,0,0,1,0,0,0,0,0,0,0, 'Kor''kron Battle Standard - On spawn Cast spell 69809'),
(@SKYBREAKER,0,0,0,54,0,100,1,0,0,0,0,11,@ASPELL,2,0,0,0,0,1,0,0,0,0,0,0,0, 'Skybreaker Battle Standard - On spawn Cast spell 69808');

SET @PRIMALIST := 37030;
SET @INVOKER := 37033;
SET @DEFENDER := 37032;
SET @VINDICATOR := 37003;
SET @SORCERER := 37026;
SET @PROTECTOR := 36998;
SET @FROSTWYRM := 37230;
SET @SOUNDID :=0;
DELETE FROM `creature_text` WHERE `entry` IN (37030,37033,37032,37003,37026,36998,37230);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@PRIMALIST,0, 0, 'Thank the spirits for you, brothers and sisters. The Skybreaker has already left. Quickly now, to Orgrim''s Hammer! If you leave soon, you may be able to catch them.', 12, 0, 100, 0, 0, @SOUNDID, 'Kor''kron Primalist - SAY_FIRST_SQUAD_RESCUED_HORDE_0'),
(@INVOKER,  0, 0, 'This should be helpin''ya!', 12, 0, 100, 0, 0, @SOUNDID, 'Kor''kron Invoker - SAY_FIRST_SQUAD_RESCUED_HORDE_1'),
(@INVOKER,  1, 0, '%s summons a Kor''kron Battle Standard.', 16, 0, 100, 0, 0, @SOUNDID, 'Kor''kron Invoker - SAY_SUMMON_BATTLE_STANDARD'),
(@DEFENDER, 0, 0, 'Aka''Magosh, brave warriors. The alliance is in great number here.', 12, 0, 100, 0, 0, @SOUNDID, 'Kor''kron Defender - SAY_SECOND_SQUAD_RESCUED_HORDE_0'),
(@DEFENDER, 1, 0, 'Captain Saurfang will be pleased to see you aboard Orgrim''s Hammer. Make haste, we will secure the area until you are ready for take-off.', 12, 0, 100, 0, 0, @SOUNDID, 'Kor''kron Defender - SAY_SECOND_SQUAD_RESCUED_HORDE_1'),
(@DEFENDER, 2, 0, 'A screeching cry pierces the air above!',41, 0, 100, 0, 0, @SOUNDID, 'Frostwyrm - SAY_FROSTWYRM_SUMMON_0'),
(@VINDICATOR, 0, 0, 'Thank goodness you arrived when you did, heroes. Orgrim''s Hammer has already left. Quickly now, to The Skybreaker! If you leave soon, you may be able to catch them.', 12, 0, 100, 0, 0, @SOUNDID, 'Skybreaker Vindicator - SAY_FIRST_SQUAD_RESCUED_ALLIANCE_0'),
(@SORCERER, 0, 0, 'This ought to help!', 12, 0, 100, 0, 0, @SOUNDID, 'Skybreaker Sorcerer - SAY_FIRST_SQUAD_RESCUED_ALLIANCE_1'),
(@SORCERER, 1, 0, '%s summons a Skybreaker Battle Standard.', 16, 0, 100, 0, 0, @SOUNDID, 'Skybreaker Sorcerer - SAY_SUMMON_BATTLE_STANDARD'),
(@PROTECTOR,0, 0, 'You have my thanks. We were outnumbered until you arrived.', 12, 0, 100, 0, 0, @SOUNDID, 'Skybreaker Protector - SAY_SECOND_SQUAD_RESCUED_ALLIANCE_0'),
(@PROTECTOR,1, 0, 'Captain Muradin is waiting aboard The Skybreaker. We''ll secure the area until you are ready for take off.', 12, 0, 100, 0, 0, @SOUNDID, 'Skybreaker Protector - SAY_SECOND_SQUAD_RESCUED_ALLIANCE_1'),
(@PROTECTOR,2, 0, 'Skybreaker infantry, hold position!', 12, 0, 100, 0, 0, @SOUNDID, 'Skybreaker Protector - SAY_SECOND_SQUAD_RESCUED_ALLIANCE_2'),
(@PROTECTOR,3, 0, 'A screeching cry pierces the air above!',41, 0, 100, 0, 0, @SOUNDID, 'Frostwyrm - SAY_FROSTWYRM_SUMMON_0'),
(@FROSTWYRM,0, 0, 'A Spire Frostwyrm lands just before Orgrim''s Hammer.', 16, 0, 100, 0, 0, @SOUNDID, 'Frostwyrm - SAY_FROSTWYRM_LAND_H_1'),
(@FROSTWYRM,1, 0, 'A Spire Frostwyrm lands just before The Skybreaker. ', 16, 0, 100, 0, 0, @SOUNDID, 'Frostwyrm - SAY_FROSTWYRM_LAND_A_2');

DELETE FROM `disables` WHERE `entry` = 70460;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES ('0', '70460', '64', '', '', 'Ignore LOS on Coldflame Jets');

DELETE FROM `creature` WHERE `guid` = 201041;
DELETE FROM `creature` WHERE `guid` = 200988;
DELETE FROM `creature` WHERE `guid` = 201388;
DELETE FROM `creature` WHERE `guid` = 201445;
DELETE FROM `creature` WHERE `guid` = 201492;
DELETE FROM `creature` WHERE `guid` = 201018;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES ('201041', '37032', '631', '15', '1', '0', '1', '-565.392', '2211.957', '199.969', '4.450', '86400', '0', '0', '392528', '0', '0', '0', '0', '0');
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES ('200988', '37003', '631',  '15', '1', '0', '1', '-561.728', '2217.28', '199.97', '4.12012', '86400', '0', '0', '398434', '41690', '0', '0', '0', '0');
-- Move NPCs to proper locations
UPDATE `creature` SET  `position_x` =  '-558.109253', `position_y` =  '2205.420654', `position_z` = 199.969559, `orientation` = 3.004918 WHERE  `guid` = 200988;  -- VINDICATOR
UPDATE `creature` SET  `position_x` =  '-531.942566', `position_y` =  '2124.377930', `position_z` = 199.969681, `orientation` = 2.438634 WHERE  `guid` = 201041; -- Horde DEFENDER
UPDATE `creature` SET  `position_x` =  '-540.092224', `position_y` =  '2129.904785', `position_z` = 199.970352, `orientation` = 2.438634 WHERE  `guid` = 201076; -- Ally NPC, 
UPDATE `creature` SET  `position_x` =  '-562.132874', `position_y` =  '2195.537354', `position_z` = 199.969757, `orientation` = 1.466264 WHERE  `guid` = 201020; -- Ally sorcerer

UPDATE `creature_template` SET `ScriptName` = 'npc_nerubar_broodkeeper_icc' WHERE `entry` IN (38058,36725);

UPDATE gameobject SET state = 0 WHERE id = 201376;
UPDATE `gameobject` SET `position_x`=-192.116287, `position_y`=2167.751465,`position_z`=37.985165 WHERE `guid`=150166;
UPDATE `gameobject_template` SET `data1` = '0' ,`data4`=1,`data9` = '0',`data11` = '0' WHERE `entry` IN (201814,201815,201816,201817);

UPDATE `creature_template` SET flags_extra=flags_extra | 128 WHERE entry IN(39010,39011,39012,39013);

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_icc_stoneform';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_icc_sprit_alarm';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(70733, 'spell_icc_stoneform'),
(70546, 'spell_icc_sprit_alarm'),
(70536, 'spell_icc_sprit_alarm'),
(70545, 'spell_icc_sprit_alarm'),
(70547, 'spell_icc_sprit_alarm');

-- Update ALL ICC Immunities
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`
|1 -- CHARM
|2 -- DISORIENTED
|4 -- DISARM
|8 -- DISTRACT
|16 -- FEAR
|32 -- GRIP
|64 -- ROOT
|256 -- SILENCE
|512 -- SLEEP
|1024 -- SNARE
|2048 -- STUN
|4096 -- FREEZE
|8192 -- KNOCKOUT
|65536 -- POLYMORPH
|131072 -- BANISH
|524288 -- SHACKLE
|4194304 -- TURN
|8388608 -- HORROR
|33554432 -- INTERRUPT
|67108864 -- DAZE
|536870912 -- SAPPED
WHERE `entry` IN
(36612,37957,37958,37959, -- Lord Marrowgar
36619,38233,38459,38460, -- Bone Spike
38490,38494, -- Rotting Frost Giant
37813,38402,38582,38583, -- Deathbringer Saurfang
36626,37504,37505,37506, -- Festergut
36627,38390,38549,38550, -- Rotface
36897,38138, -- Little Ooze
36899,38123, -- Big Ooze
36678,38431,38585,38586, -- Professor Putricide
37697,38604,38758,38759, -- Volatile Ooze
37562,38602,38760,38761, -- Gas Cloud
37970,38401,38784,38785, -- Prince Valanar
37972,38399,38769,38770, -- Prince Keleseth
37973,38400,38771,38772, -- Prince Taldaram
38369, -- Dark Nucleus 
38454,38775,38776,38777, -- Kinetic Bomb
37955,38434,38435,38436, -- Blood-Queen Lana'thel
37126,38258, -- Sister Svalna
37533,38220, -- Rimefang
37534,38219, -- Spinestalker
36853,38265,38266,38267, -- Sindragosa
36597,39166,39167,39168, -- The Lich King
37698,39299,39300,39301, -- Shambling Horror
37695,39309,39310,39311, -- Drudge Ghoul
36633,39305,39306,39307, -- Ice Sphere
36701,39302,39303,39304, -- Raging Spirit
37799,39284,39285,39286, -- Vile Spirits
39190,39287,39288,39289, -- Wicked Spirit
36824,39296); -- Spirit Warden

