-- Ignorar mmaps en los siguientes npcs (path - paths - pathfinding)
-- Para quitar bits usar: UPDATE `creature_template` SET `flags_extra` = `flags_extra` &~ 0x20000000 WHERE `entry` IN( ... );
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 0x20000000 WHERE `entry` IN(

-- ICC/Gunship Battle
-- Mobs
36939, 36948, 37182, 50004, 50006, 37026, 37116, 37920, 36957, 36960, 36961, 37117, 36950, 36982, 36978, 36968, 36969, 36970, 37033, 37230,

-- ICC/Sindragosa
-- Sindragosa (boss)
36853, 38265, 38266, 38267
);
