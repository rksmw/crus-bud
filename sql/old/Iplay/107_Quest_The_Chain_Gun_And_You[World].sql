-- Quest - The Chain Gun And You
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=49554;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,1,49554,0,0,31,0,3,27795,0,0,0,'','Dismount player when not in intended zone'),
(13,1,49554,0,0,35,0,1,80,4,0,0,'','Dismount player when not in intended zone');

UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_injured_7th_legion_soldier' WHERE `entry`=27788;
UPDATE `creature_template` SET `speed_run`=0, `speed_walk`=0, `ScriptName`='', `unit_flags`=unit_flags|2 WHERE `entry`= 27714;
UPDATE `creature_template` SET `type_flags`=type_flags&~4096 WHERE `entry`=27319;

DELETE FROM `smart_scripts` WHERE `entryorguid`=27791 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(27791,0,0,0,25,0,100,0,0,0,0,0,8,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'7th Legion Rifleman - Reset - React Deffensive'),
(27791,0,1,0,25,0,100,0,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'7th Legion Rifleman - Reset - Stop Combat Move'),
(27791,0,2,0,4,0,100,0,0,0,0,0,11,62312,0,0,0,0,0,2,0,0,0,0,0,0,0,'7th Legion Rifleman - On Aggro - Cast Net'),
(27791,0,3,0,0,0,100,0,500,3500,5000,6000,11,50092,0,0,0,0,0,2,0,0,0,0,0,0,0,'7th Legion Rifleman - In combat - Cast Shoot');

DELETE FROM `creature_text` WHERE `entry`=27788;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(27788,0,0,"I was almost ghoul bait! Thanks for the rescue!",12,0,100,1,0,0,"Injured 7th Legion Soldier"),
(27788,0,1,"It's a good thing you came along, ally! We were done for!",12,0,100,1,0,0,"Injured 7th Legion Soldier"),
(27788,0,2,"Thanks for the cover fire! It's a MADHOUSE down there!",12,0,100,1,0,0,"Injured 7th Legion Soldier"),
(27788,0,3,"Wow, I thought I was a goner! Thanks, friend!",12,0,100,1,0,0,"Injured 7th Legion Soldier");
