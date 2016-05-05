-- Quest - Assault by Air
SET @TURRET_A := 32227;
SET @TURRET_H := 31884;
SET @PLANE_A := 32225;
SET @PLANE_H := 31881;
SET @INF_H := 31882;
SET @INF_A := 32222;
SET @SPEAR := 31280;

-- Troop Transports
UPDATE `creature` SET `MovementType`=0, `spawndist`=0, `spawntimesecs`=0 WHERE `id`=@PLANE_H;
DELETE FROM `creature` WHERE `id`=@PLANE_A;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@PLANE_A,571,1,1,0,0,7303.09,1520.76,322.236,3.56024,0,0,0,63000,0,0,0,0,0);

UPDATE `creature_template_addon` SET `auras`='61307' WHERE `entry`=@PLANE_H;
DELETE FROM `creature_template_addon` WHERE `entry`=@PLANE_A;
INSERT INTO `creature_template_addon` (`entry`,`auras`) VALUES
(@PLANE_A, '61307');

UPDATE `vehicle_template_accessory` SET `minion`=1 WHERE `entry` IN (@PLANE_H,@PLANE_A);
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_troop_transport', `InhabitType`=4 WHERE `entry` IN (@PLANE_A,@PLANE_H);

DELETE FROM `waypoint_data` WHERE `id` IN (@PLANE_A,@PLANE_H);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`move_flag`) VALUES
(@PLANE_H,1,7508.197754,1768.132446,378.810120,1),
(@PLANE_H,2,7497.587891,1852.143066,474.770203,1),
(@PLANE_H,3,7484.508301,1910.523682,533.143555,1),
(@PLANE_H,4,7464.937500,1959.833984,608.820251,1),
(@PLANE_H,5,7310.121582,2166.409424,596.744202,1),
(@PLANE_H,6,7236.881348,2199.217529,594.861450,1),
(@PLANE_H,7,7206.767090,2215.892822,612.004150,1),
(@PLANE_H,8,7031.756348,2260.663818,650.179504,1),
(@PLANE_H,9,7015.623535,2244.409424,664.515015,1),
(@PLANE_H,10,7003.405762,2218.664551,676.927917,1),
(@PLANE_H,11,6998.795898,2204.972412,673.728394,1),
(@PLANE_H,12,7086.583008,2167.369873,665.919739,1), -- baja primer infiltrado
(@PLANE_H,13,7178.199707,2149.928711,627.133423,1),
(@PLANE_H,14,7213.365234,2142.867188,609.757202,1),
(@PLANE_H,15,7267.942871,2103.922852,604.519104,1),
(@PLANE_H,16,7300.485352,2055.216553,600.818176,1),
(@PLANE_H,17,7316.083008,1947.026489,589.887512,1),
(@PLANE_H,18,7286.930176,1861.262085,612.999695,1), -- baja el segundo
(@PLANE_H,19,7286.895996,1798.862305,594.897888,1),
(@PLANE_H,20,7268.172363,1780.395508,593.016785,1),
(@PLANE_H,21,7090.528320,1730.489624,594.553711,1),
(@PLANE_H,22,7036.323242,1721.251099,604.364197,1), -- baja el tercero
(@PLANE_H,23,6913.823730,1703.766846,600.880981,1),
(@PLANE_H,24,6846.398438,1714.685303,645.349365,1),
(@PLANE_H,25,6811.934570,1769.093384,650.670837,1),
(@PLANE_H,26,6796.268066,1863.550659,684.542175,1), -- baja el cuarto
(@PLANE_H,27,6765.362305,1874.653809,705.264709,1),
(@PLANE_H,28,6717.525391,1808.388428,688.465515,1),
(@PLANE_H,29,6840.083008,1665.899902,618.585022,1),
(@PLANE_H,30,6979.834473,1620.942505,574.193420,1),
(@PLANE_H,31,7296.093750,1566.257568,431.230438,1),
(@PLANE_H,32,7382.628418,1557.463135,407.077209,1),
(@PLANE_H,33,7446.905762,1580.020508,396.430603,1),
(@PLANE_H,34,7477.147461,1623.954712,389.053375,1),
(@PLANE_H,35,7506.093262,1684.628052,372.976990,1),
(@PLANE_H,36,7505.810059,1707.040039,350.194000,1),
(@PLANE_A,1,7263.323242,1503.869995,352.468781,1),
(@PLANE_A,2,7128.745117,1453.747437,433.246887,1),
(@PLANE_A,3,6899.095703,1418.249268,499.081848,1),
(@PLANE_A,4,6782.458008,1436.193726,596.768555,1),
(@PLANE_A,5,6611.949219,1642.892700,701.295959,1),
(@PLANE_A,6,6537.958496,1880.673462,757.180054,1),
(@PLANE_A,7,6574.211914,1957.098267,775.753418,1),
(@PLANE_A,8,6652.396973,1983.578491,783.272522,1),
(@PLANE_A,9,6796.268066,1863.550659,684.542175,1), -- baja el primero
(@PLANE_A,10,6811.934570,1769.093384,650.670837,1),
(@PLANE_A,11,6846.398438,1714.685303,645.349365,1),
(@PLANE_A,12,6913.823730,1703.766846,600.880981,1),
(@PLANE_A,13,7036.323242,1721.251099,604.364197,1), -- baja el segundo
(@PLANE_A,14,7090.528320,1730.489624,594.553711,1),
(@PLANE_A,15,7268.172363,1780.395508,593.016785,1),
(@PLANE_A,16,7286.895996,1798.862305,594.897888,1),
(@PLANE_A,17,7286.930176,1861.262085,612.999695,1), -- baja el tercero
(@PLANE_A,18,7316.083008,1947.026489,589.887512,1),
(@PLANE_A,19,7300.485352,2055.216553,600.818176,1),
(@PLANE_A,20,7267.942871,2103.922852,604.519104,1),
(@PLANE_A,21,7213.365234,2142.867188,609.757202,1),
(@PLANE_A,22,7178.199707,2149.928711,627.133423,1),
(@PLANE_A,23,7086.583008,2167.369873,665.919739,1), -- baja el cuarto
(@PLANE_A,24,7045.766113,2177.301758,710.336426,1),
(@PLANE_A,25,7013.473633,2237.540527,715.641602,1),
(@PLANE_A,26,7080.154785,2275.579590,688.385986,1),
(@PLANE_A,27,7300.875000,2208.790283,625.089844,1),
(@PLANE_A,28,7490.421875,2048.640625,569.232300,1),
(@PLANE_A,29,7568.714844,1956.525513,531.493347,1),
(@PLANE_A,30,7498.284668,1609.670532,431.385498,1),
(@PLANE_A,31,7325.715332,1524.457397,357.535767,1),
(@PLANE_A,32,7303.09,1520.76,322.236,1);

