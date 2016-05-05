-- Icc adds putricidio
-- Ajuste de velocidades para babosas Gas Cloud de putricidio, amenorada la velocidad
-- Originalmente speed_walk=1
UPDATE `creature_template` SET `speed_walk`=0.68 WHERE `entry` IN (37562,38602,38760,38761);
