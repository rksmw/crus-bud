-- Stackeo de Tierra y Luna (druida), Pesteador de Ebano (dk) y Maldicion de los Elementos (brujo) reducidos a maximo 1
UPDATE `spell_group_stack_rules` SET `stack_rule` = '1' WHERE `group_id` = '1101'; -- anterior 3
