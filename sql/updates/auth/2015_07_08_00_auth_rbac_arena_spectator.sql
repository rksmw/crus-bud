DELETE FROM `rbac_permissions` WHERE `id` BETWEEN 1000 AND 1005;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
('1000', 'spectator version'),
('1001', 'spectator'),
('1004', 'spectator spectate'),
('1002', 'spectator watch'),
('1005', 'spectator reset'),
('1003', 'spectator leave'); 

DELETE FROM `rbac_role_permissions` WHERE `permissionId` BETWEEN 1000 AND 1005;
INSERT INTO `rbac_role_permissions` (`roleId`, `permissionId`) VALUES
(1, 1000),
(1, 1001),
(1, 1004), 
(1, 1002), 
(1, 1005), 
(1, 1003);
