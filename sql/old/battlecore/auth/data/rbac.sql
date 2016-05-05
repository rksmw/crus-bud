SET @PERMISSION_ID = 1000;

DELETE FROM `rbac_permissions` WHERE `id` BETWEEN @PERMISSION_ID+13 AND @PERMISSION_ID+48;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(@PERMISSION_ID+13, 'Command: bc'),
(@PERMISSION_ID+14, 'Command: bc resetcd'),
(@PERMISSION_ID+15, 'Command: bc accinfo'),
(@PERMISSION_ID+20, 'Command: bc house'),
(@PERMISSION_ID+21, 'Command: bc house add'),
(@PERMISSION_ID+22, 'Command: bc house del'),
(@PERMISSION_ID+23, 'Command: bc house available'),
(@PERMISSION_ID+24, 'Command: bc house info'),
(@PERMISSION_ID+25, 'Command: bc event'),
(@PERMISSION_ID+26, 'Command: bc event add'),
(@PERMISSION_ID+27, 'Command: bc event del'),
(@PERMISSION_ID+28, 'Command: bc event rename'),
(@PERMISSION_ID+29, 'Command: bc event info'),
(@PERMISSION_ID+30, 'Command: bc event appear'),
(@PERMISSION_ID+31, 'Command: bc event list'),
(@PERMISSION_ID+32, 'Command: bc event visible'),
(@PERMISSION_ID+33, 'Command: bc event build'),
(@PERMISSION_ID+34, 'Command: bc debug'),
(@PERMISSION_ID+35, 'Command: bc debug worldstate'),
(@PERMISSION_ID+36, 'Command: bc debug isinrange'),
(@PERMISSION_ID+37, 'Command: bc debug worldpacket'),
(@PERMISSION_ID+38, 'Command: bc server'),
(@PERMISSION_ID+39, 'Command: bc server lock'),
(@PERMISSION_ID+40, 'Command: bc instance'),
(@PERMISSION_ID+41, 'Command: bc instance freeze'),
(@PERMISSION_ID+42, 'Command: bc instance unfreeze'),
(@PERMISSION_ID+43, 'Command: bc anticheat'),
(@PERMISSION_ID+44, 'Command: bc anticheat handle'),
(@PERMISSION_ID+45, 'Command: bc anticheat listen'),
(@PERMISSION_ID+46, 'Command: bc reload'),
(@PERMISSION_ID+47, 'Command: bc reload ip2nation'),
(@PERMISSION_ID+48, 'Command: bc reload account_access');


SET @PERMISSION_ID = 1100;

DELETE FROM `rbac_permissions` WHERE `id` BETWEEN @PERMISSION_ID+1 AND @PERMISSION_ID+2;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(@PERMISSION_ID+1, 'Command: json'),
(@PERMISSION_ID+2, 'Command: json server');

SET @PERMISSION_ID = 1200;

DELETE FROM `rbac_permissions` WHERE `id` = @PERMISSION_ID+1;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(@PERMISSION_ID+1, 'Command: cementerio');
