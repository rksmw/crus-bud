DELETE FROM `creature_text` WHERE `entry` IN (26280);
INSERT INTO `creature_text` VALUES
('26280','0','0',"The master will be with you momentarily.",'12','0','0','0','0','0','SAY_00'),
('26280','0','1',"No.",'12','0','0','0','0','0','SAY_00'),
('26280','0','2',"I cannot.",'12','0','0','0','0','0','SAY_00'),
('26280','0','3',"The master will be with you momentarily.",'12','0','0','0','0','0','SAY_00'),
('26280','0','4',"My orders are that you must wait here.",'12','0','0','0','0','0','SAY_00'),
('26280','0','5',"It won't be long now.",'12','0','0','0','0','0','SAY_00');

DELETE FROM `creature_text` WHERE `entry` IN (26496);
INSERT INTO `creature_text` VALUES
('26496','0','0',"You are nothing but an underling! I will not wait a moment longer! Escort me to Goramosh immediately!",'12','0','0','0','0','0','SAY_00'),
('26496','0','1',"I was personally assured by Malygos that your commander would make the details of this accord his top priority. Now let me pass!",'12','0','0','0','0','0','SAY_00'),
('26496','0','2',"Yes, yes. I am given to understand that the ley fine has already been diverted. I will wait no longer... summon Goramosh this instant!",'12','0','0','0','0','0','SAY_00'),
('26496','0','3',"You will tell your commander that I will not wait a moment longer! Does he want this alliance or not?!",'12','0','0','0','0','0','SAY_00'),
('26496','0','4',"If I have to wait much longer, I will be forced to reconsider  the proposed accord between the Ethereum and the Blue Dragonblight!",'12','0','0','0','0','0','SAY_00');

DELETE FROM `locales_creature_text` WHERE `entry` = '26496';
INSERT INTO `locales_creature_text` (`entry`, `groupid`, `id`, `text_loc1`, `text_loc2`, `text_loc3`, `text_loc4`, `text_loc5`, `text_loc6`, `text_loc7`, `text_loc8`) VALUES
('26496','0','0',NULL,NULL,NULL,NULL,NULL,NULL,"Tu aguja de flujo ha funcionado a la perfección. ¿Seguro que Goramosh tiene tiempo para continuar hablando del acuerdo propuesto?.",NULL),
('26496','0','1',NULL,NULL,NULL,NULL,NULL,NULL,'¡He esperado una eternidad desde nuestra última reunión! ¿Cuándo acabará Goramosh con su ritual?',NULL),
('26496','0','2',NULL,NULL,NULL,NULL,NULL,NULL,'¡No eres más que un subordinado! ¡No esperaré más! ¡Llévame ante Goramosh inmediatamente!',NULL),
('26496','0','3',NULL,NULL,NULL,NULL,NULL,NULL,'¡Esto es insufrible! ¡Represento a un Príncipe-nexo, no debería tener que esperar! ¡Goramosh debería estar esperándome a mí!',NULL),
('26496','0','4',NULL,NULL,NULL,NULL,NULL,NULL,'Malygos me aseguró personalmente que tu comandante convertiría los detalles de este acuerdo en su principal prioidad. ¡Ahora déjame pasar!',NULL);

DELETE FROM `locales_creature_text` WHERE `entry` = '26280';
INSERT INTO `locales_creature_text` (`entry`, `groupid`, `id`, `text_loc1`, `text_loc2`, `text_loc3`, `text_loc4`, `text_loc5`, `text_loc6`, `text_loc7`, `text_loc8`) VALUES
('26280','0','0',NULL,NULL,NULL,NULL,NULL,NULL,"Tendrás que tener paciencia..",NULL),
('26280','0','1',NULL,NULL,NULL,NULL,NULL,NULL,'El maestro estará contigo en un momento.',NULL),
('26280','0','2',NULL,NULL,NULL,NULL,NULL,NULL,'No puedo.',NULL),
('26280','0','3',NULL,NULL,NULL,NULL,NULL,NULL,'Mis disculpas, embajador. Tengo órdenes precisas.',NULL),
('26280','0','4',NULL,NULL,NULL,NULL,NULL,NULL,'No.',NULL),
('26280','0','5',NULL,NULL,NULL,NULL,NULL,NULL,'No tardará mucho.',NULL);

UPDATE creature_template SET scriptname = 'npc_wind_trader_mufah',AIName='' WHERE entry = 26496;
UPDATE creature_template SET scriptname = 'npc_surge_needle_sorcerer',AIName='' WHERE entry =26257;
UPDATE creature_template SET scriptname = 'npc_goramosh',AIName='' WHERE entry =26349;
DELETE FROM `creature_template`  WHERE `entry` = '190009';
INSERT INTO `creature_template` VALUES('190009','0','0','0','0','0','10045','0','0','0',"Moonrest Gardens Dummy",'Visual',NULL,'0','1','80','0','35','35','0','0.91','1.14286','1','0','422','586','0','642','1','2000','2200','1','0','2048','0','0','0','0','0','0','345','509','103','8','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','4','1','0.0125','1','1','0','0','0','0','0','0','0','0','1','0','130','','1');
delete from creature where id = 190009;
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values('190009','571','1','1','0','0','3337.55','2516.33','77.234','1.79769','300','0','0','13','0','0','0','33554432','0');
DELETE FROM creature_template_addon WHERE entry = 190009;
INSERT INTO creature_template_addon VALUES (190009,0,0,0,0,0,'52485');
