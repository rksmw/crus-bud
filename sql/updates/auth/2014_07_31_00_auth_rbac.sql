-- Add new permissions
DELETE FROM `rbac_permissions` WHERE `id` = 282;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(282,'Command: character erase');

-- Add Permissions to "Administrator Commands Role"
DELETE FROM `rbac_role_permissions` WHERE `roleId` = 43 AND `permissionId` = 282;
INSERT INTO `rbac_role_permissions` (`roleId`, `permissionId`) VALUES
(43, 282);
