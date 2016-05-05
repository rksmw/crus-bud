-- Quest - Mystery of the Infinite, Redux
-- Hourglass of Eternity SAI
SET @HOURGLASS := 32327;
SET @SUMMON1 := 49900;
SET @SUMMON2 := 49901;
SET @SUMMON3 := 49902;
SET @SUMMON4 := 49905;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@HOURGLASS AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@HOURGLASS*100 AND `source_type`=9;
UPDATE `creature_template` SET AIName="SmartAI", `unit_flags`=unit_flags|2, `minlevel`=80, `maxlevel`=80 WHERE entry=@HOURGLASS;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@HOURGLASS,0,0,0,54,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Summoned - Store invoker"),
(@HOURGLASS,0,1,0,54,0,100,0,0,0,0,0,80,@HOURGLASS*100,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Summoned - Run script"),
(@HOURGLASS,0,2,0,38,0,100,0,0,1,0,0,15,13343,0,0,0,0,0,12,1,0,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Data set - Complete quest"),
(@HOURGLASS*100,9,0,0,0,0,100,0,3000,3000,0,0,85,60791,3,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Spawn - Invoker Summon Future You"),
(@HOURGLASS*100,9,1,0,0,0,100,0,14000,14000,0,0,11,@SUMMON1,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Script - Summon Infinite Assailant"),
(@HOURGLASS*100,9,2,0,0,0,100,0,0,0,0,0,11,@SUMMON1,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Script - Summon Infinite Assailant"),
(@HOURGLASS*100,9,3,0,0,0,100,0,20000,20000,0,0,11,@SUMMON1,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Script - Summon Infinite Assailant"),
(@HOURGLASS*100,9,4,0,0,0,100,0,0,0,0,0,11,@SUMMON1,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Script - Summon Infinite Assailant"),
(@HOURGLASS*100,9,5,0,0,0,100,0,20000,20000,0,0,11,@SUMMON2,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Script - Summon Infinite Destroyer"),
(@HOURGLASS*100,9,6,0,0,0,100,0,0,0,0,0,11,@SUMMON2,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Script - Summon Infinite Destroyer"),
(@HOURGLASS*100,9,7,0,0,0,100,0,0,0,0,0,11,@SUMMON3,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Script - Summon Infinite Chrono Magus"),
(@HOURGLASS*100,9,8,0,0,0,100,0,30000,30000,0,0,11,@SUMMON2,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Script - Summon Infinite Destroyer"),
(@HOURGLASS*100,9,9,0,0,0,100,0,0,0,0,0,11,@SUMMON2,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Script - Summon Infinite Destroyer"),
(@HOURGLASS*100,9,10,0,0,0,100,0,0,0,0,0,11,@SUMMON3,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Script - Summon Infinite Chrono Magus"),
(@HOURGLASS*100,9,11,0,0,0,100,0,30000,30000,0,0,45,0,1,0,0,0,0,19,32331,50,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Script - Set data Past You"),
(@HOURGLASS*100,9,12,0,0,0,100,0,5000,5000,0,0,11,@SUMMON4,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Script - Summon Infinite Timerender");

-- Past You SAI
SET @PAST := 32331;
UPDATE `creature_template` SET `AIName`='SmartAI', `minlevel`=75, `maxlevel`=75 WHERE `entry`=@PAST;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@PAST AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@PAST,0,0,0,54,0,100,0,0,0,0,0,85,45204,3,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Past You - Just created - Cast Mirror Image"),
(@PAST,0,1,0,54,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Past You - Just created - Say text"),
(@PAST,0,2,0,54,0,100,0,0,0,0,0,1,0,7000,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Past You - Just created - Say text"),
(@PAST,0,3,0,25,0,100,0,0,0,0,0,86,45204,3,12,1,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Past You - Reset - Stored cast mirror Image"),
(@PAST,0,4,0,52,0,100,0,0,@PAST,0,0,1,1,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Past You - Text over - Say text"),
(@PAST,0,5,0,38,0,100,1,0,1,0,0,1,2,0,0,0,0,0,12,1,0,0,0.0,0.0,0.0,0.0,"Past You - Data set - Say text");

DELETE FROM `creature_text` WHERE `entry`=@PAST;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@PAST,0,0, "Whoa! You're me, but from the future! Hey, my equipment got an upgrade! Cool!",15,0,100,0,0,0, "Past You"),
(@PAST,1,0, "Here come the Infinites! I've got to keep the hourglass safe. Can you help?",15,0,100,0,0,0, "Past You"),
(@PAST,2,0, "This equipment looks cool and all, but couldn't we have done a little better? Are you even raiding?",15,0,100,0,0,0, "Past You"),
(@PAST,2,1, "Chromie said that if I don't do this just right, I might wink out of existence. If I go, then you go!",15,0,100,0,0,0, "Past You"),
(@PAST,2,2, "I just want you to know that if we get through this alive, I'm making sure that we turn out better than you. No offense.",15,0,100,0,0,0, "Past You"),
(@PAST,2,3, "Looks like I'm an underachiever.",15,0,100,0,0,0, "Past You"),
(@PAST,2,4, "Wait a minute! If you're here, then that means that in the not-so-distant future I'm going to be you helping me? Are we stuck in a time loop?!",15,0,100,0,0,0, "Past You"),
(@PAST,2,5, "I think I'm going to turn to drinking after this.",15,0,100,0,0,0, "Past You");
