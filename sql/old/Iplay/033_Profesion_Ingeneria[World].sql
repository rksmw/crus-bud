-- Book "Soothsaying for Dummies" script
UPDATE `gameobject_template` SET `ScriptName`='obj_soothsaying_for_dummies' WHERE `entry`=177226;
-- Book "Soothsaying for Dummies" gossip menu text
DELETE FROM `gossip_menu` WHERE `entry` IN (7058);
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES (7058, 8321);
