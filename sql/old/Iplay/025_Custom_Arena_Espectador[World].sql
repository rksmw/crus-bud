SET @entry :=5000000;

DELETE FROM creature_template WHERE entry = @entry+6;

INSERT INTO `creature_template` VALUES (@entry+6, 0, 0, 0, 0, 0, 29348, 0, 0, 0, 'Arena Espectador', 'BattleCore', 'Speak', 50001, 71, 71, 2, 35, 35, 1, 1, 1.14286, 1.25, 1, 124, 256, 0, 783, 1, 2000, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 138936390, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.56, 1.56, 1.56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 'npc_arena_spectator', 12340);

-- DELETE FROM `creature` WHERE `id` = @entry+6;
-- INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
-- (@entry+6, 571, 1, 1, 0, 0, 5785.08, 631.906, 647.687, 0.810619, 300, 0, 0, 14494, 0, 0, 0, 0, 0);

SET @id = 1000;
-- DELETE FROM `rbac_permissions` WHERE `id` BETWEEN @id AND @id+5;
-- INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
-- (@id+1, 'spectate'),
-- (@id+2, 'spectate view'),
-- (@id+3, 'spectate leave'),
-- (@id+4, 'spectate player'),
-- (@id+5, 'spectate reset');

-- DELETE FROM `rbac_role_permissions` WHERE `roleId` = 0 AND `permissionId` BETWEEN @id AND @id+5;
-- INSERT INTO `rbac_role_permissions` (`roleId`, `permissionId`) VALUES
-- (0,@id+1),
-- (0,@id+2),
-- (0,@id+3),
-- (0,@id+4),
-- (0,@id+5);

DELETE FROM `command` WHERE `permission` BETWEEN @id+1 AND @id+5;
INSERT INTO `command` (`name`, `permission`, `help`)
VALUES
('spectate', @id+1, 'Syntax: .spectate $subcommand.\nUse .help sppectate'),
('spectate view',@id+2, 'Syntax: .spectate view #player\nAllow player to spectate arena from anotherplayer.'),
('spectate leave', @id+3, 'Syntax: .spectate leave\nDisable spectator mode.'),
('spectate player', @id+4, 'Syntax: .spectate player #player\nAllow to spectate player.'),
('spectate reset', @id+5, 'Syntax: .spectate reset\nSend addon data.');

UPDATE `gameobject_template` SET `flags` = 36 WHERE entry IN (185918, 185917, 183970, 183971, 183972, 183973, 183977, 183979, 183978, 183980, 192642, 192643);
