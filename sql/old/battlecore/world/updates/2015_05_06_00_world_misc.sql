-- Deep Freeze scriptname
DELETE FROM `spell_script_names` WHERE `spell_id` = 44572 AND `ScriptName` = 'spell_mage_deep_freeze';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`)
VALUES (44572, 'spell_mage_deep_freeze');

DELETE FROM spell_bonus_data WHERE entry = 71757;
INSERT INTO spell_bonus_data VALUES 
(71757, 2.143, 0, 0, 0, 'Mage - Deep Freeze (Immunity Damage)');
