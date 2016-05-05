-- Tempotary Hackfix for Entrapment
DELETE FROM `spell_script_names` WHERE `spell_id`  IN (63487,45145);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(63487, 'spell_hun_entrapment_frost'), -- Frost trap
(45145, 'spell_hun_entrapment_snake'); -- Snake Trap
