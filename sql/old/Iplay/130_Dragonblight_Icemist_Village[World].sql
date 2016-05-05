UPDATE creature SET spawndist='5',movementtype='2' WHERE guid IN (118379);

DELETE FROM creature_addon WHERE guid IN (118379);
INSERT INTO creature_addon VALUES
('118379','1183790','0','0','0','0','');


DELETE FROM waypoint_data WHERE id = 1183790;
insert into `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) values
('1183790','1','3843.48','1989.52','116.648','0','0','0','0','100','0'),
('1183790','2','3846.11','1998.84','120.054','0','0','0','0','100','0'),
('1183790','3','3849.81','2010.78','123.852','0','0','0','0','100','0'),
('1183790','4','3856.42','2028.32','129.604','0','0','0','0','100','0'),
('1183790','5','3861.01','2039.94','132.417','0','0','0','0','100','0'),
('1183790','6','3870.23','2060.1','133.188','0','0','0','0','100','0'),
('1183790','7','3875.16','2067.34','133.185','0','0','0','0','100','0');

UPDATE creature SET spawndist='5',movementtype='2' WHERE guid IN (118392);

DELETE FROM creature_addon WHERE guid IN (118392);
INSERT INTO creature_addon VALUES
('118392','1183920','0','0','0','0','');

DELETE FROM waypoint_data WHERE id = 1183920;
insert into `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) values
('1183920','1','3959.43','2162.69','154.99','0','0','0','0','100','0'),
('1183920','2','3966.13','2163.29','153.402','0','0','0','0','100','0'),
('1183920','3','3971.68','2162.68','151.957','0','0','0','0','100','0'),
('1183920','4','3980.12','2160.21','148.501','0','0','0','0','100','0'),
('1183920','5','3986.49','2157.31','145.079','0','0','0','0','100','0'),
('1183920','6','3991.29','2153.93','142.921','0','0','0','0','100','0'),
('1183920','7','3991.43','2152.04','142.134','0','0','0','0','100','0'),
('1183920','8','3990.52','2143.02','137.682','0','0','0','0','100','0'),
('1183920','9','3988.97','2139.12','135.861','0','0','0','0','100','0'),
('1183920','10','3982.05','2131.17','132.753','0','0','0','0','100','0'),
('1183920','11','3972.68','2126.26','130.671','0','0','0','0','100','0'),
('1183920','12','3965.83','2124.91','131.199','0','0','0','0','100','0'),
('1183920','13','3957.35','2121.37','131.451','0','0','0','0','100','0'),
('1183920','14','3955.71','2120.23','131.391','0','0','0','0','100','0');

UPDATE creature SET spawndist='5',movementtype='2' WHERE guid IN (115437);

DELETE FROM creature_addon WHERE guid IN (115437);
INSERT INTO creature_addon VALUES
('115437','1154370','0','0','0','0','');

DELETE FROM waypoint_data WHERE id = 1154370;


