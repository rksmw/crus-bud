-- Achievement - Crashin' & Trashing
UPDATE `achievement_criteria_data` SET `type`=16, `value1`=141 WHERE `criteria_id`=4090;

-- Crashin' Trashin' Racer SAI
DELETE FROM `creature_template_addon` WHERE `entry`=40281;
INSERT INTO `creature_template_addon` (`entry`,`auras`) VALUES
(40281,'75110');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=40281;
UPDATE `creature_template` SET `flags_extra`=flags_extra|128 WHERE `entry`=27697;
DELETE FROM `smart_scripts` WHERE `entryorguid`=40281 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(40281,0,0,0,54,0,100,0,0,0,0,0,28,49444,0,0,0,0,0,7,0,0,0,0,0,0,0,'Crashin'' Trashin'' Racer - Just summoned - Remove count auras'),
(40281,0,1,2,8,0,100,1,49325,0,0,0,11,40622,2,0,0,0,0,1,0,0,0,0,0,0,0,'Crashin'' Trashin'' Racer - Spellhit - Cast Superjump'),
(40281,0,2,3,61,0,100,0,0,0,0,0,85,49444,2,0,0,0,0,0,0,0,0,0,0,0,0,'Crashin'' Trashin'' Racer - Spellhit - Invoker Cast Racer Kill Counter'),
(40281,0,3,4,61,0,100,0,0,0,0,0,11,49327,2,0,0,0,0,1,0,0,0,0,0,0,0,'Crashin'' Trashin'' Racer - Spellhit - Cast Racer Slam missile'),
(40281,0,4,5,61,0,100,0,0,0,0,0,11,49337,2,0,0,0,0,1,0,0,0,0,0,0,0,'Crashin'' Trashin'' Racer - Spellhit - Cast Racer Slam Explosion'),
(40281,0,5,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Crashin'' Trashin'' Racer - Spellhit - Despawn'),
(40281,0,6,0,23,0,100,0,49440,1,100,100,11,49325,2,0,0,0,0,1,0,0,0,0,0,0,0,'Crashin'' Trashin'' Racer - Has aura - Cast Racer Slam');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=49325;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,1,49325,0,0,31,0,3,40281,0,0,0,'','Racer Slam Resolve - Implicit target - Crashin'' Trashin'' Racer'),
(13,1,49325,0,0,1,0,49440,0,0,1,0,'','Racer Slam Resolve - Implicit target - not charging');

-- Racer Slam Bunny SAI
UPDATE `creature_template` SET `AIName`='SmartAI', `modelid2`=0 WHERE `entry`=27674;
DELETE FROM `smart_scripts` WHERE `entryorguid`=27674 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(27674,0,0,0,54,0,100,0,0,0,0,0,85,49302,0,0,0,0,0,1,0,0,0,0,0,0,0,'Racer Slam Bunny - Just summoned - Racer Slam Hit Destination (see conditions)'),
(27674,0,1,0,54,0,100,0,0,0,0,0,85,49302,0,0,0,0,0,19,40281,15,0,0,0,0,0,'Racer Slam Bunny - Just summoned - Racer Slam Hit Destination (see conditions)');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=27674 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,27674,0,0,29,1,40281,15,0,1,0,'','Racer Slam Bunny - activate SAI if not near Crashin'' Trashin'' Racer'),
(22,2,27674,0,0,29,1,40281,15,0,0,0,'','Racer Slam Bunny - activate SAI if near Crashin'' Trashin'' Racer');

