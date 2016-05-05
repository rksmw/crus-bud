-- Quest - Hope Within the Emerald Nightmare
SET @ENTRY := 11832;
SET @QUEST := 13074;
SET @GOSSIP := 10215;
SET @SPELL_FITFUL_DREAM := 57413;
SET @SPELL_WAKING_REMOVE := 57515;
SET @SPELL_WAKING_TRIGGER := 57517;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0 AND `id` IN (33,34,35,36);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,33,0,19,0,100,0,@QUEST,0,0,0,11,@SPELL_FITFUL_DREAM,0,0,0,0,0,7,0,0,0,0,0,0,0,"Keeper Remulos - On Quest Accept - Cast Fitful Dream"),
(@ENTRY,0,34,35,62,0,100,0,@GOSSIP,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Keeper Remulos - On Gossip select - Close gossip"),
(@ENTRY,0,35,0,61,0,100,0,0,0,0,0,11,@SPELL_FITFUL_DREAM,0,0,0,0,0,7,0,0,0,0,0,0,0,"Keeper Remulos - On Gossip Select - Cast Fitful Dream"),
(@ENTRY,0,36,0,8,0,100,0,@SPELL_WAKING_TRIGGER,0,0,0,1,10,0,0,0,0,0,1,0,0,0,0,0,0,0,"Keeper Remulos - Spellhit - Say text");

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=-@SPELL_FITFUL_DREAM;
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`comment`) VALUES
(-@SPELL_FITFUL_DREAM,@SPELL_WAKING_REMOVE,'Cast Waking from a Fitful Dream on Fitful Dream remove');

DELETE FROM `spell_target_position` WHERE `id`=@SPELL_WAKING_REMOVE;
INSERT INTO `spell_target_position` (`id`,`target_map`,`target_position_x`,`target_position_y`,`target_position_z`,`target_orientation`) VALUES
(@SPELL_WAKING_REMOVE,1,7845.4,-2221.39,469.48,0.93899);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=@SPELL_WAKING_TRIGGER;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,2,@SPELL_WAKING_TRIGGER,0,0,31,0,3,@ENTRY,0,0,0,0,'','Waking from a Fitful Dream - Impplicit target - Keeper Remulos');

DELETE FROM `creature_text` WHERE `entry`=@ENTRY AND `groupid`=10;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(11832,10,0,'Welcome back to the waking world, child.',12,0,100,0,0,0,'Keeper Remulos');
