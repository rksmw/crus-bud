SET @GUID := 1000192;
-- Spawn Shaman Jakjek and Lightningcaller Soo-met
DELETE FROM `creature` WHERE `id` IN(28106,28107);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
(@CGUID+0, 28106, 571, 1, 1,  4869.281, 5912.271, -40.38539, 5.166174, 120, 0, 0), -- 28106 (Area: 3711)
(@CGUID+1, 28107, 571, 1, 1,  5116.647, 5469.729, -91.70967, 1.605703, 120, 0, 0); -- 28107 (Area: 3711)

DELETE FROM `creature_template_addon` WHERE `entry` IN(28106,28107);
INSERT INTO `creature_template_addon` (`entry`, `mount`, `bytes1`, `bytes2`, `auras`) VALUES
(28106, 0, 0x10000, 0x1, '52215'), -- 28106 - 52215
(28107, 0, 0x10000, 0x1, '52215'); -- 28107 - 52215

DELETE FROM `gossip_menu` WHERE `entry` IN(9744,9745);
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES
(9745, 13364), -- 28106
(9744, 13363); -- 28107
