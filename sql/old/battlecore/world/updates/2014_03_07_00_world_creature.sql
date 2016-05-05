DELETE FROM `creature` WHERE `guid` IN(85488, 130406, 130407, 130409);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`)
VALUES
    (85488, 22466, 530, 1, 1, 0, 0, -3552.84, 5457.76, -11.6149, 5.09984, 450, 0, 0, 5715, 0, 0, 0, 0, 0),
    (130406, 29199, 609, 1, 128, 25446, 1, 2438.45, -5137.02, 82.6968, 4.13643, 360, 0, 0, 2489500, 0, 0, 0, 0, 0),
    (130407, 29200, 609, 1, 128, 25447, 1, 2431.82, -5130.47, 83.3011, 4.04916, 360, 0, 0, 2489500, 0, 0, 0, 0, 0),
    (130409, 29204, 609, 1, 128, 25448, 1, 2436.04, -5132.31, 82.8884, 3.90954, 360, 0, 0, 2489500, 0, 0, 0, 0, 0);
