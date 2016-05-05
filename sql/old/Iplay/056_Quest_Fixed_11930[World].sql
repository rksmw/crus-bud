DELETE FROM `creature_text` WHERE `entry` IN (26167);
INSERT INTO `creature_text` VALUES
('26167','0','0',"I was raised on this land... taught to hunt on this very tundra.",'12','0','0','0','0','0','SAY_00'),
('26167','1','0',"I... I don't think I can make it...",'12','0','0','0','0','0','SAY_01'),
('26167','2','0',"Give me a moment to catch my breath.",'12','0','0','0','0','0','SAY_02'),
('26167','3','0',"Taunka'le Evacuee cries.",'16','0','0','0','0','0','SAY_03'),
('26167','4','0',"Taunka'le Evacuee points northeast.",'16','0','0','0','0','0','SAY_04'),
('26167','5','0',"The smoke in the distance... It is Wartook. He is trying to tell us something...",'12','0','0','0','0','0','SAY_05'),
('26167','6','0',"Taunka'le Evacuee expertly identifies the messages hidden within the smoke signals.",'16','0','0','0','0','0','SAY_06'),
('26167','7','0',"No... It cannot be true...",'12','0','0','0','0','0','SAY_07'),
('26167','8','0',"Icemist... Not Icemist... NO!!! Come quickly, hero! Follow me!",'12','0','0','0','0','0','SAY_08'),
('26167','9','0',"Look out!",'12','0','0','0','0','0','SAY_09');
DELETE FROM `locales_creature_text` WHERE `entry` = '26167';
INSERT INTO `locales_creature_text` (`entry`, `groupid`, `id`, `text_loc1`, `text_loc2`, `text_loc3`, `text_loc4`, `text_loc5`, `text_loc6`, `text_loc7`, `text_loc8`) VALUES
('26167','0','0',NULL,NULL,NULL,NULL,NULL,NULL,'Crecí en esta tierra... aprendí a cazar en esta misma tundra.',NULL),
('26167','1','0',NULL,NULL,NULL,NULL,NULL,NULL,'No... no creo que pueda conseguirlo...',NULL),
('26167','2','0',NULL,NULL,NULL,NULL,NULL,NULL,'Dame un momento para recobrar el aliento.',NULL),
('26167','3','0',NULL,NULL,NULL,NULL,NULL,NULL,"Evacuada de Taunka'le llora.",NULL),
('26167','4','0',NULL,NULL,NULL,NULL,NULL,NULL,"Evacuada de Taunka'le señala hacia el noreste.",NULL),
('26167','5','0',NULL,NULL,NULL,NULL,NULL,NULL,'El humo a lo lejos... es Guerratuk. Está íntentando decirnos algo...',NULL),
('26167','6','0',NULL,NULL,NULL,NULL,NULL,NULL,"Evacuada de Taunka'le decifra expertamente los mensajes escondidos en las señales de humo.",NULL),
('26167','7','0',NULL,NULL,NULL,NULL,NULL,NULL,'No... no puede ser cierto...',NULL),
('26167','8','0',NULL,NULL,NULL,NULL,NULL,NULL,'Bruma de Hielo... Bruma de Hielo no... ¡¡¡NO!!! Rápido. ¡sígueme!',NULL),
('26167','9','0',NULL,NULL,NULL,NULL,NULL,NULL,'¡Cuidado!',NULL);
DELETE FROM `creature_text` WHERE `entry` IN (26165);
INSERT INTO `creature_text` VALUES
('26165','0','0',"Death is the only Salvation...",'12','0','0','0','0','0','SAY_00'),
('26165','0','1',"There is no escape...",'12','0','0','0','0','0','SAY_02');
DELETE FROM `locales_creature_text` WHERE `entry` IN (26165);
INSERT INTO `locales_creature_text` (`entry`, `groupid`, `id`, `text_loc1`, `text_loc2`, `text_loc3`, `text_loc4`, `text_loc5`, `text_loc6`, `text_loc7`, `text_loc8`) VALUES
('26165','0','0',NULL,NULL,NULL,NULL,NULL,NULL,'La muerte es la única salvación...',NULL),
('26165','0','1',NULL,NULL,NULL,NULL,NULL,NULL,'No te resistas...',NULL);
UPDATE `creature_template` SET `scriptname` = 'npc_taunkale_evacuee' WHERE `entry` = '26167';
UPDATE `creature_template` SET `scriptname` = 'npc_mother_tauranook' WHERE `entry` = '26158';
