-- ----------------------------------------
-- Achievement - Torch Juggler
-- ----------------------------------------
SET @SPELL_TORCH_CATCH := 45644;
SET @SPELL_THROW_TORCH := 45819;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (@SPELL_TORCH_CATCH);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,@SPELL_TORCH_CATCH,0,0,8,0,11923,0,0,0,0,'','Torch catch - Implicit target - Completed quest Torch catching'),
(13,1,@SPELL_TORCH_CATCH,0,1,8,0,11657,0,0,0,0,'','Torch catch - Implicit target - Completed quest Torch catching');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=@SPELL_TORCH_CATCH;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(@SPELL_TORCH_CATCH,45280,1,'Torch Catch - Give Torch');

DELETE FROM `spell_script_names` WHERE `spell_id`=@SPELL_THROW_TORCH;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(@SPELL_THROW_TORCH,'spell_midsummer_throw_torch');

DELETE FROM `achievement_criteria_data` WHERE `criteria_id`=6937;
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`) VALUES
(6937,16,341),
(6937,6,4613);

-- Quests - Torch Tossing - More Torch Tossing
SET @BUNNY := 25535;
SET @CONTROLLER := 25536;
SET @FOCUS := 300068;
SET @BRAZIER := 187708;
SET @FIRE_EATER := 25975;
SET @FLAME_EATER := 26113;

UPDATE `quest_template` SET `LimitTime`=40, `RequiredRaces`=690 WHERE `Id`=11922;
UPDATE `quest_template` SET `LimitTime`=40, `RequiredRaces`=1101 WHERE `Id`=11731;
UPDATE `quest_template` SET `LimitTime`=90, `RequiredRaces`=690, `PrevQuestId`=11923 WHERE `Id`=11926;
UPDATE `quest_template` SET `LimitTime`=90, `RequiredRaces`=1101, `PrevQuestId`=11657 WHERE `Id`=11921;

UPDATE `gameobject_template` SET `data1`=20 WHERE `entry`=@FOCUS;
DELETE FROM `game_event_gameobject` WHERE `guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` IN (@FOCUS,@BRAZIER) AND `guid`>50971);
UPDATE `gameobject` SET `position_z`=99.50457 WHERE `guid`=50962 AND `id`=@BRAZIER;
DELETE FROM `gameobject` WHERE `id` IN (@FOCUS,@BRAZIER) AND `guid`>50971;
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@FOCUS,0,1,1,-8837.04,857.657,98.7763,-2.07694,0,0,0.861629,-0.507538,180,100,1),
(@FOCUS,0,1,1,-4700.28,-1224.34,501.659,-2.14675,0,0,0.878817,-0.477159,180,100,1),
(@FOCUS,1,1,1,8700.21,931.422,14.823,1.67552,0,0,0.743145,0.669131,180,100,1),
(@FOCUS,0,1,1,1822.27,218.639,59.8924,-0.034907,0,0,0.017452,-0.999848,180,100,1),
(@FOCUS,1,1,1,1911.67,-4338.28,21.0705,-0.20944,0,0,0.104528,-0.994522,180,100,1),
(@FOCUS,1,1,1,-1027.8,296.424,135.746,2.82743,0,0,0.987688,0.156434,180,100,1),
(@FOCUS,530,1,1,-3794.02,-11502.1,-134.74,5.00689,0,0,0.59571,-0.8032,300,0,1),
(@FOCUS,530,1,1,9805.88,-7239.91,26.0512,-3.1066,0,0,0,0,120,0,1),
(@BRAZIER,530,1,1,9817.76,-7227.87,26.11,3.99925,0,0,0.909452,-0.415808,300,0,1),
(@BRAZIER,530,1,1,9823.73,-7229.12,26.1191,3.90108,0,0,0.928759,-0.370684,300,0,1),
(@BRAZIER,530,1,1,9819.86,-7234.65,26.119,3.8249,0,0,0.942202,-0.335046,300,0,1),
(@BRAZIER,530,1,1,9810.32,-7227.03,26.0581,0.69823,0,0,0.342066,0.939676,300,0,1),
(@BRAZIER,530,1,1,9817.68,-7221.27,26.1126,3.92857,0,0,0.923577,-0.383414,300,0,1),
(@BRAZIER,530,1,1,-3775.38,-11506.6,-134.539,5.73105,0,0,0.272574,-0.962135,300,0,1),
(@BRAZIER,530,1,1,-3768.58,-11511.3,-134.478,5.69571,0,0,0.289533,-0.957168,300,0,1),
(@BRAZIER,530,1,1,-3773.15,-11519.4,-134.562,5.69571,0,0,0.289533,-0.957168,300,0,1),
(@BRAZIER,530,1,1,-3780.43,-11514,-134.625,5.69571,0,0,0.289533,-0.957168,300,0,1),
(@BRAZIER,530,1,1,-3776.37,-11511.5,-134.57,5.69571,0,0,0.289533,-0.957168,300,0,1),
(@BRAZIER,0,1,1,-8816.49,854.262,98.881,3.07738,0,0,0.999485,0.0320991,300,0,1),
(@BRAZIER,0,1,1,-8814.97,860.552,98.9543,3.07738,0,0,0.999485,0.0320991,300,0,1),
(@BRAZIER,0,1,1,-8817.98,865.261,98.9764,3.07738,0,0,0.999485,0.0320991,300,0,1);

SET @GUID := (SELECT `guid` FROM `gameobject` WHERE `id`=@FOCUS ORDER BY `guid` LIMIT 1);
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1,@GUID),
(1,@GUID+1),
(1,@GUID+2),
(1,@GUID+3),
(1,@GUID+4),
(1,@GUID+5),
(1,@GUID+6),
(1,@GUID+7),
(1,@GUID+8),
(1,@GUID+9),
(1,@GUID+10),
(1,@GUID+11),
(1,@GUID+12),
(1,@GUID+13),
(1,@GUID+14),
(1,@GUID+15),
(1,@GUID+16),
(1,@GUID+17),
(1,@GUID+18),
(1,@GUID+19),
(1,@GUID+20);

DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id`=@BUNNY);
DELETE FROM `creature_template_addon` WHERE `entry`=@BUNNY;
INSERT INTO `creature_template_addon` (`entry`,`auras`) VALUES
(@BUNNY,'43396');

