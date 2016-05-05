-- assign core-script to drake riders and delete SAI
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_hyldsmeet_drakerider' WHERE `entry` =29694;
DELETE FROM `smart_scripts` WHERE  `entryorguid`= 29694;

-- prevent ornaments from falling down
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` =29754;
 
-- drake riders despawn immediately after death
UPDATE `vehicle_template_accessory` SET `summontype` = 5 WHERE `entry` =29625 AND `seat_id` =1;
 
-- there are problems with fights on moving vehicles, so disbale movement of drakes
UPDATE `creature` SET `MovementType` = 0 WHERE `id` =29625;
 
-- assign core-script to questgiver to handle the flight to the Temple of Storms
UPDATE `creature_template` SET `ScriptName` = 'npc_gretta_the_arbiter' WHERE `entry` =29796;

-- assing script
UPDATE `creature_template` SET `ScriptName`='npc_hyldsmeet_protodrake' WHERE `entry`=29625;

-- clean old script
UPDATE `creature_template` SET `ScriptName`='' WHERE `entry`=29679;
