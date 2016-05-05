-- Removemos mmaps de Ragnaros
UPDATE creature_template SET flags_extra = flags_extra | 0x20000000 WHERE entry = 11502;
