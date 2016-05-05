DELETE FROM `creature_template`  WHERE `entry` = '190008';
INSERT INTO `creature_template` VALUES('190008','0','0','0','0','0','10045','0','0','0',"Naxxanar Segundo Piso",'Visual',NULL,'0','1','80','0','35','35','0','0.91','1.14286','1','0','422','586','0','642','1','2000','2200','1','0','2048','0','0','0','0','0','0','345','509','103','8','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','4','1','0.0125','1','1','0','0','0','0','0','0','0','0','1','0','130','npc_naxxanar_segundo_piso','1');
UPDATE `creature_template` SET `scriptname` = 'npc_darkfallen_deathblade' WHERE `entry` = '26103';
DELETE FROM `creature` WHERE `id` IN (190008);
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) 
VALUES
('190008','571','1','1','0','0','3739.73','3566.97','341.567','2.77573','300','0','0','15','0','0','0','33554432','0');
