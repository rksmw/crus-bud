-- Make the Wildervar Miners unselectable
UPDATE `creature_template` SET `unit_flags`=33554432 WHERE `entry`=24062;

-- Make two miners emote to talk
DELETE FROM `creature_addon` WHERE `guid` IN (120419,120422);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES 
(120419,0,0,0,0,1,''),(120422,0,0,0,0,1,'');

-- The ram meat spell may only be used if player is inside the mine
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=43209;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17,0,43209,0,23,4534,0,0,64,'','Place Ram Meat can only be used in Wildervar Mine');

-- Insert missing spell_target_position for Place Ram Meat spell
DELETE FROM `spell_target_position` WHERE `id`=43209;
INSERT INTO `spell_target_position` (`id`,`target_map`,`target_position_x`,`target_position_y`,`target_position_z`,`target_orientation`) VALUES
(43209,571,2636.288086,-5050.891113,295.537445,5.374982);

-- Shatterhorn SAI
SET @ENTRY := 24178;
SET @SPELL_GROUND_SMASH := 12734; -- Ground Smash
UPDATE `creature_template` SET `AIName`='SmartAI',`unit_flags`=256 WHERE `entry`=@ENTRY;
DELETE FROM `creature_addon` WHERE `guid`=106573;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Shatterhorn - On Aggro - Say Line 0'),
(@ENTRY,0,1,0,21,0,100,0,0,0,0,0,11,42648,1,0,0,0,0,1,0,0,0,0,0,0,0,"Shatterhorn - On Reached Home - Cast Sleeping Sleep"),
(@ENTRY,0,2,0,11,0,100,0,0,0,0,0,11,42648,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shatterhorn - On Spawn - Cast Sleeping Sleep"),
(@ENTRY,0,3,0,21,0,100,0,0,0,0,0,18,256,1,0,0,0,0,1,0,0,0,0,0,0,0,"Shatterhorn - On Reached Home - Set Unit Flags Not Attackable"),
(@ENTRY,0,4,0,0,0,100,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shatterhorn - On Enter Combat - Set React State Aggressive"),
(@ENTRY,0,5,0,0,0,100,0,3000,5000,12000,13000,11,@SPELL_GROUND_SMASH,1,0,0,0,0,2,0,0,0,0,0,0,0,'Shatterhorn - In Combat - Cast Ground Smash'),
(@ENTRY,0,6,0,6,0,100,0,0,0,0,0,41,10,0,0,0,0,0,1,0,0,0,0,0,0,0,'Shatterhorn - Force Despawn 8 Seconds After Death'); -- Doesn't work but in use for later
-- Text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,'%s wakes up from the smell of fresh meat!',16,0,100,15,0,0,'Shatterhorn on aggro line and roar at same time');

DELETE FROM  smart_scripts  WHERE `entryorguid`=24178 AND `id`=3;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(24178,0,3,0,8,0,0,0,43209,0,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,'Shatterhorn - On Place Meat spellhit remove unit flags');
