-- Quest - The Halls of Reflection
SET @UTHER :=37225;
SET @QUEL :=37158;
SET @TRIGG :=5632;

DELETE FROM `areatrigger_scripts` WHERE `entry`=@TRIGG;
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES
(@TRIGG,'at_quel_delar_uther');

DELETE FROM `creature` WHERE `id`=@QUEL; -- spawn incorrecto
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@UTHER;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@UTHER AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@UTHER*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@UTHER,0,0,0,11,0,100,1,0,668,4820,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Uther - Spawn - Switch to phase 1'),
(@UTHER,0,1,2,10,1,100,1,1,90,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Uther - At distance - Say text'),
(@UTHER,0,2,0,61,1,100,1,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Uther - At distance - Switch to phase 2'),
(@UTHER,0,3,4,10,2,100,1,1,25,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Uther - At distance - Say text'),
(@UTHER,0,4,0,61,2,100,1,0,0,0,0,22,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Uther - At distance - Switch to phase 3'),
(@UTHER,0,5,6,1,4,100,1,0,0,0,0,85,69966,3,0,0,0,0,7,0,0,0,0,0,0,0,'Uther - At distance - Summon Quel Delar'),
(@UTHER,0,6,7,61,4,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Uther - At distance - Say text'),
(@UTHER,0,7,0,61,4,100,1,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Uther - At distance - React Passive'),
(@UTHER,0,8,0,38,0,100,1,0,1,0,0,80,@UTHER*100,2,0,0,0,0,1,0,0,0,0,0,0,0,'Uther - Set data - Run script'),
(@UTHER*100,9,0,0,0,0,100,0,0,0,0,0,45,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Uther - Script - Set data self'),
(@UTHER*100,9,1,0,0,0,100,0,3000,3000,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Uther - Script - Say text'),
(@UTHER*100,9,2,0,0,0,100,0,12000,12000,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,'Uther - Script - Say text'),
(@UTHER*100,9,3,0,0,0,100,0,8000,8000,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,'Uther - Script - Say text'),
(@UTHER*100,9,4,0,0,0,100,0,10000,10000,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,'Uther - Script - Say text'),
(@UTHER*100,9,5,0,0,0,100,0,4000,4000,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Uther - Script - Despawn');

DELETE FROM `creature_text` WHERE `entry`=@UTHER;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@UTHER,0,0,"Halt! Do not carry that blade any further!",14,0,100,0,0,16675,'Uther the Lightbringer'),
(@UTHER,1,0,"Quel'Delar leaps to life in the presence of Frostmourne!",41,0,100,0,2,0,'Uther the Lightbringer'),
(@UTHER,2,0,"Do you realize what you've done?",14,0,100,0,0,16676,'Uther the Lightbringer'),
(@UTHER,3,0,"You have forged this blade from saronite, the very blood of an old god. The power of the Lich King calls to this weapon.",12,0,100,1,2000,16677,'Uther the Lightbringer'),
(@UTHER,4,0,"Each moment you tarry here, Quel'Delar drinks in the evil of this place.",12,0,100,1,2000,16678,'Uther the Lightbringer'),
(@UTHER,5,0,"There is only one way to cleanse the sword. Make haste for the Sunwell and immerse the blade in its waters.",12,0,100,25,2000,16679,'Uther the Lightbringer'),
(@UTHER,6,0,"I can resist Frostmourne's call no more...",12,0,100,1,2000,16680,'Uther the Lightbringer');

DELETE FROM `creature_equip_template` WHERE `entry`=37158;
INSERT INTO `creature_equip_template` (`entry`, `id` ,`itemEntry1`,`itemEntry2`,`itemEntry3`) VALUES
(37158,1,49767,0,0);

DELETE FROM `creature_loot_template` WHERE `entry`=37158;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (37158, 50254, -100, 1, 0, 1, 1);

UPDATE `creature_template` SET `modelid1`=30547, `faction_A`=2124, `faction_H`=2124, `modelid2`=0, `AIName`='SmartAI' , `ScriptName`='' WHERE `entry`=@QUEL;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@QUEL AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@QUEL,0,0,1,11,0,100,0,0,668,4820,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Queldelar - On spawn - react passive'),
(@QUEL,0,1,2,61,0,100,1,0,0,0,0,18,768,0,0,0,0,0,1,0,0,0,0,0,0,0,'Queldelar - On spawn - set unitflags'),
(@QUEL,0,2,3,61,0,100,1,0,0,0,0,11,70300,2,0,0,0,0,1,0,0,0,0,0,0,0,'Queldelar - On spawn - cast whirlwind visual'),
(@QUEL,0,3,0,61,0,100,1,0,0,0,0,46,6,0,0,0,0,0,1,0,0,0,0,0,0,0,'Queldelar - On spawn - walk 6 yards'),
(@QUEL,0,4,5,1,0,100,1,10000,10000,0,0,19,768,0,0,0,0,0,1,0,0,0,0,0,0,0,'Queldelar - 10sec OOC - remove unitflags'),
(@QUEL,0,5,6,61,0,100,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Queldelar - 10sec OOC - say text'),
(@QUEL,0,6,7,61,0,100,1,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Queldelar - 10sec OOC - react aggresive'),
(@QUEL,0,7,0,61,0,100,1,0,0,0,0,28,70300,0,0,0,0,0,1,0,0,0,0,0,0,0,'Queldelar - 10sec OOC - remove aura'),
(@QUEL,0,8,0,0,0,100,0,0,1000,10000,11500,11,67541,0,0,0,0,0,1,0,0,0,0,0,0,0,'Queldelar - In combat - cast bladestorm'),
(@QUEL,0,9,0,0,0,100,0,3000,5000,6000,7500,11,29426,0,0,0,0,0,2,0,0,0,0,0,0,0,'Queldelar - In combat - cast heroic strike'),
(@QUEL,0,10,0,0,0,100,0,6000,7000,6000,7500,11,16856,0,0,0,0,0,2,0,0,0,0,0,0,0,'Queldelar - In combat - cast mortal strike'),
(@QUEL,0,11,0,6,0,100,0,0,0,0,0,45,0,1,0,0,0,0,11,@UTHER,100,0,0,0,0,0,'Queldelar - Death - Set data Uther the Lightbringer');

DELETE FROM `creature_text` WHERE `entry`=@QUEL;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@QUEL,0,0,"Quel'Delar prepares to attack!",41,0,100,0,2,0,'Queldelar');
