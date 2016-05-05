-- alliance loot
DELETE FROM `creature_loot_template` WHERE `entry`=1;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `mincountOrRef`, `maxcount`) VALUES
(1, 17306, 50, 2, 5),
(1, 17326, 30, 1, 1),
(1, 17327, 20, 1, 1),
(1, 17328, 10, 1, 1),
(1, 17422, 85, 15, 22),
(1, 18228, 1, 1, 1);

-- horde loot
DELETE FROM `creature_loot_template` WHERE `entry`=0;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `mincountOrRef`, `maxcount`) VALUES
(0, 17423, 50, 2, 5),
(0, 17502, 30, 1, 1),
(0, 17503, 20, 1, 1),
(0, 17504, 10, 1, 1),
(0, 17422, 85, 15, 22),
(0, 18228, 1, 1, 1);
