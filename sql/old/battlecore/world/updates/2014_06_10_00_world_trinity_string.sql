DELETE FROM `trinity_string` WHERE `entry` = 11002;
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES ('11002', '|cffff0000[Arena Queue Announcer]:|r A team has joined : %ux%u : %u|r');
UPDATE `trinity_string` SET `content_loc6`='|cffff0000[Anuncio de Cola de Arena]:|r Un equipo se unio : %ux%u : %u|r' WHERE `entry` = 11002;
