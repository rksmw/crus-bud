DELETE FROM `rbac_permissions` WHERE `id` BETWEEN 1085 AND 1090;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
('1085 ', 'filter mod'),
('1086 ', 'filter add'),
('1087 ', 'filter remove'),
('1088 ', 'filter list'),
('1089 ', 'reload filter'),
('1090',  'reload letter_analog');

DELETE FROM `rbac_role_permissions` WHERE `permissionId` BETWEEN 1085 AND 1090;
INSERT INTO `rbac_role_permissions` (`roleId`, `permissionId`) VALUES
(43, 1085),
(43, 1086),
(43, 1087), 
(43, 1088), 
(43, 1089), 
(43, 1090);
