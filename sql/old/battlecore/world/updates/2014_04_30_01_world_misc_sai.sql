-- Quest - Iron Rune Constructs and You: The Bluff
SET @DWARF := 24718;
SET @GOLEM := 24823;
SET @BENCH  := 186958;
SET @SUMMON := 49989;
SET @QUEST := 11491;

-- Work Bench SAI
DELETE FROM `smart_scripts` WHERE `entryorguid`=@BENCH AND `source_type`=1 AND `id` IN (4,5);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@BENCH,1,4,5,62,0,100,0,9024,2,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Work Bench - Gossip select - Close gossip'),
(@BENCH,1,5,0,61,0,100,0,0,0,0,0,85,@SUMMON,2,0,0,0,0,7,0,0,0,0,0,0,0,'Work Bench - Gossip select - Summon Iron Rune Construct');

-- Lebronski SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@DWARF;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = @DWARF;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@DWARF,0,0,0,25,0,100,0,0,0,0,0,53,0,@DWARF,1,0,0,0,1,0,0,0,0,0,0,0,"Lebronski - Reset - WP start"),
(@DWARF,0,1,2,8,0,100,0,44562,0,15000,15000,45,0,1,0,0,0,0,7,0,0,0,0,0,0,0,"Lebronski - Spellhit - set data"),
(@DWARF,0,2,3,61,0,100,0,0,0,0,0,54,15000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lebronski - Spellhit - pause waypoint"),
(@DWARF,0,3,0,61,0,100,0,0,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Lebronski - Spellhit - turn");

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@DWARF);
UPDATE `creature` SET `MovementType`=0 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
DELETE FROM `waypoint_data` WHERE `id`=@GUID*10;
DELETE FROM `waypoints` WHERE `entry`=@DWARF;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@DWARF,1,484.572,-5917.3,308.676,'Lebronski'),
(@DWARF,2,488.253,-5919.57,308.657,'Lebronski');

DELETE FROM `creature_text` WHERE `entry`=@DWARF;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(@DWARF,0,0,"What do you think you're doing, man? Lebronski does NOT appreciate you dragging your loose metal parts all over his rug.",12,0,100,1,0,0,'Lebronski'),
(@DWARF,1,0,"Far out, man. This bucket of bolts might make it after all...",12,0,100,1,0,0,'Lebronski');

-- Iron Rune Construct SAI
UPDATE `creature_template` SET `spell1`=44562, `AIName`='SmartAI' WHERE `entry`=@GOLEM;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GOLEM AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GOLEM*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@GOLEM,0,0,0,38,0,100,0,0,1,0,0,80,@GOLEM*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'Iron Rune Construct - Data set - Run script'),
(@GOLEM*100,9,0,0,0,0,100,0,1000,1000,0,0,1,0,0,0,0,0,0,10,@GUID,@DWARF,0,0,0,0,0,'Iron Rune Construct - Data set - Run script'),
(@GOLEM*100,9,1,0,0,0,100,0,5000,5000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Iron Rune Construct - Data set - Run script'),
(@GOLEM*100,9,2,0,0,0,100,0,5000,5000,0,0,1,1,0,0,0,0,0,10,@GUID,@DWARF,0,0,0,0,0,'Iron Rune Construct - Data set - Run script'),
(@GOLEM*100,9,3,0,0,0,100,0,1000,1000,0,0,15,@QUEST,0,0,0,0,0,23,0,0,0,0,0,0,0,'Iron Rune Construct - Data set - Run script');

DELETE FROM `creature_text` WHERE `entry`=@GOLEM;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(@GOLEM,0,0,"Model U-9207 Iron Rune Construct does not appreciate your tone of voice. Commencing total annihilation of your rug, Lebronski.",12,0,100,0,0,0,'Iron Rune Construct');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=44562;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,1,44562,0,0,31,0,3,@DWARF,0,0,0,'','Bluff - Implicit target - Lebronski');
