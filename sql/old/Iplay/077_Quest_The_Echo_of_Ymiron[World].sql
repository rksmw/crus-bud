-- Quest - The Echo of Ymiron
SET @MALE := 24314;
SET @FEMALE := 24315;
SET @LICH := 24248;
SET @VALKYR := 24327;
UPDATE `creature_template` SET `unit_flags`=unit_flags|2|131072, `flags_extra`=flags_extra|2 WHERE `entry` IN (@MALE,@FEMALE,@LICH,@VALKYR);
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry`=@VALKYR;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@FEMALE,@LICH);

DELETE FROM `creature_template_addon` WHERE `entry`=@VALKYR;
INSERT INTO `creature_template_addon` (`entry`,`bytes1`) VALUES (@VALKYR,50331648);

-- Missing spawns from YTDB
DELETE FROM `creature` WHERE `id` IN (@MALE,@FEMALE,@LICH,@VALKYR);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES 
(NULL,@MALE,571,1,2,0,0,1072.85,-5029.35,9.75146,4.94099,300,0,0,5158,0,0,0,0,0),
(NULL,@FEMALE,571,1,2,0,0,1074.21,-5034.29,9.86589,3.37019,300,0,0,5158,0,0,0,0,0),
(NULL,@VALKYR,571,1,2,0,0,1057.28,-4909.43,16.9932,3.42988,300,0,0,9610,0,0,0,0,0),
(NULL,@VALKYR,571,1,2,0,0,1062.26,-4925.3,16.9932,3.48093,300,0,0,9610,0,0,0,0,0),
(NULL,@LICH,571,1,2,0,0,1058.61,-4917.45,10.6189,3.46522,300,0,0,27890000,0,0,0,0,0);

DELETE FROM `gameobject` WHERE `id`=186664;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(NULL, 186664, 571, 1, 2, 1073, -5033.95, 9.77122, 1.51844, 0, 0, 0.688356, 0.725373, 5, 0, 1);

-- Quest event
DELETE FROM `smart_scripts` WHERE `entryorguid`=@FEMALE AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@FEMALE*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@FEMALE,0,0,0,25,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Ancient Female Vrykul - Reset - Set phase 1'),
(@FEMALE,0,1,0,25,0,100,0,0,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Ancient Female Vrykul - Reset - Set walk'),
(@FEMALE,0,2,0,25,0,100,0,0,0,0,0,90,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Ancient Female Vrykul - Reset - Sit'),
(@FEMALE,0,3,0,10,1,100,0,0,10,0,0,80,@FEMALE*100,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Ancient Female Vrykul - Move in LOS - Run script (see conditions)'),
(@FEMALE*100,9,0,0,0,0,100,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Ancient Female Vrykul - Script - Set phase 2'),
(@FEMALE*100,9,1,0,0,0,100,0,2000,2000,0,0,1,0,0,0,0,0,0,19,24314,50,0,0,0,0,0, 'Ancient Female Vrykul - Script - Say text (Ancient Male Vrykul)'),
(@FEMALE*100,9,2,0,0,0,100,0,2000,2000,0,0,1,1,0,0,0,0,0,19,24314,50,0,0,0,0,0, 'Ancient Female Vrykul - Script - Say text (Ancient Male Vrykul)'),
(@FEMALE*100,9,3,0,0,0,100,0,3000,3000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Ancient Female Vrykul - Script - Say text'),
(@FEMALE*100,9,4,0,0,0,100,0,3000,3000,0,0,1,2,0,0,0,0,0,19,24314,50,0,0,0,0,0, 'Ancient Female Vrykul - Script - Say text (Ancient Male Vrykul)'),
(@FEMALE*100,9,5,0,0,0,100,0,10000,10000,0,0,91,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Ancient Female Vrykul - Script - Stand up'),
(@FEMALE*100,9,6,0,0,0,100,0,0,0,0,0,69,1,0,0,0,0,0,8,0,0,0,1073.65,-5031.66,9.898,0, 'Ancient Female Vrykul - Script - Move to position'),
(@FEMALE*100,9,7,0,0,0,100,0,3000,3000,0,0,66,0,0,0,0,0,0,19,24314,50,0,0,0,0,0, 'Ancient Female Vrykul - Script - Set orientation'),
(@FEMALE*100,9,8,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Ancient Female Vrykul - Script - Say text'),
(@FEMALE*100,9,9,0,0,0,100,0,7000,7000,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Ancient Female Vrykul - Script - Kneel'),
(@FEMALE*100,9,10,0,0,0,100,0,0,0,0,0,1,3,0,0,0,0,0,19,24314,50,0,0,0,0,0, 'Ancient Female Vrykul - Script - Say text (Ancient Male Vrykul)'),
(@FEMALE*100,9,11,0,0,0,100,0,5000,5000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Ancient Female Vrykul - Script - Say text'),
(@FEMALE*100,9,12,0,0,0,100,0,5000,5000,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Ancient Female Vrykul - Script - Stand up'),
(@FEMALE*100,9,13,0,0,0,100,0,1000,1000,0,0,15,11343,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Ancient Female Vrykul - Script - Group event happens'),
(@FEMALE*100,9,14,0,0,0,100,0,0,0,0,0,15,11343,0,0,0,0,0,16,0,0,0,0,0,0,0, 'Ancient Female Vrykul - Script - Group event happens'),
(@FEMALE*100,9,15,0,0,0,100,0,3000,3000,0,0,69,2,0,0,0,0,0,8,0,0,0,1074.21,-5034.29,9.86589,0, 'Ancient Female Vrykul - Script - Return to home position'),
(@FEMALE*100,9,16,0,0,0,100,0,3000,3000,0,0,90,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Ancient Female Vrykul - Script - Sit'),
(@FEMALE*100,9,17,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Ancient Female Vrykul - Script - Set orientation'),
(@FEMALE*100,9,18,0,0,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Ancient Female Vrykul - Script - Set phase 1');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@FEMALE AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,4,@FEMALE,0,0,1,0,42786,0,0,0,0,'','SAI - Ancient Female Vrykul run script if player has aura'),
(22,4,@FEMALE,0,0,9,0,11343,0,0,0,0,'','SAI - Ancient Female Vrykul run script if player has quest');

DELETE FROM `creature_text` WHERE `entry` IN (@MALE,@FEMALE);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(@MALE,0,0,'So then we too are cursed?',12,0,100,1,0,0,'Ancient Male Vrykul'),
(@MALE,1,0,'Ancient Male Vrykul points to the infant.',16,0,100,25,0,0,'Ancient Male Vrykul'),
(@MALE,2,0,'The gods have forsaken us! We must dispose of it before Ymiron is notified!',12,0,100,53,0,0,'Ancient Male Vrykul'),
(@MALE,3,0,'Then what are we to do, wife? The others cannot find out. Should they learn of this aberration, we will all be executed.',12,0,100,1,0,0,'Ancient Male Vrykul'),
(@FEMALE,0,0,'Ancient Female Vrykul sobs.',16,0,100,0,0,0,'Ancient Female Vrykul'),
(@FEMALE,1,0,'NO! You cannot! I beg of you! It is our child!',12,0,100,0,0,0,'Ancient Female Vrykul'),
(@FEMALE,2,0,'I... I will hide it. I will hide it until I find it a home, far away from here...', 12,0,100,1,0,0,'Ancient Female Vrykul');

-- Extra - Lich King Event
SET @PULL := 29661; -- Spell Magnetic Pull
SET @STUN := 43489; -- Spell Grasp of The Lich King
SET @WOTLK := 43488; -- Spell Wrath of The Lich King
DELETE FROM `smart_scripts` WHERE `entryorguid`=@LICH AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@LICH*100,@LICH*100+1) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@LICH,0,0,0,25,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'The Lich King - Reset - Set phase 1'),
(@LICH,0,1,0,10,1,100,0,0,20,0,0,80,@LICH*100,2,0,0,0,0,1,0,0,0,0,0,0,0, 'The Lich King - Move in LOS - Run script (see conditions)'),
(@LICH,0,2,0,10,1,100,0,0,20,0,0,80,@LICH*100+1,2,0,0,0,0,1,0,0,0,0,0,0,0, 'The Lich King - Move in LOS - Run script (see conditions)'),
-- Script one (first time)
(@LICH*100,9,0,0,0,0,100,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'The Lich King - Script - Set phase 2'),
(@LICH*100,9,1,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'The Lich King - Script - Say text'),
(@LICH*100,9,2,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0, 'The Lich King - Script - Face Invoker'),
(@LICH*100,9,3,0,0,0,100,0,500,500,0,0,11,@PULL,0,0,0,0,0,7,0,0,0,0,0,0,0, 'The Lich King - Script - Cast Magnetic Pull'),
(@LICH*100,9,4,0,0,0,100,0,1000,1000,0,0,11,@STUN,0,0,0,0,0,7,0,0,0,0,0,0,0, 'The Lich King - Script - Cast Grasp of The Lich King'),
(@LICH*100,9,5,0,0,0,100,0,1000,1000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'The Lich King - Script - Say text'),
(@LICH*100,9,6,0,0,0,100,0,2000,2000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'The Lich King - Script - Say text'),
(@LICH*100,9,7,0,0,0,100,0,6000,6000,0,0,1,0,0,0,0,0,0,19,@VALKYR,20,0,0,0,0,0, 'The Lich King - Script - Say text'),
(@LICH*100,9,8,0,0,0,100,0,5000,5000,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0, 'The Lich King - Script - Say text'),
(@LICH*100,9,9,0,0,0,100,0,6000,6000,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0, 'The Lich King - Script - Say text'),
(@LICH*100,9,10,0,0,0,100,0,10000,10000,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0, 'The Lich King - Script - Say text'),
(@LICH*100,9,11,0,0,0,100,0,10000,10000,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0, 'The Lich King - Script - Say text'),
(@LICH*100,9,12,0,0,0,100,0,10000,10000,0,0,85,@WOTLK,3,0,0,0,0,7,0,0,0,0,0,0,0, 'The Lich King - Script - Cast Wrath of The Lich King'),
(@LICH*100,9,13,0,0,0,100,0,500,500,0,0,51,0,0,0,0,0,0,7,0,0,0,0,0,0,0, 'The Lich King - Script - Kill invoker'),
(@LICH*100,9,14,0,0,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'The Lich King - Script - Set phase 1'),
(@LICH*100,9,15,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'The Lich King - Script - Set orientation'),
-- Script 2
(@LICH*100+1,9,0,0,0,0,100,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'The Lich King - Script - Set phase 2'),
(@LICH*100+1,9,1,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0, 'The Lich King - Script - Face Invoker'),
(@LICH*100+1,9,2,0,0,0,100,0,500,500,0,0,11,@PULL,0,0,0,0,0,7,0,0,0,0,0,0,0, 'The Lich King - Script - Cast Magnetic Pull'),
(@LICH*100+1,9,3,0,0,0,100,0,1000,1000,0,0,11,@STUN,0,0,0,0,0,7,0,0,0,0,0,0,0, 'The Lich King - Script - Cast Grasp of The Lich King'),
(@LICH*100+1,9,4,0,0,0,100,0,4000,4000,0,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0, 'The Lich King - Script - Say text'),
(@LICH*100+1,9,5,0,0,0,100,0,7000,7000,0,0,51,0,0,0,0,0,0,7,0,0,0,0,0,0,0, 'The Lich King - Script - Kill invoker'),
(@LICH*100+1,9,6,0,0,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'The Lich King - Script - Set phase 1'),
(@LICH*100+1,9,7,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'The Lich King - Script - Set orientation');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@LICH AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,2,@LICH,0,0,1,0,42786,0,0,0,0,'','SAI - The Lich King run script if player has aura'),
(22,2,@LICH,0,0,8,0,12485,0,0,1,0,'','SAI - The Lich King run script if player has quest not rewarded'),
(22,3,@LICH,0,0,1,0,42786,0,0,0,0,'','SAI - The Lich King run script if player has aura'),
(22,3,@LICH,0,0,8,0,12485,0,0,0,0,'','SAI - The Lich King run script if player has quest not rewarded');

DELETE FROM `creature_text` WHERE `entry` IN (@LICH,@VALKYR);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(@LICH,0,0,'The Lich King turns to face you.',16,0,100,0,0,0,'The Lich King'),
(@LICH,1,0,'The Lich King grins.',16,0,100,0,0,0,'The Lich King'),
(@LICH,2,0,'Shamanism has brought you here... Its scent permeates the air. *The Lich King laughs* I was once a shaman.',12,0,100,0,0,0,'The Lich King'),
(@LICH,3,0,'No, minion. This one is not ready.',12,0,100,0,0,0,'The Lich King'),
(@LICH,4,0,'Do you feel it, mortal? Death seeps through me, enveloping all that I touch. With just a snap of my finger your soul will languish in damnation for all eternity.',12,0,100,0,0,0,'The Lich King'),
(@LICH,5,0,'But... It is not yet your time to serve the Lich King. Yes, a greater destiny awaits you. Power... You must become more powerful before you are to serve me.',12,0,100,0,0,0,'The Lich King'),
(@LICH,6,0,'Now watch, val''kyr. Observe as I apply pressure. Can you see that it is not yet ripe? Watch as it pops and falls lifeless to the floor.',12,0,100,0,0,0,'The Lich King'),
(@LICH,7,0,'Persistence or stupidity? It matters not. Let this be a lesson learned, mortal!',12,0,100,0,0,0,'The Lich King'),
(@VALKYR,0,0,'Shall we prepare it for you, my lord?',12,0,100,0,0,0,'Val''kyr Soulclaimer');
