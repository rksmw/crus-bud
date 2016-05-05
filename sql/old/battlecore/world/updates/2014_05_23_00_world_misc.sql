-- Quest - Betrayal
SET @DRAKURU1 := 28503;
SET @DRAKURU2 := 28998;
SET @LICH := 28498;
SET @BUNNY := 28960;
SET @TROLL := 28931;

-- Overlord Drakuru SAI (este es el que da las quest)
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@DRAKURU1;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@DRAKURU1 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@DRAKURU1,0,0,0,62,0,100,0,9731,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Overlord Drakuru - Gossip select - Close Gossip'),
(@DRAKURU1,0,1,0,62,0,100,0,9731,0,0,0,11,52863,2,0,0,0,0,7,0,0,0,0,0,0,0,'Overlord Drakuru - Gossip select - Cast Drakuru Betrayal Teleport'),
(@DRAKURU1,0,2,0,62,0,100,0,9731,0,0,0,45,0,1,0,0,0,0,10,98865,@BUNNY,0,0,0,0,0,'Overlord Drakuru - Gossip select - Set data generic Bunny');

DELETE FROM `spell_target_position` WHERE `id`=52863;
INSERT INTO `spell_target_position` (`id`,`target_map`,`target_position_x`,`target_position_y`,`target_position_z`,`target_orientation`) VALUES
(52863,571,6161.15,-2015.36,590.878,0);

-- Totally Generic Bunny SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@BUNNY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@BUNNY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@BUNNY,0,0,0,38,0,100,0,0,1,0,0,12,@DRAKURU2,6,3000,0,0,0,8,0,0,0,6177.09,-2018.15,590.877,2.970416,'Totally Generic Bunny - Data set - Summon Drakuru (see conditions)'),
(@BUNNY,0,1,0,38,0,100,0,0,2,0,0,11,51807,2,0,0,0,0,1,0,0,0,0,0,0,0,'Totally Generic Bunny - Data set - Cast Arthas Portal'),
(@BUNNY,0,2,0,8,0,100,0,54250,0,0,0,11,54253,2,0,0,0,0,1,0,0,0,0,0,0,0,'Totally Generic Bunny - Spellhit - Cast Spawn Drakuru''s Skull');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@BUNNY AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(22,1,@BUNNY,0,0,29,1,@DRAKURU2,100,0,1,0,'','Totally Generic Bunny - Summon Drakuru if not near Drakuru'),
(22,1,@BUNNY,0,0,30,1,191458,100,0,1,0,'','Totally Generic Bunny - Summon Drakuru if not near Drakuru Skull');

