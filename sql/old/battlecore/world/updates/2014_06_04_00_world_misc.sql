-- The Ocular SAI
SET @EYE := 29747;
SET @SHELL := 29790;
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry` IN (@EYE,@SHELL);
UPDATE `creature_template` SET `unit_flags`=unit_flags|33554432 WHERE `entry`=@SHELL;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@EYE AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@EYE,0,0,0,0,0,100,0,1500,1500,6000,6000,11,55269,0,0,0,0,0,2,0,0,0,0,0,0,0,'Ocular - cast Deathly Stare every 5 secs'),
(@EYE,0,1,0,6,0,100,0,0,0,0,0,33,29803,0,0,0,0,0,7,0,0,0,0,0,0,0,'Ocular - cast It''s All Fun and Games: The Ocular On Death'),
(@EYE,0,2,0,8,0,100,1,30740,0,0,0,49,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Ocular - Attack start on spell hit'),
(@EYE,0,3,0,25,0,100,0,0,0,0,0,75,55162,1,0,0,0,0,1,0,0,0,0,0,0,0,'Ocular - cast Transform on Spawn');