insert into `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) values
('1154370','1','3950','2164.43','156.194','0','0','0','0','100','0'),
('1154370','2','3943','2164.59','156.199','0','0','0','0','100','0'),
('1154370','3','3934.04','2164.98','156.184','0','0','0','0','100','0'),
('1154370','4','3930.19','2168.68','156.156','0','0','0','0','100','0'),
('1154370','5','3929.18','2175.6','155.689','0','0','0','0','100','0'),
('1154370','6','3928.7','2182.58','152.43','0','0','0','0','100','0'),
('1154370','7','3929.1','2186','152.011','0','0','0','0','100','0'),
('1154370','8','3932.93','2191.08','152.011','0','0','0','0','100','0'),
('1154370','9','3939.9','2195.3','152.011','0','0','0','0','100','0'),
('1154370','10','3942.6','2192.5','152.011','0','0','0','0','100','0'),
('1154370','11','3943.43','2186.98','152.011','0','0','0','0','100','0'),
('1154370','12','3939.11','2185.03','152.011','0','0','0','0','100','0'),
('1154370','13','3929.34','2185.35','152.011','0','0','0','0','100','0'),
('1154370','14','3927.77','2182.17','152.011','0','0','0','0','100','0'),
('1154370','15','3928.57','2175.57','155.639','0','0','0','0','100','0'),
('1154370','16','3929.09','2169.55','156.146','0','0','0','0','100','0'),
('1154370','17','3926.12','2165.54','156.023','0','0','0','0','100','0'),
('1154370','18','3922.1','2164.09','155.915','0','0','0','0','100','0'),
('1154370','19','3912.31','2163.38','155.973','0','0','0','0','100','0'),
('1154370','20','3907.97','2160.81','155.983','0','0','0','0','100','0'),
('1154370','21','3908.55','2154.45','155.995','0','0','0','0','100','0'),
('1154370','22','3912.32','2153.09','155.995','0','0','0','0','100','0'),
('1154370','23','3918.81','2153.14','155.952','0','0','0','0','100','0'),
('1154370','24','3926.72','2156.58','155.992','0','0','0','0','100','0'),
('1154370','25','3936.05','2157.99','156.185','0','0','0','0','100','0'),
('1154370','26','3943.02','2158.6','156.183','0','0','0','0','100','0'),
('1154370','27','3949.99','2159.25','156.178','0','0','0','0','100','0');


UPDATE creature SET spawndist='5',movementtype='2' WHERE guid IN (118396);

DELETE FROM creature_addon WHERE guid IN (118396);
INSERT INTO creature_addon VALUES
('118396','1183960','0','0','0','0','');

DELETE FROM waypoint_data WHERE id = 1183960;

insert into `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) values
('1183960','1','4014.34','2210.08','150.998','0','0','0','0','100','0'),
('1183960','2','4007.36','2210.59','151.201','0','0','0','0','100','0'),
('1183960','3','3996.8','2216.5','153.276','0','0','0','0','100','0'),
('1183960','4','3994.92','2221.73','153.483','0','0','0','0','100','0'),
('1183960','5','3992.67','2231.47','153.535','0','0','0','0','100','0'),
('1183960','6','3989.62','2234.54','153.535','0','0','0','0','100','0'),
('1183960','7','3982.92','2236.68','153.582','0','0','0','0','100','0'),
('1183960','8','3978.41','2235.35','153.645','0','0','0','0','100','0'),
('1183960','9','3972.45','2233.95','153.515','0','0','0','0','100','0'),
('1183960','10','3970.1','2231.85','153.432','0','0','0','0','100','0'),
('1183960','11','3967.81','2226.01','153.363','0','0','0','0','100','0'),
('1183960','12','3968.8','2223.27','153.374','0','0','0','0','100','0'),
('1183960','13','3971.83','2218.53','153.649','0','0','0','0','100','0'),
('1183960','14','3976.5','2214.71','153.613','0','0','0','0','100','0'),
('1183960','15','3981.82','2212.87','153.536','0','0','0','0','100','0'),
('1183960','16','3985.78','2214.17','153.509','0','0','0','0','100','0'),
('1183960','17','3988.96','2213.91','153.534','0','0','0','0','100','0'),
('1183960','18','3995.13','2210.84','153.305','0','0','0','0','100','0'),
('1183960','19','4000.73','2209.26','152.548','0','0','0','0','100','0'),
('1183960','20','4008.3','2209.06','151.162','0','0','0','0','100','0'),
('1183960','21','4014.69','2209.66','150.974','0','0','0','0','100','0');

UPDATE creature SET spawndist='5',movementtype='2' WHERE guid IN (118394);

DELETE FROM creature_addon WHERE guid IN (118394);
INSERT INTO creature_addon VALUES
('118394','1183940','0','0','0','0','');

DELETE FROM waypoint_data WHERE id = 1183940;

