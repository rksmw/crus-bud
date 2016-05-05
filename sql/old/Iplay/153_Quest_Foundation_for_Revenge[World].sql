-- Quest - Foundation for Revenge
DELETE FROM `creature` WHERE `id` IN (28748,28747,28719);
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `curhealth`, `curmana`, `spawndist`, `MovementType`) VALUES
(28719,571,1,2,5746.94, -4236.17, 363.731, 1.46001,600,8800,8139,0,0),
(28719,571,1,2,5683.05, -4232.75, 363.563, 1.6328,600,8800,8139,0,0),
(28719,571,1,2,5578.58, -4459.31, 374.465, 6.14491,600,8800,8139,0,0),
(28719,571,1,2,5853.1, -4420.86, 375.206, 2.93892,600,8800,8139,0,0),
(28719,571,1,2,5775.62, -4362.06, 386.486, 4.81366,600,8800,8139,0,0),
(28719,571,1,2,5826.17, -4300.7, 374.071, 3.05672,600,8800,8139,0,0),
(28719,571,1,2,5624.92, -4287.33, 373.996, 4.79245,600,8800,8139,0,0),
(28719,571,1,2,5693.62, -4291.43, 374.028, 4.78853,600,8800,8139,0,0),
(28719,571,1,2,5741.22, -4290.42, 374.046, 4.69036,600,8800,8139,0,0),
(28747,571,1,2,5674.59,-4307.57,373.995,3.23747,600,8800,8139,10,1),
(28747,571,1,2,5647.31,-4303.52,373.995,2.994,600,8800,8139,10,1),
(28747,571,1,2,5618.43,-4315,373.995,3.55556,600,8800,8139,10,1),
(28747,571,1,2,5590.74,-4316.08,374.263,2.82514,600,8800,8139,10,1),
(28747,571,1,2,5749.56,-4299.13,373.994,0.135147,600,8800,8139,10,1),
(28747,571,1,2,5773.08,-4300.38,373.994,5.70755,600,8800,8139,10,1),
(28747,571,1,2,5795.86,-4315.17,374.094,5.83714,600,8800,8139,10,1),
(28747,571,1,2,5826.84,-4313.33,373.996,5.67613,600,8800,8139,10,1),
(28747,571,1,2,5837.81,-4337.97,373.996,5.87641,600,8800,8139,10,1),
(28747,571,1,2,5741.7,-4224.71,362.833,5.97458,600,8800,8139,10,1),
(28747,571,1,2,5669.66,-4215.96,362.748,3.46131,600,8800,8139,10,1),
(28747,571,1,2,5644.27,-4226.31,362.752,2.21645,600,8800,8139,10,1),
(28747,571,1,2,5778.74,-4222.6,360.19,5.32663,600,8800,8139,10,1),
(28747,571,1,2,5796.52,-4243.61,362.668,6.12381,600,8800,8139,10,1),
(28747,571,1,2,5814.23,-4237.75,363.447,1.44676,600,8800,8139,10,1),
(28747,571,1,2,5803.24,-4264.43,371.075,5.55047,600,8800,8139,10,1),
(28747,571,1,2,5617.58,-4210.75,364.287,3.46131,600,8800,8139,10,1),
(28747,571,1,2,5591.48,-4222.92,367.94,3.17856,600,8800,8139,10,1),
(28747,571,1,2,5582.1,-4215.94,368.512,1.69809,600,8800,8139,10,1),
(28747,571,1,2,5743.5,-4311.48,374.018,1.33287,600,8800,8139,10,1),
(28747,571,1,2,5692.38,-4315.48,375.065,1.62347,600,8800,8139,10,1),
(28747,571,1,2,5665.15,-4290.69,373.995,0.213681,600,8800,8139,10,1),
(28748,571,1,2,5590.73,-4353.75,374.186,1.52529,600,11001,0,0,0),
(28748,571,1,2,5840.61,-4363.09,373.995,1.61169,600,11001,0,0,0),
(28748,571,1,2,5732.51,-4262.55,374.759,3.19427,600,11001,0,0,0),
(28748,571,1,2,5701.31,-4262.18,373.996,0.00162315,600,11001,0,0,0);

