-- Chars
CREATE TABLE IF NOT EXISTS `battlecl_transmogrification` (
  `GUID` int(10) unsigned NOT NULL DEFAULT '0',
  `FakeEntry` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`GUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='version 3.0';
