SET @ENTRY := 201818;
DELETE FROM `gameobject` WHERE `id` = @ENTRY;
INSERT INTO `gameobject` VALUES (NULL, @ENTRY, 631, 15, 1, 4149.16, 2779.66, 350.963, 6.27123, 0, 0, 0.00597703, -0.999982, 604800, 0, 1);
UPDATE `gameobject_template` SET `faction` = 14, `ScriptName` = 'go_icc_inconspicuous_lever' WHERE `entry` = @ENTRY;
