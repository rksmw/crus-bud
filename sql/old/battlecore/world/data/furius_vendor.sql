SET @CREATURE_GUID = 10000000;
SET @FURIUS_VENDOR_ENTRY = 5000003;
SET @EVENT_ID = 46;

DELETE FROM `creature_template` WHERE `entry` = @FURIUS_VENDOR_ENTRY;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES
(@FURIUS_VENDOR_ENTRY, 0, 0, 0, 0, 0, 3705, 0, 0, 0, 'Armas Furius', 'Staff WoWCL', NULL, 0, 80, 80, 0, 35, 35, 128, 1, 1.14286, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 1);

DELETE FROM `npc_vendor` WHERE `entry` = @FURIUS_VENDOR_ENTRY;
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES
(@FURIUS_VENDOR_ENTRY, 0, 42209, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42228, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42233, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42243, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42249, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42256, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42261, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42266, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42271, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42276, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42281, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42286, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42291, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42318, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42323, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42328, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42333, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42347, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42353, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42364, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42385, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42451, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42486, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42491, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42496, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42503, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42514, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42520, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42526, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42532, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42538, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42560, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42565, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 42571, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 44421, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 44422, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45937, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45938, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45939, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45948, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45949, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45950, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45951, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45952, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45953, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45954, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45955, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45956, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45957, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45958, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45959, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45960, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45961, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45962, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45963, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45964, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45965, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45966, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45967, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45968, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45969, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45970, 0, 0, 2960),
(@FURIUS_VENDOR_ENTRY, 0, 45971, 0, 0, 2960);

DELETE FROM `battlecl_event` WHERE `id` = @EVENT_ID;
INSERT INTO `battlecl_event` (`id`, `name`, `map`, `x`, `y`, `z`, `visible`, `time`) VALUES
(@EVENT_ID, 'Furius Vendor', 1, 1663.04, -4203.2, 56.3824, 1, 0);

DELETE FROM `battlecl_event_creature` WHERE `id` = @EVENT_ID;
INSERT INTO `battlecl_event_creature` (`id`, `creature`, `account`) VALUES
(@EVENT_ID, @CREATURE_GUID+3673, 1),
(@EVENT_ID, @CREATURE_GUID+3674, 1);

DELETE FROM `creature` WHERE `guid` IN(@CREATURE_GUID+3673, @CREATURE_GUID+3674);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@CREATURE_GUID+3673, @FURIUS_VENDOR_ENTRY, 1, 1, 1, 0, 0, 1663.04, -4203.2, 56.3824, 0.472776, 300, 0, 0, 53420, 0, 0, 0, 0, 0),
(@CREATURE_GUID+3674, @FURIUS_VENDOR_ENTRY, 0, 1, 1, 0, 0, -8779.79, 420.589, 105.233, 5.5819, 300, 0, 0, 53420, 0, 0, 0, 0, 0);
