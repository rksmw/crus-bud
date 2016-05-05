-- Quest - On Ruby Wings
SET @DRAGON := 27996;
SET @GIANT := 28018;
SET @ANTIOK := 28006;
UPDATE `creature_template` SET `spell1`=50430, `spell2`=55987, `spell3`=50348, `InhabitType`=5 WHERE `entry`=@DRAGON;
DELETE FROM `creature_template_addon` WHERE `entry`=@DRAGON;
INSERT INTO `creature_template_addon` (`entry`,`bytes1`,`auras`) VALUES
(@DRAGON,33554432,'53112');

-- Thiassi the Lightning Bringer SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@GIANT;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GIANT AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@GIANT,0,0,0,0,0,100,0,5000,5000,12000,14000,11,50456,0,0,0,0,0,2,0,0,0,0,0,0,0,'Thiassi the Lightning Bringer - In combat - Cast Thiassi''s Stormbolt'),
(@GIANT,0,1,0,0,0,100,0,9000,9000,15000,19000,11,15593,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thiassi the Lightning Bringer - In combat - Cast War Stomp'),
(@GIANT,0,2,3,6,0,100,0,0,0,0,0,12,@ANTIOK,3,200000,0,0,0,1,0,0,0,0,0,0,0,'Thiassi the Lightning Bringer - Death - Summon Antiok'), -- esto es medio hack, en realidad es un addon del vehiculo pero desaparece cuando muere, aunque le quites el minion
(@GIANT,0,3,0,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,19,@ANTIOK,40,0,0,0,0,0,'Thiassi the Lightning Bringer - Death - Set data Antiok');

-- Grand Necrolord Antiok
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ANTIOK;
DELETE FROM `creature_template_addon` WHERE `entry`=@ANTIOK;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ANTIOK;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ANTIOK,0,0,0,0,0,100,0,5000,5000,12000,12000,11,50455,0,0,0,0,0,2,0,0,0,0,0,0,0,'Grand Necrolord Antiok - In combat - Cast Shadow Bolt'),
(@ANTIOK,0,1,0,0,0,100,0,9000,9000,35000,45000,11,32863,0,0,0,0,0,5,0,0,0,0,0,0,0,'Grand Necrolord Antiok - In combat - Cast Seed of Corruption'),
(@ANTIOK,0,2,0,0,0,100,0,15000,15000,25000,29000,11,50497,0,0,0,0,0,1,0,0,0,0,0,0,0,'Grand Necrolord Antiok - In combat - Cast Scream of Chaos'),
(@ANTIOK,0,3,0,38,0,100,0,0,1,0,0,1,0,5000,0,0,0,0,1,0,0,0,0,0,0,0,'Grand Necrolord Antiok - Data set - Say text'),
(@ANTIOK,0,4,5,52,0,100,0,0,@ANTIOK,0,0,28,50494,0,0,0,0,0,1,0,0,0,0,0,0,0,'Grand Necrolord Antiok - Text over - Remove Immunity aura'),
(@ANTIOK,0,5,6,61,0,100,0,0,0,0,0,11,50501,0,0,0,0,0,19,@DRAGON,30,0,0,0,0,0,'Grand Necrolord Antiok - Text over - Cast Flesh Harvest'),
(@ANTIOK,0,6,0,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,21,30,0,0,0,0,0,0,'Grand Necrolord Antiok - Text over - Attack Closest player'),
(@ANTIOK,0,7,0,6,0,100,0,0,0,0,0,11,50472,0,0,0,0,0,1,0,0,0,0,0,0,0,'Grand Necrolord Antiok - Death - Cast Drop Scythe of Antiok');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=50501;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,1,50501,0,0,31,0,3,@DRAGON,0,0,0,'','Flesh Harvest - Implicit target - Wyrmrest Vanquisher'),
(13,2,50501,0,0,31,0,3,@DRAGON,0,0,0,'','Flesh Harvest - Implicit target - Wyrmrest Vanquisher');

DELETE FROM `creature_text` WHERE `entry`=@ANTIOK;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ANTIOK,0,0,'You think you''ve won, mortal? Face the unbridled power of Antiok!',14,0,100,0,0,0, 'Grand Necrolord Antiok');
