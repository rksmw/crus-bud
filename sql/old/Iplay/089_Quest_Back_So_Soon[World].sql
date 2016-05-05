-- Fix [Quest] Back So Soon?
DELETE FROM `creature` WHERE `id`=28114;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`,`MovementType`) VALUES
(NULL,28114,571,1,1,0,0,6165,5092.98,-97.377174,0.750492,300,0,0,117700,3809,0);

DELETE FROM `creature_template_addon` WHERE `entry`=28114;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(28114,0,0,65536,1,0,'51589');
