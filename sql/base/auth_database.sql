# ************************************************************
# Sequel Pro SQL dump
# Versión 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 190.153.181.72 (MySQL 5.5.31-0+wheezy1)
# Base de datos: auth
# Tiempo de Generación: 2014-02-14 15:50:44 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Volcado de tabla account
# ------------------------------------------------------------

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `username` varchar(32) NOT NULL DEFAULT '',
  `sha_pass_hash` varchar(40) NOT NULL DEFAULT '',
  `sessionkey` varchar(80) NOT NULL DEFAULT '',
  `v` longtext,
  `s` longtext,
  `reg_mail` varchar(255) NOT NULL DEFAULT '',
  `token_key` varchar(100) NOT NULL DEFAULT '',
  `email` text,
  `joindate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_ip` varchar(30) NOT NULL DEFAULT '0.0.0.0',
  `failed_logins` int(11) unsigned NOT NULL DEFAULT '0',
  `locked` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `lock_country` varchar(2) NOT NULL DEFAULT '00',
  `last_login` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `online` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `expansion` tinyint(3) unsigned NOT NULL DEFAULT '2',
  `mutetime` bigint(40) NOT NULL DEFAULT '0',
  `mutereason` varchar(255) NOT NULL DEFAULT '',
  `muteby` varchar(50) NOT NULL DEFAULT '',
  `locale` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `os` varchar(4) NOT NULL DEFAULT '',
  `recruiter` int(11) NOT NULL DEFAULT '0',
  `eod` int(255) NOT NULL DEFAULT '0',
  `eoe` int(255) NOT NULL DEFAULT '0',
  `refer` varchar(32) NOT NULL DEFAULT '0',
  `points` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Account System';



# Volcado de tabla account_access
# ------------------------------------------------------------

DROP TABLE IF EXISTS `account_access`;

