-- Arreglar portales y teletransportes de Wintergrasp (Conquista de invierno)
DELETE FROM `spell_script_names` WHERE `spell_id` = 58622;
INSERT INTO `spell_script_names` VALUES (58622, 'spell_wintergrasp_teleport_wintergrasp');
DELETE FROM `spell_target_position` WHERE `id` IN(59096, 58632, 58633);
INSERT INTO `spell_target_position` (`id`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
(59096, 571, 5325.06, 2843.36, 409.285, 3.20278), (58632, 571, 5097.79, 2180.29, 365.61, 2.41), (58633, 571, 5026.80, 3676.69, 362.58, 3.94);
DELETE FROM `gameobject` WHERE `id` = 193772 AND `spawntimesecs` = 300;
INSERT INTO `gameobject` VALUES (NULL, 193772, 571, 1, 1, 5924.29, 570.311, 661.087, 6.28092, 0, 0, 0.0011324, -0.999999, 300, 0, 1);
