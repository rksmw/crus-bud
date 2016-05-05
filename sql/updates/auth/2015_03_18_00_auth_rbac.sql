-- Add new permissions
DELETE FROM `rbac_permissions` WHERE `id` = 1018;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(1018, 'Command: .bc house phaseable');

-- Add Permissions to "Administrator Commands Role"
DELETE FROM `rbac_role_permissions` WHERE `roleId` IN(42,43) AND `permissionId` = 1018;
INSERT INTO `rbac_role_permissions` (`roleId`, `permissionId`) VALUES
(42, 1018),
(43, 1018);
