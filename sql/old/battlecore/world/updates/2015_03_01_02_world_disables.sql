SET @SpellBattleStandard :=  32205; -- Place Mag'har Battle Standard
SET @FirstTriggerNPC     :=  18305; -- First trigger NPC
SET @SecondTriggerNPC    :=  18306; -- Second trigger NPC
SET @ThirdTriggerNPC     :=  18307; -- Third trigger NPC

SET @FirstBB             := 182261; -- First Burning Blade Pyre
SET @SecondBB            := 182264; -- Second Burning Blade Pyre
SET @ThirdBB             := 182262; -- Third Burning Blade Pyre
SET @TriggerBB           := 182263; -- First Burning Blade Pyre (Trigger GO)

-- Spawnpoints of Burning Blades
DELETE FROM `gameobject` WHERE `id` IN (@FirstBB, @SecondBB, @ThirdBB, @TriggerBB);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(22718, @TriggerBB, 530, 1, 1, -2532.98, 6307.27, 14.0203, 2.95833, 0, 0, 0.995805, 0.091502, 181, 100, 1),
(379, @TriggerBB, 530, 1, 1, -2533.19, 6168.61, 59.9391, 2.81871, 0, 0, 0.986996, 0.160743, 181, 100, 1),
(371, @TriggerBB, 530, 1, 1, -2475.29, 6106.4, 91.9832, 1.98095, 0, 0, 0.836286, 0.548293, 181, 100, 1),
(22716, @FirstBB, 530, 1, 1, -2532.98, 6307.27, 14.0203, 2.95833, 0, 0, 0.995805, 0.091502, 181, 100, 1),
(22719, @SecondBB, 530, 1, 1, -2533.19, 6168.61, 59.9391, 2.81871, 0, 0, 0.986996, 0.160743, 181, 100, 1),
(22717, @ThirdBB, 530, 1, 1, -2475.29, 6106.4, 91.9832, 1.98095, 0, 0, 0.836286, 0.548293, 181, 100, 1);

-- Trigger NPC's for quest complete
DELETE FROM `creature` WHERE `guid` IN (65640, 65641, 65642);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(65640, @FirstTriggerNPC, 530, 1, 1, 0, 0, -2532.98, 6307.27, 14.0203, 2.95833, 300, 0, 0, 800, 0, 0, 0, 0, 0),
(65641, @SecondTriggerNPC, 530, 1, 1, 0, 0, -2533.19, 6168.61, 59.9391, 2.81871, 300, 0, 0, 800, 0, 0, 0, 0, 0),
(65642, @ThirdTriggerNPC, 530, 1, 1, 0, 0, -2475.29, 6106.4, 91.9832, 1.98095, 300, 0, 0, 800, 0, 0, 0, 0, 0);

-- Ignore LOS for trigger spell
DELETE FROM `disables` WHERE `sourceType` = 0 AND `entry` = @SpellBattleStandard;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(0, @SpellBattleStandard, 64, '', '', 'Ignore LOS for Place Mag''har Battle Standard');

UPDATE `creature_template` SET `ainame`='SmartAI' WHERE `entry` IN (18305,18306,18307);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (18305,18306,18307) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18305,0,0,0,8,0,100,0,32205,0,0,0,33,18305,0,0,0,0,0,7,0,0,0,0,0,0,0,'Burning Blade Pyre (01) - On Spell Hit (Place Maghar Battle Standard)- Give Quest Credit'),
(18306,0,0,0,8,0,100,0,32205,0,0,0,33,18306,0,0,0,0,0,7,0,0,0,0,0,0,0,'Burning Blade Pyre (02) - On Spell Hit (Place Maghar Battle Standard)- Give Quest Credit'),
(18307,0,0,0,8,0,100,0,32205,0,0,0,33,18307,0,0,0,0,0,7,0,0,0,0,0,0,0,'Burning Blade Pyre (03) - On Spell Hit (Place Maghar Battle Standard)- Give Quest Credit');
