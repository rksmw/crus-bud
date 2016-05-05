-- Quest - Mystery of the Infinite
-- Hourglass of Eternity SAI
SET @HOURGLASS := 27840;
SET @SUMMON1 := 49900;
SET @SUMMON2 := 49901;
SET @SUMMON3 := 49902;
SET @SUMMON4 := 49905;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@HOURGLASS AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`IN (@HOURGLASS*100,@HOURGLASS*100+1,@HOURGLASS*100+2) AND `source_type`=9;
UPDATE `creature_template` SET AIName="SmartAI", `unit_flags`=unit_flags|2 WHERE entry=@HOURGLASS;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@HOURGLASS,0,0,0,54,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Summoned - Store invoker"),
(@HOURGLASS,0,1,0,54,0,100,0,0,0,0,0,80,@HOURGLASS*100,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Summoned - Run script"),
(@HOURGLASS,0,2,0,38,0,100,0,0,1,0,0,15,12470,0,0,0,0,0,12,1,0,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Data set - Complete quest"),
(@HOURGLASS*100,9,0,0,0,0,100,0,3000,3000,0,0,85,49931,3,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Spawn - Invoker Summon Future You"),
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
(@HOURGLASS*100,9,11,0,0,0,100,0,30000,30000,0,0,45,0,1,0,0,0,0,19,27899,50,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Script - Set data Future You"),
(@HOURGLASS*100,9,12,0,0,0,100,0,5000,5000,0,0,11,@SUMMON4,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Hourglass of Eternity - Script - Summon Infinite Timerender");

-- Infinite Chrono Magus SAI
SET @MAGUS := 27898;
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_A`=2111, `faction_H`=2111 WHERE `entry`=@MAGUS;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@MAGUS;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@MAGUS AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@MAGUS,0,0,0,37,0,100,0,0,0,0,0,58,1,9613,1500,3000,30,15,1,0,0,0,0.0,0.0,0.0,0.0,"Infinite Chrono Magus - AI Init - Set caster template (Shadow Bolt)"),
(@MAGUS,0,1,0,0,0,100,0,7000,9000,20000,25000,11,38085,1,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Infinite Chrono Magus - Spawn - Attack Future You");

-- Future You SAI
SET @FUTURE := 27899;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@FUTURE;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@FUTURE AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@FUTURE,0,0,0,54,0,100,0,0,0,0,0,85,45204,3,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Future You - Just created - Cast Mirror Image"),
(@FUTURE,0,1,0,54,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Future You - Just created - Say text"),
(@FUTURE,0,2,0,54,0,100,0,0,0,0,0,1,0,7000,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Future You - Just created - Say text"),
(@FUTURE,0,3,0,25,0,100,0,0,0,0,0,86,45204,3,12,1,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Future You - Reset - Stored cast mirror Image"),
(@FUTURE,0,4,0,52,0,100,0,0,@FUTURE,0,0,1,1,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Future You - Text over - Say text"),
(@FUTURE,0,5,0,38,0,100,1,0,1,0,0,1,2,0,0,0,0,0,12,1,0,0,0.0,0.0,0.0,0.0,"Future You - Data set - Say text");

DELETE FROM `creature_text` WHERE `entry`=@FUTURE;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@FUTURE,0,0, "Hey there, $n, don't be alarmed. It's me... you... from the future. I'm here to help.",15,0,100,0,0,0, "Future You"),
(@FUTURE,1,0, "Heads up... here they come. I'll help as much as I can. Let's just keep them off of the hourglass!",15,0,100,0,0,0, "Future You"),
(@FUTURE,2,0, "No matter what, you can't die, because would mean that I would cease to exist, right? But, I was here before when I was you. I'm so confused!",15,0,100,0,0,0, "Future You"),
(@FUTURE,2,1, "Sorry, but Chromie said that I couldn't reveal anything about your future to you. She said that if I did, I would cease to exist.",15,0,100,0,0,0, "Future You"),
(@FUTURE,2,2, "Look at you fight; no wonder I turned to drinking.",15,0,100,0,0,0, "Future You"),
(@FUTURE,2,3, "Wow, I'd forgotten how inexperienced I used to be.",15,0,100,0,0,0, "Future You"),
(@FUTURE,2,4, "I can't believe that I used to wear that.",15,0,100,0,0,0, "Future You"),
(@FUTURE,2,5, "Listen. I'm not supposed to tell you this, but there's going to be this party that you're invited to. Whatever you do, DO NOT DRINK THE PUNCH!",15,0,100,0,0,0, "Future You"),
(@FUTURE,2,6, "Wish I could remember how many of the Infinite Dragonflight were going to try to stop you. This fight was so long ago.",15,0,100,0,0,0, "Future You");

-- Infinite Timerender
SET @RENDER := 27900;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@RENDER AND `source_type`=0;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@RENDER;
UPDATE `creature_template` SET AIName="SmartAI", `faction_A`=2111, `faction_H`=2111 WHERE entry=@RENDER LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@RENDER,0,0,0,54,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Infinite Timerender - Summoned - Store invoker"),
(@RENDER,0,1,0,0,0,100,0,15000,20000,25000,30000,11,51020,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Infinite Timerender - In combat - Cast time lapse"),
(@RENDER,0,2,0,6,0,100,0,0,0,0,0,45,0,1,0,0,0,0,12,1,0,0,0.0,0.0,0.0,0.0,"Infinite Timerender - Death - Set Data Hourglass");

-- Extend cast area - Spell 49890 (Hourglass of Eternity)
UPDATE `gameobject_template` SET `data1`=100 WHERE `entry` = 300209;
