DROP TABLE IF EXISTS `spell_custom_attr`;
CREATE TABLE IF NOT EXISTS `spell_custom_attr` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'spell id',
  `attributes` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'SpellCustomAttributes',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='SpellInfo custom attributes';
