DROP TABLE IF EXISTS `battlecl_house_instance`;

CREATE TABLE `battlecl_house_instance` (
  `guid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `houseId` tinyint(3) unsigned NOT NULL,
  `guildId` int(10) unsigned NOT NULL,
  `startTime` int(10) unsigned NOT NULL,
  `endTime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
