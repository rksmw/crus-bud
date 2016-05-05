-- Add new permissions
DELETE FROM `rbac_permissions` WHERE `id` = 1017;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(1017, 'Command: .bc event phasemask');

-- Add Permissions to "Administrator Commands Role"
DELETE FROM `rbac_role_permissions` WHERE `roleId` IN(42,43) AND `permissionId` = 1017;
INSERT INTO `rbac_role_permissions` (`roleId`, `permissionId`) VALUES
(42, 1017),
(43, 1017);
