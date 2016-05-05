-- Quest - Kaw the Mammoth Destroyer
SET @KAW := 25802;
SET @MORIA := 25881;
SET @RIDE := 46598;
SET @SPELL := 46310;
UPDATE `creature_template` SET `unit_flags`=unit_flags&~256, `AIName`='SmartAI' WHERE `entry`=@KAW;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@MORIA;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@KAW;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@KAW,@MORIA) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@KAW,0,0,0,1,0,100,0,0,0,5000,5000,11,@RIDE,34,0,0,0,0,19,@MORIA,100,0,0,0,0,0,'Kaw the Mammoth Destroyer - Update OOC - Ride Moria'),
(@KAW,0,1,0,4,0,100,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Kaw the Mammoth Destroyer - Aggro - Say text'),
(@KAW,0,2,0,6,0,100,0,0,0,0,0,11,@SPELL,0,0,0,0,0,1,0,0,0,0,0,0,0,'Kaw the Mammoth Destroyer - Death - Cast Drop War Halberd'),
(@MORIA,0,0,0,25,0,100,0,0,0,0,0,70,0,0,0,0,0,0,10,114932,@KAW,0,0,0,0,0,'Moria - Reset - Respawn Kaw');

DELETE FROM `creature_text` WHERE `entry`=@KAW;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@KAW,0,0,"You challenge Kaw, destroyer of mammoths!? Then face me and feel my thunder!",14,0,100,0,0,0,'Kaw the Mammoth Destroyer');

-- Beast Empathy
DELETE FROM `spell_area` WHERE `spell`=46234;
INSERT INTO `spell_area` (`spell`,`area`,`quest_start`,`quest_start_status`,`quest_end`,`aura_spell`,`racemask`,`gender`,`autocast`) VALUES
(46234,3537,11879,74,0,0,0,2,1);

-- Wooly Mammoth Bull SAI
UPDATE `creature_template` SET `spell1`=46315, `spell2`=46317, `spell3`=46316 WHERE `entry`=25743;
DELETE FROM `smart_scripts` WHERE `entryorguid`=25743 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(25743,0,0,0,6,0,100,0,0,0,0,0,11,46221,2,0,0,0,0,7,0,0,0,0,0,0,0,'Wooly Mammoth Bull - On Death - Cast Animal Blood'),
(25743,0,1,0,0,0,100,0,3000,9000,9000,18000,11,46316,0,0,0,0,0,2,0,0,0,0,0,0,0,'Wooly Mammoth Bull - In Combat - Cast Thundering Roar'),
(25743,0,2,3,27,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Wooly Mammoth Bull - Passenger Boarded - React passive'),
(25743,0,3,0,61,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Wooly Mammoth Bull - Passenger Boarded - Set phase 1'),
(25743,0,4,0,23,1,100,0,46260,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Wooly Mammoth Bull - Missing ride aura - Despawn');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=18 AND `SourceGroup`=25743;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(18,25743,46260,0,0,9,0,11879,0,0,0,0, '', 'Required quest active for spellclick');

DELETE FROM `creature_text` WHERE `entry`='25802';
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(25802, 0, 0, 'You challenge Kaw, destroyer of mammoths? Then face me and feel my thunder!', 14, 0, 100, 0, 0, 0, 'Kaw - Event Start Yell');

DELETE FROM `locales_creature_text` WHERE `entry` = '25802';
INSERT INTO `locales_creature_text` (`entry`, `groupid`, `id`, `text_loc1`, `text_loc2`, `text_loc3`, `text_loc4`, `text_loc5`, `text_loc6`, `text_loc7`, `text_loc8`) VALUES
('25802','0','0',NULL,NULL,NULL,NULL,NULL,NULL,"¿Retas a Kaw, el Destructor de Mamuts? ¡Entonces enfréntate a mí y siente mis relámpagos!",NULL);

UPDATE creature SET spawntimesecs='20' WHERE id IN (25802,25881);
UPDATE creature_template SET scriptname='npc_kaw_the_mammoth_destroyer',unit_flags = 0 WHERE entry = 25802;
UPDATE creature_template SET faction_A=16,faction_H=16,unit_flags = 0, unit_flags2 = 0,type_flags=0,vehicleid=0,movementid=186,scriptname='npc_moria' WHERE entry = 25881;
