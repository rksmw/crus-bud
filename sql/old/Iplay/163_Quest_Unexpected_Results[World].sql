-- Quest - Unexpected Results
SET @ELF := 15402;
SET @GARZHUL := 15958;
SET @ANGERSHADE := 15656;
SET @QUEST := 8488;
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='', `unit_flags`=0, `flags_extra`=0 WHERE `entry`=@ELF;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ELF AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ELF,0,0,0,25,0,100,0,0,0,0,0,82,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Apprentice Mirveda - Reset - Set npcflag'),
(@ELF,0,1,0,25,0,100,0,0,0,0,0,2,1604,0,0,0,0,0,1,0,0,0,0,0,0,0,'Apprentice Mirveda - Reset - Set faction'),
(@ELF,0,2,3,19,0,100,0,@QUEST,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Apprentice Mirveda - Quest accepted - Remove npcflag'),
(@ELF,0,3,4,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Apprentice Mirveda - Quest accepted - Store target'),
(@ELF,0,4,5,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Apprentice Mirveda - Quest accepted - Say text'),
(@ELF,0,5,6,61,0,100,0,0,0,0,0,2,1603,0,0,0,0,0,1,0,0,0,0,0,0,0,'Apprentice Mirveda - Quest accepted - Set faction'),
(@ELF,0,6,7,61,0,100,0,0,0,0,0,12,@GARZHUL,7,0,0,1,0,8,0,0,0,8745,-7134.32,35.22,0,'Apprentice Mirveda - Quest accepted - Summon Garzhul'),
(@ELF,0,7,8,61,0,100,0,0,0,0,0,12,@ANGERSHADE,7,0,0,1,0,8,0,0,0,8745,-7134.32,35.22,0,'Apprentice Mirveda - Quest accepted - Summon Garzhul'),
(@ELF,0,8,0,61,0,100,0,0,0,0,0,12,@ANGERSHADE,7,0,0,1,0,8,0,0,0,8745,-7134.32,35.22,0,'Apprentice Mirveda - Quest accepted - Summon Garzhul'),
(@ELF,0,9,10,7,0,100,0,0,0,0,0,15,@QUEST,0,0,0,0,0,12,1,0,0,0,0,0,0,'Apprentice Mirveda - Evade - Complete quest'),
(@ELF,0,10,0,61,0,100,0,0,0,0,0,82,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Apprentice Mirveda - Evade - Set npcflag'),
(@ELF,0,11,0,6,0,100,0,0,0,0,0,6,@QUEST,0,0,0,0,0,12,1,0,0,0,0,0,0,'Apprentice Mirveda - Death - Fail quest'),
(@ELF,0,12,0,37,0,100,0,0,0,0,0,58,1,20811,2000,2000,40,25,1,0,0,0,0,0,0,0,'Apprentice Mirveda - AI Init - Set caster template (Fireball)'),
(@ELF,0,13,0,0,0,100,0,8000,15000,8000,15000,11,12468,1,0,0,0,0,2,0,0,0,0,0,0,0,'Apprentice Mirveda - In combat - Cast Flamestrike');

DELETE FROM `creature_text` WHERE `entry`=@ELF;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ELF,0,0,"Such... dark... energy! How can this be possible?",12,0,100,0,0,0,'Apprentice Mirveda');
