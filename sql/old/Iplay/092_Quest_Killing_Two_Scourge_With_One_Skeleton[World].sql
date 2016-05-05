-- Quest - Killing Two Scourge With One Skeleton
UPDATE `creature_template` SET `AIName`='SmartAI', `InhabitType`=1 WHERE `entry`=30689;
DELETE FROM `smart_scripts` WHERE `entryorguid`=30689;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30689,0,0,0,0,0,100,0,2000,3000,8000,10000,11,15496,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Chained Abomination - IC - cast Cleave on target'),
(30689,0,1,0,9,0,100,0,8,40,10000,15000,11,50335,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Chained Abomination - IC - cast Scourge Hook on target'),
(30689,0,2,3,8,0,100,1,58593,0,0,0,50,190795,60,0,0,0,0,1,0,0,0,0,0,0,0, 'Chained Abomination - on spellhit - summon medium fire on self'),
(30689,0,3,4,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,19,31048,5,0,0,0,0,0, 'Chained Abomination - on spellhit - set data to caster'),
(30689,0,4,0,61,0,100,0,0,0,0,0,11,58596,3,0,0,0,0,0,0,0,0,0,0,0,0, 'Chained Abomination - on spellhit - cast abomination explosion');

UPDATE `creature_template` SET `AIName`='SmartAI', `InhabitType`=1 WHERE `entry`=31048;
DELETE FROM `smart_scripts` WHERE `entryorguid`=31048 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31048,0,0,1,38,0,100,0,0,1,0,0,11,58602,3,0,0,0,0,1,0,0,0,0,0,0,0, 'Burning Skeleton - Data set - Cast Trigger Abom Credit to Master'),
(31048,0,1,0,38,0,100,0,0,1,0,0,33,30995,0,0,0,0,0,23,0,0,0,0,0,0,0, 'Burning Skeleton - Data set - Owner Cast Abom Credit');

DELETE FROM `creature_template_addon` WHERE `entry`=31048;
INSERT INTO `creature_template_addon` (`entry`,`auras`) VALUES
(31048,'58594');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (58593,58596);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,58593,0,0,31,0,3,30689,0,0,0,'','Skeleton Check - Implicit target - Chained Abomination'),
(13,2,58596,0,0,31,0,3,31048,0,0,0,'','Abomination Explosion - Implicit target - Burning Skeleton');
