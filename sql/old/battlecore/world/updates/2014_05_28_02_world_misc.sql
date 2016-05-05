-- Kor'kron Squad Leader
SET @ENTRY := 31833;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,@SOURCETYPE,0,0,4,0,100,1,0,0,0,0,11,15547,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Cast Shoot on Aggro"),
(@ENTRY,@SOURCETYPE,1,0,9,0,100,0,5,30,3500,4100,11,15547,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Cast Shoot"),
(@ENTRY,@SOURCETYPE,2,0,0,0,100,0,3500,4300,15700,16500,11,12551,0,0,0,0,0,5,0,0,0,0.0,0.0,0.0,0.0,"Cast Frost Shot"),
(@ENTRY,@SOURCETYPE,3,0,0,0,100,0,4500,5500,11300,12700,11,15496,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Cast Cleave"),
(@ENTRY,@SOURCETYPE,4,5,19,0,100,0,13301,0,0,0,53,1,3183300,0,0,0,2,1,0,0,0,0.0,0.0,0.0,0.0,"On q accept do wp"),
(@ENTRY,@SOURCETYPE,5,0,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,9,31832,0,10,0.0,0.0,0.0,0.0,"Link set data 1 to soldier"),
(@ENTRY,@SOURCETYPE,6,0,40,0,100,0,9,3183300,0,0,41,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Despawn on wp 9"),
(@ENTRY,@SOURCETYPE,7,0,1,0,100,0,1000,1000,1000,1000,49,2,0,0,0,0,0,9,31746,0,30,0.0,0.0,0.0,0.0,"Auto aggro on near"),
(@ENTRY,@SOURCETYPE,8,0,19,0,100,0,13301,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"On q a talk0"),
(@ENTRY,@SOURCETYPE,9,0,25,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"On reset talk 1"),
(@ENTRY,@SOURCETYPE,10,0,4,0,100,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"on aggro talk 2");

-- Kor'kron Infantry
SET @ENTRY := 31832;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,@SOURCETYPE,0,0,4,0,100,1,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Set Phase 1 on Aggro"),
(@ENTRY,@SOURCETYPE,1,0,4,1,100,1,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stop Moving on Aggro"),
(@ENTRY,@SOURCETYPE,2,0,4,1,100,1,0,0,0,0,11,15547,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Cast Shoot on Aggro"),
(@ENTRY,@SOURCETYPE,3,0,9,1,100,0,5,30,3500,4100,11,15547,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Cast Shoot"),
(@ENTRY,@SOURCETYPE,4,0,9,1,100,0,30,100,100,2000,21,1,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Start Moving when not in Shoot Range"),
(@ENTRY,@SOURCETYPE,5,0,9,1,100,0,9,15,100,2000,21,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stop Moving at 15 Yards"),
(@ENTRY,@SOURCETYPE,6,0,9,1,100,0,0,5,100,2000,21,1,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Start Moving when not in Shoot Range"),
(@ENTRY,@SOURCETYPE,7,0,9,1,100,0,5,30,100,2000,21,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stop Moving when in Shoot Range"),
(@ENTRY,@SOURCETYPE,8,0,2,1,100,1,0,15,0,0,22,2,0,0,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,"At 15% HP -- Set Phase 2"),
(@ENTRY,@SOURCETYPE,9,0,2,2,100,1,0,15,0,0,25,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Flee at 15% HP"),
(@ENTRY,@SOURCETYPE,10,0,7,2,100,1,0,0,0,0,22,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Reset on Evade"),
(@ENTRY,@SOURCETYPE,11,0,2,2,100,1,0,15,0,0,1,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Say Text at 15% HP"),
(@ENTRY,@SOURCETYPE,12,0,0,1,100,0,4500,5500,11300,12700,11,29426,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Cast Heroic Strike"),
(@ENTRY,@SOURCETYPE,13,0,38,0,100,0,0,1,0,0,53,1,3183300,0,0,0,2,1,0,0,0,0.0,0.0,0.0,0.0,"On data set 1 do wp"),
(@ENTRY,@SOURCETYPE,14,0,40,0,100,0,9,3183300,0,0,80,3183200,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"on wp 9 reach add credit"),
(@ENTRY,@SOURCETYPE,15,0,1,0,100,0,1000,1000,1000,1000,49,0,0,0,0,0,0,9,31746,0,30,0.0,0.0,0.0,0.0,"Auto attack");

-- Kor'kron Infantry
SET @ENTRY := 3183200;
SET @SOURCETYPE := 9;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,@SOURCETYPE,0,0,0,0,100,0,0,0,0,0,33,31845,0,0,0,0,0,17,0,100,0,0.0,0.0,0.0,0.0,"Kor'kron Infantry get Credit 31845"),
(@ENTRY,@SOURCETYPE,1,0,0,0,100,0,1500,1500,1500,1500,41,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Kor'kron Infantry Despawn after Credit");

DELETE FROM `waypoints` WHERE  `entry` =3183300;
INSERT INTO `waypoints` (entry, pointid, position_x, position_y, position_z) 
VALUES 
(3183300, 1, 7496.28, 1820.7, 356.884),
(3183300, 2, 7477.58, 1839.43, 379.676),
(3183300, 3, 7445.82, 1840.21, 396.976),
(3183300, 4, 7418.6, 1848.96, 416.636),
(3183300, 5, 7412.98, 1845.67, 421.026),
(3183300, 6, 7403.45, 1821.38, 428.551),
(3183300, 7, 7334.47, 1742.05, 454.717),
(3183300, 8, 7291.88, 1731.59, 469.097),
(3183300, 9, 7178.76, 1721.28, 476.399);

DELETE FROM `creature_text` WHERE `entry` =31833;
INSERT INTO `creature_text` (entry, groupid, id, text, type, language, probability, emote, duration, sound, comment) VALUES 
(31833, 0, 0, 'On your feet, men! Move, move move!', 12, 0, 100, 0, 0, 0, 'Kor''kron Squad Leader'),
(31833, 1, 0, 'Quickly, catch your breaths before we press to the gate!', 12, 0, 100, 0, 0, 0, 'Kor''kron Squad Leader'),
(31833, 2, 0, 'For the horde!', 14, 0, 100, 0, 0, 0, 'Kor''kron Squad Leader'),
(31833, 2, 1, 'You''ve got some fight in you! Blood and honor, friend!', 12, 0, 100, 0, 0, 0, 'Kor''kron Squad Leader');
