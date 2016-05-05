-- Quest - Gorgrom the Dragon-Eater
SET @ENTRY := 21514;
SET @BEAR := 22498;
UPDATE `event_scripts` SET `x`=3625.13, `y`=7161.64, `z`=141.7747 WHERE `id` IN (14400,14536) AND `datalong`=@ENTRY;
UPDATE `event_scripts` SET `datalong`=@BEAR, `datalong2`=30000, `o`=5.485304 WHERE `id`=14400 AND `datalong`!=@ENTRY;
-- UPDATE `quest_template` SET `RequiredSpellCast1`=0 WHERE `Id`=10802; -- por esto no contaba cada vez que ponias un totem XD
DELETE FROM `gameobject` WHERE `id`= 300243;
UPDATE `gameobject_template` SET `data1`=30 WHERE `entry`=300243;
UPDATE `creature_template` SET `unit_flags`=unit_flags|128|512, `AIName`='SmartAI' WHERE `entry`=@ENTRY;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@BEAR;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@BEAR) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,54,0,100,0,0,0,0,0,1,0,3000,0,0,0,0,1,0,0,0,0,0,0,0,'Gorgrom - Just Summoned - Say text'),
(@ENTRY,0,1,0,52,0,100,0,0,@ENTRY,0,0,69,1,0,0,0,0,0,8,0,0,0,3610.205,7181.468,139.8896,0,'Gorgrom - Text over - Move to position'),
(@ENTRY,0,2,0,34,0,100,0,0,1,0,0,11,39185,2,0,0,0,0,1,0,0,0,0,0,0,0,'Gorgrom - Point Reached - Cast trigger trap'),
(@ENTRY,0,3,0,8,0,100,1,39185,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gorgrom - Point Reached - Summon gameobject'),
(@ENTRY,0,4,5,1,1,100,1,1000,1000,0,0,50,300243,300,0,0,0,0,1,0,0,0,0,0,0,0,'Gorgrom - Point Reached - Summon gameobject'),
(@ENTRY,0,5,0,61,0,100,1,0,0,0,0,51,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gorgrom - Point Reached - Summon gameobject'),
(@BEAR,0,0,0,1,0,100,1,7000,7000,0,0,69,1,0,0,0,0,0,8,0,0,0,3615.61,7195.52,139.856,0,'Misha - 4 secs OOC - Move to position');

DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(@ENTRY,0,0,"I will crush it and flay it and eat its meat and crack its bones one by one when I am done.",14,0,100,0,0,0,'Gorgrom'),
(@ENTRY,0,1,"Who dares defile the altar of Gorgrom the Dragon-Eater?",14,0,100,0,0,0,'Gorgrom');
