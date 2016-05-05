-- Argent Valiant SAI
SET @VALIANT := 33448;
UPDATE `creature_template` SET `faction_A`=14, `faction_H`=14, `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@VALIANT;
UPDATE `creature_template_addon` SET `auras`= '63500 65190' WHERE `entry`=@VALIANT;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@VALIANT AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@VALIANT*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@VALIANT,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Valiant - Aggro - Say Text'),
(@VALIANT,0,1,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Argent Valiant - Distance - Cast Shield-Breaker'),
(@VALIANT,0,2,0,9,0,100,0,8,25,7000,7000,11,63010,2,0,0,0,0,2,0,0,0,0,0,0,0,'Argent Valiant - Distance - Cast Charge'),
(@VALIANT,0,3,0,0,0,100,0,10000,10000,10000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Valiant - In combat - flee'),
(@VALIANT,0,4,5,2,0,100,1,0,5,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Valiant - Defeated - Set faction friendly'),
(@VALIANT,0,5,6,61,0,100,1,0,0,0,0,85,64885,0,0,0,0,0,7,0,0,0,0,0,0,0,'Argent Valiant - Defeated - Invoker cast spell'),
(@VALIANT,0,6,0,61,0,100,1,0,0,0,0,80,@VALIANT*100,2,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Valiant - Defeated - Run script'),
(@VALIANT,0,7,8,6,0,100,1,0,0,0,0,33,38595,0,0,0,0,0,7,0,0,0,0,0,0,0,'Argent Valiant - Death - Give quest credit'),
(@VALIANT,0,8,0,61,0,100,1,0,0,0,0,85,64885,0,0,0,0,0,7,0,0,0,0,0,0,0,'Argent Valiant - Death - Invoker cast spell'),
(@VALIANT,0,9,0,11,0,100,1,0,571,210,0,46,25,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Valiant - Just summoned - Walk 25 yards'),
(@VALIANT,0,10,11,5,0,100,1,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Valiant - Kill unit - Set faction friendly'),
(@VALIANT,0,11,12,61,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Valiant - Kill unit - Say text'),
(@VALIANT,0,12,0,61,0,100,1,0,0,0,0,41,5000,5000,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Valiant - Kill unit - Say text'),
(@VALIANT*100,9,0,0,0,0,100,0,0,0,0,0,33,38595,0,0,0,0,0,7,0,0,0,0,0,0,0,'Argent Valiant - Script - Give quest credit'),
(@VALIANT*100,9,1,0,0,0,100,0,3000,3000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Valiant - Script - Say text'),
(@VALIANT*100,9,2,0,0,0,100,0,8000,8000,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Argent Valiant - Script - Despawn');

DELETE FROM `creature_text` WHERE `entry`=@VALIANT;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@VALIANT,0,0,"The rank of valiant is not easily won. Prepare yourself!",12,0,100,0,3,0,'Argent Valiant Aggro'),
(@VALIANT,0,1,"You believe yourself ready for the rank of valiant? We shall see.",12,0,100,0,3,0,'Argent Valiant Aggro'),
(@VALIANT,1,0,"Impressive skills indeed. I believe that you are more than ready for the rank of valiant.",12,0,100,0,3,0,'Argent Valiant Defeated'),
(@VALIANT,1,1,"Well done! It seems that you are worthy of the valiant rank!",12,0,100,0,3,0,'Argent Valiant Defeated'),
(@VALIANT,2,0,"I'm afraid you are not ready to become a valiant. However I suspect you will be ready soon enough.",12,0,100,0,3,0,'Argent Valiant Victory'),
(@VALIANT,2,1,"It would seem that you are not yet ready for the rank of valiant. Some more training may serve you well.",12,0,100,0,3,0,'Argent Valiant Victory');

-- Squire David SAI
SET @DAVID := 33447;
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@DAVID;

UPDATE `gossip_menu` SET `entry`=10339 WHERE `text_id`=14407;
DELETE FROM `gossip_menu_option` WHERE `menu_id`=10339;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(10339,0,0,'I am ready to fight!',1,1,0,0,0,0,NULL),
(10339,1,0,'How do the Argent Crusader raiders fight?',1,1,10341,0,0,0,NULL);

DELETE FROM `gossip_menu` WHERE `entry`=10341;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (10341,14410);
DELETE FROM `npc_text` WHERE `ID`=14410;
INSERT INTO `npc_text` (`ID`,`text0_0`,`text0_1`,`text1_0`,`text1_1`,`text2_0`,`text2_1`,`text3_0`,`text3_1`,`text4_0`,`text4_1`,`text5_0`,`text5_1`,`text6_0`,`text6_1`,`text7_0`,`text7_1`) VALUES
(14410,'The Argent Crusade raiders believe in balance and precision, deftly mixing attack and defense.$B$BHowever, they will often open themselves to Charges by trying to gain range on you.$B$BClose that range with a Charge before they can do the same, and then Shield-Break them as you wheel around for more Thrusts.','','','','','','','','','','','','','','','');

DELETE FROM `smart_scripts` WHERE `entryorguid`=@DAVID AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@DAVID,0,0,0,64,0,100,0,0,0,0,0,98,10339,14407,0,0,0,0,7,0,0,0,0,0,0,0,'Squire David - Gossip Hello - Send different gossip (see conditions)'),
(@DAVID,0,1,2,62,0,100,0,10339,0,0,0,12,@VALIANT,8,0,0,0,0,8,0,0,0,8575.451,952.472,547.554,0.38,'Squire David - Gossip select - Summon Argent Valiant'),
(@DAVID,0,2,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Squire David - Gossip select - Close Gossip');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@DAVID AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@DAVID,0,0,1,0,63034,0,0,0,0,'','SAI - Squire David show different menu if player mounted'),
(22,1,@DAVID,0,0,9,0,13679,0,0,0,0,'','SAI - Squire David show different menu if player quest taken'),
(22,1,@DAVID,0,1,1,0,63034,0,0,0,0,'','SAI - Squire David show different menu if player mounted'),
(22,1,@DAVID,0,1,9,0,13680,0,0,0,0,'','SAI - Squire David show different menu if player quest taken');
