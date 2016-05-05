-- Halls Of Reflexion WIP
DELETE FROM `creature_template` WHERE `entry`IN (36955,36993,37221,37226,36954,37107);
INSERT INTO `creature_template`
VALUES
(36955,0,0,0,0,0,30867,0,0,0,'Lady Jaina Proudmoore','','',10909,80,80,2,84,84,2,1,1.14286,1,1,346,499,0,287,7.5,0,0,8,0,2048,8,0,0,0,0,0,315,468,69,7,262144,0,0,0,0,0,0,0,0,0,69708,0,0,0,0,0,0,0,0,0,0,0,'',0,3,1,500,100,1,0,0,0,0,0,0,0,0,1,0,0,'npc_jaina_or_sylvanas_escape_hor',12340),
(36993,0,0,0,0,0,30867,0,0,0,'Lady Jaina Proudmoore','','',0,80,80,2,35,35,2,1,1.14286,1,1,346,499,0,287,7.5,0,0,8,0,2048,8,0,0,0,0,0,315,468,69,7,0,0,0,0,0,0,0,0,0,0,38384,70132,32192,70464,0,0,0,0,0,0,0,0,'',0,3,1,500,100,1,0,0,0,0,0,0,0,0,1,0,0,'',12340),
(36954,0,0,0,0,0,30721,0,0,0,'The Lich King','','',0,83,83,2,2102,2102,0,2,1,1,3,509,683,0,805,35,2000,0,1,256,2048,8,0,0,0,0,0,371,535,135,6,268435500,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'',0,3,1,2000,500,1,0,0,0,0,0,0,0,117,1,8388624,0,'',12340),
(37107,0,0,0,0,0,24653,0,0,0,'Spiritual Reflection','','',0,80,80,2,35,35,0,1,1.14286,1,1,422,586,0,642,7.5,0,0,1,0,2048,8,0,0,0,0,0,345,509,103,7,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'',0,3,1,4,1,1,0,0,0,0,0,0,0,113,1,0,0,'',12340),
(37226,0,0,0,0,0,30721,0,0,0,'The Lich King','','',0,83,83,2,2102,2102,0,2,1.42857,1,3,509,683,0,805,35,2000,0,1,768,2048,8,0,0,0,0,0,371,535,135,6,36,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'',0,3,1,2000,500,1,0,0,0,0,0,0,0,151,1,617299955,0,'',12340),
(37221,0,0,0,0,0,30867,0,0,0,'Lady Jaina Proudmoore','','',11031,80,80,2,35,35,2,1,1,1,1,346,499,0,287,7.5,2000,0,8,33600,2048,8,0,0,0,0,0,315,468,69,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'',0,3,1,500,100,1,0,0,0,0,0,0,0,0,1,0,0,'npc_jaina_or_sylvanas_hor',12340);

