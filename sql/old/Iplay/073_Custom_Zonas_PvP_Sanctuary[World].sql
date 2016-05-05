-- Custom Sanctuary
DROP TABLE IF EXISTS `custom_sanctuary`;
CREATE TABLE `custom_sanctuary` (
  `entry` int(32) unsigned NOT NULL,
  `type` int(8) unsigned NOT NULL default '0' COMMENT '0 = disabled, 1 = map, 2 = zone, 3 = area',
  PRIMARY KEY  (`entry`,`type`)
) 
ENGINE=InnoDB
ROW_FORMAT=DEFAULT;

-- Custom FFA
DROP TABLE IF EXISTS `custom_pvp_zones`;
CREATE TABLE `custom_pvp_zones` (
  `entry` int(32) unsigned NOT NULL,
  `type` int(8) unsigned NOT NULL default '0' COMMENT '0 = disabled, 1 = map, 2 = zone, 3 = area',
  PRIMARY KEY  (`entry`,`type`)
) 
ENGINE=InnoDB
ROW_FORMAT=DEFAULT;

SET @id = 1000;
-- DELETE FROM `rbac_permissions` WHERE `id` BETWEEN @id AND @id+2;
-- INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
-- (@id+1, 'reload custom_sanctuary'),
-- (@id+2, 'reload custom_ffa');

-- DELETE FROM `rbac_role_permissions` WHERE `roleId` = 0 AND `permissionId` BETWEEN @id AND @id+2;
-- INSERT INTO `rbac_role_permissions` (`roleId`, `permissionId`) VALUES
-- (0,@id+1),
-- (0,@id+2);

-- Reload commands
DELETE FROM `command` WHERE `permission` BETWEEN @id+1 AND @id+2;  
INSERT INTO `command` (`name`,`permission`,`help`) VALUES
('reload custom_sanctuary',@id+8,'Recarga los datos de santuarios custom.'), -- Reload custom_sanctuary table
('reload custom_ffa',@id+9,'Recarga las zonas pvp custom.'); -- Reload custom_pvp_zones table
