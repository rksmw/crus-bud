DELETE FROM `trinity_string` WHERE `entry` IN(711, 712);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`)
VALUES
    (711, '|cffff0000[%s Queue]:|r %s (%u - %u) A: %u/%u H: %u/%u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    (712, '|cffff0000[%s Queue]:|r %s (%u - %u) A: %u/%u H: %u/%u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

SET @ENTRY := 5000000;
DELETE FROM `creature_template` WHERE `entry` = @ENTRY+24;
INSERT INTO `creature_template` VALUES (@ENTRY+24, 0, 0, 0, 0, 0, 28213, 0, 0, 0, 'GuildWars', 'BattleCore', 'Speak', 50001, 71, 71, 2, 35, 35, 1, 1, 1.14286, 1.25, 1, 124, 256, 0, 783, 1, 2000, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 138936390, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.56, 1.56, 1.56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 'npc_battlemaster_guildwars', 12340);
