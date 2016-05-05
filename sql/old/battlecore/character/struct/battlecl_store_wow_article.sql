DROP TABLE IF EXISTS `battlecl_store_wow_article`;

CREATE TABLE `battlecl_store_wow_article` (
  `articleId` int(10) NOT NULL,
  `name` varchar(256) NOT NULL,
  `battlePoints` int(10) unsigned NOT NULL,
  `gamePoints` int(10) unsigned NOT NULL,
  `category` tinyint(3) unsigned NOT NULL,
  `enable` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`articleId`)
);
