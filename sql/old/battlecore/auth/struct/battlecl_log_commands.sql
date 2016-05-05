DROP TABLE IF EXISTS `battlecl_log_commands`;

CREATE TABLE `battlecl_log_commands` (
  `accountId` int(10) unsigned NOT NULL DEFAULT '0',
  `guid` int(10) unsigned NOT NULL DEFAULT '0',
  `command` varchar(50) NOT NULL,
  `args` varchar(100) NOT NULL,
  `targetType` varchar(12) NOT NULL,
  `targetName` varchar(100) NOT NULL,
  `targetGUID` int(10) unsigned NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `mapId` smallint(5) unsigned NOT NULL DEFAULT '0',
  `time` int(10) unsigned NOT NULL DEFAULT '0',
  `realmId` tinyint(3) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
