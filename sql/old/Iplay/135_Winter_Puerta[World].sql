-- Fix para poder cruzar al romper la puerta de la camara de Wintergrasp
DELETE FROM `gameobject` WHERE `id`=194323;
-- Para dejarlo como estaba
-- delete from `gameobject` where `id`=194323;
-- INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
-- (60070,194323,571,1,1,5396.21,2840.01,432.268,3.13286,0,0,0.99999,0.004363,180,255,1);
