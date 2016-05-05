DROP TABLE IF EXISTS `battlecl_guildwars`;
CREATE TABLE `battlecl_guildwars` (
  `guildId` int(10) unsigned NOT NULL,
  `win` int(10) unsigned NOT NULL DEFAULT '0',
  `total` bigint(20) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`guildId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
