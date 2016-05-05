DELETE FROM `rbac_permissions` WHERE `id` IN (1071,1072,1073,1074,1075,1084);
INSERT INTO `rbac_permissions` (`id`,`name`) VALUES
(1071,'Command: qc'),
(1072,'Command: qc status'),
(1073,'Command: qc add'),
(1074,'Command: qc del'),
(1075,'Command: qc complete'),
(1084,'Command: qc reload');
 
DELETE FROM `rbac_role_permissions` WHERE `permissionId` IN (1071,1072,1073,1074,1075,1084);
INSERT INTO `rbac_role_permissions` (`roleId`, `permissionId`) VALUES
(43, 1071),
(43, 1072), -- adds qc status to GMs
(43, 1073), -- adds qc add to GMs
(43, 1074), -- adds qc del to GMs  
(43, 1075), -- adds qc complete to GMs
(43, 1084); -- adds qc reload to GMs
