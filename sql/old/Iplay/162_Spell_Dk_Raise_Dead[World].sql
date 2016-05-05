-- DK Reaise dead Script Name
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_dk_raise_dead';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(46584, 'spell_dk_raise_dead');
