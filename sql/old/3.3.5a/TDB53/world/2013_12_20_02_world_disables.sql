-- Quitamos mmaps en Hall Of Reflection para prevenir que los npc vayan out of combat, desabilitamos hasta corregir ultimo evento (Script con discrepancia entre alianza y horda hace que no continue)
DELETE FROM disables WHERE sourceType in(2,7) AND entry = 668;
INSERT INTO disables (sourceType,entry,flags,COMMENT) VALUES (2,668,15,'Disable Map for Hall Of Reflection');
INSERT INTO disables (sourceType,entry,flags,COMMENT) VALUES (7,668,0,'Disable MMAP for Hall Of Reflection');
