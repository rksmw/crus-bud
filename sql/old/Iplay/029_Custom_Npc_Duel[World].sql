SET @entry :=5000000;

DELETE FROM `creature_template`  WHERE  `entry`=@entry+9;
INSERT INTO `creature_template` 
VALUES 
(@entry+9, 0, 0, 0, 0, 0, 29348, 0, 0, 0, 'BattleCore', 'Reta Tu Oponente', 'Speak', 50001, 71, 71, 2, 35, 35, 3, 1, 1.14286, 1.25, 1, 124, 256, 0, 783, 1, 2000, 0, 1, 2, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 138936390, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 168000, 190000, '', 0, 3, 1, 1.56, 1.56, 1.56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 'npc_blood_money', 12340);

-- DELETE FROM `creature` WHERE `id`=@entry+9;
-- INSERT INTO `creature` ( `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
-- (@entry+9, 571, 1, 1, 0, 0, 5812.49, 614.737, 609.158, 2.2903, 300, 0, 0, 14494, 0, 0, 0, 0, 0);
