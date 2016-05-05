DELETE FROM `spell_script_names` WHERE `spell_id`=47190;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(47190, 'spell_q12028_toalu_spiritual_incense');

SET @CUSTOM := 5000000;
DELETE FROM `creature_template` WHERE `entry`=@CUSTOM+15;
INSERT INTO `creature_template` (`entry`,`modelid1`,`name`,`unit_flags`,`flags_extra`,`faction_A`,`faction_H`,`unit_class`,`AIName`) VALUES
(@CUSTOM+15,169,'Toalu\'u The Mystic',3355468,128,35,35,1,'');

UPDATE `creature_template` SET `InhabitType` = 7 WHERE `entry` = @CUSTOM+15;

UPDATE `creature_template` SET `Scriptname`  = 'npc_dummy_quest_12028' WHERE `entry` = @CUSTOM+15 ; 

DELETE FROM `creature` WHERE `id` =@CUSTOM+15;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) 
VALUES
('10003955','5000015','571','1','1','0','0','2737.86','882.485','6.46273','5.36552','300','0','0','42','0','0','0','36909900','0'),
('10003954','5000015','571','1','1','0','0','2701.04','1029.34','0.00257961','4.50407','300','0','0','42','0','0','0','36909900','0'),
('10003953','5000015','571','1','1','0','0','2718.34','1258.03','54.4049','4.46873','300','0','0','42','0','0','0','36909900','0'),
('10003952','5000015','571','1','1','0','0','3063.28','1550.72','148.663','4.98709','300','0','0','42','0','0','0','36909900','0'),
('10003951','5000015','571','1','1','0','0','2934.52','1404.49','151.634','1.87691','300','0','0','42','0','0','0','36909900','0'),
('10003950','5000015','571','1','1','0','0','2948.28','1273.02','151.047','3.70296','300','0','0','42','0','0','0','36909900','0'),
('10003949','5000015','571','1','1','0','0','3107.59','1245.27','159.368','2.17536','300','0','0','42','0','0','0','36909900','0'),
('10003948','5000015','571','1','1','0','0','3041.41','907.522','67.7176','4.0289','300','0','0','42','0','0','0','36909900','0'),
('10003947','5000015','571','1','1','0','0','2626.92','946.288','0.00123906','4.83394','300','0','0','42','0','0','0','36909900','0');

DELETE FROM `creature_text` WHERE `entry` = '@CUSTOM+15';
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) 
VALUES
(@CUSTOM+15, 0, 0, "You've successfully freed your spirit! You can serve as my eyes. Together we'll get to the bottom of this.", 15, 0, 100, 0, 0, 0, ''),
(@CUSTOM+15, 1, 0, "You're coming up on the village now. Keep your eyes peeled.", 15, 0, 100, 0, 0, 0, ''),
(@CUSTOM+15, 2, 0, "What's happened to the lake bed? Strange power is pouring out of it.", 15, 0, 100, 0, 0, 0, ''),
(@CUSTOM+15, 3, 0, "No... no! My people are all dead spirits or deranged!", 15, 0, 100, 0, 0, 0, ''),
(@CUSTOM+15, 4, 0, "Elder Mana loa, the statue there, sees you. This is a good sign!", 15, 0, 100, 0, 0, 0, ''),
(@CUSTOM+15, 5, 0, "Combe back, $N. If you're out of your body for too long, you run the risk of not being able to return. We have much to discuss.", 15, 0, 100, 0, 0, 0, '');

SET @CUSTOM := 5000000;
DELETE FROM `locales_creature_text` WHERE `entry` = @CUSTOM+15;
INSERT INTO `locales_creature_text` (`entry`, `groupid`, `id`, `text_loc1`, `text_loc2`, `text_loc3`, `text_loc4`, `text_loc5`, `text_loc6`, `text_loc7`, `text_loc8`) VALUES
(@CUSTOM+15,'0','0',NULL,NULL,NULL,NULL,NULL,NULL,"¡Has conseguido liberar tu espíritu! Ahora serás mis ojos. Juntos llegaremos hasta el fondo de la cuestión.",NULL),
(@CUSTOM+15,'1','0',NULL,NULL,NULL,NULL,NULL,NULL,'Estás llegando al poblado. Mantén los ojos bien abiertos.',NULL),
(@CUSTOM+15,'2','0',NULL,NULL,NULL,NULL,NULL,NULL,'¿Qué ha ocurrido con el lecho del lago? Emana una energía extraña.',NULL),
(@CUSTOM+15,'3','0',NULL,NULL,NULL,NULL,NULL,NULL,'No... ¡no! ¡Mi gente se ha convertido en espíritus muertos o se ha vuelto loca!',NULL),
(@CUSTOM+15,'4','0',NULL,NULL,NULL,NULL,NULL,NULL,"El ancestro Mana'loa, esa estatua de ahí, te ve. ¡Esta es una buena señal!",NULL),
(@CUSTOM+15,'5','0',NULL,NULL,NULL,NULL,NULL,NULL,'Vuelve, $N. Si pasas demasiado tiempo fuera de tu cuerpo, corres el ríesgo de no poder volver. Tenemos mucho de lo que hablar.',NULL);