DELETE FROM `game_event_creature` WHERE `eventEntry`=1 AND `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (@BUNNY,@CONTROLLER));
DELETE FROM `creature` WHERE `id` IN (@BUNNY,@CONTROLLER) AND `guid`>46914;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`,`position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@CONTROLLER,1,1,1,-1052.69,302.024,133.314,0.538506),
(@CONTROLLER,1,1,1,1914.62,-4316.19,23.2105,5.88965),
(@CONTROLLER,0,1,1,1841.84,220.353,60.847,3.54074),
(@CONTROLLER,530,1,1,9823.4,-7221.86,26.7766,3.98641),
(@CONTROLLER,0,1,1,-8820.81,856.192,99.035,2.9833),
(@CONTROLLER,0,1,1,-4680.07,-1224.66,501.659,3.35709),
(@CONTROLLER,530,1,1,-3771.32,-11515.4,-134.525,2.54862),
(@BUNNY,1,1,1,-1048.8,299.889,134.401,0.698132),
(@BUNNY,1,1,1,-1042.52,306.56,134.451,-1.98968),
(@BUNNY,1,1,1,-1041.61,313.163,133.278,-1.76278),
(@BUNNY,1,1,1,-1049.08,306.373,132.937,-2.18166),
(@BUNNY,1,1,1,-1035.88,312.549,134.666,-1.58825),
(@BUNNY,0,1,1,-4685.95,-1218.96,501.659,0.698132),
(@BUNNY,0,1,1,-4677.39,-1229.83,501.659,-1.58825),
(@BUNNY,0,1,1,-4675.41,-1224.66,501.659,-1.98968),
(@BUNNY,0,1,1,-4683.98,-1232.64,501.659,-1.76278),
(@BUNNY,0,1,1,-4678.69,-1219.43,501.659,-2.18166),
(@BUNNY,1,1,1,1915.58,-4320.46,21.8202,-1.58825),
(@BUNNY,1,1,1,1920.49,-4319.35,21.8167,0.698132),
(@BUNNY,1,1,1,1918.07,-4314.9,22.8562,-1.98968),
(@BUNNY,1,1,1,1925.15,-4321.27,21.6547,-1.76278),
(@BUNNY,1,1,1,1923.87,-4315.27,22.4918,-2.181661),
(@BUNNY,0,1,1,1837.4,213.158,60.3433,-1.98968),
(@BUNNY,0,1,1,1837.19,225.627,60.246,-1.58825),
(@BUNNY,0,1,1,1838.23,218.969,60.1496,-1.76278),
(@BUNNY,0,1,1,1840.84,216.245,60.074,-2.18166),
(@BUNNY,0,1,1,1840.18,222.607,60.2069,0.698132),
(@BUNNY,530,1,1,-3768.73,-11511.2,-134.479,2.70805),
(@BUNNY,530,1,1,-3773.26,-11519.4,-134.56,2.53526),
(@BUNNY,530,1,1,-3776.32,-11511.5,-134.569,5.69256),
(@BUNNY,530,1,1,-3775.23,-11506.7,-134.539,5.79074),
(@BUNNY,530,1,1,-3780.47,-11514.1,-134.626,5.66115),
(@BUNNY,530,1,1,9817.67,-7227.84,26.1104,3.89843),
(@BUNNY,530,1,1,9810.38,-7226.95,26.0582,0.898206),
(@BUNNY,530,1,1,9819.87,-7234.51,26.1176,0.898206),
(@BUNNY,530,1,1,9823.56,-7229.12,26.1209,3.78847),
(@BUNNY,530,1,1,9817.55,-7221.36,26.1142,3.80025),
(@BUNNY,0,1,1,-8819.46,848.506,98.9483,-2.18166),
(@BUNNY,0,1,1,-8825.72,845.613,99.0511,2.89725),
(@BUNNY,0,1,1,-8816.54,854.183,98.882,4.34518),
(@BUNNY,0,1,1,-8815.11,860.487,98.96,4.75751),
(@BUNNY,0,1,1,-8818.01,865.253,98.9761,4.47084);

SET @GUID := (SELECT `guid` FROM `creature` WHERE `id`=@CONTROLLER AND `guid`>46914 ORDER BY `guid` LIMIT 1);
INSERT INTO `game_event_creature` (`eventEntry`,`guid`) VALUES
(1,@GUID),
(1,@GUID+1),
(1,@GUID+2),
(1,@GUID+3),
(1,@GUID+4),
(1,@GUID+5),
(1,@GUID+6),
(1,@GUID+7),
(1,@GUID+8),
(1,@GUID+9),
(1,@GUID+10),
(1,@GUID+11),
(1,@GUID+12),
(1,@GUID+13),
(1,@GUID+14),
(1,@GUID+15),
(1,@GUID+16),
(1,@GUID+17),
(1,@GUID+18),
(1,@GUID+19),
(1,@GUID+20),
(1,@GUID+21),
(1,@GUID+22),
(1,@GUID+23),
(1,@GUID+24),
(1,@GUID+25),
(1,@GUID+26),
(1,@GUID+27),
(1,@GUID+28),
(1,@GUID+29),
(1,@GUID+30),
(1,@GUID+31),
(1,@GUID+32),
(1,@GUID+33),
(1,@GUID+34),
(1,@GUID+35),
(1,@GUID+36),
(1,@GUID+37),
(1,@GUID+38),
(1,@GUID+39),
(1,@GUID+40),
(1,@GUID+41),
(1,46906),
(1,46908),
(1,46909),
(1,46910),
(1,46911),
(1,46914);

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (45716,46630,-45716,-46630);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(45716,43398,2,'Torch tossing training aura trigger detect invisibility + remove on expire'),
(46630,43398,2,'Torch tossing practice aura trigger detect invisibility + remove on expire'),
(-45716,-45724,0,'Remove Brazier Hit stacks on expire Torch tossing training aura'),
(-46630,-45724,0,'Remove Brazier Hit stacks on expire Torch tossing practice aura');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=46054;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition` ,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,46054,0,0,1,0,43313,0,0,0,0,'','Torch toss can hit only targets with mark'),
(13,1,46054,0,0,31,0,3,@BUNNY,0,0,0,'','Torch toss can hit only targets with mark');

