UPDATE `creature_template` SET `npcflag` = '16777216' WHERE `entry` = '27989';
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = '27989';
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES ('27989', '50493', '2', '1');
DELETE FROM `spell_script_names` WHERE `spell_id` = '50493';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES ('50493', 'spell_gen_listening_music_disco');
