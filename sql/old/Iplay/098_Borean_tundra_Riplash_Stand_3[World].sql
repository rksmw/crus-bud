DELETE FROM creature_template_addon WHERE entry = 24576;
INSERT INTO creature_template_addon VALUES (24576,0,0,0,1,0,'43167 29266 45459');
UPDATE creature_template SET unit_flags2 = 1,unit_flags=537166591,dynamicflags = 32 WHERE entry = 24576;

DELETE FROM creature_template_addon WHERE entry = 25244;
INSERT INTO creature_template_addon VALUES (25244,0,0,0,1,0,'43167 29266 45459');
UPDATE creature_template SET unit_flags2 = 1,unit_flags=537166591,dynamicflags = 32 WHERE entry = 25244;

UPDATE creature SET spawndist='5',movementtype='2' WHERE guid IN (28703);

DELETE FROM creature_addon WHERE guid IN (28703);
INSERT INTO creature_addon VALUES
('28703','287030','0','0','0','0','');

DELETE FROM `waypoint_data` WHERE id IN (287030);
insert into `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) values
('287030','1','1328.42','5813.82','6.05378','0','8000','0','0','100','0'),
('287030','2','1331.65','5820.03','6.44478','0','0','0','0','100','0'),
('287030','3','1338.16','5832.42','8.37066','0','0','0','0','100','0'),
('287030','4','1343.36','5841.54','8.95354','0','0','0','0','100','0'),
('287030','5','1352.86','5851.38','10.8941','0','0','0','0','100','0'),
('287030','6','1363.06','5853.81','11.3498','0','0','0','0','100','0'),
('287030','7','1373.47','5855.16','13.4576','0','0','0','0','100','0'),
('287030','8','1381.19','5855.8','15.0468','0','8000','0','0','100','0');


UPDATE creature SET spawndist='5',movementtype='2' WHERE guid IN (28697);

DELETE FROM creature_addon WHERE guid IN (28697);
INSERT INTO creature_addon VALUES
('28697','286970','0','0','0','0','');

DELETE FROM `waypoint_data` WHERE id IN (286970);
insert into `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) values
('286970','1','1404.95','5730.25','23.6008','0','8000','0','0','100','0'),
('286970','2','1412.33','5722.79','23.6027','0','0','0','0','100','0'),
('286970','3','1423.13','5715.13','23.6013','0','0','0','0','100','0'),
('286970','4','1435.81','5713.76','23.6013','0','0','0','0','100','0'),
('286970','5','1445.36','5715.31','23.6013','0','0','0','0','100','0'),
('286970','6','1455.56','5717.78','23.6013','0','0','0','0','100','0'),
('286970','7','1462.96','5720.13','23.6013','0','0','0','0','100','0'),
('286970','8','1468.8','5725.13','23.6013','0','0','0','0','100','0'),
('286970','9','1470.48','5731.9','23.6013','0','0','0','0','100','0'),
('286970','10','1468','5738.4','23.6013','0','0','0','0','100','0'),
('286970','11','1462.1','5744.18','23.6013','0','8000','0','0','100','0');

UPDATE creature SET spawndist='5',movementtype='2' WHERE guid IN (54496);

DELETE FROM creature_addon WHERE guid IN (54496);
INSERT INTO creature_addon VALUES
('54496','544960','0','0','0','0','');

DELETE FROM `waypoint_data` WHERE id IN (544960);


insert into `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) values
('544960','1','1421.5','5722.6','23.6502','0','8000','0','0','100','0'),
('544960','2','1424.52','5729.29','21.7237','0','0','0','0','100','0'),
('544960','3','1425.02','5732.83','20.4579','0','0','0','0','100','0'),
('544960','4','1421.21','5739.55','17.7666','0','0','0','0','100','0'),
('544960','5','1416.5','5740.76','16.1022','0','0','0','0','100','0'),
('544960','6','1412.5','5740.29','14.9301','0','0','0','0','100','0'),
('544960','7','1409.14','5735.98','13.3096','0','0','0','0','100','0'),
('544960','8','1406.52','5729.26','10.7883','0','0','0','0','100','0'),
('544960','9','1407.71','5727.12','9.92771','0','0','0','0','100','0'),
('544960','10','1409.79','5724.03','8.82229','0','0','0','0','100','0'),
('544960','11','1414.53','5722.01','7.12927','0','0','0','0','100','0'),
('544960','12','1418.72','5721.94','5.62906','0','0','0','0','100','0'),
('544960','13','1427.55','5721.62','3.57918','0','8000','0','0','100','0');

UPDATE creature SET spawndist='5',movementtype='2' WHERE guid IN (54495);

DELETE FROM creature_addon WHERE guid IN (54495);
INSERT INTO creature_addon VALUES
('54495','544950','0','0','0','0','');

DELETE FROM `waypoint_data` WHERE id IN (544950);



insert into `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) values
('544950','1','1413.85','5781.66','23.6012','0','8000','0','0','100','0'),
('544950','2','1409.81','5793.4','23.6012','0','0','0','0','100','0'),
('544950','3','1415.79','5802.94','23.6012','0','0','0','0','100','0'),
('544950','4','1425.55','5806.47','23.6012','0','0','0','0','100','0'),
('544950','5','1440.2','5807.31','25.7005','0','0','0','0','100','0'),
('544950','6','1451.72','5807.02','28.7603','0','0','0','0','100','0'),
('544950','7','1456.64','5804.65','28.7906','0','0','0','0','100','0'),
('544950','8','1461.9','5798.27','28.7906','0','0','0','0','100','0'),
('544950','9','1461.01','5788.75','28.7906','0','0','0','0','100','0'),
('544950','10','1457.49','5783.4','28.7906','0','8000','0','0','100','0');