-- Supression Turrets
UPDATE `creature_template` SET `AIName`='SmartAI', `spell1`=59880, `unit_flags`=unit_flags&~256&~512 WHERE `entry` IN (@TURRET_A,@TURRET_H);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@TURRET_A,@TURRET_H) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@TURRET_A,0,0,0,25,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Skybreaker Suppression Turret - Reset - React passive'),
(@TURRET_A,0,1,0,27,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,@PLANE_A,0,0,0,0,0,0,'Skybreaker Suppression Turret - Passenger Boarded - Set data Skybreaker Troop Transport'),
(@TURRET_A,0,2,0,28,0,100,0,0,0,0,0,45,2,2,0,0,0,0,19,@PLANE_A,0,0,0,0,0,0,'Skybreaker Suppression Turret - Passenger Removed - Set data Skybreaker Troop Transport'),
(@TURRET_A,0,3,0,6,0,100,0,0,0,0,0,45,2,2,0,0,0,0,19,@PLANE_A,0,0,0,0,0,0,'Skybreaker Suppression Turret - Death - Set data Skybreaker Troop Transport'),
(@TURRET_A,0,4,0,38,0,100,0,1,1,0,0,33,32224,0,0,0,0,0,1,0,0,0,0,0,0,0,'Skybreaker Suppression Turret - Data set - Give killcredit'),
(@TURRET_H,0,0,0,25,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Kor''kron Suppression Turret - Reset - React passive'),
(@TURRET_H,0,1,0,27,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,@PLANE_H,0,0,0,0,0,0,'Kor''kron Suppression Turret - Passenger Boarded - Set data Kor''kron Troop Transport'),
(@TURRET_H,0,2,0,28,0,100,0,0,0,0,0,45,2,2,0,0,0,0,19,@PLANE_H,0,0,0,0,0,0,'Kor''kron Suppression Turret - Passenger Removed - Set data Kor''kron Troop Transport'),
(@TURRET_H,0,3,0,6,0,100,0,0,0,0,0,45,2,2,0,0,0,0,19,@PLANE_H,0,0,0,0,0,0,'Kor''kron Suppression Turret - Death - Set data Kor''kron Troop Transport'),
(@TURRET_H,0,4,0,38,0,100,0,1,1,0,0,33,31888,0,0,0,0,0,1,0,0,0,0,0,0,0,'Kor''kron Suppression Turret - Data set - Give killcredit');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry` IN (@TURRET_H,@TURRET_A) AND `SourceId`=0;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=18 AND `SourceGroup` IN (@TURRET_H,@TURRET_A);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTarget`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`Comment`) VALUES
(22,2,@TURRET_H,0,31,4,0,'Kor''kron Suppression Turret - Activate SAI if invoker is a player'),
(22,3,@TURRET_H,0,31,4,0,'Kor''kron Suppression Turret - Activate SAI if invoker is a player'),
(22,2,@TURRET_A,0,31,4,0,'Skybreaker Suppression Turret - Activate SAI if invoker is a player'),
(22,3,@TURRET_A,0,31,4,0,'Skybreaker Suppression Turret - Activate SAI if invoker is a player'),
(18,@TURRET_H,46598,0,9,13310,0,'Kor''kron Suppression Turret - can only be spellclicked with quest active'),
(18,@TURRET_A,46598,0,9,13309,0,'Skybreaker Suppression Turret - can only be spellclicked with quest active');

