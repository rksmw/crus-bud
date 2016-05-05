-- Poniendo script_name a la spell para que no se pueda usar si el dk esta cayendo o saltando
DELETE FROM spell_script_names WHERE ScriptName='spell_dk_death_grip_trigger';
INSERT INTO spell_script_names (spell_id,ScriptName) VALUES
(49576,'spell_dk_death_grip_trigger');
