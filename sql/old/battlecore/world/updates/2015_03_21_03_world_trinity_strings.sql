DELETE FROM `trinity_string` WHERE `entry` IN (11333, 11334, 11335, 11336, 11337, 11338, 11339, 11340, 11341, 11342, 11343, 11344);

INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) 
VALUES 
(11333, 'Syntax: .qc $quest\n\nObtienes informacion sobre el estado de la mision, si esta se encuentra bug el comando te la autocompletara', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11334, 'La mision: %s  ha sido completada con exito!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11335, 'La mision: %s se encuentra bug!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11336, 'Error: No se encontraron resultados con referencia a la quest %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11337, 'Syntax: .qc add $quest\n\nAñades misiones al sistema para que los players puedan autocompletarlas.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11338, 'La Mision: %s fue añadida con exito!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11339, 'Error con la solicitud de añadir la mision %s. SQL error.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11340, 'La Mision: %s ya esta incorporada en el sistema!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11341, 'Syntax: .qc del $quest\n\nEliminas misiones del sistema que ya estan reparadas.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), 
(11342, 'La Mision: %s fue removida con exito!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), 
(11343, 'La Mision: %s no se encuentra en el sistema.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11344, 'Error con la solicitud de eliminar la quest.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL); 
