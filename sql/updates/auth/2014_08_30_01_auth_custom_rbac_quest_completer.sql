DELETE FROM `rbac_permissions` WHERE `id` BETWEEN 1071 AND 1075;
INSERT INTO `rbac_permissions` (`id`,`name`) VALUES
(1071,'Command: .qc'),
(1072,'Command: .qc status'),
(1073,'Command: .qc add'),
(1074,'Command: .qc del'),
(1075,'Command: .qc complete');

DELETE FROM `rbac_role_permissions` WHERE `permissionId` BETWEEN 1071 AND 1075;
INSERT INTO `rbac_role_permissions` (`roleId`, `permissionId`) VALUES
(1, 1071),
(1, 1072), -- adds qc status to players
(43, 1073), -- adds qc add to GMs
(43, 1074), -- adds qc del to GMs
(1, 1075); -- adds qc complete to players