insert into `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) values
('1183940','1','3986.76','2247.27','153.582','0','0','0','0','100','0'),
('1183940','2','3986.02','2243.85','153.567','0','0','0','0','100','0'),
('1183940','3','3983.45','2234.07','153.542','0','0','0','0','100','0'),
('1183940','4','3978.97','2230.81','153.532','0','0','0','0','100','0'),
('1183940','5','3974.97','2230.54','153.539','0','0','0','0','100','0'),
('1183940','6','3971.25','2233.79','153.476','0','0','0','0','100','0'),
('1183940','7','3970.03','2237.42','153.446','0','0','0','0','100','0'),
('1183940','8','3968.99','2244.34','153.355','0','0','0','0','100','0'),
('1183940','9','3964.82','2256.69','152.636','0','0','0','0','100','0'),
('1183940','10','3962.04','2266.79','152.318','0','0','0','0','100','0'),
('1183940','11','3959.63','2280.58','153.152','0','0','0','0','100','0'),
('1183940','12','3957.54','2290.87','153.957','0','0','0','0','100','0'),
('1183940','13','3955.4','2301.15','153.74','0','0','0','0','100','0'),
('1183940','14','3957.98','2309.35','152.95','0','0','0','0','100','0'),
('1183940','15','3961.36','2310.23','152.913','0','0','0','0','100','0'),
('1183940','16','3967.16','2308.75','153.133','0','0','0','0','100','0'),
('1183940','17','3976.07','2303.21','153.274','0','0','0','0','100','0'),
('1183940','18','3977.4','2302.27','153.289','0','0','0','0','100','0'),
('1183940','19','3984.22','2296.42','153.165','0','0','0','0','100','0'),
('1183940','20','3990.49','2294.56','153.135','0','0','0','0','100','0'),
('1183940','21','3997.48','2294.3','153.148','0','0','0','0','100','0'),
('1183940','22','4007.87','2292.86','153.131','0','0','0','0','100','0'),
('1183940','23','4010.59','2291.39','153.126','0','0','0','0','100','0'),
('1183940','24','4013.16','2287.16','153.08','0','0','0','0','100','0'),
('1183940','25','4012.36','2283.41','153.095','0','0','0','0','100','0'),
('1183940','26','4010.05','2280.75','153.146','0','0','0','0','100','0'),
('1183940','27','4004.28','2276.8','153.48','0','0','0','0','100','0'),
('1183940','28','3998.23','2270.81','153.534','0','0','0','0','100','0'),
('1183940','29','3992.15','2262.26','153.534','0','0','0','0','100','0'),
('1183940','30','3988.36','2255.64','153.529','0','0','0','0','100','0'),
('1183940','31','3987.18','2250.52','153.559','0','0','0','0','100','0'),
('1183940','32','3986.65','2247.06','153.59','0','0','0','0','100','0'),
('1183940','33','3985.85','2240','153.535','0','0','0','0','100','0'),
('1183940','34','3983.9','2235.59','153.565','0','0','0','0','100','0'),
('1183940','35','3981.72','2234.23','153.528','0','0','0','0','100','0'),
('1183940','36','3973.71','2231','153.515','0','0','0','0','100','0'),
('1183940','37','3967.93','2229.94','153.373','0','0','0','0','100','0'),
('1183940','38','3960.99','2228.99','153.891','0','0','0','0','100','0');


UPDATE creature SET spawndist='5',movementtype='2' WHERE guid IN (118388);

DELETE FROM creature_addon WHERE guid IN (118388);
INSERT INTO creature_addon VALUES
('118388','1183880','0','0','0','0','');

DELETE FROM waypoint_data WHERE id = 1183880;

insert into `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) values
('1183880','1','4074.38','2341.53','152.621','0','0','0','0','100','0'),
('1183880','2','4070.79','2334.22','153.646','0','0','0','0','100','0'),
('1183880','3','4068.62','2326.23','154.009','0','0','0','0','100','0'),
('1183880','4','4063.85','2316.91','153.485','0','0','0','0','100','0'),
('1183880','5','4060.25','2310.11','153.117','0','0','0','0','100','0'),
('1183880','6','4057.46','2300.58','153.06','0','0','0','0','100','0'),
('1183880','7','4052.23','2299.39','153.173','0','0','0','0','100','0'),
('1183880','8','4050.31','2301.5','153.056','0','0','0','0','100','0'),
('1183880','9','4047.95','2309.19','153.07','0','0','0','0','100','0'),
('1183880','10','4046.39','2312.33','153.057','0','0','0','0','100','0'),
('1183880','11','4044.16','2317.07','153.112','0','0','0','0','100','0'),
('1183880','12','4045.6','2313.87','153.072','0','0','0','0','100','0'),
('1183880','13','4048.52','2307.51','153.064','0','0','0','0','100','0'),
('1183880','14','4052.27','2301.02','153.056','0','0','0','0','100','0'),
('1183880','15','4056.47','2299.33','153.163','0','0','0','0','100','0'),
('1183880','16','4064.86','2297.98','153.203','0','0','0','0','100','0'),
('1183880','17','4073.7','2294.5','153.14','0','0','0','0','100','0'),
('1183880','18','4075.29','2293.14','153.114','0','0','0','0','100','0'),
('1183880','19','4082.12','2285.16','153.067','0','0','0','0','100','0'),
('1183880','20','4086.52','2280.71','153.085','0','0','0','0','100','0'),
('1183880','21','4092.56','2279.82','153.068','0','0','0','0','100','0'),
('1183880','22','4095.9','2280.31','153.067','0','0','0','0','100','0'),
('1183880','23','4091.87','2280.07','153.067','0','0','0','0','100','0'),
('1183880','24','4084.07','2281.66','153.085','0','0','0','0','100','0'),
('1183880','25','4080.78','2285.24','153.067','0','0','0','0','100','0'),
('1183880','26','4074.44','2294.03','153.12','0','0','0','0','100','0'),
('1183880','27','4067.29','2297.58','153.165','0','0','0','0','100','0'),
('1183880','28','4061.13','2300.16','153.066','0','0','0','0','100','0'),
('1183880','29','4058.49','2305.65','152.978','0','0','0','0','100','0'),
('1183880','30','4059.18','2309.28','153.077','0','0','0','0','100','0'),
('1183880','31','4063.63','2318.09','153.502','0','0','0','0','100','0'),
('1183880','32','4068.26','2323.71','153.881','0','0','0','0','100','0'),
('1183880','33','4070.35','2330.39','154.05','0','0','0','0','100','0'),
('1183880','34','4072.89','2336.91','153.328','0','0','0','0','100','0');

