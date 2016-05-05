UPDATE `creature_template` SET `AIName`= 'SmartAI',`ScriptName`='' WHERE `entry` =17542;
DELETE FROM `smart_scripts` WHERE `entryorguid` =17542;

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17542,0,0,1,8,0,100,0,8593,0,0,0,33,17542,0,0,0,0,0,7,0,0,0,0,0,0,0,'Young Furbolg Shaman - On Spell Hit - Give Kill Credit'),
(17542,0,1,2,61,0,100,0,0,0,0,0,28,29266,0,0,0,0,0,1,0,0,0,0,0,0,0,'Young Furbolg Shaman - Linked with Previous Event - Remove permament Feign Death'),
(17542,0,2,0,61,0,100,0,0,0,0,0,23,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Young Furbolg Shaman - Linked with Previous Event - Set Phase 2'),

(17542,0,4,5, 1,2,100,0,60000,60000,60000,60000,11,29266,2,0,0,0,0,1,0,0,0,0,0,0,0,'Young Furbolg Shaman - OOC - Cast Permament Feign Death'),
(17542,0,5,0,61,2,100,0,0,0,0,0,23,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Young Furbolg Shaman - Linked with Previous Event - Set Phase 1'),
(17542,0,6,0,25,0,100,0,0,0,0,0,11,29266,2,0,0,0,0,1,0,0,0,0,0,0,0,'Young Furbolg Shaman - On Spawn - Cast Permament Feign Death');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=8593;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(13, 1, 8593, 0, 0, 31, 0, 3, 17542, 0, 0, 0, 0, '', 'Symbol of Life can be casted on Young Furbolg Shaman'),
(13, 1, 8593, 0, 1, 31, 0, 3, 6172, 0, 0, 0, 0, '', 'Symbol of Life can be casted on Henze Faulk'),
(13, 1, 8593, 0, 2, 31, 0, 3, 6177, 0, 0, 0, 0, '', 'Symbol of Life can be casted on Narm Faulk');

UPDATE `creature_template` SET `ainame`='SmartAI',`scriptname`='' WHERE `entry`=17768;
DELETE FROM `smart_scripts` WHERE `entryorguid`=17768 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=1776800 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17768,0,0,0,8,0,100,0,31225,0,0,0,80,1776800,0,0,0,0,0,1,0,0,0,0,0,0,0,'Blood Knight Stillblade - On Spell Hit - Call Timed Action List'),
(1776800,9,0,0,0,0,100,0,0,0,0,0,33,17768,0,0,0,0,0,7,0,0,0,0,0,0,0,'Action 0 - Give Quest Credit'),
(1776800,9,1,0,0,0,100,0,0,0,0,0,11,32343,0,0,0,0,0,1,0,0,0,0,0,0,0,'Action 1 - Cast Revive Self'),
(1776800,9,2,0,0,0,100,0,0,0,0,0,91,7,0,0,0,0,0,1,0,0,0,0,0,0,0,'Action 2 - Remove Unit Field Bytes 1'),
(1776800,9,3,0,0,0,100,0,0,0,0,0,96,40,0,0,0,0,0,1,0,0,0,0,0,0,0,'Action 3 - Remove Dynamic Flags'),
(1776800,9,4,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Action 4 - Talk'),
(1776800,9,5,0,0,0,100,0,120000,120000,0,0,94,40,0,0,0,0,0,1,0,0,0,0,0,0,0,'Action 5 - Restore Dynamic Flags'),
(1776800,9,6,0,0,0,100,0,0,0,0,0,90,7,0,0,0,0,0,1,0,0,0,0,0,0,0,'Action 6 - Restore Unit Field Bytes 1');
