-- [Quest] Congratulations
-- Commander Kunz
SET @ENTRY := 28039;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,19,0,100,0,12596,0,0,0,33,28042,0,0,0,0,0,7,0,0,0,0,0,0,0,'Commander Kunz - On quest accept - Cast Captain Brandon credit (see conditions)'),
(@ENTRY,0,1,0,19,0,100,0,12596,0,0,0,33,28044,0,0,0,0,0,7,0,0,0,0,0,0,0,'Commander Kunz - On quest accept - Cast Captain Rupert credit (see conditions)'),
(@ENTRY,0,2,0,19,0,100,0,12596,0,0,0,33,28043,0,0,0,0,0,7,0,0,0,0,0,0,0,'Commander Kunz - On quest accept - Cast Captain Grondel credit (see conditions)'),
(@ENTRY,0,3,0,19,0,100,0,12596,0,0,0,33,28205,0,0,0,0,0,7,0,0,0,0,0,0,0,'Commander Kunz - On quest accept - Cast Alchemist Finklestein credit (see conditions)'),
(@ENTRY,0,4,0,19,0,100,0,12501,0,0,0,85,51573,2,0,0,0,0,7,0,0,0,0,0,0,0,'Commander Kunz - On quest accept - Invoker cast On Patrol'),
(@ENTRY,0,5,0,19,0,100,0,12563,0,0,0,85,51573,2,0,0,0,0,7,0,0,0,0,0,0,0,'Commander Kunz - On quest accept - Invoker cast On Patrol'),
(@ENTRY,0,6,0,19,0,100,0,12587,0,0,0,85,51573,2,0,0,0,0,7,0,0,0,0,0,0,0,'Commander Kunz - On quest accept - Invoker cast On Patrol');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@ENTRY AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(22,1,@ENTRY,0,8,12597,0,0,0,'','Commander Kunz - Give Brandon credit if Brandon quest rewarded'),
(22,2,@ENTRY,0,8,12598,0,0,0,'','Commander Kunz - Give Rupert credit if Rupert quest rewarded'),
(22,3,@ENTRY,0,8,12599,0,0,0,'','Commander Kunz - Give Grondel credit if Grondel quest rewarded'),
(22,4,@ENTRY,0,8,12557,0,0,0,'','Commander Kunz - Give Finklestein credit if Finklestein quest rewarded');
