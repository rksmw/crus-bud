DELETE FROM `command` WHERE `permission` BETWEEN 1000 AND 1005;
INSERT INTO `command` (`name`, `permission`, `help`)
VALUES
('spectator', 		 	1001, 'Syntax: .spectator $subcommand.\nUse .help spectate'),
('spectator version',	1000, 'Syntax: .spectator version '),
('spectator spectate',	1004, 'Syntax: .spectator spectate playerName\nAllow to spectate player.'),
('spectator leave',		1003, 'Syntax: .spectator leave\nDisable spectator mode.'),
('spectator watch',		1002, 'Syntax: .spectator watch  playerName\nAllow player to spectate arena from another player.'),
('spectator reset',		1005, 'Syntax: .spectator reset\nSend addon data.');
