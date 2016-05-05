-- Quest - Fervor of the Frostborn
SET @GIANT := 30142;
SET @HAMMER := 56448;
DELETE FROM `creature` WHERE `id`=@GIANT;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `curhealth`, `curmana`, `spawndist`, `MovementType`) VALUES
(@GIANT,571,1,1,8392.7,-1970.14,1461.84,0.0948219,600,100800,0,0,0);

DELETE FROM `gameobject` WHERE `id`=192243;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(NULL,192243,571,1,1,8531.9,-1971.44,1467.57,-0.837757,0,0,-0.406736,0.913546,300,100,1);

-- The Iron Watcher SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@GIANT;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@GIANT;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@GIANT,0,0,0,0,0,100,0,4000,9000,11000,17000,11,60925,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Iron Watcher - In combat - Cast Thundering Stomp'),
(@GIANT,0,1,0,8,0,100,0,@HAMMER,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Iron Watcher - Spellhit - Say text'),
(@GIANT,0,2,0,8,0,100,0,@HAMMER,0,0,0,11,60930,2,0,0,0,0,7,0,0,0,0,0,0,0,'The Iron Watcher - Spellhit - Cast Storm Hammer');

DELETE FROM `creature_text` WHERE `entry`=@GIANT;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@GIANT,0,0,'As the hammer lands, more rust shakes free from the Iron Watcher''s frame and its pace quickens.',16,0,100,0,0,0,'The Iron Watcher'),
(@GIANT,0,1,'The Iron Watcher roars with fury, shaking more rust from its ancient frame.',16,0,100,0,0,0,'The Iron Watcher');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=@HAMMER;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`comment`) VALUES
(17,0,@HAMMER,0,31,1,3,@GIANT,'Storm Hammer - Explicit target - The Iron Watcher');
