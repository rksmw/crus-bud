-- ------------------------------
--  Quest - Thalorien Dawnseeker
-- ------------------------------
SET @THALORIEN := 37205;
SET @MORLEN := 37542;
SET @ZOMBIE := 37538;
SET @GHOUL := 37539;
SET @CRYPT := 37541;

-- Thalorien Dawnseeker remains
UPDATE `creature_template` SET `gossip_menu_id`=56001, `npcflag`=1, `unit_flags`=131840, `dynamicflags`=32, `AIName`='SmartAI' WHERE `entry`=37552;
DELETE FROM `creature_template_addon` WHERE `entry`=37552;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(37552,0,0,7,0,65,'');

DELETE FROM `gossip_menu` WHERE `entry`=56001;
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES (56001,56001);

DELETE FROM `npc_text` WHERE `ID`=56001;
INSERT INTO `npc_text` (`ID`,`text0_0`,`text0_1`,`text1_0`,`text1_1`,`text2_0`,`text2_1`,`text3_0`,`text3_1`,`text4_0`,`text4_1`,`text5_0`,`text5_1`,`text6_0`,`text6_1`,`text7_0`,`text7_1`) VALUES
(56001,"These appear to be the remains of Thalorien Dawnseeker, the last Wielder of Quel'delar",'','','','','','','','','','','','','','','');

DELETE FROM `gossip_menu_option` WHERE `menu_id`=56001;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(56001,0,0,"Examine the remains",1,1,0,0,0,0,'');

