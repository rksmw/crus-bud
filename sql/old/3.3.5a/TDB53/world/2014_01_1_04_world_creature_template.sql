-- Agregamos inmunidad a fear y root a los adds de Professor Putricide
UPDATE creature_template SET mechanic_immune_mask = (mechanic_immune_mask | 16 | 64) WHERE entry IN(
37697,38604,38758,38759, -- Volatile Ooze
37562,38602,38760,38761 -- Gas Cloud
);