-- Overlord Drakuru SAI (contra este se lucha)
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_A`=974, `faction_H`=974 WHERE `entry`=@DRAKURU2;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@DRAKURU2 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@DRAKURU2*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@DRAKURU2,0,0,0,54,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Drakuru - Just summoned - Set phase 1'),
(@DRAKURU2,0,1,0,1,1,100,1,12000,12000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Drakuru - OOC (phase 1) - Say text'),
(@DRAKURU2,0,2,3,1,1,100,1,20000,20000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Drakuru - OOC (phase 1) - Say text'),
(@DRAKURU2,0,3,4,61,1,100,1,0,0,0,0,12,@TROLL,6,5000,0,0,0,8,0,0,0,6222.86,-2026.53,586.759,2.598638,'Overlord Drakuru - OOC (phase 1) - Summon Blightblood Troll'),
(@DRAKURU2,0,4,5,61,1,100,1,0,0,0,0,12,@TROLL,6,5000,0,0,0,8,0,0,0,6184.2,-1969.86,586.759,4.078330,'Overlord Drakuru - OOC (phase 1) - Summon Blightblood Troll'),
(@DRAKURU2,0,5,6,61,1,100,1,0,0,0,0,12,@TROLL,6,5000,0,0,0,8,0,0,0,6127.48,-2008.54,586.759,5.861971,'Overlord Drakuru - OOC (phase 1) - Summon Blightblood Troll'),
(@DRAKURU2,0,6,0,61,1,100,1,0,0,0,0,12,@TROLL,6,5000,0,0,0,8,0,0,0,6166.17,-2065.31,586.759,1.056119,'Overlord Drakuru - OOC (phase 1) - Summon Blightblood Troll'),
(@DRAKURU2,0,7,0,4,0,100,0,0,0,0,0,11,54104,34,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Drakuru - Just summoned - Cast Debuff aura'),
(@DRAKURU2,0,8,0,4,0,100,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Drakuru - Aggro - Say text'),
(@DRAKURU2,0,9,0,4,0,100,0,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Drakuru - Aggro - Disable combat move'),
(@DRAKURU2,0,10,0,4,0,100,0,0,0,0,0,42,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Drakuru - Aggro - Set Invincibility at 1 hp'),
(@DRAKURU2,0,11,0,0,0,100,0,0,0,5000,7000,11,54113,0,0,0,0,0,2,0,0,0,0,0,0,0,'Overlord Drakuru - In combat - Cast Shadow Bolt'),
(@DRAKURU2,0,12,0,0,0,100,0,10000,15000,6000,15000,11,54087,1,0,0,0,0,6,0,0,0,0,0,0,0,'Overlord Drakuru - In combat - Cast Throw Blight Crystal'),
(@DRAKURU2,0,13,0,0,0,100,0,10000,15000,20000,25000,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Drakuru - In combat - Say random text'),
(@DRAKURU2,0,14,0,2,0,100,1,0,3,0,0,80,@DRAKURU2*100,2,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Drakuru - Health below 3% - Run script'),
(@DRAKURU2,0,15,0,38,0,100,0,0,1,0,0,11,54250,2,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Drakuru - Data set - Cast Drakuru Skull Missile'),
(@DRAKURU2,0,16,0,38,0,100,0,0,2,0,0,51,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Drakuru - Data set - Die'),
(@DRAKURU2,0,17,18,1,0,100,1,120000,120000,0,0,51,0,0,0,0,0,0,11,@TROLL,50,0,0,0,0,0,'Overlord Drakuru - 2 minutes OOC - Kill all Blightblood Trolls'),
(@DRAKURU2,0,18,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Drakuru - 2 minutes OOC - Despawn'),
(@DRAKURU2*100,9,0,0,0,0,100,0,0,0,0,0,28,54104,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Drakuru - Script - Remove Debuff'),
(@DRAKURU2*100,9,1,0,0,0,100,0,0,0,0,0,51,0,0,0,0,0,0,11,@TROLL,50,0,0,0,0,0,'Overlord Drakuru - Script - Kill all Blightblood Trolls'),
(@DRAKURU2*100,9,2,0,0,0,100,0,0,0,0,0,18,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Drakuru - Script - Set unit flags'),
(@DRAKURU2*100,9,3,0,0,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Drakuru - Script - React passive'),
(@DRAKURU2*100,9,4,0,0,0,100,0,100,100,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Drakuru - Script - Evade'),
(@DRAKURU2*100,9,5,0,0,0,100,0,0,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Drakuru - Script - Say text'),
(@DRAKURU2*100,9,6,0,0,0,100,0,6000,6000,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Drakuru - Script - Say text'),
(@DRAKURU2*100,9,7,0,0,0,100,0,1000,1000,0,0,45,0,2,0,0,0,0,10,98914,@BUNNY,0,0,0,0,0,'Overlord Drakuru - Script - Set data Bunny'),
(@DRAKURU2*100,9,8,0,0,0,100,0,1000,1000,0,0,12,@LICH,7,0,0,0,0,8,0,0,0,6147.79,-2012.28,590.87,6.09,'Overlord Drakuru - Script - Summon The Lich King'),
(@DRAKURU2*100,9,9,0,0,0,100,0,100,100,0,0,45,0,2,0,0,0,0,19,@LICH,100,0,0,0,0,0,'Overlord Drakuru - Script - Set data The Lich King');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@DRAKURU2 AND `SourceId`=0;
DELETE FROM `creature_template_addon` WHERE `entry`=@DRAKURU2;

DELETE FROM `creature_text` WHERE `entry`=@DRAKURU2;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@DRAKURU2,0,0,'Behold, mon! We be creatin'' da greatest Scourge army ever seen!',12,0,100,1,0,14023,'Overlord Drakuru - Quest Betrayal'),
(@DRAKURU2,1,0,'These be da first of many! We shall sweep across Zul''Drak like da wind....',12,0,100,1,0,14024,'Overlord Drakuru - Quest Betrayal'),
(@DRAKURU2,2,0,'What treachery is this?! You be payin'' for this deceit with your life, mon!',12,0,100,0,0,14025,'Overlord Drakuru - Quest Betrayal'),
(@DRAKURU2,3,0,'Your betrayal not gunna be slowin'' me down none, mon.',14,0,100,0,0,14030,'Overlord Drakuru - Quest Betrayal'),
(@DRAKURU2,3,1,'Ya done turned your back on destiny, mon. Now you gonna die!',14,0,100,0,0,14029,'Overlord Drakuru - Quest Betrayal'),
(@DRAKURU2,3,2,'I never needed ya, mon. I can crush Zul''Drak without ya!',14,0,100,0,0,14031,'Overlord Drakuru - Quest Betrayal'),
(@DRAKURU2,3,3,'Fool! Ya coulda been havin'' great power, mon!',14,0,100,0,0,14026,'Overlord Drakuru - Quest Betrayal'),
(@DRAKURU2,3,4,'How could dis be? Da Lich King said he be havin'' great plans for you, mon...',14,0,100,0,0,14027,'Overlord Drakuru - Quest Betrayal'),
(@DRAKURU2,3,5,'I shoulda known not to be trustin'' nobody!',14,0,100,0,0,14028,'Overlord Drakuru - Quest Betrayal'),
(@DRAKURU2,4,0,'ENOUGH!',14,0,100,0,0,14020,'Overlord Drakuru - Quest Betrayal'),
(@DRAKURU2,5,0,'Dis foolish treachery has cost ya your destiny!',14,0,100,1,0,14021,'Overlord Drakuru - Quest Betrayal'),
(@DRAKURU2,6,0,'Master, dis mortal scum be double-crossin'' us. Dey must be made to suffer!',12,0,100,1,0,14022,'Overlord Drakuru - Quest Betrayal');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=54250;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,54250,0,0,31,0,3,@BUNNY,0,0,0,'','Drakuru Skull Missile - Implicit target - Totally Generic Bunny'),
(13,1,54250,0,0,31,0,1,15,4,0,0,'','Drakuru Skull Missile - Implicit target - 15 yards');

-- The Lich King SAI
DELETE FROM `smart_scripts` WHERE `entryorguid`=@LICH AND `source_type`=0 AND `id`=2;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@LICH*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@LICH,0,2,0,38,0,100,1,0,2,0,0,80,@LICH*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Data set - Run script'),
(@LICH*100,9,0,0,0,0,100,0,0,0,0,0,46,12,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Script - Walk 12 yards'),
(@LICH*100,9,1,0,0,0,100,0,7000,7000,0,0,1,6,0,0,0,0,0,19,@DRAKURU2,30,0,0,0,0,0,'The Lich King - Script - Say text'),
(@LICH*100,9,2,0,0,0,100,0,10000,10000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Script - Say text'),
(@LICH*100,9,3,0,0,0,100,0,8000,8000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Script - Say text'),
(@LICH*100,9,4,0,0,0,100,0,8000,8000,0,0,11,51825,0,0,0,0,0,19,@DRAKURU2,30,0,0,0,0,0,'The Lich King - Script - Cast Arthas Scourge Drakuru'),
(@LICH*100,9,5,0,0,0,100,0,3000,3000,0,0,45,0,1,0,0,0,0,19,@DRAKURU2,30,0,0,0,0,0,'The Lich King - Script - Set data Drakuru'),
(@LICH*100,9,6,0,0,0,100,0,100,100,0,0,45,0,2,0,0,0,0,19,@DRAKURU2,30,0,0,0,0,0,'The Lich King - Script - Set data Drakuru'),
(@LICH*100,9,7,0,0,0,100,0,3000,3000,0,0,66,0,0,0,0,0,0,21,30,0,0,0,0,0,0,'The Lich King - Script - Face Closest Player'),
(@LICH*100,9,8,0,0,0,100,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Script - Say text'),
(@LICH*100,9,9,0,0,0,100,0,5000,5000,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Script - Say text'),
(@LICH*100,9,10,0,0,0,100,0,14000,14000,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Script - Say text'),
(@LICH*100,9,11,0,0,0,100,0,6000,6000,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Script - Say text'),
(@LICH*100,9,12,0,0,0,100,0,6000,6000,0,0,66,2.939581,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Script - Say text'),
(@LICH*100,9,13,0,0,0,100,0,100,100,0,0,69,0,0,0,0,0,0,8,0,0,0,6147.79,-2012.28,590.87,6.09,'The Lich King - Script - Return to original position'),
(@LICH*100,9,14,0,0,0,100,0,4500,4500,0,0,28,0,0,0,0,0,0,10,98914,@BUNNY,0,0,0,0,0,'The Lich King - Script - Remove Arthas Portal Aura'),
(@LICH*100,9,15,0,0,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Script - Despawn');

DELETE FROM `creature_text` WHERE `entry`=@LICH;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@LICH,0,0,'You have failed me, Drakuru!',12,0,100,1,0,14762,'The Lich King - Quest Betrayal'),
(@LICH,1,0,'It is you who should suffer. Be content that your death is a quick one....',12,0,100,25,0,14763,'The Lich King - Quest Betrayal'),
(@LICH,2,0,'As for you...',12,0,100,25,0,14764,'The Lich King - Quest Betrayal'),
(@LICH,3,0,'I spare your insignificant life as a reward for this amusing betrayal. There may yet be a shred of potential in you.',12,0,100,378,0,14765,'The Lich King - Quest Betrayal'),
(@LICH,4,0,'Be warned...',12,0,100,1,0,14766,'The Lich King - Quest Betrayal'),
(@LICH,5,0,'When next we meet I shall require much more to justify your life.',12,0,100,1,0,14767,'The Lich King - Quest Betrayal');

-- Blightblood Troll SAI
UPDATE `creature_template` SET `AIName`='SmartAI', `spell1`=54135, `spell2`=54132, `spell3`=54136 WHERE `entry`=@TROLL;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@TROLL AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@TROLL,0,0,0,54,0,100,0,0,0,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,'Blightblood Troll - Just summoned - Remove unit flags'),
(@TROLL,0,1,0,54,0,100,0,0,0,0,0,8,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Blightblood Troll - Just summoned - React deffensive');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=39664;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17,0,39664,0,0,1,0,51966,0,0,1,0,'','Scepter of domination cannot be used with plague disguise');

-- Drakuru' Last Wish teleport spell
DELETE FROM `spell_target_position` WHERE `id`=57553;
INSERT INTO `spell_target_position` (`id`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
(57553,571,5875.43,-1981.37,234.671,0);