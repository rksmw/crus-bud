-- Removemos todos los MMAPS de Trial of the Crusader para corregir el movimiento de todos los npc
DELETE FROM disables WHERE sourceType = 7 AND entry = 649;
INSERT INTO disables (sourceType,entry,flags,COMMENT) VALUES (7,649,0,'Disable MMAP for Trial of the Crusader');
