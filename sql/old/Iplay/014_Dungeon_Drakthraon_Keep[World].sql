-- Drak'tharon Keep
UPDATE `creature_template` SET `faction_A` = '16', `faction_H` = '16', `unit_flags` = '64' WHERE `entry` IN ('26638', '31351', '31339');
UPDATE `creature_template` SET `unit_flags` = '32768' WHERE `entry` IN ('27490', '26622', '26630', '31337', '31362');
UPDATE `creature_template` SET `faction_A` = '16', `faction_H` = '16' WHERE `entry` = '26620';
UPDATE `creature_template` SET `ScriptName`='RisenDrakkariBatRider' WHERE `entry`= '26638';
