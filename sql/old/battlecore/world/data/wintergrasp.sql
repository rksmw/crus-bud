-- Wintergrasp coreside texts
DELETE FROM `trinity_string` WHERE `entry` BETWEEN 12050 AND 12073;
INSERT INTO `trinity_string` (`entry`,`content_default`,`content_loc6`,`content_loc7`)VALUES
(12073, '%s has been successfully defended by %s', '%s ha sido defendida con éxito por la %s', '%s ha sido defendida con éxito por la %s'),
(12072, '%s has been destroyed!', '%s ha sido destruida!', '%s ha sido destruida!'),
(12071, '%s has been damaged!', '%s ha sido dañada!', '%s ha sido dañada!'),
(12070, '%s has been lost by %s', '%s ha sido perdido por la %s', '%s ha sido perdido por la %s'),
(12069, '%s has been captured by %s', '%s ha sido tomado por la %s', '%s ha sido tomado por la %s'),
(12068, '%s is under attack by %s', '%s está siendo atacado por la %s', '%s está siendo atacado por la %s'),
(12067, 'You have reached Rank 2: First Lieutenant', 'Haz alcanzado el Rango 2: Teniente Primero', 'Haz alcanzado el Rango 2: Teniente Primero'),
(12066, 'You have reached Rank 1: Corporal', 'Haz alcanzado el Rango 1: Cabo', 'Haz alcanzado el Rango 1: Cabo'),
(12065, 'Horde!', 'Horda!', 'Horda!'),
(12064, 'Alliance!', 'Alianza!', 'Alianza!'),
(12063, 'The tower southeastern fortress', '¡La torre Suroeste de la Fortaleza', '¡La torre Sureste de la Fortaleza'),
(12062, 'The tower southwestern fortress', '¡La torre Sureste de la Fortaleza', '¡La torre Suroeste de la Fortaleza'),
(12061, 'The tower northeastern fortress', '¡La torre Noreste de la Fortaleza', '¡La torre Noreste de la Fortaleza'),
(12060, 'The tower northwestern fortress', '¡La torre Noroeste de la Fortaleza', '¡La torre Noroeste de la Fortaleza'),
(12059, 'The Flamewatch tower', '¡La torre de la Guardia en Llamas', '¡La torre de la Guardia en Llamas'),
(12058, 'The Winter\'s Edge tower', '¡La torre Filoinverno', '¡La torre del Filoinverno'),
(12057, 'The Shadowsight tower', '¡La torre de la Vista de las Sombras', '¡La torre de la Vista de las Sombras'),
(12056, 'The Eastspark siege workshop', '¡El taller de Asedio de la Chispa Oriental', '¡El taller de Asedio de la Chispa Oriental'),
(12055, 'The Westspark siege workshop', '¡El taller de Asedio de la Chispa Occidental', '¡El taller de Asedio de la Chispa Occidental'),
(12054, 'The Sunken Ring siege workshop', '¡El taller de Asedio del Anillo Sumergido', '¡El taller de Asedio del Anillo Sumergido'),
(12053, 'The Broken Temple siege workshop', '¡El taller del Templo Quebrado', '¡El taller del Templo Quebrado'),
(12052, 'The Wintergrasp fortress', '¡La fortaleza de la Conquista del Invierno', '¡La fortaleza de la Conquista del Invierno'),
(12051, 'The battle for Wintergrasp has begun!', '¡La batalla por la Conquista del Invierno ha comenzado!', '¡La batalla por Conquista del Invierno ha comenzado!'),
(12050, 'The battle for Wintergrasp is going to begin!', '¡La batalla por la Conquista del Invierno va a comenzar!', '¡La batalla por la Conquista del Invierno va a comenzar!');

-- Wintergrasp queue template NPCs script
UPDATE `creature_template` SET `ScriptName`= 'npc_wg_queue' WHERE `entry` IN (32169,32170,35599,35596,35600,35601,35598,35603,35602,35597,35612,35611); -- <Wintergrasp Battle-Master>

