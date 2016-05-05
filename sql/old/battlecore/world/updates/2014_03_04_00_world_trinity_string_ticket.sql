-- Implementamos que cuando se complete un ticket llegue un mensaje al destinatario de que su ticket fue completado.
DELETE FROM `trinity_string` WHERE `entry` = 11130;
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES (11130, '|cff00ff00Completado por|r:|cff00ccff %s|r');
