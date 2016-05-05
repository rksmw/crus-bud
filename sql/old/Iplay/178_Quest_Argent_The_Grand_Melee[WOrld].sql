-- Quest - The Grand Melee
UPDATE `creature_template` SET `gossip_menu_id`=0, `AIName`='SmartAI', `ScriptName`='' WHERE `entry` IN (33285,33306,33382,33383,33384,33558,33559,33561,33562,33564);

-- Sen'jin Valiant SAI
SET @VALIANT := 33285;
SET @VICTORY := 64812; -- Spell Bested Sen'jin
DELETE FROM `smart_scripts` WHERE `entryorguid`=@VALIANT AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@VALIANT,0,0,0,64,0,100,0,0,0,0,0,98,10466,14384,0,0,0,0,7,0,0,0,0,0,0,0,'Senjin Valiant - Gossip Hello - Send different gossip (see conditions)'),
(@VALIANT,0,1,2,62,0,100,0,10466,1,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Senjin Valiant - Gossip select - close gossip'),
(@VALIANT,0,2,3,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Senjin Valiant - Gossip select - Store target'),
(@VALIANT,0,3,4,61,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Valiant - Gossip - Change Faction'),
(@VALIANT,0,4,5,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,'Senjin Valiant - Gossip - Attack Invoker vehicle'),
(@VALIANT,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Valiant - Gossip - Say Text'),
(@VALIANT,0,6,0,4,0,100,0,0,0,0,0,11,64221,2,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Valiant - Aggro - Cast defend aura'),
(@VALIANT,0,7,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Senjin Valiant - In combat - Cast Shield-Breaker'),
(@VALIANT,0,8,0,9,0,100,0,8,25,7000,7000,11,63010,0,0,0,0,0,2,0,0,0,0,0,0,0,'Senjin Valiant - Distance - Cast Charge'),
(@VALIANT,0,9,0,0,0,100,0,10000,10000,15000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Valiant - In combat - Flee'),
(@VALIANT,0,10,11,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Valiant - HP at 5% - Set faction default'),
(@VALIANT,0,11,12,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Valiant - Defeated - Say text'),
(@VALIANT,0,12,14,61,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Senjin Valiant - Defeated - Cross cast spell'),
(@VALIANT,0,13,14,6,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Senjin Valiant - Death - Cross cast spell'), -- this line is hacky, npc shouldn't be killed
(@VALIANT,0,14,0,61,0,100,1,0,0,0,0,86,62724,3,12,1,0,0,12,1,0,0,0,0,0,0,'Senjin Valiant - Defeated - Cross Cast Mounted Melee Victory'),
(@VALIANT,0,15,18,25,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Valiant - Reset - Set faction default'),
(@VALIANT,0,16,17,5,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Valiant - Kill - Say win text'),
(@VALIANT,0,17,18,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Valiant - Link - Set faction default'),
(@VALIANT,0,18,19,61,0,100,1,0,0,0,0,28,64221,0,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Valiant - Link - Remove defend aura'),
(@VALIANT,0,19,0,61,0,100,1,0,0,0,0,28,62719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Valiant - Link - Remove defend charges');

DELETE FROM `creature_text` WHERE `entry`=@VALIANT;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@VALIANT,0,0,"Let it begin!",12,0,100,0,3,0,'Senjin Valiant Aggro'),
(@VALIANT,0,1,"On your guard!",12,0,100,0,3,0,'Senjin Valiant Aggro'),
(@VALIANT,0,2,"Prepare yourself!",12,0,100,0,3,0,'Senjin Valiant Aggro'),
(@VALIANT,0,3,"Ready yourself!",12,0,100,0,3,0,'Senjin Valiant Aggro'),
(@VALIANT,1,0,"I have been defeated. Good fight!",12,0,100,0,3,0,'Senjin Valiant Defeated'),
(@VALIANT,1,1,"It would seem I underestimated your skills. Well done.",12,0,100,0,3,0,'Senjin Valiant Defeated'),
(@VALIANT,1,2,"That was a well fought battle. I yield to you.",12,0,100,0,3,0,'Senjin Valiant Defeated'),
(@VALIANT,1,3,"I yield to you.",12,0,100,0,3,0,'Senjin Valiant Defeated'),
(@VALIANT,2,0,"I am afraid you will need more practice to defeat me.",12,0,100,0,3,0,'Senjin Valiant Victory'),
(@VALIANT,2,1,"I have won. Better luck another time, friend.",12,0,100,0,3,0,'Senjin Valiant Victory'),
(@VALIANT,2,2,"It seems you still need more practice. Perhaps another time.",12,0,100,0,3,0,'Senjin Valiant Victory'),
(@VALIANT,2,3,"Victory is mine!",12,0,100,0,3,0,'Senjin Valiant Victory');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@VALIANT AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@VALIANT,0,0,1,0,63034,0,0,0,0,'',"SAI - Senjin Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,0,9,0,13772,0,0,0,0,'',"SAI - Senjin Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,0,1,0,@VICTORY,0,0,1,0,'',"SAI - Senjin Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,1,1,0,63034,0,0,0,0,'',"SAI - Senjin Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,1,9,0,13777,0,0,0,0,'',"SAI - Senjin Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,1,1,0,@VICTORY,0,0,1,0,'',"SAI - Senjin Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,2,1,0,63034,0,0,0,0,'',"SAI - Senjin Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,2,9,0,13782,0,0,0,0,'',"SAI - Senjin Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,2,1,0,@VICTORY,0,0,1,0,'',"SAI - Senjin Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,3,1,0,63034,0,0,0,0,'',"SAI - Senjin Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,3,9,0,13787,0,0,0,0,'',"SAI - Senjin Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,3,1,0,@VICTORY,0,0,1,0,'',"SAI - Senjin Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,4,1,0,63034,0,0,0,0,'',"SAI - Senjin Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,4,9,0,13767,0,0,0,0,'',"SAI - Senjin Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,4,1,0,@VICTORY,0,0,1,0,'',"SAI - Senjin Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,5,1,0,63034,0,0,0,0,'',"SAI - Senjin Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,5,9,0,13761,0,0,0,0,'',"SAI - Senjin Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,5,1,0,@VICTORY,0,0,1,0,'',"SAI - Senjin Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,6,1,0,63034,0,0,0,0,'',"SAI - Senjin Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,6,9,0,13745,0,0,0,0,'',"SAI - Senjin Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,6,1,0,@VICTORY,0,0,1,0,'',"SAI - Senjin Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,7,1,0,63034,0,0,0,0,'',"SAI - Senjin Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,7,9,0,13750,0,0,0,0,'',"SAI - Senjin Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,7,1,0,@VICTORY,0,0,1,0,'',"SAI - Senjin Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,8,1,0,63034,0,0,0,0,'',"SAI - Senjin Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,8,9,0,13756,0,0,0,0,'',"SAI - Senjin Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,8,1,0,@VICTORY,0,0,1,0,'',"SAI - Senjin Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,9,1,0,63034,0,0,0,0,'',"SAI - Senjin Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,9,9,0,13665,0,0,0,0,'',"SAI - Senjin Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,9,1,0,@VICTORY,0,0,1,0,'',"SAI - Senjin Valiant show different menu if player doesn't have aura");

-- Orgrimmar Valiant SAI
SET @VALIANT := 33306;
SET @VICTORY := 64811; -- Spell Bested Orgrimmar
DELETE FROM `smart_scripts` WHERE `entryorguid`=@VALIANT AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@VALIANT,0,0,0,64,0,100,0,0,0,0,0,98,10466,14384,0,0,0,0,7,0,0,0,0,0,0,0,'Orgrimmar Valiant - Gossip Hello - Send different gossip (see conditions)'),
(@VALIANT,0,1,2,62,0,100,0,10466,1,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Orgrimmar Valiant - Gossip select - close gossip'),
(@VALIANT,0,2,3,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Orgrimmar Valiant - Gossip select - Store target'),
(@VALIANT,0,3,4,61,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Valiant - Gossip - Change Faction'),
(@VALIANT,0,4,5,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,'Orgrimmar Valiant - Gossip - Attack Invoker vehicle'),
(@VALIANT,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Valiant - Gossip - Say Text'),
(@VALIANT,0,6,0,4,0,100,0,0,0,0,0,11,64221,2,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Valiant - Aggro - Cast defend aura'),
(@VALIANT,0,7,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Orgrimmar Valiant - In combat - Cast Shield-Breaker'),
(@VALIANT,0,8,0,9,0,100,0,8,25,7000,7000,11,63010,0,0,0,0,0,2,0,0,0,0,0,0,0,'Orgrimmar Valiant - Distance - Cast Charge'),
(@VALIANT,0,9,0,0,0,100,0,10000,10000,15000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Valiant - In combat - Flee'),
(@VALIANT,0,10,11,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Valiant - HP at 5% - Set faction default'),
(@VALIANT,0,11,12,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Valiant - Defeated - Say text'),
(@VALIANT,0,12,14,61,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Orgrimmar Valiant - Defeated - Cross cast spell'),
(@VALIANT,0,13,14,6,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Orgrimmar Valiant - Death - Cross cast spell'), -- this line is hacky, npc shouldn't be killed
(@VALIANT,0,14,0,61,0,100,1,0,0,0,0,86,62724,3,12,1,0,0,12,1,0,0,0,0,0,0,'Orgrimmar Valiant - Defeated - Cross Cast Mounted Melee Victory'),
(@VALIANT,0,15,18,25,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Valiant - Reset - Set faction default'),
(@VALIANT,0,16,17,5,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Valiant - Kill - Say win text'),
(@VALIANT,0,17,18,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Valiant - Link - Set faction default'),
(@VALIANT,0,18,19,61,0,100,1,0,0,0,0,28,64221,0,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Valiant - Link - Remove defend aura'),
(@VALIANT,0,19,0,61,0,100,1,0,0,0,0,28,62719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Valiant - Link - Remove defend charges');

DELETE FROM `creature_text` WHERE `entry`=@VALIANT;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@VALIANT,0,0,"Let it begin!",12,0,100,0,3,0,'Orgrimmar Valiant Aggro'),
(@VALIANT,0,1,"On your guard!",12,0,100,0,3,0,'Orgrimmar Valiant Aggro'),
(@VALIANT,0,2,"Prepare yourself!",12,0,100,0,3,0,'Orgrimmar Valiant Aggro'),
(@VALIANT,0,3,"Ready yourself!",12,0,100,0,3,0,'Orgrimmar Valiant Aggro'),
(@VALIANT,1,0,"I have been defeated. Good fight!",12,0,100,0,3,0,'Orgrimmar Valiant Defeated'),
(@VALIANT,1,1,"It would seem I underestimated your skills. Well done.",12,0,100,0,3,0,'Orgrimmar Valiant Defeated'),
(@VALIANT,1,2,"That was a well fought battle. I yield to you.",12,0,100,0,3,0,'Orgrimmar Valiant Defeated'),
(@VALIANT,1,3,"I yield to you.",12,0,100,0,3,0,'Orgrimmar Valiant Defeated'),
(@VALIANT,2,0,"I am afraid you will need more practice to defeat me.",12,0,100,0,3,0,'Orgrimmar Valiant Victory'),
(@VALIANT,2,1,"I have won. Better luck another time, friend.",12,0,100,0,3,0,'Orgrimmar Valiant Victory'),
(@VALIANT,2,2,"It seems you still need more practice. Perhaps another time.",12,0,100,0,3,0,'Orgrimmar Valiant Victory'),
(@VALIANT,2,3,"Victory is mine!",12,0,100,0,3,0,'Orgrimmar Valiant Victory');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@VALIANT AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@VALIANT,0,0,1,0,63034,0,0,0,0,'',"SAI - Orgrimmar Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,0,9,0,13772,0,0,0,0,'',"SAI - Orgrimmar Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,0,1,0,@VICTORY,0,0,1,0,'',"SAI - Orgrimmar Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,1,1,0,63034,0,0,0,0,'',"SAI - Orgrimmar Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,1,9,0,13777,0,0,0,0,'',"SAI - Orgrimmar Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,1,1,0,@VICTORY,0,0,1,0,'',"SAI - Orgrimmar Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,2,1,0,63034,0,0,0,0,'',"SAI - Orgrimmar Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,2,9,0,13782,0,0,0,0,'',"SAI - Orgrimmar Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,2,1,0,@VICTORY,0,0,1,0,'',"SAI - Orgrimmar Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,3,1,0,63034,0,0,0,0,'',"SAI - Orgrimmar Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,3,9,0,13787,0,0,0,0,'',"SAI - Orgrimmar Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,3,1,0,@VICTORY,0,0,1,0,'',"SAI - Orgrimmar Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,4,1,0,63034,0,0,0,0,'',"SAI - Orgrimmar Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,4,9,0,13767,0,0,0,0,'',"SAI - Orgrimmar Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,4,1,0,@VICTORY,0,0,1,0,'',"SAI - Orgrimmar Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,5,1,0,63034,0,0,0,0,'',"SAI - Orgrimmar Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,5,9,0,13761,0,0,0,0,'',"SAI - Orgrimmar Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,5,1,0,@VICTORY,0,0,1,0,'',"SAI - Orgrimmar Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,6,1,0,63034,0,0,0,0,'',"SAI - Orgrimmar Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,6,9,0,13745,0,0,0,0,'',"SAI - Orgrimmar Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,6,1,0,@VICTORY,0,0,1,0,'',"SAI - Orgrimmar Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,7,1,0,63034,0,0,0,0,'',"SAI - Orgrimmar Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,7,9,0,13750,0,0,0,0,'',"SAI - Orgrimmar Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,7,1,0,@VICTORY,0,0,1,0,'',"SAI - Orgrimmar Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,8,1,0,63034,0,0,0,0,'',"SAI - Orgrimmar Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,8,9,0,13756,0,0,0,0,'',"SAI - Orgrimmar Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,8,1,0,@VICTORY,0,0,1,0,'',"SAI - Orgrimmar Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,9,1,0,63034,0,0,0,0,'',"SAI - Orgrimmar Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,9,9,0,13665,0,0,0,0,'',"SAI - Orgrimmar Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,9,1,0,@VICTORY,0,0,1,0,'',"SAI - Orgrimmar Valiant show different menu if player doesn't have aura");

-- Undercity Valiant SAI
SET @VALIANT := 33384;
SET @VICTORY := 64816; -- Spell Bested the Undercity
DELETE FROM `smart_scripts` WHERE `entryorguid`=@VALIANT AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@VALIANT,0,0,0,64,0,100,0,0,0,0,0,98,10466,14384,0,0,0,0,7,0,0,0,0,0,0,0,'Undercity Valiant - Gossip Hello - Send different gossip (see conditions)'),
(@VALIANT,0,1,2,62,0,100,0,10466,1,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Undercity Valiant - Gossip select - close gossip'),
(@VALIANT,0,2,3,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Undercity Valiant - Gossip select - Store target'),
(@VALIANT,0,3,4,61,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Valiant - Gossip - Change Faction'),
(@VALIANT,0,4,5,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,'Undercity Valiant - Gossip - Attack Invoker vehicle'),
(@VALIANT,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Valiant - Gossip - Say Text'),
(@VALIANT,0,6,0,4,0,100,0,0,0,0,0,11,64221,2,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Valiant - Aggro - Cast defend aura'),
(@VALIANT,0,7,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Undercity Valiant - In combat - Cast Shield-Breaker'),
(@VALIANT,0,8,0,9,0,100,0,8,25,7000,7000,11,63010,0,0,0,0,0,2,0,0,0,0,0,0,0,'Undercity Valiant - Distance - Cast Charge'),
(@VALIANT,0,9,0,0,0,100,0,10000,10000,15000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Valiant - In combat - Flee'),
(@VALIANT,0,10,11,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Valiant - HP at 5% - Set faction default'),
(@VALIANT,0,11,12,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Valiant - Defeated - Say text'),
(@VALIANT,0,12,14,61,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Undercity Valiant - Defeated - Cross cast spell'),
(@VALIANT,0,13,14,6,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Undercity Valiant - Death - Cross cast spell'), -- this line is hacky, npc shouldn't be killed
(@VALIANT,0,14,0,61,0,100,1,0,0,0,0,86,62724,3,12,1,0,0,12,1,0,0,0,0,0,0,'Undercity Valiant - Defeated - Cross Cast Mounted Melee Victory'),
(@VALIANT,0,15,18,25,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Valiant - Reset - Set faction default'),
(@VALIANT,0,16,17,5,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Valiant - Kill - Say win text'),
(@VALIANT,0,17,18,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Valiant - Link - Set faction default'),
(@VALIANT,0,18,19,61,0,100,1,0,0,0,0,28,64221,0,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Valiant - Link - Remove defend aura'),
(@VALIANT,0,19,0,61,0,100,1,0,0,0,0,28,62719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Valiant - Link - Remove defend charges');

DELETE FROM `creature_text` WHERE `entry`=@VALIANT;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@VALIANT,0,0,"Let it begin!",12,0,100,0,3,0,'Undercity Valiant Aggro'),
(@VALIANT,0,1,"On your guard!",12,0,100,0,3,0,'Undercity Valiant Aggro'),
(@VALIANT,0,2,"Prepare yourself!",12,0,100,0,3,0,'Undercity Valiant Aggro'),
(@VALIANT,0,3,"Ready yourself!",12,0,100,0,3,0,'Undercity Valiant Aggro'),
(@VALIANT,1,0,"I have been defeated. Good fight!",12,0,100,0,3,0,'Undercity Valiant Defeated'),
(@VALIANT,1,1,"It would seem I underestimated your skills. Well done.",12,0,100,0,3,0,'Undercity Valiant Defeated'),
(@VALIANT,1,2,"That was a well fought battle. I yield to you.",12,0,100,0,3,0,'Undercity Valiant Defeated'),
(@VALIANT,1,3,"I yield to you.",12,0,100,0,3,0,'Undercity Valiant Defeated'),
(@VALIANT,2,0,"I am afraid you will need more practice to defeat me.",12,0,100,0,3,0,'Undercity Valiant Victory'),
(@VALIANT,2,1,"I have won. Better luck another time, friend.",12,0,100,0,3,0,'Undercity Valiant Victory'),
(@VALIANT,2,2,"It seems you still need more practice. Perhaps another time.",12,0,100,0,3,0,'Undercity Valiant Victory'),
(@VALIANT,2,3,"Victory is mine!",12,0,100,0,3,0,'Undercity Valiant Victory');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@VALIANT AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@VALIANT,0,0,1,0,63034,0,0,0,0,'',"SAI - Undercity Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,0,9,0,13772,0,0,0,0,'',"SAI - Undercity Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,0,1,0,@VICTORY,0,0,1,0,'',"SAI - Undercity Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,1,1,0,63034,0,0,0,0,'',"SAI - Undercity Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,1,9,0,13777,0,0,0,0,'',"SAI - Undercity Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,1,1,0,@VICTORY,0,0,1,0,'',"SAI - Undercity Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,2,1,0,63034,0,0,0,0,'',"SAI - Undercity Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,2,9,0,13782,0,0,0,0,'',"SAI - Undercity Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,2,1,0,@VICTORY,0,0,1,0,'',"SAI - Undercity Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,3,1,0,63034,0,0,0,0,'',"SAI - Undercity Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,3,9,0,13787,0,0,0,0,'',"SAI - Undercity Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,3,1,0,@VICTORY,0,0,1,0,'',"SAI - Undercity Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,4,1,0,63034,0,0,0,0,'',"SAI - Undercity Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,4,9,0,13767,0,0,0,0,'',"SAI - Undercity Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,4,1,0,@VICTORY,0,0,1,0,'',"SAI - Undercity Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,5,1,0,63034,0,0,0,0,'',"SAI - Undercity Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,5,9,0,13761,0,0,0,0,'',"SAI - Undercity Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,5,1,0,@VICTORY,0,0,1,0,'',"SAI - Undercity Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,6,1,0,63034,0,0,0,0,'',"SAI - Undercity Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,6,9,0,13745,0,0,0,0,'',"SAI - Undercity Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,6,1,0,@VICTORY,0,0,1,0,'',"SAI - Undercity Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,7,1,0,63034,0,0,0,0,'',"SAI - Undercity Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,7,9,0,13750,0,0,0,0,'',"SAI - Undercity Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,7,1,0,@VICTORY,0,0,1,0,'',"SAI - Undercity Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,8,1,0,63034,0,0,0,0,'',"SAI - Undercity Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,8,9,0,13756,0,0,0,0,'',"SAI - Undercity Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,8,1,0,@VICTORY,0,0,1,0,'',"SAI - Undercity Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,9,1,0,63034,0,0,0,0,'',"SAI - Undercity Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,9,9,0,13665,0,0,0,0,'',"SAI - Undercity Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,9,1,0,@VICTORY,0,0,1,0,'',"SAI - Undercity Valiant show different menu if player doesn't have aura");

-- Thunder Bluff Valiant SAI
SET @VALIANT := 33383;
SET @VICTORY := 64815; -- Spell Bested Thunder Bluff
DELETE FROM `smart_scripts` WHERE `entryorguid`=@VALIANT AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@VALIANT,0,0,0,64,0,100,0,0,0,0,0,98,10466,14384,0,0,0,0,7,0,0,0,0,0,0,0,'Thunder Bluff Valiant - Gossip Hello - Send different gossip (see conditions)'),
(@VALIANT,0,1,2,62,0,100,0,10466,1,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Thunder Bluff Valiant - Gossip select - close gossip'),
(@VALIANT,0,2,3,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Thunder Bluff Valiant - Gossip select - Store target'),
(@VALIANT,0,3,4,61,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Valiant - Gossip - Change Faction'),
(@VALIANT,0,4,5,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,'Thunder Bluff Valiant - Gossip - Attack Invoker vehicle'),
(@VALIANT,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Valiant - Gossip - Say Text'),
(@VALIANT,0,6,0,4,0,100,0,0,0,0,0,11,64221,2,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Valiant - Aggro - Cast defend aura'),
(@VALIANT,0,7,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Thunder Bluff Valiant - In combat - Cast Shield-Breaker'),
(@VALIANT,0,8,0,9,0,100,0,8,25,7000,7000,11,63010,0,0,0,0,0,2,0,0,0,0,0,0,0,'Thunder Bluff Valiant - Distance - Cast Charge'),
(@VALIANT,0,9,0,0,0,100,0,10000,10000,15000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Valiant - In combat - Flee'),
(@VALIANT,0,10,11,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Valiant - HP at 5% - Set faction default'),
(@VALIANT,0,11,12,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Valiant - Defeated - Say text'),
(@VALIANT,0,12,14,61,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Thunder Bluff Valiant - Defeated - Cross cast spell'),
(@VALIANT,0,13,14,6,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Thunder Bluff Valiant - Death - Cross cast spell'), -- this line is hacky, npc shouldn't be killed
(@VALIANT,0,14,0,61,0,100,1,0,0,0,0,86,62724,3,12,1,0,0,12,1,0,0,0,0,0,0,'Thunder Bluff Valiant - Defeated - Cross Cast Mounted Melee Victory'),
(@VALIANT,0,15,18,25,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Valiant - Reset - Set faction default'),
(@VALIANT,0,16,17,5,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Valiant - Kill - Say win text'),
(@VALIANT,0,17,18,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Valiant - Link - Set faction default'),
(@VALIANT,0,18,19,61,0,100,1,0,0,0,0,28,64221,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Valiant - Link - Remove defend aura'),
(@VALIANT,0,19,0,61,0,100,1,0,0,0,0,28,62719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Valiant - Link - Remove defend charges');

DELETE FROM `creature_text` WHERE `entry`=@VALIANT;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@VALIANT,0,0,"Let it begin!",12,0,100,0,3,0,'Thunder Bluff Valiant Aggro'),
(@VALIANT,0,1,"On your guard!",12,0,100,0,3,0,'Thunder Bluff Valiant Aggro'),
(@VALIANT,0,2,"Prepare yourself!",12,0,100,0,3,0,'Thunder Bluff Valiant Aggro'),
(@VALIANT,0,3,"Ready yourself!",12,0,100,0,3,0,'Thunder Bluff Valiant Aggro'),
(@VALIANT,1,0,"I have been defeated. Good fight!",12,0,100,0,3,0,'Thunder Bluff Valiant Defeated'),
(@VALIANT,1,1,"It would seem I underestimated your skills. Well done.",12,0,100,0,3,0,'Thunder Bluff Valiant Defeated'),
(@VALIANT,1,2,"That was a well fought battle. I yield to you.",12,0,100,0,3,0,'Thunder Bluff Valiant Defeated'),
(@VALIANT,1,3,"I yield to you.",12,0,100,0,3,0,'Thunder Bluff Valiant Defeated'),
(@VALIANT,2,0,"I am afraid you will need more practice to defeat me.",12,0,100,0,3,0,'Thunder Bluff Valiant Victory'),
(@VALIANT,2,1,"I have won. Better luck another time, friend.",12,0,100,0,3,0,'Thunder Bluff Valiant Victory'),
(@VALIANT,2,2,"It seems you still need more practice. Perhaps another time.",12,0,100,0,3,0,'Thunder Bluff Valiant Victory'),
(@VALIANT,2,3,"Victory is mine!",12,0,100,0,3,0,'Thunder Bluff Valiant Victory');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@VALIANT AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@VALIANT,0,0,1,0,63034,0,0,0,0,'',"SAI - Thunder Bluff Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,0,9,0,13772,0,0,0,0,'',"SAI - Thunder Bluff Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,0,1,0,@VICTORY,0,0,1,0,'',"SAI - Thunder Bluff Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,1,1,0,63034,0,0,0,0,'',"SAI - Thunder Bluff Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,1,9,0,13777,0,0,0,0,'',"SAI - Thunder Bluff Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,1,1,0,@VICTORY,0,0,1,0,'',"SAI - Thunder Bluff Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,2,1,0,63034,0,0,0,0,'',"SAI - Thunder Bluff Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,2,9,0,13782,0,0,0,0,'',"SAI - Thunder Bluff Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,2,1,0,@VICTORY,0,0,1,0,'',"SAI - Thunder Bluff Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,3,1,0,63034,0,0,0,0,'',"SAI - Thunder Bluff Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,3,9,0,13787,0,0,0,0,'',"SAI - Thunder Bluff Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,3,1,0,@VICTORY,0,0,1,0,'',"SAI - Thunder Bluff Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,4,1,0,63034,0,0,0,0,'',"SAI - Thunder Bluff Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,4,9,0,13767,0,0,0,0,'',"SAI - Thunder Bluff Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,4,1,0,@VICTORY,0,0,1,0,'',"SAI - Thunder Bluff Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,5,1,0,63034,0,0,0,0,'',"SAI - Thunder Bluff Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,5,9,0,13761,0,0,0,0,'',"SAI - Thunder Bluff Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,5,1,0,@VICTORY,0,0,1,0,'',"SAI - Thunder Bluff Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,6,1,0,63034,0,0,0,0,'',"SAI - Thunder Bluff Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,6,9,0,13745,0,0,0,0,'',"SAI - Thunder Bluff Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,6,1,0,@VICTORY,0,0,1,0,'',"SAI - Thunder Bluff Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,7,1,0,63034,0,0,0,0,'',"SAI - Thunder Bluff Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,7,9,0,13750,0,0,0,0,'',"SAI - Thunder Bluff Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,7,1,0,@VICTORY,0,0,1,0,'',"SAI - Thunder Bluff Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,8,1,0,63034,0,0,0,0,'',"SAI - Thunder Bluff Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,8,9,0,13756,0,0,0,0,'',"SAI - Thunder Bluff Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,8,1,0,@VICTORY,0,0,1,0,'',"SAI - Thunder Bluff Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,9,1,0,63034,0,0,0,0,'',"SAI - Thunder Bluff Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,9,9,0,13665,0,0,0,0,'',"SAI - Thunder Bluff Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,9,1,0,@VICTORY,0,0,1,0,'',"SAI - Thunder Bluff Valiant show different menu if player doesn't have aura");

-- Silvermoon Valiant SAI
SET @VALIANT := 33382;
SET @VICTORY := 64813; -- Spell Bested Silvermoon City
DELETE FROM `smart_scripts` WHERE `entryorguid`=@VALIANT AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@VALIANT,0,0,0,64,0,100,0,0,0,0,0,98,10466,14384,0,0,0,0,7,0,0,0,0,0,0,0,'Silvermoon Valiant - Gossip Hello - Send different gossip (see conditions)'),
(@VALIANT,0,1,2,62,0,100,0,10466,1,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Silvermoon Valiant - Gossip select - close gossip'),
(@VALIANT,0,2,3,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Silvermoon Valiant - Gossip select - Store target'),
(@VALIANT,0,3,4,61,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Valiant - Gossip - Change Faction'),
(@VALIANT,0,4,5,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,'Silvermoon Valiant - Gossip - Attack Invoker vehicle'),
(@VALIANT,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Valiant - Gossip - Say Text'),
(@VALIANT,0,6,0,4,0,100,0,0,0,0,0,11,64221,2,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Valiant - Aggro - Cast defend aura'),
(@VALIANT,0,7,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Silvermoon Valiant - In combat - Cast Shield-Breaker'),
(@VALIANT,0,8,0,9,0,100,0,8,25,7000,7000,11,63010,0,0,0,0,0,2,0,0,0,0,0,0,0,'Silvermoon Valiant - Distance - Cast Charge'),
(@VALIANT,0,9,0,0,0,100,0,10000,10000,15000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Valiant - In combat - Flee'),
(@VALIANT,0,10,11,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Valiant - HP at 5% - Set faction default'),
(@VALIANT,0,11,12,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Valiant - Defeated - Say text'),
(@VALIANT,0,12,14,61,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Silvermoon Valiant - Defeated - Cross cast spell'),
(@VALIANT,0,13,14,6,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Silvermoon Valiant - Death - Cross cast spell'), -- this line is hacky, npc shouldn't be killed
(@VALIANT,0,14,0,61,0,100,1,0,0,0,0,86,62724,3,12,1,0,0,12,1,0,0,0,0,0,0,'Silvermoon Valiant - Defeated - Cross Cast Mounted Melee Victory'),
(@VALIANT,0,15,18,25,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Valiant - Reset - Set faction default'),
(@VALIANT,0,16,17,5,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Valiant - Kill - Say win text'),
(@VALIANT,0,17,18,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Valiant - Link - Set faction default'),
(@VALIANT,0,18,19,61,0,100,1,0,0,0,0,28,64221,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Valiant - Link - Remove defend aura'),
(@VALIANT,0,19,0,61,0,100,1,0,0,0,0,28,62719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Valiant - Link - Remove defend charges');

DELETE FROM `creature_text` WHERE `entry`=@VALIANT;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@VALIANT,0,0,"Let it begin!",12,0,100,0,3,0,'Silvermoon Valiant Aggro'),
(@VALIANT,0,1,"On your guard!",12,0,100,0,3,0,'Silvermoon Valiant Aggro'),
(@VALIANT,0,2,"Prepare yourself!",12,0,100,0,3,0,'Silvermoon Valiant Aggro'),
(@VALIANT,0,3,"Ready yourself!",12,0,100,0,3,0,'Silvermoon Valiant Aggro'),
(@VALIANT,1,0,"I have been defeated. Good fight!",12,0,100,0,3,0,'Silvermoon Valiant Defeated'),
(@VALIANT,1,1,"It would seem I underestimated your skills. Well done.",12,0,100,0,3,0,'Silvermoon Valiant Defeated'),
(@VALIANT,1,2,"That was a well fought battle. I yield to you.",12,0,100,0,3,0,'Silvermoon Valiant Defeated'),
(@VALIANT,1,3,"I yield to you.",12,0,100,0,3,0,'Silvermoon Valiant Defeated'),
(@VALIANT,2,0,"I am afraid you will need more practice to defeat me.",12,0,100,0,3,0,'Silvermoon Valiant Victory'),
(@VALIANT,2,1,"I have won. Better luck another time, friend.",12,0,100,0,3,0,'Silvermoon Valiant Victory'),
(@VALIANT,2,2,"It seems you still need more practice. Perhaps another time.",12,0,100,0,3,0,'Silvermoon Valiant Victory'),
(@VALIANT,2,3,"Victory is mine!",12,0,100,0,3,0,'Silvermoon Valiant Victory');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@VALIANT AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@VALIANT,0,0,1,0,63034,0,0,0,0,'',"SAI - Silvermoon Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,0,9,0,13772,0,0,0,0,'',"SAI - Silvermoon Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,0,1,0,@VICTORY,0,0,1,0,'',"SAI - Silvermoon Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,1,1,0,63034,0,0,0,0,'',"SAI - Silvermoon Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,1,9,0,13777,0,0,0,0,'',"SAI - Silvermoon Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,1,1,0,@VICTORY,0,0,1,0,'',"SAI - Silvermoon Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,2,1,0,63034,0,0,0,0,'',"SAI - Silvermoon Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,2,9,0,13782,0,0,0,0,'',"SAI - Silvermoon Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,2,1,0,@VICTORY,0,0,1,0,'',"SAI - Silvermoon Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,3,1,0,63034,0,0,0,0,'',"SAI - Silvermoon Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,3,9,0,13787,0,0,0,0,'',"SAI - Silvermoon Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,3,1,0,@VICTORY,0,0,1,0,'',"SAI - Silvermoon Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,4,1,0,63034,0,0,0,0,'',"SAI - Silvermoon Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,4,9,0,13767,0,0,0,0,'',"SAI - Silvermoon Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,4,1,0,@VICTORY,0,0,1,0,'',"SAI - Silvermoon Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,5,1,0,63034,0,0,0,0,'',"SAI - Silvermoon Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,5,9,0,13761,0,0,0,0,'',"SAI - Silvermoon Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,5,1,0,@VICTORY,0,0,1,0,'',"SAI - Silvermoon Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,6,1,0,63034,0,0,0,0,'',"SAI - Silvermoon Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,6,9,0,13745,0,0,0,0,'',"SAI - Silvermoon Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,6,1,0,@VICTORY,0,0,1,0,'',"SAI - Silvermoon Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,7,1,0,63034,0,0,0,0,'',"SAI - Silvermoon Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,7,9,0,13750,0,0,0,0,'',"SAI - Silvermoon Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,7,1,0,@VICTORY,0,0,1,0,'',"SAI - Silvermoon Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,8,1,0,63034,0,0,0,0,'',"SAI - Silvermoon Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,8,9,0,13756,0,0,0,0,'',"SAI - Silvermoon Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,8,1,0,@VICTORY,0,0,1,0,'',"SAI - Silvermoon Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,9,1,0,63034,0,0,0,0,'',"SAI - Silvermoon Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,9,9,0,13665,0,0,0,0,'',"SAI - Silvermoon Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,9,1,0,@VICTORY,0,0,1,0,'',"SAI - Silvermoon Valiant show different menu if player doesn't have aura");

-- Stormwind Valiant SAI
SET @VALIANT := 33561;
SET @VICTORY := 64814; -- Spell Bested Stormwind
DELETE FROM `smart_scripts` WHERE `entryorguid`=@VALIANT AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@VALIANT,0,0,0,64,0,100,0,0,0,0,0,98,10466,14384,0,0,0,0,7,0,0,0,0,0,0,0,'Stormwind Valiant - Gossip Hello - Send different gossip (see conditions)'),
(@VALIANT,0,1,2,62,0,100,0,10466,1,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Stormwind Valiant - Gossip select - close gossip'),
(@VALIANT,0,2,3,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Stormwind Valiant - Gossip select - Store target'),
(@VALIANT,0,3,4,61,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Valiant - Gossip - Change Faction'),
(@VALIANT,0,4,5,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,'Stormwind Valiant - Gossip - Attack Invoker vehicle'),
(@VALIANT,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Valiant - Gossip - Say Text'),
(@VALIANT,0,6,0,4,0,100,0,0,0,0,0,11,64221,2,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Valiant - Aggro - Cast defend aura'),
(@VALIANT,0,7,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Stormwind Valiant - In combat - Cast Shield-Breaker'),
(@VALIANT,0,8,0,9,0,100,0,8,25,7000,7000,11,63010,0,0,0,0,0,2,0,0,0,0,0,0,0,'Stormwind Valiant - Distance - Cast Charge'),
(@VALIANT,0,9,0,0,0,100,0,10000,10000,15000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Valiant - In combat - Flee'),
(@VALIANT,0,10,11,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Valiant - HP at 5% - Set faction default'),
(@VALIANT,0,11,12,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Valiant - Defeated - Say text'),
(@VALIANT,0,12,14,61,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Stormwind Valiant - Defeated - Cross cast spell'),
(@VALIANT,0,13,14,6,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Stormwind Valiant - Death - Cross cast spell'), -- this line is hacky, npc shouldn't be killed
(@VALIANT,0,14,0,61,0,100,1,0,0,0,0,86,62724,3,12,1,0,0,12,1,0,0,0,0,0,0,'Stormwind Valiant - Defeated - Cross Cast Mounted Melee Victory'),
(@VALIANT,0,15,18,25,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Valiant - Reset - Set faction default'),
(@VALIANT,0,16,17,5,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Valiant - Kill - Say win text'),
(@VALIANT,0,17,18,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Valiant - Link - Set faction default'),
(@VALIANT,0,18,19,61,0,100,1,0,0,0,0,28,64221,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Valiant - Link - Remove defend aura'),
(@VALIANT,0,19,0,61,0,100,1,0,0,0,0,28,62719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Valiant - Link - Remove defend charges');

DELETE FROM `creature_text` WHERE `entry`=@VALIANT;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@VALIANT,0,0,"Let it begin!",12,0,100,0,3,0,'Stormwind Valiant Aggro'),
(@VALIANT,0,1,"On your guard!",12,0,100,0,3,0,'Stormwind Valiant Aggro'),
(@VALIANT,0,2,"Prepare yourself!",12,0,100,0,3,0,'Stormwind Valiant Aggro'),
(@VALIANT,0,3,"Ready yourself!",12,0,100,0,3,0,'Stormwind Valiant Aggro'),
(@VALIANT,1,0,"I have been defeated. Good fight!",12,0,100,0,3,0,'Stormwind Valiant Defeated'),
(@VALIANT,1,1,"It would seem I underestimated your skills. Well done.",12,0,100,0,3,0,'Stormwind Valiant Defeated'),
(@VALIANT,1,2,"That was a well fought battle. I yield to you.",12,0,100,0,3,0,'Stormwind Valiant Defeated'),
(@VALIANT,1,3,"I yield to you.",12,0,100,0,3,0,'Stormwind Valiant Defeated'),
(@VALIANT,2,0,"I am afraid you will need more practice to defeat me.",12,0,100,0,3,0,'Stormwind Valiant Victory'),
(@VALIANT,2,1,"I have won. Better luck another time, friend.",12,0,100,0,3,0,'Stormwind Valiant Victory'),
(@VALIANT,2,2,"It seems you still need more practice. Perhaps another time.",12,0,100,0,3,0,'Stormwind Valiant Victory'),
(@VALIANT,2,3,"Victory is mine!",12,0,100,0,3,0,'Stormwind Valiant Victory');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@VALIANT AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@VALIANT,0,0,1,0,63034,0,0,0,0,'',"SAI - Stormwind Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,0,9,0,13772,0,0,0,0,'',"SAI - Stormwind Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,0,1,0,@VICTORY,0,0,1,0,'',"SAI - Stormwind Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,1,1,0,63034,0,0,0,0,'',"SAI - Stormwind Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,1,9,0,13777,0,0,0,0,'',"SAI - Stormwind Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,1,1,0,@VICTORY,0,0,1,0,'',"SAI - Stormwind Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,2,1,0,63034,0,0,0,0,'',"SAI - Stormwind Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,2,9,0,13782,0,0,0,0,'',"SAI - Stormwind Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,2,1,0,@VICTORY,0,0,1,0,'',"SAI - Stormwind Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,3,1,0,63034,0,0,0,0,'',"SAI - Stormwind Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,3,9,0,13787,0,0,0,0,'',"SAI - Stormwind Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,3,1,0,@VICTORY,0,0,1,0,'',"SAI - Stormwind Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,4,1,0,63034,0,0,0,0,'',"SAI - Stormwind Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,4,9,0,13767,0,0,0,0,'',"SAI - Stormwind Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,4,1,0,@VICTORY,0,0,1,0,'',"SAI - Stormwind Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,5,1,0,63034,0,0,0,0,'',"SAI - Stormwind Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,5,9,0,13761,0,0,0,0,'',"SAI - Stormwind Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,5,1,0,@VICTORY,0,0,1,0,'',"SAI - Stormwind Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,6,1,0,63034,0,0,0,0,'',"SAI - Stormwind Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,6,9,0,13745,0,0,0,0,'',"SAI - Stormwind Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,6,1,0,@VICTORY,0,0,1,0,'',"SAI - Stormwind Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,7,1,0,63034,0,0,0,0,'',"SAI - Stormwind Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,7,9,0,13750,0,0,0,0,'',"SAI - Stormwind Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,7,1,0,@VICTORY,0,0,1,0,'',"SAI - Stormwind Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,8,1,0,63034,0,0,0,0,'',"SAI - Stormwind Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,8,9,0,13756,0,0,0,0,'',"SAI - Stormwind Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,8,1,0,@VICTORY,0,0,1,0,'',"SAI - Stormwind Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,9,1,0,63034,0,0,0,0,'',"SAI - Stormwind Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,9,9,0,13665,0,0,0,0,'',"SAI - Stormwind Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,9,1,0,@VICTORY,0,0,1,0,'',"SAI - Stormwind Valiant show different menu if player doesn't have aura");

-- Ironforge Valiant SAI
SET @VALIANT := 33564;
SET @VICTORY := 64810; -- Spell Bested Ironforge
DELETE FROM `smart_scripts` WHERE `entryorguid`=@VALIANT AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@VALIANT,0,0,0,64,0,100,0,0,0,0,0,98,10466,14384,0,0,0,0,7,0,0,0,0,0,0,0,'Ironforge Valiant - Gossip Hello - Send different gossip (see conditions)'),
(@VALIANT,0,1,2,62,0,100,0,10466,1,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Ironforge Valiant - Gossip select - close gossip'),
(@VALIANT,0,2,3,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Ironforge Valiant - Gossip select - Store target'),
(@VALIANT,0,3,4,61,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Valiant - Gossip - Change Faction'),
(@VALIANT,0,4,5,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,'Ironforge Valiant - Gossip - Attack Invoker vehicle'),
(@VALIANT,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Valiant - Gossip - Say Text'),
(@VALIANT,0,6,0,4,0,100,0,0,0,0,0,11,64221,2,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Valiant - Aggro - Cast defend aura'),
(@VALIANT,0,7,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Ironforge Valiant - In combat - Cast Shield-Breaker'),
(@VALIANT,0,8,0,9,0,100,0,8,25,7000,7000,11,63010,0,0,0,0,0,2,0,0,0,0,0,0,0,'Ironforge Valiant - Distance - Cast Charge'),
(@VALIANT,0,9,0,0,0,100,0,10000,10000,15000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Valiant - In combat - Flee'),
(@VALIANT,0,10,11,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Valiant - HP at 5% - Set faction default'),
(@VALIANT,0,11,12,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Valiant - Defeated - Say text'),
(@VALIANT,0,12,14,61,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Ironforge Valiant - Defeated - Cross cast spell'),
(@VALIANT,0,13,14,6,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Ironforge Valiant - Death - Cross cast spell'), -- this line is hacky, npc shouldn't be killed
(@VALIANT,0,14,0,61,0,100,1,0,0,0,0,86,62724,3,12,1,0,0,12,1,0,0,0,0,0,0,'Ironforge Valiant - Defeated - Cross Cast Mounted Melee Victory'),
(@VALIANT,0,15,18,25,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Valiant - Reset - Set faction default'),
(@VALIANT,0,16,17,5,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Valiant - Kill - Say win text'),
(@VALIANT,0,17,18,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Valiant - Link - Set faction default'),
(@VALIANT,0,18,19,61,0,100,1,0,0,0,0,28,64221,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Valiant - Link - Remove defend aura'),
(@VALIANT,0,19,0,61,0,100,1,0,0,0,0,28,62719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Valiant - Link - Remove defend charges');

DELETE FROM `creature_text` WHERE `entry`=@VALIANT;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@VALIANT,0,0,"Let it begin!",12,0,100,0,3,0,'Ironforge Valiant Aggro'),
(@VALIANT,0,1,"On your guard!",12,0,100,0,3,0,'Ironforge Valiant Aggro'),
(@VALIANT,0,2,"Prepare yourself!",12,0,100,0,3,0,'Ironforge Valiant Aggro'),
(@VALIANT,0,3,"Ready yourself!",12,0,100,0,3,0,'Ironforge Valiant Aggro'),
(@VALIANT,1,0,"I have been defeated. Good fight!",12,0,100,0,3,0,'Ironforge Valiant Defeated'),
(@VALIANT,1,1,"It would seem I underestimated your skills. Well done.",12,0,100,0,3,0,'Ironforge Valiant Defeated'),
(@VALIANT,1,2,"That was a well fought battle. I yield to you.",12,0,100,0,3,0,'Ironforge Valiant Defeated'),
(@VALIANT,1,3,"I yield to you.",12,0,100,0,3,0,'Ironforge Valiant Defeated'),
(@VALIANT,2,0,"I am afraid you will need more practice to defeat me.",12,0,100,0,3,0,'Ironforge Valiant Victory'),
(@VALIANT,2,1,"I have won. Better luck another time, friend.",12,0,100,0,3,0,'Ironforge Valiant Victory'),
(@VALIANT,2,2,"It seems you still need more practice. Perhaps another time.",12,0,100,0,3,0,'Ironforge Valiant Victory'),
(@VALIANT,2,3,"Victory is mine!",12,0,100,0,3,0,'Ironforge Valiant Victory');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@VALIANT AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@VALIANT,0,0,1,0,63034,0,0,0,0,'',"SAI - Ironforge Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,0,9,0,13772,0,0,0,0,'',"SAI - Ironforge Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,0,1,0,@VICTORY,0,0,1,0,'',"SAI - Ironforge Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,1,1,0,63034,0,0,0,0,'',"SAI - Ironforge Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,1,9,0,13777,0,0,0,0,'',"SAI - Ironforge Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,1,1,0,@VICTORY,0,0,1,0,'',"SAI - Ironforge Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,2,1,0,63034,0,0,0,0,'',"SAI - Ironforge Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,2,9,0,13782,0,0,0,0,'',"SAI - Ironforge Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,2,1,0,@VICTORY,0,0,1,0,'',"SAI - Ironforge Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,3,1,0,63034,0,0,0,0,'',"SAI - Ironforge Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,3,9,0,13787,0,0,0,0,'',"SAI - Ironforge Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,3,1,0,@VICTORY,0,0,1,0,'',"SAI - Ironforge Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,4,1,0,63034,0,0,0,0,'',"SAI - Ironforge Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,4,9,0,13767,0,0,0,0,'',"SAI - Ironforge Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,4,1,0,@VICTORY,0,0,1,0,'',"SAI - Ironforge Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,5,1,0,63034,0,0,0,0,'',"SAI - Ironforge Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,5,9,0,13761,0,0,0,0,'',"SAI - Ironforge Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,5,1,0,@VICTORY,0,0,1,0,'',"SAI - Ironforge Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,6,1,0,63034,0,0,0,0,'',"SAI - Ironforge Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,6,9,0,13745,0,0,0,0,'',"SAI - Ironforge Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,6,1,0,@VICTORY,0,0,1,0,'',"SAI - Ironforge Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,7,1,0,63034,0,0,0,0,'',"SAI - Ironforge Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,7,9,0,13750,0,0,0,0,'',"SAI - Ironforge Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,7,1,0,@VICTORY,0,0,1,0,'',"SAI - Ironforge Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,8,1,0,63034,0,0,0,0,'',"SAI - Ironforge Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,8,9,0,13756,0,0,0,0,'',"SAI - Ironforge Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,8,1,0,@VICTORY,0,0,1,0,'',"SAI - Ironforge Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,9,1,0,63034,0,0,0,0,'',"SAI - Ironforge Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,9,9,0,13665,0,0,0,0,'',"SAI - Ironforge Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,9,1,0,@VICTORY,0,0,1,0,'',"SAI - Ironforge Valiant show different menu if player doesn't have aura");

-- Gnomeregan Valiant SAI
SET @VALIANT := 33558;
SET @VICTORY := 64809; -- Spell Bested Gnomeregan
DELETE FROM `smart_scripts` WHERE `entryorguid`=@VALIANT AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@VALIANT,0,0,0,64,0,100,0,0,0,0,0,98,10466,14384,0,0,0,0,7,0,0,0,0,0,0,0,'Gnomeregan Valiant - Gossip Hello - Send different gossip (see conditions)'),
(@VALIANT,0,1,2,62,0,100,0,10466,1,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Gnomeregan Valiant - Gossip select - close gossip'),
(@VALIANT,0,2,3,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Gnomeregan Valiant - Gossip select - Store target'),
(@VALIANT,0,3,4,61,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Valiant - Gossip - Change Faction'),
(@VALIANT,0,4,5,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,'Gnomeregan Valiant - Gossip - Attack Invoker vehicle'),
(@VALIANT,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Valiant - Gossip - Say Text'),
(@VALIANT,0,6,0,4,0,100,0,0,0,0,0,11,64221,2,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Valiant - Aggro - Cast defend aura'),
(@VALIANT,0,7,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Gnomeregan Valiant - In combat - Cast Shield-Breaker'),
(@VALIANT,0,8,0,9,0,100,0,8,25,7000,7000,11,63010,0,0,0,0,0,2,0,0,0,0,0,0,0,'Gnomeregan Valiant - Distance - Cast Charge'),
(@VALIANT,0,9,0,0,0,100,0,10000,10000,15000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Valiant - In combat - Flee'),
(@VALIANT,0,10,11,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Valiant - HP at 5% - Set faction default'),
(@VALIANT,0,11,12,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Valiant - Defeated - Say text'),
(@VALIANT,0,12,14,61,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Gnomeregan Valiant - Defeated - Cross cast spell'),
(@VALIANT,0,13,14,6,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Gnomeregan Valiant - Death - Cross cast spell'), -- this line is hacky, npc shouldn't be killed
(@VALIANT,0,14,0,61,0,100,1,0,0,0,0,86,62724,3,12,1,0,0,12,1,0,0,0,0,0,0,'Gnomeregan Valiant - Defeated - Cross Cast Mounted Melee Victory'),
(@VALIANT,0,15,18,25,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Valiant - Reset - Set faction default'),
(@VALIANT,0,16,17,5,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Valiant - Kill - Say win text'),
(@VALIANT,0,17,18,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Valiant - Link - Set faction default'),
(@VALIANT,0,18,19,61,0,100,1,0,0,0,0,28,64221,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Valiant - Link - Remove defend aura'),
(@VALIANT,0,19,0,61,0,100,1,0,0,0,0,28,62719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Valiant - Link - Remove defend charges');

DELETE FROM `creature_text` WHERE `entry`=@VALIANT;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@VALIANT,0,0,"Let it begin!",12,0,100,0,3,0,'Gnomeregan Valiant Aggro'),
(@VALIANT,0,1,"On your guard!",12,0,100,0,3,0,'Gnomeregan Valiant Aggro'),
(@VALIANT,0,2,"Prepare yourself!",12,0,100,0,3,0,'Gnomeregan Valiant Aggro'),
(@VALIANT,0,3,"Ready yourself!",12,0,100,0,3,0,'Gnomeregan Valiant Aggro'),
(@VALIANT,1,0,"I have been defeated. Good fight!",12,0,100,0,3,0,'Gnomeregan Valiant Defeated'),
(@VALIANT,1,1,"It would seem I underestimated your skills. Well done.",12,0,100,0,3,0,'Gnomeregan Valiant Defeated'),
(@VALIANT,1,2,"That was a well fought battle. I yield to you.",12,0,100,0,3,0,'Gnomeregan Valiant Defeated'),
(@VALIANT,1,3,"I yield to you.",12,0,100,0,3,0,'Gnomeregan Valiant Defeated'),
(@VALIANT,2,0,"I am afraid you will need more practice to defeat me.",12,0,100,0,3,0,'Gnomeregan Valiant Victory'),
(@VALIANT,2,1,"I have won. Better luck another time, friend.",12,0,100,0,3,0,'Gnomeregan Valiant Victory'),
(@VALIANT,2,2,"It seems you still need more practice. Perhaps another time.",12,0,100,0,3,0,'Gnomeregan Valiant Victory'),
(@VALIANT,2,3,"Victory is mine!",12,0,100,0,3,0,'Gnomeregan Valiant Victory');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@VALIANT AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@VALIANT,0,0,1,0,63034,0,0,0,0,'',"SAI - Gnomeregan Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,0,9,0,13772,0,0,0,0,'',"SAI - Gnomeregan Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,0,1,0,@VICTORY,0,0,1,0,'',"SAI - Gnomeregan Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,1,1,0,63034,0,0,0,0,'',"SAI - Gnomeregan Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,1,9,0,13777,0,0,0,0,'',"SAI - Gnomeregan Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,1,1,0,@VICTORY,0,0,1,0,'',"SAI - Gnomeregan Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,2,1,0,63034,0,0,0,0,'',"SAI - Gnomeregan Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,2,9,0,13782,0,0,0,0,'',"SAI - Gnomeregan Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,2,1,0,@VICTORY,0,0,1,0,'',"SAI - Gnomeregan Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,3,1,0,63034,0,0,0,0,'',"SAI - Gnomeregan Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,3,9,0,13787,0,0,0,0,'',"SAI - Gnomeregan Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,3,1,0,@VICTORY,0,0,1,0,'',"SAI - Gnomeregan Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,4,1,0,63034,0,0,0,0,'',"SAI - Gnomeregan Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,4,9,0,13767,0,0,0,0,'',"SAI - Gnomeregan Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,4,1,0,@VICTORY,0,0,1,0,'',"SAI - Gnomeregan Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,5,1,0,63034,0,0,0,0,'',"SAI - Gnomeregan Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,5,9,0,13761,0,0,0,0,'',"SAI - Gnomeregan Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,5,1,0,@VICTORY,0,0,1,0,'',"SAI - Gnomeregan Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,6,1,0,63034,0,0,0,0,'',"SAI - Gnomeregan Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,6,9,0,13745,0,0,0,0,'',"SAI - Gnomeregan Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,6,1,0,@VICTORY,0,0,1,0,'',"SAI - Gnomeregan Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,7,1,0,63034,0,0,0,0,'',"SAI - Gnomeregan Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,7,9,0,13750,0,0,0,0,'',"SAI - Gnomeregan Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,7,1,0,@VICTORY,0,0,1,0,'',"SAI - Gnomeregan Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,8,1,0,63034,0,0,0,0,'',"SAI - Gnomeregan Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,8,9,0,13756,0,0,0,0,'',"SAI - Gnomeregan Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,8,1,0,@VICTORY,0,0,1,0,'',"SAI - Gnomeregan Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,9,1,0,63034,0,0,0,0,'',"SAI - Gnomeregan Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,9,9,0,13665,0,0,0,0,'',"SAI - Gnomeregan Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,9,1,0,@VICTORY,0,0,1,0,'',"SAI - Gnomeregan Valiant show different menu if player doesn't have aura");

-- Darnassus Valiant SAI
SET @VALIANT := 33559;
SET @VICTORY := 64805; -- Spell Bested Darnassus
DELETE FROM `smart_scripts` WHERE `entryorguid`=@VALIANT AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@VALIANT,0,0,0,64,0,100,0,0,0,0,0,98,10466,14384,0,0,0,0,7,0,0,0,0,0,0,0,'Darnassus Valiant - Gossip Hello - Send different gossip (see conditions)'),
(@VALIANT,0,1,2,62,0,100,0,10466,1,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Darnassus Valiant - Gossip select - close gossip'),
(@VALIANT,0,2,3,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Darnassus Valiant - Gossip select - Store target'),
(@VALIANT,0,3,4,61,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Valiant - Gossip - Change Faction'),
(@VALIANT,0,4,5,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,'Darnassus Valiant - Gossip - Attack Invoker vehicle'),
(@VALIANT,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Valiant - Gossip - Say Text'),
(@VALIANT,0,6,0,4,0,100,0,0,0,0,0,11,64221,2,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Valiant - Aggro - Cast defend aura'),
(@VALIANT,0,7,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Darnassus Valiant - In combat - Cast Shield-Breaker'),
(@VALIANT,0,8,0,9,0,100,0,8,25,7000,7000,11,63010,0,0,0,0,0,2,0,0,0,0,0,0,0,'Darnassus Valiant - Distance - Cast Charge'),
(@VALIANT,0,9,0,0,0,100,0,10000,10000,15000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Valiant - In combat - Flee'),
(@VALIANT,0,10,11,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Valiant - HP at 5% - Set faction default'),
(@VALIANT,0,11,12,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Valiant - Defeated - Say text'),
(@VALIANT,0,12,14,61,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Darnassus Valiant - Defeated - Cross cast spell'),
(@VALIANT,0,13,14,6,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Darnassus Valiant - Death - Cross cast spell'), -- this line is hacky, npc shouldn't be killed
(@VALIANT,0,14,0,61,0,100,1,0,0,0,0,86,62724,3,12,1,0,0,12,1,0,0,0,0,0,0,'Darnassus Valiant - Defeated - Cross Cast Mounted Melee Victory'),
(@VALIANT,0,15,18,25,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Valiant - Reset - Set faction default'),
(@VALIANT,0,16,17,5,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Valiant - Kill - Say win text'),
(@VALIANT,0,17,18,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Valiant - Link - Set faction default'),
(@VALIANT,0,18,19,61,0,100,1,0,0,0,0,28,64221,0,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Valiant - Link - Remove defend aura'),
(@VALIANT,0,19,0,61,0,100,1,0,0,0,0,28,62719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Valiant - Link - Remove defend charges');

DELETE FROM `creature_text` WHERE `entry`=@VALIANT;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@VALIANT,0,0,"Let it begin!",12,0,100,0,3,0,'Darnassus Valiant Aggro'),
(@VALIANT,0,1,"On your guard!",12,0,100,0,3,0,'Darnassus Valiant Aggro'),
(@VALIANT,0,2,"Prepare yourself!",12,0,100,0,3,0,'Darnassus Valiant Aggro'),
(@VALIANT,0,3,"Ready yourself!",12,0,100,0,3,0,'Darnassus Valiant Aggro'),
(@VALIANT,1,0,"I have been defeated. Good fight!",12,0,100,0,3,0,'Darnassus Valiant Defeated'),
(@VALIANT,1,1,"It would seem I underestimated your skills. Well done.",12,0,100,0,3,0,'Darnassus Valiant Defeated'),
(@VALIANT,1,2,"That was a well fought battle. I yield to you.",12,0,100,0,3,0,'Darnassus Valiant Defeated'),
(@VALIANT,1,3,"I yield to you.",12,0,100,0,3,0,'Darnassus Valiant Defeated'),
(@VALIANT,2,0,"I am afraid you will need more practice to defeat me.",12,0,100,0,3,0,'Darnassus Valiant Victory'),
(@VALIANT,2,1,"I have won. Better luck another time, friend.",12,0,100,0,3,0,'Darnassus Valiant Victory'),
(@VALIANT,2,2,"It seems you still need more practice. Perhaps another time.",12,0,100,0,3,0,'Darnassus Valiant Victory'),
(@VALIANT,2,3,"Victory is mine!",12,0,100,0,3,0,'Darnassus Valiant Victory');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@VALIANT AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@VALIANT,0,0,1,0,63034,0,0,0,0,'',"SAI - Darnassus Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,0,9,0,13772,0,0,0,0,'',"SAI - Darnassus Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,0,1,0,@VICTORY,0,0,1,0,'',"SAI - Darnassus Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,1,1,0,63034,0,0,0,0,'',"SAI - Darnassus Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,1,9,0,13777,0,0,0,0,'',"SAI - Darnassus Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,1,1,0,@VICTORY,0,0,1,0,'',"SAI - Darnassus Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,2,1,0,63034,0,0,0,0,'',"SAI - Darnassus Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,2,9,0,13782,0,0,0,0,'',"SAI - Darnassus Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,2,1,0,@VICTORY,0,0,1,0,'',"SAI - Darnassus Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,3,1,0,63034,0,0,0,0,'',"SAI - Darnassus Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,3,9,0,13787,0,0,0,0,'',"SAI - Darnassus Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,3,1,0,@VICTORY,0,0,1,0,'',"SAI - Darnassus Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,4,1,0,63034,0,0,0,0,'',"SAI - Darnassus Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,4,9,0,13767,0,0,0,0,'',"SAI - Darnassus Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,4,1,0,@VICTORY,0,0,1,0,'',"SAI - Darnassus Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,5,1,0,63034,0,0,0,0,'',"SAI - Darnassus Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,5,9,0,13761,0,0,0,0,'',"SAI - Darnassus Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,5,1,0,@VICTORY,0,0,1,0,'',"SAI - Darnassus Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,6,1,0,63034,0,0,0,0,'',"SAI - Darnassus Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,6,9,0,13745,0,0,0,0,'',"SAI - Darnassus Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,6,1,0,@VICTORY,0,0,1,0,'',"SAI - Darnassus Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,7,1,0,63034,0,0,0,0,'',"SAI - Darnassus Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,7,9,0,13750,0,0,0,0,'',"SAI - Darnassus Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,7,1,0,@VICTORY,0,0,1,0,'',"SAI - Darnassus Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,8,1,0,63034,0,0,0,0,'',"SAI - Darnassus Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,8,9,0,13756,0,0,0,0,'',"SAI - Darnassus Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,8,1,0,@VICTORY,0,0,1,0,'',"SAI - Darnassus Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,9,1,0,63034,0,0,0,0,'',"SAI - Darnassus Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,9,9,0,13665,0,0,0,0,'',"SAI - Darnassus Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,9,1,0,@VICTORY,0,0,1,0,'',"SAI - Darnassus Valiant show different menu if player doesn't have aura");

-- Exodar Valiant SAI
SET @VALIANT := 33562;
SET @VICTORY := 64808; -- Spell Bested the Exodar
DELETE FROM `smart_scripts` WHERE `entryorguid`=@VALIANT AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@VALIANT,0,0,0,64,0,100,0,0,0,0,0,98,10466,14384,0,0,0,0,7,0,0,0,0,0,0,0,'Exodar Valiant - Gossip Hello - Send different gossip (see conditions)'),
(@VALIANT,0,1,2,62,0,100,0,10466,1,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Exodar Valiant - Gossip select - close gossip'),
(@VALIANT,0,2,3,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Exodar Valiant - Gossip select - Store target'),
(@VALIANT,0,3,4,61,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Valiant - Gossip - Change Faction'),
(@VALIANT,0,4,5,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,'Exodar Valiant - Gossip - Attack Invoker vehicle'),
(@VALIANT,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Valiant - Gossip - Say Text'),
(@VALIANT,0,6,0,4,0,100,0,0,0,0,0,11,64221,2,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Valiant - Aggro - Cast defend aura'),
(@VALIANT,0,7,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Exodar Valiant - In combat - Cast Shield-Breaker'),
(@VALIANT,0,8,0,9,0,100,0,8,25,7000,7000,11,63010,0,0,0,0,0,2,0,0,0,0,0,0,0,'Exodar Valiant - Distance - Cast Charge'),
(@VALIANT,0,9,0,0,0,100,0,10000,10000,15000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Valiant - In combat - Flee'),
(@VALIANT,0,10,11,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Valiant - HP at 5% - Set faction default'),
(@VALIANT,0,11,12,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Valiant - Defeated - Say text'),
(@VALIANT,0,12,14,61,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Exodar Valiant - Defeated - Cross cast spell'),
(@VALIANT,0,13,14,6,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Exodar Valiant - Death - Cross cast spell'), -- this line is hacky, npc shouldn't be killed
(@VALIANT,0,14,0,61,0,100,1,0,0,0,0,86,62724,3,12,1,0,0,12,1,0,0,0,0,0,0,'Exodar Valiant - Defeated - Cross Cast Mounted Melee Victory'),
(@VALIANT,0,15,18,25,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Valiant - Reset - Set faction default'),
(@VALIANT,0,16,17,5,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Valiant - Kill - Say win text'),
(@VALIANT,0,17,18,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Valiant - Link - Set faction default'),
(@VALIANT,0,18,19,61,0,100,1,0,0,0,0,28,64221,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Valiant - Link - Remove defend aura'),
(@VALIANT,0,19,0,61,0,100,1,0,0,0,0,28,62719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Valiant - Link - Remove defend charges');

DELETE FROM `creature_text` WHERE `entry`=@VALIANT;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@VALIANT,0,0,"Let it begin!",12,0,100,0,3,0,'Exodar Valiant Aggro'),
(@VALIANT,0,1,"On your guard!",12,0,100,0,3,0,'Exodar Valiant Aggro'),
(@VALIANT,0,2,"Prepare yourself!",12,0,100,0,3,0,'Exodar Valiant Aggro'),
(@VALIANT,0,3,"Ready yourself!",12,0,100,0,3,0,'Exodar Valiant Aggro'),
(@VALIANT,1,0,"I have been defeated. Good fight!",12,0,100,0,3,0,'Exodar Valiant Defeated'),
(@VALIANT,1,1,"It would seem I underestimated your skills. Well done.",12,0,100,0,3,0,'Exodar Valiant Defeated'),
(@VALIANT,1,2,"That was a well fought battle. I yield to you.",12,0,100,0,3,0,'Exodar Valiant Defeated'),
(@VALIANT,1,3,"I yield to you.",12,0,100,0,3,0,'Exodar Valiant Defeated'),
(@VALIANT,2,0,"I am afraid you will need more practice to defeat me.",12,0,100,0,3,0,'Exodar Valiant Victory'),
(@VALIANT,2,1,"I have won. Better luck another time, friend.",12,0,100,0,3,0,'Exodar Valiant Victory'),
(@VALIANT,2,2,"It seems you still need more practice. Perhaps another time.",12,0,100,0,3,0,'Exodar Valiant Victory'),
(@VALIANT,2,3,"Victory is mine!",12,0,100,0,3,0,'Exodar Valiant Victory');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@VALIANT AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@VALIANT,0,0,1,0,63034,0,0,0,0,'',"SAI - Exodar Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,0,9,0,13772,0,0,0,0,'',"SAI - Exodar Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,0,1,0,@VICTORY,0,0,1,0,'',"SAI - Exodar Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,1,1,0,63034,0,0,0,0,'',"SAI - Exodar Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,1,9,0,13777,0,0,0,0,'',"SAI - Exodar Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,1,1,0,@VICTORY,0,0,1,0,'',"SAI - Exodar Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,2,1,0,63034,0,0,0,0,'',"SAI - Exodar Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,2,9,0,13782,0,0,0,0,'',"SAI - Exodar Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,2,1,0,@VICTORY,0,0,1,0,'',"SAI - Exodar Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,3,1,0,63034,0,0,0,0,'',"SAI - Exodar Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,3,9,0,13787,0,0,0,0,'',"SAI - Exodar Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,3,1,0,@VICTORY,0,0,1,0,'',"SAI - Exodar Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,4,1,0,63034,0,0,0,0,'',"SAI - Exodar Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,4,9,0,13767,0,0,0,0,'',"SAI - Exodar Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,4,1,0,@VICTORY,0,0,1,0,'',"SAI - Exodar Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,5,1,0,63034,0,0,0,0,'',"SAI - Exodar Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,5,9,0,13761,0,0,0,0,'',"SAI - Exodar Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,5,1,0,@VICTORY,0,0,1,0,'',"SAI - Exodar Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,6,1,0,63034,0,0,0,0,'',"SAI - Exodar Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,6,9,0,13745,0,0,0,0,'',"SAI - Exodar Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,6,1,0,@VICTORY,0,0,1,0,'',"SAI - Exodar Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,7,1,0,63034,0,0,0,0,'',"SAI - Exodar Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,7,9,0,13750,0,0,0,0,'',"SAI - Exodar Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,7,1,0,@VICTORY,0,0,1,0,'',"SAI - Exodar Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,8,1,0,63034,0,0,0,0,'',"SAI - Exodar Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,8,9,0,13756,0,0,0,0,'',"SAI - Exodar Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,8,1,0,@VICTORY,0,0,1,0,'',"SAI - Exodar Valiant show different menu if player doesn't have aura"),
(22,1,@VALIANT,0,9,1,0,63034,0,0,0,0,'',"SAI - Exodar Valiant show different menu if player mounted"),
(22,1,@VALIANT,0,9,9,0,13665,0,0,0,0,'',"SAI - Exodar Valiant show different menu if player quest taken"),
(22,1,@VALIANT,0,9,1,0,@VICTORY,0,0,1,0,'',"SAI - Exodar Valiant show different menu if player doesn't have aura");
