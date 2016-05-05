-- Quest - Slaves of the Stromforged
SET @ENTRY := 29384;
SET @GOSSIP := 9871;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,25,0,100,0,0,0,0,0,17,233,0,0,0,0,0,1,0,0,0,0,0,0,0,'Captive Mechagnome - Reset - Emote mining'),
(@ENTRY,0,1,0,25,0,100,0,0,0,0,0,81,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Captive Mechagnome - Reset - Add gossip npcflag'),
(@ENTRY,0,2,0,25,0,100,0,0,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Captive Mechagnome - Reset - Walk'),
(@ENTRY,0,3,4,62,0,100,0,@GOSSIP,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Captive Mechagnome - Gossip select - Close gossip'),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'Captive Mechagnome - Gossip select - Run script'),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,83,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Captive Mechagnome - Script - Remove gossip flag'),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Captive Mechagnome - Script - Turn'),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Captive Mechagnome - Script - Remove emote state'),
(@ENTRY*100,9,3,0,0,0,100,0,2000,2000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Captive Mechagnome - Script - Say text'),
(@ENTRY*100,9,4,0,0,0,100,0,5000,5000,0,0,46,6,0,0,0,0,0,1,0,0,0,0,0,0,0,'Captive Mechagnome - Script - Walk 6 yards'),
(@ENTRY*100,9,5,0,0,0,100,0,1000,1000,0,0,33,29962,0,0,0,0,0,7,0,0,0,0,0,0,0,'Captive Mechagnome - Script - Give quest credit'),
(@ENTRY*100,9,6,0,0,0,100,0,5000,5000,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Captive Mechagnome - Script - Despawn');

DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Does not compute. Unit malfunctioning. Directive: shut down.",12,0,100,1,0,0,'Captive Mechagnome'),
(@ENTRY,0,1,"Thank you, $r. I will join your struggle against the stormforged.",12,0,100,1,0,0,'Captive Mechagnome'),
(@ENTRY,0,2,"New directive: leave mine and return to Inventor's Library.",12,0,100,1,0,0,'Captive Mechagnome'),
(@ENTRY,0,3,"New directive: assist in the defeat of the iron dwarves.",12,0,100,1,0,0,'Captive Mechagnome'),
(@ENTRY,0,4,"Free again? Keeper Mimir's work awaits.",12,0,100,1,0,0,'Captive Mechagnome');

DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(@GOSSIP,0,0,"I'm not a laborer. I'm here to free you from servitude in the mines.",1,1,0,0,0,0,'');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=@GOSSIP;	
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES	
(15,@GOSSIP,0,0,9,12957,0,0,0,'','Show gossip only if Slaves of the Stormforged quest taken');
