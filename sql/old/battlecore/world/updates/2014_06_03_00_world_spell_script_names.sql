-- Solucionamos reduccion de armadura del spell 'Enrage' (5229) [druida] y cambios en las formas pasivas de oso 'Bear form passive' (1178, 9635)
DELETE FROM `spell_script_names` WHERE `spell_id` IN(1178, 9635);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES 
(1178, 'spell_dru_bear_form_passive'), 
(9635, 'spell_dru_bear_form_passive');
