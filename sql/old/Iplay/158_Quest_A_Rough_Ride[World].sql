-- [QUEST] A Rough Ride (12536)
SET @ENTRY := 28298;
SET @GOSSIP := 9674;
SET @SPELL := 51258;
SET @ENTRY_MOUNT := 28308;
SET @QUEST := 12536;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@ENTRY,@ENTRY_MOUNT);
UPDATE `creature_template` SET `VehicleId`=115, `InhabitType`=3, `unit_flags`=`unit_flags`|512|256 WHERE `entry`=@ENTRY_MOUNT;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY_MOUNT) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY_MOUNT*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(@ENTRY,0,0,0,62,0,100,0,@GOSSIP,0,0,0,11,@SPELL,0,0,0,0,0,7,0,0,0,0,0,0,0, 'On gossip select - cast spell 51258 - Captive Crocolisk'),
(@ENTRY_MOUNT,0,1,0,54,0,100,0,0,0,0,0,80,@ENTRY_MOUNT*100,0,2,0,0,0,1,0,0,0,0,0,0,0, 'On summon - run script - Captive Crocolisk'),
(@ENTRY_MOUNT*100,9,0,0,0,0,100,0,0,0,0,0,53,1,@ENTRY_MOUNT,0,@QUEST,0,1,1,0,0,0,0,0,0,0, 'Start wp - Captive Crocolisk'),
(@ENTRY_MOUNT,0,2,3,58,0,100,0,41,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'on wp end - despawn - Captive Crocolisk'),
(@ENTRY_MOUNT,0,3,0,61,0,100,0,@ENTRY_MOUNT,0,0,0,15,@QUEST,0,0,0,0,0,7,0,0,0,0,0,0,0, 'on despawn - call area explored of event happens');

-- Waypoints
DELETE FROM `waypoints` WHERE `entry`=@ENTRY_MOUNT;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(@ENTRY_MOUNT,1,5268.226,4425.439,-95.55899, 'Captive Crocolisk'),
(@ENTRY_MOUNT,2,5249.557,4405.892,-96.04365, 'Captive Crocolisk'),
(@ENTRY_MOUNT,3,5266.678,4365.464,-98.19455, 'Captive Crocolisk'),
(@ENTRY_MOUNT,4,5289.138,4366.553,-102.234, 'Captive Crocolisk'),
(@ENTRY_MOUNT,5,5330.018,4363.27,-121.0311, 'Captive Crocolisk'),
(@ENTRY_MOUNT,6,5349.229,4341.059,-134.0126, 'Captive Crocolisk'),
(@ENTRY_MOUNT,7,5365.038,4333.716,-141.5817, 'Captive Crocolisk'),
(@ENTRY_MOUNT,8,5405.443,4307.841,-142.03, 'Captive Crocolisk'),
(@ENTRY_MOUNT,9,5434.999,4305.659,-136.4706, 'Captive Crocolisk'),
(@ENTRY_MOUNT,10,5464.708,4302.066,-133.1981, 'Captive Crocolisk'),
(@ENTRY_MOUNT,11,5490.555,4294.395,-127.5203, 'Captive Crocolisk'),
(@ENTRY_MOUNT,12,5503.808,4269.717,-110.3168, 'Captive Crocolisk'),
(@ENTRY_MOUNT,13,5518.324,4255.308,-103.0638, 'Captive Crocolisk'),
(@ENTRY_MOUNT,14,5540.53,4259.77,-102.3979, 'Captive Crocolisk'),
(@ENTRY_MOUNT,15,5564.194,4263.45,-102.7574, 'Captive Crocolisk'),
(@ENTRY_MOUNT,16,5585.45,4261.137,-99.54807, 'Captive Crocolisk'),
(@ENTRY_MOUNT,17,5609.614,4259.657,-98.87333, 'Captive Crocolisk'),
(@ENTRY_MOUNT,18,5633.434,4259.228,-98.53442, 'Captive Crocolisk'),
(@ENTRY_MOUNT,19,5681.639,4266.31,-99.26748, 'Captive Crocolisk'),
(@ENTRY_MOUNT,20,5708.126,4273.348,-102.9183, 'Captive Crocolisk'),
(@ENTRY_MOUNT,21,5748.732,4284.135,-112.0557, 'Captive Crocolisk'),
(@ENTRY_MOUNT,22,5839.82,4368.61,-112.0805, 'Captive Crocolisk'),
(@ENTRY_MOUNT,23,5865.922,4371.208,-105.5544, 'Captive Crocolisk'),
(@ENTRY_MOUNT,24,5897.276,4408.44,-95.25065, 'Captive Crocolisk'),
(@ENTRY_MOUNT,25,5925.311,4440.624,-94.77592, 'Captive Crocolisk'),
(@ENTRY_MOUNT,26,5953.005,4476.29,-94.3763, 'Captive Crocolisk'),
(@ENTRY_MOUNT,27,5964.229,4503.729,-92.81553, 'Captive Crocolisk'),
(@ENTRY_MOUNT,28,5960.583,4546.558,-95.65462, 'Captive Crocolisk'),
(@ENTRY_MOUNT,29,5965.167,4579.141,-97.39779, 'Captive Crocolisk'),
(@ENTRY_MOUNT,30,5969.295,4613.739,-98.05751, 'Captive Crocolisk'),
(@ENTRY_MOUNT,31,5975.809,4659.289,-99.27143, 'Captive Crocolisk'),
(@ENTRY_MOUNT,32,5992.961,4699.554,-99.30317, 'Captive Crocolisk'),
(@ENTRY_MOUNT,33,6015.139,4743.752,-97.52377, 'Captive Crocolisk'),
(@ENTRY_MOUNT,34,6035.183,4788.787,-94.66938, 'Captive Crocolisk'),
(@ENTRY_MOUNT,35,6064.951,4827.502,-94.54885, 'Captive Crocolisk'),
(@ENTRY_MOUNT,36,6065.57,4870.553,-94.47726, 'Captive Crocolisk'),
(@ENTRY_MOUNT,37,6096.612,4885.741,-94.44479, 'Captive Crocolisk'),
(@ENTRY_MOUNT,38,6120.387,4902.048,-95.06882, 'Captive Crocolisk'),
(@ENTRY_MOUNT,39,6139.616,4913.349,-94.8635, 'Captive Crocolisk'),
(@ENTRY_MOUNT,40,6139.616,4913.349,-94.93861, 'Captive Crocolisk'),
(@ENTRY_MOUNT,41,6139.616,4913.349,-94.93861, 'Captive Crocolisk');

-- Give Zepik's Horn to player on quest accept
UPDATE `quest_template` SET `SourceSpellId`=52545 WHERE `Id`=12536;
