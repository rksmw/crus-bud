-- Quest - Steamtank Surprise
SET @TANK := 27587;
SET @GNOME := 27163;
SET @VAGON := 27607;
SET @ELITE := 27588;
UPDATE `creature_template` SET `unit_flags`=unit_flags&~33554432, `spell1`=49315, `spell2`=49333, `spell3`=49109, `spell4`=49081, `ScriptName`='npc_alliance_steam_tank' WHERE `entry`=@TANK;
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=@TANK;
INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`cast_flags`,`user_type`) VALUES
(@TANK,49078,1,0);

DELETE FROM `vehicle_template_accessory` WHERE `entry`=@TANK;
INSERT INTO `vehicle_template_accessory` VALUES
(@TANK,@ELITE,2,1,'',7,0),
(@TANK,@ELITE,3,1,'',7,0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=16 AND `SourceEntry`=@TANK;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry` IN (49081,49109);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=49333;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(16,0,@TANK,0,0,23,0,4188,0,0,0,0,'','Dismount player when not in intended zone'),
(16,0,@TANK,0,1,23,0,4190,0,0,0,0,'','Dismount player when not in intended zone'),
(16,0,@TANK,0,2,23,0,4246,0,0,0,0,'','Dismount player when not in intended zone'),
(17,0,49081,0,0,23,0,4246,0,0,0,0,'','Drop Off Soldier can only be casted in intended zone'),
(17,0,49109,0,0,29,0,@VAGON,10,0,0,0,'','Drop Off Gnome can only be casted near Plague Wagon'),
(17,0,49109,0,0,29,0,@GNOME,20,0,1,0,'','Drop Off Gnome can only be casted not near 7th Legion Siege Engineer'),
(17,0,49109,0,0,30,0,189970,20,0,1,0,'','Drop Off Gnome can only be casted not near Scourge Discombobulater'),
(13,1,49333,0,0,31,0,3,27288,0,0,0,'','Ice Prison - Implicit target - Death Knight Champion'),
(13,1,49333,0,1,31,0,3,27410,0,0,0,'','Ice Prison - Implicit target - Scourge Siegesmith'),
(13,1,49333,0,2,31,0,3,27286,0,0,0,'','Ice Prison - Implicit target - Dreadbone Invader'),
(13,1,49333,0,3,31,0,3,27283,0,0,0,'','Ice Prison - Implicit target - Risen Wintergarde Mage');

-- 7th Legion Siege Engineer SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@GNOME;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GNOME AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GNOME*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@GNOME,0,0,0,54,0,100,0,0,0,0,0,80,@GNOME*100,2,0,0,0,0,1,0,0,0,0,0,0,0,'7th Legion Siege Engineer - Just Summoned - Run script'),
(@GNOME,0,1,0,6,0,100,0,0,0,0,0,28,49215,0,0,0,0,0,19,@VAGON,20,0,0,0,0,0,'7th Legion Siege Engineer - Death - Remove self Destruct aura'),
(@GNOME*100,9,0,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,19,@VAGON,20,0,0,0,0,0,'7th Legion Siege Engineer - Script - Face Plague Wagon'),
(@GNOME*100,9,1,0,0,0,100,0,1000,1000,0,0,46,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'7th Legion Siege Engineer - Script - Walk 1 yard'),
(@GNOME*100,9,2,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'7th Legion Siege Engineer - Script - Say text'),
(@GNOME*100,9,3,0,0,0,100,0,5000,5000,0,0,66,0,0,0,0,0,0,19,@VAGON,20,0,0,0,0,0,'7th Legion Siege Engineer - Script - Face Plague Wagon'),
(@GNOME*100,9,4,0,0,0,100,0,0,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'7th Legion Siege Engineer - Script - Set home position'),
(@GNOME*100,9,5,0,0,0,100,0,0,0,0,0,17,69,0,0,0,0,0,1,0,0,0,0,0,0,0,'7th Legion Siege Engineer - Script - Set emote state'),
(@GNOME*100,9,6,0,0,0,100,0,0,0,0,0,11,49114,2,0,0,0,0,1,0,0,0,0,0,0,0,'7th Legion Siege Engineer - Script - Cast Place Scourge Discombobulater'),
(@GNOME*100,9,7,0,0,0,100,0,0,0,0,0,11,49215,2,0,0,0,0,19,@VAGON,20,0,0,0,0,0,'7th Legion Siege Engineer - Script -  Cast Start Self-Destruct Sequence'),
(@GNOME*100,9,8,0,0,0,100,0,10000,10000,0,0,33,27625,0,0,0,0,0,7,0,0,0,0,0,0,0,'7th Legion Siege Engineer - Script -  Give credit'),
(@GNOME*100,9,9,0,0,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'7th Legion Siege Engineer - Script -  Despawn');

-- Plague Wagon SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@VAGON;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@VAGON AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@VAGON,0,0,0,8,0,100,0,49218,0,0,0,51,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Plague Wagon - Spellhit - Die');

-- Texts
DELETE FROM `creature_text` WHERE `entry` IN (@GNOME,@ELITE);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@GNOME,0,0,"Cover me!",12,0,100,0,0,0, "7th Legion Siege Engineer"),
(@GNOME,0,1,"Did I ever tell you soldiers about the time I destroyed the Thandol Span? Yep, weren't no dark irons destroyed that bridge! Was me!",12,0,100,0,0,0, "7th Legion Siege Engineer"),
(@GNOME,0,2,"I used to know a dwarf that claimed gnomes evolved from beneath the earth. That we all started out as sand gnomes. What a load of nonsense! Sand gnomes? PUH-LEASE!",12,0,100,0,0,0, "7th Legion Siege Engineer"),
(@GNOME,0,3,"Keep 'em off me for about 15 seconds and this thing is as good as dead.",12,0,100,0,0,0, "7th Legion Siege Engineer"),
(@GNOME,0,4,"Keep the bad guys off me!",12,0,100,0,0,0, "7th Legion Siege Engineer"),
(@GNOME,0,5,"That oughta do it! Just a few more seconds now.",12,0,100,0,0,0, "7th Legion Siege Engineer"),
(@GNOME,0,6,"When I'm done with this plague wagon it'll look like a goblin built it! Keep me safe!",12,0,100,0,0,0, "7th Legion Siege Engineer"),
(@ELITE,0,0,"Driver, I hear you single handedly airlifted our villagers out of this hell-hole. Is that true?",12,0,100,0,0,0, "7th Legion Elite"),
(@ELITE,0,1,"For the Alliance and Lord Fordragon!",12,0,100,0,0,0, "7th Legion Elite"),
(@ELITE,0,2,"Great driving, soldier! Not a scratch on us!",12,0,100,0,0,0, "7th Legion Elite"),
(@ELITE,0,3,"HOO-WAH! The cavalry has arrived!",12,0,100,0,0,0, "7th Legion Elite"),
(@ELITE,0,4,"If I don't make it back to Wintergarde, let my family know that I did my best and that I love them...",12,0,100,0,0,0, "7th Legion Elite"),
(@ELITE,0,5,"Without you we'd be lost. Thanks for the ride!",12,0,100,0,0,0, "7th Legion Elite");
