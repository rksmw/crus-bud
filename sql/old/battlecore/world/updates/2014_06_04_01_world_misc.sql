-- -----------------------------------
-- Quest - The Black Knight's Curse
-- -----------------------------------

-- Cult Saboteur SAI
SET @ENTRY := 35116;
UPDATE `creature_template` SET `faction_A`=21 , `faction_H`=21, `unit_flags`=unit_flags|2, `flags_extra`=flags_extra|2, `AIName`='SmartAI' WHERE `entry`=@ENTRY;

DELETE FROM `creature_template_addon` WHERE `entry`=@ENTRY;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(@ENTRY,0,0,0,0,0,'67469');

DELETE FROM `creature` WHERE `id`=@ENTRY;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(NULL,@ENTRY,571,1,1,0,0,8452.67,459.611,596.072,1.07055,300,0,0,12600,0,0,0,0,0);

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,10,0,100,1,0,20,0,0,1,0,6000,0,0,0,0,1,0,0,0,0,0,0,0,'Cult Saboteur - Hostile in LOS - Say text'),
(@ENTRY,0,1,0,52,0,100,1,0,@ENTRY,0,0,1,1,6000,0,0,0,0,1,0,0,0,0,0,0,0,'Cult Saboteur - Text over - Say text'),
(@ENTRY,0,2,0,52,0,100,1,1,@ENTRY,0,0,1,2,6000,0,0,0,0,1,0,0,0,0,0,0,0,'Cult Saboteur - Text over - Say text'),
(@ENTRY,0,3,4,52,0,100,1,2,@ENTRY,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cult Saboteur - Text over - despawn'),
(@ENTRY,0,4,0,61,0,100,1,0,0,0,0,45,0,1,0,0,0,0,19,35127,20,0,0,0,0,0,'Cult Saboteur - Text over - Set data Cult Assassin');

DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"What do you think you're doing?",12,0,100,1,0,0,'Cult Saboteur'),
(@ENTRY,1,0,"You're too late to stop our plan.",12,0,100,1,0,0,'Cult Saboteur'),
(@ENTRY,2,0,"See to it that I'm not followed.",12,0,100,1,0,0,'Cult Saboteur');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@ENTRY AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@ENTRY,0,0,9,0,14016,0,0,0,0,'','SAI - Cult Saboteur start text if player has quest');

-- Cult Assassin SAI
SET @ENTRY := 35127;
UPDATE `creature_template` SET `faction_A`=21 , `faction_H`=21, `AIName`='SmartAI' WHERE `entry`=@ENTRY;

DELETE FROM `creature_template_addon` WHERE `entry`=@ENTRY;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(@ENTRY,0,0,0,0,0,'67469');

DELETE FROM `creature` WHERE `id`=@ENTRY;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(NULL,@ENTRY,571,1,1,0,0,8455.52,459.915,596.072,1.38314,300,0,0,12600,3994,0,0,0,0);

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,25,0,100,1,0,0,0,0,18,131078,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cult Assassin - Reset - Set Unit flags'),
(@ENTRY,0,1,2,61,0,100,1,0,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cult Assassin - Reset - Kneel'),
(@ENTRY,0,2,0,61,0,100,1,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cult Assassin - Reset - react state passive'),
(@ENTRY,0,3,4,38,0,100,1,0,1,0,0,45,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cult Assassin - Data set - Set data'),
(@ENTRY,0,4,5,61,0,100,1,0,0,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cult Assassin - Data set - Stand up'),
(@ENTRY,0,5,0,61,0,100,1,0,0,0,0,1,0,5000,0,0,0,0,1,0,0,0,0,0,0,0,'Cult Assassin - Data set - Say text'),
(@ENTRY,0,6,7,52,0,100,1,0,@ENTRY,0,0,19,131078,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cult Assassin - Text over - Remove unit flags'),
(@ENTRY,0,7,8,61,0,100,1,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cult Assassin - Text over - set react state aggressive'),
(@ENTRY,0,8,0,61,0,100,1,0,0,0,0,49,0,0,0,0,0,0,21,50,0,0,0,0,0,0,'Cult Assassin - Text over - Attack closest player'),
(@ENTRY,0,9,0,0,0,100,0,0,5,9000,12000,11,60842,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cult Assassin - In combat - Cast expose armor'),
(@ENTRY,0,10,0,0,0,100,0,0,5,5000,8000,11,14873,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cult Assassin - In combat - Cast sinister strike'),
(@ENTRY,0,11,0,6,0,100,0,0,0,0,0,85,66785,5,0,0,0,0,7,0,0,0,0,0,0,0,'Cult Assassin - Death - Cast Black Knights Grave Credit');

DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Gladly.",12,0,100,1,0,0,'Cult Assasin');

-- Spell Area to see invisible NPC
DELETE FROM `spell_area` WHERE `spell`=67471;
INSERT INTO `spell_area` (`spell`,`area`,`quest_start`,`quest_start_status`,`quest_end`,`aura_spell`,`racemask`,`gender`,`autocast`) VALUES
(67471,4658,14016,74,14016,0,0,2,1);