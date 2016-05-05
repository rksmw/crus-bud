-- Quest - A Visit to the Doctor
SET @PATCHES := 30993;
SET @SABNOK := 30992;
SET @CHAIN := 30995;
SET @GO := 193025;
UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `id` IN (@PATCHES,@CHAIN);
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=@GO;
UPDATE `creature_template` SET `AIName`='SmartAI', `unit_flags`=unit_flags&~256, `faction_A`=2141, `faction_H`=2141 WHERE `entry`=@PATCHES;
UPDATE `creature_template` SET `AIName`='SmartAI', `unit_flags`=unit_flags|256, `faction_A`=14, `faction_H`=14 WHERE `entry`=@SABNOK;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@PATCHES,@SABNOK) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@SABNOK*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@PATCHES,0,0,0,11,0,100,0,0,571,210,0,11,58108,3,0,0,0,0,19,@CHAIN,0,0,0,0,0,0,'Patches - Respawn - Cast Patches Chain'),
(@PATCHES,0,1,2,38,0,100,1,1,1,0,0,12,@SABNOK,6,10000,0,0,0,8,0,0,0,6605.156,3193.803,647.3837,6.23921,'Patches - Data set - Summon Doctor Sabnok'),
(@PATCHES,0,2,3,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Patches - Data set - Say text'),
(@PATCHES,0,3,0,61,0,100,0,0,0,0,0,92,0,58108,0,0,0,0,1,0,0,0,0,0,0,0,'Patches - Data set - Stop casting chain'),
(@PATCHES,0,4,5,38,0,100,0,1,2,0,0,1,1,10000,0,0,0,0,1,0,0,0,0,0,0,0,'Patches - Data set - Say text'),
(@PATCHES,0,5,0,61,0,100,0,0,0,0,0,17,402,0,0,0,0,0,1,0,0,0,0,0,0,0,'Patches - Data set - Set emote state'),
(@PATCHES,0,6,7,52,0,100,0,1,@PATCHES,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Patches - Text over - Remove emote state'),
(@PATCHES,0,7,0,61,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Patches - Text over - Despawn'),
(@SABNOK,0,0,0,54,0,100,0,0,0,0,0,80,@SABNOK*100,2,0,0,0,0,1,0,0,0,0,0,0,0,'Doctor Sabnok - Just summoned - Run script'),
(@SABNOK,0,1,2,8,0,100,0,58118,0,0,0,11,59115,3,0,0,0,0,0,0,0,0,0,0,0,0,'Doctor Sabnok - Spellhit - Cast Patches Credit'),
(@SABNOK,0,2,0,61,0,100,0,0,0,0,0,45,1,2,0,0,0,0,19,@PATCHES,0,0,0,0,0,0,'Doctor Sabnok - Spellhit - Set data Patches'),
(@SABNOK*100,9,0,0,0,0,100,0,3000,3000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Doctor Sabnok - Script - Say text'),
(@SABNOK*100,9,1,0,0,0,100,0,7000,7000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Doctor Sabnok - Script - Say text'),
(@SABNOK*100,9,2,0,0,0,100,0,0,0,0,0,49,0,0,0,0,0,0,19,@PATCHES,0,0,0,0,0,0,'Doctor Sabnok - Script - Attack Patches'),
(@SABNOK*100,9,3,0,0,0,100,0,3000,3000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Doctor Sabnok - Script - Say text'),
(@SABNOK*100,9,4,0,0,0,100,0,4000,4000,0,0,86,58118,3,19,@PATCHES,0,0,1,0,0,0,0,0,0,0,'Doctor Sabnok - Script - Patches cross cast');

DELETE FROM `smart_scripts` WHERE `entryorguid`=@GO AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@GO,1,0,0,70,0,100,0,2,0,0,0,45,1,1,0,0,0,0,19,@PATCHES,0,0,0,0,0,0,'Patches Chain - State changed - Set data Patches');

DELETE FROM `creature_text` WHERE `entry` IN (@PATCHES,@SABNOK);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES  
(@PATCHES,0,0,"Patches get revenge on Doctor Sabnok!",12,0,100,0,0,0,'Patches'),
(@PATCHES,1,0,"Patches not going to be cut open or sewn up no more!",12,0,100,0,0,0,'Patches'),
(@SABNOK,0,0,"Oh, bravo. Do you feel proud of yourself now that you've unleashed this terrible mistake?",12,0,100,0,0,0,'Doctor Sabnok'),
(@SABNOK,1,0,"I already had him scheduled for disposal, but I suppose we can speed up the process a bit.",12,0,100,0,0,0,'Doctor Sabnok'),
(@SABNOK,2,0,"It's a pity so many fine, and reusable, parts will go to waste...",12,0,100,0,0,0,'Doctor Sabnok');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=58108;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`, `ConditionValue2`,`Comment`) VALUES
(13,1,58108,31,3,@CHAIN,'Patches chain - Implicit target - Patches Chain Target');
