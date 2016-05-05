-- Quest - Rescue from Town Square
SET @VILLAGER := 27359;
SET @GEIST := 27370;
SET @QUEST := 12253;

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@VILLAGER;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@VILLAGER AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@VILLAGER,0,0,1,10,0,100,1,1,5,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Trapped Wintergarde Villager - Move in LOS - Say text (see conditions)'),
(@VILLAGER,0,1,2,61,0,100,1,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Trapped Wintergarde Villager - Move in LOS - Remove emote state'),
(@VILLAGER,0,2,3,61,0,100,1,0,0,0,0,33,@VILLAGER,0,0,0,0,0,7,0,0,0,0,0,0,0,'Trapped Wintergarde Villager - Move in LOS - Give quest credit'),
(@VILLAGER,0,3,0,61,0,100,1,0,0,0,0,41,7000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Trapped Wintergarde Villager - Move in LOS - Despawn in 7 seconds');

DELETE FROM `creature_text` WHERE `entry`=@VILLAGER;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@VILLAGER,0,0,"Finally! A hero has come!",12,0,100,1,0,0,'Trapped Wintergarde Villager'),
(@VILLAGER,0,1,"Good of you to come, champion! The beast almost had me!",12,0,100,1,0,0,'Trapped Wintergarde Villager'),
(@VILLAGER,0,2,"I'll never forget you, friend.",12,0,100,1,0,0,'Trapped Wintergarde Villager'),
(@VILLAGER,0,3,"Thank you, kind soul.",12,0,100,1,0,0,'Trapped Wintergarde Villager');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@VILLAGER AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@VILLAGER,0,0,9,0,@QUEST,0,0,0,0,'','SAI - Trapped Wintergarde Villager say text if player has quest'),
(22,1,@VILLAGER,0,0,29,1,@GEIST,5,0,1,0,'','SAI - Trapped Wintergarde Villager say text if not Geist at 5 yards');
