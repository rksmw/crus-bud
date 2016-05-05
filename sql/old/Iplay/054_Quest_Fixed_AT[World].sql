-- Argent Champion SAI
SET @CHAMPION := 33707;
UPDATE `creature_template` SET `dmg_multiplier`=3, `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@CHAMPION;
DELETE FROM `creature_template_addon` WHERE `entry`=@CHAMPION;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(@CHAMPION,0,28919,0,0,0,'63501 64553');

DELETE FROM `smart_scripts` WHERE `entryorguid`=@CHAMPION AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@CHAMPION,0,0,1,11,0,100,1,0,571,210,0,46,25,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Champion - Just summoned - Walk 25 yards'),
(@CHAMPION,0,1,0,61,0,100,1,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Champion - Just summoned - Set phase 1'),
(@CHAMPION,0,2,0,1,1,100,1,10000,10000,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Champion - 10 secs OOC - Set faction 14'),
(@CHAMPION,0,3,0,4,1,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Champion - Aggro - Say Text'),
(@CHAMPION,0,4,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Argent Champion - Distance - Cast Shield-Breaker'),
(@CHAMPION,0,5,0,9,0,100,0,8,25,7000,7000,11,63010,2,0,0,0,0,2,0,0,0,0,0,0,0,'Argent Champion - Distance - Cast Charge'),
(@CHAMPION,0,6,0,0,0,100,0,10000,10000,10000,15000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Champion - In combat - flee'),
(@CHAMPION,0,7,8,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Champion - Defeated - Set faction friendly'),
(@CHAMPION,0,8,9,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Champion - Defeated - Say text'),
(@CHAMPION,0,9,11,61,0,100,1,0,0,0,0,85,64885,0,0,0,0,0,7,0,0,0,0,0,0,0,'Argent Champion - Defeated - Invoker cast spell'),
(@CHAMPION,0,10,11,6,0,100,1,0,0,0,0,85,64885,0,0,0,0,0,7,0,0,0,0,0,0,0,'Argent Champion - Death - Invoker cast spell'),
(@CHAMPION,0,11,12,61,0,100,1,0,0,0,0,33,33708,0,0,0,0,0,7,0,0,0,0,0,0,0,'Argent Champion - Link - Give quest credit'),
(@CHAMPION,0,12,0,61,0,100,1,0,0,0,0,41,7000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Champion - Link - Despawn'),
(@CHAMPION,0,13,14,5,0,100,1,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Champion - Kill unit - Set faction friendly'),
(@CHAMPION,0,14,12,61,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Champion - Kill unit - Say text');

DELETE FROM `creature_text` WHERE `entry`=@CHAMPION;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@CHAMPION,0,0,"You believe you are ready to be a champion? Defend yourself!",12,0,100,0,3,0,'Argent Champion Aggro'),
(@CHAMPION,0,1,"You think you are ready to become a champion. We shall see.",12,0,100,0,3,0,'Argent Champion Aggro'),
(@CHAMPION,1,0,"Most impressive. You are worthy to gain the rank of champion.",12,0,100,0,3,0,'Argent Champion Defeated'),
(@CHAMPION,1,1,"You have shown that you are ready for the rank of champion.",12,0,100,0,3,0,'Argent Champion Defeated'),
(@CHAMPION,2,0,"It seems you are not ready for the rank of champion. Some more training may serve you well.",12,0,100,0,3,0,'Argent Champion Victory'),
(@CHAMPION,2,1,"You have been defeated. But do not give up. I sense that one day you will join our ranks as a champion.",12,0,100,0,3,0,'Argent Champion Victory');

-- Squire Danny SAI
SET @DANNY := 33518;
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@DANNY;

DELETE FROM `gossip_menu_option` WHERE `menu_id`=10343;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(10343,0,0,'I am ready to fight!',1,1,0,0,0,0,NULL);

DELETE FROM `smart_scripts` WHERE `entryorguid`=@DANNY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@DANNY,0,0,1,62,0,100,0,10343,0,0,0,12,@CHAMPION,8,0,0,0,0,8,0,0,0,8543.415,1088.268,556.788,1.12,'Squire Danny - Gossip select - Summon Argent Champion'),
(@DANNY,0,1,2,61,0,100,0,0,0,0,0,4,15852,0,0,0,0,0,7,0,0,0,0,0,0,0,'Squire Danny - Gossip select - Play Sound'),
(@DANNY,0,2,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Squire Danny - Gossip select - Close Gossip');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=10343;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15,10343,0,0,0,1,0,63034,0,0,0,0,'','SAI - Squire Danny show gossip if player mounted'),
(15,10343,0,0,0,9,0,13727,0,0,0,0,'','SAI - Squire Danny show gossip if player quest taken'),
(15,10343,0,0,1,1,0,63034,0,0,0,0,'','SAI - Squire Danny show gossip if player mounted'),
(15,10343,0,0,1,9,0,13728,0,0,0,0,'','SAI - Squire Danny show gossip if player quest taken'),
(15,10343,0,0,2,1,0,63034,0,0,0,0,'','SAI - Squire Danny show gossip if player mounted'),
(15,10343,0,0,2,9,0,13729,0,0,0,0,'','SAI - Squire Danny show gossip if player quest taken'),
(15,10343,0,0,3,1,0,63034,0,0,0,0,'','SAI - Squire Danny show gossip if player mounted'),
(15,10343,0,0,3,9,0,13731,0,0,0,0,'','SAI - Squire Danny show gossip if player quest taken'),
(15,10343,0,0,4,1,0,63034,0,0,0,0,'','SAI - Squire Danny show gossip if player mounted'),
(15,10343,0,0,4,9,0,13726,0,0,0,0,'','SAI - Squire Danny show gossip if player quest taken'),
(15,10343,0,0,5,1,0,63034,0,0,0,0,'','SAI - Squire Danny show gossip if player mounted'),
(15,10343,0,0,5,9,0,13725,0,0,0,0,'','SAI - Squire Danny show gossip if player quest taken'),
(15,10343,0,0,6,1,0,63034,0,0,0,0,'','SAI - Squire Danny show gossip if player mounted'),
(15,10343,0,0,6,9,0,13713,0,0,0,0,'','SAI - Squire Danny show gossip if player quest taken'),
(15,10343,0,0,7,1,0,63034,0,0,0,0,'','SAI - Squire Danny show gossip if player mounted'),
(15,10343,0,0,7,9,0,13723,0,0,0,0,'','SAI - Squire Danny show gossip if player quest taken'),
(15,10343,0,0,8,1,0,63034,0,0,0,0,'','SAI - Squire Danny show gossip if player mounted'),
(15,10343,0,0,8,9,0,13724,0,0,0,0,'','SAI - Squire Danny show gossip if player quest taken'),
(15,10343,0,0,9,1,0,63034,0,0,0,0,'','SAI - Squire Danny show gossip if player mounted'),
(15,10343,0,0,9,9,0,13699,0,0,0,0,'','SAI - Squire Danny show gossip if player quest taken');
