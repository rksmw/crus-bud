-- Quest - Chasing Icestorm: Thel'zan's Phylactery
-- Icestorm SAI
SET @ENTRY  := 26287;
SET @SPELL1 := 47425; -- Frost Breath
SET @SPELL2 := 49695; -- Summon Thel'zan's Phylactery
UPDATE `creature_template` SET `AIName`= 'SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid`=@ENTRY*100;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,63,0,100,0,0,0,0,0,3,0,24165,0,0,0,0,1,0,0,0,0,0,0,0,'Icestorm - Just created - set model'),
(@ENTRY,0,1,2,61,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Icestorm - Just created - react passive'),
(@ENTRY,0,2,3,61,0,100,0,0,0,0,0,18,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Icestorm - Just created - set unit flags'),
(@ENTRY,0,3,4,61,0,100,0,0,0,0,0,60,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Icestorm - Just created - turn fly on'), 
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,53,1,@ENTRY*100,0,0,0,0,1,0,0,0,0,0,0,0,'Icestorm - Just created - load path'),
(@ENTRY,0,5,0,0,0,100,0,1000,3000,3000,5000,11,@SPELL1,0,0,0,0,0,5,0,0,0,0,0,0,0,'Icestorm - Combat - Cast Frost Breath'),
(@ENTRY,0,6,0,6,0,100,0,0,0,0,0,11,@SPELL2,3,0,0,0,0,1,0,0,0,0,0,0,0,'Icestorm - On death - Cast Summon Thel''zan''s Phylactery'),
(@ENTRY,0,7,8,40,0,100,0,2,@ENTRY*100,0,0,60,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Wyrmbait - reach waypoint 2 - Fly off'),
(@ENTRY,0,8,0,61,0,100,0,0,0,0,0,91,2,3,0,0,0,0,1,0,0,0,0,0,0,0,'Icestorm - reach waypoint 2 - Remove hover'),
(@ENTRY,0,9,10,40,0,100,0,3,@ENTRY*100,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Icestorm - reach waypoint 3 - react agressive'),
(@ENTRY,0,10,11,61,0,100,0,0,0,0,0,19,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Icestorm - reach waypoint 3 - remove unit flags'),
(@ENTRY,0,11,0,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,11,27843,100,0,0,0,0,0,'Wyrmbait - reach waypoint 3 - set data');

-- waypoints for Icestorm
DELETE FROM `waypoints` WHERE `entry` IN (@ENTRY*100,@ENTRY*100+1); 
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@ENTRY*100,3,4543.458,46.66932,82.14817, 'Icestorm'),
(@ENTRY*100,2,4543.821,45.72195,104.5742, 'Icestorm'),
(@ENTRY*100,1,4551.378,94.04321,127.0742, 'Icestorm');

-- Update Model info for Icestorm
UPDATE `creature_model_info` SET `bounding_radius`=1.5,`combat_reach`=7.5 WHERE `modelid`=16919;
DELETE FROM `creature_model_info` WHERE `modelid`=24165;
INSERT INTO `creature_model_info` (`modelid`,`bounding_radius`,`combat_reach`,`gender`) VALUES
(24165,1.5,7.5,2);

-- Add creature_template_addon for Icestorm
DELETE FROM `creature_template_addon` WHERE `entry`=26287;
INSERT INTO `creature_template_addon` (`entry`,`bytes1`,`bytes2`) VALUES (26287,50331648,1);

-- 7th Legion Harpoon Gun SAI
SET @ENTRY  := 27839;
SET @SPELL1 := 49679; -- Harpoon Chain
SET @SPELL2 := 49682; -- Harpoon Chain
SET @SPELL3 := 49683; -- Harpoon Chain
SET @SPELL4 := 49684; -- Harpoon Chain

UPDATE `creature_template` SET `AIName`= 'SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,1,100,0,2000,2000,2000,2000,11,@SPELL1,0,0,0,0,0,11,26287,100,0,0,0,0,0,'7th Legion Harpoon Gun - OOC - Cast spell (phase 1)'),
(@ENTRY,0,1,0,38,0,100,0,0,1,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'7th Legion Harpoon Gun - on dataset 0 1 - set phase 1');

-- Spell Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (49679,49682,49683,49684);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,49679,0,31,3,26287,0,0,'','Spell 49679 can only target Icestorm'),
(13,1,49682,0,31,3,26287,0,0,'','Spell 49682 can only target Icestorm'),
(13,1,49683,0,31,3,26287,0,0,'','Spell 49683 can only target Icestorm'),
(13,1,49684,0,31,3,26287,0,0,'','Spell 49684 can only target Icestorm');

-- Gossip option
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (9603);
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(9603,0,0,"Wyrmbait, eh? Welp, go fetch us Icestorm!",1,1,0,0,0,0,'');

-- Conditions for the gossip options

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (15) AND `SourceGroup` IN (9603);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`comment`) VALUES
(15,9603,0,0,9,12467,'Gossip option 0 requires quest 12467 active');

-- Wyrmbait SAI
SET @ENTRY  := 27843;
SET @SPELL1 := 15620; -- Shoot
UPDATE `creature_template` SET `AIName`= 'SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid` IN (@ENTRY*100,@ENTRY*100+1);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,62,0,100,0,9603,0,0,0,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'Wyrmbait - gossip option select - Run Script'),
(@ENTRY,0,1,0,0,0,100,1,0,0,0,0,39,100,0,0,0,0,0,1,0,0,0,0,0,0,0,'Wyrmbait - combat - call for help'),
(@ENTRY,0,2,0,0,0,100,0,0,1000,1000,3000,11,@SPELL1,0,0,0,0,0,2,0,0,0,0,0,0,0,'Wyrmbait - combat - cast shoot'),
(@ENTRY,0,3,0,25,0,100,0,0,0,0,0,82,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Wyrmbait - on reset - add npcflag'),
(@ENTRY,0,4,0,40,0,100,0,3,@ENTRY*100,0,0,12,26287,6,14000,0,1,0,8,0,0,0,4551.378,94.04321,127.0742,4.939622,'Wyrmbait - reach waypoint 3 - spawn Icestorm'),
(@ENTRY,0,5,0,40,0,100,0,4,@ENTRY*100,0,0,60,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Wyrmbait - reach waypoint 4 - turn fly off'),
(@ENTRY,0,6,0,40,0,100,0,5,@ENTRY*100,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,1.67552,'Wyrmbait - reach waypoint 5 - turn to'),
(@ENTRY,0,7,8,38,0,100,0,0,1,0,0,18,32768,0,0,0,0,0,1,0,0,0,0,0,0,0,'7th Legion Harpoon Gun - on dataset 0 1 - run script'),
(@ENTRY,0,8,0,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,11,26287,100,0,0,0,0,0,'Wyrmbait - script - attack start'),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Wyrmbait - script - close gossip'),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,18,33280,0,0,0,0,0,1,0,0,0,0,0,0,0,'Wyrmbait - script - set unit flags'),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,83,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Wyrmbait - script - remove npc flag'),
(@ENTRY*100,9,3,0,0,0,100,0,500,500,0,0,5,66,0,0,0,0,0,1,0,0,0,0,0,0,0,'Wyrmbait - script - emote'),
(@ENTRY*100,9,4,0,0,0,100,0,4000,4000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Wyrmbait - script - say 0'),
(@ENTRY*100,9,5,0,0,0,100,0,5000,5000,0,0,60,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Wyrmbait - script - turn fly on'),
(@ENTRY*100,9,6,0,0,0,100,0,0,0,0,0,53,1,@ENTRY*100,0,0,0,0,1,0,0,0,0,0,0,0,'Wyrmbait - script - load path'),
(@ENTRY*100,9,7,0,0,0,100,0,0,0,0,0,45,0,1,0,0,0,0,11,27839,100,0,0,0,0,0,'Wyrmbait - script - set data on 7th Legion Harpoon Gun');

-- waypoints for Wyrmbait
DELETE FROM `waypoints` WHERE `entry` IN (@ENTRY*100,@ENTRY*100+1,@ENTRY*100+2); 
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@ENTRY*100,1,4534.954,32.78271,88.17386, 'Wyrmbait'),
(@ENTRY*100,2,4537.267,76.02501,97.88784, 'Wyrmbait'),
(@ENTRY*100,3,4541.015,34.2519,88.31277, 'Wyrmbait'),
(@ENTRY*100,4,4548.401,3.602159,71.40673, 'Wyrmbait'),
(@ENTRY*100,5,4548.401,3.60216,70.40673, 'Wyrmbait');

-- NPC talk text insert from sniff
DELETE FROM `creature_text` WHERE `entry`=27843;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(27843,0,0, 'I''ll flush her out, $N! You just be ready for her when she comes in!',12,0,100,1,0,0, 'Wyrmbait');
