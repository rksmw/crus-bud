-- Handle visiblity of mobs during Zombie Event
UPDATE `creature` SET `PhaseMask`=1 WHERE `map`= 289 AND `guid` > 91428; -- Selects all creatures in Scholomance above guid 91428
UPDATE `creature` SET `PhaseMask`=1 WHERE `map`= 289 AND `guid` < 91428; -- Selects all creatures in Scholomance below guid 
