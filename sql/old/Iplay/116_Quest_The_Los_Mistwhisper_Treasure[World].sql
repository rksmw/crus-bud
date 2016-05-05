-- The Lost Mistwhisper Treasure
SET @TARTEK := 28105;
SET @ZEPTEK := 28399;
SET @TRIGG := 5030;

DELETE FROM `areatrigger_scripts` WHERE `entry`=@TRIGG;
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES (@TRIGG,'at_mistwhisper_treasure');

UPDATE `creature_template` SET `faction_A`=2062, `faction_H`=2062, `AIName`='SmartAI' WHERE `entry` IN (@TARTEK,@ZEPTEK);
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@TARTEK;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@TARTEK,@ZEPTEK) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ZEPTEK,0,0,1,11,0,100,0,0,571,3711,0,12,@TARTEK,6,20000,0,0,0,8,0,0,0,6707.040527,5146.905273,-19.443356,4.814339,'Zeptek the Destroyer - Spawn - Summon Warlord Tartek'),
(@ZEPTEK,0,1,2,61,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zeptek the Destroyer - Spawn - Set phase 1'),
(@ZEPTEK,0,2,0,61,0,100,0,0,0,0,0,18,768,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zeptek the Destroyer - Spawn - Set unit flags immune'),
(@ZEPTEK,0,3,4,38,0,100,1,0,1,0,0,45,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zeptek the Destroyer - Data set - set data self'),
(@ZEPTEK,0,4,5,61,0,100,0,0,0,0,0,19,768,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zeptek the Destroyer - Data set - Remove unit flags'),
(@ZEPTEK,0,5,0,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,21,50,0,0,0,0,0,0,'Zeptek the Destroyer - Data set - Attack closest player'),
(@ZEPTEK,0,6,0,1,1,100,1,2000,2000,0,0,46,11,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zeptek the Destroyer - 2sec OOC phase 1 - Walk 12 yards'),
(@TARTEK,0,0,1,11,0,100,0,0,571,3711,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Warlord Tartek - Spawn - Set phase 1'),
(@TARTEK,0,1,0,61,0,100,0,0,0,0,0,18,768,0,0,0,0,0,1,0,0,0,0,0,0,0,'Warlord Tartek - Spawn - Set unit flags immune'),
(@TARTEK,0,2,0,1,1,100,1,50,50,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Warlord Tartek - 50 ms OOC phase 1  - Say text'),
(@TARTEK,0,3,0,1,1,100,1,2000,2000,0,0,46,12.5,0,0,0,0,0,1,0,0,0,0,0,0,0,'Warlord Tartek - 2sec OOC phase 1 - Walk 12 yards'),
(@TARTEK,0,4,0,0,0,100,0,3000,6000,4000,7000,11,29426,0,0,0,0,0,2,0,0,0,0,0,0,0,'Warlord Tartek - In combat - Cast Heroic Strike'),
(@TARTEK,0,5,0,0,0,100,0,9000,12000,9000,12000,11,15572,0,0,0,0,0,2,0,0,0,0,0,0,0,'Warlord Tartek - In combat - Cast Sunder Armor'),
(@TARTEK,0,6,0,2,0,100,0,0,30,12000,15000,11,35429,1,0,0,0,0,1,0,0,0,0,0,0,0,'Warlord Tartek - 30% HP - Cast Sweeping Strikes'),
(@TARTEK,0,7,0,1,1,100,1,10000,10000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Warlord Tartek - 10 sec OOC phase 1 - Say Text'),
(@TARTEK,0,8,9,1,1,100,1,15000,15000,0,0,19,768,0,0,0,0,0,1,0,0,0,0,0,0,0,'Warlord Tartek - 15 sec OOC phase 1 - Remove unit flags'),
(@TARTEK,0,9,10,61,1,100,1,0,0,0,0,45,0,1,0,0,0,0,19,@ZEPTEK,50,0,0,0,0,0,'Warlord Tartek - 15 sec OOC phase 1 - Set data Zeptek the destroyer'),
(@TARTEK,0,10,0,61,1,100,1,0,0,0,0,49,0,0,0,0,0,0,21,100,0,0,0,0,0,0,'Warlord Tartek - 15 sec OOC phase 1 - Attack closest player');

DELETE FROM `creature_text` WHERE `entry`=@TARTEK;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@TARTEK,0,0,"My Treasure! You no steal from Tartek, you big-tongue traitor thing.",14,0,100,0,0,0,'Warlord Tartek'),
(@TARTEK,1,0,"Tartek and nasty dragon going to kill you! You so dumb.",14,0,100,0,0,0,'Warlord Tartek');
