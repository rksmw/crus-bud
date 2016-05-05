DELETE FROM `spell_script_names` WHERE `spell_id` = 50842;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (50842, 'spell_dk_pestilence'); 

DELETE FROM `spell_linked_spell` WHERE `spell_effect`=71757;

DELETE FROM `spell_proc_event` WHERE `entry`=71761;
INSERT INTO `spell_proc_event` (`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES 
(71761, 0, 3, 0, 0x100000, 0, 0, 0x100, 0, 0, 0); -- Deep Freeze

UPDATE `spell_proc_event` SET `procEx`=`procEx`|0x100 WHERE `entry`=74396;

DELETE FROM `spell_script_names` WHERE `spell_id`=70811;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(70811,'spell_sha_item_t10_elemental_2p_bonus');
 
DELETE FROM `spell_proc_event` WHERE `entry`=70811;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(70811, 0, 11, 3, 0, 0, 0, 0, 0, 0, 0);
