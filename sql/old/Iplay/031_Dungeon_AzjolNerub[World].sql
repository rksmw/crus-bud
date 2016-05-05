-- Cambio de la faccion de Hadronox para evitar que combata con los mobs que le rodean y se cuele en las texturas
UPDATE `creature_template` SET `faction_A`='1814', `faction_H`='1814' WHERE `entry`='28921' OR `entry`='31611';
