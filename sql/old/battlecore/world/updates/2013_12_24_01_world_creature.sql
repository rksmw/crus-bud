-- Volvemos el phaseMask original luego de la aplicacion del crashfix
UPDATE creature SET phaseMask = 1 WHERE id = 24601;
