-- Disminuimos la cantidad de trofeos para no sobreescribir otro loot de Argent Crusade Tribute Chest
UPDATE gameobject_loot_template SET maxcount = 1 WHERE mincountorref = -12002;
