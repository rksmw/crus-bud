-- Script named 'npc_proximity_mine' does not have a script name assigned in database.
UPDATE `creature_template` SET `ScriptName`='npc_proximity_mine' WHERE `entry`=34362;


-- Reaplicando SQl no Aplicado 030_Mobs_Blades_Edge_Mountains_Update_2[World].sql
-- Script named 'npc_the_soulgrinder' does not have a script name assigned in database.
-- Script named 'npc_sundered_ghost' does not have a script name assigned in database.
-- Script named 'npc_skulloc_soulgrinder' does not have a script name assigned in database.
UPDATE `creature_template` SET `faction_A`='16',`faction_H`='16',`scriptname` = 'npc_skulloc_soulgrinder' WHERE entry = '22910';
UPDATE `creature_template` SET `modelid1`='11686', `scriptname` = 'npc_sundered_ghost' WHERE `entry` IN (24039);
UPDATE `creature_template` SET `modelid1`='11686', `scriptname` = 'npc_sundered_spirit' WHERE `entry` IN (22912);
UPDATE `creature_template` SET `faction_A`='16',`faction_H`='16' WHERE `entry` IN (24039,22912);
UPDATE `gameobject_template` SET `data8` = '11000',`data12` = '1',`data15`='1' WHERE `entry` IN (185577);
UPDATE `creature_template` SET `faction_A`='35',`faction_H`='35',`scriptname` = 'npc_the_soulgrinder' WHERE `entry` IN (23019);
SET @entry :=5000000;
DELETE FROM `creature_template`  WHERE `entry` IN (@entry+10,@entry+11,@entry+12,@entry+13,@entry+14);
INSERT INTO `creature_template` 
VALUES
(@entry+10,'0','0','0','0','0','10045','0','0','0','Soulgrinder Target #1','Visual',NULL,'0','1','80','0','35','35','0','0.91','1.14286','1','0','422','586','0','642','1','2000','2200','1','0','2048','0','0','0','0','0','0','345','509','103','8','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','4','1','0.0125','1','1','0','0','0','0','0','0','0','0','1','0','130','','1'),
(@entry+11,'0','0','0','0','0','10045','0','0','0','Soulgrinder Target #2','Visual',NULL,'0','1','80','0','35','35','0','0.91','1.14286','1','0','422','586','0','642','1','2000','2200','1','0','2048','0','0','0','0','0','0','345','509','103','8','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','4','1','0.0125','1','1','0','0','0','0','0','0','0','0','1','0','130','','1'),
(@entry+12,'0','0','0','0','0','10045','0','0','0','Soulgrinder Target #3','Visual',NULL,'0','1','80','0','35','35','0','0.91','1.14286','1','0','422','586','0','642','1','2000','2200','1','0','2048','0','0','0','0','0','0','345','509','103','8','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','4','1','0.0125','1','1','0','0','0','0','0','0','0','0','1','0','130','','1'),
(@entry+13,'0','0','0','0','0','10045','0','0','0','Soulgrinder Target #4','Visual',NULL,'0','1','80','0','35','35','0','0.91','1.14286','1','0','422','586','0','642','1','2000','2200','1','0','2048','0','0','0','0','0','0','345','509','103','8','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','4','1','0.0125','1','1','0','0','0','0','0','0','0','0','1','0','130','','1'),
(@entry+14,'0','0','0','0','0','10045','0','0','0','Soulgrinder Dummy','Visual',NULL,'0','1','80','0','35','35','0','0.91','1.14286','1','0','422','586','0','642','1','2000','2200','1','0','2048','0','0','0','0','0','0','345','509','103','8','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','4','1','0.0125','1','1','0','0','0','0','0','0','0','0','1','0','130','','1');
UPDATE `item_template` SET `scriptname` = 'item_vimgols_grimoire' WHERE `entry`  IN  (32467);
DELETE FROM `creature` WHERE `id` IN (@entry+10,@entry+11,@entry+12,@entry+13);
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) 
VALUES
(@entry+10,'530','1','1','0','0','3491.77','5528.91','18.0622','0.997415','300','0','0','26','0','0','0','33554432','0'),
(@entry+11,'530','1','1','0','0','3469.42','5581.31','19.9931','5.88021','300','0','0','33','0','0','0','33554432','0'),
(@entry+12,'530','1','1','0','0','3515.04','5525','19.4217','1.26206','300','0','0','51','0','0','0','33554432','0'),
(@entry+13,'530','1','1','0','0','3464.46','5564.1','19.1158','0.0486162','300','0','0','57','0','0','0','33554432','0');
DELETE FROM `gameobject` WHERE `id` =185577;

