-- Removemos el talento Infected Wounds (no el efecto) de spell group
DELETE FROM spell_group WHERE id = 1061 AND spell_id = 48483;
