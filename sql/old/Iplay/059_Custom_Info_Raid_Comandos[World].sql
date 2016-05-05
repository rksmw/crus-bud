-- Textos de anuncio para el Boss kill
DELETE FROM `trinity_string` WHERE `entry` IN (10100, 10101, 10102, 10103, 10104, 10105, 10106, 10107, 10108, 10109);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
(10100, '|Cffff0000[RAID INFO] |cff00ffff%s %uN: |Cff00ff00%s |cff00ffffderrotado por la hermandad |Cff00ff00%s|cff00ffff. Jugadores: %u/%u    Progresión: %u/%u    Detalle: .raid info %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10101, '|Cffff0000[RAID INFO] |cff00ffff%s %uH: |Cff00ff00%s |cff00ffffderrotado por la hermandad |Cff00ff00%s|cff00ffff. Jugadores: %u/%u    Progresión: %u/%u    Detalle: .raid info %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10102, '|Cffff0000[RAID INFO] |cff00ffff%s %uN: |Cff00ff00Gemelas Valkyr |cff00ffffderrotadas por la hermandad |Cff00ff00%s|cff00ffff. Jugadores: %u/%u    Progresión: %u/%u    Detalle: .raid info %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10103, '|Cffff0000[RAID INFO] |cff00ffff%s %uH: |Cff00ff00Gemelas Valkyr |cff00ffffderrotadas por la hermandad |Cff00ff00%s|cff00ffff. Jugadores: %u/%u    Progresión: %u/%u    Detalle: .raid info %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10104, '|Cffff0000[RAID INFO] |cff00ffff%s %uN: |Cff00ff00Consejo de Sangre |cff00ffffderrotado por la hermandad |Cff00ff00%s|cff00ffff. Jugadores: %u/%u    Progresión: %u/%u    Detalle: .raid info %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10105, '|Cffff0000[RAID INFO] |cff00ffff%s %uH: |Cff00ff00Consejo de Sangre |cff00ffffderrotado por la hermandad |Cff00ff00%s|cff00ffff. Jugadores: %u/%u    Progresión: %u/%u    Detalle: .raid info %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10106, '|Cffff0000[RAID INFO] |cff00ffff%s %uN: |Cff00ff00Batalla Naval |cff00ffffsuperado por la hermandad |Cff00ff00%s|cff00ffff. Jugadores: %u/%u    Progresión: %u/%u    Detalle: .raid info %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10107, '|Cffff0000[RAID INFO] |cff00ffff%s %uH: |Cff00ff00Batalla Naval |cff00ffffsuperado por la hermandad |Cff00ff00%s|cff00ffff. Jugadores: %u/%u    Progresión: %u/%u    Detalle: .raid info %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10108, '|Cffff0000[RAID INFO] |cff00ffff%s %uN: |Cff00ff00%s |cff00ffffrescatada por la hermandad |Cff00ff00%s|cff00ffff. Jugadores: %u/%u    Progresión: %u/%u    Detalle: .raid info %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10109, '|Cffff0000[RAID INFO] |cff00ffff%s %uH: |Cff00ff00%s |cff00ffffrescatada por la hermandad |Cff00ff00%s|cff00ffff. Jugadores: %u/%u    Progresión: %u/%u    Detalle: .raid info %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- Info Commands

-- Strings para el Info Player
DELETE FROM `trinity_string` WHERE `entry` BETWEEN 11300 AND 11310;
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
(11300, '|cff00ffff========== PLAYER INFO ===========', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11301, '|Cff00ff00 Nombre:|r %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11302, '|Cff00ff00 Hermandad:|r %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11303, '|Cff00ff00 Clase&Rama:|r %s  -  %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11304, '|Cff00ff00 Talentos:|r %u  -  %u  -  %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11305, '|Cff00ff00 Posible Rol:|r %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11306, '|Cff00ff00 GS total:|r %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11307, '|Cff00ff00 ilvl equipado:|r %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11308, '|Cff00ff00 MMR 2c2 3c3 5c5:|r %u  -  %u  -  %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11309, '  - BattleCore - Puedes usar .raid list $nombre para conocer los cds de raids/dungeons de un jugador', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11310, '|cff00ffff=================================', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- Strings para el Info Raid
DELETE FROM `trinity_string` WHERE `entry` BETWEEN 11311 AND 11321;
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
(11311, '|cff00ffff==================== RAID INFO ====================', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11312, '|Cff00ff00 RaidID:|r %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11313, '|Cff00ff00 Mapa&Dificultad:|r %s, %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11314, '|Cff00ff00 Encuentros:|r %u/%u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11315, '|Cff00ff00 Lider:|r  %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11316, '|Cff00ff00 Jugadores:|r %u/%u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11317, '|Cff00ff00 Posibles Roles:|r %u Tankes - %u Healers - %u Dps', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11318, '|Cff00ff00 GS Promedio:|r %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11319, '|Cff00ff00 ilvl Promedio:|r %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11320, '  - BattleCore - Puedes usar .player info $nombre para conocer detalles de un jugador online', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11321, '|cff00ffff=================================================', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- Strings para el List Raid
DELETE FROM `trinity_string` WHERE `entry` BETWEEN 11322 AND 11327;
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
(11322, '|cff00ffff==================== RAID LIST ====================', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11323, '|Cff00ff00 Jugador:|r  %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11324, '|Cff00ff00 RaidID:|r %u    |Cff00ff00 Mapa&Dificultad:|r %s, %s    [ACTIVO]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11325, '|Cff00ff00 RaidID:|r %u    |Cff00ff00 Mapa&Dificultad:|r %s, %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11326, '  - BattleCore - Puedes usar .raid info $raidId para conocer la composicion de un raid activo aqui listado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11327, '|cff00ffff=================================================', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- Comando
SET @id = 1000;
-- DELETE FROM `rbac_permissions` WHERE `id` BETWEEN @id AND @id+3;
-- INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
-- (@id+1, 'player info'),
-- (@id+2, 'raid info'),
-- (@id+3, 'raid list');

-- DELETE FROM `rbac_role_permissions` WHERE `roleId` = 0 AND `permissionId` BETWEEN @id AND @id+3;
-- INSERT INTO `rbac_role_permissions` (`roleId`, `permissionId`) VALUES
-- (0,@id+1),
-- (0,@id+2),
-- (0,@id+3);

DELETE FROM `command` WHERE `permission` BETWEEN @id+1 AND @id+3;  
INSERT INTO `command` (`name`,`permission`,`help`) VALUES
('player info',@id+10,'Sintaxis: .player info $jugador o target actual.\r\n\nMuestra informacion de interes del objetivo!\r\n\nBattleCore'),
('raid info',@id+11,'Sintaxis: .raid info #idraid.\r\nPuede que ninguno de los integrantes de este RaidID este conectado, o sea erroneo!\r\n\nBattleCore'),
('raid list',@id+12,'Sintaxis: .raid list $jugador o target actual.\r\nMuestra la lista de las raids activas del objetivo! Funciona siempre que haya entrado a la instance al menos una vez y este en grupo\r\n\nBattleCore');
