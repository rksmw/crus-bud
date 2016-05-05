DROP TABLE IF EXISTS `battlecl_character_backup`;

CREATE TABLE `battlecl_character_backup` (
  `account` int(10) unsigned NOT NULL,
  `startTime` int(10) unsigned NOT NULL,
  `endTime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`account`, `startTime`, `endTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `battlecl_character_backup_item`;

CREATE TABLE `battlecl_character_backup_item` (
  `guid` int(10) unsigned NOT NULL,
  `entry` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
