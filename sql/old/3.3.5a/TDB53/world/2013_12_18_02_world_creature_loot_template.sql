-- Limitamos el loot para que pueda aparecer el item de mision "Tainted Helboar Meat"
UPDATE creature_loot_template SET groupid = 2 WHERE entry = 16879 AND item = 2;
UPDATE creature_loot_template SET groupid = 3 WHERE entry = 16880 AND item = 1;
UPDATE creature_loot_template SET groupid = 2 WHERE entry = 16880 AND item IN(1,2);
