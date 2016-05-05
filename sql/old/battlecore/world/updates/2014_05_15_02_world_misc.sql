-- Quest - Putting Olakin Back Together Again
SET @ENTRY := 31235;
UPDATE `creature_template` SET `faction_A`=2070, `faction_H`=2070, `AIName`='SmartAI' WHERE `entry`=@ENTRY;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,54,0,100,0,0,0,0,0,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'Crusader Olakin - Just summoned - Run script'),
(@ENTRY*100,9,0,0,0,0,100,0,5000,5000,0,0,91,7,0,0,0,0,0,1,0,0,0,0,0,0,0,'Crusader Olakin - Script - Remove dead bytes'),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,11,58854,2,0,0,0,0,1,0,0,0,0,0,0,0,'Crusader Olakin - Script - Cast Resurrection'),
(@ENTRY*100,9,2,0,0,0,100,0,3000,3000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Crusader Olakin - Script - Say text'),
(@ENTRY*100,9,3,0,0,0,100,0,5000,5000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Crusader Olakin - Script - Say text'),
(@ENTRY*100,9,4,0,0,0,100,0,5000,5000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Crusader Olakin - Script - Say text'),
(@ENTRY*100,9,5,0,0,0,100,0,1000,1000,0,0,33,@ENTRY,0,0,0,0,0,7,0,0,0,0,0,0,0,'Crusader Olakin - Script - Give kill credit'),
(@ENTRY*100,9,6,0,0,0,100,0,7000,7000,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Crusader Olakin - Script - Despawn');

DELETE FROM `creature_template_addon` WHERE `entry`=@ENTRY;
INSERT INTO `creature_template_addon` (`entry`,`bytes1`) VALUES
(@ENTRY,7);

DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES  
(@ENTRY,0,0,'Thank the Light for granting me another chance. And thank you, $n.',12,0,100,1,0,0,'Crusader Olakin'),
(@ENTRY,1,0,'Without your help, I would''ve been doomed to a life of undeath among the Lich King''s gruesome creations.',12,0,100,1,0,0,'Crusader Olakin'),
(@ENTRY,2,0,'There will be time for a proper thanks later, but there is still a battle to be fought!',12,0,100,1,0,0,'Crusader Olakin');

UPDATE `gameobject` SET `phaseMask`=64 WHERE `id`=300237;
DELETE FROM `gameobject` WHERE `id` IN (193092,193091);
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(193091,571,1,64,6666.59, 3269.46,668.809,4.033,0,0,0.902308,-0.431093,300,100,1),
(193092,571,1,64,6591.63, 3151.89,666.691,1.53545,0,0,0.6945,0.719492,300,100,1);

DELETE FROM `event_scripts` WHERE `id`=20269;
INSERT INTO `event_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`x`, `y`, `z`, `o`) VALUES
(20269,0,10,@ENTRY,180000,6635.74,3210.31,668.531,1.19928);
