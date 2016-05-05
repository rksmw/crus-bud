-- Quest - Fuel For the Fire
UPDATE `creature_template` SET `spell1`=52497, `spell2`=52510, `AIName`='SmartAI' WHERE `entry`=28843;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=28844;
UPDATE `creature_template` SET `AIName`='SmartAI', `unit_flags`=2 WHERE `entry`=28873;
UPDATE `creature_template` SET `AIName`='SmartAI', `VehicleId`=129, `InhabitType`=4 WHERE `entry`=28759;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (28843,28844,28759,28873) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(28843,0,0,0,5,0,100,0,0,0,0,28844,86,52590,2,23,0,0,0,23,0,0,0,0,0,0,0,'Bloated Abomination - Kill unit - Cross cast credit'),
(28843,0,1,0,38,0,100,0,0,1,0,0,86,52590,2,23,0,0,0,23,0,0,0,0,0,0,0,'Bloated Abomination - Data set - Cross cast credit'),
(28843,0,2,0,38,0,10,0,0,1,0,0,86,52616,2,23,0,0,0,23,0,0,0,0,0,0,0,'Bloated Abomination - Data set - Cross cast summon Drakkari Chieftain (10% chance)'),
(28844,0,0,1,8,0,100,0,52510,0,0,0,45,0,1,0,0,0,0,7,0,0,0,0,0,0,0,'Drakkari Skullcrusher - Spellhit - Set data'),
(28844,0,1,0,61,0,100,0,0,0,0,0,11,52508,2,0,0,0,0,1,0,0,0,0,0,0,0,'Drakkari Skullcrusher - Spellhit - Cast Burst at the Seams (damage)'),
(28873,0,0,1,54,0,100,0,0,0,0,0,49,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Drakkari Chieftain - Just summoned - Attack summoner'),
(28873,0,1,0,61,0,100,0,0,0,0,0,1,0,3000,0,0,0,0,1,0,0,0,0,0,0,0,'Drakkari Chieftain - Just summoned - Say text'),
(28873,0,2,3,52,0,100,0,0,28873,0,0,12,28759,3,20000,0,0,0,1,0,0,0,0,0,0,0,'Drakkari Chieftain - Text over - Summon Flying Fiend'),
(28873,0,3,4,61,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Drakkari Chieftain - Text over - Say text'),
(28873,0,4,0,61,0,100,0,0,0,0,0,41,15000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Drakkari Chieftain - Text over - Despawn in 15 seconds'),

(28759,0,0,1,54,0,100,0,0,0,0,0,85,46598,2,0,0,0,0,1,0,0,0,0,0,0,0,'Flying Fiend - Just summoned - Invoker ride'),
(28759,0,1,0,61,0,100,0,0,0,0,0,53,0,28759,0,0,0,0,1,0,0,0,0,0,0,0,'Flying Fiend - Just summoned - Start wp');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (52497,52510);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,52497,0,31,0,3,28844,0,0,0,'','Flatulate - Implicit target - Drakkari Skullcrusher'),
(13,2,52497,0,31,0,3,28844,0,0,0,'','Flatulate - Implicit target - Drakkari Skullcrusher'),
(13,2,52510,0,31,0,3,28844,0,0,0,'','Burst at the Seams - Implicit target - Drakkari Skullcrusher');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=52510;
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(52510,52516,1,'');

DELETE FROM `spell_scripts` WHERE `id`=52510;
INSERT INTO `spell_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`) VALUES
(52510,1,15,52508,1);

DELETE FROM `waypoints` WHERE `entry`=28759;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(28759,1,6326.199,-2212.638,335.17147,'Flying Fiend'),
(28759,2,6257.8,-2154.089,363.324280,'Flying Fiend');

DELETE FROM `creature_text` WHERE `entry`=28873;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(28873,0,0,'Die, nasty scourge!',12,0,100,0,0,0,'Drakkari Chieftain'),
(28873,0,1,'I come to avenge my bruddas, mon!',12,0,100,0,0,0,'Drakkari Chieftain'),
(28873,0,2,'Now you gunna die, mon!',12,0,100,0,0,0,'Drakkari Chieftain'),
(28873,0,3,'We gunna drive all da scourge outta Zul''Drak, mon - startin'' with you!',12,0,100,0,0,0,'Drakkari Chieftain'),
(28873,1,0,'Wha?!...',12,0,100,0,0,0,'Drakkari Chieftain'),
(28873,1,1,'Owww!',12,0,100,0,0,0,'Drakkari Chieftain'),
(28873,1,2,'Ooof!',12,0,100,0,0,0,'Drakkari Chieftain'),
(28873,1,3,'Aaah....',12,0,100,0,0,0,'Drakkari Chieftain');
