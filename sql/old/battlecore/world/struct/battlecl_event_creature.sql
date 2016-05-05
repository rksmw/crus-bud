DROP TABLE IF EXISTS `battlecl_event_creature`;

CREATE TABLE `battlecl_event_creature` (
  `id` smallint(5) unsigned NOT NULL,
  `creature` int(10) unsigned NOT NULL,
  `account` int(10) unsigned NOT NULL,
  PRIMARY KEY (`creature`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
