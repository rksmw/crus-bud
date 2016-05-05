DELETE FROM `creature` WHERE `guid` IN (2000034,2000035,2000036);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values
('2000034','25338','571','1','1','0','1','4140.91','5783.52','60.5318','2.89846','5','0','0','8982','0','0','0','0','0'),
('2000035','25338','571','1','1','0','1','4141.57','5787.48','61.2827','3.16942','5','0','0','8982','0','0','0','0','0'),
('2000036','25338','571','1','1','0','1','4142.79','5785.11','60.8389','3.05946','5','0','0','8982','0','0','0','0','0');

DELETE FROM creature_formations WHERE leaderGUID = 85249;
INSERT INTO creature_formations VALUES
(85249,85249,0,0,0),
(85249,2000034,4,270,0),
(85249,2000035,4,90,0),
(85249,2000036,4,360,0);

UPDATE creature_template SET scriptname='npc_longrunner_proudhoof',unit_flags = 32776,faction_H = 1921 WHERE entry IN (25335);
UPDATE creature_template SET scriptname ='npc_steeljaw',unit_flags = 32776,faction_H = 16,faction_A = 16 WHERE entry IN (25359);
UPDATE creature_template SET scriptname='npc_warsong_caravan_guard' WHERE entry = 25338;
UPDATE creature_template SET scriptname='npc_kaganishu' WHERE entry = 25427;
UPDATE creature_template SET unit_flags = 32776 WHERE entry IN (25351,25350);

DELETE FROM `script_waypoint` WHERE `entry` = 25335;
INSERT INTO `script_waypoint` (`entry`, `pointid`, `location_x`, `location_y`, `location_z`, `waittime`, `point_comment`) VALUES
('25335','0','4138.37','5785.34','60.8838','3000',''),
('25335','1','4138.37','5785.34','60.8838','7000',''),
('25335','2','4138.37','5785.34','60.8838','4000',''),
('25335','3','4128.82','5789.7','62.0624','0',''),
('25335','4','4109.61','5798.17','66.2576','0',''),
('25335','5','4088.17','5804.98','70.7421','0',''),
('25335','6','4067.38','5807.83','74.0433','0',''),
('25335','7','4049.38','5805.43','75.4919','0',''),
('25335','8','4029.28','5799.4','76.3638','0',''),
('25335','9','4009.87','5791.44','74.47','0',''),
('25335','10','3988.72','5787.94','74.0056','7000',''),
('25335','11','3988.72','5787.94','74.0056','5000',''),
('25335','12','3975.74','5782.71','73.9351','0',''),
('25335','13','3942.71','5766.33','72.0499','0',''),
('25335','14','3921.4','5757.79','70.3733','0',''),
('25335','15','3900.53','5746.18','70.3444','0',''),
('25335','16','3884.94','5733.28','68.5974','0',''),
('25335','17','3880.66','5725.82','67.387','7000',''),
('25335','18','3880.66','5725.82','67.387','7000',''),
('25335','19','3880.66','5725.82','67.387','4000',''),
('25335','20','3880.66','5725.82','67.387','7000','');


DELETE FROM `creature_text` WHERE `entry` IN (25335);
INSERT INTO `creature_text` VALUES
('25335','0','0',"$N is going to join us on our assault. Let us bring peace to my ancestors!",'12','0','0','0','0','0','SAY_00'),
('25335','1','0',"WE STRIKE!",'14','0','0','0','0','0','SAY_01'),
('25335','2','0',"An ambush. Return them to their rest!",'12','0','0','0','0','0','SAY_02'),
('25335','3','0',"Regain your strenght. The place where Steeljaw was felled is just ahead.",'12','0','0','0','0','0','SAY_03'),
('25335','4','0',"There's the dog's banner and there's his corpse. What's that? He's upon us!",'12','0','0','0','0','0','SAY_04'),
('25335','5','0',"You fought well. Now go north to your orc outpost and inform Overlord Bor'gorok of our success!",'12','0','0','0','0','0','SAY_05');

DELETE FROM `locales_creature_text` WHERE `entry` = '25335';
INSERT INTO `locales_creature_text` (`entry`, `groupid`, `id`, `text_loc1`, `text_loc2`, `text_loc3`, `text_loc4`, `text_loc5`, `text_loc6`, `text_loc7`, `text_loc8`) VALUES
('25335','0','0',NULL,NULL,NULL,NULL,NULL,NULL,"$N va a unirse a nuestro ataque. ¡Hagamos que mis ancestros descansen en paz!",NULL),
('25335','1','0',NULL,NULL,NULL,NULL,NULL,NULL,'¡ATACAMOS!',NULL),
('25335','2','0',NULL,NULL,NULL,NULL,NULL,NULL,'Una emboscada, ¡Devolvedlos a su eterno descanso!',NULL),
('25335','3','0',NULL,NULL,NULL,NULL,NULL,NULL,'Recupera tus fuerzas. El lugar donde Quijacero fue derribado está justo ahí.',NULL),
('25335','4','0',NULL,NULL,NULL,NULL,NULL,NULL,'Ahí está el estandarte del perro y ahí su cadáver. ¿Qué es eso? ¡Está sobre nosotros!',NULL),
('25335','5','0',NULL,NULL,NULL,NULL,NULL,NULL,"Has luchado bien. ¡Ahora ve hacia el norte hasta tu avanzada orca e informa al señor supremo Bor'gorok de nuestro éxito!",NULL);

DELETE FROM `creature_text` WHERE `entry` IN (25359);
INSERT INTO `creature_text` VALUES
('25359','0','0',"I'm freed! Thank you.",'12','0','0','0','0','0','SAY_00');

DELETE FROM `locales_creature_text` WHERE `entry` = '25359';
INSERT INTO `locales_creature_text` (`entry`, `groupid`, `id`, `text_loc1`, `text_loc2`, `text_loc3`, `text_loc4`, `text_loc5`, `text_loc6`, `text_loc7`, `text_loc8`) VALUES
('25359','0','0',NULL,NULL,NULL,NULL,NULL,NULL,"¡Soy libre! Gracias.",NULL);

UPDATE creature SET spawntimesecs = 5 WHERE guid = 85249;
