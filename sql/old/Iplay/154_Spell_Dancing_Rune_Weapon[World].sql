-- Set Rune Weapon flag and immunity
UPDATE `creature_template` SET
`unit_flags`=
0x00000002|                 -- UNIT_FLAG_NON_ATTACKABLE
0x02000000                  -- UNIT_FLAG_NOT_SELECTABLE / Can't be selected by mouse or with /target {name} command
WHERE `entry`=27893;        -- Rune Weapon

-- Change ProcFlags of Dancing Rune Weapon Dummy Aura to include melee attack
DELETE FROM `spell_proc_event` WHERE `entry` = 49028;
INSERT INTO `spell_proc_event` (`entry`, `procFlags`) VALUES
(49028, 86288               -- DBC ProcFlags
| 0x4);                     -- Successful melee attack
