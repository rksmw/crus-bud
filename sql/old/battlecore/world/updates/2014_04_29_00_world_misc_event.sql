-- Game Event - Children's Week
DELETE FROM `game_event_seasonal_questrelation` WHERE `eventEntry`=10;
INSERT INTO `game_event_seasonal_questrelation` (`questId`, `eventEntry`) VALUES
-- Orgrimmar orphan quest 
(172, 10), 
(910, 10), 
(911, 10), 
(1800, 10), 
(915, 10), 
(925, 10), 
(5502, 10), 
-- Stormwind orphan quest 
(1468, 10), 
(1687, 10), 
(1558, 10), 
(1479, 10), 
(4822, 10), 
(558, 10), 
(171, 10), 
-- Blood Elf orphan quest 
(10942, 10), 
(10945, 10), 
(10953, 10), 
(10951, 10),
(11975, 10), 
(10963, 10), 
(10967, 10), 
-- Draenei orphan quest 
(10943, 10), 
(10950, 10),
(10954, 10), 
(10952, 10),
(10956, 10), 
(10962, 10), 
(10966, 10), 
-- Wolvar quest 
(13927, 10), 
(13930, 10), 
(13934, 10), 
(13951, 10), 
(13955, 10), 
(13957, 10), 
(13938, 10),  
(13960, 10),  
-- Oracle quest 
(13926, 10), 
(13929, 10),  
(13950, 10),  
(13933, 10),  
(13956, 10),  
(13954, 10), 
(13937, 10),  
(13959, 10);

-- Orphan Matron Aria gossip conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=10502 AND `SourceEntry` IN (2,3);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,10502,2,0,0,2,0,46397,1,0,1,0,0,'','Must not have item 46397'),
(15,10502,2,0,0,8,0,13926,0,0,0,0,0,'','Quest 13926 must be rewarded'),
(15,10502,2,0,0,12,0,10,0,0,0,0,0,'','Childrens Week must be active'),
(15,10502,2,0,0,8,0,13959,0,0,1,0,0,'','Quest 13959 must not be rewarded'),
(15,10502,3,0,0,2,0,46396,1,0,1,0,0,'','Must not have item 46396'),
(15,10502,3,0,0,8,0,13927,0,0,0,0,0,'','Quest 13927 must be rewarded'),
(15,10502,3,0,0,12,0,10,0,0,0,0,0,'','Childrens Week must be active'),
(15,10502,2,0,0,8,0,13960,0,0,1,0,0,'','Quest 13960 must not be rewarded');

-- Orphan Matron Mercy gossip conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=8568;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,8568,1,0,0,2,0,31880,1,0,1,0,0,'','Must not have item 31880'),
(15,8568,1,0,0,8,0,10942,0,0,0,0,0,'','Quest 10942 must be rewarded'),
(15,8568,1,0,0,12,0,10,0,0,0,0,0,'','Childrens Week must be active'),
(15,8568,1,0,0,8,0,10967,0,0,1,0,0,'','Quest 10967 must not be rewarded'),
(15,8568,2,0,0,2,0,31881,1,0,1,0,0,'','Must not have item 31881'),
(15,8568,2,0,0,8,0,10943,0,0,0,0,0,'','Quest 10943 must be rewarded'),
(15,8568,2,0,0,12,0,10,0,0,0,0,0,'','Childrens Week must be active'),
(15,8568,2,0,0,8,0,10966,0,0,1,0,0,'','Quest 10966 must not be rewarded');

-- Orphan Matron Nightingale gossip conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=5849;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,5849,1,0,0,2,0,18598,1,0,1,0,0,'','Must not have item 18598'),
(15,5849,1,0,0,8,0,1468,0,0,0,0,0,'','Quest 1468 must be rewarded'),
(15,5849,1,0,0,12,0,10,0,0,0,0,0,'','Childrens Week must be active'),
(15,5849,1,0,0,8,0,171,0,0,1,0,0,'','Quest 171 must not be rewarded');

-- Orphan Matron Battlewail
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=5848;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,5848,1,0,0,2,0,18597,1,0,1,0,0,'','Must not have item 18597'),
(15,5848,1,0,0,8,0,172,0,0,0,0,0,'','Quest 172 must be rewarded'),
(15,5848,1,0,0,12,0,10,0,0,0,0,0,'','Childrens Week must be active'),
(15,5848,1,0,0,8,0,5502,0,0,1,0,0,'','Quest 5502 must not be rewarded');

-- Add mail reward for Oracle and Wolvar chains
UPDATE `quest_template` SET `RewardMailTemplateId`=269, `RewardMailDelay`=21600 WHERE `Id`=13959;
UPDATE `quest_template` SET `RewardMailTemplateId`=270, `RewardMailDelay`=21600 WHERE `Id`=13960;

DELETE FROM `mail_loot_template` WHERE `entry` IN (269,270);
INSERT INTO `mail_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(269,46545,100,1,0,1,1),
(270,46544,100,1,0,1,1);
