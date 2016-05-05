SET @ENTRY := 38879;
UPDATE `creature_template` SET `ScriptName` = 'npc_putricide_trap' WHERE `entry` = @ENTRY; -- UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `unit_flags` = 0, `flags_extra` = 128, `ScriptName` = 'npc_sindragosas_ward' WHERE `entry` = @ENTRY;
DELETE FROM `areatrigger_scripts` WHERE `entry` = 5647;
INSERT INTO `areatrigger_scripts` VALUES (5647, 'at_icc_start_putricide_gauntlet');
UPDATE `creature_template` SET `type` = 1 WHERE `entry` = 37782;
DELETE FROM `creature` WHERE `id` = 37782;
