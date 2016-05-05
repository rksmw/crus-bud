SET @ENTRY_RANGE := 5000000;
DELETE FROM `creature_template` WHERE `entry` = @ENTRY_RANGE+17;
DELETE FROM `creature` WHERE `id` = @ENTRY_RANGE+17;

DELETE FROM `trinity_string` WHERE `entry` = 873;
