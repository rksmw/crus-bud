-- Custom - Cerdoball
SET @ENTRY := 100007;
SET @GOSSIP := 60005;
SET @TEXT_ID := 100005;
DELETE FROM `creature_template` WHERE `entry` IN (@ENTRY,@ENTRY+1,@ENTRY+2,@ENTRY+3);
INSERT INTO `creature_template` (`entry`,`modelid1`,`name`,`subname`,`scale`,`gossip_menu_id`,`npcflag`,`unit_flags`,`type`,`minlevel`,`maxlevel`,`AIName`,`faction_A`,`faction_H`,`Health_mod`,`ScriptName`) VALUES
(@ENTRY,7094,"George Larrionda","Test Cerdoball",1,@GOSSIP,1,2,7,80,80,'SmartAI',35,35,1,''),
(@ENTRY+1,30547,"Trigger arco rojo","",0.3,0,0,2+33554432,7,80,80,'',15,15,1,''),
(@ENTRY+2,30547,"Trigger arco azul","",0.3,0,0,2+33554432,7,80,80,'',15,15,1,''),
(@ENTRY+3,193,"Chancho","Test Cerdoball",1,0,0,768,7,80,80,'',1095,1095,0.1872,'npc_cerdoball_ball');

UPDATE `creature_template` SET  `Health_mod` =  '10000' WHERE  `entry` =100010;

UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`
|16 -- FEAR
|32 -- GRIP
|64 -- ROOT
|65536 -- POLYMORPH
WHERE `entry` = 100010;

DELETE FROM `creature_template_addon` WHERE `entry` IN (@ENTRY+1,@ENTRY,@ENTRY+2);
INSERT INTO `creature_template_addon` (`entry`,`auras`) VALUES
(@ENTRY+1,'63772'),
(@ENTRY+2,'63773');

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

DELETE FROM `creature` WHERE `id` IN (@ENTRY,@ENTRY+1,@ENTRY+2);
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@ENTRY+1,0,1,1,0,0,-4734.49,-4335.35,332.799,0.0819294,300,0,0,5342,0,0,0,0,0),
(@ENTRY+1,0,1,1,0,0,-4734.49,-4350.35,332.799,0.0819294,300,0,0,5342,0,0,0,0,0),
(@ENTRY+2,0,1,1,0,0,-4664.49,-4335.35,332.799,0.0819294,300,0,0,5342,0,0,0,0,0),
(@ENTRY+2,0,1,1,0,0,-4664.49,-4350.35,332.799,0.0819294,300,0,0,5342,0,0,0,0,0),
(@ENTRY,0,1,1,0,0,-4699.49,-4313.98,332.799,4.58707,300,0,0,5342,0,0,0,0,0);

DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(@GOSSIP,@TEXT_ID);

DELETE FROM `npc_text` WHERE `ID`=@TEXT_ID;
INSERT INTO `npc_text` (`ID`,`text0_0`,`text0_1`,`text1_0`,`text1_1`,`text2_0`,`text2_1`,`text3_0`,`text3_1`,`text4_0`,`text4_1`,`text5_0`,`text5_1`,`text6_0`,`text6_1`,`text7_0`,`text7_1`) VALUES
(@TEXT_ID,"Quiero un juego limpio, nada de tonterías.",'','','','','','','','','','','','','','','');

DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(@GOSSIP,0,0,'Crear un cerdo.',1,1,0,0,0,0,NULL);

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,62,0,100,0,@GOSSIP,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'George Larrionda - On gossip select - Wp start'),
(@ENTRY,0,1,2,61,0,100,0,0,0,0,0,83,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'George Larrionda - On gossip select - Remove gossip flag'),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,53,1,@ENTRY,0,0,0,0,1,0,0,0,0,0,0,0,'George Larrionda - On gossip select - Wp start'),
(@ENTRY,0,3,4,40,0,100,0,1,@ENTRY,0,0,54,6000,0,0,0,0,0,1,0,0,0,0,0,0,0,'George Larrionda - Wp reached - Pause'),
(@ENTRY,0,4,5,61,0,100,0,0,0,0,0,1,4,5000,0,0,0,0,1,0,0,0,0,0,0,0,'George Larrionda - Wp reached - Pause'),
(@ENTRY,0,5,0,61,0,100,0,0,0,0,0,12,@ENTRY+3,6,3000,0,0,0,8,0,0,0,-4699.49,-4342.85,332.799,4.58707,'George Larrionda - Wp reached - Summon Chancho'),
(@ENTRY,0,6,0,52,0,100,0,4,@ENTRY,0,0,1,5,1000,0,0,0,0,1,0,0,0,0,0,0,0,'George Larrionda - Text over - Say text'),
(@ENTRY,0,7,0,52,0,100,0,5,@ENTRY,0,0,1,6,1000,0,0,0,0,1,0,0,0,0,0,0,0,'George Larrionda - Text over - Say text'),
(@ENTRY,0,8,0,52,0,100,0,6,@ENTRY,0,0,1,7,1000,0,0,0,0,1,0,0,0,0,0,0,0,'George Larrionda - Text over - Say text'),
(@ENTRY,0,9,10,52,0,100,0,7,@ENTRY,0,0,1,8,0,0,0,0,0,1,0,0,0,0,0,0,0,'George Larrionda - Text over - Say text'),
(@ENTRY,0,10,0,61,0,100,0,0,0,0,0,19,768,0,0,0,0,0,9,@ENTRY+3,0,100,0,0,0,0,'George Larrionda - Text over - Remove unit flags Chancho'),
(@ENTRY,0,11,12,40,0,100,0,2,@ENTRY,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,4.58707,'George Larrionda - Wp reached - Pause'),
(@ENTRY,0,12,0,61,0,100,0,0,0,0,0,81,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'George Larrionda - Wp reached - Add gossip flag');

DELETE FROM `waypoints` WHERE `entry`=@ENTRY;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(@ENTRY,1,-4699.49,-4339.85,332.799,'George Larrionda'),
(@ENTRY,2,-4699.49,-4313.98,332.799,'George Larrionda');

-- Ingame teleport for gamemasters
SET @TELE := 1003;
DELETE FROM `game_tele` WHERE `id`=@TELE;
INSERT INTO `game_tele` (`id`,`position_x`,`position_y`,`position_z`,`orientation`,`map`,`name`) VALUES
(@TELE,-4700.56781,-4324.148936,332.800079,1.597835,0,'Cerdoball');

-- Spawn ambiente por hold
DELETE FROM `gameobject` WHERE `guid` BETWEEN 800000 AND 800064;
SET @GUID := 800000;
INSERT INTO `gameobject` (`guid`,`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID+1 ,19901, 0, 1, 1, -4700.14, -4343.13, 332.8, 1.5066, 0, 0, 0.684051, 0.729434, 300, 0, 1),
(@GUID+2 ,192231, 0, 1, 1, -4664.01, -4360.87, 332.8, 3.20619, 0, 0, 0.999478, -0.0322947, 300, 255, 1),
(@GUID+3 ,192231, 0, 1, 1, -4668.88, -4369.36, 332.8, 1.65739, 0, 0, 0.73705, 0.675839, 300, 255, 1),
(@GUID+4 ,192231, 0, 1, 1, -4684.21, -4370.7, 332.8, 1.65739, 0, 0, 0.73705, 0.675839, 300, 255, 1),
(@GUID+5 ,192231, 0, 1, 1, -4699.91, -4372.06, 332.8, 1.65739, 0, 0, 0.73705, 0.675839, 300, 255, 1),
(@GUID+6 ,192231, 0, 1, 1, -4715.13, -4373.38, 332.8, 1.65739, 0, 0, 0.73705, 0.675839, 300, 255, 1),
(@GUID+7 ,192231, 0, 1, 1, -4733.76, -4362.15, 332.8, 0.133715, 0, 0, 0.0668079, 0.997766, 300, 255, 1),
(@GUID+8 ,192231, 0, 1, 1, -4726.6, -4373.57, 332.799, 4.80212, 0, 0, 0.674679, -0.738111, 300, 255, 1),
(@GUID+9 ,192231, 0, 1, 1, -4735.25, -4323.66, 332.8, 0.0198462, 0, 0, 0.00992293, 0.999951, 300, 255, 1),
(@GUID+10,192231, 0, 1, 1, -4728.91, -4312.32, 332.799, 4.78172, 0, 0, 0.682176, -0.731188, 300, 255, 1),
(@GUID+11,192231, 0, 1, 1, -4713.54, -4311.25, 332.799, 4.78172, 0, 0, 0.682176, -0.731188, 300, 255, 1),
(@GUID+12,192231, 0, 1, 1, -4697.16, -4309.74, 332.799, 4.78172, 0, 0, 0.682176, -0.731188, 300, 255, 1),
(@GUID+13,192231, 0, 1, 1, -4684.07, -4309.99, 332.799, 4.78172, 0, 0, 0.682176, -0.731188, 300, 255, 1),
(@GUID+14,192231, 0, 1, 1, -4664.65, -4322.94, 332.799, 3.17401, 0, 0, 0.999869, -0.0162057, 300, 255, 1),
(@GUID+15,192231, 0, 1, 1, -4672.25, -4311.18, 332.799, 1.62127, 0, 0, 0.724725, 0.689038, 300, 255, 1),
(@GUID+16,192219, 0, 1, 1, -4685.11, -4312.59, 347.282, 4.74481, 0, 0, 0.695553, -0.718475, 300, 0, 1),
(@GUID+17,192219, 0, 1, 1, -4689.98, -4312.75, 347.068, 4.74481, 0, 0, 0.695553, -0.718475, 300, 0, 1),
(@GUID+18,192219, 0, 1, 1, -4695.22, -4312.92, 347.25, 4.74481, 0, 0, 0.695553, -0.718475, 300, 0, 1),
(@GUID+19,192219, 0, 1, 1, -4700.13, -4313.08, 347.25, 4.74481, 0, 0, 0.695553, -0.718475, 300, 0, 1),
(@GUID+20,192219, 0, 1, 1, -4704.21, -4313.21, 346.968, 4.74481, 0, 0, 0.695553, -0.718475, 300, 0, 1),
(@GUID+21,192219, 0, 1, 1, -4708.41, -4313.36, 346.968, 4.74481, 0, 0, 0.695553, -0.718475, 300, 0, 1),
(@GUID+22,192219, 0, 1, 1, -4714.21, -4314.28, 346.686, 4.80529, 0, 0, 0.673512, -0.739176, 300, 0, 1),
(@GUID+23,192219, 0, 1, 1, -4720.13, -4314.83, 346.441, 4.80529, 0, 0, 0.673512, -0.739176, 300, 0, 1),
(@GUID+24,192219, 0, 1, 1, -4725.48, -4315.34, 346.441, 4.80529, 0, 0, 0.673512, -0.739176, 300, 0, 1),
(@GUID+25,192219, 0, 1, 1, -4729.77, -4315.74, 346.195, 4.80529, 0, 0, 0.673512, -0.739176, 300, 0, 1),
(@GUID+26,192219, 0, 1, 1, -4671.27, -4366.98, 346.753, 1.6629, 0, 0, 0.73891, 0.673804, 300, 0, 1),
(@GUID+27,192219, 0, 1, 1, -4676.61, -4367.47, 346.654, 1.6629, 0, 0, 0.73891, 0.673804, 300, 0, 1),
(@GUID+28,192219, 0, 1, 1, -4682.07, -4367.97, 346.654, 1.6629, 0, 0, 0.73891, 0.673804, 300, 0, 1),
(@GUID+29,192219, 0, 1, 1, -4686.61, -4368.39, 346.542, 1.6629, 0, 0, 0.73891, 0.673804, 300, 0, 1),
(@GUID+30,192219, 0, 1, 1, -4692.06, -4368.88, 346.542, 1.6629, 0, 0, 0.73891, 0.673804, 300, 0, 1),
(@GUID+31,192219, 0, 1, 1, -4696.59, -4369.3, 346.444, 1.6629, 0, 0, 0.73891, 0.673804, 300, 0, 1),
(@GUID+32,192219, 0, 1, 1, -4702.17, -4369.8, 346.444, 1.6629, 0, 0, 0.73891, 0.673804, 300, 0, 1),
(@GUID+33,192219, 0, 1, 1, -4707.39, -4370.28, 346.344, 1.6629, 0, 0, 0.73891, 0.673804, 300, 0, 1),
(@GUID+34,192219, 0, 1, 1, -4712.97, -4370.79, 346.344, 1.6629, 0, 0, 0.73891, 0.673804, 300, 0, 1),
(@GUID+35,192219, 0, 1, 1, -4717.51, -4371.21, 346.232, 1.6629, 0, 0, 0.73891, 0.673804, 300, 0, 1),
(@GUID+36,181618, 0, 1, 1, -4659.83, -4342.66, 332.8, 3.26668, 0, 0, 0.998045, -0.0625041, 300, 0, 1),
(@GUID+37,181619, 0, 1, 1, -4740.78, -4342.69, 332.8, 0.0520459, 0, 0, 0.02602, 0.999661, 300, 0, 1),
(@GUID+38,181852, 0, 1, 1, -4654.14, -4342.8, 332.8, 3.25097, 0, 0, 0.998505, -0.0546629, 300, 0, 1),
(@GUID+39,181852, 0, 1, 1, -4653.75, -4344.33, 332.8, 3.2282, 0, 0, 0.999063, -0.0432881, 300, 0, 1),
(@GUID+40,181852, 0, 1, 1, -4654.12, -4340.04, 332.8, 3.2282, 0, 0, 0.999063, -0.0432881, 300, 0, 1),
(@GUID+41,181853, 0, 1, 1, -4745.83, -4345.15, 332.8, 0.0379072, 0, 0, 0.0189525, 0.99982, 300, 0, 1),
(@GUID+42,181853, 0, 1, 1, -4745.89, -4342.35, 332.8, 0.0221992, 0, 0, 0.0110994, 0.999938, 300, 0, 1),
(@GUID+43,181853, 0, 1, 1, -4745.94, -4340.13, 332.8, 0.0221992, 0, 0, 0.0110994, 0.999938, 300, 0, 1),
(@GUID+44,210214, 0, 1, 1, -4734.87, -4355.63, 346.707, 0.180848, 0, 0, 0.0903008, 0.995915, 300, 0, 1),
(@GUID+45,210215, 0, 1, 1, -4734.97, -4331.02, 346.707, 3.15594, 0, 0, 0.999974, -0.00717221, 300, 0, 1),
(@GUID+46,210214, 0, 1, 1, -4664.38, -4330.83, 346.707, 3.16614, 0, 0, 0.999925, -0.0122742, 300, 0, 1),
(@GUID+47,210215, 0, 1, 1, -4664.77, -4353.42, 346.708, 6.21113, 0, 0, 0.0360207, -0.999351, 300, 0, 1),
(@GUID+48,180708, 0, 1, 1, -4671.86, -4318.75, 346.909, 0.730618, 0, 0, 0.357238, 0.934013, 300, 0, 1),
(@GUID+49,180708, 0, 1, 1, -4730.75, -4318.84, 345.228, 3.10959, 0, 0, 0.999872, 0.0160015, 300, 0, 1),
(@GUID+50,180723, 0, 1, 1, -4725.53, -4366.99, 345.888, 3.1842, 0, 0, 0.999773, -0.0213028, 300, 0, 1),
(@GUID+51,180723, 0, 1, 1, -4668.01, -4362.81, 345.533, 0.0339678, 0, 0, 0.0169831, 0.999856, 300, 0, 1),
(@GUID+52,180723, 0, 1, 1, -4697.54, -4313.86, 332.8, 1.64717, 0, 0, 0.733586, 0.679596, 300, 0, 1),
(@GUID+53,181852, 0, 1, 1, -4656.09, -4336.74, 332.801, 3.93203, 0, 0, 0.922913, -0.385008, 300, 0, 1),
(@GUID+54,181852, 0, 1, 1, -4659.01, -4333.03, 332.801, 4.12759, 0, 0, 0.880917, -0.47327, 300, 0, 1),
(@GUID+55,181852, 0, 1, 1, -4655.34, -4347.58, 332.801, 2.35809, 0, 0, 0.924242, 0.381808, 300, 0, 1),
(@GUID+56,181852, 0, 1, 1, -4658.21, -4350.47, 332.801, 2.35809, 0, 0, 0.924242, 0.381808, 300, 0, 1),
(@GUID+57,181853, 0, 1, 1, -4742.22, -4348.97, 332.801, 0.663201, 0, 0, 0.325557, 0.945522, 300, 0, 1),
(@GUID+58,181853, 0, 1, 1, -4740.14, -4351.64, 332.801, 0.663201, 0, 0, 0.325557, 0.945522, 300, 0, 1),
(@GUID+59,181853, 0, 1, 1, -4744.27, -4335.99, 332.801, 5.75964, 0, 0, 0.258791, -0.965933, 300, 0, 1),
(@GUID+60,181853, 0, 1, 1, -4740.47, -4333.27, 332.801, 5.22322, 0, 0, 0.505519, -0.862815, 300, 0, 1);
