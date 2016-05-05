-- Spell Rocket Blast Script Name
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_rocket_blast_trigger' AND spell_id IN (51673);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES('51673','spell_rocket_blast_trigger');
