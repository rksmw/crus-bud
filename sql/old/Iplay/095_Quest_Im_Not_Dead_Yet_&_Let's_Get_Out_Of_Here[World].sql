-- Quests - I'm Not Dead Yet! - Let's Get Out of Here!
SET @KAMAROS_1 := 31279;
SET @KAMAROS_64 := 32800;
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_A`=113, `faction_H`=113, `unit_flags`=768 WHERE `entry` IN (@KAMAROS_1,@KAMAROS_64);
DELETE FROM `creature_addon` WHERE `guid`=121631;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@KAMAROS_1,@KAMAROS_64) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@KAMAROS_1,0,0,0,11,0,100,0,0,0,0,0,18,768,0,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Respawn - Set unit flags'),
(@KAMAROS_1,0,1,0,11,0,100,0,0,0,0,0,81,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Respawn - Set questgiver flags'),
(@KAMAROS_1,0,2,0,11,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Respawn - React passive'),
(@KAMAROS_1,0,3,4,19,0,100,0,0,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Quest accept - Remove questgiver flags'),
(@KAMAROS_1,0,4,5,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Father Kamaros - Quest accept - store target'),
(@KAMAROS_1,0,5,0,61,0,100,0,0,0,0,0,1,0,5000,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Quest accept - say text'),
(@KAMAROS_1,0,6,0,52,0,100,0,0,@KAMAROS_1,0,0,1,1,5000,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Text over - Say text'),
(@KAMAROS_1,0,7,8,52,0,100,0,1,@KAMAROS_1,0,0,53,0,@KAMAROS_1,0,0,0,2,1,0,0,0,0,0,0,0,'Father Kamaros - Text over - WP start'),
(@KAMAROS_1,0,8,0,61,0,100,0,0,0,0,0,19,768,0,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Text over - Set faction 113'),
(@KAMAROS_1,0,9,0,40,0,100,0,13,@KAMAROS_1,0,0,15,13221,0,0,0,0,0,12,1,0,0,0,0,0,0,'Father Kamaros - Wp reached - complete quest'),
(@KAMAROS_1,0,10,0,40,0,100,0,13,@KAMAROS_1,0,0,15,13229,0,0,0,0,0,12,1,0,0,0,0,0,0,'Father Kamaros - Wp reached - complete quest'),
(@KAMAROS_1,0,11,0,40,0,100,0,13,@KAMAROS_1,0,0,1,3,5000,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Wp reached - Say text'),
(@KAMAROS_1,0,12,0,52,0,100,0,3,@KAMAROS_1,0,0,1,4,10000,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Text over - Say text'),
(@KAMAROS_1,0,13,0,52,0,100,0,4,@KAMAROS_1,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Text over - Despawn'),
(@KAMAROS_1,0,14,0,4,0,100,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Aggro - Say text'),
(@KAMAROS_1,0,15,0,4,0,100,0,0,0,0,0,11,74973,32,0,0,0,0,12,1,0,0,0,0,0,0,'Father Kamaros - Aggro - Cast Power Word: Fortitude'),
(@KAMAROS_1,0,16,0,9,0,100,0,0,40,3400,4700,11,25054,0,0,0,0,0,2,0,0,0,0,0,0,0,'Father Kamaros - In combat - Cast bolt'),
(@KAMAROS_1,0,17,0,14,0,100,0,500,40,15000,20000,11,25054,32,0,0,0,0,7,0,0,0,0,0,0,0,'Father Kamaros - Friendly hp deficit - Cast Power Word: Shield'),
(@KAMAROS_1,0,18,0,0,0,100,0,5000,6200,11700,15600,11,17146,0,0,0,0,0,5,0,0,0,0,0,0,0,'Father Kamaros - In combat - Cast Shadow Word: Pain'),

(@KAMAROS_64,0,0,0,11,0,100,0,0,0,0,0,18,768,0,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Respawn - Set unit flags'),
(@KAMAROS_64,0,1,0,11,0,100,0,0,0,0,0,81,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Respawn - Set questgiver flags'),
(@KAMAROS_64,0,2,0,11,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Respawn - React passive'),
(@KAMAROS_64,0,3,4,19,0,100,0,0,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Quest accept - Remove questgiver flags'),
(@KAMAROS_64,0,4,5,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Father Kamaros - Quest accept - store target'),
(@KAMAROS_64,0,5,0,61,0,100,0,0,0,0,0,1,0,5000,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Quest accept - say text'),
(@KAMAROS_64,0,6,0,52,0,100,0,0,@KAMAROS_64,0,0,1,1,5000,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Text over - Say text'),
(@KAMAROS_64,0,7,8,52,0,100,0,1,@KAMAROS_64,0,0,53,0,@KAMAROS_64,0,0,0,2,1,0,0,0,0,0,0,0,'Father Kamaros - Text over - WP start'),
(@KAMAROS_64,0,8,0,61,0,100,0,0,0,0,0,19,768,0,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Text over - Set faction 113'),
(@KAMAROS_64,0,9,0,40,0,100,0,13,@KAMAROS_64,0,0,15,13482,0,0,0,0,0,12,1,0,0,0,0,0,0,'Father Kamaros - Wp reached - complete quest'),
(@KAMAROS_64,0,10,0,40,0,100,0,13,@KAMAROS_64,0,0,15,13481,0,0,0,0,0,12,1,0,0,0,0,0,0,'Father Kamaros - Wp reached - complete quest'),
(@KAMAROS_64,0,11,0,40,0,100,0,13,@KAMAROS_64,0,0,1,3,5000,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Wp reached - Say text'),
(@KAMAROS_64,0,12,0,52,0,100,0,3,@KAMAROS_64,0,0,1,4,10000,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Text over - Say text'),
(@KAMAROS_64,0,13,0,52,0,100,0,4,@KAMAROS_64,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Text over - Despawn'),
(@KAMAROS_64,0,14,0,4,0,100,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Father Kamaros - Aggro - Say text'),
(@KAMAROS_64,0,15,0,4,0,100,0,0,0,0,0,11,74973,32,0,0,0,0,12,1,0,0,0,0,0,0,'Father Kamaros - Aggro - Cast Power Word: Fortitude'),
(@KAMAROS_64,0,16,0,9,0,100,0,0,40,3400,4700,11,25054,0,0,0,0,0,2,0,0,0,0,0,0,0,'Father Kamaros - In combat - Cast bolt'),
(@KAMAROS_64,0,17,0,14,0,100,0,500,40,15000,20000,11,25054,32,0,0,0,0,7,0,0,0,0,0,0,0,'Father Kamaros - Friendly hp deficit - Cast Power Word: Shield'),
(@KAMAROS_64,0,18,0,0,0,100,0,5000,6200,11700,15600,11,17146,0,0,0,0,0,5,0,0,0,0,0,0,0,'Father Kamaros - In combat - Cast Shadow Word: Pain');

DELETE FROM `creature_text` WHERE `entry` IN (@KAMAROS_1,@KAMAROS_64);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(@KAMAROS_1,0,0,"The Light's blessing be upon you for aiding me in my time of need, $n.",12,0,100,1,0,0,'Father Kamaros'),
(@KAMAROS_1,1,0,"I've had my fill of this place. Let us depart.",12,0,100,1,0,0,'Father Kamaros'),
(@KAMAROS_1,2,0,"Face your judgment by the Light!",12,0,100,0,0,0,'Father Kamaros'),
(@KAMAROS_1,2,1,"The Argent Crusade never surrenders!",12,0,100,0,0,0,'Father Kamaros'),
(@KAMAROS_1,2,2,"You will never take me alive!",12,0,100,0,0,0,'Father Kamaros'),
(@KAMAROS_1,3,0,"You must tell my brothers that I live.",12,0,100,1,0,0,'Father Kamaros'),
(@KAMAROS_1,4,0,"I have you to thank for my life. I will return to my comrades and spread word of your bravery. Fight the Scourge with all the strength you can muster, and we will be by your side.",12,0,100,1,0,0,'Father Kamaros'),
(@KAMAROS_64,0,0,"The Light's blessing be upon you for aiding me in my time of need, $n.",12,0,100,1,0,0,'Father Kamaros'),
(@KAMAROS_64,1,0,"I've had my fill of this place. Let us depart.",12,0,100,1,0,0,'Father Kamaros'),
(@KAMAROS_64,2,0,"Face your judgment by the Light!",12,0,100,0,0,0,'Father Kamaros'),
(@KAMAROS_64,2,1,"The Argent Crusade never surrenders!",12,0,100,0,0,0,'Father Kamaros'),
(@KAMAROS_64,2,2,"You will never take me alive!",12,0,100,0,0,0,'Father Kamaros'),
(@KAMAROS_64,3,0,"You must tell my brothers that I live.",12,0,100,1,0,0,'Father Kamaros'),
(@KAMAROS_64,4,0,"I have you to thank for my life. I will return to my comrades and spread word of your bravery. Fight the Scourge with all the strength you can muster, and we will be by your side.",12,0,100,1,0,0,'Father Kamaros');

DELETE FROM `waypoints` WHERE `entry` IN (@KAMAROS_1,@KAMAROS_64);
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@KAMAROS_1,1,6718.946289,3436.632813,682.196777,'Father Kamaros'),
(@KAMAROS_1,2,6728.942871,3432.237061,682.196777,'Father Kamaros'),
(@KAMAROS_1,3,6735.460449,3436.852539,681.729675,'Father Kamaros'),
(@KAMAROS_1,4,6771.905762,3470.200928,673.036072,'Father Kamaros'),
(@KAMAROS_1,5,6786.034668,3485.005615,675.559448,'Father Kamaros'),
(@KAMAROS_1,6,6828.949707,3480.739258,689.476685,'Father Kamaros'),
(@KAMAROS_1,7,6877.636719,3479.511719,695.122498,'Father Kamaros'),
(@KAMAROS_1,8,6926.661621,3481.686768,704.649780,'Father Kamaros'),
(@KAMAROS_1,9,6951.593262,3476.161621,709.489990,'Father Kamaros'),
(@KAMAROS_1,10,6980.244141,3469.139404,710.857300,'Father Kamaros'),
(@KAMAROS_1,11,7009.522461,3457.913818,696.671814,'Father Kamaros'),
(@KAMAROS_1,12,7019.481445,3453.278320,696.671814,'Father Kamaros'),
(@KAMAROS_1,13,7085.294922,3407.391602,694.898010,'Father Kamaros'),
(@KAMAROS_64,1,6718.946289,3436.632813,682.196777,'Father Kamaros'),
(@KAMAROS_64,2,6728.942871,3432.237061,682.196777,'Father Kamaros'),
(@KAMAROS_64,3,6735.460449,3436.852539,681.729675,'Father Kamaros'),
(@KAMAROS_64,4,6771.905762,3470.200928,673.036072,'Father Kamaros'),
(@KAMAROS_64,5,6786.034668,3485.005615,675.559448,'Father Kamaros'),
(@KAMAROS_64,6,6828.949707,3480.739258,689.476685,'Father Kamaros'),
(@KAMAROS_64,7,6877.636719,3479.511719,695.122498,'Father Kamaros'),
(@KAMAROS_64,8,6926.661621,3481.686768,704.649780,'Father Kamaros'),
(@KAMAROS_64,9,6951.593262,3476.161621,709.489990,'Father Kamaros'),
(@KAMAROS_64,10,6980.244141,3469.139404,710.857300,'Father Kamaros'),
(@KAMAROS_64,11,7009.522461,3457.913818,696.671814,'Father Kamaros'),
(@KAMAROS_64,12,7019.481445,3453.278320,696.671814,'Father Kamaros'),
(@KAMAROS_64,13,7085.294922,3407.391602,694.898010,'Father Kamaros');

DELETE FROM `creature` WHERE `id`=@KAMAROS_64;
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(@KAMAROS_64,571,1,64,27554,0,6717.81,3451.98,683.747,4.64258,300,0,0,12600,11982,0,0,0,0);

-- No se pueden hacer las dos misiones
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (19,20) AND `SourceEntry` IN (13221,13482,13229,13481);
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`Comment`) VALUES
(19,13221,0,14,13482,'I''m Not Dead Yet! (Alliance) requieres Let''s Get Out of Here (Alliance) status none'),
(20,13221,0,14,13482,'I''m Not Dead Yet! (Alliance) requieres Let''s Get Out of Here (Alliance) status none'),
(19,13482,0,14,13221,'Let''s Get Out of Here (Alliance) requieres I''m Not Dead Yet! (Alliance) status none'),
(20,13482,0,14,13221,'Let''s Get Out of Here (Alliance) requieres I''m Not Dead Yet! (Alliance) status none'),
(19,13229,0,14,13481,'I''m Not Dead Yet! (Horde) requieres Let''s Get Out of Here (Horde) status none'),
(20,13229,0,14,13481,'I''m Not Dead Yet! (Horde) requieres Let''s Get Out of Here (Horde) status none'),
(19,13481,0,14,13229,'Let''s Get Out of Here (Horde) requieres I''m Not Dead Yet! (Horde) status none'),
(20,13481,0,14,13229,'Let''s Get Out of Here (Horde) requieres I''m Not Dead Yet! (Horde) status none');
