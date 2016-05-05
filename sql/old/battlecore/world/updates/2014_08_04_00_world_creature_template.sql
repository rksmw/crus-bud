-- ICC Normal: Originalmente speed_walk=0.8, speed_run=0.28571
UPDATE `creature_template` SET `speed_walk`=0.18571, `speed_run`=0.18571 WHERE `entry` IN (38454, 38775);
-- ICC Hero: Originalmente speed_walk=0.8, speed_run=0.28571
UPDATE `creature_template` SET `speed_walk`=0.28571, `speed_run`=0.28571 WHERE `entry` IN (38776, 38777);