UPDATE creature SET spawndist='5',movementtype='2' WHERE guid IN (28696);

DELETE FROM creature_addon WHERE guid IN (28696);
INSERT INTO creature_addon VALUES
('28696','286960','0','0','0','0','');

DELETE FROM `waypoint_data` WHERE id IN (286960);

insert into `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) values
('286960','1','1483.4','5745.11','23.6014','0','8000','0','0','100','0'),
('286960','2','1484.73','5749.73','22.2859','0','0','0','0','100','0'),
('286960','3','1486.71','5757.36','18.8093','0','0','0','0','100','0'),
('286960','4','1488','5765.78','15.2485','0','0','0','0','100','0'),
('286960','5','1488','5769.95','13.6415','0','0','0','0','100','0'),
('286960','6','1485.35','5776.29','9.92873','0','0','0','0','100','0'),
('286960','7','1481.13','5784.66','4.4025','0','0','0','0','100','0'),
('286960','8','1480','5786.65','4.21296','0','8000','0','0','100','0');

UPDATE creature SET spawndist='5',movementtype='2' WHERE guid IN (54497);

DELETE FROM creature_addon WHERE guid IN (54497);
INSERT INTO creature_addon VALUES
('54497','544970','0','0','0','0','');

DELETE FROM `waypoint_data` WHERE id IN (544970);

insert into `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) values
('544970','1','1428.22','5795.39','2.06974','0','8000','0','0','100','0'),
('544970','2','1419.52','5789.53','2.06373','0','0','0','0','100','0'),
('544970','3','1410.41','5786.24','2.98377','0','0','0','0','100','0'),
('544970','4','1406.68','5782.56','3.16753','0','0','0','0','100','0'),
('544970','5','1406.59','5778.54','2.72755','0','0','0','0','100','0'),
('544970','6','1408.28','5773.03','2.07065','0','0','0','0','100','0'),
('544970','7','1406.34','5766.31','1.9688','0','0','0','0','100','0'),
('544970','8','1404.64','5750.87','2.83026','0','8000','0','0','100','0');

UPDATE creature SET spawndist='5',movementtype='2' WHERE guid IN (54499);

DELETE FROM creature_addon WHERE guid IN (54499);
INSERT INTO creature_addon VALUES
('54499','544990','0','0','0','0','');

DELETE FROM `waypoint_data` WHERE id IN (544990);



insert into `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) values
('544990','1','1461.28','5741.03','1.55504','0','8000','0','9000000','30','0'),
('544990','2','1461.28','5741.03','1.55504','0','8000','0','9000001','30','0'),
('544990','3','1461.28','5741.03','1.55504','0','8000','0','9000002','30','0');

DELETE FROM waypoint_scripts WHERE guid IN (9000000,9000001);
INSERT INTO waypoint_scripts VALUES (9000000,1,1,1,0,0,0,0,0,0,'9000000');
INSERT INTO waypoint_scripts VALUES (9000001,1,1,25,0,0,0,0,0,0,'9000001');

UPDATE creature SET spawndist='5',movementtype='2' WHERE guid IN (54498);

DELETE FROM creature_addon WHERE guid IN (54498);
INSERT INTO creature_addon VALUES
('54498','544980','0','0','0','0','');


DELETE FROM `waypoint_data` WHERE id IN (544980);


insert into `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) values
('544980','1','1468.63','5745.18','1.98743','0','8000','0','9000002','30','0'),
('544980','2','1468.63','5745.18','1.98743','0','8000','0','9000000','30','0'),
('544980','3','1468.63','5745.18','1.98743','0','8000','0','9000001','30','0');

UPDATE creature SET spawndist='5',movementtype='2' WHERE guid IN (28693);

DELETE FROM creature_addon WHERE guid IN (28693);
INSERT INTO creature_addon VALUES
('28693','286930','0','0','0','0','');

DELETE FROM `waypoint_data` WHERE id IN (286930);

insert into `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) values
('286930','1','1304.05','5584.58','5.33791','0','0','0','0','100','0'),
('286930','2','1311.94','5594.28','5.51546','0','0','0','0','100','0'),
('286930','3','1327.8','5613.6','5.32575','0','0','0','0','100','0'),
('286930','4','1347.58','5637.79','5.39711','0','0','0','0','100','0'),
('286930','5','1359.42','5652.33','5.93104','0','0','0','0','100','0'),
('286930','6','1370.86','5666.39','5.97328','0','0','0','0','100','0');

UPDATE creature SET spawndist='5',movementtype='2' WHERE guid IN (28691);

DELETE FROM creature_addon WHERE guid IN (28691);
INSERT INTO creature_addon VALUES
('28691','286910','0','0','0','0','');


DELETE FROM `waypoint_data` WHERE id IN (286910);

insert into `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) values
('286910','1','1305.68','5545.58','5.55033','0','0','0','0','100','0'),
('286910','2','1320.13','5533.63','5.32183','0','0','0','0','100','0'),
('286910','3','1334.98','5522.23','5.32887','0','0','0','0','100','0'),
('286910','4','1356.13','5508.9','5.39291','0','0','0','0','100','0'),
('286910','5','1377.49','5495.91','5.26372','0','0','0','0','100','0'),
('286910','6','1383.51','5492.3','5.71012','0','0','0','0','100','0');

DELETE FROM creature_addon WHERE guid IN (28689,28687);
INSERT INTO creature_addon VALUES
('28689','0','0','8','0','0',''),
('28687','0','0','8','0','0','');

DELETE FROM creature_addon WHERE guid IN (55335,112683);
INSERT INTO creature_addon VALUES
('55335','0','0','0','0','4',''),
('112683','0','0','0','0','4','');
