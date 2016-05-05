-- Sindragosa: Fix spell 69762 Unchained Magic - Add internal cooldown with 1 seconds, so multi-spell spells will only apply one stack of triggered spell 69766 (i.e. Chain Heal)
DELETE FROM `spell_proc_event` WHERE `entry` = 69762;
INSERT INTO `spell_proc_event` (entry, SchoolMask, SpellFamilyName, SpellFamilyMask0, SpellFamilyMask1, SpellFamilyMask2, procFlags, procEx, ppmRate, CustomChance, Cooldown) VALUES
(69762, 0, 0, 0, 0, 0, 81920, 0, 0, 0, 1);
