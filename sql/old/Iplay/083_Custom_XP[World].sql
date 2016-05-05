SET @id = 1000;
-- DELETE FROM `rbac_permissions` WHERE `id` BETWEEN @id AND @id+2;
-- INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
-- (@id+1, 'rate xp'),
-- (@id+2, 'rate loot');

-- DELETE FROM `rbac_role_permissions` WHERE `roleId` = 0 AND `permissionId` BETWEEN @id AND @id+2;
-- INSERT INTO `rbac_role_permissions` (`roleId`, `permissionId`) VALUES
-- (0,@id+1),
-- (0,@id+2);

DELETE FROM `command` WHERE `permission` BETWEEN @id+1 AND @id+2;  
INSERT INTO `command` (`name`, `permission`, `help`) 
VALUES
('rate xp',@id+6,'Syntax: .rate xp $value\r\nSets your XP multiplier to $value. If no parameter is provided, it will show your current XP rate.'),
('rate loot',@id+7,'Syntax: .rate loot $value\r\nSets your loot multiplier to $value. If no parameter is provided, it will show your current loot rate. A $value of 0 means you wont be able to loot anything.');
