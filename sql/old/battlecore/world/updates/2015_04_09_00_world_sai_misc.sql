-- Quest - Runes of Compulsion
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (26785,26920,26921,26922,26923);
UPDATE `creature_template` SET `faction_A`=1954, `faction_H`=1954 WHERE `entry` IN (26920,26921,26922,26923);

-- Overseer Durval SAI
SET @ENTRY := 26920;
SET @GO := 188471;
SET @GUID := -111145;
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=@GO;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GO AND `source_type`=1;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GO*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@GO,1,0,0,70,0,100,0,2,0,0,0,80,@GO*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'Directional Rune - On activate - Run script'),
(@GO*100,9,0,0,0,0,100,0,0,0,0,0,12,@ENTRY,1,120000,0,0,0,8,0,0,0,4483.63,-4654.35,77.727,3.274123,'Directional Rune - Script - Summon Overseer Durval'),
(@GO*100,9,1,0,0,0,100,0,30000,30000,0,0,32,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Directional Rune - Script - Reset');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@GUID,@ENTRY) AND `source_type`=0;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@GUID,0,0,0,8,0,100,0,47463,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Directional Rune - Spellhit - Set phase 1'),
(@GUID,0,1,2,23,1,100,0,47463,0,0,0,9,0,0,0,0,0,0,15,@GO,30,0,0,0,0,0, 'Directional Rune - Missing Aura - Activate Directional Rune 2'),
(@GUID,0,2,0,61,0,100,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Directional Rune - Missing Aura - Set phase 2'),
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Overseer Durval - Just Summoned - Say text');

DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"You'll pay for this!",12,0,100,0,0,0,'Overseer Durval'),
(@ENTRY,0,1,"What do you think you're doing?",12,0,100,0,0,0,'Overseer Durval'),
(@ENTRY,0,2,"You dare to defy the sons of iron?",12,0,100,0,0,0,'Overseer Durval');

-- Overseer Korgan SAI
SET @ENTRY := 26921;
SET @GO := 188505;
SET @GUID := -111146;
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=@GO;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GO AND `source_type`=1;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GO*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@GO,1,0,0,70,0,100,0,2,0,0,0,80,@GO*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'Directional Rune - On activate - Run script'),
(@GO*100,9,0,0,0,0,100,0,0,0,0,0,12,@ENTRY,1,120000,0,0,0,8,0,0,0,4314.36,-4877.18,33.599,2.41784,'Directional Rune - On activate - Summon Overseer Korgan'),
(@GO*100,9,1,0,0,0,100,0,30000,30000,0,0,32,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Directional Rune - Script - Reset');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@GUID,@ENTRY) AND `source_type`=0;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@GUID,0,0,0,8,0,100,0,47463,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Directional Rune - Spellhit - Set phase 1'),
(@GUID,0,1,2,23,1,100,0,47463,0,0,0,9,0,0,0,0,0,0,15,@GO,30,0,0,0,0,0, 'Directional Rune - Missing Aura - Activate Directional Rune 2'),
(@GUID,0,2,0,61,0,100,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Directional Rune - Missing Aura - Set phase 2'),
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Overseer Korgan - Just Summoned - Say text');

DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"You'll pay for this!",12,0,100,0,0,0,'Overseer Korgan'),
(@ENTRY,0,1,"What do you think you're doing?",12,0,100,0,0,0,'Overseer Korgan'),
(@ENTRY,0,2,"You dare to defy the sons of iron?",12,0,100,0,0,0,'Overseer Korgan');

-- Overseer Lochii SAI
SET @ENTRY := 26922;
SET @GO := 188506;
SET @GUID := -111147;
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=@GO;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GO AND `source_type`=1;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GO*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@GO,1,0,0,70,0,100,0,2,0,0,0,80,@GO*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'Directional Rune - On activate - Run script'),
(@GO*100,9,0,0,0,0,100,0,0,0,0,0,12,@ENTRY,1,120000,0,0,0,8,0,0,0,4214.51,-5048.09,5.757,2.60635,'Directional Rune - On activate - Summon Overseer Lochii'),
(@GO*100,9,1,0,0,0,100,0,30000,30000,0,0,32,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Directional Rune - Script - Reset');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@GUID,@ENTRY) AND `source_type`=0;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@GUID,0,0,0,8,0,100,0,47463,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Directional Rune - Spellhit - Set phase 1'),
(@GUID,0,1,2,23,1,100,0,47463,0,0,0,9,0,0,0,0,0,0,15,@GO,30,0,0,0,0,0, 'Directional Rune - Missing Aura - Activate Directional Rune 2'),
(@GUID,0,2,0,61,0,100,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Directional Rune - Missing Aura - Set phase 2'),
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Overseer Lochii - Just Summoned - Say text');

DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"You'll pay for this!",12,0,100,0,0,0,'Overseer Lochii'),
(@ENTRY,0,1,"What do you think you're doing?",12,0,100,0,0,0,'Overseer Lochii'),
(@ENTRY,0,2,"You dare to defy the sons of iron?",12,0,100,0,0,0,'Overseer Lochii');

-- Overseer Brunon SAI
SET @ENTRY := 26923;
SET @GO := 188507;
SET @GUID := -202405;
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=@GO;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GO AND `source_type`=1;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GO*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@GO,1,0,0,70,0,100,0,2,0,0,0,80,@GO*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'Directional Rune - On activate - Run script'),
(@GO*100,9,0,0,0,0,100,0,0,0,0,0,12,@ENTRY,1,120000,0,0,0,8,0,0,0,3981.47,-5249.55,6.997,2.97156,'Directional Rune - On activate - Summon Overseer Brunon'),
(@GO*100,9,1,0,0,0,100,0,30000,30000,0,0,32,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Directional Rune - Script - Reset');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@GUID,@ENTRY) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@GUID,0,0,0,8,0,100,0,47463,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Directional Rune - Spellhit - Set phase 1'),
(@GUID,0,1,2,23,1,100,0,47463,0,0,0,9,0,0,0,0,0,0,15,@GO,30,0,0,0,0,0, 'Directional Rune - Missing Aura - Activate Directional Rune 2'),
(@GUID,0,2,0,61,0,100,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Directional Rune - Missing Aura - Set phase 2'),
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Overseer Brunon - Just Summoned - Say text');

DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"You'll pay for this!",12,0,100,0,0,0,'Overseer Brunon'),
(@ENTRY,0,1,"What do you think you're doing?",12,0,100,0,0,0,'Overseer Brunon'),
(@ENTRY,0,2,"You dare to defy the sons of iron?",12,0,100,0,0,0,'Overseer Brunon');
