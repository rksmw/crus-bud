-- Spawn missing TEMP Walt's Transport Rune (300167)
DELETE FROM `gameobject` WHERE `id` = 300167;
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) 
VALUES
('300167','571','1','1','479.08','-5942.37','308.757','1.56623','0','0','0.70549','0.70872','300','0','1');
