-- Quest - Tirion's Gambit
SET @TIRION := 32239;
SET @CRUSADER := 32241;
SET @ZEALOT := 32175;
SET @BASALEPH := 32272;
SET @LICH := 32184;
SET @KNIGHT := 32309;
SET @MOGRAINE := 32312;
SET @KOLTIRA := 32311;
SET @THASSARIAN := 32310;
SET @COSMET := 24042;
SET @FROZEN_HEART := 193794;
SET @ESCAPE_PORTAL := 193941;
SET @SPELL_TIRION_SMASHES_HEART := 60456;
SET @SPELL_HEART_EXPLOSION := 60484;
SET @SPELL_LICH_KINGS_FURY := 60536;
SET @SPELL_CULTIST_HOOD := 61131;
SET @SPELL_HEART_EXPLOSION_EFFECTS := 60532;
SET @SPELL_TIRIONS_GAMBIT_EVENT_CREDIT := 61487;
SET @GOSSIP := 56058;

DELETE FROM `creature` WHERE `id` IN (@TIRION,@CRUSADER,@BASALEPH);
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`curhealth`,`curmana`) VALUES
(@TIRION,571,1,1,6239.6,2659.06,570.25,0.532619,300,2789000,4258),
(@CRUSADER,571,1,1,6251.89,2656.13,570.25,2.36652,300,63000,19970),
(@CRUSADER,571,1,1,6252.87,2666,570.25,3.65458,300,63000,19970),
(@CRUSADER,571,1,1,6243.31,2667.88,570.25,5.12327,300,63000,19970),
(@BASALEPH,571,1,1,6131.26,2763.73,573.997,5.13127,300,126000,19970);

