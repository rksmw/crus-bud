UPDATE `creature_template` SET `scriptname` = 'npc_bladespire_raptor' WHERE `entry` = '20728';
UPDATE `creature_template` SET `scriptname` = 'npc_bladespire_shaman' WHERE `entry` = '19998';
UPDATE `creature_template` SET `scriptname` = 'npc_bladespire_champion' WHERE `entry` = '21296';
UPDATE `creature_template` SET `scriptname` = 'npc_bladespire_cook' WHERE `entry` = '20334';
UPDATE `creature_template` SET `scriptname` = 'npc_stronglimb_seeproot' WHERE `entry` = '21023';
UPDATE `creature_template` SET `scriptname` = 'npc_bladewing_bloodletter' WHERE `entry` = '21033';
UPDATE `creature_template` SET `scriptname` = 'npc_fey_drake' WHERE `entry` = '20713';
UPDATE `creature_template` SET `scriptname` = 'npc_thunderlord_dire_wolf', `AIname`='' WHERE entry = '20748';
-- UPDATE `quest_template` SET `requiredspellcast1` = '0' WHERE `id` = '10488';
-- Textos
DELETE FROM `creature_text` WHERE `entry` =22911;
INSERT INTO `creature_text` VALUES
('22911','0','0',"You dare summon me?",'14','0','0','0','0','0','SAY_00'),
('22911','1','0',"Now me grow bigger and crush you!",'14','0','0','0','0','0','SAY_01');
-- Scipt Name + Inmunidades a Vimgol The Vile
UPDATE `creature_template` SET `scriptname` = 'npc_vimgol_the_vile' WHERE `entry` = '22911';
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
|67108864 -- DAZE
|536870912 -- SAPPED
WHERE `entry` = 22911;
UPDATE `gameobject_template` SET `data8` = '10998',`data12` = '1',`data15`='1' WHERE `entry` = 185562;
SET @entry :=5000000;
DELETE FROM `creature_template`  WHERE `entry` = @entry+7;
INSERT INTO `creature_template` VALUES(@entry+7,'0','0','0','0','0','10045','0','0','0',"Summon Vim'gol the Vile",'Visual',NULL,'0','1','80','0','35','35','0','0.91','1.14286','1','0','422','586','0','642','1','2000','2200','1','0','2048','0','0','0','0','0','0','345','509','103','8','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','4','1','0.0125','1','1','0','0','0','0','0','0','0','0','1','0','130','npc_summon_vimgol','1');
DELETE FROM `creature` WHERE `id` = @entry+7;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) 
VALUES
(@entry+7,'530','1','1','0','0','3257.16','4653.67','214.631','6.09265','300','0','0','8','0','0','0','33554432','0'),
(@entry+7,'530','1','1','0','0','3279.22','4664.41','214.161','4.70422','300','0','0','17','0','0','0','33554432','0'),
(@entry+7,'530','1','1','0','0','3304.48','4644.04','214.64','3.31799','300','0','0','1','0','0','0','33554432','0'),
(@entry+7,'530','1','1','0','0','3292.78','4620.01','214.644','2.2577','300','0','0','63','0','0','0','33554432','0'),
(@entry+7,'530','1','1','0','0','3262.04','4625.51','214.545','0.76309','300','0','0','27','0','0','0','33554432','0');
