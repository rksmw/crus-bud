-- SQL Achievement Leeroy
UPDATE gameobject_template SET flags = 1, data0 = 0, data3 = 15745, data4 = 1, data5 = 300, data7 = 5, ScriptName = 'go_rookery_egg' WHERE entry = 175124;
DELETE FROM spell_linked_spell WHERE spell_trigger = 15750;
INSERT INTO spell_linked_spell VALUES
(15750, 15745, 0, '');
-- Rookery Whelps
UPDATE creature_template SET unit_flags = 1, ScriptName = 'npc_rookery_whelp' WHERE entry = 10161;