-- Highlord Tirion Fordring SAI
SET @CRUSADER_GUID := (SELECT `guid` FROM `creature` WHERE `id`=@CRUSADER ORDER BY `guid` LIMIT 1);
UPDATE `creature_template` SET `npcflag`=1, `gossip_menu_id`=@GOSSIP, `faction_A`=2070, `faction_H`=2070, `AIName`='SmartAI', `rank`=1 WHERE `entry`=@TIRION;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@TIRION AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@TIRION*100,@TIRION*100+1,@TIRION*100+2) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@TIRION,0,0,0,25,0,100,0,0,0,0,0,82,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Reset - Set gossip flag"),
(@TIRION,0,1,0,25,0,100,0,0,0,0,0,71,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Reset - Remove Ashbringer"),
(@TIRION,0,2,3,62,0,100,0,@GOSSIP,0,0,0,1,0,4000,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Gossip select - Say text"),
(@TIRION,0,3,6,61,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Gossip select - Set phase 1"),
(@TIRION,0,4,5,62,0,100,0,@GOSSIP,1,0,0,1,0,4000,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Gossip select - Say text"),
(@TIRION,0,5,6,61,0,100,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Gossip select - Set phase 2"),
(@TIRION,0,6,7,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,10,@CRUSADER_GUID,@CRUSADER,0,0,0,0,0,"Highlord Tirion Fordring - Gossip select - Set data Disguised Crusader"),
(@TIRION,0,7,8,61,0,100,0,0,0,0,0,45,0,2,0,0,0,0,10,@CRUSADER_GUID+1,@CRUSADER,0,0,0,0,0,"Highlord Tirion Fordring - Gossip select - Set data Disguised Crusader"),
(@TIRION,0,8,9,61,0,100,0,0,0,0,0,45,0,3,0,0,0,0,10,@CRUSADER_GUID+2,@CRUSADER,0,0,0,0,0,"Highlord Tirion Fordring - Gossip select - Set data Disguised Crusader"),
(@TIRION,0,9,10,61,0,100,0,0,0,0,0,83,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Gossip select - Remove gossip flag"),
(@TIRION,0,10,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Gossip select - Close gossip"),
(@TIRION,0,11,0,52,0,100,0,0,@TIRION,0,0,53,0,@TIRION*10,0,0,0,1,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Text over - Wp start"),
(@TIRION,0,12,0,40,0,100,0,4,@TIRION*10,0,0,54,8000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Wp reached - Wp pause"),
(@TIRION,0,13,14,56,0,100,0,4,@TIRION*10,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Wp resumed - Say text"),
(@TIRION,0,14,15,61,0,100,0,0,0,0,0,45,0,4,0,0,0,0,10,@CRUSADER_GUID,@CRUSADER,0,0,0,0,0,"Highlord Tirion Fordring - Wp resumed - Set data Disguised Crusader"),
(@TIRION,0,15,16,61,0,100,0,0,0,0,0,45,0,5,0,0,0,0,10,@CRUSADER_GUID+1,@CRUSADER,0,0,0,0,0,"Highlord Tirion Fordring - Wp resumed - Set data Disguised Crusader"),
(@TIRION,0,16,0,61,0,100,0,0,0,0,0,45,0,6,0,0,0,0,10,@CRUSADER_GUID+2,@CRUSADER,0,0,0,0,0,"Highlord Tirion Fordring - Wp resumed - Set data Disguised Crusader"),
(@TIRION,0,17,0,40,0,100,0,11,@TIRION*10,0,0,80,@TIRION*100,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Wp reached - Run script"),
(@TIRION,0,18,0,38,0,100,0,0,1,0,0,1,3,7000,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Data set - Say text"),
(@TIRION,0,19,0,52,0,100,0,3,@TIRION,0,0,1,4,1000,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Text over - Say text"),
(@TIRION,0,20,21,52,0,100,0,4,@TIRION,0,0,12,@LICH,7,0,0,0,0,8,0,0,0,6168.637,2683.512,573.9148,2.02562,"Highlord Tirion Fordring - Text over - Summon The Lich King"),
(@TIRION,0,21,0,61,0,100,0,0,0,0,0,66,0,0,0,0,0,0,19,@LICH,100,0,0,0,0,0,"Highlord Tirion Fordring - Text over - Face The Lich King"),
(@TIRION,0,22,23,38,0,100,0,0,2,0,0,71,546,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Data set - Equip Ashbringer"),
(@TIRION,0,23,0,61,0,100,0,0,0,0,0,53,0,@TIRION*10+1,0,0,0,1,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Data set - Wp start"),
(@TIRION,0,24,0,40,1,100,0,2,@TIRION*10+1,0,0,80,@TIRION*100+1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Wp reached - Run script"),
(@TIRION,0,25,0,40,2,100,0,2,@TIRION*10+1,0,0,80,@TIRION*100+2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Wp reached - Run script"),
(@TIRION,0,26,27,38,0,100,0,2,1,0,0,91,7,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Data set - Remove bytes 1"),
(@TIRION,0,27,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Data set - Despawn"),

(@TIRION*100,9,0,0,0,0,100,0,6000,6000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Script - Say text"),
(@TIRION*100,9,1,0,0,0,100,0,3000,3000,0,0,45,0,1,0,0,0,0,19,@BASALEPH,50,0,0,0,0,0,"Highlord Tirion Fordring - Script - Set data High Invoker Basaleph"),

(@TIRION*100+1,9,0,0,0,0,100,0,10000,10000,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Script - Say text"),
(@TIRION*100+1,9,1,0,0,0,100,0,5000,5000,0,0,1,2,0,0,0,0,0,19,@LICH,30,0,0,0,0,0,"Highlord Tirion Fordring - Script - Say text"),
(@TIRION*100+1,9,2,0,0,0,100,0,12000,12000,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Script - Say text"),
(@TIRION*100+1,9,3,0,0,0,100,0,5000,5000,0,0,1,3,0,0,0,0,0,19,@LICH,30,0,0,0,0,0,"Highlord Tirion Fordring - Script - Say text"),
(@TIRION*100+1,9,4,0,0,0,100,0,8000,8000,0,0,1,4,0,0,0,0,0,19,@LICH,30,0,0,0,0,0,"Highlord Tirion Fordring - Script - Say text"),
(@TIRION*100+1,9,5,0,0,0,100,0,4000,4000,0,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Script - Say text"),
(@TIRION*100+1,9,6,0,0,0,100,0,15000,15000,0,0,1,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Script - Say text"),
(@TIRION*100+1,9,7,0,0,0,100,0,4000,4000,0,0,11,@SPELL_TIRION_SMASHES_HEART,0,0,0,0,0,19,@COSMET,50,0,0,0,0,0,"Highlord Tirion Fordring - Script - Cast Tirion Smashes Heart"),
(@TIRION*100+1,9,8,0,0,0,100,0,2000,2000,0,0,90,7,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Script - Play dead"),
(@TIRION*100+1,9,9,0,0,0,100,0,0,0,0,0,45,0,1,0,0,0,0,19,@COSMET,50,0,0,0,0,0,"Highlord Tirion Fordring - Script - Set data cosmetic trigger"),
(@TIRION*100+1,9,10,0,0,0,100,0,0,0,0,0,45,0,7,0,0,0,0,10,@CRUSADER_GUID,@CRUSADER,0,0,0,0,0,"Highlord Tirion Fordring - Script - Set data Disguised Crusader"),
(@TIRION*100+1,9,11,0,0,0,100,0,0,0,0,0,45,0,8,0,0,0,0,10,@CRUSADER_GUID+1,@CRUSADER,0,0,0,0,0,"Highlord Tirion Fordring - Script - Set data Disguised Crusader"),
(@TIRION*100+1,9,12,0,0,0,100,0,0,0,0,0,45,0,9,0,0,0,0,10,@CRUSADER_GUID+2,@CRUSADER,0,0,0,0,0,"Highlord Tirion Fordring - Script - Set data Disguised Crusader"),
(@TIRION*100+1,9,13,0,0,0,100,0,15000,15000,0,0,107,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Script - Summon Creature Group"),

(@TIRION*100+2,9,0,0,0,0,100,0,10000,10000,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Script - Say text"),
(@TIRION*100+2,9,1,0,0,0,100,0,5000,5000,0,0,1,2,0,0,0,0,0,19,@LICH,30,0,0,0,0,0,"Highlord Tirion Fordring - Script - Say text"),
(@TIRION*100+2,9,2,0,0,0,100,0,12000,12000,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Script - Say text"),
(@TIRION*100+2,9,3,0,0,0,100,0,5000,5000,0,0,1,3,0,0,0,0,0,19,@LICH,30,0,0,0,0,0,"Highlord Tirion Fordring - Script - Say text"),
(@TIRION*100+2,9,4,0,0,0,100,0,8000,8000,0,0,1,4,0,0,0,0,0,19,@LICH,30,0,0,0,0,0,"Highlord Tirion Fordring - Script - Say text"),
(@TIRION*100+2,9,5,0,0,0,100,0,4000,4000,0,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Script - Say text"),
(@TIRION*100+2,9,6,0,0,0,100,0,15000,15000,0,0,1,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Script - Say text"),
(@TIRION*100+2,9,7,0,0,0,100,0,4000,4000,0,0,11,@SPELL_TIRION_SMASHES_HEART,0,0,0,0,0,19,@COSMET,50,0,0,0,0,0,"Highlord Tirion Fordring - Script - Cast Tirion Smashes Heart"),
(@TIRION*100+2,9,8,0,0,0,100,0,2000,2000,0,0,90,7,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Script - Play dead"),
(@TIRION*100+2,9,9,0,0,0,100,0,0,0,0,0,45,0,1,0,0,0,0,19,@COSMET,50,0,0,0,0,0,"Highlord Tirion Fordring - Script - Set data cosmetic trigger"),
(@TIRION*100+2,9,10,0,0,0,100,0,0,0,0,0,45,0,7,0,0,0,0,10,@CRUSADER_GUID,@CRUSADER,0,0,0,0,0,"Highlord Tirion Fordring - Script - Set data Disguised Crusader"),
(@TIRION*100+2,9,11,0,0,0,100,0,0,0,0,0,45,0,8,0,0,0,0,10,@CRUSADER_GUID+1,@CRUSADER,0,0,0,0,0,"Highlord Tirion Fordring - Script - Set data Disguised Crusader"),
(@TIRION*100+2,9,12,0,0,0,100,0,0,0,0,0,45,0,9,0,0,0,0,10,@CRUSADER_GUID+2,@CRUSADER,0,0,0,0,0,"Highlord Tirion Fordring - Script - Set data Disguised Crusader"),
(@TIRION*100+2,9,13,0,0,0,100,0,15000,15000,0,0,107,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Tirion Fordring - Script - Summon Creature Group");

DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(@GOSSIP,14159),
(@GOSSIP,14160);

DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(@GOSSIP,0,0,'I''m ready, Highlord.',1,1,0,0,0,0,''),
(@GOSSIP,1,0,'I''m ready, Highlord.',1,1,0,0,0,0,'');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=@SPELL_TIRION_SMASHES_HEART;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,14159,0,0,1,0,@SPELL_CULTIST_HOOD,0,0,1,0,0,'','Tirion Fordring - show different gossip text if missing aura'),
(14,@GOSSIP,14160,0,0,1,0,@SPELL_CULTIST_HOOD,0,0,0,0,0,'','Tirion Fordring - show different gossip text if has aura'),
(15,@GOSSIP,0,0,0,1,0,@SPELL_CULTIST_HOOD,0,0,0,0,0,'','Tirion Fordring - show different gossip option if has aura'),
(15,@GOSSIP,0,0,0,9,0,13403,0,0,0,0,0,'','Tirion Fordring - show different gossip option if has quest'),
(15,@GOSSIP,1,0,0,1,0,@SPELL_CULTIST_HOOD,0,0,0,0,0,'','Tirion Fordring - show different gossip option if has aura'),
(15,@GOSSIP,1,0,0,9,0,13364,0,0,0,0,0,'','Tirion Fordring - show different gossip option if has quest'),
(13,1,@SPELL_TIRION_SMASHES_HEART,0,0,31,0,3,@COSMET,0,0,0,0,'','Tirion Smashes Heart - Implicit target - Cosmetic Trigger');

DELETE FROM `waypoints` WHERE `entry` IN (@TIRION*10,@TIRION*10+1);
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@TIRION*10,1,6239.941406,2650.707520,570.249817,'Tirion Fordring - Trion''s Gambit path 1'),
(@TIRION*10,2,6220.946777,2631.026611,570.249817,'Tirion Fordring - Trion''s Gambit path 1'),
(@TIRION*10,3,6196.118164,2624.815430,570.249817,'Tirion Fordring - Trion''s Gambit path 1'),
(@TIRION*10,4,6189.239258,2639.413574,570.249817,'Tirion Fordring - Trion''s Gambit path 1'),
(@TIRION*10,5,6178.146484,2663.314453,574.775452,'Tirion Fordring - Trion''s Gambit path 1'),
(@TIRION*10,6,6170.651367,2679.328857,573.914551,'Tirion Fordring - Trion''s Gambit path 1'),
(@TIRION*10,7,6147.055664,2730.367676,573.914551,'Tirion Fordring - Trion''s Gambit path 1'),
(@TIRION*10,8,6148.141113,2734.706055,573.914551,'Tirion Fordring - Trion''s Gambit path 1'),
(@TIRION*10,9,6166.146973,2747.875977,573.914551,'Tirion Fordring - Trion''s Gambit path 1'),
(@TIRION*10,10,6168.471191,2753.927002,573.914551,'Tirion Fordring - Trion''s Gambit path 1'),
(@TIRION*10,11,6165.566895,2759.631592,573.914551,'Tirion Fordring - Trion''s Gambit path 1'),
(@TIRION*10+1,1,6162.756836,2755.913574,573.914551,'Tirion Fordring - Trion''s Gambit path 2'),
(@TIRION*10+1,2,6142.962402,2758.375977,573.914551,'Tirion Fordring - Trion''s Gambit path 2');

DELETE FROM `creature_text` WHERE `entry`=@TIRION;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@TIRION,0,0,'It is time. May the Light give us strength.',12,0,100,0,0,0,'Tirion Fordring - Tirion''s Gambit'),
(@TIRION,1,0,'Keep your heads down and follow my lead.',12,0,100,0,0,0,'Tirion Fordring - Tirion''s Gambit'),
(@TIRION,2,0,'Here it comes. Stand ready.',12,0,100,0,0,0,'Tirion Fordring - Tirion''s Gambit'),
(@TIRION,3,0,'Something''s wrong... I sense a dark presence.',12,0,100,0,0,0,'Tirion Fordring - Tirion''s Gambit'),
(@TIRION,4,0,'The Lich King is here. May the Light guide our blades.',12,0,100,0,0,0,'Tirion Fordring - Tirion''s Gambit'),
(@TIRION,5,0,'You sound a little too confident. Especially considering the way our last encounter ended.',12,0,100,397,0,0,'Tirion Fordring - Tirion''s Gambit'),
(@TIRION,6,0,'That might be, but I don''t need to stand on holy ground to run that disembodied heart of yours through with the Ashbringer.',12,0,100,1,0,0,'Tirion Fordring - Tirion''s Gambit'),
(@TIRION,7,0,'The heart... the last remaining vestige of your humanity. I had to stop it from being destroyed. I had to see for myself. And at last I''m sure...',12,0,100,1,0,0,'Tirion Fordring - Tirion''s Gambit'),
(@TIRION,8,0,'Only shadows from the past remain. There''s nothing left to redeem!',12,0,100,0,0,0,'Tirion Fordring - Tirion''s Gambit');

DELETE FROM `creature_summon_groups` WHERE `summonerId`=@TIRION;
INSERT INTO `creature_summon_groups` (`summonerId`,`summonerType`,`groupId`,`entry`,`position_x`,`position_y`,`position_z`,`orientation`,`summonType`,`summonTime`) VALUES
(@TIRION,0,0,@MOGRAINE,6155.681152,2711.570068,573.914490,2.039399,7,0),
(@TIRION,0,0,@THASSARIAN,6158.756836,2704.989746,573.914490,2.011906,7,0),
(@TIRION,0,0,@KNIGHT,6164.154297,2707.019287,573.914490,2.011906,7,0),
(@TIRION,0,0,@KNIGHT,6159.490723,2710.089844,573.914490,2.000125,7,0),
(@TIRION,0,0,@KNIGHT,6154.571289,2707.321045,573.914490,2.070811,7,0),
(@TIRION,0,0,@KNIGHT,6154.311035,2702.372070,573.914490,2.011906,7,0),
(@TIRION,0,1,@MOGRAINE,6155.681152,2711.570068,573.914490,2.039399,7,0),
(@TIRION,0,1,@KOLTIRA,6158.756836,2704.989746,573.914490,2.011906,7,0),
(@TIRION,0,1,@KNIGHT,6164.154297,2707.019287,573.914490,2.011906,7,0),
(@TIRION,0,1,@KNIGHT,6159.490723,2710.089844,573.914490,2.000125,7,0),
(@TIRION,0,1,@KNIGHT,6154.571289,2707.321045,573.914490,2.070811,7,0),
(@TIRION,0,1,@KNIGHT,6154.311035,2702.372070,573.914490,2.011906,7,0);

-- Disguised Crusader SAI
UPDATE `creature_template` SET `faction_A`=2070, `faction_H`=2070, `AIName`='SmartAI' WHERE `entry`=@CRUSADER;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@CRUSADER AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@CRUSADER,0,0,0,38,0,100,0,0,1,0,0,53,0,@CRUSADER*10,0,0,0,1,1,0,0,0,0,0,0,0,"Disguised Crusader - Data set - Wp start"),
(@CRUSADER,0,1,0,38,0,100,0,0,2,0,0,53,0,@CRUSADER*10+1,0,0,0,1,1,0,0,0,0,0,0,0,"Disguised Crusader - Data set - Wp start"),
(@CRUSADER,0,2,0,38,0,100,0,0,3,0,0,53,0,@CRUSADER*10+2,0,0,0,1,1,0,0,0,0,0,0,0,"Disguised Crusader - Data set - Wp start"),
(@CRUSADER,0,3,0,38,0,100,0,0,4,0,0,53,0,@CRUSADER*10+3,0,0,0,1,1,0,0,0,0,0,0,0,"Disguised Crusader - Data set - Wp start"),
(@CRUSADER,0,4,0,38,0,100,0,0,5,0,0,53,0,@CRUSADER*10+4,0,0,0,1,1,0,0,0,0,0,0,0,"Disguised Crusader - Data set - Wp start"),
(@CRUSADER,0,5,0,38,0,100,0,0,6,0,0,53,0,@CRUSADER*10+5,0,0,0,1,1,0,0,0,0,0,0,0,"Disguised Crusader - Data set - Wp start"),
(@CRUSADER,0,6,0,38,0,100,0,0,7,0,0,53,1,@CRUSADER*10+6,0,0,0,1,1,0,0,0,0,0,0,0,"Disguised Crusader - Data set - Wp start"),
(@CRUSADER,0,7,0,38,0,100,0,0,8,0,0,53,1,@CRUSADER*10+7,0,0,0,1,1,0,0,0,0,0,0,0,"Disguised Crusader - Data set - Wp start"),
(@CRUSADER,0,8,0,38,0,100,0,0,9,0,0,53,1,@CRUSADER*10+8,0,0,0,1,1,0,0,0,0,0,0,0,"Disguised Crusader - Data set - Wp start"),
(@CRUSADER,0,9,13,40,0,100,0,2,@CRUSADER*10+6,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,3.955350,"Disguised Crusader - Wp reached - Set orientation"),
(@CRUSADER,0,10,11,40,0,100,0,2,@CRUSADER*10+7,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,5.157006,"Disguised Crusader - Wp reached - Set orientation"),
(@CRUSADER,0,11,13,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Disguised Crusader - Wp reached - Say text"),
(@CRUSADER,0,12,13,40,0,100,0,2,@CRUSADER*10+8,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,5.910987,"Disguised Crusader - Wp reached - Set orientation"),
(@CRUSADER,0,13,0,61,0,100,0,0,0,0,0,17,375,0,0,0,0,0,1,0,0,0,0,0,0,0,"Disguised Crusader - Wp reached - Emote state ready 2h"),
(@CRUSADER,0,14,15,38,0,100,0,2,1,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Disguised Crusader - Data set - Remove emote state"),
(@CRUSADER,0,15,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Disguised Crusader - Data set - Despawn");

DELETE FROM `creature_text` WHERE `entry`=@CRUSADER;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@CRUSADER,0,0,'Tirion''s down! Defend him with your lives!',14,0,100,0,0,0,'Disguised Crusader');

DELETE FROM `waypoints` WHERE `entry` IN (@CRUSADER*10,@CRUSADER*10+1,@CRUSADER*10+2,@CRUSADER*10+3,@CRUSADER*10+4,@CRUSADER*10+5,@CRUSADER*10+6,@CRUSADER*10+7,@CRUSADER*10+8);
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@CRUSADER*10,1,6220.838867,2624.906250,570.249695,'Disguised Crusader 1 - path 1'),
(@CRUSADER*10,2,6197.014648,2618.346680,570.249695,'Disguised Crusader 1 - path 1'),
(@CRUSADER*10,3,6186.297363,2622.918457,570.249695,'Disguised Crusader 1 - path 1'),
(@CRUSADER*10,4,6182.798828,2631.565674,570.249695,'Disguised Crusader 1 - path 1'),

(@CRUSADER*10+1,1,6258.975098,2648.005615,570.249695,'Disguised Crusader 2 - path 1'),
(@CRUSADER*10+1,2,6206.530762,2622.075684,570.249695,'Disguised Crusader 2 - path 1'),
(@CRUSADER*10+1,3,6196.014648,2624.235840,570.249695,'Disguised Crusader 2 - path 1'),
(@CRUSADER*10+1,4,6193.691406,2630.078613,570.249695,'Disguised Crusader 2 - path 1'),

(@CRUSADER*10+2,1,6237.660645,2664.916748,570.249695,'Disguised Crusader 3 - path 1'),
(@CRUSADER*10+2,2,6234.392578,2645.124512,570.249695,'Disguised Crusader 3 - path 1'),
(@CRUSADER*10+2,3,6230.790039,2631.032471,570.249695,'Disguised Crusader 3 - path 1'),
(@CRUSADER*10+2,4,6206.812012,2628.923828,570.249695,'Disguised Crusader 3 - path 1'),
(@CRUSADER*10+2,5,6198.209473,2639.145020,570.249695,'Disguised Crusader 3 - path 1'),

(@CRUSADER*10+3,1,6179.115234,2649.185059,573.049133,'Disguised Crusader 1 - path 2'),
(@CRUSADER*10+3,2,6172.813965,2662.745361,575.019165,'Disguised Crusader 1 - path 2'),
(@CRUSADER*10+3,3,6166.211914,2677.572998,573.914612,'Disguised Crusader 1 - path 2'),
(@CRUSADER*10+3,4,6142.465332,2728.010742,573.914612,'Disguised Crusader 1 - path 2'),
(@CRUSADER*10+3,5,6151.588379,2739.946045,573.914612,'Disguised Crusader 1 - path 2'),
(@CRUSADER*10+3,6,6170.939453,2751.959961,573.914612,'Disguised Crusader 1 - path 2'),
(@CRUSADER*10+3,7,6171.098145,2755.557861,573.914612,'Disguised Crusader 1 - path 2'),
(@CRUSADER*10+3,8,6168.311035,2761.048096,573.914612,'Disguised Crusader 1 - path 2'),

(@CRUSADER*10+4,1,6177.047852,2665.750732,574.636719,'Disguised Crusader 2 - path 2'),
(@CRUSADER*10+4,2,6147.493164,2728.676514,573.914185,'Disguised Crusader 2 - path 2'),
(@CRUSADER*10+4,3,6154.661133,2739.391846,573.914185,'Disguised Crusader 2 - path 2'),
(@CRUSADER*10+4,4,6175.181152,2752.962402,573.914185,'Disguised Crusader 2 - path 2'),
(@CRUSADER*10+4,5,6174.470703,2756.466797,573.914185,'Disguised Crusader 2 - path 2'),
(@CRUSADER*10+4,6,6170.861816,2762.202881,573.914734,'Disguised Crusader 2 - path 2'),

(@CRUSADER*10+5,1,6188.757813,2654.733643,573.277649,'Disguised Crusader 3 - path 2'),
(@CRUSADER*10+5,2,6182.578125,2667.641357,575.042358,'Disguised Crusader 3 - path 2'),
(@CRUSADER*10+5,3,6174.874023,2681.556885,573.914612,'Disguised Crusader 3 - path 2'),
(@CRUSADER*10+5,4,6150.269531,2733.372559,573.914612,'Disguised Crusader 3 - path 2'),
(@CRUSADER*10+5,5,6177.979980,2751.850342,573.914612,'Disguised Crusader 3 - path 2'),
(@CRUSADER*10+5,6,6175.007324,2759.482178,573.914734,'Disguised Crusader 3 - path 2'),
(@CRUSADER*10+5,7,6173.294434,2763.204346,573.914734,'Disguised Crusader 3 - path 2'),

(@CRUSADER*10+6,1,6156.296875,2755.093018,573.914429,'Disguised Crusader 1 - path 3'),
(@CRUSADER*10+6,2,6129.550293,2759.240479,573.914429,'Disguised Crusader 1 - path 3'),

(@CRUSADER*10+7,1,6156.296875,2755.093018,573.914429,'Disguised Crusader 2 - path 3'),
(@CRUSADER*10+7,2,6133.671875,2758.313232,573.914429,'Disguised Crusader 2 - path 3'),

(@CRUSADER*10+8,1,6156.296875,2755.093018,573.914429,'Disguised Crusader 3 - path 3'),
(@CRUSADER*10+8,2,6135.753418,2762.257813,573.914429,'Disguised Crusader 3 - path 3');


-- High Invoker Basaleph
UPDATE `creature_template` SET `faction_A`=233, `faction_H`=233, `unit_flags`=unit_flags|256|512, `ScriptName`='npc_high_invoker_basaleph' WHERE `entry`=@BASALEPH;

-- Chosen Zealot
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ZEALOT;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ZEALOT AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ZEALOT*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ZEALOT,0,0,0,38,0,100,0,0,1,0,0,53,0,@ZEALOT*10,0,0,0,0,1,0,0,0,0,0,0,0,"Chosen Zealot - Data set - Wp start"),
(@ZEALOT,0,1,0,38,0,100,0,0,2,0,0,53,0,@ZEALOT*10+1,0,0,0,0,1,0,0,0,0,0,0,0,"Chosen Zealot - Data set - Wp start"),
(@ZEALOT,0,2,0,38,0,100,0,0,3,0,0,53,0,@ZEALOT*10+2,0,0,0,0,1,0,0,0,0,0,0,0,"Chosen Zealot - Data set - Wp start"),
(@ZEALOT,0,3,0,40,0,100,0,1,@ZEALOT*10+1,0,0,54,17000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chosen Zealot - Wp reached - Pause wp"),
(@ZEALOT,0,4,0,40,0,100,0,1,@ZEALOT*10+2,0,0,54,17000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chosen Zealot - Wp reached - Pause wp"),
(@ZEALOT,0,5,6,40,0,100,0,1,@ZEALOT*10,0,0,54,18000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chosen Zealot - Wp reached - Pause wp"),
(@ZEALOT,0,6,0,61,0,100,0,0,0,0,0,80,@ZEALOT*100,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chosen Zealot - Wp reached - Run script"),
(@ZEALOT,0,7,0,40,0,100,0,2,@ZEALOT*10,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chosen Zealot - Wp reached - Despawn"),
(@ZEALOT,0,8,0,40,0,100,0,2,@ZEALOT*10+1,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chosen Zealot - Wp reached - Despawn"),
(@ZEALOT,0,9,0,40,0,100,0,2,@ZEALOT*10+2,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chosen Zealot - Wp reached - Despawn"),
(@ZEALOT,0,10,0,38,0,100,0,1,1,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chosen Zealot - Data set - Kneel"),
(@ZEALOT,0,11,0,38,0,100,0,1,2,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chosen Zealot - Data set - Stand up"),
(@ZEALOT,0,12,0,38,0,100,0,1,3,0,0,5,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chosen Zealot - Data set - Bow"),
(@ZEALOT,0,13,14,34,0,100,0,8,3,0,0,17,27,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chosen Zealot - Movementinform - Set emote state"),
(@ZEALOT,0,14,15,61,0,100,0,0,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chosen Zealot - Movementinform - Set home position"),
(@ZEALOT,0,15,0,61,0,100,0,0,0,0,0,66,0,0,0,0,0,0,19,@TIRION,50,0,0,0,0,0,"Chosen Zealot - Movementinform - Face Tirion"),
(@ZEALOT*100,9,0,0,0,0,100,0,3000,3000,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chosen Zealot - Script - Kneel"),
(@ZEALOT*100,9,1,0,0,0,100,0,0,0,0,0,45,1,1,0,0,0,0,9,@ZEALOT,0,5,0,0,0,0,"Chosen Zealot - Script - Set data Chosen Zealot"),
(@ZEALOT*100,9,2,0,0,0,100,0,2000,2000,0,0,45,0,2,0,0,0,0,19,@COSMET,30,0,0,0,0,0,"Chosen Zealot - Script - Set data Cosmetic trigger"),
(@ZEALOT*100,9,3,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chosen Zealot - Script - Say text"),
(@ZEALOT*100,9,4,0,0,0,100,0,7000,7000,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chosen Zealot - Script - Stand up"),
(@ZEALOT*100,9,5,0,0,0,100,0,0,0,0,0,45,1,2,0,0,0,0,9,@ZEALOT,0,5,0,0,0,0,"Chosen Zealot - Script - Set data Chosen Zealot"),
(@ZEALOT*100,9,6,0,0,0,100,0,3000,3000,0,0,5,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chosen Zealot - Script - Bow"),
(@ZEALOT*100,9,7,0,0,0,100,0,0,0,0,0,45,1,3,0,0,0,0,9,@ZEALOT,0,5,0,0,0,0,"Chosen Zealot - Script - Set data Chosen Zealot"),
(@ZEALOT*100,9,8,0,0,0,100,0,3000,3000,0,0,45,0,1,0,0,0,0,19,@TIRION,50,0,0,0,0,0,"Chosen Zealot - Script - Set data Tirion Fordring");

DELETE FROM `creature_text` WHERE `entry`=@ZEALOT;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ZEALOT,0,0,'We lost many to the faceless ones, my lord. But we succeeded in retrieving the heart from Naz''anak.',12,0,100,0,0,0,'Chosen Zealot');

DELETE FROM `waypoints` WHERE `entry` IN (@ZEALOT*10,@ZEALOT*10+1,@ZEALOT*10+2);
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@ZEALOT*10,1,6134.06,2757.756,573.914,'Chosen Zealot 1'),
(@ZEALOT*10,2,6159.269,2703.837,573.914,'Chosen Zealot 1'),
(@ZEALOT*10+1,1,6132.468,2755.545,573.914,'Chosen Zealot 2'),
(@ZEALOT*10+1,2,6158.322,2701.014,573.914,'Chosen Zealot 2'),
(@ZEALOT*10+2,1,6136.583,2757.737,573.914,'Chosen Zealot 3'),
(@ZEALOT*10+2,2,6162.118,2702.893,573.914,'Chosen Zealot 3');

-- The Lich King
UPDATE `creature_template` SET `AIName`='SmartAI', `minlevel`=1, `maxlevel`=1, `faction_A`=14, `faction_H`=14, `type_flags`=0, `RegenHealth`=0, `unit_flags`=unit_flags|256 WHERE `entry`=@LICH;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@LICH AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@LICH*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@LICH,0,0,1,54,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - Just summoned - React passive"),
(@LICH,0,1,0,61,0,100,0,0,0,0,0,53,0,@LICH,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - Just summoned - Wp start"),
(@LICH,0,2,0,40,0,100,0,1,@LICH,0,0,80,@LICH*100,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - Wp reached - Run script"),
(@LICH,0,3,0,8,0,100,0,@SPELL_HEART_EXPLOSION_EFFECTS,0,0,0,1,5,5000,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - Spellhit - Say text"),
(@LICH,0,4,5,52,0,100,0,5,@LICH,0,0,1,6,10000,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - Text over - Say text"),
(@LICH,0,5,0,61,0,100,0,0,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - Text over - Kneel"),
(@LICH,0,6,0,38,0,100,0,0,2,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - Data set - Stand up"),
(@LICH,0,7,8,38,0,100,0,2,1,0,0,41,8000,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - Data set - Despawn in 8 seconds"),
(@LICH,0,8,0,61,0,100,0,0,0,0,0,11,@SPELL_LICH_KINGS_FURY,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - Data set - Cast Lich King's Fury"),
(@LICH*100,9,0,0,0,0,100,0,4000,4000,0,0,66,0,0,0,0,0,0,19,@TIRION,50,0,0,0,0,0,"The Lich King - Script - Face Tirion"),
(@LICH*100,9,1,0,0,0,100,0,4000,4000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - Script - Say text"),
(@LICH*100,9,2,0,0,0,100,0,0,0,0,0,45,0,2,0,0,0,0,19,@TIRION,50,0,0,0,0,0,"The Lich King - Script - Set data Tirion"),
(@LICH*100,9,3,0,0,0,100,0,8000,8000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Lich King - Script - Say text");

DELETE FROM `waypoints` WHERE `entry`=@LICH;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@LICH,1,6132.128418,2757.831543,573.914856,'The Lich King - Tirion''s Gambit');

DELETE FROM `creature_text` WHERE `entry`=@LICH;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@LICH,0,0,'Uninvited guests! Did you think you''d go unnoticed inside my dominion?',12,0,100,1,0,0,'The Lich King - Tirion''s Gambit'),
(@LICH,1,0,'I must confess... you were not altogether unexpected. I hope you find your final resting place... to your liking.',12,0,100,1,0,0,'The Lich King - Tirion''s Gambit'),
(@LICH,2,0,'Last time we met, you had the advantage of fighting on holy ground. You''ll find that our situation has been... reversed.',12,0,100,11,0,0,'The Lich King - Tirion''s Gambit'),
(@LICH,3,0,'I call your bluff. You''re a paladin after all. Your obsession with redemption goes beyond the inane.',12,0,100,1,0,0,'The Lich King - Tirion''s Gambit'),
(@LICH,4,0,'You surely wouldn''t destroy humanity''s only chance to redeem its most wayward son. You''d sooner die!',12,0,100,1,0,0,'The Lich King - Tirion''s Gambit'),
(@LICH,5,0,'Arrrrggggggggggh!!!!',14,0,100,0,0,0,'The Lich King - Tirion''s Gambit'),
(@LICH,6,0,'You... will pay for that, old man. Slay them all!',14,0,100,0,0,0,'The Lich King - Tirion''s Gambit');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=@SPELL_LICH_KINGS_FURY;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,@SPELL_LICH_KINGS_FURY,0,0,31,0,4,0,0,0,0,0,'','Lich King''s Fury- Implicit target - Players');

-- Generic Trigger LAB
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@COSMET;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@COSMET AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@COSMET,0,0,0,38,0,100,0,0,1,0,0,11,@SPELL_HEART_EXPLOSION,0,0,0,0,0,1,0,0,0,0,0,0,0,"Generic Trigger LAB - Data set - Cast Heart explosion"),
(@COSMET,0,1,0,38,0,100,0,0,2,0,0,50,@FROZEN_HEART,140,0,0,0,0,1,0,0,0,0,0,0,0,"Generic Trigger LAB - Data set - Summon Frozen Heart"),
(@COSMET,0,6,0,38,0,100,0,0,3,0,0,50,@ESCAPE_PORTAL,60,0,0,0,0,8,0,0,0,6132.794434,2756.298828,573.914551,4.617866,"Generic Trigger LAB - Data set - Summon Escape Portal");

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=@SPELL_HEART_EXPLOSION;
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(@SPELL_HEART_EXPLOSION,@SPELL_HEART_EXPLOSION_EFFECTS,1,'Heart Explosion - Heart Explosion Effects');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=@SPELL_HEART_EXPLOSION_EFFECTS;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,@SPELL_HEART_EXPLOSION_EFFECTS,0,0,31,0,3,@LICH,0,0,0,0,'','Heart Explosion Effects - Implicit target - The Lich King'),
(13,2,@SPELL_HEART_EXPLOSION_EFFECTS,0,0,31,0,3,@LICH,0,0,0,0,'','Heart Explosion Effects - Implicit target - The Lich King'),
(13,4,@SPELL_HEART_EXPLOSION_EFFECTS,0,0,31,0,3,@BASALEPH,0,0,0,0,'','Heart Explosion Effects - Implicit target - High Invoker Basaleph');

-- Highlord Darion Mograine
UPDATE `creature_template` SET `AIName`='SmartAI', `minlevel`=83, `maxlevel`=83, `faction_A`=2144, `faction_H`=2144, `mindmg`=417, `maxdmg`=582, `unit_flags`=unit_flags|256|512 WHERE `entry`=@MOGRAINE;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@MOGRAINE AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@MOGRAINE*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@MOGRAINE,0,0,1,54,0,100,0,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Darion Mograine - Just Summoned - Set run"),
(@MOGRAINE,0,1,2,61,0,100,0,0,0,0,0,42,0,50,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Darion Mograine - Just Summoned - Set invincibility at 50% hp"),
(@MOGRAINE,0,2,3,61,0,100,0,0,0,0,0,46,43,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Darion Mograine - Just Summoned - Move 43 yards forward"),
(@MOGRAINE,0,3,0,61,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Darion Mograine - Just Summoned - Set phase 1"),
(@MOGRAINE,0,4,5,34,0,100,0,8,0,0,0,17,333,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Darion Mograine - Movementinform - Set emote state"),
(@MOGRAINE,0,5,6,61,0,100,0,0,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Darion Mograine - Movementinform - Set home position"),
(@MOGRAINE,0,6,7,61,0,100,0,0,0,0,0,19,768,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Darion Mograine - Movementinform - Remove unit flags"),
(@MOGRAINE,0,7,0,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,19,@ZEALOT,50,0,0,0,0,0,"Highlord Darion Mograine - Movementinform - Attack chosen Zealot"),
(@MOGRAINE,0,8,0,0,0,100,0,2000,3000,2000,3000,11,60541,0,0,0,0,0,2,0,0,0,0,0,0,0,"Highlord Darion Mograine - In combat - Cast Instantkill Chosen Zealot"),
(@MOGRAINE,0,9,0,7,1,100,1,0,0,0,0,80,@MOGRAINE*100,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Darion Mograine - Evade (phase 1) - Run script"),

(@MOGRAINE*100,9,0,0,0,0,100,0,5000,5000,0,0,66,0,0,0,0,0,0,19,@LICH,50,0,0,0,0,0,"Highlord Darion Mograine - Script - Face Lich King"),
(@MOGRAINE*100,9,1,0,0,0,100,0,5000,5000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Darion Mograine - Script - Say text"),
(@MOGRAINE*100,9,2,0,0,0,100,0,0,0,0,0,11,@SPELL_TIRIONS_GAMBIT_EVENT_CREDIT,2,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Darion Mograine - Script - Complete quest"),
(@MOGRAINE*100,9,3,0,0,0,100,0,0,0,0,0,45,0,3,0,0,0,0,19,@COSMET,50,0,0,0,0,0,"Highlord Darion Mograine - Script - Set data Cosmetic Trigger"),
(@MOGRAINE*100,9,4,0,0,0,100,0,9000,9000,0,0,45,0,1,0,0,0,0,19,@THASSARIAN,50,0,0,0,0,0,"Highlord Darion Mograine - Script - Say text"),
(@MOGRAINE*100,9,5,0,0,0,100,0,0,0,0,0,45,0,1,0,0,0,0,19,@KOLTIRA,50,0,0,0,0,0,"Highlord Darion Mograine - Script - Say text"),
(@MOGRAINE*100,9,6,0,0,0,100,0,7000,7000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Darion Mograine - Script - Say text"),
(@MOGRAINE*100,9,7,0,0,0,100,0,5000,5000,0,0,45,0,2,0,0,0,0,19,@LICH,50,0,0,0,0,0,"Highlord Darion Mograine - Script - Set data Lich King"),
(@MOGRAINE*100,9,8,0,0,0,100,0,3000,3000,0,0,45,2,1,0,0,0,0,19,@THASSARIAN,50,0,0,0,0,0,"Highlord Darion Mograine - Script - Set data Thasarian"),
(@MOGRAINE*100,9,9,0,0,0,100,0,0,0,0,0,45,2,1,0,0,0,0,19,@KOLTIRA,50,0,0,0,0,0,"Highlord Darion Mograine - Script - Set data Koltira"),
(@MOGRAINE*100,9,10,0,0,0,100,0,0,0,0,0,45,2,1,0,0,0,0,19,@TIRION,50,0,0,0,0,0,"Highlord Darion Mograine - Script - Set data Tirion Fordring"),
(@MOGRAINE*100,9,11,0,0,0,100,0,0,0,0,0,45,2,1,0,0,0,0,9,@KNIGHT,0,50,0,0,0,0,"Highlord Darion Mograine - Script - Set data Ebon Knights"),
(@MOGRAINE*100,9,12,0,0,0,100,0,0,0,0,0,45,2,1,0,0,0,0,9,@CRUSADER,0,50,0,0,0,0,"Highlord Darion Mograine - Script - Set data Disguised Crusaders"),
(@MOGRAINE*100,9,13,0,0,0,100,0,0,0,0,0,45,2,1,0,0,0,0,19,@LICH,50,0,0,0,0,0,"Highlord Darion Mograine - Script - Set data Lich King"),
(@MOGRAINE*100,9,14,0,0,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Darion Mograine - Script - Despawn");

DELETE FROM `creature_text` WHERE `entry`=@MOGRAINE;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@MOGRAINE,0,0,'Quick, through the portal! He won''t stay down for long.',12,0,100,0,0,0,'Darion Mograine - Tirion''s Gambit'),
(@MOGRAINE,1,0,'Patience... we will get our chance soon enough. Be content that for once, it is Tirion who is in our debt.',12,0,100,0,0,0,'Darion Mograine - Tirion''s Gambit');

DELETE FROM `spell_target_position` WHERE `id`=60585;
INSERT INTO `spell_target_position` (`id`,`target_map`,`target_position_x`,`target_position_y`,`target_position_z`,`target_orientation`) VALUES
(60585,571,6440.082,406.008,497.512,2.359903);

-- Thassarian
UPDATE `creature_template` SET `AIName`='SmartAI', `minlevel`=80, `maxlevel`=80, `faction_A`=2144, `faction_H`=2144, `mindmg`=417, `maxdmg`=582, `unit_flags`=unit_flags|256|512 WHERE `entry`=@THASSARIAN;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@THASSARIAN AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@THASSARIAN,0,0,1,54,0,100,0,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Thassarian - Just Summoned - Set run"),
(@THASSARIAN,0,1,2,61,0,100,0,0,0,0,0,42,0,50,0,0,0,0,1,0,0,0,0,0,0,0,"Thassarian - Just Summoned - Set invincibility at 50% hp"),
(@THASSARIAN,0,2,3,61,0,100,0,0,0,0,0,46,39,0,0,0,0,0,1,0,0,0,0,0,0,0,"Thassarian - Just Summoned - Move 39 yards forward"),
(@THASSARIAN,0,3,0,61,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Thassarian - Just Summoned - Set phase 1"),
(@THASSARIAN,0,4,5,34,0,100,0,8,0,0,0,17,333,0,0,0,0,0,1,0,0,0,0,0,0,0,"Thassarian - Movementinform - Set emote state"),
(@THASSARIAN,0,5,6,61,0,100,0,0,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Thassarian - Movementinform - Set home position"),
(@THASSARIAN,0,6,7,61,0,100,0,0,0,0,0,19,768,0,0,0,0,0,1,0,0,0,0,0,0,0,"Thassarian - Movementinform - Remove unit flags"),
(@THASSARIAN,0,7,0,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,19,@ZEALOT,50,0,0,0,0,0,"Thassarian - Movementinform - Attack chosen Zealot"),
(@THASSARIAN,0,8,0,0,0,100,0,5000,8000,11200,13400,11,59992,0,0,0,0,0,2,0,0,0,0,0,0,0,"Thassarian - In combat - Cast Cleave"),
(@THASSARIAN,0,9,0,0,0,100,0,2000,3000,2000,3000,11,60541,0,0,0,0,0,2,0,0,0,0,0,0,0,"Thassarian - In combat - Cast Instantkill Chosen Zealot"),
(@THASSARIAN,0,10,0,0,1,100,1,1500,1500,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Thassarian - OOC (phase 1) - Say text"),
(@THASSARIAN,0,11,0,38,0,100,0,2,1,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Thassarian - Data set - Despawn"),
(@THASSARIAN,0,12,0,38,0,100,0,0,1,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Thassarian - Data set - Say text");

DELETE FROM `creature_text` WHERE `entry`=@THASSARIAN;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@THASSARIAN,0,0,'I hope you fellows don''t mind if we crash this party. I brought some old friends with me!',14,0,100,0,0,0,'Thassarian - Tirion''s Gambit'),
(@THASSARIAN,1,0,'Looks like whatever Tirion did put some hurt on the Lich King. It''s too bad we can''t finish him off....',12,0,100,0,0,0,'Thassarian - Tirion''s Gambit');

-- Koltira Deathweaver
UPDATE `creature_template` SET `AIName`='SmartAI', `minlevel`=80, `maxlevel`=80, `faction_A`=2144, `faction_H`=2144, `mindmg`=417, `maxdmg`=582, `unit_flags`=unit_flags|256|512 WHERE `entry`=@KOLTIRA;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@KOLTIRA AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@KOLTIRA,0,0,1,54,0,100,0,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Koltira Deathweaver - Just Summoned - Set run"),
(@KOLTIRA,0,1,2,61,0,100,0,0,0,0,0,42,0,50,0,0,0,0,1,0,0,0,0,0,0,0,"Koltira Deathweaver - Just Summoned - Set invincibility at 50% hp"),
(@KOLTIRA,0,2,3,61,0,100,0,0,0,0,0,46,39,0,0,0,0,0,1,0,0,0,0,0,0,0,"Koltira Deathweaver - Just Summoned - Move 39 yards forward"),
(@KOLTIRA,0,3,0,61,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Koltira Deathweaver - Just Summoned - Set phase 1"),
(@KOLTIRA,0,4,5,34,0,100,0,8,0,0,0,17,375,0,0,0,0,0,1,0,0,0,0,0,0,0,"Koltira Deathweaver - Movementinform - Set emote state"),
(@KOLTIRA,0,5,6,61,0,100,0,0,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Koltira Deathweaver - Movementinform - Set home position"),
(@KOLTIRA,0,6,7,61,0,100,0,0,0,0,0,19,768,0,0,0,0,0,1,0,0,0,0,0,0,0,"Koltira Deathweaver - Movementinform - Remove unit flags"),
(@KOLTIRA,0,7,0,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,19,@ZEALOT,50,0,0,0,0,0,"Koltira Deathweaver - Movementinform - Attack chosen Zealot"),
(@KOLTIRA,0,8,0,0,0,100,0,5000,8000,11200,13400,11,59992,0,0,0,0,0,2,0,0,0,0,0,0,0,"Koltira Deathweaver - In combat - Cast Cleave"),
(@KOLTIRA,0,9,0,0,0,100,0,2000,3000,2000,3000,11,60541,0,0,0,0,0,2,0,0,0,0,0,0,0,"Koltira Deathweaver - In combat - Cast Instantkill Chosen Zealot"),
(@KOLTIRA,0,10,0,0,1,100,1,1500,1500,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Koltira Deathweaver - OOC (phase 1) - Say text"),
(@KOLTIRA,0,11,0,38,0,100,0,2,1,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Koltira Deathweaver - Data set - Despawn"),
(@KOLTIRA,0,12,0,38,0,100,0,0,1,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Koltira Deathweaver - Data set - Say text");

DELETE FROM `creature_text` WHERE `entry`=@KOLTIRA;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@KOLTIRA,0,0,'Take courage, crusaders. You do not fight alone!',14,0,100,0,0,0,'Koltira Deathweaver - Tirion''s Gambit'),
(@KOLTIRA,1,0,'The Lich King is badly hurt. We ought to stay behind and finish him.',12,0,100,0,0,0,'Koltira Deathweaver - Tirion''s Gambit');

-- Ebon Knight
UPDATE `creature_template` SET `AIName`='SmartAI', `minlevel`=80, `maxlevel`=80, `faction_A`=2144, `faction_H`=2144, `mindmg`=417, `maxdmg`=582, `unit_flags`=unit_flags|256|512 WHERE `entry`=@KNIGHT;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@KNIGHT AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@KNIGHT,0,0,1,54,0,100,0,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ebon Knight - Just Summoned - Set run"),
(@KNIGHT,0,1,2,61,0,100,0,0,0,0,0,42,0,50,0,0,0,0,1,0,0,0,0,0,0,0,"Ebon Knight - Just Summoned - Set invincibility at 50% hp"),
(@KNIGHT,0,2,0,61,0,100,0,0,0,0,0,46,39,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ebon Knight - Just Summoned - Move 39 yards forward"),
(@KNIGHT,0,3,4,34,0,100,0,8,0,0,0,17,375,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ebon Knight - Movementinform - Set emote state"),
(@KNIGHT,0,4,5,61,0,100,0,0,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ebon Knight - Movementinform - Set home position"),
(@KNIGHT,0,5,6,61,0,100,0,0,0,0,0,19,768,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ebon Knight - Movementinform - Remove unit flags"),
(@KNIGHT,0,6,0,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,19,@ZEALOT,50,0,0,0,0,0,"Ebon Knight - Movementinform - Attack chosen Zealot"),
(@KNIGHT,0,7,0,0,0,100,0,5000,8000,11000,12000,11,60945,0,0,0,0,0,2,0,0,0,0,0,0,0,"Ebon Knight - In combat - Cast Blood Strike"),
(@KNIGHT,0,8,0,0,0,70,0,3300,3300,16000,16000,11,59131,0,0,0,0,0,2,0,0,0,0,0,0,0,"Ebon Knight - In combat - Cast Icy Touch"),
(@KNIGHT,0,9,0,0,0,100,0,10000,10000,19000,19000,11,60949,0,0,0,0,0,5,0,0,0,0,0,0,0,"Ebon Knight - In combat - Cast Death Coil"),
(@KNIGHT,0,10,0,9,0,100,0,10,30,10000,15000,11,49576,0,0,0,0,0,2,0,0,0,0,0,0,0,"Ebon Knight - In combat - Cast Death Grip on Aggro"),
(@KNIGHT,0,11,0,0,0,100,0,5000,8000,25000,25000,11,50688,0,0,0,0,0,2,0,0,0,0,0,0,0,"Ebon Knight - In combat - Cast Plague Strike"),
(@KNIGHT,0,12,0,38,0,100,0,2,1,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ebon Knight - Data set - Despawn");
