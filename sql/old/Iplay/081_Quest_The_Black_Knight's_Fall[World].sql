-- --------------------------------
-- Quest - The Black Knight's Fall
-- --------------------------------

-- The Black Knight SAI
SET @ENTRY := 33785; -- The Black Knight
SET @MOUNT := 28652; -- Black Knight's Gryphon
SET @SPELL1 := 64505; -- Spell Dark Shield
SET @SPELL2 := 64490; -- Spell Black Knight Transform
SET @SPELL3 := 64498; -- Spell Black Knight Transform 2

UPDATE `creature_template` SET `speed_walk`=`speed_run`, `faction_A`=14, `faction_H`=14, `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,1,0,571,210,0,43,0,@MOUNT,0,0,0,0,1,0,0,0,0,0,0,0,'The Black Knight - Summon - Mount to Gryphon model'),
(@ENTRY,0,1,2,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Black Knight - Aggro - Say Text'),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Black Knight - Aggro - Set phase 1'),
(@ENTRY,0,3,0,9,1,100,0,10,30,10000,10000,11,65147,3,0,0,0,0,2,0,0,0,0,0,0,0,'The Black Knight - Distance - Cast Shield-Breaker'),
(@ENTRY,0,4,0,9,1,100,0,8,25,7000,7000,11,63010,2,0,0,0,0,2,0,0,0,0,0,0,0,'The Black Knight - Distance - Cast Charge'),
(@ENTRY,0,5,0,0,1,100,0,10000,10000,10000,20000,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Black Knight - In combat - flee'),
(@ENTRY,0,6,7,2,1,100,1,0,15,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Black Knight - 15% HP - Disable attack'),
(@ENTRY,0,7,8,61,1,100,1,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Black Knight - 15% HP - Disable movement'),
(@ENTRY,0,8,9,61,1,100,1,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Black Knight - 15% HP - Set phase 2'),
(@ENTRY,0,9,10,61,2,100,1,0,15,0,0,43,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Black Knight - 15% HP - Dismount'),
(@ENTRY,0,10,11,61,2,100,1,0,0,0,0,11,@SPELL2,3,0,0,0,0,1,0,0,0,0,0,0,0,'The Black Knight - 15% HP - Cast spell transform'),
(@ENTRY,0,11,12,61,2,100,1,0,0,0,0,11,@SPELL1,3,0,0,0,0,1,0,0,0,0,0,0,0,'The Black Knight - 15% HP - Cast Dark Shield'),
(@ENTRY,0,12,13,61,2,100,1,0,0,0,0,28,63151,0,0,0,0,0,7,0,0,0,0,0,0,0,'The Black Knight - 15% HP - Remove Mounted Aura Invoker'),
(@ENTRY,0,13,0,61,2,100,1,0,0,0,0,1,1,8000,0,0,0,0,1,0,0,0,0,0,0,0,'The Black Knight - 15% HP - Say text'),
(@ENTRY,0,14,15,52,2,100,1,1,@ENTRY,0,0,11,@SPELL3,3,0,0,0,0,1,0,0,0,0,0,0,0,'The Black Knight - Text Over - Cast transform'),
(@ENTRY,0,15,0,61,2,100,1,0,0,0,0,1,2,3000,0,0,0,0,1,0,0,0,0,0,0,0,'The Black Knight - Text Over - Say text'),
(@ENTRY,0,16,17,52,2,100,1,1,@ENTRY,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Black Knight - Text Over - Allow combat movement'),
(@ENTRY,0,17,0,61,2,100,1,0,0,0,0,20,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Black Knight - Text Over - Allow attack');

DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Enough of this insolence! Prepare to die!",12,0,100,0,3,0,'The Black Knight Aggro'),
(@ENTRY,1,0,"Get off that horse and fight me man-to-man!",14,0,100,0,3,0,'The Black Knight 15% HP'),
(@ENTRY,2,0,"I will not fail you, master!",14,0,100,0,3,0,'The Black Knight phase 2');

-- Squire Cavin SAI
SET @CAVIN := 33522;
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@CAVIN;

DELETE FROM `gossip_menu_option` WHERE `menu_id`=10383;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(10383,0,0,'Ask Cavin to summon the Black Knight',1,1,0,0,0,0,NULL);

DELETE FROM `smart_scripts` WHERE `entryorguid`=@CAVIN AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@CAVIN,0,0,1,62,0,100,0,10383,0,0,0,12,@ENTRY,8,0,0,0,0,8,0,0,0,8410.7656,965.9083,544.6740,6.222,'Squire Cavin - Gossip select - Summon The Black Knight'),
(@CAVIN,0,1,2,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Squire Cavin - Gossip select - Say text'),
(@CAVIN,0,2,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Squire Cavin - Gossip select - Close Gossip');

DELETE FROM `creature_text` WHERE `entry`=@CAVIN;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@CAVIN,0,0,"Good luck, $n",12,0,100,0,3,0,'Squire Cavin');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=10383;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15,10383,0,0,0,1,0,63034,0,0,0,0,'','Squire Cavin show gossip if player mounted'),
(15,10383,0,0,0,9,0,13664,0,0,0,0,'','Squire Cavin show gossip if player quest taken');

-- Stabled Argent Warhorse
DELETE FROM `creature` WHERE `id`=33870;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(NULL, 33870, 571, 1, 1, 0, 0, 8484.8, 909.686, 547.293, 3.11573, 300, 0, 0, 50000, 0, 0, 0, 0, 0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=18 AND `SourceGroup`=33870;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(18,33870,63663,0,0,9,0,13664,0,0,0,0,'','Stabled Argent Warhorse - spellclick if player quest taken');
