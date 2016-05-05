UPDATE creature_template SET scriptname = 'npc_rocknar' WHERE entry = '25514';

DELETE FROM `creature_text` WHERE `entry` IN (25514);
INSERT INTO `creature_text` VALUES
('25514','0','0',"You are not welcome here. Die!",'12','0','0','0','0','0','SAY_00'),
('25514','1','0',"Frozen and destroyed. This is all your fleshy corpse is good for.",'12','0','0','0','0','0','SAY_01');

DELETE FROM `locales_creature_text` WHERE `entry` = '25514';
INSERT INTO `locales_creature_text` (`entry`, `groupid`, `id`, `text_loc1`, `text_loc2`, `text_loc3`, `text_loc4`, `text_loc5`, `text_loc6`, `text_loc7`, `text_loc8`) VALUES
('25514','0','0',NULL,NULL,NULL,NULL,NULL,NULL,"No eres bienvenido aquí. ¡Muere!.",NULL),
('25514','1','0',NULL,NULL,NULL,NULL,NULL,NULL,'Tu presencia desequilibra la tierra. ¡Hay que eliminarte!',NULL);

UPDATE creature SET spawntimesecs = 20 WHERE guid = 111976;

UPDATE creature_template SET scriptname = 'npc_leviroth' WHERE entry = 26452;

UPDATE creature SET position_x ='2476.60', position_y = '5216.74', position_z='31.4394',orientation='0.43228' WHERE guid = 117746;
UPDATE creature SET position_x ='2480.94', position_y = '5212.34', position_z='30.1997',orientation='0.01210' WHERE guid = 117688;
UPDATE creature SET position_x ='2483.65', position_y = '5209.22', position_z='30.5400',orientation='0.80535' WHERE guid = 117809;
DELETE FROM creature_addon WHERE guid IN (117809);
INSERT INTO creature_addon VALUES
('117809','0','0','0','0','375','');

DELETE FROM creature_addon WHERE guid IN (57076);
INSERT INTO creature_addon VALUES
('57076','0','0','0','0','432','');

UPDATE creature SET MovementType='1',spawndist='6' WHERE guid IN (57077,57074,57075);

DELETE FROM creature_addon WHERE guid IN (111092,111086,111085,111087,111126,111140);
INSERT INTO creature_addon VALUES
('111092','0','0','0','0','333',''),
('111086','0','0','0','0','333',''),
('111085','0','0','0','0','333',''),
('111087','0','0','0','0','333',''),
('111126','0','0','0','0','333',''),
('111140','0','0','0','0','333','');
