-- Quest chain - The Conquest Pit
SET @QUEST_1    := 12427;
SET @QUEST_2    := 12428;
SET @QUEST_3    := 12429;
SET @QUEST_4    := 12430;
SET @QUEST_5    := 12431;
SET @WEAPON     := 31000; -- Necesito 1 para el equip_template
-- Npc
SET @GOBLIN     := 27719;
SET @IRONHIDE   := 27715;
SET @TORGG      := 27716;
SET @RUSTBLOOD  := 27717;
SET @HORGRENN   := 27718;
SET @GORGONNA   := 27726;
SET @KRENNA     := 27727;
SET @ANTHIS     := 26862;
SET @SETHYEL    := 26863;
UPDATE `quest_template` SET `EndText`='Krenna defeated' WHERE `Id`=@QUEST_5;

-- Grennix Shivwiggle SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@GOBLIN;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GOBLIN AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GOBLIN*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@GOBLIN,0,0,0,25,0,100,0,0,0,0,0,81,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Grennix Shivwiggle - Reset - Set questgiver flag'),
(@GOBLIN,0,1,0,38,0,100,0,0,1,0,0,81,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Grennix Shivwiggle - Data set - Set questgiver flag'),
(@GOBLIN,0,2,3,19,0,100,0,@QUEST_1,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Grennix Shivwiggle - Quest accept - Remove questgiver flag'),
(@GOBLIN,0,3,0,61,0,100,0,0,0,0,0,1,0,5000,0,0,0,0,1,0,0,0,0,0,0,0,'Grennix Shivwiggle - Quest accept - Say text'),
(@GOBLIN,0,4,0,52,0,100,0,0,@GOBLIN,0,0,12,@IRONHIDE,6,5000,0,0,0,8,0,0,0,3249.41,-2338.752,91.9832,1.11763,'Grennix Shivwiggle - Text over - Summon Ironhide'),
(@GOBLIN,0,5,6,19,0,100,0,@QUEST_2,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Grennix Shivwiggle - Quest accept - Remove questgiver flag'),
(@GOBLIN,0,6,0,61,0,100,0,0,0,0,0,1,1,7000,0,0,0,0,1,0,0,0,0,0,0,0,'Grennix Shivwiggle - Quest accept - Say text'),
(@GOBLIN,0,7,0,52,0,100,0,1,@GOBLIN,0,0,12,@TORGG,6,5000,0,0,0,8,0,0,0,3249.41,-2338.752,91.9832,1.11763,'Grennix Shivwiggle - Text over - Summon Torgg Thundertotem'),
(@GOBLIN,0,8,9,19,0,100,0,@QUEST_3,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Grennix Shivwiggle - Quest accept - Remove questgiver flag'),
(@GOBLIN,0,9,0,61,0,100,0,0,0,0,0,1,2,7000,0,0,0,0,1,0,0,0,0,0,0,0,'Grennix Shivwiggle - Quest accept - Say text'),
(@GOBLIN,0,10,0,52,0,100,0,2,@GOBLIN,0,0,1,3,3000,0,0,0,0,1,0,0,0,0,0,0,0,'Grennix Shivwiggle - Text over - Say text'),
(@GOBLIN,0,11,0,52,0,100,0,3,@GOBLIN,0,0,12,@RUSTBLOOD,6,5000,0,0,0,8,0,0,0,3249.41,-2338.752,91.9832,1.11763,'Grennix Shivwiggle - Text over - Summon Rustblood'),
(@GOBLIN,0,12,13,19,0,100,0,@QUEST_4,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Grennix Shivwiggle - Quest accept - Remove questgiver flag'),
(@GOBLIN,0,13,0,61,0,100,0,0,0,0,0,1,4,7000,0,0,0,0,1,0,0,0,0,0,0,0,'Grennix Shivwiggle - Quest accept - Say text'),
(@GOBLIN,0,14,0,52,0,100,0,4,@GOBLIN,0,0,1,5,5000,0,0,0,0,1,0,0,0,0,0,0,0,'Grennix Shivwiggle - Text over - Say text'),
(@GOBLIN,0,15,0,52,0,100,0,5,@GOBLIN,0,0,1,6,3000,0,0,0,0,1,0,0,0,0,0,0,0,'Grennix Shivwiggle - Text over - Say text'),
(@GOBLIN,0,16,0,52,0,100,0,6,@GOBLIN,0,0,12,@HORGRENN,6,5000,0,0,0,8,0,0,0,3249.41,-2338.752,91.9832,1.11763,'Grennix Shivwiggle - Text over - Summon Horgrenn Hellcleave'),
(@GOBLIN,0,17,0,19,0,100,0,@QUEST_5,0,0,0,80,@GOBLIN*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'Grennix Shivwiggle - Quest accept - Run Script'),
(@GOBLIN*100,9,0,0,0,0,100,0,0,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Grennix Shivwiggle - Script - Remove questgiver flag'),
(@GOBLIN*100,9,1,0,0,0,100,0,0,0,0,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0,'Grennix Shivwiggle - Script - Say text'),
(@GOBLIN*100,9,2,0,0,0,100,0,3000,3000,0,0,12,@GORGONNA,6,15000,0,0,0,8,0,0,0,3238.496,-2341.813,92.8545,0.174012,'Grennix Shivwiggle - Script - Summon Gorgonna'),
(@GOBLIN*100,9,3,0,0,0,100,0,0,0,0,0,12,@KRENNA,6,15000,0,0,0,8,0,0,0,3247.951,-2340.126,91.9299,3.303823,'Grennix Shivwiggle - Script - Summon Conqueror Krenna'),
(@GOBLIN*100,9,4,0,0,0,100,0,0,0,0,0,12,@ANTHIS,6,15000,0,0,0,8,0,0,0,3251.653,-2336.644,92.0931,3.358798,'Grennix Shivwiggle - Script - Summon Anthis'),
(@GOBLIN*100,9,5,0,0,0,100,0,0,0,0,0,12,@SETHYEL,6,15000,0,0,0,8,0,0,0,3252.691,-2341.938,91.8231,3.394141,'Grennix Shivwiggle - Script - Summon Sethyel'),
(@GOBLIN*100,9,6,0,0,0,100,0,9000,9000,0,0,1,0,0,0,0,0,0,19,@GORGONNA,100,0,0,0,0,0,'Grennix Shivwiggle - Script - Say text'),
(@GOBLIN*100,9,7,0,0,0,100,0,6000,6000,0,0,1,0,0,0,0,0,0,19,@KRENNA,100,0,0,0,0,0,'Grennix Shivwiggle - Script - Say text'),
(@GOBLIN*100,9,8,0,0,0,100,0,6000,6000,0,0,1,1,0,0,0,0,0,19,@GORGONNA,100,0,0,0,0,0,'Grennix Shivwiggle - Script - Say text'),
(@GOBLIN*100,9,9,0,0,0,100,0,8000,8000,0,0,1,1,0,0,0,0,0,19,@KRENNA,100,0,0,0,0,0,'Grennix Shivwiggle - Script - Say text'),
(@GOBLIN*100,9,10,0,0,0,100,0,6000,6000,0,0,1,2,0,0,0,0,0,19,@GORGONNA,100,0,0,0,0,0,'Grennix Shivwiggle - Script - Say text'),
(@GOBLIN*100,9,11,0,0,0,100,0,9000,9000,0,0,1,2,0,0,0,0,0,19,@KRENNA,100,0,0,0,0,0,'Grennix Shivwiggle - Script - Say text'),
(@GOBLIN*100,9,12,0,0,0,100,0,7000,7000,0,0,1,3,0,0,0,0,0,19,@GORGONNA,100,0,0,0,0,0,'Grennix Shivwiggle - Script - Say text'),
(@GOBLIN*100,9,13,0,0,0,100,0,7000,7000,0,0,45,0,1,0,0,0,0,19,@KRENNA,100,0,0,0,0,0,'Grennix Shivwiggle - Script - Set data Krenna'),
(@GOBLIN*100,9,14,0,0,0,100,0,0,0,0,0,45,0,1,0,0,0,0,19,@ANTHIS,100,0,0,0,0,0,'Grennix Shivwiggle - Script - Set data Anthis'),
(@GOBLIN*100,9,15,0,0,0,100,0,0,0,0,0,45,0,1,0,0,0,0,19,@SETHYEL,100,0,0,0,0,0,'Grennix Shivwiggle - Script - Set data Sethyel');

DELETE FROM `creature_text` WHERE `entry`=@GOBLIN;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@GOBLIN,0,0,'Ladies and gentlemen, gather round the Conquest Pit! Witness the battle of $r vs bear and place your bets with confidence!',12,0,100,1,0,0,'Grennix Shivwiggle'),
(@GOBLIN,1,0,'Just when you think you''ve seen it all! $n will square off with an authentic Grizzly Hills crazed furbolg in front of your very eyes here at the Conquest Pit! Place your bets, folks!',12,0,100,1,0,0,'Grennix Shivwiggle'),
(@GOBLIN,2,0,'Gather round, folks! Grab a warm drink and find a good seat for you''re about to witness a showdown between $r and machine!',12,0,100,1,0,0,'Grennix Shivwiggle'),
(@GOBLIN,3,0,'Straight out of Thor Modan and made of 100 percent authentic... metal... here is Rustblood, the lightning-powered iron golem!',12,0,100,1,0,0,'Grennix Shivwiggle'),
(@GOBLIN,4,0,'Ladies and gentlemen... gather round the pit!',12,0,100,1,0,0,'Grennix Shivwiggle'),
(@GOBLIN,5,0,'In one corner we have... $n, truly a world class $c. Slayer of reptiles, mammals, mechanical constructs and the odd dragon...kin. You''ve never seen another $r like $ghim:her;.',12,0,100,1,0,0,'Grennix Shivwiggle'),
(@GOBLIN,6,0,'In the other corner, a serial killer, mass defenestrator, sentenced to death multiple times by noose and by blunt instrument! Horgreen... Hellcleave! Ladies and gentlemen... place your bets!',12,0,100,1,0,0,'Grennix Shivwiggle'),
(@GOBLIN,7,0,'Ladies and gentlemen! Well... let''s just say you don''t want to miss this one!',12,0,100,1,0,0,'Grennix Shivwiggle');

-- Ironhide SAI
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_A`=1802, `faction_H`=1802 WHERE `entry`=@IRONHIDE;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@IRONHIDE AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@IRONHIDE,0,0,0,0,0,100,0,7000,10000,5000,15000,11,31279,0,0,0,0,0,2,0,0,0,0,0,0,0,'Ironhide - In combat - Cast Swipe'),
(@IRONHIDE,0,1,0,0,0,100,0,15000,20000,3000,10000,11,34298,0,0,0,0,0,2,0,0,0,0,0,0,0,'Ironhide - In combat - Cast Maul'),
(@IRONHIDE,0,2,0,9,0,100,0,8,25,5000,15000,11,32323,0,0,0,0,0,2,0,0,0,0,0,0,0,'Ironhide - At distance - Cast Charge'),
(@IRONHIDE,0,3,4,6,0,100,0,0,0,0,0,15,@QUEST_1,0,0,0,0,0,24,0,0,0,0,0,0,0,'Ironhide - Death - Group event happens'),
(@IRONHIDE,0,4,5,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,10,102451,@GOBLIN,0,0,0,0,0,'Ironhide - Death - Set data Grennix Shivwiggle'),
(@IRONHIDE,0,5,0,61,0,100,0,0,0,0,0,15,@QUEST_1,0,0,0,0,0,16,0,0,0,0,0,0,0,'Ironhide - Death - Group event happens (invoker party)'),
(@IRONHIDE,0,6,7,7,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironhide - Evade - Despawn'),
(@IRONHIDE,0,7,0,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,10,102451,@GOBLIN,0,0,0,0,0,'Ironhide - Evade - Set data Grennix Shivwiggle');

-- Torgg Thundertotem SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@TORGG;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@TORGG AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@TORGG,0,0,0,4,0,100,0,0,0,0,0,11,31991,0,0,0,0,0,1,0,0,0,0,0,0,0,'Torgg Thundertotem - Aggro - Cast Corrupted Nova Totem'),
(@TORGG,0,1,0,0,0,100,0,5000,7000,5000,7000,11,16033,0,0,0,0,0,2,0,0,0,0,0,0,0,'Torgg Thundertotem - In combat - Cast Chain Lightning'),
(@TORGG,0,2,0,13,0,100,0,7000,7000,0,0,11,15501,1,0,0,0,0,2,0,0,0,0,0,0,0,'Torgg Thundertotem - Target casting - Cast Earth Shock'),
(@TORGG,0,3,0,2,0,100,0,0,50,18000,22000,11,15982,1,0,0,0,0,1,0,0,0,0,0,0,0,'Torgg Thundertotem - At 50% hp - Cast Healing Wave'),
(@TORGG,0,4,5,6,0,100,0,0,0,0,0,15,@QUEST_2,0,0,0,0,0,7,0,0,0,0,0,0,0,'Torgg Thundertotem - Death - Group event happens'),
(@TORGG,0,5,6,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,10,102451,@GOBLIN,0,0,0,0,0,'Torgg Thundertotem - Death - Set data Grennix Shivwiggle'),
(@TORGG,0,6,0,61,0,100,0,0,0,0,0,15,@QUEST_2,0,0,0,0,0,16,0,0,0,0,0,0,0,'Torgg Thundertotem - Death - Group event happens (invoker party)'),
(@TORGG,0,7,8,7,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Torgg Thundertotem - Evade - Despawn'),
(@TORGG,0,8,0,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,10,102451,@GOBLIN,0,0,0,0,0,'Torgg Thundertotem - Evade - Set data Grennix Shivwiggle');

-- Rustblood SAI
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_A`=1802, `faction_H`=1802 WHERE `entry`=@RUSTBLOOD;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@RUSTBLOOD AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@RUSTBLOOD,0,0,0,9,0,100,0,10,40,3400,4800,11,61893,0,0,0,0,0,2,0,0,0,0,0,0,0,'Rustblood - At distance - Cast Lightning Bolt'),
(@RUSTBLOOD,0,1,0,9,0,100,0,0,5,5000,7000,11,42746,0,0,0,0,0,2,0,0,0,0,0,0,0,'Rustblood - At distance - Cast Cleave'),
(@RUSTBLOOD,0,2,0,0,0,100,0,12000,15000,18000,21000,11,14102,0,0,0,0,0,2,0,0,0,0,0,0,0,'Rustblood - In combat - Cast Head Smash'),
(@RUSTBLOOD,0,3,0,9,0,100,0,0,5,22000,30000,11,49398,0,0,0,0,0,1,0,0,0,0,0,0,0,'Rustblood - At distance - Cast Knockback'),
(@RUSTBLOOD,0,4,5,6,0,100,0,0,0,0,0,15,@QUEST_3,0,0,0,0,0,7,0,0,0,0,0,0,0,'Rustblood - Death - Group event happens'),
(@RUSTBLOOD,0,5,6,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,10,102451,@GOBLIN,0,0,0,0,0,'Rustblood - Death - Set data Grennix Shivwiggle'),
(@RUSTBLOOD,0,6,0,61,0,100,0,0,0,0,0,15,@QUEST_3,0,0,0,0,0,16,0,0,0,0,0,0,0,'Rustblood - Death - Group event happens (invoker party)'),
(@RUSTBLOOD,0,7,8,7,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Rustblood - Evade - Despawn'),
(@RUSTBLOOD,0,8,0,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,10,102451,@GOBLIN,0,0,0,0,0,'Rustblood - Evade - Set data Grennix Shivwiggle');

-- Horgrenn Hellcleave SAI
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_A`=1802, `faction_H`=1802 WHERE `entry`=@HORGRENN;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@HORGRENN AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@HORGRENN,0,0,0,9,0,100,0,0,10,21000,29000,11,16508,1,0,0,0,0,2,0,0,0,0,0,0,0,'Horgrenn Hellcleave - At distance - Cast Intimidating Roar'),
(@HORGRENN,0,1,0,0,0,100,0,3000,6000,8000,12000,11,15572,0,0,0,0,0,2,0,0,0,0,0,0,0,'Horgrenn Hellcleave - In combat - Cast Sunder Armor'),
(@HORGRENN,0,2,0,0,0,100,0,9000,12000,12000,16000,11,39171,1,0,0,0,0,2,0,0,0,0,0,0,0,'Horgrenn Hellcleave - In combat - Cast Mortal Strike'),
(@HORGRENN,0,3,0,0,0,100,0,13000,15000,13000,18000,11,38618,0,0,0,0,0,1,0,0,0,0,0,0,0,'Horgrenn Hellcleave - In combat - Cast Whirlwind'),
(@HORGRENN,0,4,5,6,0,100,0,0,0,0,0,15,@QUEST_4,0,0,0,0,0,7,0,0,0,0,0,0,0,'Horgrenn Hellcleave - Death - Group event happens'),
(@HORGRENN,0,5,6,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,10,102451,@GOBLIN,0,0,0,0,0,'Horgrenn Hellcleave - Death - Set data Grennix Shivwiggle'),
(@HORGRENN,0,6,0,61,0,100,0,0,0,0,0,15,@QUEST_4,0,0,0,0,0,16,0,0,0,0,0,0,0,'Horgrenn Hellcleave - Death - Group event happens (invoker party)'),
(@HORGRENN,0,7,8,7,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Horgrenn Hellcleave - Evade - Despawn'),
(@HORGRENN,0,8,0,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,10,102451,@GOBLIN,0,0,0,0,0,'Horgrenn Hellcleave - Evade - Set data Grennix Shivwiggle');

DELETE FROM `creature_equip_template` WHERE `entry`=@WEAPON;
INSERT INTO `creature_equip_template` (`entry`,`itemEntry1`,`itemEntry2`,`itemEntry3`) VALUES
(@WEAPON,42943,42943,0);

-- Conqueror Krenna SAI
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_A`=1979, `faction_H`=1979 WHERE `entry`=@KRENNA;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@KRENNA AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@KRENNA,0,0,1,38,0,100,0,0,1,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Conqueror Krenna - Data set - Set faction'),
(@KRENNA,0,1,0,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,19,@GORGONNA,30,0,0,0,0,0,'Conqueror Krenna - Data set - Attack Gorgonna'),
(@KRENNA,0,2,0,9,0,100,0,0,5,7000,9000,11,15284,0,0,0,0,0,2,0,0,0,0,0,0,0,'Conqueror Krenna - At distance - Cast Cleave'),
(@KRENNA,0,3,0,0,0,100,0,9000,12000,12000,17000,11,11430,1,0,0,0,0,2,0,0,0,0,0,0,0,'Conqueror Krenna - In combat - Cast Slam'),
(@KRENNA,0,4,0,0,0,100,0,3000,6000,6000,11000,11,34719,0,0,0,0,0,2,0,0,0,0,0,0,0,'Conqueror Krenna - In combat - Cast Fixate'),
(@KRENNA,0,5,0,13,0,100,0,14000,17000,0,0,11,12555,0,0,0,0,0,2,0,0,0,0,0,0,0,'Conqueror Krenna - Target casting - Cast Pummel'),
(@KRENNA,0,6,7,6,0,100,0,0,0,0,0,15,@QUEST_5,0,0,0,0,0,17,0,30,0,0,0,0,0,'Conqueror Krenna - Death - Group event happens'),
(@KRENNA,0,7,8,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,10,102451,@GOBLIN,0,0,0,0,0,'Conqueror Krenna - Death - Set data Grennix Shivwiggle'),
(@KRENNA,0,8,9,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,19,@GORGONNA,50,0,0,0,0,0,'Conqueror Krenna - Death - Set data Gorgonna)'),
(@KRENNA,0,9,10,61,0,100,0,0,0,0,0,45,0,2,0,0,0,0,19,@ANTHIS,50,0,0,0,0,0,'Conqueror Krenna - Death - Set data Anthis)'),
(@KRENNA,0,10,0,61,0,100,0,0,0,0,0,45,0,2,0,0,0,0,19,@SETHYEL,50,0,0,0,0,0,'Conqueror Krenna - Death - Set data Sethyel)'),
(@KRENNA,0,11,12,7,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Conqueror Krenna - Evade - Despawn'),
(@KRENNA,0,12,13,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,10,102451,@GOBLIN,0,0,0,0,0,'Conqueror Krenna - Evade - Set data Grennix Shivwiggle'),
(@KRENNA,0,13,14,61,0,100,0,0,0,0,0,45,0,2,0,0,0,0,19,@ANTHIS,50,0,0,0,0,0,'Conqueror Krenna - Evade - Set data Anthis)'),
(@KRENNA,0,14,0,61,0,100,0,0,0,0,0,45,0,2,0,0,0,0,19,@SETHYEL,50,0,0,0,0,0,'Conqueror Krenna - Evade - Set data Sethyel)');

DELETE FROM `creature_text` WHERE `entry`=@KRENNA;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@KRENNA,0,0,'Good one, sister. What about your pet? Where is $n?',12,0,100,0,0,0,'Conqueror Krenna'),
(@KRENNA,1,0,'You went behind my back. You neglected my orders. You will pay the price.',12,0,100,0,0,0,'Conqueror Krenna'),
(@KRENNA,2,0,'Enough talk! By the time, I''m through with you, not even the worgs are going to want to go near your corpse.',12,0,100,0,0,0,'Conqueror Krenna');

-- Anthis & Sethyel SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@ANTHIS,@SETHYEL);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ANTHIS,@SETHYEL) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ANTHIS,0,0,1,38,0,100,0,0,1,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Anthis - Data set - Set faction'),
(@ANTHIS,0,1,0,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,19,@GORGONNA,30,0,0,0,0,0,'Anthis - Data set - Attack Gorgonna'),
(@ANTHIS,0,2,0,38,0,100,0,0,2,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Anthis - Data set - Despawn'),
(@SETHYEL,0,0,1,38,0,100,0,0,1,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Sethyel - Data set - Set faction'),
(@SETHYEL,0,1,0,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,19,@GORGONNA,30,0,0,0,0,0,'Sethyel - Data set - Attack Gorgonna'),
(@SETHYEL,0,2,0,38,0,100,0,0,2,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Sethyel - Data set - Despawn');

-- Gorgonna SAI
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_A`=1986, `faction_H`=1986, `mindmg`=356, `maxdmg`=503, `minlevel`=76, `maxlevel`=76 WHERE `entry`=@GORGONNA;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GORGONNA AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GORGONNA*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@GORGONNA,0,0,0,38,0,100,0,0,1,0,0,80,@GORGONNA*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gorgonna - Data set - Run script'),
(@GORGONNA*100,9,0,0,0,0,100,0,5000,5000,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gorgonna - Script - Say text'),
(@GORGONNA*100,9,1,0,0,0,100,0,20000,20000,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gorgonna - Script - Despawn');

DELETE FROM `creature_text` WHERE `entry`=@GORGONNA;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@GORGONNA,0,0,'I see you''ve brought your pets.',12,0,100,0,0,0,'Gorgonna'),
(@GORGONNA,1,0,'It doesn''t have to end this way, you know?',12,0,100,0,0,0,'Gorgonna'),
(@GORGONNA,2,0,'I used good judgement when you showed none. I don''t want to see you lead us into ruin, Krenna!',12,0,100,0,0,0,'Gorgonna'),
(@GORGONNA,3,0,'We''ll see about that.',12,0,100,0,0,0,'Gorgonna'),
(@GORGONNA,4,0,'Why... why sister? Why did it have to come to this?',12,0,100,0,0,0,'Gorgonna');
