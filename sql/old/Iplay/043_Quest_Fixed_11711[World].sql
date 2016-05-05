UPDATE `item_template` SET `scriptname` ='item_warsong_flare_gun' WHERE `entry` IN (34971);
UPDATE `creature_template` SET `scriptname` ='npc_valiance_keep_officer' WHERE `entry` IN (25759);
UPDATE `creature_template` SET `scriptname` ='npc_warden_nork_bloodfrenzy' WHERE `entry` IN (25379);
DELETE FROM `creature_text` WHERE `entry` IN (25759);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(25759,0,0,"Thank you, $r. I will take this miserable cur from you now.",12,0,100,0,0,0, "Valient Keep Officer 1");
DELETE FROM `creature_template_addon` WHERE `entry` IN (25759);
INSERT INTO `creature_template_addon` VALUES (25759,0,14584,0,0,0,'');