DELETE FROM `smart_scripts` WHERE `entryorguid`=37552 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(37552,0,0,1,62,0,100,0,56001,0,0,0,12,@THALORIEN,6,5000,0,0,0,8,0,0,0,11798.02,-7070.79,25.935,5.361713,'Thalorien remains - on gossip - Summon Thalorien Dawnseeker'),
(37552,0,1,2,61,0,100,0,0,0,0,0,12,37211,8,0,0,0,0,8,0,0,0,11804.797852,-7076.939453,25.877527,2.315565,'Thalorien remains - on gossip - Summon Sunwell Defender'), -- Fila 2
(37552,0,2,3,61,0,100,0,0,0,0,0,12,37211,8,0,0,0,0,8,0,0,0,11801.797852,-7078.939453,26.137663,2.315565,'Thalorien remains - on gossip - Summon Sunwell Defender'),
(37552,0,3,4,61,0,100,0,0,0,0,0,12,37211,8,0,0,0,0,8,0,0,0,11799.797852,-7080.939453,26.186699,2.315565,'Thalorien remains - on gossip - Summon Sunwell Defender'),
(37552,0,4,5,61,0,100,0,0,0,0,0,12,37211,8,0,0,0,0,8,0,0,0,11807.797852,-7074.939453,25.877527,2.315565,'Thalorien remains - on gossip - Summon Sunwell Defender'),
(37552,0,5,6,61,0,100,0,0,0,0,0,12,37211,8,0,0,0,0,8,0,0,0,11810.797852,-7072.939453,25.877527,2.315565,'Thalorien remains - on gossip - Summon Sunwell Defender'),
(37552,0,6,7,61,0,100,0,0,0,0,0,12,37211,8,0,0,0,0,8,0,0,0,11802.797852,-7074.939453,25.877527,2.315565,'Thalorien remains - on gossip - Summon Sunwell Defender'), -- Fila 1 
(37552,0,7,8,61,0,100,0,0,0,0,0,12,37211,8,0,0,0,0,8,0,0,0,11799.797852,-7076.939453,26.19614,2.315565,'Thalorien remains - on gossip - Summon Sunwell Defender'),
(37552,0,8,9,61,0,100,0,0,0,0,0,12,37211,8,0,0,0,0,8,0,0,0,11796.797852,-7078.939453,26.223213,2.315565,'Thalorien remains - on gossip - Summon Sunwell Defender'),
(37552,0,9,10,61,0,100,0,0,0,0,0,12,37211,8,0,0,0,0,8,0,0,0,11805.797852,-7072.939453,25.877527,2.315565,'Thalorien remains - on gossip - Summon Sunwell Defender'),
(37552,0,10,11,61,0,100,0,0,0,0,0,12,37211,8,0,0,0,0,8,0,0,0,11808.797852,-7070.939453,25.877527,2.315565,'Thalorien remains - on gossip - Summon Sunwell Defender'),
(37552,0,11,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Thalorien remains - on gossip - Close gossip');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=56001;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,56001,0,0,9,24563,0,0,0,0,'','Thalorien Dawnseeker remains - Show gossip menu if quest accepted'),
(15,56001,0,0,29,@THALORIEN,50,0,1,0,'','Thalorien Dawnseeker remains - Show gossip menu if no Thalorien Near'),
(15,56001,0,1,9,24535,0,0,0,0,'','Thalorien Dawnseeker remains - Show gossip menu if quest accepted'),
(15,56001,0,1,29,@THALORIEN,50,0,1,0,'','Thalorien Dawnseeker remains - Show gossip menu if no Thalorien Near');

-- Thalorien Dawnseeker
UPDATE `creature_template` SET `minlevel`=80, `maxlevel`=80, `faction_A`=2141, `faction_H`=2141, `AIName`='SmartAI', `mindmg`=399, `maxdmg`=559, dmg_multiplier=7.5, `baseattacktime`=2000 WHERE `entry`=@THALORIEN;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@THALORIEN AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@THALORIEN*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@THALORIEN,0,0,0,11,0,100,0,0,530,4080,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Spawn - Set phase 1'),
(@THALORIEN,0,1,0,1,1,100,1,4000,4000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Phase 1 OOC - Say text'),
(@THALORIEN,0,2,0,1,1,100,1,9000,9000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Phase 1 OOC - Say text'),
(@THALORIEN,0,3,0,1,1,100,1,15000,15000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Phase 1 OOC - Say text'),
(@THALORIEN,0,4,0,1,1,100,1,25000,25000,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Phase 1 OOC - Say text'),
(@THALORIEN,0,5,0,1,1,100,1,31000,31000,0,0,53,0,@THALORIEN,0,0,0,1,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Phase 1 OOC - Say text'),
(@THALORIEN,0,6,7,40,1,100,0,1,@THALORIEN,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Waypoint reached - Set phase 2'),
(@THALORIEN,0,7,8,61,0,100,0,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,3.210278,'Thalorien Dawnseeker - Waypoint reached - Set orientation'),
(@THALORIEN,0,8,0,61,0,100,0,0,0,0,0,17,375,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Waypoint reached - State Ready 2H'),
(@THALORIEN,0,9,0,1,2,100,1,1000,1000,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Phase 2 OOC - Set home position'),
(@THALORIEN,0,10,0,1,2,100,1,4000,4000,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Phase 2 OOC - Say text'),
(@THALORIEN,0,11,12,1,2,100,1,12000,12000,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Phase 2 OOC - Say text'),
(@THALORIEN,0,12,13,61,2,100,1,0,0,0,0,12,@MORLEN,6,5000,0,0,0,8,0,0,0,11777.434570,-7053.158691,25.409922,5.554669,'Thalorien Dawnseeker - Phase 2 OOC - Summon Morlen Coldgrip'),
(@THALORIEN,0,13,0,61,2,100,1,0,0,0,0,22,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Phase - Set phase 3'),
(@THALORIEN,0,14,0,0,0,100,0,7000,8000,17000,18000,11,67541,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - In combat - cast bladestorm'),
(@THALORIEN,0,15,0,0,0,100,0,3000,5000,6000,7500,11,29426,0,0,0,0,0,2,0,0,0,0,0,0,0,'Thalorien Dawnseeker - In combat - cast heroic strike'),
(@THALORIEN,0,16,0,0,0,100,0,6000,7000,6000,7500,11,16856,0,0,0,0,0,2,0,0,0,0,0,0,0,'Thalorien Dawnseeker - In combat - cast mortal strike'),
(@THALORIEN,0,17,0,38,0,100,1,0,1,0,0,80,@THALORIEN*100,2,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Set data - Run script'),
(@THALORIEN*100,9,0,0,0,0,100,0,0,0,0,0,45,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Script - Set data self'),
(@THALORIEN*100,9,1,0,0,0,100,0,5000,5000,0,0,17,26,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Script - Emote stand'),
(@THALORIEN*100,9,2,0,0,0,100,0,1000,1000,0,0,33,37601,0,0,0,0,0,18,100,0,0,0,0,0,0,'Thalorien Dawnseeker - Script - Kill credit'),
(@THALORIEN*100,9,3,0,0,0,100,0,3000,3000,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Script- Say text'),
(@THALORIEN*100,9,4,0,0,0,100,0,5000,5000,0,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Script - Say text'),
(@THALORIEN*100,9,5,0,0,0,100,0,9000,9000,0,0,1,8,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Script- Say text'),
(@THALORIEN*100,9,6,0,0,0,100,0,6000,6000,0,0,1,9,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Script - Say text'),
(@THALORIEN*100,9,7,0,0,0,100,0,11000,11000,0,0,5,16,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Script - Emote kneel'),
(@THALORIEN*100,9,8,0,0,0,100,0,4000,4000,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thalorien Dawnseeker - Script - Force despawn');

DELETE FROM `creature_text` WHERE `entry`=@THALORIEN;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@THALORIEN,0,0,"We must defend the Sunwell from the enemy at all costs.",12,0,100,1,3000,16769,'Thalorien Dawnseeker'),
(@THALORIEN,1,0,"I am ordering you to withdraw to the Sunwell proper to help prepare the defenses.",12,0,100,25,3000,16770,'Thalorien Dawnseeker'),
(@THALORIEN,2,0,"I will make my stand here and buy you as much time as I am able. Use it well and make our prince proud.",12,0,100,1,3000,16771,'Thalorien Dawnseeker'),
(@THALORIEN,3,0,"It has been a great honor to fight beside you in defense of our land and our people.",12,0,100,113,100,16772,'Thalorien Dawnseeker'),
(@THALORIEN,4,0,"You, stranger... you are not one of my soldiers. Will you stay and stand with me to face the enemy?",12,0,100,0,10,16773,'Thalorien Dawnseeker'),
(@THALORIEN,5,0,"Listen well, Scourge defilers. None of you will reach the Sunwell so long as I stand!",14,0,100,15,10,16774,'Thalorien Dawnseeker'),
(@THALORIEN,6,0,"I... I wasn't meant to survive this attack.",12,0,100,1,3000,16775,'Thalorien Dawnseeker'),
(@THALORIEN,7,0,"Why has this happened? Why have you come here?",12,0,100,1,3000,16776,'Thalorien Dawnseeker'),
(@THALORIEN,8,0,"It's Quel'Delar! You possess the sword!",12,0,100,1,3000,16777,'Thalorien Dawnseeker'),
(@THALORIEN,9,0,"I don't know how, but the blade has chosen you to be its new wielder. Take it with my blessing, and wield it against the Scourge as I once did.",12,0,100,1,3000,16778,'Thalorien Dawnseeker');

DELETE FROM `waypoints` WHERE `entry`=@THALORIEN;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@THALORIEN,1,11791.1,-7064.34,25.7884,'');

-- Morlen Coldgrip
UPDATE `creature_template` SET `minlevel`=80, `maxlevel`=80, `faction_A`=2212, `faction_H`=2212, `AIName`='SmartAI', `unit_flags`=131842, `mindmg`=422, `maxdmg`=586, dmg_multiplier=7.5, `baseattacktime`=2000 WHERE `entry`=@MORLEN;
DELETE FROM `creature_template_addon` WHERE `entry`=@MORLEN;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(@MORLEN,0,25678,0,1,0,'');

DELETE FROM `smart_scripts` WHERE `entryorguid`=@MORLEN AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@MORLEN,0,0,0,11,0,100,0,0,530,4080,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Morlen Coldgrip - Spawn - Set phase 1'),
(@MORLEN,0,1,0,1,1,100,1,6000,6000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Morlen Coldgrip - Phase 1 OOC - Say text'),
(@MORLEN,0,2,0,1,1,100,1,12000,12000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Morlen Coldgrip - Phase 1 OOC - Say text'),
(@MORLEN,0,3,4,1,1,100,1,15000,15000,0,0,12,37538,6,2000,0,0,0,8,0,0,0,11778.434570,-7059.158691,25.128551,6.267024,'Morlen Coldgrip - Phase 1 OOC - Summon Scourge Zombie'),
(@MORLEN,0,4,5,61,1,100,1,0,0,0,0,12,@ZOMBIE,6,2000,0,0,0,8,0,0,0,11779.434570,-7064.158691,25.128551,6.267024,'Morlen Coldgrip - Phase 1 OOC - Summon Scourge Zombie'),
(@MORLEN,0,5,6,61,1,100,1,0,0,0,0,12,@ZOMBIE,6,2000,0,0,0,8,0,0,0,11780.434570,-7069.158691,25.128551,6.267024,'Morlen Coldgrip - Phase 1 OOC - Summon Scourge Zombie'),
(@MORLEN,0,6,0,61,1,100,1,0,0,0,0,12,@ZOMBIE,6,2000,0,0,0,8,0,0,0,11781.434570,-7074.158691,25.128551,6.267024,'Morlen Coldgrip - Phase 1 OOC - Summon Scourge Zombie'),
(@MORLEN,0,7,0,1,1,100,1,50000,50000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Morlen Coldgrip - Phase 1 OOC - Say text'),
(@MORLEN,0,8,9,1,1,100,1,55000,55000,0,0,12,@GHOUL,6,2000,0,0,0,8,0,0,0,11778.7714,-7059.431641,25.000710,0.147950,'Morlen Coldgrip - Phase 1 OOC - Summon Ghoul Invader'),
(@MORLEN,0,9,10,61,1,100,1,0,0,0,0,12,@GHOUL,6,2000,0,0,0,8,0,0,0,11779.7714,-7062.431641,25.000710,0.147950,'Morlen Coldgrip - Phase 1 OOC - Summon Ghoul Invader'),
(@MORLEN,0,10,11,61,1,100,1,0,0,0,0,12,@GHOUL,6,2000,0,0,0,8,0,0,0,11780.7714,-7065.431641,25.000710,0.147950,'Morlen Coldgrip - Phase 1 OOC - Summon Ghoul Invader'),
(@MORLEN,0,11,12,61,1,100,1,0,0,0,0,12,@GHOUL,6,2000,0,0,0,8,0,0,0,11781.7714,-7068.431641,25.000710,0.147950,'Morlen Coldgrip - Phase 1 OOC - Summon Ghoul Invader'),
(@MORLEN,0,12,0,61,1,100,1,0,0,0,0,12,@GHOUL,6,2000,0,0,0,8,0,0,0,11782.7714,-7071.431641,25.000710,0.147950,'Morlen Coldgrip - Phase 1 OOC - Summon Ghoul Invader'),
(@MORLEN,0,13,0,1,1,100,1,90000,90000,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Morlen Coldgrip - Phase 1 OOC - Say text'),
(@MORLEN,0,14,15,1,1,100,1,95000,95000,0,0,12,@CRYPT,6,2000,0,0,0,8,0,0,0,11764.348633,-7057.431641,25.000710,0.147950,'Morlen Coldgrip - Phase 1 OOC - Summon Crypt Raider'),
(@MORLEN,0,15,16,61,1,100,1,0,0,0,0,12,@CRYPT,6,2000,0,0,0,8,0,0,0,11765.348633,-7065.431641,25.000710,0.147950,'Morlen Coldgrip - Phase 1 OOC - Summon Crypt Raider'),
(@MORLEN,0,16,0,61,1,100,1,0,0,0,0,12,@CRYPT,6,2000,0,0,0,8,0,0,0,11766.348633,-7073.431641,25.000710,0.147950,'Morlen Coldgrip - Phase 1 OOC - Summon Crypt Raider'),
(@MORLEN,0,17,0,1,1,100,1,130000,130000,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,'Morlen Coldgrip - Phase 1 OOC - Say text'),
(@MORLEN,0,18,0,1,1,100,1,135000,135000,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Morlen Coldgrip - Phase 1 OOC - Set phase 2'),
(@MORLEN,0,19,20,1,2,100,1,0,0,0,0,19,131842,0,0,0,0,0,1,0,0,0,0,0,0,0,'Morlen Coldgrip - Phase 2 OOC - Remove unit flags'),
(@MORLEN,0,20,0,61,2,100,1,0,0,0,0,49,0,0,0,0,0,0,11,@THALORIEN,100,0,0,0,0,0,'Morlen Coldgrip - Phase 2 OOC - Attack Thalorien Dawnseeker'),
(@MORLEN,0,21,0,6,0,100,0,0,0,0,0,45,0,1,0,0,0,0,11,@THALORIEN,100,0,0,0,0,0,'Morlen Coldgrip - Death - Set data Thalorien Dawnseeker'),
(@MORLEN,0,22,0,1,1,100,1,1000,1000,0,0,11,50689,1,0,0,0,0,1,0,0,0,0,0,0,0,'Morlen Coldgrip - OOC - Cast blood prescense'),
(@MORLEN,0,23,0,0,2,100,0,1000,2000,5000,6000,11,50688,0,0,0,0,0,2,0,0,0,0,0,0,0,'Morlen Coldgrip - IC - Plague Strike'),
(@MORLEN,0,24,0,5,0,100,0,0,0,0,@THALORIEN,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Morlen Coldgrip - Kill Thalorien Dawnseeker - Despawn');
 
DELETE FROM `creature_text` WHERE `entry`=@MORLEN;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@MORLEN,0,0,"You will fall as your lands and your city have before you. My lord will win a great victory here, and none will remember your name!",14,0,100,0,3000,0,'Morlen Coldgrip'),
(@MORLEN,1,0,"Forward!",14,0,100,0,3000,0,'Morlen Coldgrip'),
(@MORLEN,2,0,"Ghouls, slay this pathetic high elf!",14,0,100,0,3000,0,'Morlen Coldgrip'),
(@MORLEN,3,0,"You will fall before the might of the Scourge. Crypt raiders, attack!",14,0,100,0,3000,0,'Morlen Coldgrip'),
(@MORLEN,4,0,"I shall kill you myself!",14,0,100,0,3000,0,'Morlen Coldgrip');
 
DELETE FROM `creature_text` WHERE `entry`=@MORLEN;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@MORLEN,0,0,"You will fall as your lands and your city have before you. My lord will win a great victory here, and none will remember your name!",14,0,100,0,3000,0,'Morlen Coldgrip'),
(@MORLEN,1,0,"Forward!",14,0,100,0,3000,0,'Morlen Coldgrip'),
(@MORLEN,2,0,"Ghouls, slay this pathetic high elf!",14,0,100,0,3000,0,'Morlen Coldgrip'),
(@MORLEN,3,0,"You will fall before the might of the Scourge. Crypt raiders, attack!",14,0,100,0,3000,0,'Morlen Coldgrip'),
(@MORLEN,4,0,"I shall kill you myself!",14,0,100,0,3000,0,'Morlen Coldgrip');

-- Scourge Zombies, Ghoul Invaders, Crypt Raiders
UPDATE `creature_template` SET `minlevel`=80, `maxlevel`=80, `faction_A`=2212, `faction_H`=2212, `AIName`='SmartAI', `mindmg`=422, `maxdmg`=586, dmg_multiplier=1, `baseattacktime`=2000 WHERE `entry` IN (@ZOMBIE, @GHOUL, @CRYPT);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ZOMBIE, @GHOUL, @CRYPT) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ZOMBIE,0,0,0,0,0,50,0,2000,3000,9000,9000,11,49861,0,0,0,0,0,2,0,0,0,0,0,0,0,'Scourge Zombie - In combat - Infected Bite'),
(@ZOMBIE,0,1,0,11,0,100,0,0,530,4080,0,49,0,0,0,0,0,0,11,@THALORIEN,100,0,0,0,0,0,'Morlen Coldgrip - Spawn - Attack Thalorien Dawnseeker'),
(@GHOUL,0,0,0,0,0,50,0,2000,3000,15000,15000,11,38056,0,0,0,0,0,2,0,0,0,0,0,0,0,'Scourge Zombie - In combat - Infected Bite'),
(@GHOUL,0,1,0,11,0,100,0,0,530,4080,0,49,0,0,0,0,0,0,11,@THALORIEN,100,0,0,0,0,0,'Morlen Coldgrip - Spawn - Attack Thalorien Dawnseeker'),
(@CRYPT,0,0,0,0,0,100,0,0,0,0,0,11,31600,0,0,0,0,0,2,0,0,0,0,0,0,0,'Crypt Raider - In combat - Crypt Scarabs'),
(@CRYPT,0,1,0,11,0,100,0,0,530,4080,0,49,0,0,0,0,0,0,11,@THALORIEN,100,0,0,0,0,0,'Morlen Coldgrip - Spawn - Attack Thalorien Dawnseeker');

-- Sunwell Defenders
UPDATE `creature_template` SET `minlevel`=80, `maxlevel`=80, `faction_A`=2141, `faction_H`=2141, `AIName`='SmartAI' WHERE `entry`=37211;
DELETE FROM `smart_scripts` WHERE `entryorguid`=37211 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(37211,0,0,1,1,0,100,1,30000,30000,0,0,5,66,0,0,0,0,0,1,0,0,0,0,0,0,0,'Sunwell Defender - OOC time - Salute'),
(37211,0,1,0,61,0,100,1,0,0,0,0,41,2000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Sunwell Defender - OOC time - Despawn');
