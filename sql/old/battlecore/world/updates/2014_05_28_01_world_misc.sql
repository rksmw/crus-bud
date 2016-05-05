-- Quest - It Goes to 11
UPDATE `creature_template` SET `spell1`=44213, `spell2`=43997, `speed_walk`=0, `speed_run`=0 WHERE `entry`=27992;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=50331;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,1,50331,0,0,31,0,3,27992,0,0,0, '', 'Vrykul Harpoon Control - Implicit target - Vrykul Harpoon Gun');

-- Credit for houses
SET @LONGHOUSE := 24538;
SET @DOCKHOUSE := 24646;
SET @STORG_FAC := 24647;
SET @DEFENDER := 24533;
DELETE FROM `spell_script_names` WHERE `spell_id`=44214;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(44214,'spell_q11421_fiery_harpoon');

DELETE FROM `creature_text` WHERE `entry` IN (@LONGHOUSE,@DOCKHOUSE,@STORG_FAC);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@LONGHOUSE,0,0,"The longhouse is destroyed! Alarms can be heard in the distance.",42,0,100,0,0,0,'Dragonflayer Installation I'),
(@DOCKHOUSE,0,0,"The dockhouse is destroyed! Alarms can be heard in the distance.",42,0,100,0,0,0,'Dragonflayer Installation II'),
(@STORG_FAC,0,0,"The storage facility is destroyed! Alarms can be heard in the distance.",42,0,100,0,0,0,'Dragonflayer Installation III');

-- Dragonflayer Defender SAI
UPDATE `creature_template` SET `AIName`='SmartAI', `InhabitType`=4, `RegenHealth`=0 WHERE `entry`=@DEFENDER;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@DEFENDER AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@DEFENDER,0,0,0,37,0,100,0,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,'Dragonflayer Defender - AI Init - Disable combat move'),
(@DEFENDER,0,1,0,38,0,100,0,0,1,0,0,53,1,@DEFENDER*10,0,0,0,2,1,0,0,0,0.0,0.0,0.0,0.0,'Dragonflayer Defender - Data set - Waypoint start'),
(@DEFENDER,0,2,0,38,0,100,0,0,2,0,0,53,1,@DEFENDER*10+1,0,0,0,2,1,0,0,0,0.0,0.0,0.0,0.0,'Dragonflayer Defender - Data set - Waypoint start'),
(@DEFENDER,0,3,0,38,0,100,0,0,3,0,0,53,1,@DEFENDER*10+2,0,0,0,2,1,0,0,0,0.0,0.0,0.0,0.0,'Dragonflayer Defender - Data set - Waypoint start'),
(@DEFENDER,0,4,5,40,0,100,0,1,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,'Dragonflayer Defender - Point reached - set home position'),
(@DEFENDER,0,5,0,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,19,27992,100,0,0.0,0.0,0.0,0.0,'Dragonflayer Defender - Point reached - attack Vrykull harpoon gun'),
(@DEFENDER,0,6,0,7,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,'Dragonflayer Defender - Evade - Despawn'),
(@DEFENDER,0,7,0,0,0,100,0,0,1000,5000,7000,11,44188,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,'Dragonflayer Defender - In combat - Cast Throw Harpoon'),
(@DEFENDER,0,8,0,8,0,50,0,43997,0,0,0,85,50339,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,'Dragonflayer Defender - Spellhit (50% chance) - Cast Dragonflayer Harpoon');

DELETE FROM `creature_template_addon` WHERE `entry`=@DEFENDER;
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`) VALUES
(@DEFENDER,22657,50331648);

DELETE FROM `waypoints` WHERE `entry` BETWEEN @DEFENDER*10 AND @DEFENDER*10+2;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@DEFENDER*10,1,988.151855,-5290.867676,184.269058,'Dragonflayer Defender'),
(@DEFENDER*10+1,1,1011.832520,-5300.576660,184.269058,'Dragonflayer Defender'),
(@DEFENDER*10+2,1,995.252869,-5295.444336,194.461594,'Dragonflayer Defender');
