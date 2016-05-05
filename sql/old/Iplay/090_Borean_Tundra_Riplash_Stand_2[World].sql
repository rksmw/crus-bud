UPDATE creature SET spawndist='5',movementtype='2' WHERE guid IN (28704);

DELETE FROM creature_addon WHERE guid IN (28704);
INSERT INTO creature_addon VALUES
('28704','287040','0','0','0','0','');

DELETE FROM `waypoint_data` WHERE id IN (287040);
insert into `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) values
('287040','1','1317.85','5923.33','6.22486','0','8000','0','0','100','0'),
('287040','2','1328.32','5920.44','5.39282','0','0','0','0','100','0'),
('287040','3','1342.1','5920.21','7.54717','0','0','0','0','100','0'),
('287040','4','1354.36','5923.07','5.31943','0','0','0','0','100','0'),
('287040','5','1367.37','5933.56','6.53096','0','8000','0','0','100','0');

UPDATE creature SET spawndist='5',movementtype='2' WHERE guid IN (54488);

DELETE FROM creature_addon WHERE guid IN (54488);
INSERT INTO creature_addon VALUES
('54488','544880','0','0','0','0','');

DELETE FROM `waypoint_data` WHERE id IN (544880);
insert into `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) values
('544880','1','1386.97','5970.58','7.42454','0','8000','0','0','100','0'),
('544880','2','1387.82','5967.19','7.39332','0','0','0','0','100','0'),
('544880','3','1393.46','5962.01','4.99651','0','0','0','0','100','0'),
('544880','4','1406.56','5958.17','2.06674','0','0','0','0','100','0'),
('544880','5','1414.12','5953.39','1.66914','0','0','0','0','100','0'),
('544880','6','1416.35','5939.36','2.46143','0','0','0','0','100','0'),
('544880','7','1414.65','5926.62','5.36214','0','0','0','0','100','0'),
('544880','8','1410.95','5914.35','6.54985','0','8000','0','0','100','0');

UPDATE creature SET spawndist='5',movementtype='2' WHERE guid IN (54489);

DELETE FROM creature_addon WHERE guid IN (54489);
INSERT INTO creature_addon VALUES
('54489','544890','0','0','0','0','');

DELETE FROM `waypoint_data` WHERE id IN (544890);
insert into `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) values
('544890','1','1451.69','5917.1','0.58224','0','8000','0','0','100','0'),
('544890','2','1452.91','5925.29','-0.839884','0','0','0','0','100','0'),
('544890','3','1454.92','5934.88','-0.844453','0','0','0','0','100','0'),
('544890','4','1457.39','5945.08','-0.844453','0','0','0','0','100','0'),
('544890','5','1456.66','5955.01','-0.844453','0','8000','0','0','100','0');


UPDATE creature SET spawndist='5',movementtype='2' WHERE guid IN (28701);

DELETE FROM creature_addon WHERE guid IN (28701);
INSERT INTO creature_addon VALUES
('28701','287010','0','0','0','0','');

DELETE FROM `waypoint_data` WHERE `id` = '287010';
insert into `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) values
('287010','1','1421.33','5830.34','11.6754','0','8000','0','0','100','0'),
('287010','2','1420.67','5837.3','11.7382','0','0','0','0','100','0'),
('287010','3','1417.06','5848.14','12.6932','0','0','0','0','100','0'),
('287010','4','1415.63','5860.13','13.0192','0','8000','0','0','100','0');

DELETE FROM creature_addon WHERE guid IN (28700);
INSERT INTO creature_addon VALUES
('28700','0','0','1','0','0','');


DELETE FROM creature_addon WHERE guid IN (56807,56808,56809,56816,56817);
INSERT INTO creature_addon VALUES
('56807','0','0','7','0','0','43167 29266 45459'),
('56808','0','0','7','0','0','43167 29266 45459'),
('56809','0','0','7','0','0','43167 29266 45459'),
('56816','0','0','7','0','0','43167 29266 45459'),
('56817','0','0','7','0','0','43167 29266 45459');

DELETE FROM creature_addon WHERE guid IN (46851,46857,46858);
INSERT INTO creature_addon VALUES
('46851','0','0','0','0','71',''),
('46857','0','0','0','0','71',''),
('46858','0','0','0','0','71','');

UPDATE creature_template SET unit_flags2=1,unit_flags=537166591 WHERE entry = 24576; 
UPDATE creature_template SET unit_flags2=1,unit_flags=537166591 WHERE entry = 25244;
