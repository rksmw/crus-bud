SET @CREATURE_GUID = 10000000;
SET @REDEEM_ENRTY = 5000002;
SET @EVENT_ID = 45;

DELETE FROM `creature_template` WHERE `entry` = @REDEEM_ENRTY;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES
(@REDEEM_ENRTY, 0, 0, 0, 0, 0, 21723, 0, 0, 0, 'Redeem', '', '', 0, 80, 80, 2, 35, 35, 1, 1, 1.14286, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1000, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_store', 1);

DELETE FROM `battlecl_event` WHERE `id` = @EVENT_ID;
INSERT INTO `battlecl_event` (`id`, `name`, `map`, `x`, `y`, `z`, `visible`, `time`) VALUES
(@EVENT_ID, 'Redeem', 571, 5962.49, 628.616, 650.626, 1, 0);

DELETE FROM `battlecl_event_creature` WHERE `id` = @EVENT_ID;
INSERT INTO `battlecl_event_creature` (`id`, `creature`, `account`) VALUES
(@EVENT_ID, @CREATURE_GUID+3675, 1),
(@EVENT_ID, @CREATURE_GUID+3676, 1),
(@EVENT_ID, @CREATURE_GUID+3677, 1),
(@EVENT_ID, @CREATURE_GUID+3678, 1),
(@EVENT_ID, @CREATURE_GUID+3679, 1),
(@EVENT_ID, @CREATURE_GUID+3680, 1);

DELETE FROM `creature` WHERE `guid` BETWEEN @CREATURE_GUID+3675 AND @CREATURE_GUID+3680;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@CREATURE_GUID+3675, @REDEEM_ENRTY, 571, 1, 1, 0, 0, 5962.49, 628.616, 650.626, 5.91964, 300, 0, 0, 12600000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+3676, @REDEEM_ENRTY, 571, 1, 1, 0, 0, 5645.55, 672.466, 651.994, 2.75763, 300, 0, 0, 12600000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+3677, @REDEEM_ENRTY, 0, 1, 1, 0, 0, -8913.63, 633.772, 99.523, 3.63753, 300, 0, 0, 12600000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+3678, @REDEEM_ENRTY, 0, 1, 1, 0, 0, -8905.31, 619.836, 99.523, 3.65324, 300, 0, 0, 12600000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+3679, @REDEEM_ENRTY, 1, 1, 1, 0, 0, 1616.38, -4369.47, 12.5605, 6.00276, 300, 0, 0, 12600000, 0, 0, 0, 0, 0),
(@CREATURE_GUID+3680, @REDEEM_ENRTY, 1, 1, 1, 0, 0, 1621.57, -4384.77, 12.5248, 1.34408, 300, 0, 0, 12600000, 0, 0, 0, 0, 0);
