-- Nuevo trinity_string para lo de cola de BGs
DELETE FROM `trinity_string` WHERE entry = 711;
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('711','[BG INFO] %s (%u - %u) Ali: %u (faltan %u) Horda: %u (faltan %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- cambiando el anuncio amarillo feo por algo mas wai, comenzando BG INFO
DELETE FROM `trinity_string` WHERE `entry` IN (712);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
(712, '|Cffff0000[BG INFO] |Cff00ff00%s |cff00ffff-- [%u-%u] Ali: %u (faltan %u) Horda: %u (faltan %u)|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

DELETE FROM `trinity_string` WHERE entry = 717;
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('717','|Cffff0000[BG INFO] |Cff00ff00%s |cff00ffff-- [%u-%u] Inicia!|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
