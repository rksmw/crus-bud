-- Quest - Kick, What Kick?
SET @WILHELM := 28054;
SET @APPLE := 28053;
DELETE FROM `vehicle_template_accessory` WHERE `entry`=@WILHELM;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@WILHELM,@APPLE);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@WILHELM,@APPLE);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@WILHELM,0,0,0,23,0,100,0,46598,0,5000,5000,12,@APPLE,8,0,0,0,0,1,0,0,0,0,0,0,0,'Lucky Wilhelm - Missing aura - Summon Apple'),
(@APPLE,0,0,0,54,0,100,0,0,0,0,0,11,46598,2,0,0,0,0,7,0,0,0,0,0,0,0,'Apple - Just summoned - Ride Wilhelm');
