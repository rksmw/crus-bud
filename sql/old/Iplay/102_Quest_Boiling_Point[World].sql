UPDATE creature_template SET scriptname = 'npc_boiling_spirit' WHERE entry IN (25419);
UPDATE creature_template SET scriptname = 'npc_enraged_tempest' WHERE entry = '25415';
UPDATE creature_template SET scriptname = 'npc_churn',ainame='' WHERE entry = '25418';
UPDATE creature_template SET scriptname = 'npc_simmer',ainame='' WHERE entry = '25416';
UPDATE creature_template SET scriptname = 'npc_raging_boiler',ainame='' WHERE entry = '25417';

DELETE FROM `creature_text` WHERE `entry` IN (25418);
INSERT INTO `creature_text` VALUES
('25418','0','0',"You dare come into my pool?!",'12','0','0','0','0','0','SAY_00'),
('25418','0','1',"Your corpse will feed my fish.",'12','0','0','0','0','0','SAY_00'),
('25418','0','2',"Your death will not be pleasant!",'12','0','0','0','0','0','SAY_00'),
('25418','0','3',"I will crush you under the weight of my waves!",'12','0','0','0','0','0','SAY_00'),
('25418','1','0',"WAIT... NO MORE!",'12','0','0','0','0','0','SAY_01'),
('25418','2','0',"I... submit. As long as Simmer agrees to stop boilling by pool, I agree to an armistice.",'12','0','0','0','0','0','SAY_01'),
('25418','3','0',"Now, remove yourself from my presence. You would be wise not to come within sight of me again.",'12','0','0','0','0','0','SAY_01');

DELETE FROM `locales_creature_text` WHERE `entry` IN (25418,25209);
INSERT INTO `locales_creature_text` (`entry`, `groupid`, `id`, `text_loc1`, `text_loc2`, `text_loc3`, `text_loc4`, `text_loc5`, `text_loc6`, `text_loc7`, `text_loc8`) VALUES
('25418','0','0',NULL,NULL,NULL,NULL,NULL,NULL,"Tu cadáver alimentará a mis peces.",NULL),
('25418','0','1',NULL,NULL,NULL,NULL,NULL,NULL,"¡Tu muerte no será agradable!",NULL),
('25418','0','2',NULL,NULL,NULL,NULL,NULL,NULL,"!¿Osas entrar a mi poza!?",NULL),
('25418','0','3',NULL,NULL,NULL,NULL,NULL,NULL,"¡Te aplastaré bajo el peso de mis olas!",NULL),
('25209','1','0',NULL,NULL,NULL,NULL,NULL,NULL,'ESPERA... ¡BASTA!',NULL),
('25209','2','0',NULL,NULL,NULL,NULL,NULL,NULL,'Me... rindo. Siempre y cuando Cocer acepte dejar de hacer que mi charca hierva, estaré de acuerdo con el armisticio.',NULL),
('25209','3','0',NULL,NULL,NULL,NULL,NULL,NULL,'Ahora, desaparece de mi vista. Si sabes lo que te conviene, no volverás a presentarte ante mí.',NULL);

DELETE FROM `creature_text` WHERE `entry` IN (25416);
INSERT INTO `creature_text` VALUES
('25416','0','0',"Who dares?!",'12','0','0','0','0','0','SAY_00'),
('25416','0','1',"I will turn your bones to ash!",'12','0','0','0','0','0','SAY_00'),
('25416','0','2',"There is no escape from my rise!",'12','0','0','0','0','0','SAY_00'),
('25416','0','3',"You will be consumed!",'12','0','0','0','0','0','SAY_00'),
('25416','1','0',"STOP!",'12','0','0','0','0','0','SAY_01'),
('25416','2','0',"Tell Imperean that I will consider a cessation of hostilities. But first, Churn must stop his watery intrusions upon my rise!",'12','0','0','0','0','0','SAY_01'),
('25416','3','0',"I grow bored with you. Begone!",'12','0','0','0','0','0','SAY_01');

DELETE FROM `locales_creature_text` WHERE `entry` = '25416';
INSERT INTO `locales_creature_text` (`entry`, `groupid`, `id`, `text_loc1`, `text_loc2`, `text_loc3`, `text_loc4`, `text_loc5`, `text_loc6`, `text_loc7`, `text_loc8`) VALUES
('25416','0','0',NULL,NULL,NULL,NULL,NULL,NULL,"¡Convertiré tus huesos en ceniza!",NULL),
('25416','0','1',NULL,NULL,NULL,NULL,NULL,NULL,"¡Serás consumido!",NULL),
('25416','0','2',NULL,NULL,NULL,NULL,NULL,NULL,"¡¿Quién se atreve?!",NULL),
('25416','0','3',NULL,NULL,NULL,NULL,NULL,NULL,"¡No puedes escapar de mí!",NULL),
('25416','1','0',NULL,NULL,NULL,NULL,NULL,NULL,'¡ALTO!',NULL),
('25416','2','0',NULL,NULL,NULL,NULL,NULL,NULL,'Díle a Imperean que consideraré un cese de las hostilidades. ¡Pero primero, Xurn tiene que abandonar sus intromisiones acuáticas en mi colina!',NULL),
('25416','3','0',NULL,NULL,NULL,NULL,NULL,NULL,'Me aburres. ¡Vere!',NULL);