-- Wintergrasp spirit guide & demolisher engineer SAI
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`= '' WHERE `entry` IN (30400,30499,31841,31842); -- Goblin Mechanic, Gnomish Engineer, Taunka Spirit Guide, Dwarven Spirit Guide

-- Wintergrasp Questgiver NPCs script
UPDATE `creature_template` SET `ScriptName`= 'npc_wg_quest_giver' WHERE `entry` IN (31054,31052,31091,31036,31101,31107,31053,31051,31153,31151,31102,31106);

-- Wintergrasp Achievements
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN(6440, 6441, 6444, 6445, 6436, 7365, 7403, 7404, 7405, 7406, 7407, 7666, 7703, 7704, 7705, 7706, 7707, 7708, 7709, 7710, 7711, 7712, 7713, 7714, 7715, 7716, 7718, 7719, 7735, 9178, 9179, 9180, 9181);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(6440, 11, 0, 0, 'achievement_wg_destruction_derby'), -- Destruction Derby A (Wintergrasp Catapult)
(6441, 11, 0, 0, 'achievement_wg_destruction_derby'), -- Destruction Derby A (Wintergrasp Demolisher)
(6444, 11, 0, 0, 'achievement_wg_destruction_derby'), -- Destruction Derby A (Wintergrasp Siege Engine)
(6445, 11, 0, 0, 'achievement_wg_destruction_derby'), -- Destruction Derby A (Wintergrasp Tower Cannon)
(6436, 0, 0, 0, ''), -- Win Wintergrasp
(7365, 0, 0, 0, ''), -- Win Wintergrasp 100 times
(7403, 0, 0, 0, ''), -- 50 Stone Keeper's Shards (Loot 50 Stone Keeper's Shards)
(7404, 0, 0, 0, ''), -- 100 Stone Keeper's Shards (Loot 100 Stone Keeper's Shards)
(7405, 0, 0, 0, ''), -- 250 Stone Keeper's Shards (Loot 250 Stone Keeper's Shards)
(7406, 0, 0, 0, ''), -- 500 Stone Keeper's Shards (Loot 500 Stone Keeper's Shards)
(7407, 0, 0, 0, ''), -- 1000 Stone Keeper's Shards (Loot 1000 Stone Keeper's Shards)
(7666, 11, 0, 0, 'achievement_wg_within_our_grasp'), --	Within Our Grasp (Attack Wintergrasp and succeed in 10 minutes or less.)
(7703, 11, 0, 0, 'achievement_wg_didnt_stand_a_chance'), -- Didn't Stand a Chance (Kill 20 mounted players using a tower cannon)
(7704, 11, 0, 0, 'achievement_wg_vehicular_gnomeslaughter'), -- Vehicular Gnomeslaughter (Vehiculo)
(7705, 11, 0, 0, 'achievement_wg_vehicular_gnomeslaughter'), -- Vehicular Gnomeslaughter (Cannon)
(7706, 11, 0, 0, 'achievement_wg_vehicular_gnomeslaughter'), -- Vehicular Gnomeslaughter (Shredder)
(7707, 11, 0, 0, 'achievement_wg_vehicular_gnomeslaughter'), -- Vehicular Gnomeslaughter (Fighter)
(7708, 11, 0, 0, 'achievement_wg_vehicular_gnomeslaughter'), -- Vehicular Gnomeslaughter (Bomber)
(7709, 6, 4575, 0, ''), -- Wintergrasp Ranger (Wintergrasp Fortress)
(7710, 6, 4612, 0, ''), -- Wintergrasp Ranger (Eastspark Workshop)
(7711, 6, 4539, 0, ''), -- Wintergrasp Ranger (The Broken Temple)
(7712, 6, 4538, 0, ''), -- Wintergrasp Ranger (The Sunken Ring)
(7713, 6, 4611, 0, ''), -- Wintergrasp Ranger (Westspark Workshop)
(7714, 6, 4581, 0, ''), -- Wintergrasp Ranger (Flamewatch Tower)
(7715, 6, 4583, 0, ''), -- Wintergrasp Ranger (Shadowsight Tower)
(7716, 6, 4582, 0, ''), -- Wintergrasp Ranger (Winter's Edge Tower)
(7718, 6, 4584, 0, ''), -- Wintergrasp Ranger (The Cualdron of Flames)
(7719, 6, 4589, 0, ''), -- Wintergrasp Ranger (The Chilled Quagmire)
(7735, 11, 0, 0, ''), -- Leaning Tower
(9178, 11, 0, 0, 'achievement_wg_destruction_derby'), -- Destruction Derby H (Wintergrasp Catapult)
(9179, 11, 0, 0, 'achievement_wg_destruction_derby'), -- Destruction Derby H (Wintergrasp Demolisher)
(9180, 11, 0, 0, 'achievement_wg_destruction_derby'), -- Destruction Derby H (Wintergrasp Siege Engine)
(9181, 11, 0, 0, 'achievement_wg_destruction_derby'); -- Destruction Derby H (Wintergrasp Tower Cannon)

SET @GAMEOBJECT_GUID = 10016323;
SET @CREATURE_GUID = 10003681;

DELETE FROM `creature` WHERE `guid` BETWEEN @CREATURE_GUID+1 AND @CREATURE_GUID+48;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@CREATURE_GUID+1, 28366, 571, 1, 1, 0, 0, 5391.19, 3060.8, 419.616, 1.69557, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+2, 28366, 571, 1, 1, 0, 0, 5352.2, 3060.73, 421.1, 1.57067, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+3, 28366, 571, 1, 1, 0, 0, 5323.05, 2923.7, 421.645, 1.5817, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+4, 28366, 571, 1, 1, 0, 0, 5363.82, 2923.87, 421.709, 1.60527, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+5, 28366, 571, 1, 1, 0, 0, 5264.04, 2861.34, 421.587, 3.21142, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+6, 28366, 571, 1, 1, 0, 0, 5266.75, 2976.5, 421.067, 3.20354, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+7, 28366, 571, 1, 1, 0, 0, 5234.86, 2948.8, 420.88, 1.61311, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+8, 28366, 571, 1, 1, 0, 0, 5264.68, 2819.78, 421.656, 3.15645, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+9, 28366, 571, 1, 1, 0, 0, 5322.16, 2756.69, 421.646, 4.69978, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+10, 28366, 571, 1, 1, 0, 0, 5363.78, 2756.77, 421.629, 4.78226, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+11, 28366, 571, 1, 1, 0, 0, 5236.2, 2732.68, 421.649, 4.72336, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+12, 28366, 571, 1, 1, 0, 0, 5265.02, 2704.63, 421.7, 3.12507, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+13, 28366, 571, 1, 1, 0, 0, 5350.87, 2616.03, 421.243, 4.72729, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+14, 28366, 571, 1, 1, 0, 0, 5390.95, 2615.5, 421.126, 4.6409, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+15, 28366, 571, 1, 1, 0, 0, 5148.8, 2820.24, 421.621, 3.16043, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+16, 28366, 571, 1, 1, 0, 0, 5147.98, 2861.93, 421.63, 3.18792, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+17, 28366, 571, 1, 1, 0, 0, 5255.88, 3047.63, 438.499, 3.13677, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+18, 28366, 571, 1, 1, 0, 0, 5280.9, 3071.32, 438.499, 1.62879, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+19, 28366, 571, 1, 1, 0, 0, 5138.59, 2935.16, 439.845, 3.11723, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+20, 28366, 571, 1, 1, 0, 0, 5163.06, 2959.52, 439.846, 1.47258, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+21, 28366, 571, 1, 1, 0, 0, 5163.84, 2723.74, 439.844, 4.7097, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+22, 28366, 571, 1, 1, 0, 0, 5139.69, 2747.4, 439.844, 3.17221, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+23, 28366, 571, 1, 1, 0, 0, 5278.21, 2607.23, 439.755, 4.71944, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+24, 28366, 571, 1, 1, 0, 0, 5255.01, 2631.98, 439.755, 3.15257, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+25, 28366, 571, 1, 1, 0, 0, 4577.2, 3648.53, 402.887, 0.896749, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+26, 28366, 571, 1, 1, 0, 0, 4582.08, 3603.84, 402.887, 5.61437, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+27, 28366, 571, 1, 1, 0, 0, 4537.12, 3599.18, 402.887, 4.0739, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+28, 28366, 571, 1, 1, 0, 0, 4532.5, 3644.07, 402.886, 2.57358, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+29, 28366, 571, 1, 1, 0, 0, 4554.61, 3648.26, 426.54, 1.66536, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+30, 28366, 571, 1, 1, 0, 0, 4581.65, 3626.49, 426.537, 0.1851, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+31, 28366, 571, 1, 1, 0, 0, 4532.57, 3621.31, 426.54, 3.26692, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+32, 28366, 571, 1, 1, 0, 0, 4559.69, 3599.02, 426.538, 4.92348, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+33, 28366, 571, 1, 1, 0, 0, 4376, 2799.62, 412.63, 3.99122, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+34, 28366, 571, 1, 1, 0, 0, 4375.25, 2844.59, 412.631, 2.39053, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+35, 28366, 571, 1, 1, 0, 0, 4421.17, 2800.3, 412.631, 5.55263, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+36, 28366, 571, 1, 1, 0, 0, 4420.25, 2845.26, 412.631, 0.885186, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+37, 28366, 571, 1, 1, 0, 0, 4397.76, 2847.42, 436.283, 1.58921, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+38, 28366, 571, 1, 1, 0, 0, 4373.37, 2822.06, 436.283, 3.17986, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+39, 28366, 571, 1, 1, 0, 0, 4398.56, 2797.62, 436.283, 4.74542, 600, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+40, 28366, 571, 1, 1, 0, 0, 4422.94, 2822.89, 436.283, 0.0478602, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+41, 28366, 571, 1, 1, 0, 0, 4428.83, 1933.17, 441.995, 3.51626, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+42, 28366, 571, 1, 1, 0, 0, 4470.15, 1914.31, 441.995, 5.06677, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+43, 28366, 571, 1, 1, 0, 0, 4488.81, 1955.3, 441.996, 0.389292, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+44, 28366, 571, 1, 1, 0, 0, 4447.99, 1974.59, 441.995, 1.91471, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+45, 28366, 571, 1, 1, 0, 0, 4448.65, 1921.92, 465.647, 4.32327, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+46, 28366, 571, 1, 1, 0, 0, 4481.49, 1933.97, 465.647, 5.90388, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+47, 28366, 571, 1, 1, 0, 0, 4469.58, 1966.9, 465.648, 1.19127, 900, 0, 0, 50000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+48, 28366, 571, 1, 1, 0, 0, 4436.41, 1954.81, 465.647, 2.75771, 900, 0, 0, 50000, 0, 0, 0, 0, 0);

DELETE FROM `gameobject` WHERE `guid` BETWEEN @GAMEOBJECT_GUID+1 AND @GAMEOBJECT_GUID+38;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GAMEOBJECT_GUID+1, 194162, 571, 1, 1, 5397.11, 2841.54, 425.901, 3.14159, 0, 0, 1, 0, 180, 255, 1),
(@GAMEOBJECT_GUID+2, 190219, 571, 1, 1, 5371.46, 3047.47, 407.571, 3.14159, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+3, 190220, 571, 1, 1, 5331.26, 3047.1, 407.923, 0.052359, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+4, 190763, 571, 1, 1, 5153.41, 2901.35, 409.191, -0.069812, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+5, 190763, 571, 1, 1, 5268.7, 2666.42, 409.099, -0.715585, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+6, 190763, 571, 1, 1, 5197.05, 2944.81, 409.191, 2.33874, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+7, 190763, 571, 1, 1, 5196.67, 2737.34, 409.189, -2.93214, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+8, 190763, 571, 1, 1, 5314.58, 3055.85, 408.862, 0.541051, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+9, 190763, 571, 1, 1, 5391.28, 2828.09, 418.675, -2.16421, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+10, 190763, 571, 1, 1, 5153.93, 2781.67, 409.246, 1.65806, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+11, 190763, 571, 1, 1, 5311.44, 2618.93, 409.092, -2.37364, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+12, 190763, 571, 1, 1, 5269.21, 3013.84, 408.828, -1.76278, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+13, 191795, 571, 1, 1, 5385.84, 2909.49, 409.713, 0.008724, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+14, 192819, 571, 1, 1, 5401.63, 2853.67, 418.675, 2.63544, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+15, 191796, 571, 1, 1, 5384.45, 2771.84, 410.27, 3.14159, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+16, 191797, 571, 1, 1, 5343.29, 2908.86, 409.576, 0.008724, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+17, 191798, 571, 1, 1, 5342.72, 2771.39, 409.625, 3.14159, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+18, 191799, 571, 1, 1, 5371.44, 2630.61, 408.816, 3.13286, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+19, 191800, 571, 1, 1, 5301.84, 2909.09, 409.866, 0.008724, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+20, 191801, 571, 1, 1, 5301.06, 2771.41, 409.901, 3.14159, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+21, 191802, 571, 1, 1, 5280.2, 2995.58, 408.825, 1.61443, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+22, 191803, 571, 1, 1, 5279.14, 2956.02, 408.604, 1.5708, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+23, 191804, 571, 1, 1, 5278.69, 2882.51, 409.539, 1.5708, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+24, 191805, 571, 1, 1, 5279.13, 2840.8, 409.783, 1.57952, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+25, 191806, 571, 1, 1, 5279.5, 2798.94, 409.998, 1.5708, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+26, 191807, 571, 1, 1, 5279.94, 2724.77, 409.945, 1.56207, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+27, 191808, 571, 1, 1, 5279.6, 2683.79, 409.849, 1.55334, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+28, 191809, 571, 1, 1, 5330.96, 2630.78, 409.283, 3.13286, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+29, 191810, 571, 1, 1, 5397.11, 2841.54, 425.901, 3.14159, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+30, 193110, 571, 1, 1, 5386.08, 3007.86, 409.175, 2.96704, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+31, 190369, 571, 1, 1, 5256.08, 2933.96, 409.357, 3.13286, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+32, 190370, 571, 1, 1, 5257.46, 2747.33, 409.743, -3.13286, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+33, 190371, 571, 1, 1, 5214.96, 2934.09, 409.19, -0.008724, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+34, 190372, 571, 1, 1, 5215.82, 2747.57, 409.188, -3.13286, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+35, 190374, 571, 1, 1, 5162.27, 2883.04, 410.256, 1.57952, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+36, 190375, 571, 1, 1, 5162.99, 2841.23, 410.162, -3.13286, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+37, 190376, 571, 1, 1, 5163.72, 2799.84, 409.227, 1.57952, 0, 0, 0, 1, 180, 0, 1),
(@GAMEOBJECT_GUID+38, 192829, 571, 1, 1, 5440, 2840.8, 430.43, 0, 0, 0, 0, 0, 120, 0, 1);

-- SmartScript
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (30400,30499,31841,31842);
INSERT INTO smart_scripts (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Demolisher Engineers
(30400, 0, 1, 0, 62, 0, 100, 0, 9904, 0, 0, 0, 85, 56663, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip option 0 select - Cast Build Catapult'),
(30400, 0, 2, 0, 62, 0, 100, 0, 9904, 1, 0, 0, 85, 56575, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip option 1 select - Cast Build Demolisher'),
(30400, 0, 3, 0, 62, 0, 100, 0, 9904, 2, 0, 0, 85, 61408, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip option 2 select - Cast Build Siege Engine'),
(30499, 0, 1, 0, 62, 0, 100, 0, 9923, 0, 0, 0, 85, 56663, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip option 0 select - Cast Build Catapult'),
(30499, 0, 2, 0, 62, 0, 100, 0, 9923, 1, 0, 0, 85, 56575, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip option 1 select - Cast Build Demolisher'),
(30499, 0, 3, 0, 62, 0, 100, 0, 9923, 2, 0, 0, 85, 56661, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip option 2 select - Cast Build Siege Engine'),
-- Spirits Guides
(31842, 0, 1, 0, 62, 0, 100, 0, 10128, 0, 0, 0, 85, 59760, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip option 0 select - Cast Teleport: Fortress Graveyard.'),
(31842, 0, 2, 0, 62, 0, 100, 0, 10128, 1, 0, 0, 85, 59762, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip option 1 select - Cast Teleport: Sunken Ring'),
(31842, 0, 3, 0, 62, 0, 100, 0, 10128, 2, 0, 0, 85, 59763, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip option 2 select - Cast Teleport: Broken Temple'),
(31842, 0, 4, 0, 62, 0, 100, 0, 10128, 3, 0, 0, 85, 59766, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip option 3 select - Cast Teleport: Westspark Factory Graveyard'),
(31842, 0, 5, 0, 62, 0, 100, 0, 10128, 4, 0, 0, 85, 59767, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip option 4 select - Cast Teleport: Eastspark Factory Graveyard'),
(31842, 0, 6, 0, 62, 0, 100, 0, 10128, 5, 0, 0, 85, 59769, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip option 5 select - Cast Teleport: Alliance Landing Zone'),
(31841, 0, 1, 0, 62, 0, 100, 0, 10129, 0, 0, 0, 85, 59760, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip option 0 select - Cast Teleport: Fortress Graveyard.'),
(31841, 0, 2, 0, 62, 0, 100, 0, 10129, 1, 0, 0, 85, 59762, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip option 1 select - Cast Teleport: Sunken Ring'),
(31841, 0, 3, 0, 62, 0, 100, 0, 10129, 2, 0, 0, 85, 59763, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip option 2 select - Cast Teleport: Broken Temple'),
(31841, 0, 4, 0, 62, 0, 100, 0, 10129, 3, 0, 0, 85, 59766, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip option 3 select - Cast Teleport: Westspark Factory Graveyard'),
(31841, 0, 5, 0, 62, 0, 100, 0, 10129, 4, 0, 0, 85, 59767, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip option 4 select - Cast Teleport: Eastspark Factory Graveyard'),
(31841, 0, 6, 0, 62, 0, 100, 0, 10129, 5, 0, 0, 85, 59765, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip option 5 select - Cast Teleport: Horde Landing Zone');

-- Spell Scripts
DELETE FROM `spell_scripts` WHERE `id` IN('49899','56663','56575','61408','59760','59762','59763','59765','59766','59767','59769');
INSERT INTO `spell_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`) VALUES
('49899','0','1','402','0'), -- Activate Robotic Arms
('49899','9','1','404','0'), -- Activate Robotic Arms
('49899','13','1','405','0'), -- Activate Robotic Arms
('49899','15','1','406','0'), -- Activate Robotic Arms
('49899','18','1','410','0'), -- Activate Robotic Arms
('56663','0','33','0','0'), -- Build Catapult
('56663','0','15','49899','2'), -- Cast Activate Robotic Arms
('56575','0','33','0','0'), -- Build Demolisher
('56575','0','15','49899','2'), -- Cast Activate Robotic Arms
('61408','0','33','0','0'), -- Build Siege Engine
('61408','0','15','49899','2'), -- Cast Activate Robotic Arms
('56661','0','33','0','0'), -- Build Siege Engine
('56661','0','15','49899','2'), -- Cast Activate Robotic Arms
('59760','0','33','0','0'), -- Teleport: Fortress Graveyard
('59762','0','33','0','0'), -- Teleport: Sunken Ring
('59763','0','33','0','0'), -- Teleport: Broken Temple
('59765','0','33','0','0'), -- Teleport: Horde Landing Zone
('59766','0','33','0','0'), -- Teleport: Westspark Factory Graveyard
('59767','0','33','0','0'), -- Teleport: Eastspark Factory Graveyard
('59769','0','33','0','0'); -- Teleport: Alliance Landing Zone

-- Spell Target Position
DELETE FROM `spell_target_position` WHERE `id` IN (59760,59762,59763,59765,59766,59767,59769);
INSERT INTO `spell_target_position` (`id`,`target_map`,`target_position_x`,`target_position_y`,`target_position_z`,`target_orientation`) VALUES
(59760,571,5537.986,2897.493,517.057,4.819249), -- Teleport: Fortress Graveyard
(59762,571,5104.750,2300.940,368.579,0.733038), -- Teleport: Sunken Ring "area 4538"
(59763,571,5099.120,3466.036,368.484,5.317802), -- Teleport: Broken Temple "area 4539 & 4589"
(59765,571,5032.454,3711.382,372.468,3.971623), -- Teleport: Horde Landing Zone
(59766,571,4331.716,3235.695,390.251,0.008500), -- Teleport: Westspark Factory Graveyard "area 4611"
(59767,571,4314.648,2408.522,392.642,6.268125), -- Teleport: Eastspark Factory Graveyard "area 4612"
(59769,571,5140.790,2179.120,390.950,1.972220); -- Teleport: Alliance Landing Zone

-- Spell linked Spell
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN(54640,58045,56618,56617,55773,55774,-54640,-58045,-56618,-56617,-55773,-55774) OR `spell_effect` IN(54640,58045,56618,56617,55773,55774,-54640,-58045,-56618,-56617,-55773,-55774);
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(54640,54643,0, 'Wintergrasp teleporter'), --  Teleports defenders behind the walls on the Isle of Ulduran, Strand of the Ancients (FIX THIS?)
(56617,-56618,1, 'When "Alliance Controls Workshop" HIT "Horde Controls Workshop" are REMOVED'),
(56618,-56617,1, 'When "Horde Controls Workshop" HIT "Alliance Controls Workshop" are REMOVED'),
(55773,-55774,1, 'When "Horde Control" HIT "Alliance Control" are REMOVED'),
(55774,-55773,1, 'When "Alliance Control" HIT "Horde Control" are REMOVED'),
(-55773,-58045,0, 'When "Horde Control" is REMOVED "Essence of Wintergrasp (PhaseShift)" are REMOVED'),
(-55774,-58045,0, 'When "Alliance Control" is REMOVED "Essence of Wintergrasp (PhaseShift)" are REMOVED');

-- Spell area
DELETE FROM `spell_area` WHERE `spell` IN (58730,58045,56618,56617,55773,55774,57940, 58729, 37795, 33280, 55629, 58549, 59911);
INSERT INTO `spell_area` (`spell`,`area`,`gender`,`autocast`) VALUES
-- Essence of Wintergrasp
(57940,65,2,1), -- Dragonblight
(57940,66,2,1), -- Zul'Drak
(57940,67,2,1), -- The Storm Peaks
(57940,210,2,1), -- Icecrown
(57940,394,2,1), -- Grizzly Hills
(57940,495,2,1), -- Howling Fjord
(57940,2817,2,1), -- Crystalsong Forest
(57940,3477,2,1), -- Azjol-Nerub
(57940,3537,2,1), -- Borean Tundra
(57940,3711,2,1), -- Sholazar Basin
(57940,3979,2,1), -- The Frozen Sea
(57940,4201,2,1), -- Vordrassil's Tears
(57940,4258,2,1), -- The North Sea
(57940,4395,2,1), -- Dalaran
(57940,4602,2,1), -- Force Interior
(57940,4630,2,1), -- The North Sea
(57940,4742,2,1), -- Hrothgar's Landing
(57940,4987,2,1), -- The Ruby of Sanctum
(57940,4812,2,1), -- Icecrown Citadel
(57940,4893,2,1), -- The Frost Queen's Lair
(57940,4894,2,1), -- Putricide's Laboratory of Alchemical Horrors and Fun
(57940,4895,2,1), -- The Crimson Hall
(57940,4896,2,1), -- The Frozen Throne
(57940,4897,2,1), -- The Sanctum of Blood
-- Essence of Wintergrasp (PhaseShift)
(58045,4197,2,1), -- Conquista del Invierno
-- Phase Shift
(55773,4197,2,1), -- Conquista del Invierno
(55774,4197,2,1), -- Conquista del Invierno
(56618,4197,2,1), -- Conquista del Invierno
(56617,4197,2,1), -- Conquista del Invierno
-- Restricted Flight Area (Wintergrasp Eject)
-- (58730,4197,2,1),
-- Spiritual Immunity
(58729,4197,2,0), -- Conquista del Invierno
-- Recruit
(37795,4197,2,0), -- Conquista del Invierno
-- Corporal
(33280,4197,2,0), -- Conquista del Invierno
-- Lieutenant
(55629,4197,2,0), -- Conquista del Invierno
-- Tenacity
(58549,4197,2,0), -- Conquista del Invierno
-- Vehicle Tenacity
(59911,4197,2,0); -- Conquista del Invierno

-- Conditions
-- Add gossip_menu condition for 9904 Horde
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=14 OR `SourceTypeOrReferenceId`=15) AND `SourceGroup` IN(9904,9923);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`) VALUES
(14,9904,13759,0,1,33280), -- Must have Rank 1: Corporal
(14,9904,13759,1,1,55629), -- Or must have Rank 2: First Lieutenant
(14,9904,13761,0,11,33280), -- Must not have Rank 1: Corporal
(14,9904,13761,0,11,55629), -- Must not have Rank 2: First Lieutenant
-- Add gossip_menu condition for 9923 Alliance
(14,9923,13798,0,1,33280), -- Must have Rank 1: Corporal
(14,9923,13798,1,1,55629), -- Or must have Rank 2: First Lieutenant
(14,9923,14172,0,11,33280), -- Must not have Rank 1: Corporal
(14,9923,14172,0,11,55629), -- Must not have Rank 2: First Lieutenant
-- Add conditions to gossip options horde
(15,9904,0,0,1,33280), -- Must have reached Rank 1: Corporal
(15,9904,0,1,1,55629), -- Or must have reached Rank 2: First Lieutenant
(15,9904,1,0,1,55629), -- Must have reached Rank 2: First Lieutenant
(15,9904,2,0,1,55629), -- Must have reached Rank 2: First Lieutenant
-- Add conditions to gossip options alliance
(15,9923,0,0,1,33280), -- Must have reached Rank 1: Corporal
(15,9923,0,1,1,55629), -- Or must have reached Rank 2: First Lieutenant
(15,9923,1,0,1,55629), -- Must have reached Rank 2: First Lieutenant
(15,9923,2,0,1,55629); -- Must have reached Rank 2: First Lieutenant

