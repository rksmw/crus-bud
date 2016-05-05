-- Cambiamos la faccion de los murlocs dependiendo de la ciudad
UPDATE creature SET id = 5000017 WHERE guid IN(10003677,10003678,10004035,10004036,10004037) AND id = 5000002; -- Alianza
UPDATE creature SET id = 5000018 WHERE guid IN(10003680,10003679,10004042,10004038,10004039,10004040) AND id = 5000002; -- Horda
