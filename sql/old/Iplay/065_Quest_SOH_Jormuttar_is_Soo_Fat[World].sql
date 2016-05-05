-- Quest - Jormuttar is Soo Fat...
SET @BEAR := 30292;
SET @KNIFE := 56562;
SET @LURE := 56566;
SET @BUNNY := 30366;
SET @WORM := 30340;
SET @FLANK := 56577; 
UPDATE `gameobject` SET `phaseMask`=4 WHERE `id`=300231;

-- Dead Icemaw Bear SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@BEAR;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@BEAR AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@BEAR*100,@BEAR*100+1) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@BEAR,0,0,0,8,0,100,0,@KNIFE,0,0,0,87,@BEAR*100,@BEAR*100,@BEAR*100,@BEAR*100,@BEAR*100+1,@BEAR*100+1,1,0,0,0,0,0,0,0,'Dead Icemaw Bear - Spellhit - Run Random script'), -- la mayoria de las veces el item no tiene que hacer nada, con esto 2/3 veces falla
(@BEAR*100,9,0,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Dead Icemaw Bear - Script - Say text'),
(@BEAR*100,9,1,0,0,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Dead Icemaw Bear - Script - Despawn'),
(@BEAR*100+1,9,0,0,0,0,100,0,0,0,0,0,85,@LURE,2,0,0,0,0,7,0,0,0,0,0,0,0,'Dead Icemaw Bear - Script - Create Icemaw Bear Flank'),
(@BEAR*100+1,9,1,0,0,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Dead Icemaw Bear - Script - Despawn');

DELETE FROM `creature_text` WHERE `entry`=@BEAR;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@BEAR,0,0,"This bear's flank is frozen solid... try again...",42,0,100,0,0,0,"Dead Icemaw Bear");

-- Jormuttar SAI
DELETE FROM `creature` WHERE `id`=@WORM;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`) VALUES
(@WORM,571,1,4,0,0,7312.98,-2048.77,761.426,2.77507,300,0,0,12600,0,0);

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@WORM;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@WORM;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@WORM AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@WORM*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@WORM,0,0,0,25,0,100,0,0,0,0,0,17,373,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jormuttar - Reset - Set emote state submerged'),
(@WORM,0,1,0,25,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jormuttar - Reset - React Passive'),
(@WORM,0,2,0,25,0,100,0,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jormuttar - Reset - Prevent Combat movement'),
(@WORM,0,3,0,25,0,100,0,0,0,0,0,18,33554434,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jormuttar - Reset - Set unit flags non selectable + non attackable'),
(@WORM,0,4,0,0,0,100,0,1000,1000,3000,5000,11,61597,0,0,0,0,0,2,0,0,0,0,0,0,0,'Jormuttar - In combat - Cast Acid Spit'),
(@WORM,0,5,0,0,0,100,0,11000,16000,15000,20000,11,61598,0,0,0,0,0,2,0,0,0,0,0,0,0,'Jormuttar - In combat - Cast Sweep'),
(@WORM,0,6,0,7,0,100,0,0,0,0,0,5,374,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jormuttar - Evade - Emote submerge'),
(@WORM,0,7,0,38,0,100,0,0,1,3000,3000,80,@WORM*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jormuttar - Data set - Run script'),
(@WORM*100,9,0,0,0,0,100,0,0,0,0,0,5,449,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jormuttar - In combat - Cast Acid Spit'),
(@WORM*100,9,1,0,0,0,100,0,3000,3000,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jormuttar - In combat - Cast Acid Spit'),
(@WORM*100,9,2,0,0,0,100,0,0,0,0,0,19,33554434,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jormuttar - In combat - Cast Acid Spit'),
(@WORM*100,9,3,0,0,0,100,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jormuttar - In combat - Cast Acid Spit');

-- Lure Jormuttar Bunny SAI
SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@WORM);
UPDATE `creature_template` SET `AIName`='SmartAI', `flags_extra`=flags_extra|128 WHERE `entry`=@BUNNY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@BUNNY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@BUNNY,0,0,0,54,0,100,0,0,0,0,0,11,@FLANK,0,0,0,0,0,1,0,0,0,0,0,0,0,'Lure Jormuttar Bunny - Just Summoned - Cast Summon Flank'),
(@BUNNY,0,1,0,1,0,100,1,1000,1000,0,0,70,0,0,0,0,0,0,10,@GUID,@WORM,0,0,0,0,0,'Lure Jormuttar Bunny - OOC - Respawn Jormuttar'),
(@BUNNY,0,2,0,1,0,100,1,3000,3000,0,0,45,0,1,0,0,0,0,10,@GUID,@WORM,0,0,0,0,0,'Lure Jormuttar Bunny - OOC - Set data Jormuttar');
