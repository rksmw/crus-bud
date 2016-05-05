UPDATE `creature_template` SET `scriptname` = 'npc_archmage_evanor' WHERE `entry` IN (25784);
UPDATE `gameobject_template` SET `scriptname` = 'go_evanors_prison' WHERE `entry` IN (187884);

DELETE FROM `creature_text` WHERE `entry` IN (25784);
INSERT INTO `creature_text` VALUES
('25784','0','0',"I thank you, friend of Dalaran.",'12','0','0','0','0','0','SAY_00'),
('25784','1','0',"We mustn't tarry here... stay close - I'll take us somewhere safe.",'12','0','0','0','0','0','SAY_01');

DELETE FROM `locales_creature_text` WHERE `entry` = '25784';
INSERT INTO `locales_creature_text` (`entry`, `groupid`, `id`, `text_loc1`, `text_loc2`, `text_loc3`, `text_loc4`, `text_loc5`, `text_loc6`, `text_loc7`, `text_loc8`) VALUES
('25784','0','0',NULL,NULL,NULL,NULL,NULL,NULL,"Gracias, camarada de Dalaran.",NULL),
('25784','1','0',NULL,NULL,NULL,NULL,NULL,NULL,"No debemos permanecer aquí... No os alejéis y os guiaré a algún lugar seguro.",NULL);