UPDATE `creature_template` SET `ScriptName`='npc_torch_tossing_target_controller' WHERE `entry`=@CONTROLLER;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@BUNNY,@FIRE_EATER,@FLAME_EATER);
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry`=@BUNNY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@BUNNY,@FIRE_EATER,@FLAME_EATER) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@BUNNY,0,0,1,8,0,100,0,46054,0,0,0,11,45724,2,0,0,0,0,7,0,0,0,0,0,0,0,'Torch Tossing Target Bunny - On hit by spell Torch Land - Cast Brazzier hit'),
(@BUNNY,0,1,0,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,@CONTROLLER,60,0,0,0,0,0,'Torch Tossing Target Bunny - On hit by spell Torch Land - Set data to Torch Tossing Controller'),
(@FIRE_EATER,0,0,2,19,0,100,0,11731,0,0,0,85,45716,2,0,0,0,0,7,0,0,0,0,0,0,0,'Master Fire Eater - On quest accept - Invoker Cast Torch Tossing Training'),
(@FIRE_EATER,0,1,2,19,0,100,0,11921,0,0,0,85,46630,2,0,0,0,0,7,0,0,0,0,0,0,0,'Master Fire Eater - On quest accept - Invoker Cast Torch Tossing Practice'),
(@FIRE_EATER,0,2,0,61,0,100,0,0,0,0,0,28,45724,0,0,0,0,0,7,0,0,0,0,0,0,0,'Master Fire Eater - On quest accept - Remove Aura Braziers Hit'),
(@FLAME_EATER,0,0,0,19,0,100,0,11922,0,0,0,85,45716,2,0,0,0,0,7,0,0,0,0,0,0,0,'Master Flame Eater - On quest accept - Invoker Cast Torch Tossing Training'),
(@FLAME_EATER,0,1,0,19,0,100,0,11926,0,0,0,85,46630,2,0,0,0,0,7,0,0,0,0,0,0,0,'Master Flame Eater - On quest accept - Invoker Cast Torch Tossing Practice'),
(@FLAME_EATER,0,2,0,61,0,100,0,0,0,0,0,28,45724,0,0,0,0,0,7,0,0,0,0,0,0,0,'Master Flame Eater - On quest accept - Remove Aura Braziers Hit');

DELETE FROM `spell_script_names` WHERE `spell_id`=45724;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(45724,'spell_midsummer_braziers_hit');

-- Quests - Torch Catching - More Torch Catching
UPDATE `quest_template` SET `RequiredRaces`=1101 WHERE `Id` IN (11657,11924);
UPDATE `quest_template` SET `RequiredRaces`=690 WHERE `Id` IN (11923,11925);
UPDATE `quest_template` SET `PrevQuestId`=11657 WHERE `Id`=11924;
UPDATE `quest_template` SET `PrevQuestId`=11923 WHERE `Id`=11925;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=45671;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition` ,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,45671,0,0,33,0,1,0,0,0,0,'','Midsummer Torches Caught - Implicit Target - Caster');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (46747,45671);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(46747,'spell_midsummer_fling_torch'),
(45671,'spell_midsummer_juggle_torch_catch_quest');
