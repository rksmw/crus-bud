SET @ENTRY := 37503;
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `unit_flags` = 0, `flags_extra` = 128, `ScriptName` = 'npc_sindragosas_ward' WHERE `entry` = @ENTRY;
DELETE FROM `creature` WHERE `id` = @ENTRY;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `curhealth`, `curmana`) VALUES (@ENTRY, 631, 15, 1, 4181.03, 2484.3, 211.033, 3.13219, 604800, 27890000, 8516000);
DELETE FROM `areatrigger_scripts` WHERE `entry` = 5623;
INSERT INTO `areatrigger_scripts` VALUES (5623, 'at_icc_start_sindragosa_gauntlet'); 
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,1,0,'You must not approach the Frost Queen. Quickly, stop them!',14,0,100,0,0,17167,'Sindragosa Ward');

SET @ENTRY := 37501;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,2000,3000,5000,5000,11,71801,0,0,0,0,0,5,0,0,0,0.0,0.0,0.0,0.0,"Nerub'ar Champion - Cast Rush");

SET @ENTRY := 37502;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,4000,5000,8000,10000,11,71326,0,0,0,0,0,5,0,0,0,0.0,0.0,0.0,0.0,"Nerub'ar Webweaver - Cast Crypt Scarabs"),
(@ENTRY,0,1,0,0,0,100,0,2000,3000,12000,15000,11,71327,0,0,0,0,0,5,0,0,0,0.0,0.0,0.0,0.0,"Nerub'ar Webweaver - Cast Web");

SET @ENTRY := 37229;
UPDATE `creature_template` SET `minlevel` = 79, `maxlevel` = 80, `faction_A` = 14, `faction_H` = 14, `mindmg` = 232, `maxdmg` = 328, `dmg_multiplier` = 12, `AIName` = 'SmartAI' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,4000,5000,8000,10000,11,71320,0,0,0,0,0,5,0,0,0,0.0,0.0,0.0,0.0,"Frostwarden Sorceress - Cast Frost Nova"),
(@ENTRY,0,1,0,0,0,100,0,2000,3000,8000,10000,11,71318,0,0,0,0,0,5,0,0,0,0.0,0.0,0.0,0.0,"Frostwarden Sorceress - Cast Frostbolt"),
(@ENTRY,0,2,0,0,0,100,0,8000,9000,8000,10000,11,71331,0,0,0,0,0,5,0,0,0,0.0,0.0,0.0,0.0,"Frostwarden Sorceress - Cast Ice Tomb");

SET @ENTRY := 37228;
UPDATE `creature_template` SET `minlevel` = 79, `maxlevel` = 80, `faction_A` = 14, `faction_H` = 14, `mindmg` = 332, `maxdmg` = 428, `dmg_multiplier` = 10, `AIName` = 'SmartAI' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,4000,5000,8000,10000,11,71325,0,0,0,0,0,5,0,0,0,0.0,0.0,0.0,0.0,"Frostwarden Warrior - Cast Frostblade"),
(@ENTRY,0,1,0,0,0,100,0,2000,3000,8000,10000,11,71317,0,0,0,0,0,5,0,0,0,0.0,0.0,0.0,0.0,"Frostwarden Warrior - Cast Glacial Strike");

SET @ENTRY := 37232;
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `dmg_multiplier` = 8 WHERE `entry` = @ENTRY;

SET @ENTRY := 38199; -- modelid1 = 1126
UPDATE `creature_template` SET `modelid1` = 16946, `minlevel` = 79, `maxlevel` = 80, `faction_A` = 14, `faction_H` = 14, `mindmg` = 332, `maxdmg` = 428, `dmg_multiplier` = 15, `unit_flags` = 33554432, `AIName` = 'SmartAI' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,2000,2000,20000,22000,11,41062,0,0,0,0,0,5,0,0,0,0.0,0.0,0.0,0.0,"Frostblade - Cast Disarm"),
(@ENTRY,0,1,0,0,0,100,0,4000,6000,12000,20000,11,71323,0,0,0,0,0,5,0,0,0,0.0,0.0,0.0,0.0,"Frostblade - Cast Frostblade");
