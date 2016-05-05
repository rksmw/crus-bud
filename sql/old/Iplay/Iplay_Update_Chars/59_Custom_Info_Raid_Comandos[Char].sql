DROP TABLE IF EXISTS `character_raidinfo`;
CREATE TABLE `character_raidinfo` (
  `Guid` bigint(20) NOT NULL AUTO_INCREMENT,
  `GuildId` int(10) NOT NULL,
  `GuildName` varchar(255) NOT NULL,
  `CreatureEntry` int(10) NOT NULL,
  `CreatureName` varchar(255) NOT NULL,
  `PlayerCount` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LeaderName` varchar(255) NOT NULL,
  `RaidId` int(6) NOT NULL,
  `KillDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `KillData` longtext NOT NULL,
  `MapId` smallint(6) unsigned NOT NULL DEFAULT '0',
  `MapName` varchar(255) NOT NULL,
  `MapSpawnMode` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `MapMaxPlayers` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `CompletedEncounters` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `TotalEncounters` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`Guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
