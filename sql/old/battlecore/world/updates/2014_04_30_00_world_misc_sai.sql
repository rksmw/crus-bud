-- Quest - Iron Rune Constructs and You: Rocket Jumping
SET @SUMMON := 49985;
SET @GOLEM  := 24806;
SET @RUNE   := 186956;
SET @BENCH  := 186958;

-- Work Bench SAI
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=@BENCH;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@BENCH AND `source_type`=1 AND `id` IN (0,1);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@BENCH,1,0,1,62,0,100,0,9024,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Work Bench - Gossip select - Close gossip'),
(@BENCH,1,1,0,61,0,100,0,0,0,0,0,85,@SUMMON,2,0,0,0,0,7,0,0,0,0,0,0,0,'Work Bench - Gossip select - Summon Iron Rune Construct');

-- Iron Rune Construct SAI
UPDATE `creature_template` SET `spell1`=44498, `AIName`='SmartAI', `InhabitType`=5 WHERE `entry`=@GOLEM;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GOLEM AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@GOLEM,0,0,0,25,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Iron Rune Construct - Just Summoned - Set phase 1'),
(@GOLEM,0,1,2,8,1,100,0,44498,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Iron Rune Construct - Has aura - Say text'),
(@GOLEM,0,2,0,61,0,100,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Iron Rune Construct - Has aura - Set phase 2'),
(@GOLEM,0,3,4,23,2,100,1,44498,0,0,0,60,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Iron Rune Construct - Missing aura (phase 2) - Set fly'),
(@GOLEM,0,4,5,61,0,100,0,0,0,0,0,11,44687,2,0,0,0,0,1,0,0,0,0,0,0,0,'Iron Rune Construct - Missing aura (phase 2) - Cast Rocket jump'),
(@GOLEM,0,5,6,61,0,100,0,0,0,0,0,11,50345,2,0,0,0,0,1,0,0,0,0,0,0,0,'Iron Rune Construct - Missing aura (phase 2) - Cast flight'),
(@GOLEM,0,6,7,61,0,100,0,0,0,0,0,53,1,@GOLEM,0,0,0,0,1,0,0,0,0,0,0,0,'Iron Rune Construct - Missing aura (phase 2) - WP start'),
(@GOLEM,0,7,0,61,0,100,0,0,0,0,0,9,0,0,0,0,0,0,14,65653,@RUNE,0,0,0,0,0,'Iron Rune Construct - Missing aura (phase 2) - Activate Gobject'),
(@GOLEM,0,8,9,40,0,100,0,4,@GOLEM,0,0,15,11485,0,0,0,0,0,23,0,0,0,0,0,0,0,'Iron Rune Construct - Waypoint reached - Explored event happens'),
(@GOLEM,0,9,10,61,0,100,0,0,0,0,0,11,46419,2,0,0,0,0,1,0,0,0,0,0,0,0,'Iron Rune Construct - Waypoint reached - Cast explosion Visual'),
(@GOLEM,0,10,0,61,0,100,0,0,0,0,0,22,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Iron Rune Construct - Waypoint reached - Set phase 3'),
(@GOLEM,0,11,0,1,4,100,1,1000,1000,0,0,28,46598,0,0,0,0,0,1,0,0,0,0,0,0,0,'Iron Rune Construct - OOC (phase 3) - Remove Vehicle aura');

DELETE FROM `creature_text` WHERE `entry`=@GOLEM;	
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@GOLEM,0,0,"Launching...",12,0,100,0,0,0,'Iron Rune Construct');

DELETE FROM `waypoints` WHERE `entry`=@GOLEM;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@GOLEM,1,521.901,-5805.573,416.132,'Iron Rune Construct'),
(@GOLEM,2,897.647,-4857.726,394.965,'Iron Rune Construct'),
(@GOLEM,3,1350.785,-3443.099,217.455,'Iron Rune Construct'),
(@GOLEM,4,1392.497,-3264.311,162.112,'Iron Rune Construct');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=44498;	
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES	
(17,0,44498,0,0,30,0,@RUNE,5,0,0,0,'','Rocket Jump can only be casted near gameobject');