UPDATE creature SET spawndist = 10 WHERE guid IN (118373,118371,118386,118397,118336,118395,118384,118345,118387,118341,118346);

DELETE FROM `creature` WHERE `guid` IN (2000037,2000038,2000039,2000040,2000041);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
('2000037','26606','571','1','1','25239','0','3890.3','2255.57','123.567','2.47263','300','10','0','9291','0','1','0','0','0'),
('2000038','26606','571','1','1','25239','0','3883.48','2215.42','123.153','3.53684','300','10','0','9610','0','1','0','0','0'),
('2000039','26606','571','1','1','25239','0','3865.75','2248.72','121.549','1.27647','300','10','0','9610','0','1','0','0','0'),
('2000040','26606','571','1','1','25239','0','3878.59','2290.93','121.825','0.225603','300','10','0','9610','0','1','0','0','0'),
('2000041','26606','571','1','1','25239','0','3855.76','2295.22','122.803','4.67723','300','10','0','9291','0','1','0','0','0');

UPDATE creature_template SET scriptname = 'npc_rabid_grizzly' WHERE entry = 26643;
UPDATE creature_template SET scriptname = 'npc_blighted_elk' WHERE entry = 26616;
UPDATE creature_template SET scriptname = 'npc_anubar_slayer' WHERE entry = 26606;