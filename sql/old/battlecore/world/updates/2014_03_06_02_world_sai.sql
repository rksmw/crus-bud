-- Quest - Tails Up

-- Frost Leopard SAI
SET @ENTRY := 29327;
SET @QUEST := 13549;
SET @GOSSIP := 54000;
SET @SPELL_RAKE := 54668;
SET @SPELL_BLOWGUN := 62105;
SET @SPELL_SLEEP := 42386; -- Sleeping Sleep
UPDATE `creature_template` SET `AIName`='SmartAI',`npcflag`=0,`gossip_menu_id`=@GOSSIP,`faction_A`=1990,`faction_H`=1990,`unit_flags`=0 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY*100,@ENTRY*100+1,@ENTRY*100+2) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,1000,1000,8000,11000,11,@SPELL_RAKE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Frost Leopard - In Combat - Cast Rake"),
(@ENTRY,0,1,0,25,0,100,0,0,0,0,0,2,1990,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Reset - Set Faction Back"),
(@ENTRY,0,2,3,8,0,100,1,@SPELL_BLOWGUN,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Spellhit - Set Faction Friendly"),
(@ENTRY,0,3,4,61,0,100,0,0,0,0,0,11,@SPELL_SLEEP,2,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Spellhit - Cast Sleep"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,81,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Spellhit - Set npc_flag Gossip"),
(@ENTRY,0,5,0,62,0,100,0,@GOSSIP,0,0,0,88,@ENTRY*100,@ENTRY*100+1,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Gossip Select - Run Random Script"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Frost Leopard - Script 1 - Say Line 0"),
(@ENTRY*100,9,1,0,0,0,100,0,1000,1000,0,0,36,33007,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script 1 - Update Template Male"),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,28,@SPELL_SLEEP,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script 1 - Remove Sleep"),
(@ENTRY*100,9,3,0,0,0,100,0,0,0,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script 1 - Remove OOC Flag"),
(@ENTRY*100+1,9,0,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Frost Leopard - Script 2 - Say Line 1"),
(@ENTRY*100+1,9,1,0,0,0,100,0,0,0,0,0,33,33005,0,0,0,0,0,7,0,0,0,0,0,0,0,"Frost Leopard - On Script 2 - Quest credit"),
(@ENTRY*100+1,9,2,0,0,0,100,0,0,0,0,0,28,@SPELL_SLEEP,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script 2 - Remove Sleep"),
(@ENTRY*100+1,9,3,0,0,0,100,0,0,0,0,0,11,62117,2,0,0,0,0,7,0,0,0,0,0,0,0,"Frost Leopard - On Script 2 - Cast Force Leopard Summon"),
(@ENTRY*100+1,9,4,0,0,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Frost Leopard - On Script 2 - Despawn");

DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"It's an angry male!",42,0,100,0,0,0,"Male Frost Leopard"),
(@ENTRY,1,0,"It's a female!",42,0,100,0,0,0,"Female Frost Leopard");

-- Male Frost Leopard SAI
SET @ENTRY := 33007;
SET @SPELL_RAKE := 54668;
UPDATE `creature_template` SET `AIName`='SmartAI',`faction_A`=1990,`faction_H`=1990,`unit_flags`=`unit_flags`|0 WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,3000,4000,9000,11000,11,@SPELL_RAKE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Male Frost Leopard - In Combat - Cast Rake");

-- Female Frost Leopard
SET @ENTRY := 33010;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,54,0,100,0,0,0,0,0,29,0,0,28527,0,0,0,7,0,0,0,0,0,0,0,"Female Frost Leopard - Just summoned - Follow Player");

-- Icepaw Bear SAI
SET @ENTRY := 29319;
SET @QUEST := 13549;
SET @GOSSIP := 55000;
SET @SPELL_CLAWS_OF_ICE := 54632;
SET @SPELL_BLOWGUN := 62105;
SET @SPELL_SLEEP := 42386; -- Sleeping Sleep
UPDATE `creature_template` SET `AIName`='SmartAI',`npcflag`=0,`gossip_menu_id`=@GOSSIP,`faction_A`=1990,`faction_H`=1990,`unit_flags`=32768 WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100,@ENTRY*100+1,@ENTRY*100+2);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,1000,1000,8000,11000,11,@SPELL_CLAWS_OF_ICE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Icepaw Bear - In Combat - Cast Claws of Ice"),
(@ENTRY,0,1,0,25,0,100,0,0,0,0,0,2,1990,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Reset - Set Faction Back"),
(@ENTRY,0,2,3,8,0,100,1,@SPELL_BLOWGUN,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Spellhit - Set Faction Friendly"),
(@ENTRY,0,3,4,61,0,100,0,0,0,0,0,11,@SPELL_SLEEP,2,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Spellhit - Cast Sleep"),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,81,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Spellhit - Set npc_flag Gossip"),
(@ENTRY,0,5,0,62,0,100,0,@GOSSIP,0,0,0,88,@ENTRY*100,@ENTRY*100+1,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Gossip Select - Run Random Script"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"Icepaw Bear - Script 1 - Say Line 0"),
(@ENTRY*100,9,1,0,0,0,100,0,1000,1000,0,0,36,33008,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script 1 - Update Template Male"),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,28,@SPELL_SLEEP,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script 1 - Remove Sleep"),
(@ENTRY*100,9,3,0,0,0,100,0,0,0,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script 1 - Remove OOC Flag"),
(@ENTRY*100+1,9,0,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Icepaw Bear - Script 2 - Say Line 1"),
(@ENTRY*100+1,9,1,0,0,0,100,0,0,0,0,0,33,33006,0,0,0,0,0,7,0,0,0,0,0,0,0,"Icepaw Bear - On Script 2 - Quest Credit"),
(@ENTRY*100+1,9,2,0,0,0,100,0,0,0,0,0,28,@SPELL_SLEEP,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script 2 - Remove Sleep"),
(@ENTRY*100+1,9,3,0,0,0,100,0,0,0,0,0,11,62118,2,0,0,0,0,7,0,0,0,0,0,0,0,"Icepaw Bear - On Script 2 - Cast Force Bear Summon"),
(@ENTRY*100+1,9,4,0,0,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Icepaw Bear - On Script 2 - Despawn");

DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"It's an angry male!",42,0,100,0,0,0,"Male Icepaw Bear"),
(@ENTRY,1,0,"It's a female!",42,0,100,0,0,0,"Female Icepaw Bear");

-- Male Icepaw Bear SAI
SET @ENTRY := 33008;
SET @SPELL_CLAWS_OF_ICE := 54632;
UPDATE `creature_template` SET `AIName`='SmartAI',`faction_A`=1990,`faction_H`=1990,`unit_flags`=`unit_flags`|0 WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,3000,4000,9000,11000,11,@SPELL_CLAWS_OF_ICE,0,0,0,0,0,2,0,0,0,0,0,0,0,"Male Icepaw Bear - In Combat - Cast Claws of Ice");

-- Female Icepaw Bear SAI
SET @ENTRY := 33011;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,54,0,100,0,0,0,0,0,29,0,0,28527,0,0,0,7,0,0,0,0,0,0,0,"Female Icepaw Bear - Just summoned - Follow Player");

-- Only show first gossip if player is on quest Tails Up
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup` IN (54000,55000);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=@SPELL_BLOWGUN;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,54000,0,0,9,0,@QUEST,0,0,0,'',"Only show gossip if player is on quest Tails Up"),
(15,55000,0,0,9,0,@QUEST,0,0,0,'',"Only show gossip if player is on quest Tails Up"),
(17,0,@SPELL_BLOWGUN,0,31,1,3,29327,0,0,'',"Spell To'kini's Blowgun can only be cast at Frost Leopard"),
(17,0,@SPELL_BLOWGUN,1,31,1,3,29319,0,0,'',"Spell To'kini's Blowgun can only be cast at Icepaw Bear");
