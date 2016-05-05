-- -------------------------
-- IoC (Isle Of Conquest) BG
-- -------------------------

-- 'High Commander Halford Wyrmbane' fix level Isla conquista
UPDATE `creature_template` SET `minlevel` = '81' ,`maxlevel` = '81' WHERE `entry` = '34924';
-- 'Overlord Agmar' fix level Isla conquista
UPDATE `creature_template` SET `minlevel` = '81' ,`maxlevel` = '81' WHERE `entry` = '34922';
-- Fix recuperacion de vida de Catapult Horde
UPDATE `creature_template` SET `RegenHealth`='0' WHERE `entry`='34793';
-- Fix para que no regenere vida Siege Turret Horde
UPDATE `creature_template` SET `RegenHealth`='0' WHERE `entry`='36355';
-- 'Catapult' fix level Isla conquista
UPDATE `creature_template` SET `minlevel` = '80' ,`maxlevel` = '80' WHERE `entry` = '34793';
-- Fix para que no regenere vida Siege Turret Alliance
UPDATE `creature_template` SET `RegenHealth`='0' WHERE `entry`='34777';
-- 'Demolisher' fix level Isla conquista
UPDATE `creature_template` SET `minlevel` = '80' ,`maxlevel` = '80' WHERE `entry` = '34775';
-- 'Keep Cannon' fix level Isla conquista
UPDATE `creature_template` SET `minlevel` = '80' ,`maxlevel` = '80' WHERE `entry` = '34944';
-- 'Glaive Thrower Horde' fix level Isla conquista
UPDATE `creature_template` SET `minlevel` = '80' ,`maxlevel` = '80' WHERE `entry` = '35273';
-- 'Glaive Thrower' fix level Isla conquista
UPDATE `creature_template` SET `minlevel` = '80' ,`maxlevel` = '80' WHERE `entry` = '34802';
-- 'Siege Engine Horde' fix level Isla conquista
UPDATE `creature_template` SET `minlevel` = '80' ,`maxlevel` = '80' WHERE `entry` = '35069';
-- 'Siege Engine Horde' fix level Isla conquista
UPDATE `creature_template` SET `minlevel` = '80' ,`maxlevel` = '80' WHERE `entry` = '34776';
-- 'Keep Cannon' fix movimiento Isla conquista
UPDATE `creature_template` SET `speed_walk` = '0' ,`speed_run` = '0' WHERE `entry` = '34944';
-- IoC Boss mechanic_immune_mask
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|4194304|8388608|33554432|536870912 WHERE `entry` IN (34922,34924);
-- Fix barcos IoC
UPDATE `gameobject_template` SET `flags`=40 WHERE `entry` IN (195276, 195121 );
