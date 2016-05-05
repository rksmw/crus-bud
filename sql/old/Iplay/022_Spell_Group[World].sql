DELETE FROM spell_group WHERE id = 1138;
INSERT INTO spell_group (id, spell_id) VALUES
(1138, 72586), -- forgotten kings
(1138, 67480), -- blessing of sanctuary 10% stats id
(1138, 25898), -- greater blessing of kings
(1138, 20217); -- blessing of kings


DELETE FROM spell_group_stack_rules WHERE group_id = 1138;
INSERT INTO spell_group_stack_rules (group_id, stack_rule) VALUES
(1138, 1);

DELETE FROM spell_ranks WHERE first_spell_id = 57658;
DELETE FROM spell_ranks WHERE first_spell_id = 52109;
INSERT INTO spell_ranks (first_spell_id, spell_id, rank) VALUES
(57658, 57658, 1), -- Totem of Wrath
(57658, 57660, 2), 
(57658, 57662, 3),
(57658, 57663, 4),
(52109, 52109, 1), -- Flametongue Totem
(52109, 52110, 2),
(52109, 52111, 3),
(52109, 52112, 4),
(52109, 52113, 5),
(52109, 58651, 6),
(52109, 58654, 7),
(52109, 58655, 8);

DELETE FROM spell_group WHERE id = 1045; -- Old Flametongue totem group
DELETE FROM spell_group WHERE id = 1046; -- Old Totem of wrath group
DELETE FROM spell_group WHERE id = 1047; -- Old Demonic pact group
DELETE FROM spell_group WHERE id = 1048; -- Connection group of the three above
DELETE FROM spell_group WHERE id = 1145;
DELETE FROM spell_group WHERE id = 1146;
DELETE FROM spell_group WHERE id = 1147;
DELETE FROM spell_group WHERE id = 1149;
DELETE FROM spell_group WHERE id = 1150;
INSERT INTO spell_group (id, spell_id) VALUES
(1145, 57658), -- Totem of Wrath (Spellpower Part)
(1146, 52109), -- Flametongue totem
(1147, 48090), -- Demonic pact
(1149, -1145), -- Referral to ToW 
(1149, -1146), -- Referral to FT 
(1150, -1147), -- Demonic Pact
(1150, -1149); -- Referral to ToW+FT stacking rule


DELETE FROM spell_group_stack_rules WHERE group_id = 1046; -- Old Totem of wrath stacking rule
DELETE FROM spell_group_stack_rules WHERE group_id = 1048; -- Connection group stacking rule is set to 1 per standard, should be 3 after applying rule for ToW and Ft
DELETE FROM spell_group_stack_rules WHERE group_id = 1145;
DELETE FROM spell_group_stack_rules WHERE group_id = 1146;
DELETE FROM spell_group_stack_rules WHERE group_id = 1147;
DELETE FROM spell_group_stack_rules WHERE group_id = 1149;
DELETE FROM spell_group_stack_rules WHERE group_id = 1150;
INSERT INTO spell_group_stack_rules (group_id, stack_rule) VALUES
(1145, 1), -- Totem of wrath will not stack with itself
(1146, 1), -- Flametongue totem will not stack with itself
(1147, 1), -- Demonic pact will not stack with itself
(1149, 1), -- Totem of wrath will not stack with flametongue totem
(1150, 1); -- Totem of wrath and flametongue tot

DELETE FROM spell_ranks WHERE first_spell_id = 75593;
DELETE FROM spell_ranks WHERE first_spell_id = 31579;
INSERT INTO spell_ranks (first_spell_id, spell_id, rank) VALUES
(75593, 75593, 1), -- Ferocious inspiration
(75593, 75446, 2),
(75593, 75447, 3),
(31579, 31579, 1), -- Arcane empowerment
(31579, 31582, 2),
(31579, 31583, 3);

DELETE FROM spell_group WHERE id = 1470;
INSERT INTO spell_group (id, spell_id) VALUES
(1470, 75593),
(1470, 31579),
(1470, 63531); -- retri aura can still be used to gain double benefit (seems like old buggy code remained in core when Sanctified retribution was "fixed")

DELETE FROM spell_group_stack_rules WHERE group_id = 1470;
INSERT INTO spell_group_stack_rules (group_id, stack_rule) VALUES
(1470, 1);
