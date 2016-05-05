-- Quest - Drop It then Rok It!
SET @VRYKUL := 23655;
SET @BANNER := 24640;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@VRYKUL AND `source_type`=0;
UPDATE `creature_template` SET AIName="SmartAI" WHERE entry=@VRYKUL;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@VRYKUL,0,0,0,54,0,100,0,0,0,0,0,53,10,@VRYKUL,0,0,0,2,1,0,0,0,0.0,0.0,0.0,0.0,"Vrykul - At Summon - Way Point Start");

DELETE FROM `waypoints` WHERE `entry`=@VRYKUL;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@VRYKUL,1,1477.47,-5338.22,194.533,'VRYKUL 1'),
(@VRYKUL,2,1502.63,-5318.21,195.642,'VRYKUL 2');

UPDATE `creature_template` SET AIName="SmartAI" WHERE entry=@BANNER;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@BANNER AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@BANNER*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@BANNER,0,0,0,54,0,100,0,0,0,0,0,80,@BANNER*100,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Alliance banner - Invocacion - Ejecutar accion"),
(@BANNER,0,2,0,60,0,100,0,10000,10000,20000,20000,12,@VRYKUL,7,0,0,1,0,8,0,0,0,1490.19,-5358.09,189.895,1.87363,"Alliance banner - At time - Summon Vrykul"),
(@BANNER,0,3,0,6,0,100,0,0,0,0,0,6,11429,0,0,0,0,0,23,0,0,0,0.0,0.0,0.0,0.0,"Alliance banner - Die - Quest Fail"),
(@BANNER*100,9,1,0,0,0,100,0,60000,60000,0,0,15,11429,0,0,0,0,0,23,0,0,0,0.0,0.0,0.0,0.0,"Alliance banner - 1 minute - Complete quest"),
(@BANNER*100,9,2,0,0,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Alliance banner - Link - Despawn");
