-- Script name de la spell Dark Command del DK, para que tenga un % de activar los encantamientos de runas de las armas.
DELETE FROM `spell_script_names` WHERE `spell_id`=56222 AND `ScriptName`='spell_dk_dark_command';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(56222,'spell_dk_dark_command');
