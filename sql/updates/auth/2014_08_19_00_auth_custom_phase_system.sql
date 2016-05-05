SET @PHASING_SYSTEM_PERM := 1057;

DELETE FROM `rbac_permissions` WHERE `id` BETWEEN @PHASING_SYSTEM_PERM AND @PHASING_SYSTEM_PERM+13;
INSERT INTO `rbac_permissions` (`id`,`name`) VALUES
(@PHASING_SYSTEM_PERM+0,'Command: .phase'),
(@PHASING_SYSTEM_PERM+1,'Command: .phase join'),
(@PHASING_SYSTEM_PERM+2,'Command: .phase go'),
(@PHASING_SYSTEM_PERM+3,'Command: .phase gotarget'),
(@PHASING_SYSTEM_PERM+4,'Command: .phase godelete'),
(@PHASING_SYSTEM_PERM+5,'Command: .phase help'),
(@PHASING_SYSTEM_PERM+6,'Command: .phase delete'),
(@PHASING_SYSTEM_PERM+7,'Command: .phase kick'),
(@PHASING_SYSTEM_PERM+8,'Command: .phase get'),
(@PHASING_SYSTEM_PERM+9,'Command: .phase complete'),
(@PHASING_SYSTEM_PERM+10,'Command: .phase addmember'),
(@PHASING_SYSTEM_PERM+11,'Command: .phase npcadd'),
(@PHASING_SYSTEM_PERM+12,'Command: .phase npcdelete'),
(@PHASING_SYSTEM_PERM+13,'Command: .phase create');

DELETE FROM `rbac_role_permissions` WHERE `roleId` BETWEEN @PHASING_SYSTEM_PERM AND @PHASING_SYSTEM_PERM+13;
INSERT INTO `rbac_role_permissions` (`roleId`, `permissionId`) VALUES
('43',@PHASING_SYSTEM_PERM+0),
('43',@PHASING_SYSTEM_PERM+1),
('43',@PHASING_SYSTEM_PERM+2),
('43',@PHASING_SYSTEM_PERM+3),
('43',@PHASING_SYSTEM_PERM+4),
('43',@PHASING_SYSTEM_PERM+5),
('43',@PHASING_SYSTEM_PERM+6),
('43',@PHASING_SYSTEM_PERM+7),
('43',@PHASING_SYSTEM_PERM+8),
('43',@PHASING_SYSTEM_PERM+9),
('43',@PHASING_SYSTEM_PERM+10),
('43',@PHASING_SYSTEM_PERM+11),
('43',@PHASING_SYSTEM_PERM+12),
('43',@PHASING_SYSTEM_PERM+13);
