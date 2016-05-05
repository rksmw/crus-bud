SET @ENTRY := 26503;
SET @ITEM := 35803;

DELETE FROM `creature_loot_template` WHERE `entry`=@ENTRY;
UPDATE `creature_template` SET `lootid`=@ENTRY WHERE `entry`=@ENTRY;
INSERT INTO creature_loot_template (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@ENTRY,@ITEM,'-100','1','0','1','1');
