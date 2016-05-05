-- UPDATE `quest_template` SET `requiredspellcast1` = '0' WHERE `id` IN (11677);
UPDATE `item_template` SET `scriptname` = 'item_highmesas_cleansing' WHERE `entry` IN (34913);
DELETE FROM `creature_template_addon` WHERE `entry` IN (25615);
INSERT INTO `creature_template_addon` VALUES
(25615,0,0,0,0,0,50366);
