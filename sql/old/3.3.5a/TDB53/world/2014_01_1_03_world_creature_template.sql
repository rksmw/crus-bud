-- Fix de la velocidad e inmunidades de Val'kyr de Lich King
UPDATE creature_template SET speed_walk = 1 AND mechanic_immune_mask = (mechanic_immune_mask | 32 | 64) WHERE entry IN(36609,39120,39121,39122);