-- Script named 'npc_apprentice_mirveda' does not have a script name assigned in database.
UPDATE `creature_template` SET `ScriptName`='npc_apprentice_mirveda' WHERE `entry`=15402;

-- Script named 'npc_eris_havenfire' does not have a script name assigned in database.
UPDATE `creature_template` SET `ScriptName`='npc_eris_havenfire' WHERE `entry`=14494;

-- Script named 'npc_pulsing_pumpkin' does not have a script name assigned in database.
-- Script named 'npc_wisp_invis' does not have a script name assigned in database.
UPDATE `creature_template` SET `ScriptName`='npc_pulsing_pumpkin' WHERE `entry` = 23694;
UPDATE `creature_template` SET `ScriptName`='npc_wisp_invis' WHERE `entry` IN (23686, 24034);



-- Reaplicamos Sql no Aplicado 2014_06_30_01_world_misc.sql
-- Script named 'achievement_torch_juggler' does not have a script name assigned in database.
-- ----------------------------------------
-- Achievement - Torch Juggler
-- ----------------------------------------
SET @SPELL_TORCH_CATCH := 45644;
SET @SPELL_THROW_TORCH := 45819;

-- Spell link for Throw Torch with on hit trigger Juggle Torch for the target
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = @SPELL_TORCH_CATCH;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(@SPELL_TORCH_CATCH, 45638, 0, 'Throw Torch with on hit trigger Juggle Torch for the target');
-- Spell link for Throw Torch with on hit trigger Juggle Torch for the target
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 45638;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(45638, 45276, 0, 'Throw Torch with on hit trigger Juggle Torch for the target');
-- Start countdown of achievement and count for it
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 45276;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(45276, 45280, 0, 'Throw Torch with on hit trigger Juggle Torch for the target');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (@SPELL_TORCH_CATCH);
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=@SPELL_TORCH_CATCH;

DELETE FROM `spell_script_names` WHERE `spell_id`=@SPELL_THROW_TORCH;

DELETE FROM `achievement_criteria_data` WHERE `criteria_id` = 6937;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(6937, 16, 341, 0, ''), 
(6937, 11, 0, 0, 'achievement_torch_juggler');

-- Script named 'npc_brewfest_reveler' does not have a script name assigned in database.
UPDATE `creature_template` SET `ScriptName`='npc_brewfest_reveler' WHERE `entry`=24484;

-- Script named 'npc_frostwing_vrykul' does not have a script name assigned in database.
UPDATE `creature_template` SET `ScriptName`='npc_frostwing_vrykul' WHERE `entry` IN (37132,38125,37127,37134,37133);

-- Script named 'npc_nerubar_broodkeeper' does not have a script name assigned in database.
UPDATE `creature_template` SET `ScriptName`='npc_nerubar_broodkeeper' WHERE `entry`=36725;

-- Script named 'npc_ruby_guardian' does not have a script name assigned in database.
UPDATE `creature_template` SET `ScriptName` = 'npc_ruby_guardian' WHERE `entry` IN (27530);

-- Script named 'npc_argent_valiant' does not have a script name assigned in database.
UPDATE `creature_template` SET `ScriptName`='npc_argent_valiant' WHERE `entry`=33448;


