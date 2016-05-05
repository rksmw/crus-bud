-- Quest - Blowing Hodir's Horn
DELETE FROM `gameobject_queststarter` WHERE `quest`=12977;
INSERT INTO `gameobject_queststarter` (`id`,`quest`) VALUES (192078,12977);
DELETE FROM `gameobject_questender` WHERE `quest`=12977;
INSERT INTO `gameobject_questender` (`id`,`quest`) VALUES (192078,12977);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=55983;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17,0,55983,0,0,31,1,3,30144,0,0,0,'','Blow Hodir''s Horn - Explicit Target - Restless Frostborn Ghost'),
(17,0,55983,0,0,36,1,0,0,0,1,0,'','Blow Hodir''s Horn - Explicit Target - Dead'),
(17,0,55983,0,1,31,1,3,30135,0,0,0,'','Blow Hodir''s Horn - Explicit Target - Restless Frostborn Warrior'),
(17,0,55983,0,1,36,1,0,0,0,1,0,'','Blow Hodir''s Horn - Explicit Target - Dead'),
(17,0,55983,0,2,31,1,3,29974,0,0,0,'','Blow Hodir''s Horn - Explicit Target - Niffelem Forefather'),
(17,0,55983,0,2,36,1,0,0,0,1,0,'','Blow Hodir''s Horn - Explicit Target - Dead');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (30144,30135,29974);
UPDATE `creature_template` SET `AIName`='SmartAI', `InhabitType`=4 WHERE `entry` IN (30141,30143,30145);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (30144,30135,29974,30141,30143,30145) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(30141,0,0,0,54,0,100,0,0,0,0,0,104,30,3,0,0,0,0,1,0,0,0,0,0,0,0,'Frost Giant Floating Spirit - Just summoned - Move Up'),
(30143,0,0,0,54,0,100,0,0,0,0,0,104,30,3,0,0,0,0,1,0,0,0,0,0,0,0,'Frostborn Floating Spirit - Just summoned - Move Up'),
(30145,0,0,0,54,0,100,0,0,0,0,0,104,30,3,0,0,0,0,1,0,0,0,0,0,0,0,'Frostborn Floating Spirit - Just summoned - Move Up'),
(29974,0,0,0,0,0,100,0,1000,5000,8000,13000,11,57454,0,0,0,0,0,4,0,0,0,0,0,0,0,'Niffelem Forefather - In combat - Cast Ice Spike'),
(29974,0,1,2,8,0,100,0,55983,0,0,0,33,30138,0,0,0,0,0,7,0,0,0,0,0,0,0,'Niffelem Forefather - Spellhit - Give Killcredit'),
(29974,0,2,3,61,0,100,0,55983,0,0,0,12,30141,3,5000,0,0,0,1,0,0,0,0,0,0,0,'Niffelem Forefather - Spellhit - Summon Frost Giant Floating Spirit'),
(29974,0,3,0,61,0,100,0,55983,0,0,0,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Niffelem Forefather - In combat - Set Invisible'),
(30135,0,0,1,8,0,100,0,55983,0,0,0,33,30139,0,0,0,0,0,7,0,0,0,0,0,0,0,'Restless Frostworn Warrior - Spellhit - Give Killcredit'),
(30135,0,1,2,61,0,100,0,55983,0,0,0,12,30143,3,5000,0,0,0,1,0,0,0,0,0,0,0,'Restless Frostworn Warrior - Spellhit - Summon Frostborn Floating Spirit'),
(30135,0,2,0,61,0,100,0,55983,0,0,0,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Restless Frostworn Warrior - In combat - Set Invisible'),
(30144,0,0,1,8,0,100,0,55983,0,0,0,33,30139,0,0,0,0,0,7,0,0,0,0,0,0,0,'Restless Frostworn Ghost - Spellhit - Give Killcredit'),
(30144,0,1,2,61,0,100,0,55983,0,0,0,12,30145,3,5000,0,0,0,1,0,0,0,0,0,0,0,'Restless Frostworn Ghost - Spellhit - Summon Frostborn Floating Spirit'),
(30144,0,2,0,61,0,100,0,55983,0,0,0,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Restless Frostworn Ghost - In combat - Set Invisible');

DELETE FROM `creature_template_addon` WHERE `entry` IN (30141,30143,30145);
INSERT INTO `creature_template_addon` (`entry`,`auras`) VALUES
(30141,'36545'),
(30143,'36545'),
(30145,'36545');
