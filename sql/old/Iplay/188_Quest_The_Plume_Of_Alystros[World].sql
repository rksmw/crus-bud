-- Quest - The Plume of Alystros
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 0x20000000 WHERE `entry` = 27249;
SET @ALYSTROS := 27249;
SET @GUID := 106352;
SET @CUSTOM := 5000000;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ALYSTROS;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;

DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ALYSTROS;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ALYSTROS AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ALYSTROS*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ALYSTROS,0,0,1,38,0,100,0,0,1,0,0,45,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Alystros - Data set - set data self"),
(@ALYSTROS,0,1,2,61,0,100,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Alystros - Data set - remove emote state"),
(@ALYSTROS,0,2,3,61,0,100,0,0,0,0,0,19,256,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Alystros - On link - Remove unit flags"),
(@ALYSTROS,0,3,4,61,0,100,0,0,0,0,0,97,10,4,0,0,0,0,1,0,0,0,2676.475,-5.636,2.269,0.0,"Alystros - On link - Jump to pos"),
(@ALYSTROS,0,4,0,61,0,100,0,0,0,0,0,80,@ALYSTROS*100,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Alystros - On link - Call timed action"),
(@ALYSTROS,0,5,0,25,0,100,0,0,0,0,0,18,256,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Alystros - Reset - Set unit flags"),
(@ALYSTROS,0,6,0,25,0,100,0,0,0,0,0,17,428,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Alystros - Reset - Set emote state"),
(@ALYSTROS,0,7,0,0,0,100,0,4000,7000,6000,9000,11,51937,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Alystros - In combat - Cast Talon Stryke"),
(@ALYSTROS,0,8,0,0,0,100,0,0,0,16000,21000,11,51938,1,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Alystros - In combat - Cast Wing Beat"),
(@ALYSTROS,0,9,0,0,0,100,0,2500,4000,17000,21000,11,51922,0,0,0,0,0,5,0,0,0,0.0,0.0,0.0,0.0,"Alystros - In combat - Cast Lapsing Dream"),
(@ALYSTROS*100,9,0,0,0,0,100,0,3000,3000,3000,3000,49,0,0,0,0,0,0,21,100,0,0,0.0,0.0,0.0,0.0,"Alystros - On timed action - Attack closest player");

-- call event Go's
DELETE FROM `creature_template` WHERE `entry`=@CUSTOM+14;
INSERT INTO `creature_template` (`entry`,`modelid1`,`name`,`unit_flags`,`flags_extra`,`faction_A`,`faction_H`,`unit_class`,`AIName`) VALUES
(@CUSTOM+14,169,'Alystros Bunny',3355468,128,35,35,1,'SmartAI');

DELETE FROM `smart_scripts` WHERE `entryorguid`=@CUSTOM+14 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@CUSTOM+14,0,0,0,54,0,100,0,0,1,0,0,45,0,1,0,0,0,0,10,@GUID,@ALYSTROS,0,0.0,0.0,0.0,0.0,"Alystros Bunny - just created - set data Alystros");

-- Gameobject range and event script
UPDATE `gameobject_template` SET `data1` = 120 WHERE `entry` = 300208;
DELETE FROM `event_scripts` WHERE `id`=18223;
INSERT INTO `event_scripts` (`id`,`command`,`datalong`,`datalong2`) VALUES
(18223,10,@CUSTOM+14,30000);
