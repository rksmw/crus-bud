-- Add new permissions
DELETE FROM `rbac_permissions` WHERE `id` = 1019;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(1019, 'Command: .bc house list');

-- Add Permissions to "Administrator Commands Role"
DELETE FROM `rbac_role_permissions` WHERE `roleId` IN(42,43) AND `permissionId` = 1019;
INSERT INTO `rbac_role_permissions` (`roleId`, `permissionId`) VALUES
(42, 1019),
(43, 1019);
