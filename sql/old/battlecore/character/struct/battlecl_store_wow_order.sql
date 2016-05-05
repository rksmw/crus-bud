DROP TABLE IF EXISTS `battlecl_store_wow_order`;

CREATE TABLE `battlecl_store_wow_order` (
  `orderId` int(10) unsigned NOT NULL,
  `gameAccountId` int(10) unsigned NOT NULL,
  `characterGUID` int(10) unsigned NOT NULL,
  `articleId` int(10) NOT NULL,
  `articleCount` tinyint(3) unsigned NOT NULL,
  `exchangeTime` int(10) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`orderId`)
);
