-- Achievement - Burning Hot Pole Dance
SET @GO := 181605;
SET @SPELL_DANCE_PERIODIC := 45406;
SET @SPELL_HAS_CLOTH := 58933;
SET @SPELL_CHANNEL_1 := 29705;
SET @SPELL_CHANNEL_2 := 29726;
SET @SPELL_CHANNEL_3 := 29727;
SET @RIBBON_TRIGGER := 17066;
SET @RIBBON_BUNNY := 25303;

DELETE FROM `spell_dbc` WHERE `Id`=58934;
INSERT INTO `spell_dbc` (`Id`,`Effect1`,`EffectImplicitTargetA1`,`EffectImplicitTargetB1`,`Comment`) VALUES
(58934,3,1,0,'Burning Hot Pole Dance (Gives achievement)');

UPDATE `gameobject_template` SET `AIName`='', `ScriptName`='go_ribbon_pole' WHERE `entry`=@GO;
UPDATE `creature_template` SET `AIName`='', `InhabitType`=4, `ScriptName`='npc_ribbon_pole_debug_target' WHERE `entry`=@RIBBON_TRIGGER;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@RIBBON_BUNNY;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@RIBBON_BUNNY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`, `target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@RIBBON_BUNNY,0,0,0,60,0,100,0,5000,5000,10000,10000,11,46836,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ribbon Pole Bunny - Update - Cast Ribbon Pole Firework Launcher Aura, Long'),
(@RIBBON_BUNNY,0,1,0,60,0,100,0,0,0,10000,10000,11,46842,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ribbon Pole Bunny - Update - Cast Ribbon Pole Firework Launcher Aura');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (@SPELL_CHANNEL_1,@SPELL_CHANNEL_2,@SPELL_CHANNEL_3);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,@SPELL_CHANNEL_1,0,0,31,0,3,@RIBBON_TRIGGER,0,0,0,'','Test Ribbon Pole Channel - Implicit target - Ribbon Pole Debug Target'),
(13,1,@SPELL_CHANNEL_2,0,0,31,0,3,@RIBBON_TRIGGER,0,0,0,'','Test Ribbon Pole Channel - Implicit target - Ribbon Pole Debug Target'),
(13,1,@SPELL_CHANNEL_3,0,0,31,0,3,@RIBBON_TRIGGER,0,0,0,'','Test Ribbon Pole Channel - Implicit target - Ribbon Pole Debug Target');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=29715;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(29715, 29175, 0, 'Pole Channel trigger Experience buff on each proc');

DELETE FROM `spell_script_names` WHERE `spell_id`=@SPELL_DANCE_PERIODIC;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(@SPELL_DANCE_PERIODIC,'spell_midsummer_ribbon_pole_visual');
