DELETE FROM `creature_equip_template` WHERE `entry` IN (32576);
INSERT INTO `creature_equip_template` VALUES (32576,1,18310,0,0);
UPDATE `creature_template` SET `AIName`='',`scriptname` = 'npc_kvaldir_mist_lord' WHERE `entry` IN (25496);
UPDATE `creature_template` SET `AIName`='',`scriptname` = 'npc_kvaldir_mistweaver' WHERE `entry` IN (25479);
