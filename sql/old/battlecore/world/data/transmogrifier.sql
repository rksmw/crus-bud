SET @CREATURE_GUID = 10000000;
SET @TRANSMOGRIFIER_ENTRY = 5000004;
SET @TRANSMOGRIFIER_NAME = 'Warpweaver';
SET @EVENT_ID = 47;

DELETE FROM `creature_template` WHERE `entry` = @TRANSMOGRIFIER_ENTRY;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`,  `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES
(@TRANSMOGRIFIER_ENTRY, 0, 0, 0, 0, 0, 19646, 0, 0, 0, @TRANSMOGRIFIER_NAME, 'Transmogrifier', NULL, 0, 80, 80, 2, 35, 35, 1, 1, 1.14286, 1, 0, 500, 500, 0, 350, 1, 2000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,'NPC_Transmogrify', 1);

DELETE FROM `battlecl_event` WHERE `id` = @EVENT_ID;
INSERT INTO `battlecl_event` (`id`, `name`, `map`, `x`, `y`, `z`, `visible`, `time`) VALUES
(@EVENT_ID, 'Transmogrifier', 571, 5806.99, 613.12, 609.159, 1, 0);

DELETE FROM `battlecl_event_creature` WHERE `id` = @EVENT_ID;
INSERT INTO `battlecl_event_creature` (`id`, `creature`, `account`) VALUES
(@EVENT_ID, @CREATURE_GUID+3681, 1);

DELETE FROM `creature`  WHERE `guid` = @CREATURE_GUID+3681; 
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@CREATURE_GUID+3681, @TRANSMOGRIFIER_ENTRY, 571, 1, 2, 0, 0, 5806.99, 613.12, 609.159, 2.12185, 300, 0, 0, 12600, 0, 0, 0, 0, 0);

DELETE FROM `trinity_string` WHERE `entry` BETWEEN 11100 AND 11129;
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`)  VALUES 
(11100, 'Transmodificaciones removidas del equipo equipado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11101, 'No tienes items transmodificados equipados', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11102, '%s transmodificacion removida', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11103, 'Ninguna transmodificacion %s slot', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11104, '%s Transfigurado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11105, 'El item seleccionado no es el adecuado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11106, 'El item seleccionado no existe', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11107, 'La ranura para equipar esta vacia', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11108, 'Head', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11109, 'Shoulders', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11110, 'Shirt', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11111, 'Chest', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11112, 'Waist', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11113, 'Legs', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11114, 'Feet', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11115, 'Wrists', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11116, 'Hands', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11117, 'Back', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11118, 'Main hand', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11119, 'Off hand', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11120, 'Ranged', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11121, 'Tabard', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11122, 'Back..', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11123, 'Remover todas las transfiguraciones', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11124, 'Remover todas las transfiguraciones del equipo equipado?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11125, 'Actualizar Menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11126, 'Remover transmodificacion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11127, 'Remover transmodificacion desde %s?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11128, 'El uso de esta articulo para transmodificar tu equipo, se unira a ti y no será comerciable ni reemmbolsable.\\r\nDo you wish to continue?\r\n\r\n', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11129, 'No posees tanto dinero %ss', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