DELETE FROM `gameobject` WHERE `id`=190707 AND `phaseMask`=2;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(NULL, 190707, 571, 1, 2, 5746.94, -4236.17, 363.731, 1.46001, 0, 0, 0.666873, 0.745171, 300, 0, 1),
(NULL, 190707, 571, 1, 2, 5683.05, -4232.75, 363.563, 1.6328, 0, 0, 0.728685, 0.684849, 300, 0, 1),
(NULL, 190707, 571, 1, 2, 5578.58, -4459.31, 374.465, 6.14491, 0, 0, 0.0690827, -0.997611, 300, 0, 1),
(NULL, 190707, 571, 1, 2, 5853.1, -4420.86, 375.206, 2.93892, 0, 0, 0.99487, 0.101163, 300, 0, 1),
(NULL, 190707, 571, 1, 2, 5775.62, -4362.06, 386.486, 4.81366, 0, 0, 0.670411, -0.74199, 300, 0, 1),
(NULL, 190707, 571, 1, 2, 5826.17, -4300.7, 374.071, 3.05672, 0, 0, 0.9991, 0.0424236, 300, 0, 1),
(NULL, 190707, 571, 1, 2, 5624.92, -4287.33, 373.996, 4.79245, 0, 0, 0.678242, -0.734839, 300, 0, 1),
(NULL, 190707, 571, 1, 2, 5693.62, -4291.43, 374.028, 4.78853, 0, 0, 0.679681, -0.733508, 300, 0, 1),
(NULL, 190707, 571, 1, 2, 5741.22, -4290.42, 374.046, 4.69036, 0, 0, 0.714852, -0.699276, 300, 0, 1);

-- Soul Font Void Zone SAI
UPDATE `creature_template` SET `AIName`='SmartAI', `flags_extra`=flags_extra|128, `faction_A`=2073, `faction_H`=2073 WHERE `entry`=28719;
DELETE FROM `smart_scripts` WHERE `entryorguid`=28719 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(28719,0,0,0,25,0,100,0,0,0,0,0,11,52222,2,0,0,0,0,1,0,0,0,0,0,0,0,'Soul Font Void Zone - Reset - Cast Soul Font Void'),
(28719,0,1,0,25,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Soul Font Void Zone - Reset - React Passive');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=52242;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`comment`) VALUES
(13,1,52242,0,31,0,3,28719,'Soul Font Void Channel - Implicit Target - Soul Font Void Zone');

-- Quetz'lun Worshipper
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_A`=2069, `faction_H`=2069 WHERE `entry`=28747;
DELETE FROM `smart_scripts` WHERE `entryorguid`=28747 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(28747,0,0,0,25,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Quetz''lun Worshipper - Reset - Set phase 1'),
(28747,0,1,0,23,1,100,0,54601,1,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Quetz''lun Worshipper - Has Aura - Set phase 2'),
(28747,0,2,0,23,2,100,0,54601,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Quetz''lun Worshipper - Missing Aura - Set phase 1'),
(28747,0,3,0,0,0,100,0,14000,21000,21000,28000,11,54601,0,0,0,0,0,1,0,0,0,0,0,0,0,'Quetz''lun Worshipper - In combat (phase 1) - Cast Serpent Form'),
(28747,0,4,0,0,2,100,0,10,40,7000,13000,11,54594,0,0,0,0,0,5,0,0,0,0,0,0,0,'Quetz''lun Worshipper - In combat (phase 2) - Cast Serpent Sting'),
(28747,0,5,6,6,0,100,0,0,0,0,0,33,28713,0,0,0,0,0,7,0,0,0,0,0,0,0,'Quetz''lun Worshipper - Death - Give kill credit (see conditions)'),
(28747,0,6,0,61,0,100,0,0,0,0,0,11,52242,3,0,0,0,0,19,28719,20,0,0,0,0,0,'Quetz''lun Worshipper - Death - Cast Soul Font Void Channel (see conditions)');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=28747 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`comment`) VALUES
(22,6,28747,0,1,1,52222,0,'Quetz''lun Worshipper - Activate SAI if Soul Font Aura'),
(22,7,28747,0,1,1,52222,0,'Quetz''lun Worshipper - Activate SAI if Soul Font Aura');

-- Serpent Touched Berserker
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_A`=2069, `faction_H`=2069 WHERE `entry`=28748;
DELETE FROM `smart_scripts` WHERE `entryorguid`=28748 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(28748,0,0,0,0,0,100,0,10,40,7000,13000,11,54594,0,0,0,0,0,5,0,0,0,0,0,0,0,'Serpent Touched Berserker - In combat - Cast Serpent Strike'),
(28748,0,1,2,6,0,100,0,0,0,0,0,33,28713,0,0,0,0,0,7,0,0,0,0,0,0,0,'Serpent Touched Berserker - Death - Give kill credit (see conditions)'),
(28748,0,2,0,61,0,100,0,0,0,0,0,11,52242,3,0,0,0,0,19,28719,20,0,0,0,0,0,'Serpent Touched Berserker - Death - Cast Soul Font Void Channel (see conditions)');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=28748 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`comment`) VALUES
(22,2,28748,0,1,1,52222,0,'Serpent Touched Berserker - Activate SAI if Soul Font Aura'),
(22,3,28748,0,1,1,52222,0,'Serpent Touched Berserker - Activate SAI if Soul Font Aura');
