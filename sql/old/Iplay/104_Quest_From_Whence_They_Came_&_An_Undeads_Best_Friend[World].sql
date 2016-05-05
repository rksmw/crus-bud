-- Quests - From Whence They Came - An Undead's Best Friend
SET @WATCHER := 31110;
SET @CRYSTAL := 31131;
SET @MEAT := 31119;
SET @HOUND := 30952;
UPDATE `creature_template` SET `minlevel`=80, `maxlevel`=80, `spell1`=58541, `spell2`=58544, `spell3`=58543, `spell4`=58562, `spell6`=58658 WHERE `entry`=@WATCHER;

-- Containment Crystal
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@CRYSTAL;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@CRYSTAL AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@CRYSTAL,0,0,1,8,0,100,0,58662,0,0,0,33,@CRYSTAL,0,0,0,0,0,7,0,0,0,0,0,0,0,'Containment Crystal - Spellhit - Give Kill credit'),
(@CRYSTAL,0,1,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Containment Crystal - Despawn');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=58658;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`Comment`) VALUES
(13,1,58658,0,31,3,@CRYSTAL,'Banish Scourge Crystal - Implicit Target - Containment Crystal');

-- Bloody Meat
UPDATE `creature_template` SET `unit_flags`=unit_flags|33554432, `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@MEAT;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@MEAT AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@MEAT,0,0,1,54,0,100,0,0,0,0,0,33,@MEAT,0,0,0,0,0,7,0,0,0,0,0,0,0,'Bloody Meat - Just summoned - Give kill credit'),
(@MEAT,0,1,0,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,19,@HOUND,5,0,0,0,0,0,'Bloody Meat - Just summoned - Set data Hungering Plaguehound');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@MEAT AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTarget`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`Comment`) VALUES
(22,1,@MEAT,1,29,@HOUND,5,'Bloody Meat - Activate SAI if near Hungering Plaguehound');

-- Hungering Plaguehound
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@HOUND;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@HOUND AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@HOUND,0,0,1,38,0,100,0,0,1,0,0,41,4000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Hungering Plaguehound - Data set - Despawn in 4 secs'),
(@HOUND,0,1,2,61,0,100,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Hungering Plaguehound - Data set - React passive'),
(@HOUND,0,2,3,61,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Hungering Plaguehound - Data set - Evade');
