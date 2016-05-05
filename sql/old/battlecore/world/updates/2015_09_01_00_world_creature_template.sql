UPDATE creature_template SET mechanic_immune_mask = 2145367039 WHERE entry IN (36609, 39120, 39121, 39122); -- Valkyr Shadowguard
UPDATE creature_template SET mechanic_immune_mask = 617299839 WHERE entry IN (36855,38106,38296,38297); -- Lady Deathwhisper
UPDATE creature_template SET speed_walk = 0.7, speed_run = 0.7 WHERE `entry` IN (37799, 39284, 39285, 39286); -- Vile Spirits
UPDATE creature_template SET speed_walk = 0.7, speed_run = 0.7 WHERE `entry` IN (39190, 39287, 39288, 39289); -- Wicked Spirit
UPDATE creature_template SET speed_walk = 0.5, speed_run = 0.5 WHERE `entry` IN (37799, 39284, 39285, 39286); -- Vile Spirits
UPDATE creature_template SET speed_walk = 0.5, speed_run = 0.5 WHERE `entry` IN (39190, 39287, 39288, 39289); -- Wicked Spirit
UPDATE creature_template SET speed_walk = 0.642857, speed_run =0.642857 WHERE `entry` IN (36609, 39120, 39121, 39122); -- Valkyr Shadowguard

-- Fix Spirit Bomb Speed
UPDATE `creature_template` SET speed_walk = 1, speed_run = 1 WHERE entry =39189; 
UPDATE `creature_template` SET speed_walk = 0.5, speed_run = 0.5 WHERE entry =39189;

-- The Lich King: Wicked Spirit Scriptname
UPDATE `creature_template` SET `ScriptName` = 'npc_wicked_spirit' WHERE `entry` = 39190;
UPDATE `creature_template` SET `unit_flags` = `unit_flags` |512 WHERE `entry` IN (39190, 39287, 39288, 39289);
