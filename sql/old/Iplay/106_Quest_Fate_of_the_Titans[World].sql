-- Quest - Fate of the Titans
SET @TOI := 30315;
SET @TOL := 30316;
SET @TOW := 30317;
SET @TOO := 30318;
SET @DATABANK :=30313;
DELETE FROM `creature` WHERE `id` IN (@TOI,@TOW,@TOO);
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `curhealth`) VALUES
(30315,571,1,1,7865.31,-1397.33,1538.9807,3.24141,600,1),
(30317,571,1,1,7498.68,-1899.41,1473.61,0.132902,600,1),
(30318,571,1,1,8193.98,-1963.11,1738.48,5.06746,600,1);

UPDATE `creature_template` SET `AIName`='SmartAI', `InhabitType`=4 WHERE `entry`=@DATABANK;
UPDATE `creature_template` SET `AIName`='', `modelid1`=11686 WHERE `entry` IN (@TOI,@TOL,@TOW,@TOO);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@DATABANK,@TOI,@TOL,@TOW,@TOO) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@DATABANK,0,0,0,10,0,100,1,1,30,0,0,53,1,@DATABANK*10,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Data set - Waypoint start'),
(@DATABANK,0,1,0,10,0,100,1,1,30,0,0,53,1,@DATABANK*10+1,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Data set - Waypoint start'),
(@DATABANK,0,2,0,10,0,100,1,1,30,0,0,53,1,@DATABANK*10+2,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Data set - Waypoint start'),
(@DATABANK,0,3,0,10,0,100,1,1,30,0,0,53,1,@DATABANK*10+3,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Data set - Waypoint start'),
(@DATABANK,0,4,30,40,0,100,0,1,@DATABANK*10,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Say text'),
(@DATABANK,0,5,30,40,0,100,0,2,@DATABANK*10,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Say text'),
(@DATABANK,0,6,30,40,0,100,0,3,@DATABANK*10,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Say text'),
(@DATABANK,0,7,30,40,0,100,0,4,@DATABANK*10,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Say text'),
(@DATABANK,0,8,9,40,0,100,0,5,@DATABANK*10,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Say text'),
(@DATABANK,0,9,31,61,0,100,0,1,0,0,0,33,@TOI,0,0,0,0,0,23,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Give credit'),
(@DATABANK,0,10,30,40,0,100,0,1,@DATABANK*10+1,0,0,1,10,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Say text'),
(@DATABANK,0,11,30,40,0,100,0,2,@DATABANK*10+1,0,0,1,11,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Say text'),
(@DATABANK,0,12,30,40,0,100,0,3,@DATABANK*10+1,0,0,1,12,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Say text'),
(@DATABANK,0,13,30,40,0,100,0,4,@DATABANK*10+1,0,0,1,13,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Say text'),
(@DATABANK,0,14,0,40,0,100,0,5,@DATABANK*10+1,0,0,54,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Pause waypoint'),
(@DATABANK,0,15,16,40,0,100,0,6,@DATABANK*10+1,0,0,1,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Say text'),
(@DATABANK,0,16,31,61,0,100,0,1,0,0,0,33,@TOL,0,0,0,0,0,23,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Give credit'),
(@DATABANK,0,17,30,40,0,100,0,1,@DATABANK*10+2,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Say text'),
(@DATABANK,0,18,30,40,0,100,0,2,@DATABANK*10+2,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Say text'),
(@DATABANK,0,19,30,40,0,100,0,3,@DATABANK*10+2,0,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Say text'),
(@DATABANK,0,20,30,40,0,100,0,4,@DATABANK*10+2,0,0,1,8,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Say text'),
(@DATABANK,0,21,22,40,0,100,0,5,@DATABANK*10+2,0,0,1,9,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Say text'),
(@DATABANK,0,22,31,61,0,100,0,1,0,0,0,33,@TOW,0,0,0,0,0,23,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Give credit'),
(@DATABANK,0,23,30,40,0,100,0,1,@DATABANK*10+3,0,0,1,15,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Say text'),
(@DATABANK,0,24,0,40,0,100,0,2,@DATABANK*10+3,0,0,54,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Pause waypoint'),
(@DATABANK,0,25,30,40,0,100,0,3,@DATABANK*10+3,0,0,1,16,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Say text'),
(@DATABANK,0,26,30,40,0,100,0,4,@DATABANK*10+3,0,0,1,17,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Say text'),
(@DATABANK,0,27,0,40,0,100,0,5,@DATABANK*10+3,0,0,54,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Pause waypoint'),
(@DATABANK,0,28,29,40,0,100,0,6,@DATABANK*10+3,0,0,1,18,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Say text'),
(@DATABANK,0,29,31,61,0,100,0,1,0,0,0,33,@TOO,0,0,0,0,0,23,0,0,0,0,0,0,0,'Mobile Databank - Waypoint reached - Give credit'),
(@DATABANK,0,30,0,61,0,100,0,1,0,0,0,54,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Link - Wp pause'),
(@DATABANK,0,31,0,61,0,100,0,1,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mobile Databank - Link - Despawn');

DELETE FROM `creature_text` WHERE `entry`=@DATABANK;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@DATABANK,0,0,"Temple of Invention analysis commencing.",12,0,100,0,0,0,'Mobile Databank'),
(@DATABANK,1,0,"Temple of Invention verified to be in-tact.",12,0,100,0,0,0,'Mobile Databank'),
(@DATABANK,2,0,"Mechanical servants appear to have turned against each other. Several attendants have been piled together in an unorganized manner.",12,0,100,0,0,0,'Mobile Databank'),
(@DATABANK,3,0,"Remaining mechagnome guardians corrupted by unknown source.",12,0,100,0,0,0,'Mobile Databank'),
(@DATABANK,4,0,"Watcher Mimir verified to no longer be present. Analysis complete.",12,0,100,0,0,0,'Mobile Databank'),
(@DATABANK,5,0,"Temple of Winter analysis commencing.",12,0,100,0,0,0,'Mobile Databank'),
(@DATABANK,6,0,"Temple of Winter verified to be in-tact.",12,0,100,0,0,0,'Mobile Databank'),
(@DATABANK,7,0,"Temple guardians verified to be deceased. Sulfurous odor suggests that death resulted from a fire-base entity.",12,0,100,0,0,0,'Mobile Databank'),
(@DATABANK,8,0,"Previously established cold weather patterns at the temple have ceased.",12,0,100,0,0,0,'Mobile Databank'),
(@DATABANK,9,0,"Watcher Hodir verified to no longer be present. Analysis complete.",12,0,100,0,0,0,'Mobile Databank'),
(@DATABANK,10,0,"Temple of Life analysis commencing.",12,0,100,0,0,0,'Mobile Databank'),
(@DATABANK,11,0,"Temple of Life verified to be damaged beyond repair.",12,0,100,0,0,0,'Mobile Databank'),
(@DATABANK,12,0,"Evidence indicates a significant battle. The opponent of Watcher Freya estimated to be of similar size and strength to Watcher Freya.",12,0,100,0,0,0,'Mobile Databank'),
(@DATABANK,13,0,"Temple guardians are no longer present. Plant forms associated with temple are deceased.",12,0,100,0,0,0,'Mobile Databank'),
(@DATABANK,14,0,"Watcher Freya verified to no longer be present. Analysis complete.",12,0,100,0,0,0,'Mobile Databank'),
(@DATABANK,15,0,"Temple of Order analysis commencing.",12,0,100,0,0,0,'Mobile Databank'),
(@DATABANK,16,0,"Temple of Order verified to be in-tact.",12,0,100,0,0,0,'Mobile Databank'),
(@DATABANK,17,0,"No indications of struggle are present. No guardians are present.",12,0,100,0,0,0,'Mobile Databank'),
(@DATABANK,18,0,"Watcher Tyr verified to no longer be present. Analysis complete.",12,0,100,0,0,0,'Mobile Databank');

DELETE FROM `waypoints` WHERE `entry` IN (@DATABANK*10,@DATABANK*10+1,@DATABANK*10+2,@DATABANK*10+3);
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@DATABANK*10,1,7889.698730,-1422.075317,1537.703491,'Mobile Databank - Temple of Invention'),
(@DATABANK*10,2,7873.547363,-1367.841064,1538.062988,'Mobile Databank - Temple of Invention'),
(@DATABANK*10,3,7917.167480,-1383.291382,1535.767456,'Mobile Databank - Temple of Invention'),
(@DATABANK*10,4,7880.887207,-1338.509766,1538.609741,'Mobile Databank - Temple of Invention'),
(@DATABANK*10,5,7869.540039,-1397.216797,1538.340942,'Mobile Databank - Temple of Invention'),
(@DATABANK*10+1,1,7992.439453,-2729.762207,1140.433838,'Mobile Databank - Temple of Life'),
(@DATABANK*10+1,2,7935.468750,-2748.708008,1149.798950,'Mobile Databank - Temple of Life'),
(@DATABANK*10+1,3,7961.118652,-2782.997803,1144.777832,'Mobile Databank - Temple of Life'),
(@DATABANK*10+1,4,7997.624023,-2754.529541,1148.756958,'Mobile Databank - Temple of Life'),
(@DATABANK*10+1,5,8020.036133,-2726.028809,1139.847778,'Mobile Databank - Temple of Life'),
(@DATABANK*10+1,6,7992.439453,-2729.762207,1140.433838,'Mobile Databank - Temple of Life'),
(@DATABANK*10+2,1,7506.763184,-1893.311401,1477.985352,'Mobile Databank - Temple of Winter'),
(@DATABANK*10+2,2,7552.986328,-1866.377197,1480.781006,'Mobile Databank - Temple of Winter'),
(@DATABANK*10+2,3,7520.549316,-1864.276001,1477.752563,'Mobile Databank - Temple of Winter'),
(@DATABANK*10+2,4,7504.662109,-1915.706055,1480.331055,'Mobile Databank - Temple of Winter'),
(@DATABANK*10+2,5,7498.573242,-1898.410889,1477.948242,'Mobile Databank - Temple of Winter'),
(@DATABANK*10+3,1,8184.807129,-1957.482788,1741.329346,'Mobile Databank - Temple of Order'),
(@DATABANK*10+3,2,8137.879395,-1992.820923,1776.828491,'Mobile Databank - Temple of Order'),
(@DATABANK*10+3,3,8148.433594,-1983.176147,1744.715332,'Mobile Databank - Temple of Order'),
(@DATABANK*10+3,4,8245.577148,-1980.172607,1741.913940,'Mobile Databank - Temple of Order'),
(@DATABANK*10+3,5,8211.146484,-1911.536621,1741.870239,'Mobile Databank - Temple of Order'),
(@DATABANK*10+3,6,8194.274414,-1963.122681,1740.541870,'Mobile Databank - Temple of Order');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry` IN (@TOI,@TOL,@TOW,@TOO,@DATABANK) AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`comment`) VALUES
(22,1,@DATABANK,0,31,0,3,@TOI,'Temple of Invention Bunny - Invoker must be Mobile Databank'),
(22,2,@DATABANK,0,31,0,3,@TOL,'Temple of Life Bunny - Invoker must be Mobile Databank'),
(22,3,@DATABANK,0,31,0,3,@TOW,'Temple of Winter Bunny - Invoker must be Mobile Databank'),
(22,4,@DATABANK,0,31,0,3,@TOO,'Temple of Order Bunny - Invoker must be Mobile Databank');

DELETE FROM `creature` WHERE `id`=30881;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(NULL,30881,571,1,1,0,0,7506.89,-1862.58,1474.01,1.23482,300,0,0,6,0,0,0,0,0),
(NULL,30881,571,1,1,0,0,7502.42,-1945.26,1474.26,4.58099,300,0,0,6,0,0,0,0,0),
(NULL,30881,571,1,1,0,0,7473.15,-1935.61,1474.26,0.893541,300,0,0,6,0,0,0,0,0);

DELETE FROM `creature_template_addon` WHERE `entry`=30881;
INSERT INTO `creature_template_addon` (`entry`,`bytes1`) VALUES
(30881,7);
