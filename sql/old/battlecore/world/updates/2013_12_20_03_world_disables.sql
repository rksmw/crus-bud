-- Removemos un disable temporal de Azjol Nerub para que los jugadores no entren a la instancia hasta que el fix sea aplicado
DELETE FROM disables WHERE sourceType = 2 AND entry = 601;