-- Fix [Bros. Before Ho Ho Ho's] 
UPDATE `creature_template` SET `faction_A`=1096, `faction_H`=1096 WHERE `entry`=8140; -- Brother Karman
UPDATE `creature_template` SET `faction_A`=11, `faction_H`=11 WHERE `entry`=739; -- Brother Nimetz
UPDATE `creature_template` SET `faction_A`=11, `faction_H`=11 WHERE `entry`=1182; -- Brother Anton
UPDATE `creature_template` SET `faction_A`=11, `faction_H`=11 WHERE `entry`=927; -- Brother Wilhelm
UPDATE `creature_template` SET `faction_A`=11, `faction_H`=11 WHERE `entry`=1444; -- Brother Kristoff
UPDATE `creature_template` SET `faction_A`=11, `faction_H`=11 WHERE `entry`=5489; -- Brother Joshua
UPDATE `creature_template` SET `faction_A`=11, `faction_H`=11 WHERE `entry`=12336; -- Brother Crowley
UPDATE `creature_template` SET `faction_A`=11, `faction_H`=11 WHERE `entry`=1351; -- Brother Cassius
UPDATE `creature_template` SET `faction_A`=11, `faction_H`=11 WHERE `entry`=5484; -- Brother Benjamin
UPDATE `creature_template` SET `faction_A`=1154, `faction_H`=1154 WHERE `entry`=5661; -- Brother Malach
UPDATE `creature_template` SET `faction_A`=2132, `faction_H`=2132 WHERE `entry`=26044; -- Durkot Wolfbrother
UPDATE `creature_template` SET `faction_A`=1986, `faction_H`=1986 WHERE `entry`=31261; -- Brother Keltan

-- Quest - Into the Soulgrinder
SET @SOUL := 23019;
SET @SKULLOC := 22910;
SET @GHOST := 24039;
SET @BUNNY := 23037;
SET @GUID := 1000183; -- Need 4

UPDATE `creature_template` SET `AIName`='SmartAI', `InhabitType`=4, `flags_extra`=flags_extra|128 WHERE `entry` IN (@SOUL,@BUNNY);
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_A`=16, `faction_H`=16 WHERE `entry` IN (@GHOST,@SKULLOC);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@SOUL,@GHOST,@SKULLOC,-@GUID,-@GUID-1,-@GUID-2,-@GUID-3) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@SOUL,0,0,0,54,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Soulgrinder - Just summoned - Set phase 1'),
(@SOUL,0,1,0,8,0,100,0,39920,0,0,0,23,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Soulgrinder - Spellhit - Increase phase'),
(@SOUL,0,2,0,1,31,75,0,2000,2000,10000,10000,12,@GHOST,6,3000,0,0,0,8,0,0,0,3537.004,5575.947,-1.8631,1.693041,'The Soulgrinder - Update (phases 1 to 5) - Summon Ogre Ghost'),
(@SOUL,0,3,0,1,31,75,0,2000,2000,10000,10000,12,@GHOST,6,3000,0,0,0,8,0,0,0,3550.72,5590.12,-3.7046,3.075341,'The Soulgrinder - Update (phases 1 to 5) - Summon Ogre Ghost'),
(@SOUL,0,4,0,1,31,75,0,2000,2000,10000,10000,12,@GHOST,6,3000,0,0,0,8,0,0,0,3534.102,5607.973,-3.7988,4.752953,'The Soulgrinder - Update (phases 1 to 5) - Summon Ogre Ghost'),
(@SOUL,0,5,0,1,31,75,0,2000,2000,10000,10000,12,@GHOST,6,3000,0,0,0,8,0,0,0,3516.48,5592.525,-2.0653,6.198869,'The Soulgrinder - Update (phases 1 to 5) - Summon Ogre Ghost'),
(@SOUL,0,6,0,1,1,100,1,30000,30000,0,0,45,0,1,0,0,0,0,10,@GUID,@BUNNY,0,0,0,0,0,'The Soulgrinder - Update (phase 1) - Set data Soulgrinder Bunny'),
(@SOUL,0,7,0,1,2,100,1,30000,30000,0,0,45,0,1,0,0,0,0,10,@GUID+1,@BUNNY,0,0,0,0,0,'The Soulgrinder - Update (phase 2) - Set data Soulgrinder Bunny'),
(@SOUL,0,8,0,1,4,100,1,30000,30000,0,0,45,0,1,0,0,0,0,10,@GUID+2,@BUNNY,0,0,0,0,0,'The Soulgrinder - Update (phase 3) - Set data Soulgrinder Bunny'),
(@SOUL,0,9,0,1,8,100,1,30000,30000,0,0,45,0,1,0,0,0,0,10,@GUID+3,@BUNNY,0,0,0,0,0,'The Soulgrinder - Update (phase 4) - Set data Soulgrinder Bunny'),
(@SOUL,0,10,11,1,16,100,1,30000,30000,0,0,51,0,0,0,0,0,0,11,@GHOST,100,0,0,0,0,0,'The Soulgrinder - Update (phase 5) - Kill al ghosts'),
(@SOUL,0,11,12,61,0,100,0,0,0,0,0,28,39920,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Soulgrinder - Link - Remove Beam Auras'),
(@SOUL,0,12,13,61,0,100,0,0,0,0,0,11,39920,0,0,0,0,0,19,@SKULLOC,0,0,0,0,0,0,'The Soulgrinder - Link - Cast Beam on Skulloc'),
(@SOUL,0,13,14,61,0,100,0,0,0,0,0,41,15000,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Soulgrinder - Link - Despawn'),
(@SOUL,0,14,0,61,0,100,0,0,0,0,0,22,6,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Soulgrinder - Link - Set phase 6'),
(@SOUL,0,15,0,38,0,100,0,0,1,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Soulgrinder - Data set - Despawn'),
(-@GUID,0,0,1,38,0,100,0,0,1,0,0,11,39920,2,0,0,0,0,19,@SOUL,100,0,0,0,0,0,'Soulgrinder Bunny - Data set - Cast Soulgrinder Beam'),
(-@GUID,0,1,0,61,0,100,0,0,0,0,0,12,@SKULLOC,6,30000,0,0,0,8,0,0,0,3487.41,5554.52,7.52,0.73,'Soulgrinder Bunny - Data set - Summon Skulloc'),
(-@GUID-1,0,0,1,38,0,100,0,0,1,0,0,11,39920,2,0,0,0,0,19,@SOUL,100,0,0,0,0,0,'Soulgrinder Bunny - Data set - Cast Soulgrinder Beam'),
(-@GUID-1,0,1,0,61,0,100,0,0,0,0,0,86,39944,2,19,@SKULLOC,100,0,19,@SKULLOC,100,0,0,0,0,0,'Soulgrinder Bunny - Data set - Remove aura to Skulloc'),
(-@GUID-2,0,0,1,38,0,100,0,0,1,0,0,11,39920,2,0,0,0,0,19,@SOUL,100,0,0,0,0,0,'Soulgrinder Bunny - Data set - Cast Soulgrinder Beam'),
(-@GUID-2,0,1,0,61,0,100,0,0,0,0,0,86,39946,2,19,@SKULLOC,100,0,19,@SKULLOC,100,0,0,0,0,0,'Soulgrinder Bunny - Data set - Remove aura to Skulloc'),
(-@GUID-3,0,0,1,38,0,100,0,0,1,0,0,11,39920,2,0,0,0,0,19,@SOUL,100,0,0,0,0,0,'Soulgrinder Bunny - Data set - Cast Soulgrinder Beam'),
(-@GUID-3,0,1,0,61,0,100,0,0,0,0,0,28,0,0,0,0,0,0,19,@SKULLOC,100,0,0,0,0,0,'Soulgrinder Bunny - Data set - Remove aura to Skulloc'),
(@GHOST,0,0,1,54,0,100,0,0,0,0,0,11,39916,2,0,0,0,0,1,0,0,0,0,0,0,0,'Sundered Ghost - Just summoned - Transform'),
(@GHOST,0,1,0,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,21,60,0,0,0,0,0,0,'Sundered Ghost - Just summoned - Attack closest player'),
(@GHOST,0,2,0,0,0,100,0,15000,20000,15000,20000,11,11443,0,0,0,0,0,5,0,0,0,0,0,0,0,'Sundered Ghost - In combat - Cast Cripple'),
(@GHOST,0,3,0,0,0,100,0,5000,6000,3000,4000,11,20816,0,0,0,0,0,2,0,0,0,0,0,0,0,'Sundered Ghost - In combat - Cast Shadowbolt'),
(@GHOST,0,4,5,21,0,100,0,0,0,0,0,45,0,1,0,0,0,0,11,@SKULLOC,100,0,0,0,0,0,'Sundered Ghost - Reached Home - Set data Skulloc'),
(@GHOST,0,5,6,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,11,@SOUL,100,0,0,0,0,0,'Sundered Ghost - Reached Home - Set data Soulgrinder'),
(@GHOST,0,6,0,61,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Sundered Ghost - Reached Home - Despawn'),
(@SKULLOC,0,0,1,54,0,100,0,0,0,0,0,11,39943,2,0,0,0,0,1,0,0,0,0,0,0,0,'Skulloc Soulgrinder - Just summoned - Cast Soulgrinder Ritual Visual'),
(@SKULLOC,0,1,2,61,0,100,0,0,0,0,0,18,33554434,0,0,0,0,0,1,0,0,0,0,0,0,0,'Skulloc Soulgrinder - Just summoned - Non attackable'),
(@SKULLOC,0,2,0,61,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Skulloc Soulgrinder - Just summoned - React Passive'),
(@SKULLOC,0,3,0,8,0,100,0,39920,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Skulloc Soulgrinder - Spellhit - Set phase 1'),
(@SKULLOC,0,4,5,23,1,100,1,39920,0,0,0,19,33554434,0,0,0,0,0,1,0,0,0,0,0,0,0,'Skulloc Soulgrinder - Missing Aura - Attackable'),
(@SKULLOC,0,5,6,61,0,100,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Skulloc Soulgrinder - Missing Aura - Non attackable'),
(@SKULLOC,0,6,0,61,0,100,0,0,0,0,0,28,39947,0,0,0,0,0,1,0,0,0,0,0,0,0,'Skulloc Soulgrinder - Missing Aura - Remove Shadowform aura'),
(@SKULLOC,0,7,0,0,0,100,0,5000,6000,10000,15000,11,39621,0,0,0,0,0,5,0,0,0,0,0,0,0,'Skulloc Soulgrinder - In combat - Cast Corruption'),
(@SKULLOC,0,8,0,0,0,100,0,15000,20000,15000,20000,11,39622,0,0,0,0,0,6,0,0,0,0,0,0,0,'Skulloc Soulgrinder - In combat - Cast Banish'),
(@SKULLOC,0,9,0,6,0,100,0,0,0,0,0,11,39909,2,0,0,0,0,1,0,0,0,0,0,0,0,'Skulloc Soulgrinder - Death - Summon Skulloc Soul Chest'),
(@SKULLOC,0,10,0,38,0,100,0,0,1,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Skulloc Soulgrinder - Data set - Despawn');

DELETE FROM `creature_template_addon` WHERE `entry`=@SOUL;
INSERT INTO `creature_template_addon` (`entry`,`auras`) VALUES
(@SOUL,'39918');

DELETE FROM `gameobject` WHERE `id`=185577;
DELETE FROM `creature` WHERE `id`=@BUNNY AND `guid` BETWEEN @GUID AND @GUID+3;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@GUID,@BUNNY,530,1,1,0,0,3491.45,5528.56,20.1852,0.977126,300,0,0,42,0,0,0,0,0),
(@GUID+1,@BUNNY,530,1,1,0,0,3464.34,5563.98,20.5376,0.390432,300,0,0,42,0,0,0,0,0),
(@GUID+2,@BUNNY,530,1,1,0,0,3469.69,5580.62,22.7957,0.185442,300,0,0,42,0,0,0,0,0),
(@GUID+3,@BUNNY,530,1,1,0,0,3515.12,5524.71,21.6635,1.29285,300,0,0,42,0,0,0,0,0);

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=-39946;
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(-39946,39947,0,'Soulgrinder Ritual Visual (Shadowform 3 to 4)');

DELETE FROM `event_scripts` WHERE `id`=14739;
INSERT INTO `event_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`x`,`y`,`z`,`o`) VALUES
(14739,0,10,@SOUL,300000,3535.119,5590.336,0.18324,3.889396);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=40328;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17,0,40328,0,0,29,0,@SOUL,100,0,1,0,'','Vim''gol''s Cantation cannot be casted if Soulgrinder near'),
(17,0,40328,0,0,29,0,@SKULLOC,100,0,1,0,'','Vim''gol''s Cantation cannot be casted if Skulloc near');