DELETE FROM `gameobject_template` WHERE `entry` IN (201385, 201885, 202396, 201596,201709,202211);
INSERT INTO `gameobject_template`
VALUES
(201385,0,9214,'Ice Wall','','','',0,0,2.5,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',12340),
(201885,0,9214,'Ice Wall','','','',0,18,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',12340),
(202396,0,9214,'Ice Wall','','','',114,33,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',12340),
(201596,0,9223,'Cave In','','','',0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',12340),
(201709,0,9288,'Gunship Stairs','','','',0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',12340),
(202211,0,9289,'Gunship Stairs','','','',0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',12340);

DELETE FROM `script_waypoint` WHERE `entry` IN(36955,36954,37554);

DELETE FROM `gameobject` WHERE `id` IN (201385, 201885, 202396 , 201596, 201709, 202211, 202079, 202212, 201710, 202337, 202336 );
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) 
VALUES
('201596','668','3','1','5275.91','1693.72','786.151','4.05956','0','0','0.896503','-0.443037','25','0','0'),
('202079','631','15','1','-72.7031','2282.45','32.8673','-1.5708','0','0','0','1','6000','100','1'),
('202396','631','15','1','4309.69','2491.27','211.171','0.209439','0','0','0','0','120','0','0'),
('201885','658','3','1','932.267','-80.6684','591.676','2.28638','0','0','0','0','300','100','1'),
('201709','668','3','1','5228.35','1640.96','783.731','5.58505','0','0','0','1','-7200','255','1'),
('201709','668','3','1','5215.89','1626.08','796.456','5.58505','0','0','0','1','-7200','255','1'),
('202211','668','3','1','5242.83','1623.45','784.15','5.81195','0','0','0','1','-7200','255','1'),
('202211','668','3','1','5225.2','1589.1','808.551','5.81195','0','0','0','1','-7200','255','1'),
('202211','668','3','1','5233.98','1606.31','796.254','5.81195','0','0','0','1','-7200','255','1'),
('201710','712','1','1','-11.7548','12.0246','20.4083','3.21707','0','0','0','1','7200','255','1'),
('202336','712','2','1','-11.7548','12.0246','20.4083','3.21707','0','0','0','1','7200','255','1'),
('202212','713','1','1','12.2333','22.4732','35.0743','1.23918','0','0','0','1','7200','255','1'),
('202337','713','2','1','12.2333','22.4732','35.0743','1.23918','0','0','0','1','7200','255','1');


DELETE FROM `creature` WHERE `guid` IN (202308,202294,202301,202293);
-- extra spawned Uther -- 202294
-- extra LK spawn -- 202301
-- Loralen -- 202293
-- Lady Jaina Proudmoore -- 202308
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(202308,38112,668,3,1,0,0,5276.583,2037.45,709.4025,5.532694,604800,0,0,0,0,0,0,0,0),
(202294,38113,668,3,1,0,0,5342.232,1975.696,709.4025,2.391101,604800,0,0,0,0,0,0,0,0),
(202301,36723,668,3,2,0,0,5415.538,2117.842,707.7781,3.944444,604800,0,0,0,0,0,0,0,0);
-- Lady Jaina Proudmoore
UPDATE `creature_template` SET `ScriptName`='npc_jaina_or_sylvanas_hor' WHERE `entry`=37221;
-- Lady Sylvanas Windrunner
UPDATE `creature_template` SET `ScriptName`='npc_jaina_or_sylvanas_hor' WHERE `entry`=37223;
-- Frostmourne Altar Bunny (Quel'Delar)
UPDATE `creature_template` SET `InhabitType`=4,`flags_extra`=128 WHERE `entry`=37704;
-- Frostsworn General
UPDATE `creature_template` SET `ScriptName`='npc_frostworn_general' WHERE `entry`=36723;
UPDATE `creature_template` SET `faction_A`=16,`faction_H`=16 WHERE `entry`=37720; -- for hc
-- Spiritual Reflection
UPDATE `creature_template` SET /*`modelid1`=57,*/`ScriptName`='npc_spiritual_reflection' WHERE `entry`=37068;
-- Falric and Marwyn bind players to instance on heroic
UPDATE `creature_template` SET `flags_extra`=1 WHERE `entry` IN (38599,38603);

DELETE FROM `areatrigger_scripts` WHERE `entry` IN (5697,5632);
INSERT INTO `areatrigger_scripts` VALUES
-- AreaTrigger for waves restarter
(5697,'at_hor_waves_restarter'),
-- AreaTrigger for intro start
(5632,'at_hor_intro_start');

DELETE FROM `creature_text` WHERE (`entry`=37226 AND `groupid` IN (3,4)) OR `entry`=36723 OR `entry`=36954 OR `entry`=36955 OR `entry`=37554 OR `entry`=30344 OR `entry`=30824;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
-- The Lich King (at start)
(37226,3,0,'Foolish girl. You seek that, which I killed long ago. He is nearly a ghost now. A fate ago in my mind.',14,0,100,0,0,17229,'Lich King SAY_LK_JAINA_INTRO_END'),
(37226,4,0,'I will not make the same mistake again. This time there will be no escape. You fail to serve me in undead. Now, all that remains for you is oblivion!',14,0,100,0,0,17228,'Lich King SAY_LK_SYLVANAS_INTRO_END'),
-- Frostsworn General
(36723,0,0,'You are not worthy to face the Lich King!',14,0,100,0,0,16921,'general SAY_AGGRO'),
(36723,1,0,'Master, I have failed...',14,0,100,0,0,16922,'general SAY_DEATH'),
-- The Lich King (at chase event)
(36954,0,0,'Your allies have arrived, Jaina, just as you promised. You will all become powerful agents of the Scourge.',14,0,100,0,0,17212, 'Lich King SAY_LICH_KING_AGGRO_A'),
(36954,1,0,'I will not make the same mistake again, Sylvanas. This time there will be no escape. You will all serve me in death!',14,0,100,0,0,17213,'Lich King SAY_LICH_KING_AGGRO_H'),
(36954,2,0,'Succumb to the chill of the grave.',14,0,100,0,0,17218,'Lich King SAY_LICH_KING_WALL_02'),
(36954,3,0,'Another dead end.',14,0,100,0,0,17219,'Lich King SAY_LICH_KING_WALL_03'),
(36954,4,0,'How long can you fight it?',14,0,100,0,0,17220,'Lich King SAY_LICH_KING_WALL_04'),
(36954,5,0,'There is no escape!', 14,0,100,0,0,17217,'Lich King SAY_LICH_KING_WALL_01'),
(36954,6,0,'Rise minions, do not left them us!',14,0,100,0,0,17216,'Lich King SAY_LICH_KING_GNOUL'),
(36954,7,0,'Minions sees them. Bring their corpses back to me!',14,0,100,0,0,17222,'Lich King SAY_LICH_KING_ABON'),
(36954,8,0,'Death''s cold embrace awaits.',14,0,100,0,0,17221,'Lich King SAY_LICH_KING_WINTER'),
(36954,9,0,'Nowhere to run! You''re mine now...',14,0,100,0,0,17223,'Lich King SAY_LICH_KING_END_DUN'),
(36954,10,0,'All is lost!',14,0,100,0,0,17215,'Lich King SAY_LICH_KING_WIN'),
-- Lady Jaina Proudmoore (at chase event)
(36955,0,0,'He is too powerful, we must leave this place at once! My magic will hold him in place for only a short time! Come quickly, heroes!',14,0,100,1,0,16644,'Jaina SAY_JAINA_AGGRO'),
(36955,1,0,'I will destroy this barrier. You must hold the undead back!',14,0,100,0,0,16607,'Jaina SAY_JAINA_WALL_01'),
(36955,2,0,'Another ice wall! Keep the undead from interrupting my incantation so that I may bring this wall down!',14,0,100,0,0,16608,'Jaina SAY_JAINA_WALL_02'),
(36955,3,0,'He is toying with us! I will show him what happens to ice when it meets fire!',14,0,100,0,0,16609,'Jaina SAY_JAINA_WALL_03'),
(36955,4,0,'Your barriers can''t hold us back much longer, monster. I will shatter them all!',14,0,100,0,0,16610,'Jaina SAY_JAINA_WALL_04'),
(36955,5,0,'There''s an opening up ahead. GO NOW!', 14,0,100,1,0,16645,'Jaina SAY_JAINA_ESCAPE_01'),
(36955,6,0,'We''re almost there... Don''t give up!',14,0,100,0,0,16646,'Jaina SAY_JAINA_ESCAPE_02'),
(36955,7,0,'It... It''s a dead end. We have no choice but to fight. Steel yourself heroes, for this is our last stand!',14,0,100,1,0,16647,'Jaina SAY_JAINA_TRAP'),
(36955,8,0,'Forgive me heroes, I should have listened to Uther. I ... I had to see for myself, to look into his eyes one last time ... I am sorry.',14,0,100,1,0,16648,'Jaina SAY_JAINA_FINAL_2'),
(36955,9,0,'We now know what must be done. I will deliver this news to King Varian and Highlord Fordring.',14,0,100,1,0,16649,'Jaina SAY_JAINA_FINAL_3'),
-- Lady Sylvanas Windrunner (at chase event)
(37554,0,0,'He''s too powerful! Heroes, quickly, come to me! We must leave this place immediately! I will do what I can do hold him in place while we flee.',14,0,100,0,0,17058,'Sylvanas SAY_SYLVANA_AGGRO'),
(37554,1,0,'No wall can hold the Banshee Queen! Keep the undead at bay, heroes! I will tear this barrier down!',14,0,100,0,0,17029,'Sylvanas SAY_SYLVANA_WALL_01'),
(37554,2,0,'Another barrier? Stand strong, champions! I will bring the wall down!',14,0,100,0,0,17030,'Sylvanas SAY_SYLVANA_WALL_02'),
(37554,3,0,'I grow tired of these games, Arthas! Your walls can\'t stop me!',14,0,100,0,0,17031,'Sylvanas SAY_SYLVANA_WALL_03'),
(37554,4,0,'You won''t impede our escape, fiend. Keep the undead off me while I bring this barrier down!',14,0,100,0,0,17032,'Sylvanas SAY_SYLVANA_WALL_04'),
(37554,5,0,'There''s an opening up ahead. GO NOW!',14,0,100,1,0,17059,'Sylvanas SAY_SYLVANA_ESCAPE_01'),
(37554,6,0,'We''re almost there! Don''t give up!',14,0,100,0,0,17060,'Sylvanas SAY_SYLVANA_ESCAPE_02'),
(37554,7,0,'BLASTED DEAD END! So this is how it ends. Prepare yourselves, heroes, for today we make our final stand!',14,0,100,5,0,17061,'Sylvanas SAY_SYLVANA_TRAP'),
(37554,8,0,'We are safe... for now. His strength has increased tenfold since our last battle. It will take a mighty army to destroy the Lich King. An army greater than even the Horde can rouse.',14,0,100,1,0,17062,'Sylvanas SAY_SYLVANA_FINAL_2'),
-- High Captain Justin Bartlett
(30344,0,0,'Fire, fire!',14,0,100,0,0,16721,'Bartlett SAY_BARTLETT_FIRE'),
(30344,1,0,'Quickly, climb aboard! We mustn''t tarry here. There''s no telling when this whole mountainside will collapse!',14,0,100,0,0,16722,'Bartlett SAY_BARTLETT_FINAL_1'),
-- Sky-Reaver Korm Blackscar
(30824,0,0,'FIRE! FIRE!',14,0,100,0,0,0,'Korm SAY_KORM_FIRE'),
(30824,1,0,'Quickly, climb aboard! We mustn''t tarry here. There''s no telling when this whole mountainside will collapse!',14,0,100,0,0,0,'Korm SAY_KORM_FINAL_1');

/*
# 3+4+4+5 +4+4+5+5 = 16+18
# if 1st boss is dead and we wipe counter starts at wave 6
SET @CGUID  := 400000;
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+33;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
-- pos 1
(@CGUID+4, 38177, 668, 3, 1, 5277.365, 1993.229, 707.7781, 0.4014257, 7200, 0, 0),
(@CGUID+31, 38172, 668, 3, 1, 5280.513, 1997.842, 707.7781, 0.296706, 7200, 0, 0),
(@CGUID+5, 38175, 668, 3, 1, 5275.479, 2001.135, 707.7781, 0.1745329, 7200, 0, 0),
(@CGUID+19, 38172, 668, 3, 1, 5279.649, 2004.656, 707.7781, 0.06981317, 7200, 0, 0),
(@CGUID+10, 38172, 668, 3, 1, 5275.076, 2008.724, 707.7781, 6.213372, 7200, 0, 0),
(@CGUID+25, 38176, 668, 3, 1, 5280.632, 2012.156, 707.7781, 6.056293, 7200, 0, 0),
(@CGUID+15, 38175, 668, 3, 1, 5277.739, 2016.882, 707.7781, 5.969026, 7200, 0, 0),
(@CGUID+29, 38176, 668, 3, 1, 5282.897, 2019.597, 707.7781, 5.88176, 7200, 0, 0),
-- pos 2
(@CGUID+1, 38172, 668, 3, 1, 5295.885, 2040.342, 707.7781, 5.078908, 7200, 0, 0),
(@CGUID+33, 38176, 668, 3, 1, 5299.25, 2035.998, 707.7781, 5.026548, 7200, 0, 0),
(@CGUID+6, 38172, 668, 3, 1, 5302.448, 2042.222, 707.7781, 4.904375, 7200, 0, 0),
(@CGUID+20, 38173, 668, 3, 1, 5306.057, 2037.002, 707.7781, 4.817109, 7200, 0, 0),
(@CGUID+0, 38175, 668, 3, 1, 5309.577, 2042.668, 707.7781, 4.694936, 7200, 0, 0),
(@CGUID+23, 38175, 668, 3, 1, 5312.752, 2037.122, 707.7781, 4.590216, 7200, 0, 0),
(@CGUID+11, 38173, 668, 3, 1, 5316.701, 2041.55, 707.7781, 4.502949, 7200, 0, 0),
(@CGUID+30, 38177, 668, 3, 1, 5318.704, 2036.108, 707.7781, 4.223697, 7200, 0, 0),
(@CGUID+16, 38173, 668, 3, 1, 5322.964, 2040.288, 707.7781, 4.34587, 7200, 0, 0),
-- pos 3
(@CGUID+28, 38173, 668, 3, 1, 5336.599, 2017.278, 707.7781, 3.473205, 7200, 0, 0),
(@CGUID+17, 38176, 668, 3, 1, 5343.467, 2015.951, 707.7781, 3.490659, 7200, 0, 0),
(@CGUID+32, 38173, 668, 3, 1, 5337.833, 2010.057, 707.7781, 3.228859, 7200, 0, 0),
(@CGUID+12, 38173, 668, 3, 1, 5344.15, 2007.168, 707.7781, 3.159046, 7200, 0, 0),
(@CGUID+21, 38176, 668, 3, 1, 5337.865, 2003.403, 707.7781, 2.984513, 7200, 0, 0),
(@CGUID+7, 38177, 668, 3, 1, 5343.293, 1999.384, 707.7781, 2.9147, 7200, 0, 0),
(@CGUID+24, 38173, 668, 3, 1, 5335.724, 1996.859, 707.7781, 2.740167, 7200, 0, 0),
(@CGUID+2, 38173, 668, 3, 1, 5340.836, 1992.458, 707.7781, 2.75762, 7200, 0, 0),
-- pos 4
(@CGUID+3, 38176, 668, 3, 1, 5325.072, 1977.597, 707.7781, 2.076942, 7200, 0, 0),
(@CGUID+8, 38176, 668, 3, 1, 5295.635, 1973.757, 707.7781, 1.186824, 7200, 0, 0),
(@CGUID+9, 38177, 668, 3, 1, 5311.031, 1972.229, 707.7781, 1.64061, 7200, 0, 0),
(@CGUID+13, 38176, 668, 3, 1, 5319.158, 1973.998, 707.7781, 1.919862, 7200, 0, 0),
(@CGUID+14, 38177, 668, 3, 1, 5302.247, 1972.415, 707.7781, 1.37881, 7200, 0, 0),
(@CGUID+18, 38172, 668, 3, 1, 5313.82, 1978.146, 707.7781, 1.745329, 7200, 0, 0),
(@CGUID+22, 38177, 668, 3, 1, 5299.434, 1979.009, 707.7781, 1.239184, 7200, 0, 0),
(@CGUID+26, 38172, 668, 3, 1, 5320.369, 1980.125, 707.7781, 2.007129, 7200, 0, 0),
(@CGUID+27, 38172, 668, 3, 1, 5306.572, 1977.474, 707.7781, 1.500983, 7200, 0, 0);
*/

/*
-- Uther the Lightbringer missing emotes
UPDATE `creature_text` SET `emote`=5 WHERE `entry`=37225 AND `groupid` IN (0,4,8,15) AND `id`=0;
UPDATE `creature_text` SET `emote`=1 WHERE `entry`=37225 AND `groupid` IN (1,2,3,5,6,7,9,10,11,12,13,14) AND `id`=0;
-- Falric missing emotes
UPDATE `creature_text` SET `emote`=2 WHERE `entry`=38112 AND `groupid`=5 AND `id`=0;
-- Marwyn missing emotes
UPDATE `creature_text` SET `emote`=2 WHERE `entry`=38113 AND `groupid`=4 AND `id`=0;
UPDATE `creature_text` SET `emote`=397 WHERE `entry`=38113 AND `groupid`=0 AND `id`=0;
-- Falric and Marwyn bind players to instance on heroic
UPDATE `creature_template` SET `flags_extra`=1 WHERE `entry` IN (38599,38603);
-- Frostsworn General
UPDATE `creature_template` SET `ScriptName`='npc_frostworn_general' WHERE `entry`=36723;
UPDATE `creature_template` SET `faction_A`=16,`faction_H`=16 WHERE `entry`=37720; -- for hc
-- Spiritual Reflection
UPDATE `creature_template` SET `modelid1`=57,`ScriptName`='npc_spiritual_reflection' WHERE `entry`=37068;
-- The Lich King (at chase event)
UPDATE `creature_template` SET `ScriptName`='boss_lich_king_hor' WHERE `entry`=36954;
-- Lady Jaina Proudmoore (at chase event)
UPDATE `creature_template` SET `faction_A`=1770,`faction_H`=1770,`unit_flags`=64|256|32768,`ScriptName`='npc_jaina_and_sylvana_hor_part2' WHERE `entry`=36955;
-- Lady Sylvanas Windrunner (at chase event)
UPDATE `creature_template` SET `ScriptName`='npc_jaina_and_sylvana_hor_part2' WHERE `entry`=37554;
-- High Captain Justin Bartlett
#UPDATE `creature_template` SET `npcflag`=3 WHERE `entry`=30344;
-- Sky-Reaver Korm Blackscar
#UPDATE `creature_template` SET `npcflag`=3 WHERE `entry`=30824;
-- Raging Ghoul
UPDATE `creature_template` SET `AIName`='',`Scriptname`='npc_raging_ghoul' WHERE `entry`=36940;
-- Risen Witch Doctor
UPDATE `creature_template` SET `AIName`='',`Scriptname`='npc_risen_witch_doctor' WHERE `entry`=36941;
-- Lumbering Abomination
UPDATE `creature_template` SET `AIName`='',`Scriptname`='npc_lumbering_abomination' WHERE `entry`=37069;
-- Frostmourne Altar Bunny (Quel'Delar)
UPDATE `creature_template` SET `InhabitType`=4,`flags_extra`=128 WHERE `entry`=37704;
DELETE FROM `conditions` WHERE `SourceEntry`=70063 AND `SourceTypeOrReferenceId`=13;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,70063,0,0,32,0,144,0,0,0,0,'','Fury of Frostmourne - target players');
-- AreaTrigger for waves restarter
DELETE FROM `areatrigger_scripts` WHERE `entry`=5697;
INSERT INTO `areatrigger_scripts` VALUES
(5697,'at_hor_waves_restarter');
SET @GUID_CREATURE := 400000;
DELETE FROM `creature` WHERE `map`=668 AND `guid` BETWEEN @GUID_CREATURE+0 AND @GUID_CREATURE+3;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@GUID_CREATURE+0,37704,668,3,1,0,0,5309.135,2006.21,715.7825,3.961897,604800,0,0,0,0,0,0,0,0),
(@GUID_CREATURE+1,38112,668,3,1,0,0,5276.583,2037.45,709.4025,5.532694,604800,0,0,0,0,0,0,0,0),
(@GUID_CREATURE+2,38113,668,3,1,0,0,5342.232,1975.696,709.4025,2.391101,604800,0,0,0,0,0,0,0,0),
(@GUID_CREATURE+3,36723,668,3,1,0,0,5415.538,2117.842,707.7781,3.944444,604800,0,0,0,0,0,0,0,0);
DELETE FROM `script_waypoint` WHERE `entry` IN(36955,36954,37554);
INSERT INTO `script_waypoint` VALUES
-- Jaina
(36955,0,5587.682,2228.586,733.011,0,'WP1'),
(36955,1,5600.715,2209.058,731.618,0,'WP2'),
(36955,2,5606.417,2193.029,731.129,0,'WP3'),
(36955,3,5598.562,2167.806,730.918,0,'WP4 - Summon IceWall 01'),
(36955,4,5556.436,2099.827,731.827,0,'WP5 - Spell Channel'),
(36955,5,5543.498,2071.234,731.702,0,'WP6'),
(36955,6,5528.969,2036.121,731.407,0,'WP7'),
(36955,7,5512.045,1996.702,735.122,0,'WP8'),
(36955,8,5504.490,1988.789,735.886,0,'WP9 - Spell Channel'),
(36955,9,5489.645,1966.389,737.653,0,'WP10'),
(36955,10,5475.517,1943.176,741.146,0,'WP11'),
(36955,11,5466.930,1926.049,743.536,0,'WP12'),
(36955,12,5445.157,1894.955,748.757,0,'WP13 - Spell Channel'),
(36955,13,5425.907,1869.708,753.237,0,'WP14'),
(36955,14,5405.118,1833.937,757.486,0,'WP15'),
(36955,15,5370.324,1799.375,761.007,0,'WP16'),
(36955,16,5335.422,1766.951,767.635,0,'WP17 - Spell Channel'),
(36955,17,5311.438,1739.390,774.165,0,'WP18'),
(36955,18,5283.589,1703.755,784.176,0,'WP19'),
(36955,19,5260.400,1677.775,784.301,3000,'WP20'),
(36955,20,5262.439,1680.410,784.294,0,'WP21'),
(36955,21,5260.400,1677.775,784.301,0,'WP22'),
-- Sylvana
(37554,0,5587.682,2228.586,733.011,0,'WP1'),
(37554,1,5600.715,2209.058,731.618,0,'WP2'),
(37554,2,5606.417,2193.029,731.129,0,'WP3'),
(37554,3,5598.562,2167.806,730.918,0,'WP4 - Summon IceWall 01'),
(37554,4,5556.436,2099.827,731.827,0,'WP5 - Spell Channel'),
(37554,5,5543.498,2071.234,731.702,0,'WP6'),
(37554,6,5528.969,2036.121,731.407,0,'WP7'),
(37554,7,5512.045,1996.702,735.122,0,'WP8'),
(37554,8,5504.490,1988.789,735.886,0,'WP9 - Spell Channel'),
(37554,9,5489.645,1966.389,737.653,0,'WP10'),
(37554,10,5475.517,1943.176,741.146,0,'WP11'),
(37554,11,5466.930,1926.049,743.536,0,'WP12'),
(37554,12,5445.157,1894.955,748.757,0,'WP13 - Spell Channel'),
(37554,13,5425.907,1869.708,753.237,0,'WP14'),
(37554,14,5405.118,1833.937,757.486,0,'WP15'),
(37554,15,5370.324,1799.375,761.007,0,'WP16'),
(37554,16,5335.422,1766.951,767.635,0,'WP17 - Spell Channel'),
(37554,17,5311.438,1739.390,774.165,0,'WP18'),
(37554,18,5283.589,1703.755,784.176,0,'WP19'),
(37554,19,5260.400,1677.775,784.301,3000,'WP20'),
(37554,20,5262.439,1680.410,784.294,0,'WP21'),
(37554,21,5260.400,1677.775,784.301,0,'WP22'),
-- Lich King
(36954,1,5577.19,2236,733.012,0,'HoR WP LichKing'),
(36954,2,5580.57,2232.22,733.012,0,'HoR WP LichKing'),
(36954,3,5586.67,2225.54,733.012,0,'HoR WP LichKing'),
(36954,4,5590.45,2221.41,733.012,0,'HoR WP LichKing'),
(36954,5,5595.75,2215.62,732.101,0,'HoR WP LichKing'),
(36954,6,5601.21,2206.49,731.54,0,'HoR WP LichKing'),
(36954,7,5605.01,2197.9,731.667,0,'HoR WP LichKing'),
(36954,8,5606.55,2191.39,730.977,0,'HoR WP LichKing'),
(36954,9,5604.68,2186.11,730.998,0,'HoR WP LichKing'),
(36954,10,5602.26,2179.9,730.967,0,'HoR WP LichKing'),
(36954,11,5600.06,2174.38,730.924,0,'HoR WP LichKing'),
(36954,12,5597.29,2166.81,730.924,0,'HoR WP LichKing'),
(36954,13,5596.25,2160.36,730.931,0,'HoR WP LichKing'),
(36954,14,5591.79,2152.87,731.008,0,'HoR WP LichKing'),
(36954,15,5585.47,2146.63,731.109,0,'HoR WP LichKing'),
(36954,16,5579.1,2140.34,731.18,0,'HoR WP LichKing'),
(36954,17,5572.56,2134.21,731.092,0,'HoR WP LichKing'),
(36954,18,5564.08,2126.53,730.816,0,'HoR WP LichKing'),
(36954,19,5559.04,2117.64,730.812,0,'HoR WP LichKing'),
(36954,20,5555.77,2111.88,730.995,0,'HoR WP LichKing'),
(36954,21,5550.82,2103.14,731.123,0,'HoR WP LichKing'),
(36954,22,5546.02,2094.68,731.16,0,'HoR WP LichKing'),
(36954,23,5541.53,2084.42,730.999,0,'HoR WP LichKing'),
(36954,24,5537.5,2075.18,730.901,0,'HoR WP LichKing'),
(36954,25,5533.76,2063.84,730.87,0,'HoR WP LichKing'),
(36954,26,5530.97,2052.98,730.981,0,'HoR WP LichKing'),
(36954,27,5526.75,2041.73,731.193,0,'HoR WP LichKing'),
(36954,28,5522.88,2031.65,731.7,0,'HoR WP LichKing'),
(36954,29,5521.01,2023.02,732.396,0,'HoR WP LichKing'),
(36954,30,5516.55,2015.36,733.12,0,'HoR WP LichKing'),
(36954,31,5513.06,2007.33,733.99,0,'HoR WP LichKing'),
(36954,32,5510.43,1997.9,735.016,0,'HoR WP LichKing'),
(36954,33,5504.53,1990.39,735.748,0,'HoR WP LichKing'),
(36954,34,5499.34,1983.78,736.29,0,'HoR WP LichKing'),
(36954,35,5493.11,1975.86,736.852,0,'HoR WP LichKing'),
(36954,36,5487.58,1968.81,737.394,0,'HoR WP LichKing'),
(36954,37,5483.12,1961.78,738.06,0,'HoR WP LichKing'),
(36954,38,5478.33,1954.2,739.343,0,'HoR WP LichKing'),
(36954,39,5475.2,1945.84,740.697,0,'HoR WP LichKing'),
(36954,40,5472.15,1938.02,741.884,0,'HoR WP LichKing'),
(36954,41,5469.26,1931.34,742.813,0,'HoR WP LichKing'),
(36954,42,5464.23,1922.25,744.055,0,'HoR WP LichKing'),
(36954,43,5458.43,1912.96,745.229,0,'HoR WP LichKing'),
(36954,44,5452.26,1902.95,747.091,0,'HoR WP LichKing'),
(36954,45,5442.44,1892.51,749.208,0,'HoR WP LichKing'),
(36954,46,5435.67,1879.7,751.776,0,'HoR WP LichKing'),
(36954,47,5429.03,1870.73,753.151,0,'HoR WP LichKing'),
(36954,48,5423.72,1862.16,754.263,0,'HoR WP LichKing'),
(36954,49,5417.21,1851.7,755.507,0,'HoR WP LichKing'),
(36954,50,5408.94,1838.38,757.002,0,'HoR WP LichKing'),
(36954,51,5398.8,1829.61,757.742,0,'HoR WP LichKing'),
(36954,52,5388.47,1817.95,759.285,0,'HoR WP LichKing'),
(36954,53,5378.23,1808.5,760.316,0,'HoR WP LichKing'),
(36954,54,5368.5,1801.35,760.845,0,'HoR WP LichKing'),
(36954,55,5360.86,1793.16,762.271,0,'HoR WP LichKing'),
(36954,56,5353.62,1785.4,763.868,0,'HoR WP LichKing'),
(36954,57,5344.78,1776.09,765.759,0,'HoR WP LichKing'),
(36954,58,5336.38,1768.67,767.324,0,'HoR WP LichKing'),
(36954,59,5327.56,1760.12,769.332,0,'HoR WP LichKing'),
(36954,60,5319.62,1750.7,771.487,0,'HoR WP LichKing'),
(36954,61,5313.12,1742.99,773.424,0,'HoR WP LichKing'),
(36954,62,5305.41,1735.79,775.473,0,'HoR WP LichKing'),
(36954,63,5298.93,1728.16,777.573,0,'HoR WP LichKing'),
(36954,64,5292.54,1720.37,779.862,0,'HoR WP LichKing'),
(36954,65,5287.11,1713.96,781.667,0,'HoR WP LichKing'),
(36954,66,5280.14,1705.21,784.65,0,'HoR WP LichKing'),
(36954,67,5277.98,1701.28,785.224,0,'HoR WP LichKing');*/

-- Halls of Reflexion WIP

-- areatrigger for the shadow throne
DELETE FROM `areatrigger_scripts` WHERE `entry` = 5605;
INSERT INTO `areatrigger_scripts` (`entry`,`scriptname`) VALUES
(5605, 'at_shadow_throne');

-- jaina's equipment
DELETE FROM `creature_equip_template` WHERE `entry` = 36955 AND `id` = 1;
INSERT INTO `creature_equip_template` (`entry`, `id`, `itementry1`, `itementry2`,`itementry3`) VALUES
(36955, 1, 2177, 12869, 0);

-- jaina's gossip menu (the same one FROM sylvanas)
UPDATE `creature_template` SET `gossip_menu_id` = 10909 WHERE `entry` = 36955;

-- jaina's scriptai part 2
UPDATE `creature_template` SET `ScriptName` = 'npc_jaina_or_sylvanas_escape_hor' WHERE `entry` in (36955, 37554);

-- Raging Ghoul scriptai
UPDATE `creature_template` SET `ScriptName` = 'npc_raging_ghoul' WHERE `entry` = 36940;

-- Risen Witch Doctor scriptai
UPDATE `creature_template` SET `ScriptName` = 'npc_risen_witch_doctor' WHERE `entry` = 36941;

-- LumberINg Abomination scriptai
UPDATE `creature_template` SET `ScriptName` = 'npc_lumbering_abomination' WHERE `entry` = 37069;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (69708,70194,69784,70224,70225,69768,69767);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 69708, 0, 0, 31, 0, 3, 36954, 0, 0, 0, 0, '', 'Spell Ice Prison only hits Lich King'),
(13, 3, 70194, 0, 0, 31, 0, 3, 36954, 0, 0, 0, 0, '', 'Spell Dark Binding only hits Lich King'),
(13, 1, 69784, 0, 0, 31, 0, 3, 37014, 0, 0, 0, 0, '', 'Spell Destroy Wall only hits Ice Wall Target'),
(13, 1, 70224, 0, 0, 31, 0, 3, 37014, 0, 0, 0, 0, '', 'Spell Destroy Wall only hits Ice Wall Target'),
(13, 1, 70225, 0, 0, 31, 0, 3, 37014, 0, 0, 0, 0, '', 'Spell Destroy Wall only hits Ice Wall Target'),
(13, 1, 69768, 0, 0, 31, 0, 3, 37014, 0, 0, 0, 0, '', 'Spell Summon Ice Wall only hits Ice Wall Target'),
(13, 5, 69767, 0, 0, 31, 0, 3, 37014, 0, 0, 0, 0, '', 'Spell Summon Ice Wall only hits Ice Wall Target');

SET @CGUID := 142975; -- need 93
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+92;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
-- The Skybreaker
(@CGUID+0, 30351, 712, 3, 1, 40.85356, 44.65979, 25.11708, 2.617994, 7200, 0, 0),
(@CGUID+1, 30867, 712, 3, 1, -32.58828, 22.11204, 21.78542, 1.762783, 7200, 0, 0),
(@CGUID+2, 30867, 712, 3, 1, -11.11922, 23.02313, 21.71026, 1.727876, 7200, 0, 0),
(@CGUID+3, 30867, 712, 3, 1, 36.80393, 45.60984, 25.11626, 1.43117, 7200, 0, 0),
(@CGUID+4, 30351, 712, 3, 1, 1.432831, 22.45517, 21.75367, 3.193953, 7200, 0, 0),
(@CGUID+5, 30394, 712, 3, 1, -57.66117, -6.004808, 23.56313, 4.956735, 7200, 0, 0),
(@CGUID+6, 30351, 712, 3, 1, 1.032896, 9.635975, 20.53982, 3.211406, 7200, 0, 0),
(@CGUID+7, 30351, 712, 3, 1, -36.27486, -6.711545, 20.53283, 1.53589, 7200, 0, 0),
(@CGUID+8, 30351, 712, 3, 1, -36.26366, 6.612509, 20.5329, 4.642576, 7200, 0, 0),
(@CGUID+9, 30352, 712, 3, 1, -16.93313, 2.497342, 20.87589, 3.106686, 7200, 0, 0),
(@CGUID+10, 30352, 712, 3, 1, -49.00542, 0.003014, 20.75066, 0.01745329, 7200, 0, 0),
(@CGUID+11, 30352, 712, 3, 1, 16.73826, 2.378118, 20.50117, 3.159046, 7200, 0, 0),
(@CGUID+12, 30352, 712, 3, 1, 48.81408, 8.76864, 40.16452, 1.675516, 7200, 0, 0),
(@CGUID+13, 30352, 712, 3, 1, -16.85414, -2.518523, 20.87587, 3.263766, 7200, 0, 0),
(@CGUID+14, 30351, 712, 3, 1, 4.010166, -22.42914, 21.77942, 0.2617994, 7200, 0, 0),
(@CGUID+15, 30351, 712, 3, 1, 0.778628, -9.484917, 20.5411, 3.036873, 7200, 0, 0),
(@CGUID+16, 30867, 712, 3, 1, -9.599308, -23.15501, 21.71576, 4.782202, 7200, 0, 0),
(@CGUID+17, 30352, 712, 3, 1, 48.82674, -8.803922, 40.16443, 4.712389, 7200, 0, 0),
(@CGUID+18, 30867, 712, 3, 1, -32.99351, -22.17393, 21.7879, 4.502949, 7200, 0, 0),
(@CGUID+19, 30867, 712, 3, 1, 37.14339, -45.94594, 25.11639, 4.014257, 7200, 0, 0),
(@CGUID+20, 30344, 712, 3, 1, -2.700737, 12.2316, 20.52945, 1.727876, 7200, 0, 0),
(@CGUID+21, 22515, 712, 3, 1, -27.09398, 38.85326, 1.366914, 1.256637, 7200, 0, 0),
(@CGUID+22, 22515, 712, 3, 1, -6.396934, 39.80114, 1.470398, 1.256637, 7200, 0, 0),
(@CGUID+23, 22515, 712, 3, 1, 4.017809, 38.32001, 1.533938, 1.256637, 7200, 0, 0),
(@CGUID+24, 30392, 712, 3, 1, 28.1948, 7.542603, 23.37183, 5.8294, 7200, 0, 0),
(@CGUID+25, 30833, 712, 3, 1, 6.518055, 0.003965, 20.66434, 0, 7200, 0, 0),
(@CGUID+26, 30350, 712, 3, 1, 16.36582, -2.323581, 20.49201, 3.141593, 7200, 0, 0),
(@CGUID+27, 30347, 712, 3, 1, 28.24817, -7.667989, 23.37183, 0.4363323, 7200, 0, 0),
-- Orgrim Hammer
(@CGUID+28, 30755, 713, 3, 1, -18.96152, 27.52218, 90.04992, 6.213372, 7200, 0, 0),
(@CGUID+29, 30754, 713, 3, 1, -54.68485, 15.01545, 34.49284, 2.338741, 7200, 0, 0),
(@CGUID+30, 30752, 713, 3, 1, -10.94232, 32.12282, 10.65215, 1.518436, 7200, 0, 0),
(@CGUID+31, 30754, 713, 3, 1, -8.504885, -0.019059, 86.17371, 3.159046, 7200, 0, 0),
(@CGUID+32, 30866, 713, 3, 1, -36.03656, 23.91632, 34.00398, 1.937315, 7200, 0, 0),
(@CGUID+33, 30754, 713, 3, 1, 29.97084, 29.32993, 89.84912, 0.122173, 7200, 0, 0),
(@CGUID+34, 30753, 713, 3, 1, 15.19238, -0.108369, 86.17371, 3.071779, 7200, 0, 0),
(@CGUID+35, 30752, 713, 3, 1, 7.702429, 25.23042, 35.08076, 4.764749, 7200, 0, 0),
(@CGUID+36, 30755, 713, 3, 1, 8.555423, 5.155768, 84.79706, 3.560472, 7200, 0, 0),
(@CGUID+37, 30755, 713, 3, 1, -4.588624, 27.91955, 34.27925, 4.729842, 7200, 0, 0),
(@CGUID+38, 30754, 713, 3, 1, -19.19535, -27.024, 90.05069, 3.124139, 7200, 0, 0),
(@CGUID+39, 30754, 713, 3, 1, -54.63672, -15.29832, 34.48149, 3.717551, 7200, 0, 0),
(@CGUID+40, 30753, 713, 3, 1, -26.19901, -10.37834, 35.63048, 1.64061, 7200, 0, 0),
(@CGUID+41, 30755, 713, 3, 1, -56.79522, -3.870484, 13.31639, 0.1047198, 7200, 0, 0),
(@CGUID+42, 30755, 713, 3, 1, -56.8364, 3.557915, 13.3138, 6.178465, 7200, 0, 0),
(@CGUID+43, 30753, 713, 3, 1, -34.95441, 11.84717, 11.5961, 1.082104, 7200, 0, 0),
(@CGUID+44, 30752, 713, 3, 1, 1.994709, 31.96335, 10.09305, 1.448623, 7200, 0, 0),
(@CGUID+45, 30753, 713, 3, 1, -26.06219, 10.57757, 35.58858, 4.712389, 7200, 0, 0),
(@CGUID+46, 30752, 713, 3, 1, 15.2307, 31.76827, 10.66515, 1.466077, 7200, 0, 0),
(@CGUID+47, 30753, 713, 3, 1, 1.994774, 17.06817, 9.246212, 1.500983, 7200, 0, 0),
(@CGUID+48, 30755, 713, 3, 1, -4.484874, 18.00111, 8.70937, 4.729842, 7200, 0, 0),
(@CGUID+49, 30755, 713, 3, 1, 8.521951, 17.92888, 8.777781, 4.625123, 7200, 0, 0),
(@CGUID+50, 30755, 713, 3, 1, -26.0374, 6.533113, 9.42994, 3.124139, 7200, 0, 0),
(@CGUID+51, 30755, 713, 3, 1, -19.30323, 6.17474, 6.879124, 0, 7200, 0, 0),
(@CGUID+52, 30755, 713, 3, 1, 8.786416, -5.037911, 84.79706, 2.740167, 7200, 0, 0),
(@CGUID+53, 30755, 713, 3, 1, 8.557505, 5.72448, 34.52152, 3.106686, 7200, 0, 0),
(@CGUID+54, 30755, 713, 3, 1, 8.450569, -5.609207, 34.52058, 2.792527, 7200, 0, 0),
(@CGUID+55, 30866, 713, 3, 1, -36.32559, -23.21568, 34.04234, 4.39823, 7200, 0, 0),
(@CGUID+56, 30753, 713, 3, 1, -35.48437, -11.9256, 11.71411, 5.986479, 7200, 0, 0),
(@CGUID+57, 30752, 713, 3, 1, 8.472344, -22.36673, 34.99833, 1.780236, 7200, 0, 0),
(@CGUID+58, 30755, 713, 3, 1, -4.738312, -28.17381, 34.26831, 1.466077, 7200, 0, 0),
(@CGUID+59, 30755, 713, 3, 1, 31.3718, -29.84369, 89.84172, 2.96706, 7200, 0, 0),
(@CGUID+60, 30755, 713, 3, 1, 37.59615, -9.010085, 30.1788, 0.05235988, 7200, 0, 0),
(@CGUID+61, 30755, 713, 3, 1, 37.52684, 8.718971, 30.17881, 5.969026, 7200, 0, 0),
(@CGUID+62, 30755, 713, 3, 1, -25.42656, -6.577197, 9.33257, 2.932153, 7200, 0, 0),
(@CGUID+63, 30755, 713, 3, 1, 23.24178, 6.302864, 7.032903, 3.176499, 7200, 0, 0),
(@CGUID+64, 30755, 713, 3, 1, -19.45751, -6.235432, 6.89157, 6.265732, 7200, 0, 0),
(@CGUID+65, 30752, 713, 3, 1, -11.36508, -29.14235, 10.01249, 4.642576, 7200, 0, 0),
(@CGUID+66, 30753, 713, 3, 1, 46.41658, 7.696208, 10.48851, 4.101524, 7200, 0, 0),
(@CGUID+67, 30752, 713, 3, 1, 15.44485, -29.7788, 9.977043, 4.694936, 7200, 0, 0),
(@CGUID+68, 30754, 713, 3, 1, 38.01897, -12.83605, 30.17452, 0.6108652, 7200, 0, 0),
(@CGUID+69, 30866, 713, 3, 1, 17.22244, -26.63993, 35.64188, 4.817109, 7200, 0, 0),
(@CGUID+70, 30752, 713, 3, 1, 2.069969, -29.66959, 9.395721, 4.677482, 7200, 0, 0),
(@CGUID+71, 30753, 713, 3, 1, 2.036507, -17.18819, 9.245911, 4.764749, 7200, 0, 0),
(@CGUID+72, 30753, 713, 3, 1, 46.33955, -7.35728, 10.47599, 2.391101, 7200, 0, 0),
(@CGUID+73, 30755, 713, 3, 1, 8.592517, -17.94128, 8.77952, 1.553343, 7200, 0, 0),
(@CGUID+74, 30755, 713, 3, 1, -4.406364, -17.97099, 8.709299, 1.48353, 7200, 0, 0),
(@CGUID+75, 30755, 713, 3, 1, 22.90693, -6.745431, 7.115322, 3.124139, 7200, 0, 0),
(@CGUID+76, 30824, 713, 3, 1, 17.28272, 21.73325, 35.37741, 1.623156, 7200, 0, 0),
(@CGUID+77, 30827, 713, 3, 1, 45.76886, -8.964413, 30.17881, 1.396263, 7200, 0, 0),
(@CGUID+78, 30825, 713, 3, 1, 38.55754, -0.025193, 10.27214, 3.106686, 7200, 0, 0),
(@CGUID+79, 30826, 713, 3, 1, 55.08521, -3.344726, 30.1788, 2.687807, 7200, 0, 0),
(@CGUID+80, 37593, 713, 3, 1, 2.015905, 34.44526, 10.09305, 1.64061, 7200, 0, 0),
(@CGUID+81, 37593, 713, 3, 1, 14.85607, 33.80163, 9.849781, 1.64061, 7200, 0, 0),
(@CGUID+82, 37593, 713, 3, 1, -10.84229, 34.34502, 10.6434, 1.64061, 7200, 0, 0),
-- Others
(@CGUID+83, 22515, 668, 3, 1, 5274.933, 1693.941, 797.2499, 0, 7200, 0, 0),
(@CGUID+84, 36736, 668, 3, 1, 5415.332, 2080.358, 720.5068, 1.64061, 7200, 0, 0),
(@CGUID+85, 36736, 668, 3, 1, 5376.905, 2115.425, 720.3566, 6.126106, 7200, 0, 0),
(@CGUID+86, 36736, 668, 3, 1, 5445.525, 2099.37, 720.3999, 2.600541, 7200, 0, 0),
(@CGUID+87, 36736, 668, 3, 1, 5431.74, 2087.503, 720.3914, 2.076942, 7200, 0, 0),
(@CGUID+88, 36736, 668, 3, 1, 5395.38, 2146.632, 720.2123, 5.305801, 7200, 0, 0),
(@CGUID+89, 36736, 668, 3, 1, 5380.971, 2134.462, 720.6889, 5.637414, 7200, 0, 0),
(@CGUID+90, 36736, 668, 3, 1, 5449.623, 2117.587, 720.4929, 3.176499, 7200, 0, 0),
(@CGUID+91, 36736, 668, 3, 1, 5412.493, 2150.627, 720.3359, 4.502949, 7200, 0, 0),
(@CGUID+92, 37071, 668, 3, 1, 5408.362, 2110.33, 726.9917, 3.630285, 7200, 0, 0);

DELETE FROM `creature_template_addon` WHERE `entry`=36736; 
INSERT INTO `creature_template_addon` (`entry`, `mount`, `bytes1`, `bytes2`, `auras`) VALUES
(36736, 0, 0x0, 0x1, '69174'); -- Invisible Stalker (Icecrown Dungeon Trap) - Reflection Window Beam Visual

DELETE FROM `creature_text` WHERE `entry` IN (30344, 30824, 36954);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`, `BroadcastTextID`) VALUES
-- High Captain Justin Bartlett
(30344, 0, 0, 'FIRE! FIRE!', 14, 0, 100, 0, 0, 16721, 'High Captain Justin Bartlett - Fire', 36993),
(30344, 1, 0, 'Quickly, climb aboard! We mustn''t tarry here! There''s no telling when this whole mountainside will collapse.', 14, 0, 100, 0, 0, 16722, 'High Captain Justin Bartlett - Final', 37213),
-- Sky-Reaver Korm Blackscar
(30824, 0, 0, 'FIRE! FIRE!', 14, 0, 100, 0, 0, 16732, 'Sky-Reaver Korm Blackscar - Fire', 38681),
(30824, 1, 0, 'Get on board, now! This whole mountainside could collapse at any moment.', 14, 0, 100, 0, 0, 16733, 'Sky-Reaver Korm Blackscar - Final', 37212),
-- Lich King
(36954, 0, 0, 'Your allies have arrived, Jaina, just as you promised. You will all become powerful agents of the Scourge..', 14, 0, 100, 0, 0, 17212, 'Lich King SAY_LICH_KING_AGGRO_A', 37172),
(36954, 1, 0, 'I will not make the same mistake again, Sylvanas. This time there will be no escape. You will all serve me in death!', 14, 0, 100, 0, 0, 17213, 'Lich King SAY_LICH_KING_AGGRO_H', 37173),
(36954, 2, 0, 'There is no escape!', 14, 0, 100, 0, 0, 17217, 'Lich King SAY_LICH_KING_WALL_01', 37177),
(36954, 3, 0, 'Succumb to the chill of the grave.', 14, 0, 100, 0, 0, 17218, 'Lich King SAY_LICH_KING_WALL_02', 37175),
(36954, 4, 0, 'Another dead end.', 14, 0, 100, 0, 0, 17219, 'Lich King SAY_LICH_KING_WALL_03', 37176),
(36954, 5, 0, 'How long can you fight it?', 14, 0, 100, 0, 0, 17220, 'Lich King SAY_LICH_KING_WALL_04', 38668),
(36954, 6, 0, 'Arise minions.  Do not let them pass.', 14, 0, 100, 0, 0, 17216, 'Lich King SAY_LICH_KING_GHOUL', 38669),
(36954, 7, 0, 'Minions, sieze them.  Bring their corpses back to me.', 14, 0, 100, 0, 0, 17222, 'Lich King SAY_LICH_KING_ABON', 38670),
(36954, 8, 0, 'Death''s cold embrace awaits.', 14, 0, 100, 0, 0, 17221, 'Lich King SAY_LICH_KING_WINTER', 37174),
(36954, 9, 0, 'Nowhere to run! You''re mine now...', 14, 0, 100, 0, 0, 17223, 'Lich King SAY_LICH_KING_END_DUN', 36994);

DELETE FROM `areatrigger_scripts` WHERE `entry` IN (5605,5740);
INSERT INTO `areatrigger_scripts` (`entry`,`scriptname`) VALUES
(5605, 'at_hor_shadow_throne'),
(5740, 'at_hor_impenetrable_door');

DELETE FROM `areatrigger_teleport` WHERE `id`=5740;
INSERT INTO `areatrigger_teleport` (`id`, `name`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
(5740, 'Halls of Reflection (The Impenetrable Door)', 668, 5354.01, 2053.53, 707.695, 0.7853982);

DELETE FROM `lfg_entrances` WHERE `dungeonId` IN(255,256);
INSERT INTO `lfg_entrances` (`dungeonId`, `name`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(255, 'Halls of Reflection (Normal)', 5239.01, 1932.64, 707.695, 0.800565),
(256, 'Halls of Reflection (Heroic)', 5239.01, 1932.64, 707.695, 0.800565);

-- Lady Jaina Proudmoore
UPDATE `creature_template` SET `ScriptName`='npc_jaina_or_sylvanas_intro_hor' WHERE `entry`=37221;
-- Lady Sylvanas Windrunner
UPDATE `creature_template` SET `ScriptName`='npc_jaina_or_sylvanas_intro_hor' WHERE `entry`=37223;
-- Frostsworn General
UPDATE `creature_template` SET `ScriptName`='npc_frostsworn_general' WHERE `entry`=36723;
-- The Lich King
UPDATE `creature_template` SET `ScriptName`='npc_the_lich_king_escape_hor', `mechanic_immune_mask`=617299839 WHERE `entry` = 36954;
-- Icecrown Dungeon Horde Gunship Cannon
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry`=37593;

UPDATE `gameobject_template` SET `faction`=2102,`flags`=32 WHERE `entry`=201385;
UPDATE `gameobject_template` SET `faction`=1375,`flags`=32 WHERE `entry` IN (201596,201709,202211);
UPDATE `gameobject_template` SET `flags`=40 WHERE `entry` IN (201598,201599);
UPDATE `gameobject_template` SET `faction`=35,`flags`=16 WHERE `entry` IN (201710,202212,202336,202337);

 -- Lady Jaina Proudmoore
UPDATE `creature_template` SET `spell1`=0, `gossip_menu_id`=10860 WHERE `entry`=36955;
 -- Lady Sylvanas Windrunner
UPDATE `creature_template` SET `gossip_menu_id`=10909 WHERE `entry`=37554;

DELETE FROM `gossip_menu` WHERE `entry`=10931;
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES
(10931, 15190); -- 37554 -- outro gossip

UPDATE `gossip_menu_option` SET `option_id`=1, `npc_option_npcflag`=1 WHERE `menu_id`=10860 AND `id`=0;

-- skip intro
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup` IN (11031,10950);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,11031,1,0,0,14,0,24500,0,0,1,0,0,'','Show options only if quest 24500 taken/complete/rewarded'),
(15,10950,1,0,0,14,0,24802,0,0,1,0,0,'','Show options only if quest 24802 taken/complete/rewarded');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (72900,70190,70017,72368,72369);
INSERT INTO `spell_script_names` (`spell_id` ,`ScriptName`) VALUES
(72900, 'spell_hor_start_halls_of_reflection_quest_ae'),
(70190, 'spell_hor_evasion'),
(70017, 'spell_hor_gunship_cannon_fire'),
(72368, 'spell_marwyn_shared_suffering'),
(72369, 'spell_marwyn_shared_suffering');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (69857,70199,70021,70246);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,1,69857,0,0,31,0,3,36954,0,0,0,0,'','Taunt Arthas targets The Lich King'),
(13,2,70199,0,0,31,0,3,36954,0,0,0,0,'','Blinding Retreat targets The Lich King'),
(13,1,70021,0,0,31,0,3,22515,0,0,0,0,'','Gunship Cannon Fire targets World Trigger'),
(13,1,70021,0,0,1,0,70017,0,0,1,0,0,'','Gunship Cannon Fire target not has aura Gunship Cannon Fire'),
(13,1,70246,0,0,31,0,3,22515,0,0,0,0,'','Gunship Cannon Fire targets World Trigger'),
(13,1,70246,0,0,1,0,70017,0,0,1,0,0,'','Gunship Cannon Fire target not has aura Gunship Cannon Fire');

-- Cloak of Darkness proc on dodge
DELETE FROM `spell_proc_event` WHERE `entry`=70188;
INSERT INTO `spell_proc_event` (`entry`,`procEx`) VALUES
(70188,0x10);

SET @OGUID := 21620; -- need 12
DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+11;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@OGUID+0, 201709, 668, 3, 1, 5228.354, 1640.958, 783.7306, 5.585054, 0, 0, 0, 1, -7200, 255, 1),
(@OGUID+1, 201709, 668, 3, 1, 5215.889, 1626.078, 796.4562, 5.585054, 0, 0, 0, 1, -7200, 255, 1),
(@OGUID+2, 202211, 668, 3, 1, 5242.835, 1623.45,  784.1498, 5.811947, 0, 0, 0, 1, -7200, 255, 1),
(@OGUID+3, 202211, 668, 3, 1, 5225.201, 1589.099, 808.5507, 5.811947, 0, 0, 0, 1, -7200, 255, 1),
(@OGUID+4, 202211, 668, 3, 1, 5233.985, 1606.311, 796.2543, 5.811947, 0, 0, 0, 1, -7200, 255, 1),
(@OGUID+5, 195682, 712, 3, 1, 4.395291, 13.68329, 20.80389, 4.19445, 0, 0, 0, 1, 7200, 255, 1),
(@OGUID+6, 201710, 712, 1, 1, -11.7548, 12.02463, 20.40827, 3.217069, 0, 0, 0, 1, 7200, 255, 1),
(@OGUID+7, 202336, 712, 2, 1, -11.7548, 12.02463, 20.40827, 3.217069, 0, 0, 0, 1, 7200, 255, 1),
(@OGUID+8, 202212, 713, 1, 1, 12.23327, 22.47315, 35.07432, 1.239183, 0, 0, 0, 1, 7200, 255, 1),
(@OGUID+9, 202337, 713, 2, 1, 12.23327, 22.47315, 35.07432, 1.239183, 0, 0, 0, 1, 7200, 255, 1),
(@OGUID+10, 195682, 713, 3, 1, 22.17697, 22.95274, 35.65761, 1.919862, 0, 0, 0, 1, 7200, 255, 1),
(@OGUID+11, 191640, 713, 3, 1, 42.08455, 14.60723, 10.65548, 4.244588, 0, 0, 0, 1, 7200, 255, 1);

DELETE FROM `spelldifficulty_dbc` WHERE `id` IN(72395,72396,72397);
INSERT INTO `spelldifficulty_dbc` (`id`,`spellid0`,`spellid1`) VALUES
(72395,72395,72390), -- Hopelessness
(72396,72396,72391), -- Hopelessness
(72397,72397,72393); -- Hopelessness


DELETE FROM `creature_text` WHERE `entry` IN(37158,37704);
DELETE FROM `creature_text` WHERE `entry`=37225 AND `groupid` > 15;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`, `BroadcastTextID`) VALUES
(37158, 0, 0, '%s prepares to attack!', 41, 0, 100, 0, 0, 0, 'Quel''Delar', 37211),
(37704, 0, 0, 'Quel''Delar leaps to life in the presence of Frostmourne!', 41, 0, 100, 0, 0, 0, 'Frostmourne Altar Bunny (Quel''Delar)', 37645),
-- Uther
(37225, 16, 0, 'Halt! Do not carry that blade any further!', 14, 0, 100, 25, 0, 16675, 'Uther the Lightbringer', 37201),
(37225, 17, 0, 'Do you realize what you''ve done?', 14, 0, 100, 5, 0, 16676, 'Uther the Lightbringer', 37202),
(37225, 18, 0, 'You have forged this blade from saronite, the very blood of an old god. The power of the Lich King calls to this weapon.', 12, 0, 100, 1, 0, 16677, 'Uther the Lightbringer', 37204),
(37225, 19, 0, 'Each moment you tarry here, Quel''Delar drinks in the evil of this place.', 12, 0, 100, 1, 0, 16678, 'Uther the Lightbringer', 38442),
(37225, 20, 0, 'There is only one way to cleanse this sword. Make haste for the Sunwell and immerse the blade in its waters.', 12, 0, 100, 25, 0, 16679, 'Uther the Lightbringer', 37205),
(37225, 21, 0, 'I can resist Frostmourne''s call no more...', 12, 0, 100, 1, 0, 16680, 'Uther the Lightbringer', 37206);

UPDATE `creature_template` SET `unit_flags`=768, `flags_extra`=0, `ScriptName`='npc_quel_delar_sword', `InhabitType`=7 WHERE `entry`=37158;
UPDATE `creature_template` SET `ScriptName`='npc_uther_quel_delar' WHERE `entry`=37225;

DELETE FROM `areatrigger_scripts` WHERE `entry`=5660;
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES
(5660, 'at_hor_uther_quel_delar_start');

DELETE FROM `spell_target_position` WHERE `id` IN(70719,70700);
INSERT INTO `spell_target_position` (`id`,`target_map`,`target_position_x`,`target_position_y`,`target_position_z`,`target_orientation`) VALUES
(70719, 668, 5302, 1989, 708, 0),
(70700, 668, 5298, 1995, 708, 0);

-- DELETE FROM `creature_loot_template` WHERE `entry` = 37158 AND `item` = 50254;
-- INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
-- (37158, 50254, 100, 1, 0, 1, 1);

DELETE FROM `conditions` WHERE `SourceEntry` = 73035 AND `SourceTypeOrReferenceId` = 13;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `Comment`) VALUES
(13,1,73035,0,0,31,0,3,37704,0,0,0,0,'Essence of the Captured (73035) only hits Frostmourne Altar Bunny (Quel''Delar)');
