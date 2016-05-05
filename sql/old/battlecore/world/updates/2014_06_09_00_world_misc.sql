-- Arreglar spell 'Levantar aliado'/'Raise Ally' (61999) [DK]
UPDATE `creature_template` SET `mindmg` = 520, `maxdmg` = 675, `attackpower` = 200, `dmg_multiplier` = 2, `unit_flags2` = 2048, `spell1` = 62225, `spell2` = 47480, `spell3` = 47481, `spell4` = 47482, `spell5` = 47484, `spell6` = 51874, `Health_mod` = 286, `ScriptName` = 'npc_risen_ally' WHERE `entry` = 30230; -- `mindmg` = 2, `maxdmg` = 2, `attackpower` = 24, `dmg_multiplier` = 1, `unit_flags2` = 2048, `spell1` = 0, `spell2` = 0, `spell3` = 0, `spell4` = 0, `spell5` = 0, `spell6` = 0, `Health_mod` = 0, `ScriptName` = ''

DELETE FROM `spell_script_names` WHERE `spell_id` = 61999;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (61999, 'spell_dk_raise_ally');

-- Quitar buff de Raise Ally (DK) cuando el jugador loguea
SET @SPELL_TRIGGER := 836;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = @SPELL_TRIGGER AND `spell_effect` = -46619;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(@SPELL_TRIGGER, -46619, 0, 'On cast LOGINEFFECT - Remove Raise Ally buff (casted to dead player to convert in ghoul)');
