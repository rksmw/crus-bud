DROP TABLE IF EXISTS `battlecl_event_gameobject`;

CREATE TABLE `battlecl_event_gameobject` (
  `id` smallint(5) unsigned NOT NULL,
  `gameobject` int(10) unsigned NOT NULL,
  `account` int(10) unsigned NOT NULL,
  PRIMARY KEY (`gameobject`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
