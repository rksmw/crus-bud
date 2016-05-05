-- Removemos loot random para que los item de mision puedan aparecer (Bonestripper Buzzard)
UPDATE creature_loot_template SET groupid = 1 WHERE entry = 16972 AND item = 1;
