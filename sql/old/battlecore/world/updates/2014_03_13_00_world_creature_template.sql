-- Quest - Get the key
UPDATE `creature_template` SET `faction_A`=16,`faction_H`=16 WHERE `entry`=29915;
DELETE FROM `creature_loot_template` WHERE `entry`=29915 AND `item` IN (41843,43089,43851,33470);
INSERT INTO `creature_loot_template`(`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(29915,41843,-100,1,0,1,1),
(29915,43089,70,1,0,1,1),
(29915,43851,17,1,0,1,1),
(29915,33470,15,1,0,1,4);
