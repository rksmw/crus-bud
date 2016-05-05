DELETE FROM `creature_text` WHERE `entry`='26832';
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(26832, 0, 0, "Deal with this Interruption, Keldonus. After you are through, bring me the head of the one they call $N. I will decorate my chambers with his skill.", 12, 0, 100, 0, 0, 0, 'Magister Kedonus - Entercombat say'),
(26832, 1, 0, "This transgression against the Blue Dragonflight has been noted. I will take extra pleasure in separating the life energy from your body!", 12, 0, 100, 0, 0, 0, 'Magister Kedonus - Ondead say'),
(26832, 2, 0, "You have done well, Keldonus. Lord Malygos will be quite pleased with your process.", 12, 0, 100, 0, 0, 0, 'Magister Kedonus - Say 3');

DELETE FROM `creature_text` WHERE `entry`='26828';
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(26828, 0, 0, "You test my patience, you now see the true might of the Blue.", 12, 0, 100, 0, 0, 0, 'Magister Kedonus - Combat 1'),
(26828, 1, 0, "My lady, the surge needle is fully operational.", 12, 0, 100, 0, 0, 0, 'Magister Kedonus - Say 1'),
(26828, 2, 0, "The ley line beneath this night elf temple is now flowing into the Azure Dragonshrine. Our brothers should have all the power they need to crush our enemies.", 12, 0, 100, 0, 0, 0, 'Magister Kedonus - Say 2'),
(26828, 3, 0, "I live only to serve the master, my lady.", 12, 0, 100, 0, 0, 0, 'Magister Kedonus - Say 4');

UPDATE `creature_template` SET `scriptname` = 'npc_magister_keldonus', `ainame` = '' WHERE `entry` IN (26828);

DELETE FROM `locales_creature_text` WHERE `entry` = '26828';
INSERT INTO `locales_creature_text` (`entry`, `groupid`, `id`, `text_loc1`, `text_loc2`, `text_loc3`, `text_loc4`, `text_loc5`, `text_loc6`, `text_loc7`, `text_loc8`) VALUES
('26828','0','0',NULL,NULL,NULL,NULL,NULL,NULL,"Pones a prueba mi paciencia, ahora verás el verdadero poder del Azul.",NULL),
('26828','1','0',NULL,NULL,NULL,NULL,NULL,NULL,"Mi señora, la Aguja de Flujo funciona a la perfección.",NULL),
('26828','2','0',NULL,NULL,NULL,NULL,NULL,NULL,"La línea Ley bajo este templo de los elfos de la noche fluye ahora hacia el Santuario de Dragones Azur. Nuestros hermanos deberían tener todo el poder necesario para aplastar a nuestros enemigos.",NULL),
('26828','3','0',NULL,NULL,NULL,NULL,NULL,NULL,"Solo vivo para servir al maestro, mi señora.",NULL);

DELETE FROM `locales_creature_text` WHERE `entry` = '26832';
INSERT INTO `locales_creature_text` (`entry`, `groupid`, `id`, `text_loc1`, `text_loc2`, `text_loc3`, `text_loc4`, `text_loc5`, `text_loc6`, `text_loc7`, `text_loc8`) VALUES
('26832','0','0',NULL,NULL,NULL,NULL,NULL,NULL,"Encárgate de esta interrupción, Keldonus. Cuando hayas terminado, tráeme la cabeza de aquel a quien llaman $N. Decoraré mis aposentos con su calavera.",NULL),
('26832','1','0',NULL,NULL,NULL,NULL,NULL,NULL,"Hemos tomado nota de esta infracción en contra del Vuelo Azul. ¡Me resultará muy placentero separar la energia vital de tu cuerpo!",NULL),
('26832','2','0',NULL,NULL,NULL,NULL,NULL,NULL,"Lo has hecho bien, Keldonus. Lord Malygos estará muy satisfecho con tu progreso.",NULL);

UPDATE `creature_template` SET `InhabitType` = '4',`scriptname`='npc_grand_magus_telestra' WHERE `entry` IN (26832);

DELETE FROM `creature_addon` WHERE `guid` IN (115057);
INSERT INTO `creature_addon` VALUES
('115057','0','0','8','0','0','');

UPDATE `creature` SET `position_x` = '3170.38',`position_y` = '2444.58',`position_z` = '40.3566',`orientation` = '0.00305271' WHERE `guid` IN (115486);
