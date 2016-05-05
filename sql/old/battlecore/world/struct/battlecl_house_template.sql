DROP TABLE IF EXISTS `battlecl_house_template`;

CREATE TABLE `battlecl_house_template` (
  `houseId` tinyint(3) unsigned NOT NULL,
  `typeId` tinyint(3) unsigned NOT NULL,
  `teamId` tinyint(3) unsigned NOT NULL,
  `wardenGuid` int(10) unsigned NOT NULL,
  `mapId` smallint(5) unsigned NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `o` float NOT NULL,
  `available` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`houseId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
