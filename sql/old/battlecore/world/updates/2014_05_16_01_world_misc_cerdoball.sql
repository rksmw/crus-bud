DELETE FROM `gameobject` WHERE `guid` BETWEEN 800000 AND 800064;

SET @ENTRY := 100007;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,'Gol del equipo rojo!',12,0,100,1,0,0,'George Larrionda'),
(@ENTRY,1,0,'Gol del equipo azul!',12,0,100,1,0,0,'George Larrionda'),
(@ENTRY,2,0,'El cerdo ha muerto, gol para el equipo rojo',12,0,100,1,0,0,'George Larrionda'),
(@ENTRY,3,0,'El cerdo ha muerto, gol para el equipo azul',12,0,100,1,0,0,'George Larrionda'),
(@ENTRY,4,0,'¡Preparados!',41,0,100,0,0,0,'George Larrionda'),
(@ENTRY,5,0,'3',41,0,100,0,0,0,'George Larrionda'),
(@ENTRY,6,0,'2',41,0,100,0,0,0,'George Larrionda'),
(@ENTRY,7,0,'1',41,0,100,0,0,0,'George Larrionda'),
(@ENTRY,8,0,'¡Vamos!',41,0,100,0,0,0,'George Larrionda');
