-- Add new permissions
DELETE FROM `rbac_permissions` WHERE `id` = 223;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(223, 'Command: .rbac list permissions');

-- Add Permissions to "Administrator Commands Role"
DELETE FROM `rbac_role_permissions` WHERE `roleId` = 43 AND `permissionId` = 223;
INSERT INTO `rbac_role_permissions` (`roleId`, `permissionId`) VALUES
(43, 223);
