SET @entry :=5000000;

DELETE FROM `creature_template`  WHERE `entry` =@entry+8;
INSERT INTO `creature_template` 
VALUES 
(@entry+8, 0, 0, 0, 0, 0, 25900, 0, 0, 0, 'BattleCore', 'Canjea Tus Items', 'Speak', 50001, 71, 71, 2, 35, 35, 3, 1, 1.14286, 1.25, 1, 124, 256, 0, 783, 1, 2000, 0, 1, 2, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 138936390, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 168000, 190000, '', 0, 3, 1, 1.56, 1.56, 1.56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 'Cambia_Npc', 12340);
UPDATE  `creature_template` SET  `modelid1` =  '25900', `scale` =  '3' WHERE  `entry` =@entry+8;
-- DELETE FROM `creature` WHERE `id`=@entry+8;
-- INSERT INTO `creature` ( `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
-- (@entry+8, 571, 1, 1, 0, 0, 5783.94, 639.581, 647.667, 5.96125, 300, 0, 0, 14494, 0, 0, 0, 0, 0);
