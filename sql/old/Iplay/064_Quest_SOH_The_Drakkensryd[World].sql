-- Fix Quest: The Drakkensryd (12886)
UPDATE `creature_template` SET `AIName`='', `ScriptName`='' WHERE `entry`=29754;
UPDATE `creature_template` SET `ScriptName`='npc_hyldsmeet_protodrake' WHERE `entry`=29625;
UPDATE `vehicle_template_accessory` SET `seat_id`=1, `minion`=1 WHERE `entry`=29625;
UPDATE `creature_template` SET `ScriptName`='npc_hyldsmeet_protodrake_transport' WHERE `entry`=29679;

SET @DRAKERIDER           := 29694; -- Hyldsmeet Drakerider
SET @SPELL_MORTAL         := 32736; -- spell Mortal Strike
SET @KILL                 := 29800; -- KillCredit for Hyldsmeet Drakerider

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @DRAKERIDER; -- Hyldsmeet Drakerider
DELETE FROM `smart_scripts` WHERE  `entryorguid`=@DRAKERIDER AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@DRAKERIDER, 0, 0, 0, 0, 0, 100, 1, 2000, 5000, 5000, 9000, 11, @SPELL_MORTAL, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Hyldsmeet Drakerider - Cast Mortal Strike"), -- Cast Mortal Strike
(@DRAKERIDER, 0, 1, 0, 6, 0, 100, 1, 0, 0, 0, 0, 33, @KILL, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "The Drakkensryd (12886) - KillCredit =29800"); -- KillCredit for Hyldsmeet Drakerider