-- Conditions
-- Spirit Guides
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=14 OR `SourceTypeOrReferenceId`=15) AND `SourceGroup` IN(10128, 10129);
INSERT INTO conditions (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
 -- La batalla debe estar en curso
(14, 10128, 14063, 0, 11, 3710, 1, 0, 0, '', NULL),
(15, 10128, 0, 0, 11, 3710, 1, 0, 0, '', NULL),
(15, 10128, 1, 0, 11, 3710, 1, 0, 0, '', NULL),
(15, 10128, 2, 0, 11, 3710, 1, 0, 0, '', NULL),
(15, 10128, 3, 0, 11, 3710, 1, 0, 0, '', NULL),
(15, 10128, 4, 0, 11, 3710, 1, 0, 0, '', NULL),
-- Bajo el control de la Alianza:
(15, 10128, 0, 0, 11, 3802, 0, 0, 0, '', NULL), -- Conquiesta del Invierno
(15, 10128, 1, 0, 11, 3700, 7, 0, 0, '', NULL), -- El Templo Quebrado
(15, 10128, 2, 0, 11, 3701, 7, 0, 0, '', NULL), -- El Anillo Sumergido
(15, 10128, 3, 0, 11, 3702, 7, 0, 0, '', NULL), -- Taller Chispa Occidental
(15, 10128, 4, 0, 11, 3703, 7, 0, 0, '', NULL), -- Taller Chispa Oriental

 -- La batalla debe estar en curso
(14, 10129, 14063, 0, 11, 3710, 1, 0, 0, '', NULL),
(15, 10129, 0, 0, 11, 3710, 1, 0, 0, '', NULL),
(15, 10129, 1, 0, 11, 3710, 1, 0, 0, '', NULL),
(15, 10129, 2, 0, 11, 3710, 1, 0, 0, '', NULL),
(15, 10129, 3, 0, 11, 3710, 1, 0, 0, '', NULL),
(15, 10129, 4, 0, 11, 3710, 1, 0, 0, '', NULL),
-- Bajo el control de la Horda:
(15, 10129, 0, 0, 11, 3802, 1, 0, 0, '', NULL), -- Conquista del Invierno
(15, 10129, 1, 0, 11, 3700, 4, 0, 0, '', NULL), -- El Templo Quebrado
(15, 10129, 2, 0, 11, 3701, 4, 0, 0, '', NULL), -- El Anillo Sumergido
(15, 10129, 3, 0, 11, 3702, 4, 0, 0, '', NULL), -- Taller Chispa Occidental
(15, 10129, 4, 0, 11, 3703, 4, 0, 0, '', NULL); -- Taller Chispa Oriental

-- Conditions
DELETE FROM `conditions` WHERE `SourceEntry` IN(55774, 55773, 56618, 56617, 58045, 58730, 57940, 55164);
INSERT INTO conditions (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES

-- Alliance Control Phase Shift
(17, 0, 55774, 0, 11,   3802, 0, 0, 0, 0, '', 'Si Conquista del Invierno esta bajo el control de la Alianza'),
(17, 0, 55774, 0, 26, 0x0080, 0, 0, 1, 0, '', 'Si el jugador no posee phaseMask = 128'),

-- Horde Control Phase Shift
(17, 0, 55773, 0, 11,   3802, 1, 0, 0, 0, '', 'Si Conquista del Invierno esta bajo el control de la Horda'),
(17, 0, 55773, 0, 26, 0x0040, 0, 0, 1, 0, '', 'Si el jugador no posee phaseMask = 64'),

-- Alliance Controls Factory Phase Shift
(17, 0, 56617, 0, 30, 192030, 300, 0, 0, 0, '', 'Si es El Templo Quebrado'),
(17, 0, 56617, 0, 11,   3700,   7, 0, 0, 0, '', 'Si el Taller esta bajo el control de la Alianza'),
(17, 0, 56617, 0, 26, 0x0020,   0, 0, 1, 0, '', 'Si el jugador no posee phaseMask = 32'),
-- OR
(17, 0, 56617, 1, 30, 192031, 300, 0, 0, 0, '', 'Si es El Anillo Sumergido'),
(17, 0, 56617, 1, 11,   3701,   7, 0, 0, 0, '', 'Si el Taller esta bajo el control de la Alianza'),
(17, 0, 56617, 1, 26, 0x0020,   0, 0, 1, 0, '', 'Si el jugador no posee phaseMask = 32'),
-- OR
(17, 0, 56617, 2, 30, 192032, 300, 0, 0, 0, '', 'Si es el Taller Chispa Occidental'),
(17, 0, 56617, 2, 11,   3702,   7, 0, 0, 0, '', 'Si el Taller esta bajo el control de la Alianza'),
(17, 0, 56617, 2, 26, 0x0020,   0, 0, 1, 0, '', 'Si el jugador no posee phaseMask = 32'),
-- OR
(17, 0, 56617, 3, 30, 192033, 300, 0, 0, 0, '', 'Si es el Taller Chispa Oriental'),
(17, 0, 56617, 3, 11,   3703,   7, 0, 0, 0, '', 'Si el Taller esta bajo el control de la Alianza'),
(17, 0, 56617, 3, 26, 0x0020,   0, 0, 1, 0, '', 'Si el jugador no posee phaseMask = 32'),

-- Horde Controls Factory Phase Shift
(17, 0, 56618, 0, 30, 192030, 300, 0, 0, 0, '', 'Si es El Templo Quebrado'),
(17, 0, 56618, 0, 11,   3700,   4, 0, 0, 0, '', 'Si el Taller esta bajo el control de la Horda'),
(17, 0, 56618, 0, 26, 0x0010,   0, 0, 1, 0, '', 'Si el jugador no posee phaseMask = 16'),
-- OR
(17, 0, 56618, 1, 30, 192031, 300, 0, 0, 0, '', 'Si es El Anillo Sumergido'),
(17, 0, 56618, 1, 11,   3701,   4, 0, 0, 0, '', 'Si el Taller esta bajo el control de la Horda'),
(17, 0, 56618, 1, 26, 0x0010,   0, 0, 1, 0, '', 'Si el jugador no posee phaseMask = 16'),
-- OR
(17, 0, 56618, 2, 30, 192032, 300, 0, 0, 0, '', 'Si es el Taller Chispa Occidental'),
(17, 0, 56618, 2, 11,   3702,   4, 0, 0, 0, '', 'Si el Taller esta bajo el control de la Horda'),
(17, 0, 56618, 2, 26, 0x0010,   0, 0, 1, 0, '', 'Si el jugador no posee phaseMask = 16'),
-- OR
(17, 0, 56618, 3, 30, 192033, 300, 0, 0, 0, '', 'Si es el Taller Chispa Oriental'),
(17, 0, 56618, 3, 11,   3703,   4, 0, 0, 0, '', 'Si el Taller esta bajo el control de la Horda'),
(17, 0, 56618, 3, 26, 0x0010,   0, 0, 1, 0, '', 'Si el jugador no posee phaseMask = 16'),

-- Essence of Wintergrasp
(17, 0, 57940, 0, 6,   469, 0, 0, 0, 0, '', 'Si el jugador es de la Alianza'),
(17, 0, 57940, 0, 11, 3802, 0, 0, 0, 0, '', 'Si Conquista del Invierno esta bajo el control de la Alianza'),
-- OR
(17, 0, 57940, 1,  6,   67, 0, 0, 0, 0, '', 'Si el jugador es de la Horda'),
(17, 0, 57940, 1, 11, 3802, 1, 0, 0, 0, '', 'Si Conquista del Invierno esta bajo el control de la Horda'),

-- Essence of Wintergrasp (Phase Shift)
(17, 0, 58045, 0, 6,     469, 0, 0, 0, 0, '', 'Si el jugador es de la Alianza'),
(17, 0, 58045, 0, 11,   3710, 0, 0, 0, 0, '', 'Si Conquista del Invierno no esta en curso'),
(17, 0, 58045, 0, 11,   3802, 0, 0, 0, 0, '', 'Si Conquista del Invierno esta bajo el control de la Alianza'),
(17, 0, 58045, 0, 26, 0x0100, 0, 0, 1, 0, '', 'Si el jugador no posee phaseMask = 256'),
-- OR
(17, 0, 58045, 1,  6,     67, 0, 0, 0, 0, '', 'Si el jugador es de la Horda'),
(17, 0, 58045, 1, 11,   3710, 0, 0, 0, 0, '', 'Si Conquista del Invierno no esta en curso'),
(17, 0, 58045, 1, 11,   3802, 1, 0, 0, 0, '', 'Si Conquista del Invierno esta bajo el control de la Horda'),
(17, 0, 58045, 1, 26, 0x0100, 0, 0, 1, 0, '', 'Si el jugador no posee phaseMask = 256'),

-- Restricted Flight Area (Wintergrasp Eject)
-- (17, 0, 58730, 0, 11, 3710, 1, 0, 0, 0, '', 'Si Conquista del Invierno esta en curso'),

-- Swift Spectral Gryphon
(17, 0, 55164, 0, 4, 4197, 0, 0, 0, 0, '', 'Si esta en Wintergrasp'),
(17, 0, 55164, 0, 11, 3710, 0, 0, 0, 0, '', 'Si Conquista del Invierno no esta en curso'),
-- OR
(17, 0, 55164, 1, 4, 4197, 0, 0, 1, 0, '', 'Si no esta en Wintergrasp');