-- Removemos la inmunidad a interrupt de estos dos boss de ToCr
UPDATE creature_template SET mechanic_immune_mask = mechanic_immune_mask & ~33554432 WHERE entry IN(
34497, 35350, 35351, 35352, -- Fjola Lightbane
34496, 35347, 35348, 35349 -- Eydis Darkbane
);
