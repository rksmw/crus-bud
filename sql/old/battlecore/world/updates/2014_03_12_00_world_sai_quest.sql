-- Quest - Seeds of Chaos
SET @KERITOSE := 30946;
SET @GRYPHON := 31157;
UPDATE `creature_template` SET `KillCredit2`=31555 WHERE `entry` IN (30949,30951,30952,31556);

-- Keritose Bloodblade
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@KERITOSE;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@KERITOSE AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@KERITOSE,0,0,1,62,0,100,0,10110,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Keritose Bloodblade - Gossip select - Close gossip'),
(@KERITOSE,0,1,0,61,0,100,0,0,0,0,0,85,58698,2,0,0,0,0,7,0,0,0,0,0,0,0,'Keritose Bloodblade - Gossip select - Invoker cast Possessed Skeletal Assault Gryphon');

DELETE FROM `conditions` WHERE SourceTypeOrReferenceId=15 AND `SourceGroup`=10110;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`NegativeCondition`,`Comment`) VALUES
(15,10110,0,9,13172,0,'Keritose Bloodblade - show gossip option if quest taken');

-- Skeletal Assault Gryphon
UPDATE `creature_template` SET `spell1`=59234, `AIName`='SmartAI', `InhabitType`=4, `minlevel`=80, `maxlevel`=80 WHERE `entry`=@GRYPHON;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GRYPHON AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@GRYPHON,0,0,0,54,0,100,0,0,0,0,0,53,1,@GRYPHON,0,0,0,0,1,0,0,0,0,0,0,0,'Skeletal Assault Gryphon - Just summoned - Wp start'),
(@GRYPHON,0,1,0,40,0,100,0,31,@GRYPHON,0,0,28,46598,0,0,0,0,0,1,0,0,0,0,0,0,0,'Skeletal Assault Gryphon - Wp reached - Remove all auras (ejects passenger)');

DELETE FROM `creature_template_addon` WHERE `entry`=@GRYPHON;
INSERT INTO `creature_template_addon` (`entry`,`auras`) VALUES
(@GRYPHON,'61543');

DELETE FROM `waypoints` WHERE `entry`=@GRYPHON;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@GRYPHON,1,8328.704102,2764.168945,681.479553,'Skeletal Assault Gryphon'),
(@GRYPHON,2,8308.695313,2773.304932,678.006836,'Skeletal Assault Gryphon'),
(@GRYPHON,3,8186.210449,2836.978027,633.593262,'Skeletal Assault Gryphon'),
(@GRYPHON,4,8049.098633,2881.939209,574.852051,'Skeletal Assault Gryphon'),
(@GRYPHON,5,7895.332520,2915.461670,529.694336,'Skeletal Assault Gryphon'),
(@GRYPHON,6,7841.274902,2934.906250,533.310242,'Skeletal Assault Gryphon'),
(@GRYPHON,7,7712.708984,3068.145020,573.114197,'Skeletal Assault Gryphon'),
(@GRYPHON,8,7644.754395,3077.704346,586.250854,'Skeletal Assault Gryphon'),
(@GRYPHON,9,7573.662109,3170.573486,605.302063,'Skeletal Assault Gryphon'),
(@GRYPHON,10,7607.303711,3220.425537,598.274597,'Skeletal Assault Gryphon'),
(@GRYPHON,11,7659.294922,3234.992676,614.771362,'Skeletal Assault Gryphon'),
(@GRYPHON,12,7882.351563,3106.616455,628.802856,'Skeletal Assault Gryphon'),
(@GRYPHON,13,7944.329102,3053.440430,610.723816,'Skeletal Assault Gryphon'),
(@GRYPHON,14,8070.692383,2893.190430,569.661987,'Skeletal Assault Gryphon'),
(@GRYPHON,15,8037.223145,2797.625488,556.424805,'Skeletal Assault Gryphon'),
(@GRYPHON,16,7985.161133,2794.082031,554.555847,'Skeletal Assault Gryphon'),
(@GRYPHON,17,7868.267578,2839.815430,529.772583,'Skeletal Assault Gryphon'),
(@GRYPHON,18,7846.604980,2957.712891,555.574585,'Skeletal Assault Gryphon'),
(@GRYPHON,19,7779.000000,3053.523926,591.727966,'Skeletal Assault Gryphon'),
(@GRYPHON,20,7710.270996,3167.041504,591.368774,'Skeletal Assault Gryphon'),
(@GRYPHON,21,7624.066406,3176.405518,602.399048,'Skeletal Assault Gryphon'),
(@GRYPHON,22,7588.322754,3175.473389,594.838806,'Skeletal Assault Gryphon'),
(@GRYPHON,23,7601.885254,3086.471680,576.937317,'Skeletal Assault Gryphon'),
(@GRYPHON,24,7728.193359,3062.774902,574.901917,'Skeletal Assault Gryphon'),
(@GRYPHON,25,7800.225098,2989.222412,555.689880,'Skeletal Assault Gryphon'),
(@GRYPHON,26,7871.064941,2981.032227,569.788635,'Skeletal Assault Gryphon'),
(@GRYPHON,27,8007.921387,2938.057861,567.395935,'Skeletal Assault Gryphon'),
(@GRYPHON,28,8160.476074,2805.577148,599.585693,'Skeletal Assault Gryphon'),
(@GRYPHON,29,8319.831055,2769.323486,668.632263,'Skeletal Assault Gryphon'),
(@GRYPHON,30,8397.631836,2702.275391,659.706604,'Skeletal Assault Gryphon'),
(@GRYPHON,31,8396.804688,2684.489502,658.905884,'Skeletal Assault Gryphon');
