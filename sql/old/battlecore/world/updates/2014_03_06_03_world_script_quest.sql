-- Quest - The Hunter and the Prince
SET @ARTHAS := 32326;
SET @ILLIDAN_1 := 31395;
SET @ILLIDAN_2 := 32587;
SET @ILLIDAN_3 := 32588;

DELETE FROM `gameobject` WHERE `id` IN (194023,194024,193980);
INSERT INTO `gameobject` (`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(193980,571,1,1,6381.9,2411.87,475.026,0.087266,0,0,0.0436192,0.999048,120,100,1),
(194023,571,1,1,6356.6,2327.43,473.636,-0.785397,0,0,-0.382683,0.92388,120,100,1),
(194024,571,1,1,6336.14,2360.25,477.015,-2.67035,0,0,-0.972369,0.233447,120,100,1);

UPDATE `creature_template` SET `minlevel`=80, `maxlevel`=80, `unit_class`=2, `spell1`=60617, `spell2`=60644, `spell3`=60672, `spell4`=60642, `VehicleId`=300,  `ScriptName`='npc_prince_arthas_menethil' WHERE `entry`=@ARTHAS;
UPDATE `creature_template` SET `minlevel`=82, `maxlevel`=82, `faction_A`=14, `faction_H`=14, `unit_flags`=unit_flags|256|512, `AIName`='SmartAI', `type_flags`=0, `mindmg`=488, `maxdmg`=642, `dmg_multiplier`=2 WHERE `entry` IN (@ILLIDAN_1,@ILLIDAN_2,@ILLIDAN_3);

DELETE FROM `creature_template_addon` WHERE `entry` IN (@ILLIDAN_1,@ILLIDAN_2,@ILLIDAN_3);
INSERT INTO `creature_template_addon` (`entry`,`bytes1`) VALUES
(@ILLIDAN_1,8),
(@ILLIDAN_2,8),
(@ILLIDAN_3,8);

DELETE FROM `event_scripts` WHERE `id` IN (20722,20723,20724);
INSERT INTO `event_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`x`,`y`,`z`,`o`) VALUES
(20722,0,10,@ILLIDAN_1,120000,6395.85,2413.86,472.9459,3.26765),
(20724,0,10,@ILLIDAN_2,120000,6323.06,2352.97,477.8571,0.57609),
(20723,0,10,@ILLIDAN_3,120000,6348.34,2313.46,475.063,1.04575);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ARTHAS,@ILLIDAN_1,@ILLIDAN_2,@ILLIDAN_3) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ILLIDAN_1*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ILLIDAN_1,0,0,0,54,0,100,0,0,0,0,0,80,@ILLIDAN_1*100,0,0,0,0,0,1,0,0,0,0,0,0,0,"Illidan Stormrage - Just summoned - Run script"),
(@ILLIDAN_1,0,1,0,2,0,100,1,0,50,0,0,11,61101,0,0,0,0,0,2,0,0,0,0,0,0,0,"Illidan Stormrage - At 50% hp - Cast Pierced Heart"),
(@ILLIDAN_1,0,2,0,0,0,100,0,20000,30000,30000,40000,11,60744,0,0,0,0,0,1,0,0,0,0,0,0,0,"Illidan Stormrage - In combat - Cast Inmolation"),
(@ILLIDAN_1,0,3,0,2,0,100,1,0,30,0,0,11,60742,0,0,0,0,0,2,0,0,0,0,0,0,0,"Illidan Stormrage - At 30% hp - Cast Shear"),
(@ILLIDAN_1,0,4,5,6,0,100,0,0,0,0,0,33,32797,0,0,0,0,0,7,0,0,0,0,0,0,0,"Illidan Stormrage - Death - Give killcredit"),
(@ILLIDAN_1,0,5,0,61,0,100,0,0,0,0,0,28,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Illidan Stormrage - Death - Remove all auras to killer"),

(@ILLIDAN_2,0,0,0,54,0,100,0,0,0,0,0,80,@ILLIDAN_1*100,0,0,0,0,0,1,0,0,0,0,0,0,0,"Illidan Stormrage - Just summoned - Run script"),
(@ILLIDAN_2,0,1,0,2,0,100,1,0,50,0,0,11,61101,0,0,0,0,0,2,0,0,0,0,0,0,0,"Illidan Stormrage - At 50% hp - Cast Pierced Heart"),
(@ILLIDAN_2,0,2,0,0,0,100,0,20000,30000,30000,40000,11,60744,0,0,0,0,0,1,0,0,0,0,0,0,0,"Illidan Stormrage - In combat - Cast Inmolation"),
(@ILLIDAN_2,0,3,0,2,0,100,1,0,30,0,0,11,60742,0,0,0,0,0,2,0,0,0,0,0,0,0,"Illidan Stormrage - At 30% hp - Cast Shear"),
(@ILLIDAN_2,0,4,5,6,0,100,0,0,0,0,0,33,32797,0,0,0,0,0,7,0,0,0,0,0,0,0,"Illidan Stormrage - Death - Give killcredit"),
(@ILLIDAN_2,0,5,0,61,0,100,0,0,0,0,0,28,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Illidan Stormrage - Death - Remove all auras to killer"),

(@ILLIDAN_3,0,0,0,54,0,100,0,0,0,0,0,80,@ILLIDAN_1*100,0,0,0,0,0,1,0,0,0,0,0,0,0,"Illidan Stormrage - Just summoned - Run script"),
(@ILLIDAN_3,0,1,0,2,0,100,1,0,50,0,0,11,61101,0,0,0,0,0,2,0,0,0,0,0,0,0,"Illidan Stormrage - At 50% hp - Cast Pierced Heart"),
(@ILLIDAN_3,0,2,0,0,0,100,0,30000,40000,30000,40000,11,60744,0,0,0,0,0,1,0,0,0,0,0,0,0,"Illidan Stormrage - In combat - Cast Inmolation"),
(@ILLIDAN_3,0,3,0,2,0,100,1,0,30,0,0,11,60742,0,0,0,0,0,2,0,0,0,0,0,0,0,"Illidan Stormrage - At 30% hp - Cast Shear"),
(@ILLIDAN_3,0,4,5,6,0,100,0,0,0,0,0,33,32797,0,0,0,0,0,7,0,0,0,0,0,0,0,"Illidan Stormrage - Death - Give killcredit"),
(@ILLIDAN_3,0,5,0,61,0,100,0,0,0,0,0,28,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Illidan Stormrage - Death - Remove all auras to killer"),

(@ILLIDAN_1*100,9,0,0,0,0,100,0,3000,3000,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Illidan Stormrage - Script - Stand up"),
(@ILLIDAN_1*100,9,1,0,0,0,100,0,2000,2000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Illidan Stormrage - Script - Say text"),
(@ILLIDAN_1*100,9,2,0,0,0,100,0,3000,3000,0,0,19,768,0,0,0,0,0,1,0,0,0,0,0,0,0,"Illidan Stormrage - Script - Remove unit flags"),
(@ILLIDAN_1*100,9,3,0,0,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,"Illidan Stormrage - Script - Attack Invoker Vehicle");

DELETE FROM `creature_text` WHERE `entry` IN (@ILLIDAN_1,@ILLIDAN_2,@ILLIDAN_3);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ILLIDAN_1,0,0,'Prepare to die!',12,0,100,0,0,0,'Illidan Stormrage'),
(@ILLIDAN_2,0,0,'Prepare to die!',12,0,100,0,0,0,'Illidan Stormrage'),
(@ILLIDAN_3,0,0,'Prepare to die!',12,0,100,0,0,0,'Illidan Stormrage');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=16 AND `SourceEntry`=@ARTHAS;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry` IN (60602,61622,61625);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(16,0,@ARTHAS,0,0,23,0,4519,0,0,0,0,0,'','Prince Arthas Menethil - Dismount if not in intended area'),
(17,0,60602,0,0,9,0,13361,0,0,0,0,0,'','Arthas 1 can only be casted during quest The Hunter and the Prince'),
(17,0,60602,0,1,9,0,13400,0,0,0,0,0,'','Arthas 1 can only be casted during quest The Hunter and the Prince'),
(17,0,61622,0,0,9,0,13361,0,0,0,0,0,'','Arthas 2 can only be casted during quest The Hunter and the Prince'),
(17,0,61622,0,1,9,0,13400,0,0,0,0,0,'','Arthas 2 can only be casted during quest The Hunter and the Prince'),
(17,0,61625,0,0,9,0,13361,0,0,0,0,0,'','Arthas 3 can only be casted during quest The Hunter and the Prince'),
(17,0,61625,0,1,9,0,13400,0,0,0,0,0,'','Arthas 3 can only be casted during quest The Hunter and the Prince');
