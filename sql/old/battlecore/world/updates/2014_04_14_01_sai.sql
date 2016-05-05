-- Quest - Gauging the Resonant Frequency
SET @ENTRY := 21760;
SET @GO := 184926;
SET @SPELL := 37697;
SET @ITEM := 37390;

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,54,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Oscillating Frequency Scanner Master - Just Summoned - Store target'),
(@ENTRY,0,1,2,61,0,100,0,0,0,0,0,50,@GO,210,0,0,0,0,1,0,0,0,0,0,0,0,'Oscillating Frequency Scanner Master - Just Summoned - Summon GO'),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Oscillating Frequency Scanner Master - Just Summoned - Set phase 1'),
(@ENTRY,0,3,0,8,31,100,0,@SPELL,0,0,0,23,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Oscillating Frequency Scanner Master - Spellhit - Increase phase'), -- cada vez q le pega un rayo aumenta de fase
(@ENTRY,0,4,0,1,31,100,0,100,100,100,100,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Oscillating Frequency Scanner Master - Update OOC - set phase 1'), -- si esta 100 milisegundos en fase 1,2,3 o 4 vuelve a la 1
(@ENTRY,0,5,0,1,32,100,1,0,0,0,0,15,10594,0,0,0,0,0,12,1,0,0,0,0,0,0,'Oscillating Frequency Scanner Master - Update OOC - complete quest'); -- si llega a fase 5 te completa la quest

DELETE FROM `creature_template_addon` WHERE `entry`=@ENTRY;
INSERT INTO `creature_template_addon` (`entry`,`auras`) VALUES
(@ENTRY,'37418'); 

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=@SPELL;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,1,@SPELL,0,0,31,0,3,@ENTRY,0,0,0,'','Top Bunny Beam Test Visual - Implicit Target - Oscillating Frequency Scanner Master');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=@ITEM;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17,0,@ITEM,0,0,30,0,@GO,25,0,1,0,'','Oscillating Frequency Scanner cannot be casted if go at 25 yards');
