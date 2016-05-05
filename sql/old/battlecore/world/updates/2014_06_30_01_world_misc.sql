-- ----------------------------------------
-- Achievement - Torch Juggler
-- ----------------------------------------
SET @SPELL_TORCH_CATCH := 45644;
SET @SPELL_THROW_TORCH := 45819;

-- Spell link for Throw Torch with on hit trigger Juggle Torch for the target
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = @SPELL_TORCH_CATCH;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(@SPELL_TORCH_CATCH, 45638, 0, 'Throw Torch with on hit trigger Juggle Torch for the target');
-- Spell link for Throw Torch with on hit trigger Juggle Torch for the target
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 45638;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(45638, 45276, 0, 'Throw Torch with on hit trigger Juggle Torch for the target');
-- Start countdown of achievement and count for it
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 45276;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(45276, 45280, 0, 'Throw Torch with on hit trigger Juggle Torch for the target');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (@SPELL_TORCH_CATCH);
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=@SPELL_TORCH_CATCH;

DELETE FROM `spell_script_names` WHERE `spell_id`=@SPELL_THROW_TORCH;

DELETE FROM `achievement_criteria_data` WHERE `criteria_id` = 6937;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(6937, 16, 341, 0, ''), 
(6937, 11, 0, 0, 'achievement_torch_juggler');
