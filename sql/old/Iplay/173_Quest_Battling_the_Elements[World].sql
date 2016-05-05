-- Missing spawns
DELETE FROM `creature` WHERE `id` IN (30099,30123);
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `curhealth`, `curmana`) VALUES
(30099, 571, 1, 4, 7183.29, -3519.86, 827.412, 0.034907, 300, 48700, 0),
(30123, 571, 1, 4, 7167.38, -3543.06, 827.746, 6.05629, 300, 50400, 0);

-- Njormeld
SET @NJORMELD := 30127;
DELETE FROM `creature_template_addon` WHERE `entry`=@NJORMELD;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(@NJORMELD,0,0,0,0,0,'56768');

-- Snorri
SET @SNORRI := 30123;
SET @SNORRI_MOUNT := 30124;
UPDATE `creature_template` SET `npcflag`=16777216 WHERE `entry`=@SNORRI;
UPDATE `creature_template` SET `spell1`=56750,`spell2`=56753,`spell4`=56752, `npcflag`=0 WHERE `entry`=@SNORRI_MOUNT;
DELETE FROM `creature_template_addon` WHERE `entry`=@SNORRI;
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=@SNORRI;
INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`cast_flags`,`user_type`) VALUES
(@SNORRI,55957,1,0);

-- Seething Revenant
SET @ELEMENTAL :=30120;
UPDATE `creature_template` SET `faction_A`=834, `faction_H`=834, `ScriptName`='npc_seething_revenant' WHERE `entry`=@ELEMENTAL;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ELEMENTAL;
DELETE FROM `creature` WHERE `id`=@ELEMENTAL;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(NULL, @ELEMENTAL, 571, 1, 4, 0, 0, 7212.37, -3624.77, 824.233, 5.91444, 60, 0, 0, 12600, 0, 0, 0, 0, 0),
(NULL, @ELEMENTAL, 571, 1, 4, 0, 0, 7238.54, -3634.89, 823.22, 5.91444, 60, 0, 0, 12600, 0, 0, 0, 0, 0),
(NULL, @ELEMENTAL, 571, 1, 4, 0, 0, 7201.85, -3641.57, 823.656, 5.10863, 60, 0, 0, 12600, 0, 0, 0, 0, 0),
(NULL, @ELEMENTAL, 571, 1, 4, 0, 0, 7220.44, -3635.76, 824.085, 4.51253, 60, 0, 0, 12600, 0, 0, 0, 0, 0),
(NULL, @ELEMENTAL, 571, 1, 4, 0, 0, 7227.23, -3621.83, 823.408, 2.21131, 60, 0, 0, 12600, 0, 0, 0, 0, 0),
(NULL, @ELEMENTAL, 571, 1, 4, 0, 0, 7239.02, -3622.82, 823.731, 2.57495, 60, 0, 0, 12600, 0, 0, 0, 0, 0),
(NULL, @ELEMENTAL, 571, 1, 4, 0, 0, 7250.36, -3633.86, 823.774, 2.12806, 60, 0, 0, 12600, 0, 0, 0, 0, 0),
(NULL, @ELEMENTAL, 571, 1, 4, 0, 0, 7252.07, -3648.68, 823.691, 2.17047, 60, 0, 0, 12600, 0, 0, 0, 0, 0),
(NULL, @ELEMENTAL, 571, 1, 4, 0, 0, 7245.54, -3657.89, 823.477, 2.17047, 60, 0, 0, 12600, 0, 0, 0, 0, 0),
(NULL, @ELEMENTAL, 571, 1, 4, 0, 0, 7231.25, -3664.3, 823.025, 2.17047, 60, 0, 0, 12600, 0, 0, 0, 0, 0),
(NULL, @ELEMENTAL, 571, 1, 4, 0, 0, 7215.02, -3662.49, 823.42, 1.52644, 60, 0, 0, 12600, 0, 0, 0, 0, 0),
(NULL, @ELEMENTAL, 571, 1, 4, 0, 0, 7202, -3657.74, 823.637, 1.8406, 60, 0, 0, 12600, 0, 0, 0, 0, 0),
(NULL, @ELEMENTAL, 571, 1, 4, 0, 0, 7189.8, -3653.1, 823.714, 1.8406, 60, 0, 0, 12600, 0, 0, 0, 0, 0),
(NULL, @ELEMENTAL, 571, 1, 4, 0, 0, 7213.31, -3673.72, 822.69, 2.07543, 60, 0, 0, 12600, 0, 0, 0, 0, 0),
(NULL, @ELEMENTAL, 571, 1, 4, 0, 0, 7228.13, -3679.11, 822.989, 1.82803, 60, 0, 0, 12600, 0, 0, 0, 0, 0);

-- Snowdrift
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=56750;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`,`ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17,0,56750,0,0,30,0,192075,5,0,0,0,'','Gather Snow can only be casted near Snowdrift');

DELETE FROM `gameobject` WHERE `id`=192075;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(NULL, 192075, 571, 1, 4, 7218.64, -3529.71, 828.539, -1.93732, 0, 0, -0.824127, 0.566404, 300, 100, 1),
(NULL, 192075, 571, 1, 4, 7201.17, -3556.13, 828.03, 2.18166, 0, 0, 0.88701, 0.461749, 300, 100, 1),
(NULL, 192075, 571, 1, 4, 7230.44, -3555.63, 841.772, 1.85005, 0, 0, 0.798636, 0.601815, 300, 100, 1),
(NULL, 192075, 571, 1, 4, 7169.6, -3615.71, 830.249, -2.89724, 0, 0, -0.992546, 0.121873, 300, 100, 1),
(NULL, 192075, 571, 1, 4, 7121.83, -3542.56, 835.008, -0.750491, 0, 0, -0.366501, 0.930418, 300, 100, 1),
(NULL, 192075, 571, 1, 4, 7131.5, -3584.22, 840.195, -1.91986, 0, 0, -0.819151, 0.573577, 300, 100, 1),
(NULL, 192075, 571, 1, 4, 7162.55, -3582.66, 830.36, 1.11701, 0, 0, 0.529919, 0.848048, 300, 100, 1),
(NULL, 192075, 571, 1, 4, 7176.21, -3511.2, 833.381, 1.93731, 0, 0, 0.824125, 0.566409, 300, 100, 1),
(NULL, 192075, 571, 1, 4, 7148.73, -3559.17, 830.36, -2.72271, 0, 0, -0.978147, 0.207914, 300, 100, 1),
(NULL, 192075, 571, 1, 4, 7165.47, -3639.53, 832.157, 0.890117, 0, 0, 0.430511, 0.902586, 300, 100, 1);

-- See Invis Tier 1
DELETE FROM `spell_area` WHERE `spell`=61209 AND `area`=4438;
DELETE FROM `spell_area` WHERE `spell`=56771 AND `area`=4438;
INSERT INTO `spell_area` (`spell`,`area`,`quest_start`,`quest_end`,`aura_spell`,`racemask`,`gender`,`autocast`,`quest_start_status`,`quest_end_status`) VALUES
(56771,4438,12924,0,0,0,2,1,66,0);
