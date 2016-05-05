-- Quest - Let's Go Surfing Now!
SET @ENTRY := 27924;
UPDATE `creature_template` SET `AIName`='SmartAI', `InhabitType`=4 WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,27,0,100,0,0,0,0,0,53,1,@ENTRY,0,0,0,0,1,0,0,0,0,0,0,0,'Dragonflayer Harpoon - Passenger Boarded - Waypoint start'),
(@ENTRY,0,1,2,40,0,100,0,1,@ENTRY,0,0,15,11436,0,0,0,0,0,7,0,0,0,0,0,0,0,'Dragonflayer Harpoon - Waypoint reached - Explored event happens'),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Dragonflayer Harpoon - Waypoint reached - Despawn');

DELETE FROM `creature_template_addon` WHERE `entry`=@ENTRY;
INSERT INTO `creature_template_addon` (`entry`,`auras`) VALUES
(@ENTRY,'44140');

DELETE FROM `waypoints` WHERE `entry`=@ENTRY;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@ENTRY,1,625.203,-5029.772,2.5283,'Dragonflayer Harpoon');

-- Fix large Vrykul Harpoon Gun
UPDATE `creature` SET `MovementType`=0, `spawndist`=0 WHERE `id`=24701;
