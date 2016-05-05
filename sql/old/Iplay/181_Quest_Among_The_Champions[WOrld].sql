-- Quest - Among the Champions
UPDATE `creature_template` SET `gossip_menu_id`=0, `AIName`='SmartAI', `ScriptName`='' WHERE `entry` IN (33745,33749,33739,33738,33747,33743,33740,33746,33748,33744);

-- Sen'jin Champion SAI
SET @CHAMPION := 33745;
SET @VICTORY := 64812; -- Spell Bested Sen'jin
DELETE FROM `smart_scripts` WHERE `entryorguid`=@CHAMPION AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@CHAMPION,0,0,0,64,0,100,0,0,0,0,0,98,10458,14421,0,0,0,0,7,0,0,0,0,0,0,0,'Senjin Champion - Gossip Hello - Send different gossip (see conditions)'),
(@CHAMPION,0,1,2,62,0,100,0,10458,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Senjin Champion - Gossip select - close gossip'),
(@CHAMPION,0,2,3,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Senjin Champion - Gossip select - Store target'),
(@CHAMPION,0,3,4,61,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Champion - Gossip - Change Faction'),
(@CHAMPION,0,4,5,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,'Senjin Champion - Gossip - Attack Invoker vehicle'),
(@CHAMPION,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Champion - Gossip - Say Text'),
(@CHAMPION,0,6,0,4,0,100,0,0,0,0,0,11,64553,2,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Champion - Aggro - Cast defend aura'),
(@CHAMPION,0,7,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Senjin Champion - In combat - Cast Shield-Breaker'),
(@CHAMPION,0,8,0,9,0,100,0,8,25,7000,7000,11,63010,0,0,0,0,0,2,0,0,0,0,0,0,0,'Senjin Champion - Distance - Cast Charge'),
(@CHAMPION,0,9,0,0,0,100,0,10000,10000,15000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Champion - In combat - Flee'),
(@CHAMPION,0,10,11,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Champion - HP at 5% - Set faction default'),
(@CHAMPION,0,11,12,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Champion - Defeated - Say text'),
(@CHAMPION,0,12,14,61,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Senjin Champion - Defeated - Cross cast spell'),
(@CHAMPION,0,13,14,6,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Senjin Champion - Death - Cross cast spell'), -- this line is hacky, npc shouldn't be killed
(@CHAMPION,0,14,0,61,0,100,1,0,0,0,0,86,63596,3,12,1,0,0,12,1,0,0,0,0,0,0,'Senjin Champion - Defeated - Cross Cast Mounted Melee Victory'),
(@CHAMPION,0,15,18,25,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Champion - Reset - Set faction default'),
(@CHAMPION,0,16,17,5,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Champion - Kill - Say win text'),
(@CHAMPION,0,17,18,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Champion - Link - Set faction default'),
(@CHAMPION,0,18,19,61,0,100,1,0,0,0,0,28,64553,0,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Champion - Link - Remove defend aura'),
(@CHAMPION,0,19,0,61,0,100,1,0,0,0,0,28,62719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Senjin Champion - Link - Remove defend charges');

DELETE FROM `creature_text` WHERE `entry`=@CHAMPION;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@CHAMPION,0,0,"Let it begin!",12,0,100,0,3,0,'Senjin Champion Aggro'),
(@CHAMPION,0,1,"On your guard!",12,0,100,0,3,0,'Senjin Champion Aggro'),
(@CHAMPION,0,2,"Prepare yourself!",12,0,100,0,3,0,'Senjin Champion Aggro'),
(@CHAMPION,0,3,"Ready yourself!",12,0,100,0,3,0,'Senjin Champion Aggro'),
(@CHAMPION,1,0,"I have been defeated. Good fight!",12,0,100,0,3,0,'Senjin Champion Defeated'),
(@CHAMPION,1,1,"It would seem I underestimated your skills. Well done.",12,0,100,0,3,0,'Senjin Champion Defeated'),
(@CHAMPION,1,2,"That was a well fought battle. I yield to you.",12,0,100,0,3,0,'Senjin Champion Defeated'),
(@CHAMPION,1,3,"I yield to you.",12,0,100,0,3,0,'Senjin Champion Defeated'),
(@CHAMPION,2,0,"I am afraid you will need more practice to defeat me.",12,0,100,0,3,0,'Senjin Champion Victory'),
(@CHAMPION,2,1,"I have won. Better luck another time, friend.",12,0,100,0,3,0,'Senjin Champion Victory'),
(@CHAMPION,2,2,"It seems you still need more practice. Perhaps another time.",12,0,100,0,3,0,'Senjin Champion Victory'),
(@CHAMPION,2,3,"Victory is mine!",12,0,100,0,3,0,'Senjin Champion Victory');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@CHAMPION AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@CHAMPION,0,0,1,0,63034,0,0,0,0,'',"SAI - Senjin Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,0,9,0,13814,0,0,0,0,'',"SAI - Senjin Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,0,1,0,@VICTORY,0,0,1,0,'',"SAI - Senjin Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,1,1,0,63034,0,0,0,0,'',"SAI - Senjin Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,1,9,0,13811,0,0,0,0,'',"SAI - Senjin Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,1,1,0,@VICTORY,0,0,1,0,'',"SAI - Senjin Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,2,1,0,63034,0,0,0,0,'',"SAI - Senjin Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,2,9,0,13793,0,0,0,0,'',"SAI - Senjin Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,2,1,0,@VICTORY,0,0,1,0,'',"SAI - Senjin Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,3,1,0,63034,0,0,0,0,'',"SAI - Senjin Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,3,9,0,13790,0,0,0,0,'',"SAI - Senjin Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,3,1,0,@VICTORY,0,0,1,0,'',"SAI - Senjin Champion show different menu if player has not aura");

-- Undercity Champion SAI
SET @CHAMPION := 33749;
SET @VICTORY := 64816; -- Spell Bested the Undercity
DELETE FROM `smart_scripts` WHERE `entryorguid`=@CHAMPION AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@CHAMPION,0,0,0,64,0,100,0,0,0,0,0,98,10458,14421,0,0,0,0,7,0,0,0,0,0,0,0,'Undercity Champion - Gossip Hello - Send different gossip (see conditions)'),
(@CHAMPION,0,1,2,62,0,100,0,10458,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Undercity Champion - Gossip select - close gossip'),
(@CHAMPION,0,2,3,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Undercity Champion - Gossip select - Store target'),
(@CHAMPION,0,3,4,61,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Champion - Gossip - Change Faction'),
(@CHAMPION,0,4,5,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,'Undercity Champion - Gossip - Attack Invoker vehicle'),
(@CHAMPION,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Champion - Gossip - Say Text'),
(@CHAMPION,0,6,0,4,0,100,0,0,0,0,0,11,64553,2,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Champion - Aggro - Cast defend aura'),
(@CHAMPION,0,7,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Undercity Champion - In combat - Cast Shield-Breaker'),
(@CHAMPION,0,8,0,9,0,100,0,8,25,7000,7000,11,63010,0,0,0,0,0,2,0,0,0,0,0,0,0,'Undercity Champion - Distance - Cast Charge'),
(@CHAMPION,0,9,0,0,0,100,0,10000,10000,15000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Champion - In combat - Flee'),
(@CHAMPION,0,10,11,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Champion - HP at 5% - Set faction default'),
(@CHAMPION,0,11,12,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Champion - Defeated - Say text'),
(@CHAMPION,0,12,14,61,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Undercity Champion - Defeated - Cross cast spell'),
(@CHAMPION,0,13,14,6,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Undercity Champion - Death - Cross cast spell'), -- this line is hacky, npc shouldn't be killed
(@CHAMPION,0,14,0,61,0,100,1,0,0,0,0,86,63596,3,12,1,0,0,12,1,0,0,0,0,0,0,'Undercity Champion - Defeated - Cross Cast Mounted Melee Victory'),
(@CHAMPION,0,15,18,25,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Champion - Reset - Set faction default'),
(@CHAMPION,0,16,17,5,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Champion - Kill - Say win text'),
(@CHAMPION,0,17,18,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Champion - Link - Set faction default'),
(@CHAMPION,0,18,19,61,0,100,1,0,0,0,0,28,64553,0,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Champion - Link - Remove defend aura'),
(@CHAMPION,0,19,0,61,0,100,1,0,0,0,0,28,62719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Undercity Champion - Link - Remove defend charges');

DELETE FROM `creature_text` WHERE `entry`=@CHAMPION;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@CHAMPION,0,0,"Let it begin!",12,0,100,0,3,0,'Undercity Champion Aggro'),
(@CHAMPION,0,1,"On your guard!",12,0,100,0,3,0,'Undercity Champion Aggro'),
(@CHAMPION,0,2,"Prepare yourself!",12,0,100,0,3,0,'Undercity Champion Aggro'),
(@CHAMPION,0,3,"Ready yourself!",12,0,100,0,3,0,'Undercity Champion Aggro'),
(@CHAMPION,1,0,"I have been defeated. Good fight!",12,0,100,0,3,0,'Undercity Champion Defeated'),
(@CHAMPION,1,1,"It would seem I underestimated your skills. Well done.",12,0,100,0,3,0,'Undercity Champion Defeated'),
(@CHAMPION,1,2,"That was a well fought battle. I yield to you.",12,0,100,0,3,0,'Undercity Champion Defeated'),
(@CHAMPION,1,3,"I yield to you.",12,0,100,0,3,0,'Undercity Champion Defeated'),
(@CHAMPION,2,0,"I am afraid you will need more practice to defeat me.",12,0,100,0,3,0,'Undercity Champion Victory'),
(@CHAMPION,2,1,"I have won. Better luck another time, friend.",12,0,100,0,3,0,'Undercity Champion Victory'),
(@CHAMPION,2,2,"It seems you still need more practice. Perhaps another time.",12,0,100,0,3,0,'Undercity Champion Victory'),
(@CHAMPION,2,3,"Victory is mine!",12,0,100,0,3,0,'Undercity Champion Victory');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@CHAMPION AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@CHAMPION,0,0,1,0,63034,0,0,0,0,'',"SAI - Undercity Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,0,9,0,13814,0,0,0,0,'',"SAI - Undercity Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,0,1,0,@VICTORY,0,0,1,0,'',"SAI - Undercity Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,1,1,0,63034,0,0,0,0,'',"SAI - Undercity Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,1,9,0,13811,0,0,0,0,'',"SAI - Undercity Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,1,1,0,@VICTORY,0,0,1,0,'',"SAI - Undercity Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,2,1,0,63034,0,0,0,0,'',"SAI - Undercity Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,2,9,0,13793,0,0,0,0,'',"SAI - Undercity Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,2,1,0,@VICTORY,0,0,1,0,'',"SAI - Undercity Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,3,1,0,63034,0,0,0,0,'',"SAI - Undercity Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,3,9,0,13790,0,0,0,0,'',"SAI - Undercity Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,3,1,0,@VICTORY,0,0,1,0,'',"SAI - Undercity Champion show different menu if player has not aura");

-- Exodar Champion SAI
SET @CHAMPION := 33739;
SET @VICTORY := 64808; -- Spell Bested the Exodar
DELETE FROM `smart_scripts` WHERE `entryorguid`=@CHAMPION AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@CHAMPION,0,0,0,64,0,100,0,0,0,0,0,98,10458,14421,0,0,0,0,7,0,0,0,0,0,0,0,'Exodar Champion - Gossip Hello - Send different gossip (see conditions)'),
(@CHAMPION,0,1,2,62,0,100,0,10458,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Exodar Champion - Gossip select - close gossip'),
(@CHAMPION,0,2,3,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Exodar Champion - Gossip select - Store target'),
(@CHAMPION,0,3,4,61,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Champion - Gossip - Change Faction'),
(@CHAMPION,0,4,5,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,'Exodar Champion - Gossip - Attack Invoker vehicle'),
(@CHAMPION,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Champion - Gossip - Say Text'),
(@CHAMPION,0,6,0,4,0,100,0,0,0,0,0,11,64553,2,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Champion - Aggro - Cast defend aura'),
(@CHAMPION,0,7,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Exodar Champion - In combat - Cast Shield-Breaker'),
(@CHAMPION,0,8,0,9,0,100,0,8,25,7000,7000,11,63010,0,0,0,0,0,2,0,0,0,0,0,0,0,'Exodar Champion - Distance - Cast Charge'),
(@CHAMPION,0,9,0,0,0,100,0,10000,10000,15000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Champion - In combat - Flee'),
(@CHAMPION,0,10,11,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Champion - HP at 5% - Set faction default'),
(@CHAMPION,0,11,12,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Champion - Defeated - Say text'),
(@CHAMPION,0,12,14,61,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Exodar Champion - Defeated - Cross cast spell'),
(@CHAMPION,0,13,14,6,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Exodar Champion - Death - Cross cast spell'), -- this line is hacky, npc shouldn't be killed
(@CHAMPION,0,14,0,61,0,100,1,0,0,0,0,86,63596,3,12,1,0,0,12,1,0,0,0,0,0,0,'Exodar Champion - Defeated - Cross Cast Mounted Melee Victory'),
(@CHAMPION,0,15,18,25,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Champion - Reset - Set faction default'),
(@CHAMPION,0,16,17,5,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Champion - Kill - Say win text'),
(@CHAMPION,0,17,18,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Champion - Link - Set faction default'),
(@CHAMPION,0,18,19,61,0,100,1,0,0,0,0,28,64553,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Champion - Link - Remove defend aura'),
(@CHAMPION,0,19,0,61,0,100,1,0,0,0,0,28,62719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exodar Champion - Link - Remove defend charges');

DELETE FROM `creature_text` WHERE `entry`=@CHAMPION;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@CHAMPION,0,0,"Let it begin!",12,0,100,0,3,0,'Exodar Champion Aggro'),
(@CHAMPION,0,1,"On your guard!",12,0,100,0,3,0,'Exodar Champion Aggro'),
(@CHAMPION,0,2,"Prepare yourself!",12,0,100,0,3,0,'Exodar Champion Aggro'),
(@CHAMPION,0,3,"Ready yourself!",12,0,100,0,3,0,'Exodar Champion Aggro'),
(@CHAMPION,1,0,"I have been defeated. Good fight!",12,0,100,0,3,0,'Exodar Champion Defeated'),
(@CHAMPION,1,1,"It would seem I underestimated your skills. Well done.",12,0,100,0,3,0,'Exodar Champion Defeated'),
(@CHAMPION,1,2,"That was a well fought battle. I yield to you.",12,0,100,0,3,0,'Exodar Champion Defeated'),
(@CHAMPION,1,3,"I yield to you.",12,0,100,0,3,0,'Exodar Champion Defeated'),
(@CHAMPION,2,0,"I am afraid you will need more practice to defeat me.",12,0,100,0,3,0,'Exodar Champion Victory'),
(@CHAMPION,2,1,"I have won. Better luck another time, friend.",12,0,100,0,3,0,'Exodar Champion Victory'),
(@CHAMPION,2,2,"It seems you still need more practice. Perhaps another time.",12,0,100,0,3,0,'Exodar Champion Victory'),
(@CHAMPION,2,3,"Victory is mine!",12,0,100,0,3,0,'Exodar Champion Victory');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@CHAMPION AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@CHAMPION,0,0,1,0,63034,0,0,0,0,'',"SAI - Exodar Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,0,9,0,13814,0,0,0,0,'',"SAI - Exodar Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,0,1,0,@VICTORY,0,0,1,0,'',"SAI - Exodar Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,1,1,0,63034,0,0,0,0,'',"SAI - Exodar Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,1,9,0,13811,0,0,0,0,'',"SAI - Exodar Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,1,1,0,@VICTORY,0,0,1,0,'',"SAI - Exodar Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,2,1,0,63034,0,0,0,0,'',"SAI - Exodar Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,2,9,0,13793,0,0,0,0,'',"SAI - Exodar Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,2,1,0,@VICTORY,0,0,1,0,'',"SAI - Exodar Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,3,1,0,63034,0,0,0,0,'',"SAI - Exodar Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,3,9,0,13790,0,0,0,0,'',"SAI - Exodar Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,3,1,0,@VICTORY,0,0,1,0,'',"SAI - Exodar Champion show different menu if player has not aura");

-- Darnassus Champion SAI
SET @CHAMPION := 33738;
SET @VICTORY := 64805; -- Spell Bested Darnassus
DELETE FROM `smart_scripts` WHERE `entryorguid`=@CHAMPION AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@CHAMPION,0,0,0,64,0,100,0,0,0,0,0,98,10458,14421,0,0,0,0,7,0,0,0,0,0,0,0,'Darnassus Champion - Gossip Hello - Send different gossip (see conditions)'),
(@CHAMPION,0,1,2,62,0,100,0,10458,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Darnassus Champion - Gossip select - close gossip'),
(@CHAMPION,0,2,3,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Darnassus Champion - Gossip select - Store target'),
(@CHAMPION,0,3,4,61,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Champion - Gossip - Change Faction'),
(@CHAMPION,0,4,5,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,'Darnassus Champion - Gossip - Attack Invoker vehicle'),
(@CHAMPION,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Champion - Gossip - Say Text'),
(@CHAMPION,0,6,0,4,0,100,0,0,0,0,0,11,64553,2,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Champion - Aggro - Cast defend aura'),
(@CHAMPION,0,7,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Darnassus Champion - In combat - Cast Shield-Breaker'),
(@CHAMPION,0,8,0,9,0,100,0,8,25,7000,7000,11,63010,0,0,0,0,0,2,0,0,0,0,0,0,0,'Darnassus Champion - Distance - Cast Charge'),
(@CHAMPION,0,9,0,0,0,100,0,10000,10000,15000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Champion - In combat - Flee'),
(@CHAMPION,0,10,11,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Champion - HP at 5% - Set faction default'),
(@CHAMPION,0,11,12,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Champion - Defeated - Say text'),
(@CHAMPION,0,12,14,61,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Darnassus Champion - Defeated - Cross cast spell'),
(@CHAMPION,0,13,14,6,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Darnassus Champion - Death - Cross cast spell'), -- this line is hacky, npc shouldn't be killed
(@CHAMPION,0,14,0,61,0,100,1,0,0,0,0,86,63596,3,12,1,0,0,12,1,0,0,0,0,0,0,'Darnassus Champion - Defeated - Cross Cast Mounted Melee Victory'),
(@CHAMPION,0,15,18,25,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Champion - Reset - Set faction default'),
(@CHAMPION,0,16,17,5,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Champion - Kill - Say win text'),
(@CHAMPION,0,17,18,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Champion - Link - Set faction default'),
(@CHAMPION,0,18,19,61,0,100,1,0,0,0,0,28,64553,0,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Champion - Link - Remove defend aura'),
(@CHAMPION,0,19,0,61,0,100,1,0,0,0,0,28,62719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Darnassus Champion - Link - Remove defend charges');

DELETE FROM `creature_text` WHERE `entry`=@CHAMPION;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@CHAMPION,0,0,"Let it begin!",12,0,100,0,3,0,'Darnassus Champion Aggro'),
(@CHAMPION,0,1,"On your guard!",12,0,100,0,3,0,'Darnassus Champion Aggro'),
(@CHAMPION,0,2,"Prepare yourself!",12,0,100,0,3,0,'Darnassus Champion Aggro'),
(@CHAMPION,0,3,"Ready yourself!",12,0,100,0,3,0,'Darnassus Champion Aggro'),
(@CHAMPION,1,0,"I have been defeated. Good fight!",12,0,100,0,3,0,'Darnassus Champion Defeated'),
(@CHAMPION,1,1,"It would seem I underestimated your skills. Well done.",12,0,100,0,3,0,'Darnassus Champion Defeated'),
(@CHAMPION,1,2,"That was a well fought battle. I yield to you.",12,0,100,0,3,0,'Darnassus Champion Defeated'),
(@CHAMPION,1,3,"I yield to you.",12,0,100,0,3,0,'Darnassus Champion Defeated'),
(@CHAMPION,2,0,"I am afraid you will need more practice to defeat me.",12,0,100,0,3,0,'Darnassus Champion Victory'),
(@CHAMPION,2,1,"I have won. Better luck another time, friend.",12,0,100,0,3,0,'Darnassus Champion Victory'),
(@CHAMPION,2,2,"It seems you still need more practice. Perhaps another time.",12,0,100,0,3,0,'Darnassus Champion Victory'),
(@CHAMPION,2,3,"Victory is mine!",12,0,100,0,3,0,'Darnassus Champion Victory');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@CHAMPION AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@CHAMPION,0,0,1,0,63034,0,0,0,0,'',"SAI - Darnassus Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,0,9,0,13814,0,0,0,0,'',"SAI - Darnassus Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,0,1,0,@VICTORY,0,0,1,0,'',"SAI - Darnassus Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,1,1,0,63034,0,0,0,0,'',"SAI - Darnassus Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,1,9,0,13811,0,0,0,0,'',"SAI - Darnassus Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,1,1,0,@VICTORY,0,0,1,0,'',"SAI - Darnassus Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,2,1,0,63034,0,0,0,0,'',"SAI - Darnassus Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,2,9,0,13793,0,0,0,0,'',"SAI - Darnassus Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,2,1,0,@VICTORY,0,0,1,0,'',"SAI - Darnassus Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,3,1,0,63034,0,0,0,0,'',"SAI - Darnassus Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,3,9,0,13790,0,0,0,0,'',"SAI - Darnassus Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,3,1,0,@VICTORY,0,0,1,0,'',"SAI - Darnassus Champion show different menu if player has not aura");

-- Stormwind Champion SAI
SET @CHAMPION := 33747;
SET @VICTORY := 64814; -- Spell Bested Stormwind
DELETE FROM `smart_scripts` WHERE `entryorguid`=@CHAMPION AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@CHAMPION,0,0,0,64,0,100,0,0,0,0,0,98,10458,14421,0,0,0,0,7,0,0,0,0,0,0,0,'Stormwind Champion - Gossip Hello - Send different gossip (see conditions)'),
(@CHAMPION,0,1,2,62,0,100,0,10458,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Stormwind Champion - Gossip select - close gossip'),
(@CHAMPION,0,2,3,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Stormwind Champion - Gossip select - Store target'),
(@CHAMPION,0,3,4,61,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Champion - Gossip - Change Faction'),
(@CHAMPION,0,4,5,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,'Stormwind Champion - Gossip - Attack Invoker vehicle'),
(@CHAMPION,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Champion - Gossip - Say Text'),
(@CHAMPION,0,6,0,4,0,100,0,0,0,0,0,11,64553,2,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Champion - Aggro - Cast defend aura'),
(@CHAMPION,0,7,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Stormwind Champion - In combat - Cast Shield-Breaker'),
(@CHAMPION,0,8,0,9,0,100,0,8,25,7000,7000,11,63010,0,0,0,0,0,2,0,0,0,0,0,0,0,'Stormwind Champion - Distance - Cast Charge'),
(@CHAMPION,0,9,0,0,0,100,0,10000,10000,15000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Champion - In combat - Flee'),
(@CHAMPION,0,10,11,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Champion - HP at 5% - Set faction default'),
(@CHAMPION,0,11,12,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Champion - Defeated - Say text'),
(@CHAMPION,0,12,14,61,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Stormwind Champion - Defeated - Cross cast spell'),
(@CHAMPION,0,13,14,6,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Stormwind Champion - Death - Cross cast spell'), -- this line is hacky, npc shouldn't be killed
(@CHAMPION,0,14,0,61,0,100,1,0,0,0,0,86,63596,3,12,1,0,0,12,1,0,0,0,0,0,0,'Stormwind Champion - Defeated - Cross Cast Mounted Melee Victory'),
(@CHAMPION,0,15,18,25,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Champion - Reset - Set faction default'),
(@CHAMPION,0,16,17,5,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Champion - Kill - Say win text'),
(@CHAMPION,0,17,18,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Champion - Link - Set faction default'),
(@CHAMPION,0,18,19,61,0,100,1,0,0,0,0,28,64553,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Champion - Link - Remove defend aura'),
(@CHAMPION,0,19,0,61,0,100,1,0,0,0,0,28,62719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormwind Champion - Link - Remove defend charges');

DELETE FROM `creature_text` WHERE `entry`=@CHAMPION;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@CHAMPION,0,0,"Let it begin!",12,0,100,0,3,0,'Stormwind Champion Aggro'),
(@CHAMPION,0,1,"On your guard!",12,0,100,0,3,0,'Stormwind Champion Aggro'),
(@CHAMPION,0,2,"Prepare yourself!",12,0,100,0,3,0,'Stormwind Champion Aggro'),
(@CHAMPION,0,3,"Ready yourself!",12,0,100,0,3,0,'Stormwind Champion Aggro'),
(@CHAMPION,1,0,"I have been defeated. Good fight!",12,0,100,0,3,0,'Stormwind Champion Defeated'),
(@CHAMPION,1,1,"It would seem I underestimated your skills. Well done.",12,0,100,0,3,0,'Stormwind Champion Defeated'),
(@CHAMPION,1,2,"That was a well fought battle. I yield to you.",12,0,100,0,3,0,'Stormwind Champion Defeated'),
(@CHAMPION,1,3,"I yield to you.",12,0,100,0,3,0,'Stormwind Champion Defeated'),
(@CHAMPION,2,0,"I am afraid you will need more practice to defeat me.",12,0,100,0,3,0,'Stormwind Champion Victory'),
(@CHAMPION,2,1,"I have won. Better luck another time, friend.",12,0,100,0,3,0,'Stormwind Champion Victory'),
(@CHAMPION,2,2,"It seems you still need more practice. Perhaps another time.",12,0,100,0,3,0,'Stormwind Champion Victory'),
(@CHAMPION,2,3,"Victory is mine!",12,0,100,0,3,0,'Stormwind Champion Victory');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@CHAMPION AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@CHAMPION,0,0,1,0,63034,0,0,0,0,'',"SAI - Stormwind Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,0,9,0,13814,0,0,0,0,'',"SAI - Stormwind Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,0,1,0,@VICTORY,0,0,1,0,'',"SAI - Stormwind Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,1,1,0,63034,0,0,0,0,'',"SAI - Stormwind Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,1,9,0,13811,0,0,0,0,'',"SAI - Stormwind Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,1,1,0,@VICTORY,0,0,1,0,'',"SAI - Stormwind Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,2,1,0,63034,0,0,0,0,'',"SAI - Stormwind Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,2,9,0,13793,0,0,0,0,'',"SAI - Stormwind Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,2,1,0,@VICTORY,0,0,1,0,'',"SAI - Stormwind Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,3,1,0,63034,0,0,0,0,'',"SAI - Stormwind Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,3,9,0,13790,0,0,0,0,'',"SAI - Stormwind Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,3,1,0,@VICTORY,0,0,1,0,'',"SAI - Stormwind Champion show different menu if player has not aura");

-- Ironforge Champion SAI
SET @CHAMPION := 33743;
SET @VICTORY := 64810; -- Spell Bested Ironforge
DELETE FROM `smart_scripts` WHERE `entryorguid`=@CHAMPION AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@CHAMPION,0,0,0,64,0,100,0,0,0,0,0,98,10458,14421,0,0,0,0,7,0,0,0,0,0,0,0,'Ironforge Champion - Gossip Hello - Send different gossip (see conditions)'),
(@CHAMPION,0,1,2,62,0,100,0,10458,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Ironforge Champion - Gossip select - close gossip'),
(@CHAMPION,0,2,3,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Ironforge Champion - Gossip select - Store target'),
(@CHAMPION,0,3,4,61,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Champion - Gossip - Change Faction'),
(@CHAMPION,0,4,5,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,'Ironforge Champion - Gossip - Attack Invoker vehicle'),
(@CHAMPION,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Champion - Gossip - Say Text'),
(@CHAMPION,0,6,0,4,0,100,0,0,0,0,0,11,64553,2,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Champion - Aggro - Cast defend aura'),
(@CHAMPION,0,7,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Ironforge Champion - In combat - Cast Shield-Breaker'),
(@CHAMPION,0,8,0,9,0,100,0,8,25,7000,7000,11,63010,0,0,0,0,0,2,0,0,0,0,0,0,0,'Ironforge Champion - Distance - Cast Charge'),
(@CHAMPION,0,9,0,0,0,100,0,10000,10000,15000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Champion - In combat - Flee'),
(@CHAMPION,0,10,11,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Champion - HP at 5% - Set faction default'),
(@CHAMPION,0,11,12,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Champion - Defeated - Say text'),
(@CHAMPION,0,12,14,61,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Ironforge Champion - Defeated - Cross cast spell'),
(@CHAMPION,0,13,14,6,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Ironforge Champion - Death - Cross cast spell'), -- this line is hacky, npc shouldn't be killed
(@CHAMPION,0,14,0,61,0,100,1,0,0,0,0,86,63596,3,12,1,0,0,12,1,0,0,0,0,0,0,'Ironforge Champion - Defeated - Cross Cast Mounted Melee Victory'),
(@CHAMPION,0,15,18,25,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Champion - Reset - Set faction default'),
(@CHAMPION,0,16,17,5,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Champion - Kill - Say win text'),
(@CHAMPION,0,17,18,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Champion - Link - Set faction default'),
(@CHAMPION,0,18,19,61,0,100,1,0,0,0,0,28,64553,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Champion - Link - Remove defend aura'),
(@CHAMPION,0,19,0,61,0,100,1,0,0,0,0,28,62719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ironforge Champion - Link - Remove defend charges');

DELETE FROM `creature_text` WHERE `entry`=@CHAMPION;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@CHAMPION,0,0,"Let it begin!",12,0,100,0,3,0,'Ironforge Champion Aggro'),
(@CHAMPION,0,1,"On your guard!",12,0,100,0,3,0,'Ironforge Champion Aggro'),
(@CHAMPION,0,2,"Prepare yourself!",12,0,100,0,3,0,'Ironforge Champion Aggro'),
(@CHAMPION,0,3,"Ready yourself!",12,0,100,0,3,0,'Ironforge Champion Aggro'),
(@CHAMPION,1,0,"I have been defeated. Good fight!",12,0,100,0,3,0,'Ironforge Champion Defeated'),
(@CHAMPION,1,1,"It would seem I underestimated your skills. Well done.",12,0,100,0,3,0,'Ironforge Champion Defeated'),
(@CHAMPION,1,2,"That was a well fought battle. I yield to you.",12,0,100,0,3,0,'Ironforge Champion Defeated'),
(@CHAMPION,1,3,"I yield to you.",12,0,100,0,3,0,'Ironforge Champion Defeated'),
(@CHAMPION,2,0,"I am afraid you will need more practice to defeat me.",12,0,100,0,3,0,'Ironforge Champion Victory'),
(@CHAMPION,2,1,"I have won. Better luck another time, friend.",12,0,100,0,3,0,'Ironforge Champion Victory'),
(@CHAMPION,2,2,"It seems you still need more practice. Perhaps another time.",12,0,100,0,3,0,'Ironforge Champion Victory'),
(@CHAMPION,2,3,"Victory is mine!",12,0,100,0,3,0,'Ironforge Champion Victory');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@CHAMPION AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@CHAMPION,0,0,1,0,63034,0,0,0,0,'',"SAI - Ironforge Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,0,9,0,13814,0,0,0,0,'',"SAI - Ironforge Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,0,1,0,@VICTORY,0,0,1,0,'',"SAI - Ironforge Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,1,1,0,63034,0,0,0,0,'',"SAI - Ironforge Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,1,9,0,13811,0,0,0,0,'',"SAI - Ironforge Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,1,1,0,@VICTORY,0,0,1,0,'',"SAI - Ironforge Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,2,1,0,63034,0,0,0,0,'',"SAI - Ironforge Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,2,9,0,13793,0,0,0,0,'',"SAI - Ironforge Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,2,1,0,@VICTORY,0,0,1,0,'',"SAI - Ironforge Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,3,1,0,63034,0,0,0,0,'',"SAI - Ironforge Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,3,9,0,13790,0,0,0,0,'',"SAI - Ironforge Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,3,1,0,@VICTORY,0,0,1,0,'',"SAI - Ironforge Champion show different menu if player has not aura");

-- Gnomeregan Champion SAI
SET @CHAMPION := 33740;
SET @VICTORY := 64809; -- Spell Bested Gnomeregan
DELETE FROM `smart_scripts` WHERE `entryorguid`=@CHAMPION AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@CHAMPION,0,0,0,64,0,100,0,0,0,0,0,98,10458,14421,0,0,0,0,7,0,0,0,0,0,0,0,'Gnomeregan Champion - Gossip Hello - Send different gossip (see conditions)'),
(@CHAMPION,0,1,2,62,0,100,0,10458,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Gnomeregan Champion - Gossip select - close gossip'),
(@CHAMPION,0,2,3,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Gnomeregan Champion - Gossip select - Store target'),
(@CHAMPION,0,3,4,61,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Champion - Gossip - Change Faction'),
(@CHAMPION,0,4,5,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,'Gnomeregan Champion - Gossip - Attack Invoker vehicle'),
(@CHAMPION,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Champion - Gossip - Say Text'),
(@CHAMPION,0,6,0,4,0,100,0,0,0,0,0,11,64553,2,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Champion - Aggro - Cast defend aura'),
(@CHAMPION,0,7,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Gnomeregan Champion - In combat - Cast Shield-Breaker'),
(@CHAMPION,0,8,0,9,0,100,0,8,25,7000,7000,11,63010,0,0,0,0,0,2,0,0,0,0,0,0,0,'Gnomeregan Champion - Distance - Cast Charge'),
(@CHAMPION,0,9,0,0,0,100,0,10000,10000,15000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Champion - In combat - Flee'),
(@CHAMPION,0,10,11,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Champion - HP at 5% - Set faction default'),
(@CHAMPION,0,11,12,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Champion - Defeated - Say text'),
(@CHAMPION,0,12,14,61,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Gnomeregan Champion - Defeated - Cross cast spell'),
(@CHAMPION,0,13,14,6,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Gnomeregan Champion - Death - Cross cast spell'), -- this line is hacky, npc shouldn't be killed
(@CHAMPION,0,14,0,61,0,100,1,0,0,0,0,86,63596,3,12,1,0,0,12,1,0,0,0,0,0,0,'Gnomeregan Champion - Defeated - Cross Cast Mounted Melee Victory'),
(@CHAMPION,0,15,18,25,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Champion - Reset - Set faction default'),
(@CHAMPION,0,16,17,5,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Champion - Kill - Say win text'),
(@CHAMPION,0,17,18,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Champion - Link - Set faction default'),
(@CHAMPION,0,18,19,61,0,100,1,0,0,0,0,28,64553,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Champion - Link - Remove defend aura'),
(@CHAMPION,0,19,0,61,0,100,1,0,0,0,0,28,62719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gnomeregan Champion - Link - Remove defend charges');

DELETE FROM `creature_text` WHERE `entry`=@CHAMPION;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@CHAMPION,0,0,"Let it begin!",12,0,100,0,3,0,'Gnomeregan Champion Aggro'),
(@CHAMPION,0,1,"On your guard!",12,0,100,0,3,0,'Gnomeregan Champion Aggro'),
(@CHAMPION,0,2,"Prepare yourself!",12,0,100,0,3,0,'Gnomeregan Champion Aggro'),
(@CHAMPION,0,3,"Ready yourself!",12,0,100,0,3,0,'Gnomeregan Champion Aggro'),
(@CHAMPION,1,0,"I have been defeated. Good fight!",12,0,100,0,3,0,'Gnomeregan Champion Defeated'),
(@CHAMPION,1,1,"It would seem I underestimated your skills. Well done.",12,0,100,0,3,0,'Gnomeregan Champion Defeated'),
(@CHAMPION,1,2,"That was a well fought battle. I yield to you.",12,0,100,0,3,0,'Gnomeregan Champion Defeated'),
(@CHAMPION,1,3,"I yield to you.",12,0,100,0,3,0,'Gnomeregan Champion Defeated'),
(@CHAMPION,2,0,"I am afraid you will need more practice to defeat me.",12,0,100,0,3,0,'Gnomeregan Champion Victory'),
(@CHAMPION,2,1,"I have won. Better luck another time, friend.",12,0,100,0,3,0,'Gnomeregan Champion Victory'),
(@CHAMPION,2,2,"It seems you still need more practice. Perhaps another time.",12,0,100,0,3,0,'Gnomeregan Champion Victory'),
(@CHAMPION,2,3,"Victory is mine!",12,0,100,0,3,0,'Gnomeregan Champion Victory');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@CHAMPION AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@CHAMPION,0,0,1,0,63034,0,0,0,0,'',"SAI - Gnomeregan Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,0,9,0,13814,0,0,0,0,'',"SAI - Gnomeregan Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,0,1,0,@VICTORY,0,0,1,0,'',"SAI - Gnomeregan Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,1,1,0,63034,0,0,0,0,'',"SAI - Gnomeregan Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,1,9,0,13811,0,0,0,0,'',"SAI - Gnomeregan Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,1,1,0,@VICTORY,0,0,1,0,'',"SAI - Gnomeregan Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,2,1,0,63034,0,0,0,0,'',"SAI - Gnomeregan Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,2,9,0,13793,0,0,0,0,'',"SAI - Gnomeregan Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,2,1,0,@VICTORY,0,0,1,0,'',"SAI - Gnomeregan Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,3,1,0,63034,0,0,0,0,'',"SAI - Gnomeregan Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,3,9,0,13790,0,0,0,0,'',"SAI - Gnomeregan Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,3,1,0,@VICTORY,0,0,1,0,'',"SAI - Gnomeregan Champion show different menu if player has not aura");

-- Silvermoon Champion SAI
SET @CHAMPION := 33746;
SET @VICTORY := 64813; -- Spell Bested Silvermoon City
DELETE FROM `smart_scripts` WHERE `entryorguid`=@CHAMPION AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@CHAMPION,0,0,0,64,0,100,0,0,0,0,0,98,10458,14421,0,0,0,0,7,0,0,0,0,0,0,0,'Silvermoon Champion - Gossip Hello - Send different gossip (see conditions)'),
(@CHAMPION,0,1,2,62,0,100,0,10458,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Silvermoon Champion - Gossip select - close gossip'),
(@CHAMPION,0,2,3,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Silvermoon Champion - Gossip select - Store target'),
(@CHAMPION,0,3,4,61,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Champion - Gossip - Change Faction'),
(@CHAMPION,0,4,5,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,'Silvermoon Champion - Gossip - Attack Invoker vehicle'),
(@CHAMPION,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Champion - Gossip - Say Text'),
(@CHAMPION,0,6,0,4,0,100,0,0,0,0,0,11,64553,2,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Champion - Aggro - Cast defend aura'),
(@CHAMPION,0,7,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Silvermoon Champion - In combat - Cast Shield-Breaker'),
(@CHAMPION,0,8,0,9,0,100,0,8,25,7000,7000,11,63010,0,0,0,0,0,2,0,0,0,0,0,0,0,'Silvermoon Champion - Distance - Cast Charge'),
(@CHAMPION,0,9,0,0,0,100,0,10000,10000,15000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Champion - In combat - Flee'),
(@CHAMPION,0,10,11,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Champion - HP at 5% - Set faction default'),
(@CHAMPION,0,11,12,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Champion - Defeated - Say text'),
(@CHAMPION,0,12,14,61,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Silvermoon Champion - Defeated - Cross cast spell'),
(@CHAMPION,0,13,14,6,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Silvermoon Champion - Death - Cross cast spell'), -- this line is hacky, npc shouldn't be killed
(@CHAMPION,0,14,0,61,0,100,1,0,0,0,0,86,63596,3,12,1,0,0,12,1,0,0,0,0,0,0,'Silvermoon Champion - Defeated - Cross Cast Mounted Melee Victory'),
(@CHAMPION,0,15,18,25,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Champion - Reset - Set faction default'),
(@CHAMPION,0,16,17,5,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Champion - Kill - Say win text'),
(@CHAMPION,0,17,18,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Champion - Link - Set faction default'),
(@CHAMPION,0,18,19,61,0,100,1,0,0,0,0,28,64553,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Champion - Link - Remove defend aura'),
(@CHAMPION,0,19,0,61,0,100,1,0,0,0,0,28,62719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Champion - Link - Remove defend charges');

DELETE FROM `creature_text` WHERE `entry`=@CHAMPION;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@CHAMPION,0,0,"Let it begin!",12,0,100,0,3,0,'Silvermoon Champion Aggro'),
(@CHAMPION,0,1,"On your guard!",12,0,100,0,3,0,'Silvermoon Champion Aggro'),
(@CHAMPION,0,2,"Prepare yourself!",12,0,100,0,3,0,'Silvermoon Champion Aggro'),
(@CHAMPION,0,3,"Ready yourself!",12,0,100,0,3,0,'Silvermoon Champion Aggro'),
(@CHAMPION,1,0,"I have been defeated. Good fight!",12,0,100,0,3,0,'Silvermoon Champion Defeated'),
(@CHAMPION,1,1,"It would seem I underestimated your skills. Well done.",12,0,100,0,3,0,'Silvermoon Champion Defeated'),
(@CHAMPION,1,2,"That was a well fought battle. I yield to you.",12,0,100,0,3,0,'Silvermoon Champion Defeated'),
(@CHAMPION,1,3,"I yield to you.",12,0,100,0,3,0,'Silvermoon Champion Defeated'),
(@CHAMPION,2,0,"I am afraid you will need more practice to defeat me.",12,0,100,0,3,0,'Silvermoon Champion Victory'),
(@CHAMPION,2,1,"I have won. Better luck another time, friend.",12,0,100,0,3,0,'Silvermoon Champion Victory'),
(@CHAMPION,2,2,"It seems you still need more practice. Perhaps another time.",12,0,100,0,3,0,'Silvermoon Champion Victory'),
(@CHAMPION,2,3,"Victory is mine!",12,0,100,0,3,0,'Silvermoon Champion Victory');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@CHAMPION AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@CHAMPION,0,0,1,0,63034,0,0,0,0,'',"SAI - Silvermoon Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,0,9,0,13814,0,0,0,0,'',"SAI - Silvermoon Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,0,1,0,@VICTORY,0,0,1,0,'',"SAI - Silvermoon Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,1,1,0,63034,0,0,0,0,'',"SAI - Silvermoon Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,1,9,0,13811,0,0,0,0,'',"SAI - Silvermoon Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,1,1,0,@VICTORY,0,0,1,0,'',"SAI - Silvermoon Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,2,1,0,63034,0,0,0,0,'',"SAI - Silvermoon Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,2,9,0,13793,0,0,0,0,'',"SAI - Silvermoon Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,2,1,0,@VICTORY,0,0,1,0,'',"SAI - Silvermoon Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,3,1,0,63034,0,0,0,0,'',"SAI - Silvermoon Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,3,9,0,13790,0,0,0,0,'',"SAI - Silvermoon Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,3,1,0,@VICTORY,0,0,1,0,'',"SAI - Silvermoon Champion show different menu if player has not aura");

-- Thunder Bluff Champion SAI
SET @CHAMPION := 33748;
SET @VICTORY := 64815; -- Spell Bested Thunder Bluff
DELETE FROM `smart_scripts` WHERE `entryorguid`=@CHAMPION AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@CHAMPION,0,0,0,64,0,100,0,0,0,0,0,98,10458,14421,0,0,0,0,7,0,0,0,0,0,0,0,'Thunder Bluff Champion - Gossip Hello - Send different gossip (see conditions)'),
(@CHAMPION,0,1,2,62,0,100,0,10458,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Thunder Bluff Champion - Gossip select - close gossip'),
(@CHAMPION,0,2,3,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Thunder Bluff Champion - Gossip select - Store target'),
(@CHAMPION,0,3,4,61,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Champion - Gossip - Change Faction'),
(@CHAMPION,0,4,5,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,'Thunder Bluff Champion - Gossip - Attack Invoker vehicle'),
(@CHAMPION,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Champion - Gossip - Say Text'),
(@CHAMPION,0,6,0,4,0,100,0,0,0,0,0,11,64553,2,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Champion - Aggro - Cast defend aura'),
(@CHAMPION,0,7,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Thunder Bluff Champion - In combat - Cast Shield-Breaker'),
(@CHAMPION,0,8,0,9,0,100,0,8,25,7000,7000,11,63010,0,0,0,0,0,2,0,0,0,0,0,0,0,'Thunder Bluff Champion - Distance - Cast Charge'),
(@CHAMPION,0,9,0,0,0,100,0,10000,10000,15000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Champion - In combat - Flee'),
(@CHAMPION,0,10,11,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Champion - HP at 5% - Set faction default'),
(@CHAMPION,0,11,12,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Champion - Defeated - Say text'),
(@CHAMPION,0,12,14,61,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Thunder Bluff Champion - Defeated - Cross cast spell'),
(@CHAMPION,0,13,14,6,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Thunder Bluff Champion - Death - Cross cast spell'), -- this line is hacky, npc shouldn't be killed
(@CHAMPION,0,14,0,61,0,100,1,0,0,0,0,86,63596,3,12,1,0,0,12,1,0,0,0,0,0,0,'Thunder Bluff Champion - Defeated - Cross Cast Mounted Melee Victory'),
(@CHAMPION,0,15,18,25,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Champion - Reset - Set faction default'),
(@CHAMPION,0,16,17,5,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Champion - Kill - Say win text'),
(@CHAMPION,0,17,18,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Champion - Link - Set faction default'),
(@CHAMPION,0,18,19,61,0,100,1,0,0,0,0,28,64553,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Champion - Link - Remove defend aura'),
(@CHAMPION,0,19,0,61,0,100,1,0,0,0,0,28,62719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thunder Bluff Champion - Link - Remove defend charges');

DELETE FROM `creature_text` WHERE `entry`=@CHAMPION;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@CHAMPION,0,0,"Let it begin!",12,0,100,0,3,0,'Thunder Bluff Champion Aggro'),
(@CHAMPION,0,1,"On your guard!",12,0,100,0,3,0,'Thunder Bluff Champion Aggro'),
(@CHAMPION,0,2,"Prepare yourself!",12,0,100,0,3,0,'Thunder Bluff Champion Aggro'),
(@CHAMPION,0,3,"Ready yourself!",12,0,100,0,3,0,'Thunder Bluff Champion Aggro'),
(@CHAMPION,1,0,"I have been defeated. Good fight!",12,0,100,0,3,0,'Thunder Bluff Champion Defeated'),
(@CHAMPION,1,1,"It would seem I underestimated your skills. Well done.",12,0,100,0,3,0,'Thunder Bluff Champion Defeated'),
(@CHAMPION,1,2,"That was a well fought battle. I yield to you.",12,0,100,0,3,0,'Thunder Bluff Champion Defeated'),
(@CHAMPION,1,3,"I yield to you.",12,0,100,0,3,0,'Thunder Bluff Champion Defeated'),
(@CHAMPION,2,0,"I am afraid you will need more practice to defeat me.",12,0,100,0,3,0,'Thunder Bluff Champion Victory'),
(@CHAMPION,2,1,"I have won. Better luck another time, friend.",12,0,100,0,3,0,'Thunder Bluff Champion Victory'),
(@CHAMPION,2,2,"It seems you still need more practice. Perhaps another time.",12,0,100,0,3,0,'Thunder Bluff Champion Victory'),
(@CHAMPION,2,3,"Victory is mine!",12,0,100,0,3,0,'Thunder Bluff Champion Victory');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@CHAMPION AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@CHAMPION,0,0,1,0,63034,0,0,0,0,'',"SAI - Thunder Bluff Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,0,9,0,13814,0,0,0,0,'',"SAI - Thunder Bluff Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,0,1,0,@VICTORY,0,0,1,0,'',"SAI - Thunder Bluff Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,1,1,0,63034,0,0,0,0,'',"SAI - Thunder Bluff Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,1,9,0,13811,0,0,0,0,'',"SAI - Thunder Bluff Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,1,1,0,@VICTORY,0,0,1,0,'',"SAI - Thunder Bluff Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,2,1,0,63034,0,0,0,0,'',"SAI - Thunder Bluff Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,2,9,0,13793,0,0,0,0,'',"SAI - Thunder Bluff Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,2,1,0,@VICTORY,0,0,1,0,'',"SAI - Thunder Bluff Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,3,1,0,63034,0,0,0,0,'',"SAI - Thunder Bluff Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,3,9,0,13790,0,0,0,0,'',"SAI - Thunder Bluff Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,3,1,0,@VICTORY,0,0,1,0,'',"SAI - Thunder Bluff Champion show different menu if player has not aura");

-- Orgrimmar Champion SAI
SET @CHAMPION := 33744;
SET @VICTORY := 64811; -- Spell Bested Orgrimmar
DELETE FROM `smart_scripts` WHERE `entryorguid`=@CHAMPION AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@CHAMPION,0,0,0,64,0,100,0,0,0,0,0,98,10458,14421,0,0,0,0,7,0,0,0,0,0,0,0,'Orgrimmar Champion - Gossip Hello - Send different gossip (see conditions)'),
(@CHAMPION,0,1,2,62,0,100,0,10458,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Orgrimmar Champion - Gossip select - close gossip'),
(@CHAMPION,0,2,3,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Orgrimmar Champion - Gossip select - Store target'),
(@CHAMPION,0,3,4,61,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Champion - Gossip - Change Faction'),
(@CHAMPION,0,4,5,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,22,0,0,0,0,0,0,0,'Orgrimmar Champion - Gossip - Attack Invoker vehicle'),
(@CHAMPION,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Champion - Gossip - Say Text'),
(@CHAMPION,0,6,0,4,0,100,0,0,0,0,0,11,64553,2,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Champion - Aggro - Cast defend aura'),
(@CHAMPION,0,7,0,9,0,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'Orgrimmar Champion - In combat - Cast Shield-Breaker'),
(@CHAMPION,0,8,0,9,0,100,0,8,25,7000,7000,11,63010,0,0,0,0,0,2,0,0,0,0,0,0,0,'Orgrimmar Champion - Distance - Cast Charge'),
(@CHAMPION,0,9,0,0,0,100,0,10000,10000,15000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Champion - In combat - Flee'),
(@CHAMPION,0,10,11,2,0,100,1,0,5,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Champion - HP at 5% - Set faction default'),
(@CHAMPION,0,11,12,61,0,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Champion - Defeated - Say text'),
(@CHAMPION,0,12,14,61,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Orgrimmar Champion - Defeated - Cross cast spell'),
(@CHAMPION,0,13,14,6,0,100,1,0,0,0,0,86,@VICTORY,3,12,1,0,0,12,1,0,0,0,0,0,0,'Orgrimmar Champion - Death - Cross cast spell'), -- this line is hacky, npc shouldn't be killed
(@CHAMPION,0,14,0,61,0,100,1,0,0,0,0,86,63596,3,12,1,0,0,12,1,0,0,0,0,0,0,'Orgrimmar Champion - Defeated - Cross Cast Mounted Melee Victory'),
(@CHAMPION,0,15,18,25,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Champion - Reset - Set faction default'),
(@CHAMPION,0,16,17,5,0,100,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Champion - Kill - Say win text'),
(@CHAMPION,0,17,18,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Champion - Link - Set faction default'),
(@CHAMPION,0,18,19,61,0,100,1,0,0,0,0,28,64553,0,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Champion - Link - Remove defend aura'),
(@CHAMPION,0,19,0,61,0,100,1,0,0,0,0,28,62719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Orgrimmar Champion - Link - Remove defend charges');

DELETE FROM `creature_text` WHERE `entry`=@CHAMPION;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@CHAMPION,0,0,"Let it begin!",12,0,100,0,3,0,'Orgrimmar Champion Aggro'),
(@CHAMPION,0,1,"On your guard!",12,0,100,0,3,0,'Orgrimmar Champion Aggro'),
(@CHAMPION,0,2,"Prepare yourself!",12,0,100,0,3,0,'Orgrimmar Champion Aggro'),
(@CHAMPION,0,3,"Ready yourself!",12,0,100,0,3,0,'Orgrimmar Champion Aggro'),
(@CHAMPION,1,0,"I have been defeated. Good fight!",12,0,100,0,3,0,'Orgrimmar Champion Defeated'),
(@CHAMPION,1,1,"It would seem I underestimated your skills. Well done.",12,0,100,0,3,0,'Orgrimmar Champion Defeated'),
(@CHAMPION,1,2,"That was a well fought battle. I yield to you.",12,0,100,0,3,0,'Orgrimmar Champion Defeated'),
(@CHAMPION,1,3,"I yield to you.",12,0,100,0,3,0,'Orgrimmar Champion Defeated'),
(@CHAMPION,2,0,"I am afraid you will need more practice to defeat me.",12,0,100,0,3,0,'Orgrimmar Champion Victory'),
(@CHAMPION,2,1,"I have won. Better luck another time, friend.",12,0,100,0,3,0,'Orgrimmar Champion Victory'),
(@CHAMPION,2,2,"It seems you still need more practice. Perhaps another time.",12,0,100,0,3,0,'Orgrimmar Champion Victory'),
(@CHAMPION,2,3,"Victory is mine!",12,0,100,0,3,0,'Orgrimmar Champion Victory');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@CHAMPION AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@CHAMPION,0,0,1,0,63034,0,0,0,0,'',"SAI - Orgrimmar Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,0,9,0,13814,0,0,0,0,'',"SAI - Orgrimmar Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,0,1,0,@VICTORY,0,0,1,0,'',"SAI - Orgrimmar Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,1,1,0,63034,0,0,0,0,'',"SAI - Orgrimmar Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,1,9,0,13811,0,0,0,0,'',"SAI - Orgrimmar Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,1,1,0,@VICTORY,0,0,1,0,'',"SAI - Orgrimmar Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,2,1,0,63034,0,0,0,0,'',"SAI - Orgrimmar Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,2,9,0,13793,0,0,0,0,'',"SAI - Orgrimmar Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,2,1,0,@VICTORY,0,0,1,0,'',"SAI - Orgrimmar Champion show different menu if player has not aura"),
(22,1,@CHAMPION,0,3,1,0,63034,0,0,0,0,'',"SAI - Orgrimmar Champion show different menu if player mounted"),
(22,1,@CHAMPION,0,3,9,0,13790,0,0,0,0,'',"SAI - Orgrimmar Champion show different menu if player quest taken"),
(22,1,@CHAMPION,0,3,1,0,@VICTORY,0,0,1,0,'',"SAI - Orgrimmar Champion show different menu if player has not aura");
