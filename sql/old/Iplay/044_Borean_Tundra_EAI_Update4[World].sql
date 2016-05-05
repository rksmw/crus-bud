UPDATE `creature_template` SET `scriptname` ='npc_bloodspore_harvester' WHERE `entry` IN (25467);
UPDATE `creature_template` SET `scriptname` ='npc_bloodspore_roaster' WHERE `entry` IN (25468);
UPDATE `creature_template` SET `scriptname` ='npc_bloodspore_moth' WHERE `entry` IN (25464);
UPDATE `creature_template` SET `scriptname` ='npc_beryl_mage_hunter' WHERE `entry` IN (25585);
UPDATE `creature_template` SET `scriptname`='npc_arcane_prisoner' WHERE `entry` IN (25320);
UPDATE `creature_template` SET `scriptname`='npc_arcane_prisoner' WHERE `entry` IN (25318);
DELETE FROM `creature_text` WHERE `entry` IN ('25320','25318');
INSERT INTO `creature_text` VALUES
('25320','1','0',"You've saved me. $C. Thank you!",'12','0','0','0','0','0','SAY_ARCANE_PRISONE_DESPAWN'),
('25318','1','0',"You've saved me. $C. Thank you!",'12','0','0','0','0','0','SAY_ARCANE_PRISONE_DESPAWN');
