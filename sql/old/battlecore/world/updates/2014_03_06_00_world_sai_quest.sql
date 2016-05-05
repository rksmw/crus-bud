-- Fix quest Borrowed Technology
UPDATE `smart_scripts` SET `action_type` = '85' ,`event_type` = 6 WHERE `entryorguid` = '31578' AND `source_type` = '0' AND `id` = '3' AND `link` = '0'; 
DELETE FROM `vehicle_template_accessory` WHERE `entry` = 31583;
INSERT INTO`vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`)
VALUES
 (31583,31630,0,1,'Frostbrood Skytalon Explosion Bunny',6,30000);
