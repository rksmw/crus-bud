-- para 25_Custom_Arena_Espectador[World].sql
SET @id = 1000; 
DELETE FROM `rbac_permissions` WHERE `id` BETWEEN @id AND @id+5;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(@id+1, 'spectate'),
(@id+2, 'spectate view'),
(@id+3, 'spectate leave'),
(@id+4, 'spectate player'),
(@id+5, 'spectate reset');

DELETE FROM `rbac_role_permissions` WHERE `roleId` = 1 AND `permissionId` BETWEEN @id AND @id+5;
INSERT INTO `rbac_role_permissions` (`roleId`, `permissionId`) VALUES
(1,@id+1),
(1,@id+2),
(1,@id+3),
(1,@id+4),
(1,@id+5);

-- para 73_Custom_Zonas_PvP_Sanctuary[World].sql
SET @id = 1000;
DELETE FROM `rbac_permissions` WHERE `id` BETWEEN @id AND @id+2;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(@id+8, 'reload custom_sanctuary'),
(@id+9, 'reload custom_ffa');

DELETE FROM `rbac_role_permissions` WHERE `roleId` = 1 AND `permissionId` BETWEEN @id AND @id+2;
INSERT INTO `rbac_role_permissions` (`roleId`, `permissionId`) VALUES
(1,@id+8),
(1,@id+9);

-- para 59_Custom_Info_Raid_Comandos[World].sql
SET @id = 1000;
DELETE FROM `rbac_permissions` WHERE `id` BETWEEN @id AND @id+3;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(@id+10, 'player info'),
(@id+11, 'raid info'),
(@id+12, 'raid list');

DELETE FROM `rbac_role_permissions` WHERE `roleId` = 1 AND `permissionId` BETWEEN @id AND @id+3;
INSERT INTO `rbac_role_permissions` (`roleId`, `permissionId`) VALUES
(1,@id+10),
(1,@id+11),
(1,@id+12);
