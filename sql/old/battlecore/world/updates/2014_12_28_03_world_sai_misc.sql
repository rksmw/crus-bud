-- Quest - Alpha Worg
SET @GARWAL := 24277;
SET @ULFANG := 24261;
DELETE FROM `creature` WHERE `id`=@GARWAL;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `curhealth`) VALUES
(@GARWAL,571,1,1,2764.15,-3097.29,110.051,3.31568,600,13936);

DELETE FROM `creature_template_addon` WHERE `entry`=@GARWAL;
INSERT INTO `creature_template_addon` (`entry`,`auras`) VALUES
(@GARWAL,'49415');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ULFANG;
UPDATE `creature_template` SET `faction_A`=14,`faction_H`=14,`AIName`='SmartAI' WHERE `entry`=@GARWAL;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (@GARWAL,@ULFANG);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@GARWAL,0,0,0,0,0,100,0,3000,4000,16000,19000,11,13443,0,0,0,0,0,2,0,0,0,0,0,0,0,'Garwal - In Combat - Cast Rend'),
(@GARWAL,0,1,0,0,0,100,0,8000,8000,25000,27000,11,6749,0,0,0,0,0,2,0,0,0,0,0,0,0,'Garwal - In Combat - Cast Wide Swipe'),
(@GARWAL,0,2,0,0,0,100,0,12000,14000,35000,38000,11,50046,0,0,0,0,0,2,0,0,0,0,0,0,0,'Garwal - In Combat - Cast Gnaw Bone'),
(@GARWAL,0,3,0,2,0,100,1,0,50,0,0,3,@GARWAL+1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Garwal - Below 50% hp - Morph'),
(@GARWAL,0,4,0,25,0,100,0,0,0,0,0,3,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Garwal - Reset - Demorph'),
(@ULFANG,0,0,0,19,0,100,0,11324,0,0,0,11,43682,3,0,0,0,0,7,0,0,0,0,0,0,0,'Ulfang - On quest accept - Cast Eyes of the Eagle Force Cast'),
(@ULFANG,0,1,0,19,0,100,0,11326,0,0,0,11,43682,3,0,0,0,0,7,0,0,0,0,0,0,0,'Ulfang - On quest accept - Cast Eyes of the Eagle Force Cast');

-- Watcher Moonleaf SAI
SET @ENTRY  := 24273;
SET @GOSSIP := 8918;
SET @QUEST1 := 11325;
SET @QUEST2 := 11326;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,62,0,100,0,@GOSSIP,0,0,0,85,43379,0,0,0,0,0,7,0,0,0,0,0,0,0,'Watcher Moonleaf - Gossip select - Cast Create Worg disguise'),
(@ENTRY,0,1,0,61,0,100,0,@GOSSIP,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Watcher Moonleaf - Gossip select - close gossip');

DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP;
INSERT INTO `gossip_menu_option`(`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(@GOSSIP,0,0,'I took off the worg mask.',1,1,0,0,0,0,'');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15,@GOSSIP,0,0,0,8,0,@QUEST1,0,0,0,0,'','Show gossip option if player has quest 11325 rewarded'),
(15,@GOSSIP,0,0,0,8,0,@QUEST2,0,0,1,0,'','Show gossip option if player has quest 11326 not rewarded'),
(15,@GOSSIP,0,0,0,2,0,33618,1,1,1,0,'','Show gossip option if not Worg Disguise in bags');

-- Sage Mistwalker SAI
SET @ENTRY  := 24186;
SET @GOSSIP := 8908;
SET @QUEST1 := 11323;
SET @QUEST2 := 11324;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,62,0,100,0,@GOSSIP,0,0,0,85,43379,0,0,0,0,0,7,0,0,0,0,0,0,0,'Sage Mistwalker - Gossip select - Cast Create Worg disguise'),
(@ENTRY,0,1,0,61,0,100,0,@GOSSIP,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Sage Mistwalker - Gossip select - close gossip');

DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP;
INSERT INTO `gossip_menu_option`(`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(@GOSSIP,0,0,'I took off the worg mask.',1,1,0,0,0,0,'');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15,@GOSSIP,0,0,0,8,0,@QUEST1,0,0,0,0,'','Show gossip option if player has quest 11323 rewarded'),
(15,@GOSSIP,0,0,0,8,0,@QUEST2,0,0,1,0,'','Show gossip option if player has quest 11324 not rewarded'),
(15,@GOSSIP,0,0,0,2,0,33618,1,1,1,0,'','Show gossip option if not Worg Disguise in bags');
