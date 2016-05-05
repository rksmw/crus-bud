DELETE FROM `smart_scripts` WHERE `entryorguid` IN (27206, 27213) AND `source_type`=0 AND `id`=1;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (27213) AND `source_type`=0 AND `id` IN (2, 3, 4);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-98539) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`IN (27213*100, 98539*100) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(27213,0,1,0,31,0,100,0,0,0,0,0,80,27213*100,0,0,0,0,0,1,0,0,0,0,0,0,0,"Onslaught Warhorse - spell_hit_target - Action list"),
(27213*100,9,0,0,0,0,100,0,0,0,0,0,11,50630,0,0,0,0,0,1,0,0,0,0,0,0,0,"Onslaught Warhorse - Action list - Eject All Passengers"),
(27213*100,9,1,0,0,0,100,0,0,0,0,0,18,33554432,0,0,0,0,0,1,0,0,0,0,0,0,0,"Onslaught Warhorse - Action list - Set non selectable"),
(27213*100,9,2,0,0,0,100,0,0,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Onslaught Warhorse - Action list - Set run off"),
(27213*100,9,3,0,0,0,100,0,0,0,0,0,69,0,0,0,0,0,0,8,0,0,0,3263.979980,-623.401001,170.712006,1.059199,"Onslaught Warhorse - Action list - move to pos"),
(27213*100,9,4,0,0,0,100,0,5000,5000,0,0,45,0,1,0,0,0,0,10,98539,23837,0,0,0,0,0,"Onslaught Warhorse - Action list - set data"),
(27213*100,9,5,0,0,0,100,0,4000,4000,0,0,11,48304,0,0,0,0,0,1,0,0,0,0,0,0,0,"Onslaught Warhorse - Action list - cast"),
(27213*100,9,6,0,0,0,100,0,2000,2000,0,0,69,0,0,0,0,0,0,8,0,0,0,3239.105957, -648.267578, 165.650528, 3.71414,"Onslaught Warhorse - Action list - move to pos"),
(27213*100,9,7,0,0,0,100,0,9000,9000,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Onslaught Warhorse - Action list - Despawn"),
(27213,0,2,3,28,0,100,0,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,"Onslaught Warhorse - Passenger removed - Set faction"),
(27213,0,3,0,61,0,100,0,0,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Onslaught Warhorse - Passenger removed - Set Home position"),
(-98539,0,0,0,38,0,100,0,0,1,0,0,11,48298,0,0,0,0,0,19,27213,20,0,0,0,0,0,"ELM General Purpose Bunny - On data set - Cast");
