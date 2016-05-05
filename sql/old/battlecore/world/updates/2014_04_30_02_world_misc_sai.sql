-- Quest - Iron Rune Constructs and You: Collecting Data
SET @CRYSTAL := 24820;
SET @GOLEM := 24821;
SET @BENCH  := 186958;
SET @SUMMON := 49986;

-- Work Bench SAI
DELETE FROM `smart_scripts` WHERE `entryorguid`=@BENCH AND `source_type`=1 AND `id` IN (2,3);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@BENCH,1,2,3,62,0,100,0,9024,1,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Work Bench - Gossip select - Close gossip'),
(@BENCH,1,3,0,61,0,100,0,0,0,0,0,85,@SUMMON,2,0,0,0,0,7,0,0,0,0,0,0,0,'Work Bench - Gossip select - Summon Iron Rune Construct');

-- Iron Dwarf Relic SAI
UPDATE `creature_template` SET `AIName`='SmartAI', `modelid2`=0 WHERE `entry`=@CRYSTAL;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = @CRYSTAL;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` = @CRYSTAL*100;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@CRYSTAL,0,0,0,8,0,100,0,44550,0,6000,6000,80,@CRYSTAL*100,0,0,0,0,0,1,0,0,0,0,0,0,0,"Iron Dwarf Relic - Spellhit - run script"),
(@CRYSTAL*100,9,0,0,0,0,100,0,5000,5000,0,0,45,0,1,0,0,0,0,7,0,0,0,0,0,0,0,"Iron Dwarf Relic - Spellhit - set data on invoker");

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=44550;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,1,44550,0,0,31,0,3,@CRYSTAL,0,0,0,'','Collect Data - Implicit target - Iron Dwarf Relic');

DELETE FROM `creature` WHERE `id`=@CRYSTAL;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`) VALUES
(@CRYSTAL,571,1,1,0,0,466.789,-5921.3,309.443,3.49066,300,0,0,8982,0,0);

-- Iron Rune Construct SAI
UPDATE `creature_template` SET `spell1`=44550, `AIName`='SmartAI' WHERE `entry`=@GOLEM;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GOLEM AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@GOLEM,0,0,0,38,0,100,0,0,1,0,0,33,@CRYSTAL,0,0,0,0,0,23,0,0,0,0,0,0,0,'Iron Rune Construct - Data set - Give credit');
