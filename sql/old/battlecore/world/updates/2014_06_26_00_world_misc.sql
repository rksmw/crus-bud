-- ----------------------------------------
-- Achievement - King of the Fire Festival
-- ----------------------------------------

-- Fix bonfire Spells
UPDATE `gameobject_template` SET `data10`=29099 WHERE `entry`=181334; -- Flame of Darnassus
UPDATE `gameobject_template` SET `data10`=29132 WHERE `entry`=181337; -- Flame of Thunder Bluff
UPDATE `gameobject_template` SET `data10`=29102 WHERE `entry`=181333; -- Flame of Ironforge
UPDATE `gameobject_template` SET `data10`=29130 WHERE `entry`=181336; -- Flame of Orgrimmar
UPDATE `gameobject_template` SET `data10`=29101 WHERE `entry`=181332; -- Flame of Stormwind
UPDATE `gameobject_template` SET `data10`=29133 WHERE `entry`=181335; -- Flame of the Undercity
UPDATE `gameobject_template` SET `faction`=1732, `data10`=46689 WHERE `entry`=188129; -- Flame of Silvermoon
UPDATE `gameobject_template` SET `faction`=1735, `data10`=46690 WHERE `entry`=188128; -- Flame of the Exodar

-- Add missing bonfire in Exodar
DELETE FROM `game_event_gameobject` WHERE `guid` IN (SELECT `guid` FROM `gameobject` WHERE `id`=188128); 
DELETE FROM `gameobject` WHERE `id`=188128;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(NULL,188128,530,1,1,-3794.1,-11503.9,-134.748,3.38429,0,0,0.992646,-0.12105,300,0,1);
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`)
SELECT 1, `guid` FROM `gameobject` WHERE `id`=188128;

-- Fix Alliance quest chaining
UPDATE `creature_queststarter` SET `id`=16817 WHERE `quest`=9365; -- Festival Loremaster should give you this quest
UPDATE `creature_questender` SET `id`=16817 WHERE `quest`=9365; -- Festival Loremaster should end this quest
UPDATE `quest_template` SET `NextQuestId`=9365 WHERE `Id` IN (9324,9325,9326,11935); -- Alliance quests should give you Alliance quest version next
DELETE FROM `creature_queststarter` WHERE `quest`=11935; -- This quest is given by an item, not npc

-- Fix Horde quest chaining
UPDATE `creature_queststarter` SET `id`=16818 WHERE `quest`=9339; -- Festival Talespinner should give you this quest
UPDATE `creature_questender` SET `id`=16818 WHERE `quest`=9339; -- Festival Talespinner should end this quest
UPDATE `quest_template` SET `NextQuestId`=9339 WHERE `Id` IN (9330,9331,9332,11933); -- Horde quests should give you Horde quest version next
DELETE FROM `creature_queststarter` WHERE `quest`=11933; -- This quest is given by an item, not npc
