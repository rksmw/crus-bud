-- Quest - Dissension Amongst the Ranks...
SET @ENTRY = 19823;
DELETE FROM `spell_scripts` WHERE `id`=38223;
INSERT INTO `spell_scripts` (`id`,`command`,`datalong`) VALUES
(38223,8,22051);

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,6,0,100,0,0,0,0,0,11,38223,2,0,0,0,0,7,0,0,0,0,0,0,0,'Crazed Colossus - Death - Cast Quest Credit');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=38223;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=38223;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`comment`) VALUES
(13,1,38223,0,1,0,38224,'Quest Credit - Implicit Target - Illidari Agent Illusion'),
(17,0,38223,0,1,1,38224,'Quest Credit - Explicit Target - Illidari Agent Illusion');

DELETE FROM `spell_script_names` WHERE `spell_id`=38224;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(38224,'spell_item_illidari_agent_illusion');