CREATE TABLE `account_access` (
  `id` int(11) unsigned NOT NULL,
  `gmlevel` tinyint(3) unsigned NOT NULL,
  `type` tinyint(3) NOT NULL DEFAULT '0',
  `security` int(3) NOT NULL DEFAULT '0',
  `RealmID` int(11) NOT NULL DEFAULT '-1',
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`RealmID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;



# Volcado de tabla account_banned
# ------------------------------------------------------------

DROP TABLE IF EXISTS `account_banned`;

CREATE TABLE `account_banned` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT 'Account id',
  `bandate` int(10) unsigned NOT NULL DEFAULT '0',
  `unbandate` int(10) unsigned NOT NULL DEFAULT '0',
  `bannedby` varchar(50) NOT NULL,
  `banreason` varchar(255) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`,`bandate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Ban List';



# Volcado de tabla account_transfer
# ------------------------------------------------------------

DROP TABLE IF EXISTS `account_transfer`;

CREATE TABLE `account_transfer` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `cStatus` tinyint(1) DEFAULT NULL,
  `cDump` mediumtext,
  `cNameOLD` char(16) NOT NULL DEFAULT '',
  `cNameNEW` char(16) NOT NULL DEFAULT '',
  `cAccount` int(11) unsigned NOT NULL DEFAULT '0',
  `gmAccount` int(11) unsigned NOT NULL DEFAULT '0',
  `cRealm` int(2) unsigned NOT NULL DEFAULT '1',
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_checked` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `cItemRow` mediumtext,
  `oPassword` varchar(255) DEFAULT NULL,
  `oAccount` char(16) NOT NULL DEFAULT '',
  `oServer` text,
  `oRealm` varchar(32) DEFAULT NULL,
  `oRealmlist` text,
  `GUID` int(11) unsigned NOT NULL DEFAULT '0',
  `Reason` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Volcado de tabla account_transfer_blacklist
# ------------------------------------------------------------

DROP TABLE IF EXISTS `account_transfer_blacklist`;

CREATE TABLE `account_transfer_blacklist` (
  `b_address` char(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`b_address`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Volcado de tabla account_transfer_guid
# ------------------------------------------------------------

DROP TABLE IF EXISTS `account_transfer_guid`;

CREATE TABLE `account_transfer_guid` (
  `RealmID` int(11) NOT NULL DEFAULT '0',
  `GUID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`RealmID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Volcado de tabla autobroadcast
# ------------------------------------------------------------

DROP TABLE IF EXISTS `autobroadcast`;

CREATE TABLE `autobroadcast` (
  `realmid` int(11) NOT NULL DEFAULT '-1',
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `weight` tinyint(3) unsigned DEFAULT '1',
  `text` longtext NOT NULL,
  PRIMARY KEY (`id`,`realmid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Volcado de tabla battle_account
# ------------------------------------------------------------

DROP TABLE IF EXISTS `battle_account`;

CREATE TABLE `battle_account` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(15) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `email` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `token` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `salt` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `locked` int(1) NOT NULL DEFAULT '0',
  `lang` int(10) NOT NULL DEFAULT '0',
  `wow` int(10) NOT NULL DEFAULT '0' COMMENT 'World of Warcraft Account ID',
  `pod` int(10) NOT NULL DEFAULT '0',
  `poe` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;



# Volcado de tabla battle_authorizations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `battle_authorizations`;

CREATE TABLE `battle_authorizations` (
  `id` int(10) NOT NULL,
  `time` int(10) NOT NULL DEFAULT '0',
  `hash` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Volcado de tabla battle_redeem_donations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `battle_redeem_donations`;

CREATE TABLE `battle_redeem_donations` (
  `guid` int(10) NOT NULL AUTO_INCREMENT,
  `account` int(10) NOT NULL,
  `informDate` int(10) NOT NULL,
  `reviewDate` int(10) NOT NULL,
  `proof` varchar(255) NOT NULL,
  `value` int(100) NOT NULL,
  `method` varchar(6) NOT NULL DEFAULT '',
  `status` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Volcado de tabla battle_redeem_item_template
# ------------------------------------------------------------

DROP TABLE IF EXISTS `battle_redeem_item_template`;

CREATE TABLE `battle_redeem_item_template` (
  `item` int(11) NOT NULL,
  `nameES` varchar(255) NOT NULL,
  `nameUS` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `iconName` varchar(255) NOT NULL,
  `poe` int(10) unsigned DEFAULT NULL,
  `pod` int(10) DEFAULT NULL,
  `category` int(10) NOT NULL DEFAULT '0',
  `model` int(10) NOT NULL DEFAULT '0',
  `type` int(10) NOT NULL,
  PRIMARY KEY (`item`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Volcado de tabla battle_redeem_tracking
# ------------------------------------------------------------

DROP TABLE IF EXISTS `battle_redeem_tracking`;

CREATE TABLE `battle_redeem_tracking` (
  `guid` int(10) NOT NULL AUTO_INCREMENT,
  `account` int(10) NOT NULL DEFAULT '0',
  `giftFrom` int(10) NOT NULL DEFAULT '0',
  `characters` int(10) NOT NULL DEFAULT '0',
  `orderDate` int(10) NOT NULL DEFAULT '0',
  `redemptionDate` int(10) NOT NULL DEFAULT '0',
  `item` int(10) NOT NULL DEFAULT '0',
  `stack` int(10) NOT NULL DEFAULT '1',
  `realm` int(1) NOT NULL DEFAULT '0',
  `method` int(1) NOT NULL DEFAULT '0',
  `status` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Volcado de tabla battle_wow_article
# ------------------------------------------------------------

DROP TABLE IF EXISTS `battle_wow_article`;

CREATE TABLE `battle_wow_article` (
  `gameArticleId` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `points` int(10) NOT NULL,
  `category` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`gameArticleId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Volcado de tabla battlecl_feed_wow_creature
# ------------------------------------------------------------

DROP TABLE IF EXISTS `battlecl_feed_wow_creature`;

CREATE TABLE `battlecl_feed_wow_creature` (
  `creatureGUID` int(10) unsigned NOT NULL DEFAULT '0',
  `gameAccountId` int(10) unsigned NOT NULL DEFAULT '0',
  `characterGUID` int(10) unsigned NOT NULL DEFAULT '0',
  `time` int(10) unsigned NOT NULL DEFAULT '0',
  `realmId` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`characterGUID`,`time`,`realmId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;



# Volcado de tabla battlecl_log_commands
# ------------------------------------------------------------

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



# Volcado de tabla battlecl_log_trades
# ------------------------------------------------------------

DROP TABLE IF EXISTS `battlecl_log_trades`;

CREATE TABLE `battlecl_log_trades` (
  `accountId` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(15) NOT NULL,
  `itemId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `count` int(10) unsigned NOT NULL DEFAULT '0',
  `money` int(10) unsigned NOT NULL DEFAULT '0',
  `targetAccountId` int(10) unsigned NOT NULL DEFAULT '0',
  `time` int(10) unsigned NOT NULL DEFAULT '0',
  `realmId` tinyint(3) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Volcado de tabla battlecl_store_wow_article
# ------------------------------------------------------------

DROP TABLE IF EXISTS `battlecl_store_wow_article`;

CREATE TABLE `battlecl_store_wow_article` (
  `articleId` int(10) NOT NULL,
  `name` varchar(256) CHARACTER SET latin1 NOT NULL,
  `battlePoints` int(10) unsigned NOT NULL,
  `gamePoints` int(10) unsigned NOT NULL,
  `category` tinyint(3) unsigned NOT NULL,
  `enable` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`articleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;



# Volcado de tabla battlecl_store_wow_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `battlecl_store_wow_order`;

CREATE TABLE `battlecl_store_wow_order` (
  `orderId` int(10) unsigned NOT NULL,
  `gameAccountId` int(10) unsigned NOT NULL,
  `realmId` tinyint(3) unsigned NOT NULL,
  `characterGUID` int(10) unsigned NOT NULL,
  `articleId` int(10) NOT NULL,
  `articleCount` tinyint(3) unsigned NOT NULL,
  `exchangeTime` int(10) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`orderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;



# Volcado de tabla commandlog
# ------------------------------------------------------------

DROP TABLE IF EXISTS `commandlog`;

CREATE TABLE `commandlog` (
  `accid` int(11) unsigned NOT NULL DEFAULT '0',
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `command` varchar(50) NOT NULL,
  `args` varchar(240) NOT NULL,
  `targetType` int(2) NOT NULL,
  `target` char(100) NOT NULL,
  `targetGUID` int(11) unsigned NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `map` smallint(5) unsigned NOT NULL DEFAULT '0',
  `unix_timestamp` bigint(40) unsigned NOT NULL DEFAULT '0',
  `realmId` tinyint(2) unsigned NOT NULL,
  `revizado` tinyint(1) DEFAULT '0',
  KEY `Index` (`accid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Volcado de tabla ip_banned
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ip_banned`;

CREATE TABLE `ip_banned` (
  `ip` varchar(15) NOT NULL DEFAULT '127.0.0.1',
  `bandate` int(10) unsigned NOT NULL,
  `unbandate` int(10) unsigned NOT NULL,
  `bannedby` varchar(50) NOT NULL DEFAULT '[Console]',
  `banreason` varchar(255) NOT NULL DEFAULT 'no reason',
  PRIMARY KEY (`ip`,`bandate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Banned IPs';



# Volcado de tabla ip2nation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ip2nation`;

CREATE TABLE `ip2nation` (
  `ip` int(11) unsigned NOT NULL DEFAULT '0',
  `country` char(2) NOT NULL DEFAULT '',
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Volcado de tabla ip2nationCountries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ip2nationCountries`;

CREATE TABLE `ip2nationCountries` (
  `code` varchar(4) NOT NULL DEFAULT '',
  `iso_code_2` varchar(2) NOT NULL DEFAULT '',
  `iso_code_3` varchar(3) DEFAULT '',
  `iso_country` varchar(255) NOT NULL DEFAULT '',
  `country` varchar(255) NOT NULL DEFAULT '',
  `lat` float NOT NULL DEFAULT '0',
  `lon` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`code`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Volcado de tabla log_login
# ------------------------------------------------------------

DROP TABLE IF EXISTS `log_login`;

CREATE TABLE `log_login` (
  `account` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `guid` int(11) NOT NULL,
  `ip` char(16) NOT NULL,
  `realm` int(11) NOT NULL,
  `time` bigint(40) NOT NULL,
  PRIMARY KEY (`guid`,`time`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Volcado de tabla logs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `logs`;

CREATE TABLE `logs` (
  `time` int(14) NOT NULL,
  `realm` int(4) NOT NULL,
  `type` int(4) NOT NULL,
  `level` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `string` text
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Volcado de tabla ptr
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ptr`;

CREATE TABLE `ptr` (
  `account` int(11) NOT NULL,
  `guid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;



# Volcado de tabla rbac_account_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rbac_account_groups`;

CREATE TABLE `rbac_account_groups` (
  `accountId` int(10) unsigned NOT NULL COMMENT 'Account id',
  `groupId` int(10) unsigned NOT NULL COMMENT 'Group id',
  `realmId` int(11) NOT NULL DEFAULT '-1' COMMENT 'Realm Id, -1 means all',
  PRIMARY KEY (`accountId`,`groupId`,`realmId`),
  KEY `fk__rbac_account_groups__rbac_groups` (`groupId`),
  CONSTRAINT `fk__rbac_account_groups__account` FOREIGN KEY (`accountId`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk__rbac_account_groups__rbac_groups` FOREIGN KEY (`groupId`) REFERENCES `rbac_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Account-Group relation';

LOCK TABLES `rbac_account_groups` WRITE;
/*!40000 ALTER TABLE `rbac_account_groups` DISABLE KEYS */;

INSERT INTO `rbac_account_groups` (`accountId`, `groupId`, `realmId`)
VALUES
  (119637,2,2),
  (119654,2,2),
  (119668,2,2),
  (119727,2,2),
  (32145,3,-1),
  (36245,3,2),
  (66386,3,2),
  (77678,3,2),
  (93017,3,2),
  (97778,3,2),
  (106980,3,2),
  (106982,3,2),
  (106983,3,2),
  (116147,3,2),
  (116149,3,2),
  (120142,3,2),
  (120244,3,2),
  (71655,4,2),
  (83403,4,2),
  (85558,4,2),
  (99366,4,2),
  (106981,4,2),
  (115011,4,2),
  (116148,4,2),
  (57404,5,2),
  (96275,5,2),
  (5,6,-1),
  (91,6,-1),
  (728,6,4),
  (11071,6,4),
  (26986,6,-1),
  (69603,6,-1),
  (102449,6,-1),
  (101323,7,4),
  (108115,7,4),
  (116423,7,4);

/*!40000 ALTER TABLE `rbac_account_groups` ENABLE KEYS */;
UNLOCK TABLES;


# Volcado de tabla rbac_account_permissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rbac_account_permissions`;

CREATE TABLE `rbac_account_permissions` (
  `accountId` int(10) unsigned NOT NULL COMMENT 'Account id',
  `permissionId` int(10) unsigned NOT NULL COMMENT 'Permission id',
  `granted` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Granted = 1, Denied = 0',
  `realmId` int(11) NOT NULL DEFAULT '-1' COMMENT 'Realm Id, -1 means all',
  PRIMARY KEY (`accountId`,`permissionId`,`realmId`),
  KEY `fk__rbac_account_roles__rbac_permissions` (`permissionId`),
  CONSTRAINT `fk__rbac_account_permissions__account` FOREIGN KEY (`accountId`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk__rbac_account_roles__rbac_permissions` FOREIGN KEY (`permissionId`) REFERENCES `rbac_permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Account-Permission relation';



# Volcado de tabla rbac_account_roles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rbac_account_roles`;

CREATE TABLE `rbac_account_roles` (
  `accountId` int(10) unsigned NOT NULL COMMENT 'Account id',
  `roleId` int(10) unsigned NOT NULL COMMENT 'Role id',
  `granted` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Granted = 1, Denied = 0',
  `realmId` int(11) NOT NULL DEFAULT '-1' COMMENT 'Realm Id, -1 means all',
  PRIMARY KEY (`accountId`,`roleId`,`realmId`),
  KEY `fk__rbac_account_roles__rbac_roles` (`roleId`),
  CONSTRAINT `fk__rbac_account_roles__account` FOREIGN KEY (`accountId`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk__rbac_account_roles__rbac_roles` FOREIGN KEY (`roleId`) REFERENCES `rbac_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Account-Role relation';



# Volcado de tabla rbac_group_roles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rbac_group_roles`;

CREATE TABLE `rbac_group_roles` (
  `groupId` int(10) unsigned NOT NULL COMMENT 'group id',
  `roleId` int(10) unsigned NOT NULL COMMENT 'Role id',
  PRIMARY KEY (`groupId`,`roleId`),
  KEY `fk__rbac_group_roles__rbac_roles` (`roleId`),
  CONSTRAINT `fk__rbac_group_roles__rbac_groups` FOREIGN KEY (`groupId`) REFERENCES `rbac_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk__rbac_group_roles__rbac_roles` FOREIGN KEY (`roleId`) REFERENCES `rbac_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Group Role relation';

LOCK TABLES `rbac_group_roles` WRITE;
/*!40000 ALTER TABLE `rbac_group_roles` DISABLE KEYS */;

INSERT INTO `rbac_group_roles` (`groupId`, `roleId`)
VALUES
  (1,1),
  (3,1),
  (4,1),
  (5,1),
  (6,1),
  (2,2),
  (3,2),
  (4,2),
  (5,2),
  (6,2),
  (3,3),
  (4,3),
  (5,3),
  (6,3),
  (4,4),
  (5,4),
  (6,4),
  (6,5),
  (7,5),
  (1,6),
  (3,6),
  (4,6),
  (5,6),
  (6,6),
  (7,6),
  (1,7),
  (3,7),
  (4,7),
  (5,7),
  (6,7),
  (7,7),
  (2,8),
  (3,8),
  (4,8),
  (5,8),
  (6,8),
  (3,9),
  (4,9),
  (5,9),
  (6,9),
  (2,10),
  (3,10),
  (4,10),
  (5,10),
  (6,10),
  (2,11),
  (3,11),
  (4,11),
  (5,11),
  (6,11),
  (2,12),
  (6,12),
  (2,13),
  (3,13),
  (4,13),
  (5,13),
  (6,13),
  (7,13),
  (2,14),
  (3,14),
  (4,14),
  (5,14),
  (2,15),
  (3,15),
  (4,15),
  (5,15),
  (6,15),
  (2,16),
  (3,16),
  (4,16),
  (5,16),
  (6,16),
  (2,17),
  (3,17),
  (4,17),
  (5,17),
  (6,17),
  (2,19),
  (3,19),
  (4,19),
  (5,19),
  (6,19),
  (2,20),
  (3,20),
  (4,20),
  (5,20),
  (6,20),
  (2,21),
  (3,21),
  (4,21),
  (5,21),
  (2,22),
  (3,22),
  (4,22),
  (5,22),
  (6,22),
  (2,24),
  (3,24),
  (4,24),
  (5,24),
  (6,24),
  (2,25),
  (3,25),
  (4,25),
  (5,25),
  (6,25),
  (2,26),
  (3,26),
  (4,26),
  (5,26),
  (6,26),
  (2,27),
  (3,27),
  (4,27),
  (5,27),
  (6,27),
  (2,28),
  (3,28),
  (4,28),
  (5,28),
  (6,28),
  (2,29),
  (3,29),
  (4,29),
  (5,29),
  (6,29),
  (2,30),
  (3,30),
  (4,30),
  (5,30),
  (6,30),
  (4,31),
  (5,31),
  (6,31),
  (2,32),
  (3,32),
  (4,32),
  (5,32),
  (6,32),
  (2,33),
  (1,34),
  (4,34),
  (5,34),
  (6,34),
  (7,34),
  (2,35),
  (3,35),
  (4,35),
  (5,35),
  (6,35),
  (2,36),
  (3,36),
  (4,36),
  (5,36),
  (6,36),
  (7,36),
  (2,37),
  (2,38),
  (3,38),
  (4,38),
  (5,38),
  (6,38),
  (3,39),
  (4,39),
  (5,39),
  (6,39),
  (5,42),
  (6,42),
  (6,43),
  (6,44),
  (7,44);

/*!40000 ALTER TABLE `rbac_group_roles` ENABLE KEYS */;
UNLOCK TABLES;


# Volcado de tabla rbac_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rbac_groups`;

CREATE TABLE `rbac_groups` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Group id',
  `name` varchar(100) NOT NULL COMMENT 'Group name',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Group List';

LOCK TABLES `rbac_groups` WRITE;
/*!40000 ALTER TABLE `rbac_groups` DISABLE KEYS */;

INSERT INTO `rbac_groups` (`id`, `name`)
VALUES
  (1,'Player'),
  (2,'GameMaster Lv 1'),
  (3,'GameMaster Lv 2'),
  (4,'GameMaster Lv 3'),
  (5,'GameMaster Lv 4'),
  (6,'Administrator'),
  (7,'Developer');

/*!40000 ALTER TABLE `rbac_groups` ENABLE KEYS */;
UNLOCK TABLES;


# Volcado de tabla rbac_permissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rbac_permissions`;

CREATE TABLE `rbac_permissions` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Permission id',
  `name` varchar(100) NOT NULL COMMENT 'Permission name',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Permission List';

LOCK TABLES `rbac_permissions` WRITE;
/*!40000 ALTER TABLE `rbac_permissions` DISABLE KEYS */;

INSERT INTO `rbac_permissions` (`id`, `name`)
VALUES
  (1,'Instant logout'),
  (2,'Skip Queue'),
  (3,'Join Normal Battleground'),
  (4,'Join Random Battleground'),
  (5,'Join Arenas'),
  (6,'Join Dungeon Finder'),
  (11,'Log GM trades'),
  (13,'Skip Instance required bosses check'),
  (14,'Skip character creation team mask check'),
  (15,'Skip character creation class mask check'),
  (16,'Skip character creation race mask check'),
  (17,'Skip character creation reserved name check'),
  (18,'Skip character creation heroic min level check'),
  (19,'Skip needed requirements to use channel check'),
  (20,'Skip disable map check'),
  (21,'Skip reset talents when used more than allowed check'),
  (22,'Skip spam chat check'),
  (23,'Skip over-speed ping check'),
  (24,'Two side faction characters on the same account'),
  (25,'Allow say chat between factions'),
  (26,'Allow channel chat between factions'),
  (27,'Two side mail interaction'),
  (28,'See two side who list'),
  (29,'Add friends of other faction'),
  (30,'Save character without delay with .save command'),
  (31,'Use params with .unstuck command'),
  (32,'Can be assigned tickets with .assign ticket command'),
  (33,'Notify if a command was not found'),
  (34,'Check if should appear in list using .gm ingame command'),
  (35,'See all security levels with who command'),
  (36,'Filter whispers'),
  (37,'Use staff badge in chat'),
  (38,'Resurrect with full Health Points'),
  (39,'Restore saved gm setting states'),
  (40,'Allows to add a gm to friend list'),
  (41,'Use Config option START_GM_LEVEL to assign new character level'),
  (42,'Allows to use CMSG_WORLD_TELEPORT opcode'),
  (43,'Allows to use CMSG_WHOIS opcode'),
  (44,'Receive global GM messages/texts'),
  (45,'Join channels without announce'),
  (46,'Change channel settings without being channel moderator'),
  (47,'Enables lower security than target check'),
  (48,'Enable IP, Last Login and EMail output in pinfo'),
  (49,'Forces to enter the email for confirmation on password change'),
  (50,'Allow user to check his own email with .account'),
  (200,'Command: .rbac'),
  (201,'Command: .rbac account'),
  (202,'Command: .rbac account group'),
  (203,'Command: .rbac account group add'),
  (204,'Command: .rbac account group remove'),
  (205,'Command: .rbac account role'),
  (206,'Command: .rbac account role grant'),
  (207,'Command: .rbac account role deny'),
  (208,'Command: .rbac account role revoke'),
  (209,'Command: .rbac account permission'),
  (210,'Command: .rbac account permission grant'),
  (211,'Command: .rbac account permission deny'),
  (212,'Command: .rbac account permission revoke'),
  (213,'Command: .rbac list'),
  (214,'Command: .rbac list groups'),
  (215,'Command: .rbac list roles'),
  (216,'Command: .rbac list permissions'),
  (217,'Command: .account'),
  (218,'Command: .account addon'),
  (219,'Command: .account create'),
  (220,'Command: .account delete'),
  (221,'Command: .account lock'),
  (222,'Command: .account lock country'),
  (223,'Command: .account lock ip'),
  (224,'Command: .account onlinelist'),
  (225,'Command: .account password'),
  (226,'Command: .account set'),
  (227,'Command: .account set addon'),
  (228,'Command: .account set gmlevel'),
  (229,'Command: .account set password'),
  (230,'Command: achievement'),
  (231,'Command: achievement add'),
  (232,'Command: arena'),
  (233,'Command: arena captain'),
  (234,'Command: arena create'),
  (235,'Command: arena disband'),
  (236,'Command: arena info'),
  (237,'Command: arena lookup'),
  (238,'Command: arena rename'),
  (239,'Command: ban'),
  (240,'Command: ban account'),
  (241,'Command: ban character'),
  (242,'Command: ban ip'),
  (243,'Command: ban playeraccount'),
  (244,'Command: baninfo'),
  (245,'Command: baninfo account'),
  (246,'Command: baninfo character'),
  (247,'Command: baninfo ip'),
  (248,'Command: banlist'),
  (249,'Command: banlist account'),
  (250,'Command: banlist character'),
  (251,'Command: banlist ip'),
  (252,'Command: unban'),
  (253,'Command: unban account'),
  (254,'Command: unban character'),
  (255,'Command: unban ip'),
  (256,'Command: unban playeraccount'),
  (257,'Command: bf'),
  (258,'Command: bf start'),
  (259,'Command: bf stop'),
  (260,'Command: bf switch'),
  (261,'Command: bf timer'),
  (262,'Command: bf enable'),
  (263,'Command: account email'),
  (264,'Command: account set sec'),
  (265,'Command: account set sec email'),
  (266,'Command: account set sec regmail'),
  (267,'Command: cast'),
  (268,'Command: cast back'),
  (269,'Command: cast dist'),
  (270,'Command: cast self'),
  (271,'Command: cast target'),
  (272,'Command: cast dest'),
  (273,'Command: character'),
  (274,'Command: character customize'),
  (275,'Command: character changefaction'),
  (276,'Command: character changerace'),
  (277,'Command: character deleted'),
  (279,'Command: character deleted list'),
  (280,'Command: character deleted restore'),
  (283,'Command: character level'),
  (284,'Command: character rename'),
  (285,'Command: character reputation'),
  (286,'Command: character titles'),
  (287,'Command: levelup'),
  (288,'Command: pdump'),
  (289,'Command: pdump load'),
  (290,'Command: pdump write'),
  (291,'Command: cheat'),
  (292,'Command: cheat casttime'),
  (293,'Command: cheat cooldown'),
  (294,'Command: cheat explore'),
  (295,'Command: cheat god'),
  (296,'Command: cheat power'),
  (297,'Command: cheat status'),
  (298,'Command: cheat taxi'),
  (299,'Command: cheat waterwalk'),
  (300,'Command: debug'),
  (301,'Command: debug anim'),
  (302,'Command: debug areatriggers'),
  (303,'Command: debug arena'),
  (304,'Command: debug bg'),
  (305,'Command: debug entervehicle'),
  (306,'Command: debug getitemstate'),
  (307,'Command: debug getitemvalue'),
  (308,'Command: debug getvalue'),
  (309,'Command: debug hostil'),
  (310,'Command: debug itemexpire'),
  (311,'Command: debug lootrecipient'),
  (312,'Command: debug los'),
  (313,'Command: debug mod32value'),
  (314,'Command: debug moveflags'),
  (315,'Command: debug play'),
  (316,'Command: debug play cinematics'),
  (317,'Command: debug play movie'),
  (318,'Command: debug play sound'),
  (319,'Command: debug send'),
  (320,'Command: debug send buyerror'),
  (321,'Command: debug send channelnotify'),
  (322,'Command: debug send chatmessage'),
  (323,'Command: debug send equiperror'),
  (324,'Command: debug send largepacket'),
  (325,'Command: debug send opcode'),
  (326,'Command: debug send qinvalidmsg'),
  (327,'Command: debug send qpartymsg'),
  (328,'Command: debug send sellerror'),
  (329,'Command: debug send setphaseshift'),
  (330,'Command: debug send spellfail'),
  (331,'Command: debug setaurastate'),
  (332,'Command: debug setbit'),
  (333,'Command: debug setitemvalue'),
  (334,'Command: debug setvalue'),
  (335,'Command: debug setvid'),
  (336,'Command: debug spawnvehicle'),
  (337,'Command: debug threat'),
  (338,'Command: debug update'),
  (339,'Command: debug uws'),
  (340,'Command: wpgps'),
  (341,'Command: deserter'),
  (342,'Command: deserter bg'),
  (343,'Command: deserter bg add'),
  (344,'Command: deserter bg remove'),
  (345,'Command: deserter instance'),
  (346,'Command: deserter instance add'),
  (347,'Command: deserter instance remove'),
  (348,'Command: disable'),
  (349,'Command: disable add'),
  (350,'Command: disable add achievement_criteria'),
  (351,'Command: disable add battleground'),
  (352,'Command: disable add map'),
  (353,'Command: disable add mmap'),
  (354,'Command: disable add outdoorpvp'),
  (355,'Command: disable add quest'),
  (356,'Command: disable add spell'),
  (357,'Command: disable add vmap'),
  (358,'Command: disable remove'),
  (359,'Command: disable remove achievement_criteria'),
  (360,'Command: disable remove battleground'),
  (361,'Command: disable remove map'),
  (362,'Command: disable remove mmap'),
  (363,'Command: disable remove outdoorpvp'),
  (364,'Command: disable remove quest'),
  (365,'Command: disable remove spell'),
  (366,'Command: disable remove vmap'),
  (367,'Command: event'),
  (368,'Command: event activelist'),
  (369,'Command: event start'),
  (370,'Command: event stop'),
  (371,'Command: gm'),
  (372,'Command: gm chat'),
  (373,'Command: gm fly'),
  (374,'Command: gm ingame'),
  (375,'Command: gm list'),
  (376,'Command: gm visible'),
  (377,'Command: go'),
  (378,'Command: go creature'),
  (379,'Command: go graveyard'),
  (380,'Command: go grid'),
  (381,'Command: go object'),
  (382,'Command: go taxinode'),
  (383,'Command: go ticket'),
  (384,'Command: go trigger'),
  (385,'Command: go xyz'),
  (386,'Command: go zonexy'),
  (387,'Command: gobject'),
  (388,'Command: gobject activate'),
  (389,'Command: gobject add'),
  (390,'Command: gobject add temp'),
  (391,'Command: gobject delete'),
  (392,'Command: gobject info'),
  (393,'Command: gobject move'),
  (394,'Command: gobject near'),
  (395,'Command: gobject set'),
  (396,'Command: gobject set phase'),
  (397,'Command: gobject set state'),
  (398,'Command: gobject target'),
  (399,'Command: gobject turn'),
  (401,'Command: guild'),
  (402,'Command: guild create'),
  (403,'Command: guild delete'),
  (404,'Command: guild invite'),
  (405,'Command: guild uninvite'),
  (406,'Command: guild rank'),
  (407,'Command: guild rename'),
  (408,'Command: honor'),
  (409,'Command: honor add'),
  (410,'Command: honor add kill'),
  (411,'Command: honor update'),
  (412,'Command: instance'),
  (413,'Command: instance listbinds'),
  (414,'Command: instance unbind'),
  (415,'Command: instance stats'),
  (416,'Command: instance savedata'),
  (417,'Command: learn'),
  (418,'Command: learn all'),
  (419,'Command: learn all my'),
  (420,'Command: learn all my class'),
  (421,'Command: learn all my pettalents'),
  (422,'Command: learn all my spells'),
  (423,'Command: learn all my talents'),
  (424,'Command: learn all gm'),
  (425,'Command: learn all crafts'),
  (426,'Command: learn all default'),
  (427,'Command: learn all lang'),
  (428,'Command: learn all recipes'),
  (429,'Command: unlearn'),
  (430,'Command: lfg'),
  (431,'Command: lfg player'),
  (432,'Command: lfg group'),
  (433,'Command: lfg queue'),
  (434,'Command: lfg clean'),
  (435,'Command: lfg options'),
  (436,'Command: list'),
  (437,'Command: list creature'),
  (438,'Command: list item'),
  (439,'Command: list object'),
  (440,'Command: list auras'),
  (441,'Command: list mail'),
  (442,'Command: lookup'),
  (443,'Command: lookup area'),
  (444,'Command: lookup creature'),
  (445,'Command: lookup event'),
  (446,'Command: lookup faction'),
  (447,'Command: lookup item'),
  (448,'Command: lookup itemset'),
  (449,'Command: lookup object'),
  (450,'Command: lookup quest'),
  (451,'Command: lookup player'),
  (452,'Command: lookup player ip'),
  (453,'Command: lookup player account'),
  (454,'Command: lookup player email'),
  (455,'Command: lookup skill'),
  (456,'Command: lookup spell'),
  (457,'Command: lookup spell id'),
  (458,'Command: lookup taxinode'),
  (459,'Command: lookup tele'),
  (460,'Command: lookup title'),
  (461,'Command: lookup map'),
  (462,'Command: announce'),
  (463,'Command: channel'),
  (464,'Command: channel set'),
  (465,'Command: channel set ownership'),
  (466,'Command: gmannounce'),
  (467,'Command: gmnameannounce'),
  (468,'Command: gmnotify'),
  (469,'Command: nameannounce'),
  (470,'Command: notify'),
  (471,'Command: whispers'),
  (472,'Command: group'),
  (473,'Command: group leader'),
  (474,'Command: group disband'),
  (475,'Command: group remove'),
  (476,'Command: group join'),
  (477,'Command: group list'),
  (478,'Command: group summon'),
  (479,'Command: pet'),
  (480,'Command: pet create'),
  (481,'Command: pet learn'),
  (482,'Command: pet unlearn'),
  (483,'Command: send'),
  (484,'Command: send items'),
  (485,'Command: send mail'),
  (486,'Command: send message'),
  (487,'Command: send money'),
  (488,'Command: additem'),
  (489,'Command: additemset'),
  (490,'Command: appear'),
  (491,'Command: aura'),
  (492,'Command: bank'),
  (493,'Command: bindsight'),
  (494,'Command: combatstop'),
  (495,'Command: cometome'),
  (496,'Command: commands'),
  (497,'Command: cooldown'),
  (498,'Command: damage'),
  (499,'Command: dev'),
  (500,'Command: die'),
  (501,'Command: dismount'),
  (502,'Command: distance'),
  (503,'Command: flusharenapoints'),
  (504,'Command: freeze'),
  (505,'Command: gps'),
  (506,'Command: guid'),
  (507,'Command: help'),
  (508,'Command: hidearea'),
  (509,'Command: itemmove'),
  (510,'Command: kick'),
  (511,'Command: linkgrave'),
  (512,'Command: listfreeze'),
  (513,'Command: maxskill'),
  (514,'Command: movegens'),
  (515,'Command: mute'),
  (516,'Command: neargrave'),
  (517,'Command: pinfo'),
  (518,'Command: playall'),
  (519,'Command: possess'),
  (520,'Command: recall'),
  (521,'Command: repairitems'),
  (522,'Command: respawn'),
  (523,'Command: revive'),
  (524,'Command: saveall'),
  (525,'Command: save'),
  (526,'Command: setskill'),
  (527,'Command: showarea'),
  (528,'Command: summon'),
  (529,'Command: unaura'),
  (530,'Command: unbindsight'),
  (531,'Command: unfreeze'),
  (532,'Command: unmute'),
  (533,'Command: unpossess'),
  (534,'Command: unstuck'),
  (535,'Command: wchange'),
  (536,'Command: mmap'),
  (537,'Command: mmap loadedtiles'),
  (538,'Command: mmap loc'),
  (539,'Command: mmap path'),
  (540,'Command: mmap stats'),
  (541,'Command: mmap testarea'),
  (542,'Command: morph'),
  (543,'Command: demorph'),
  (544,'Command: modify'),
  (545,'Command: modify arenapoints'),
  (546,'Command: modify bit'),
  (547,'Command: modify drunk'),
  (548,'Command: modify energy'),
  (549,'Command: modify faction'),
  (550,'Command: modify gender'),
  (551,'Command: modify honor'),
  (552,'Command: modify hp'),
  (553,'Command: modify mana'),
  (554,'Command: modify money'),
  (555,'Command: modify mount'),
  (556,'Command: modify phase'),
  (557,'Command: modify rage'),
  (558,'Command: modify reputation'),
  (559,'Command: modify runicpower'),
  (560,'Command: modify scale'),
  (561,'Command: modify speed'),
  (562,'Command: modify speed all'),
  (563,'Command: modify speed backwalk'),
  (564,'Command: modify speed fly'),
  (565,'Command: modify speed walk'),
  (566,'Command: modify speed swim'),
  (567,'Command: modify spell'),
  (568,'Command: modify standstate'),
  (569,'Command: modify talentpoints'),
  (570,'Command: npc'),
  (571,'Command: npc add'),
  (572,'Command: npc add formation'),
  (573,'Command: npc add item'),
  (574,'Command: npc add move'),
  (575,'Command: npc add temp'),
  (576,'Command: npc add delete'),
  (577,'Command: npc add delete item'),
  (578,'Command: npc add follow'),
  (579,'Command: npc add follow stop'),
  (580,'Command: npc set'),
  (581,'Command: npc set allowmove'),
  (582,'Command: npc set entry'),
  (583,'Command: npc set factionid'),
  (584,'Command: npc set flag'),
  (585,'Command: npc set level'),
  (586,'Command: npc set link'),
  (587,'Command: npc set model'),
  (588,'Command: npc set movetype'),
  (589,'Command: npc set phase'),
  (590,'Command: npc set spawndist'),
  (591,'Command: npc set spawntime'),
  (592,'Command: npc set data'),
  (593,'Command: npc info'),
  (594,'Command: npc near'),
  (595,'Command: npc move'),
  (596,'Command: npc playemote'),
  (597,'Command: npc say'),
  (598,'Command: npc textemote'),
  (599,'Command: npc whisper'),
  (600,'Command: npc yell'),
  (601,'Command: npc tame'),
  (602,'Command: quest'),
  (603,'Command: quest add'),
  (604,'Command: quest complete'),
  (605,'Command: quest remove'),
  (606,'Command: quest reward'),
  (607,'Command: reload'),
  (608,'Command: reload access_requirement'),
  (609,'Command: reload achievement_criteria_data'),
  (610,'Command: reload achievement_reward'),
  (611,'Command: reload all'),
  (612,'Command: reload all achievement'),
  (613,'Command: reload all area'),
  (614,'Command: reload all eventai'),
  (615,'Command: reload all gossips'),
  (616,'Command: reload all item'),
  (617,'Command: reload all locales'),
  (618,'Command: reload all loot'),
  (619,'Command: reload all npc'),
  (620,'Command: reload all quest'),
  (621,'Command: reload all scripts'),
  (622,'Command: reload all spell'),
  (623,'Command: reload areatrigger_involvedrelation'),
  (624,'Command: reload areatrigger_tavern'),
  (625,'Command: reload areatrigger_teleport'),
  (626,'Command: reload auctions'),
  (627,'Command: reload autobroadcast'),
  (628,'Command: reload command'),
  (629,'Command: reload conditions'),
  (630,'Command: reload config'),
  (631,'Command: reload creature_text'),
  (632,'Command: reload creature_ai_scripts'),
  (633,'Command: reload creature_ai_texts'),
  (634,'Command: reload creature_questender'),
  (635,'Command: reload creature_linked_respawn'),
  (636,'Command: reload creature_loot_template'),
  (637,'Command: reload creature_onkill_reputation'),
  (638,'Command: reload creature_queststarter'),
  (639,'Command: reload creature_summon_groups'),
  (640,'Command: reload creature_template'),
  (641,'Command: reload disables'),
  (642,'Command: reload disenchant_loot_template'),
  (643,'Command: reload event_scripts'),
  (644,'Command: reload fishing_loot_template'),
  (645,'Command: reload game_graveyard_zone'),
  (646,'Command: reload game_tele'),
  (647,'Command: reload gameobject_questender'),
  (648,'Command: reload gameobject_loot_template'),
  (649,'Command: reload gameobject_queststarter'),
  (650,'Command: reload gm_tickets'),
  (651,'Command: reload gossip_menu'),
  (652,'Command: reload gossip_menu_option'),
  (653,'Command: reload item_enchantment_template'),
  (654,'Command: reload item_loot_template'),
  (655,'Command: reload item_set_names'),
  (656,'Command: reload lfg_dungeon_rewards'),
  (657,'Command: reload locales_achievement_reward'),
  (658,'Command: reload locales_creature'),
  (659,'Command: reload locales_creature_text'),
  (660,'Command: reload locales_gameobject'),
  (661,'Command: reload locales_gossip_menu_option'),
  (662,'Command: reload locales_item'),
  (663,'Command: reload locales_item_set_name'),
  (664,'Command: reload locales_npc_text'),
  (665,'Command: reload locales_page_text'),
  (666,'Command: reload locales_points_of_interest'),
  (667,'Command: reload locales_quest'),
  (668,'Command: reload mail_level_reward'),
  (669,'Command: reload mail_loot_template'),
  (670,'Command: reload milling_loot_template'),
  (671,'Command: reload npc_spellclick_spells'),
  (672,'Command: reload npc_trainer'),
  (673,'Command: reload npc_vendor'),
  (674,'Command: reload page_text'),
  (675,'Command: reload pickpocketing_loot_template'),
  (676,'Command: reload points_of_interest'),
  (677,'Command: reload prospecting_loot_template'),
  (678,'Command: reload quest_poi'),
  (679,'Command: reload quest_template'),
  (680,'Command: reload rbac'),
  (681,'Command: reload reference_loot_template'),
  (682,'Command: reload reserved_name'),
  (683,'Command: reload reputation_reward_rate'),
  (684,'Command: reload reputation_spillover_template'),
  (685,'Command: reload skill_discovery_template'),
  (686,'Command: reload skill_extra_item_template'),
  (687,'Command: reload skill_fishing_base_level'),
  (688,'Command: reload skinning_loot_template'),
  (689,'Command: reload smart_scripts'),
  (690,'Command: reload spell_required'),
  (691,'Command: reload spell_area'),
  (692,'Command: reload spell_bonus_data'),
  (693,'Command: reload spell_group'),
  (694,'Command: reload spell_learn_spell'),
  (695,'Command: reload spell_loot_template'),
  (696,'Command: reload spell_linked_spell'),
  (697,'Command: reload spell_pet_auras'),
  (698,'Command: reload spell_proc_event'),
  (699,'Command: reload spell_proc'),
  (700,'Command: reload spell_scripts'),
  (701,'Command: reload spell_target_position'),
  (702,'Command: reload spell_threats'),
  (703,'Command: reload spell_group_stack_rules'),
  (704,'Command: reload trinity_string'),
  (705,'Command: reload warden_action'),
  (706,'Command: reload waypoint_scripts'),
  (707,'Command: reload waypoint_data'),
  (708,'Command: reload vehicle_accessory'),
  (709,'Command: reload vehicle_template_accessory'),
  (710,'Command: reset'),
  (711,'Command: reset achievements'),
  (712,'Command: reset honor'),
  (713,'Command: reset level'),
  (714,'Command: reset spells'),
  (715,'Command: reset stats'),
  (716,'Command: reset talents'),
  (717,'Command: reset all'),
  (718,'Command: server'),
  (719,'Command: server corpses'),
  (720,'Command: server exit'),
  (721,'Command: server idlerestart'),
  (722,'Command: server idlerestart cancel'),
  (723,'Command: server idleshutdown'),
  (724,'Command: server idleshutdown cancel'),
  (725,'Command: server info'),
  (726,'Command: server plimit'),
  (727,'Command: server restart'),
  (728,'Command: server restart cancel'),
  (729,'Command: server set'),
  (730,'Command: server set closed'),
  (731,'Command: server set difftime'),
  (732,'Command: server set loglevel'),
  (733,'Command: server set motd'),
  (734,'Command: server shutdown'),
  (735,'Command: server shutdown cancel'),
  (736,'Command: server motd'),
  (737,'Command: tele'),
  (738,'Command: tele add'),
  (739,'Command: tele del'),
  (740,'Command: tele name'),
  (741,'Command: tele group'),
  (742,'Command: ticket'),
  (743,'Command: ticket assign'),
  (744,'Command: ticket close'),
  (745,'Command: ticket closedlist'),
  (746,'Command: ticket comment'),
  (747,'Command: ticket complete'),
  (748,'Command: ticket delete'),
  (749,'Command: ticket escalate'),
  (750,'Command: ticket escalatedlist'),
  (751,'Command: ticket list'),
  (752,'Command: ticket onlinelist'),
  (753,'Command: ticket reset'),
  (754,'Command: ticket response'),
  (755,'Command: ticket response append'),
  (756,'Command: ticket response appendln'),
  (757,'Command: ticket togglesystem'),
  (758,'Command: ticket unassign'),
  (759,'Command: ticket viewid'),
  (760,'Command: ticket viewname'),
  (761,'Command: titles'),
  (762,'Command: titles add'),
  (763,'Command: titles current'),
  (764,'Command: titles remove'),
  (765,'Command: titles set'),
  (766,'Command: titles set mask'),
  (767,'Command: wp'),
  (768,'Command: wp add'),
  (769,'Command: wp event'),
  (770,'Command: wp load'),
  (771,'Command: wp modify'),
  (772,'Command: wp unload'),
  (773,'Command: wp reload'),
  (774,'Command: wp show'),
  (1001,'Command: spectate'),
  (1002,'Command: spectate view'),
  (1003,'Command: spectate leave'),
  (1004,'Command: spectate player'),
  (1005,'Command: spectate reset'),
  (1006,'Command: rate xp'),
  (1007,'Command: rate loot'),
  (1008,'Command: reload custom_sanctuary'),
  (1009,'Command: reload custom_ffa'),
  (1010,'Command: player info'),
  (1011,'Command: raid info'),
  (1012,'Command: raid list'),
  (1013,'Command: bc'),
  (1014,'Command: bc resetcd'),
  (1015,'Command: bc accinfo'),
  (1020,'Command: bc house'),
  (1021,'Command: bc house add'),
  (1022,'Command: bc house del'),
  (1023,'Command: bc house available'),
  (1024,'Command: bc house info'),
  (1025,'Command: bc event'),
  (1026,'Command: bc event add'),
  (1027,'Command: bc event del'),
  (1028,'Command: bc event rename'),
  (1029,'Command: bc event info'),
  (1030,'Command: bc event appear'),
  (1031,'Command: bc event list'),
  (1032,'Command: bc event visible'),
  (1033,'Command: bc event build'),
  (1034,'Command: bc debug'),
  (1035,'Command: bc debug worldstate'),
  (1036,'Command: bc debug isinrange'),
  (1037,'Command: bc debug worldpacket'),
  (1038,'Command: bc server'),
  (1039,'Command: bc server lock'),
  (1040,'Command: bc instance'),
  (1041,'Command: bc instance freeze'),
  (1042,'Command: bc instance unfreeze'),
  (1043,'Command: bc anticheat'),
  (1044,'Command: bc anticheat handle'),
  (1045,'Command: bc anticheat listen'),
  (1046,'Command: bc reload'),
  (1047,'Command: bc reload ip2nation'),
  (1048,'Command: bc reload account_access'),
  (1101,'Command: json'),
  (1102,'Command: json server'),
  (1201,'Command: cementerio');

/*!40000 ALTER TABLE `rbac_permissions` ENABLE KEYS */;
UNLOCK TABLES;


# Volcado de tabla rbac_role_permissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rbac_role_permissions`;

CREATE TABLE `rbac_role_permissions` (
  `roleId` int(10) unsigned NOT NULL COMMENT 'Role id',
  `permissionId` int(10) unsigned NOT NULL COMMENT 'Permission id',
  PRIMARY KEY (`roleId`,`permissionId`),
  KEY `fk__role_permissions__rbac_permissions` (`permissionId`),
  CONSTRAINT `fk__role_permissions__rbac_permissions` FOREIGN KEY (`permissionId`) REFERENCES `rbac_permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk__role_permissions__rbac_roles` FOREIGN KEY (`roleId`) REFERENCES `rbac_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Role Permission relation';

LOCK TABLES `rbac_role_permissions` WRITE;
/*!40000 ALTER TABLE `rbac_role_permissions` DISABLE KEYS */;

INSERT INTO `rbac_role_permissions` (`roleId`, `permissionId`)
VALUES
  (5,1),
  (6,3),
  (6,4),
  (6,5),
  (7,6),
  (8,11),
  (9,13),
  (33,14),
  (33,15),
  (33,16),
  (33,17),
  (33,18),
  (27,19),
  (22,20),
  (23,21),
  (24,22),
  (17,23),
  (34,24),
  (28,25),
  (30,26),
  (19,27),
  (35,28),
  (36,29),
  (11,30),
  (12,31),
  (10,32),
  (20,33),
  (14,34),
  (37,35),
  (29,36),
  (15,37),
  (13,38),
  (25,39),
  (38,40),
  (26,41),
  (18,42),
  (18,43),
  (16,44),
  (31,45),
  (32,46),
  (21,47),
  (39,48),
  (40,49),
  (41,50),
  (43,217),
  (43,225),
  (43,226),
  (43,229),
  (4,230),
  (44,230),
  (4,231),
  (44,231),
  (3,232),
  (43,233),
  (43,234),
  (43,235),
  (3,236),
  (3,237),
  (43,238),
  (3,239),
  (4,239),
  (4,240),
  (3,241),
  (3,242),
  (3,243),
  (4,243),
  (3,244),
  (4,244),
  (3,245),
  (4,245),
  (3,246),
  (3,247),
  (4,248),
  (4,249),
  (4,250),
  (4,251),
  (43,252),
  (43,253),
  (43,254),
  (43,255),
  (43,256),
  (43,257),
  (44,257),
  (44,258),
  (44,259),
  (44,260),
  (43,261),
  (44,261),
  (44,262),
  (43,267),
  (44,267),
  (44,268),
  (44,269),
  (44,270),
  (44,271),
  (44,272),
  (43,273),
  (43,274),
  (43,275),
  (43,276),
  (3,277),
  (4,279),
  (4,280),
  (43,283),
  (43,284),
  (43,285),
  (43,286),
  (43,287),
  (44,287),
  (43,291),
  (44,291),
  (44,292),
  (44,293),
  (44,294),
  (43,295),
  (44,295),
  (44,296),
  (44,297),
  (44,298),
  (44,299),
  (44,300),
  (44,301),
  (44,302),
  (44,303),
  (44,304),
  (44,305),
  (44,308),
  (44,312),
  (44,339),
  (42,367),
  (44,367),
  (42,368),
  (44,368),
  (42,369),
  (44,369),
  (44,370),
  (2,371),
  (3,371),
  (44,371),
  (2,372),
  (3,372),
  (3,373),
  (4,373),
  (44,373),
  (4,375),
  (2,376),
  (3,376),
  (44,376),
  (44,377),
  (43,378),
  (44,378),
  (44,379),
  (44,380),
  (43,381),
  (44,381),
  (44,382),
  (4,385),
  (44,385),
  (44,386),
  (3,387),
  (4,387),
  (44,387),
  (43,388),
  (44,388),
  (4,389),
  (44,389),
  (4,390),
  (44,390),
  (4,391),
  (44,391),
  (3,392),
  (44,392),
  (44,393),
  (3,394),
  (44,394),
  (43,395),
  (44,395),
  (43,396),
  (44,396),
  (44,397),
  (3,398),
  (44,398),
  (43,399),
  (44,399),
  (43,401),
  (43,402),
  (43,403),
  (43,404),
  (43,405),
  (43,406),
  (43,407),
  (44,408),
  (44,409),
  (44,410),
  (44,411),
  (4,412),
  (44,412),
  (4,413),
  (44,413),
  (4,414),
  (44,414),
  (44,415),
  (44,416),
  (4,417),
  (44,417),
  (43,418),
  (44,418),
  (43,419),
  (44,419),
  (43,420),
  (44,420),
  (43,421),
  (44,421),
  (43,422),
  (44,422),
  (43,423),
  (44,423),
  (43,424),
  (44,424),
  (44,425),
  (44,426),
  (44,427),
  (44,428),
  (4,429),
  (43,429),
  (44,429),
  (43,440),
  (3,442),
  (4,442),
  (44,442),
  (3,443),
  (4,443),
  (44,443),
  (3,444),
  (4,444),
  (44,444),
  (3,445),
  (4,445),
  (44,445),
  (4,446),
  (44,446),
  (3,447),
  (4,447),
  (44,447),
  (3,448),
  (4,448),
  (44,448),
  (3,449),
  (4,449),
  (44,449),
  (3,450),
  (4,450),
  (44,450),
  (3,451),
  (4,451),
  (3,452),
  (4,452),
  (3,453),
  (4,453),
  (3,454),
  (4,454),
  (4,455),
  (44,455),
  (4,456),
  (44,456),
  (4,457),
  (44,457),
  (4,458),
  (44,458),
  (3,459),
  (4,459),
  (44,459),
  (4,460),
  (44,460),
  (4,461),
  (44,461),
  (2,462),
  (44,462),
  (2,466),
  (44,466),
  (2,467),
  (44,467),
  (2,468),
  (44,468),
  (2,469),
  (44,469),
  (2,470),
  (44,470),
  (2,471),
  (3,472),
  (43,472),
  (43,473),
  (43,474),
  (43,475),
  (43,476),
  (43,477),
  (3,478),
  (4,478),
  (43,478),
  (44,479),
  (44,480),
  (44,481),
  (44,482),
  (3,485),
  (4,485),
  (3,486),
  (4,488),
  (4,489),
  (2,490),
  (44,490),
  (4,492),
  (3,494),
  (44,494),
  (3,495),
  (4,495),
  (1,496),
  (44,496),
  (43,497),
  (44,497),
  (3,498),
  (4,498),
  (44,498),
  (43,499),
  (44,499),
  (3,500),
  (4,500),
  (44,500),
  (44,501),
  (4,502),
  (43,502),
  (44,502),
  (4,503),
  (2,504),
  (43,505),
  (44,505),
  (3,506),
  (1,507),
  (3,510),
  (4,513),
  (44,513),
  (2,515),
  (3,517),
  (44,517),
  (3,518),
  (2,520),
  (44,520),
  (4,521),
  (43,521),
  (3,522),
  (4,522),
  (44,522),
  (3,523),
  (4,523),
  (44,523),
  (1,525),
  (4,526),
  (44,526),
  (4,527),
  (2,528),
  (44,528),
  (3,529),
  (4,529),
  (44,529),
  (2,531),
  (43,532),
  (43,536),
  (44,536),
  (43,537),
  (44,537),
  (43,538),
  (44,538),
  (43,539),
  (44,539),
  (43,540),
  (44,540),
  (43,541),
  (44,541),
  (3,542),
  (3,543),
  (3,544),
  (4,544),
  (44,544),
  (43,545),
  (43,548),
  (44,548),
  (43,551),
  (44,551),
  (4,552),
  (43,552),
  (44,552),
  (43,553),
  (44,553),
  (43,554),
  (44,554),
  (43,556),
  (44,556),
  (43,557),
  (44,557),
  (43,558),
  (44,558),
  (3,560),
  (44,560),
  (3,561),
  (4,561),
  (44,561),
  (3,562),
  (4,562),
  (44,562),
  (44,563),
  (44,564),
  (44,565),
  (44,566),
  (44,570),
  (4,571),
  (44,571),
  (44,572),
  (44,573),
  (44,574),
  (3,575),
  (44,575),
  (4,576),
  (44,576),
  (44,577),
  (44,578),
  (44,579),
  (44,580),
  (4,581),
  (44,581),
  (4,582),
  (44,582),
  (44,583),
  (44,584),
  (44,585),
  (44,586),
  (44,587),
  (44,588),
  (44,589),
  (44,590),
  (44,591),
  (4,592),
  (44,592),
  (3,593),
  (4,593),
  (44,593),
  (3,594),
  (44,594),
  (44,595),
  (4,596),
  (44,596),
  (44,597),
  (44,598),
  (44,599),
  (44,600),
  (43,601),
  (44,601),
  (3,602),
  (4,602),
  (44,602),
  (3,603),
  (4,603),
  (44,603),
  (3,604),
  (4,604),
  (44,604),
  (3,605),
  (4,605),
  (44,605),
  (3,606),
  (44,606),
  (43,607),
  (44,607),
  (43,608),
  (43,627),
  (43,630),
  (43,636),
  (44,636),
  (43,640),
  (43,641),
  (43,648),
  (42,673),
  (44,679),
  (43,680),
  (44,680),
  (43,692),
  (43,693),
  (44,698),
  (44,699),
  (43,704),
  (3,718),
  (4,718),
  (43,718),
  (44,718),
  (3,725),
  (4,725),
  (44,725),
  (43,727),
  (44,727),
  (43,728),
  (44,728),
  (43,734),
  (43,735),
  (2,737),
  (44,737),
  (3,738),
  (4,738),
  (43,739),
  (2,740),
  (3,740),
  (2,741),
  (3,741),
  (4,741),
  (2,742),
  (2,744),
  (2,748),
  (4,748),
  (2,751),
  (2,752),
  (42,753),
  (43,758),
  (2,759),
  (2,760),
  (4,761),
  (44,761),
  (4,762),
  (44,762),
  (3,763),
  (4,763),
  (44,763),
  (43,764),
  (44,764),
  (44,765),
  (44,766),
  (1,1001),
  (1,1003),
  (1,1004),
  (1,1005),
  (1,1010),
  (1,1011),
  (1,1012),
  (3,1013),
  (42,1013),
  (43,1013),
  (43,1014),
  (3,1015),
  (43,1015),
  (42,1020),
  (43,1020),
  (42,1021),
  (43,1021),
  (43,1022),
  (42,1023),
  (43,1023),
  (42,1024),
  (43,1024),
  (4,1025),
  (42,1025),
  (4,1026),
  (42,1026),
  (43,1027),
  (43,1028),
  (42,1029),
  (4,1030),
  (42,1030),
  (4,1031),
  (42,1031),
  (43,1032),
  (4,1033),
  (42,1033),
  (43,1038),
  (43,1039),
  (3,1043),
  (3,1044),
  (3,1045),
  (43,1046),
  (43,1047),
  (43,1048),
  (43,1101),
  (43,1102),
  (1,1201);

/*!40000 ALTER TABLE `rbac_role_permissions` ENABLE KEYS */;
UNLOCK TABLES;


# Volcado de tabla rbac_roles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rbac_roles`;

CREATE TABLE `rbac_roles` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Role id',
  `name` varchar(100) NOT NULL COMMENT 'Role name',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Roles List';

LOCK TABLES `rbac_roles` WRITE;
/*!40000 ALTER TABLE `rbac_roles` DISABLE KEYS */;

INSERT INTO `rbac_roles` (`id`, `name`)
VALUES
  (1,'Player Commands'),
  (2,'GameMaster Lv 1 Commands'),
  (3,'GameMaster Lv 2 Commands'),
  (4,'GameMaster Lv 3 Commands'),
  (5,'Quick Login/Logout'),
  (6,'Use Battleground/Arenas'),
  (7,'Use Dungeon Finder'),
  (8,'Log GM trades'),
  (9,'Skip Instance required bosses check'),
  (10,'Ticket management'),
  (11,'Instant .save'),
  (12,'Allow params with .unstuck'),
  (13,'Full HP after resurrect'),
  (14,'Appear in GM ingame list'),
  (15,'Use staff badge in chat'),
  (16,'Receive global GM messages/texts'),
  (17,'Skip over-speed ping check'),
  (18,'Allows Admin Opcodes'),
  (19,'Two side mail interaction'),
  (20,'Notify if a command was not found'),
  (21,'Enables lower security than target check'),
  (22,'Skip disable map check'),
  (23,'Skip reset talents when used more than allowed check'),
  (24,'Skip spam chat check'),
  (25,'Restore saved gm setting states'),
  (26,'Use Config option START_GM_LEVEL to assign new character level'),
  (27,'Skip needed requirements to use channel check'),
  (28,'Allow say chat between factions'),
  (29,'Filter whispers'),
  (30,'Allow channel chat between factions'),
  (31,'Join channels without announce'),
  (32,'Change channel settings without being channel moderator'),
  (33,'Skip character creation checks'),
  (34,'Two side faction characters on the same account'),
  (35,'See two side who list'),
  (36,'Add friends of other faction'),
  (37,'See all security levels with who command'),
  (38,'Allows to add a gm to friend list'),
  (39,'Enable IP, Last Login and EMail output in pinfo'),
  (40,'Forces to enter the email for confirmation on password change'),
  (41,'Allow user to check his own email with .account'),
  (42,'GameMaster Lv 4 Commands'),
  (43,'Administrator Commands'),
  (44,'Developer Commands');

/*!40000 ALTER TABLE `rbac_roles` ENABLE KEYS */;
UNLOCK TABLES;


# Volcado de tabla rbac_security_level_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rbac_security_level_groups`;

CREATE TABLE `rbac_security_level_groups` (
  `secId` int(10) unsigned NOT NULL COMMENT 'Security Level id',
  `groupId` int(10) unsigned NOT NULL COMMENT 'group id',
  PRIMARY KEY (`secId`,`groupId`),
  KEY `fk__rbac_security_level_groups__rbac_groups` (`groupId`),
  CONSTRAINT `fk__rbac_security_level_groups__rbac_groups` FOREIGN KEY (`groupId`) REFERENCES `rbac_groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Default groups to assign when an account is set gm level';

LOCK TABLES `rbac_security_level_groups` WRITE;
/*!40000 ALTER TABLE `rbac_security_level_groups` DISABLE KEYS */;

INSERT INTO `rbac_security_level_groups` (`secId`, `groupId`)
VALUES
  (0,1),
  (1,1),
  (2,1),
  (3,1),
  (4,1),
  (5,1),
  (1,2),
  (2,2),
  (3,2),
  (4,2),
  (5,2),
  (2,3),
  (3,3),
  (4,3),
  (5,3),
  (3,4),
  (4,4),
  (5,4),
  (4,5),
  (5,5),
  (5,6);

/*!40000 ALTER TABLE `rbac_security_level_groups` ENABLE KEYS */;
UNLOCK TABLES;



# Volcado de tabla realmcharacters
# ------------------------------------------------------------

DROP TABLE IF EXISTS `realmcharacters`;

CREATE TABLE `realmcharacters` (
  `realmid` int(11) unsigned NOT NULL DEFAULT '0',
  `acctid` bigint(20) unsigned NOT NULL,
  `numchars` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`realmid`,`acctid`),
  KEY `acctid` (`acctid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Realm Character Tracker';



# Volcado de tabla realmd_db_version
# ------------------------------------------------------------

DROP TABLE IF EXISTS `realmd_db_version`;

CREATE TABLE `realmd_db_version` (
  `required_9010_01_realmd_realmlist` bit(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Last applied sql update to DB';



# Volcado de tabla realmlist
# ------------------------------------------------------------

DROP TABLE IF EXISTS `realmlist`;

CREATE TABLE `realmlist` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  `address` varchar(255) NOT NULL DEFAULT '127.0.0.1',
  `localAddress` varchar(255) NOT NULL DEFAULT '127.0.0.1',
  `localSubnetMask` varchar(255) NOT NULL DEFAULT '255.255.255.0',
  `port` int(11) NOT NULL DEFAULT '8085',
  `icon` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `flag` tinyint(3) unsigned NOT NULL DEFAULT '2',
  `timezone` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `allowedSecurityLevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `allowedAccountType` tinyint(3) NOT NULL DEFAULT '0',
  `population` float unsigned NOT NULL DEFAULT '0',
  `realmbuilds` varchar(64) NOT NULL DEFAULT '',
  `gamebuild` int(11) unsigned NOT NULL DEFAULT '12340',
  `country` varchar(3) NOT NULL DEFAULT 'all',
  `TransferAvailable` int(1) DEFAULT '1',
  `color` tinyint(3) unsigned DEFAULT '0' COMMENT 'Borrar en update',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Realm System';


--
-- Dumping data for table `realmlist`
--

LOCK TABLES `realmlist` WRITE;
/*!40000 ALTER TABLE `realmlist` DISABLE KEYS */;
INSERT INTO `realmlist` VALUES ('1','Trinity','127.0.0.1','127.0.0.1','255.255.255.0','8085','0','1','1','0','0','0','0','12340','all','0','0');
/*!40000 ALTER TABLE `realmlist` ENABLE KEYS */;
UNLOCK TABLES;

# Volcado de tabla redeem
# ------------------------------------------------------------

DROP TABLE IF EXISTS `redeem`;

CREATE TABLE `redeem` (
  `id` int(255) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(255) NOT NULL,
  `account_id` int(255) NOT NULL DEFAULT '0',
  `proof` varchar(255) NOT NULL,
  `value` int(255) NOT NULL DEFAULT '0',
  `email` varchar(255) NOT NULL,
  `date` varchar(45) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '0',
  `method` int(1) NOT NULL DEFAULT '2',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Volcado de tabla redeem_history
# ------------------------------------------------------------

DROP TABLE IF EXISTS `redeem_history`;

CREATE TABLE `redeem_history` (
  `id` int(255) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(255) NOT NULL,
  `account_name` varchar(255) NOT NULL,
  `character_guid` int(255) NOT NULL,
  `character_name` varchar(45) NOT NULL,
  `item` int(255) unsigned NOT NULL,
  `realm` varchar(45) NOT NULL,
  `date` varchar(45) NOT NULL,
  `status` varchar(45) NOT NULL DEFAULT '0',
  `de` varchar(255) NOT NULL DEFAULT '0',
  `from_account_id` int(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Volcado de tabla redeem_items
# ------------------------------------------------------------

DROP TABLE IF EXISTS `redeem_items`;

CREATE TABLE `redeem_items` (
  `item` int(30) unsigned NOT NULL,
  `name_es` varchar(255) NOT NULL,
  `name_us` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `iconName` varchar(255) NOT NULL,
  `eoe` int(10) unsigned DEFAULT NULL,
  `eod` int(10) DEFAULT NULL,
  `category` int(10) NOT NULL DEFAULT '0',
  `model` int(10) NOT NULL DEFAULT '0',
  `type` int(10) NOT NULL,
  PRIMARY KEY (`item`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Volcado de tabla reports
# ------------------------------------------------------------

DROP TABLE IF EXISTS `reports`;

CREATE TABLE `reports` (
  `entry` int(11) unsigned NOT NULL,
  `type` int(11) unsigned NOT NULL,
  `account` int(11) unsigned NOT NULL,
  `comment` varchar(250) NOT NULL,
  UNIQUE KEY `entry` (`entry`,`type`,`account`),
  KEY `IndexEntry` (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Volcado de tabla tradelog
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tradelog`;

CREATE TABLE `tradelog` (
  `accid` int(11) unsigned NOT NULL,
  `type` varchar(20) NOT NULL,
  `item` int(11) unsigned NOT NULL,
  `count` int(11) unsigned NOT NULL,
  `money` int(11) unsigned NOT NULL,
  `targetAcc` int(11) unsigned NOT NULL,
  `unix_timestamp` bigint(40) unsigned NOT NULL DEFAULT '0',
  `realmId` tinyint(2) unsigned NOT NULL,
  `revisado` tinyint(1) DEFAULT '0',
  KEY `AccountIndex` (`accid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Volcado de tabla uptime
# ------------------------------------------------------------

DROP TABLE IF EXISTS `uptime`;

CREATE TABLE `uptime` (
  `realmid` int(11) unsigned NOT NULL,
  `starttime` bigint(20) unsigned NOT NULL DEFAULT '0',
  `startstring` varchar(64) NOT NULL DEFAULT '',
  `uptime` bigint(20) unsigned NOT NULL DEFAULT '0',
  `maxplayers` smallint(5) unsigned NOT NULL DEFAULT '0',
  `revision` varchar(255) NOT NULL DEFAULT 'Trinitycore',
  PRIMARY KEY (`realmid`,`starttime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Uptime system';



# Volcado de tabla warden_flaggeds
# ------------------------------------------------------------

DROP TABLE IF EXISTS `warden_flaggeds`;

CREATE TABLE `warden_flaggeds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `accId` int(10) unsigned NOT NULL DEFAULT '0',
  `failedCheck` int(10) unsigned NOT NULL DEFAULT '0',
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  UNIQUE KEY `id` (`id`),
  KEY `accIdIndex` (`accId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
