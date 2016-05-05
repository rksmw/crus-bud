-- Reducimos el maxcount para que puedan salir otros items del boss
UPDATE creature_loot_template SET maxcount = 2 WHERE entry = 11502 AND item = 7078;
UPDATE creature_loot_template SET maxcount = 1 WHERE entry = 11502 AND item IN(34002,34030);