-- Ymirheim Spear Gun
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`=''/*, `unit_flags`=unit_flags|*/ WHERE `entry`=@SPEAR;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@SPEAR AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@SPEAR,0,0,0,25,0,100,0,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ymirheim Spear Gun - Reset - Root'),
(@SPEAR,0,1,0,10,0,100,0,0,90,3500,3500,11,59894,0,0,0,0,0,7,0,0,0,0,0,0,0,'Ymirheim Spear Gun - Move in LOS - Cast Launch Spear');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@SPEAR AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTarget`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`Comment`) VALUES
(22,2,@SPEAR,0,0,31,3,@TURRET_A,'Ymirheim Spear Gun - Activate SAI if invoker is Suppression Turret'),
(22,2,@SPEAR,1,0,31,3,@TURRET_H,'Ymirheim Spear Gun - Activate SAI if invoker is Suppression Turret');

-- Texts for infiltrators
DELETE FROM `creature_text` WHERE `entry` IN (@INF_H,@INF_A);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@INF_H,0,0,'Destination reached - engaging in scouting mission.',12,0,100,0,0,0,'Kor''kron Infiltrator'),
(@INF_H,0,1,'Dropping. Good luck, boys!',12,0,100,0,0,0,'Kor''kron Infiltrator'),
(@INF_H,0,2,'I''ll kill one just for you.',12,0,100,0,0,0,'Kor''kron Infiltrator'),
(@INF_H,0,3,'This is my stop!',12,0,100,0,0,0,'Kor''kron Infiltrator'),
(@INF_A,0,0,'Destination reached - engaging in scouting mission.',12,0,100,0,0,0,'Skybreaker Infiltrator'),
(@INF_A,0,1,'Jeronimo!',12,0,100,0,0,0,'Skybreaker Infiltrator'),
(@INF_A,0,2,'See you on the battlefield.',12,0,100,0,0,0,'Skybreaker Infiltrator'),
(@INF_A,0,3,'Thanks for the cover!',12,0,100,0,0,0,'Skybreaker Infiltrator');
