-- Doomguard Commander SAI
SET @ENTRY := 12396;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,8000,18000,24000,11,16005,0,0,0,0,0,5,0,0,0,0,0,0,0, "Doomguard Commander - In Combat - Cast Rain of Fire"),
(@ENTRY,0,1,0,0,0,100,0,12000,15000,20000,25000,11,16727,1,0,0,0,0,1,0,0,0,0,0,0,0, "Doomguard Commander - In Combat - Cast War Stomp"),
(@ENTRY,0,2,0,0,0,100,0,2000,4000,25000,32000,11,20812,1,0,0,0,0,2,0,0,0,0,0,0,0, "Doomguard Commander - In Combat - Cast Cripple"),
(@ENTRY,0,3,0,0,0,100,0,7000,14000,17000,22000,11,15090,0,0,0,0,0,1,0,0,0,0,0,0,0, "Doomguard Commander - In Combat - Cast Dispel Magic"),
(@ENTRY,0,4,5,8,0,100,0,23019,0,18000,18000,50,179644,300000,0,0,0,0,1,0,0,0,0,0,0,0, "Doomguard Commander - Spawn Imprisoned Doomguard"),
(@ENTRY,0,5,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, "Doomguard Commander - Despawn");

-- Conditions for Glowing Crystal Prison 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=23015;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17,0,23015,0,0,31,1,3,12396,0,0,173,0,'','Glowing Crystal Prison target limit to Doomguard Commander');