-- Achievement - BB King
DELETE FROM `game_event_gameobject` WHERE `eventEntry`=52 AND `guid` IN (SELECT `guid` FROM `gameobject` WHERE `id`=187236);
DELETE FROM `gameobject` WHERE `id`=187236;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(NULL,187236,1,1,1,1624.54,-4411.9,15.3526,5.22957,0,0,0.502776,-0.864416,300,0,1),
(NULL,187236,0,1,1,-4919.62,-983.516,501.455,5.57557,0,0,0.346472,-0.93806,300,0,1);

SET @GUID := (SELECT `guid` FROM `gameobject` WHERE `id`=187236 ORDER BY `guid` LIMIT 1);
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES
(52,@GUID),
(52,@GUID+1);

DELETE FROM `gameobject_queststarter` WHERE `id`=187236;
INSERT INTO `gameobject_queststarter` (`id`,`quest`) VALUES
(187236,13966);

DELETE FROM `gameobject_questender` WHERE `id`=187236;
INSERT INTO `gameobject_questender` (`id`,`quest`) VALUES
(187236,13966);

-- Fix target Manitas Mekkatorque (High Tinker Mekkatorque) now fix untarget from npc and scope.
UPDATE `creature_template` SET `unit_flags`=unit_flags&~256 WHERE `entry`=7937;
