-- Quest - The Flesh Giant Champion
SET @MORBIDUS := 30698;
SET @LICH := 31301;
SET @DHAKAR := 31306;
SET @OLAKIN := 31428;
SET @VETERAN := 31314;
SET @GOSSIP := 10060;

DELETE FROM `creature_text` WHERE `entry` IN (@LICH,@DHAKAR,@OLAKIN);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(@DHAKAR, 0, 0, "Knights of the Ebon Blade, prepare for battle!", 12, 0, 100, 25, 0, 0, ''),
(@LICH, 0, 0, "You dare to think you have thwarted my will? That you have broken my plans?", 12, 0, 100, 25, 0, 0, "LK SAY 1"),
(@LICH, 1, 0, "You have accomplished nothing!", 12, 0, 100, 22, 0, 0, "LK SAY 2"),
(@LICH, 2, 0, "Your feeble resistance has only hastened your doom.", 12, 0, 100, 25, 0, 0, "LK SAY 3"),
(@LICH, 3, 0, "So spout your platitudes and flail until you are spent. In the end, you will be mine, and Morbidus will be the harbinger of your death!", 12, 0, 100, 22, 0, 0, "LK SAY 4"),
(@LICH, 4, 0, "Morbidus, show them what happens to those who defy the will of their king!", 12, 0, 100, 25, 0, 0, "LK SAY 5"),
(@OLAKIN, 0, 0, "You will pay for what you've done! For the Argent Crusade!", 12, 0, 100, 1, 0, 0, "OLAKIN SAY 1");

UPDATE `creature_template` SET `AIName`='SmartAI', `minlevel`=80, `maxlevel`=80, `speed_run`=0.99206, `faction_A`=2139,`faction_H`=2139 WHERE `entry`=@MORBIDUS;
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_A`=2144,`faction_H`=2144, `npcflag`=1, `gossip_menu_id`=@GOSSIP WHERE `entry`=@DHAKAR;
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_A`=14,`faction_H`=14, `unit_flags`=unit_flags|768 WHERE `entry`=@LICH;
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_A`=2144,`faction_H`=2144 WHERE `entry`=@VETERAN;
UPDATE `creature_template` SET `faction_A`=2070,`faction_H`=2070 WHERE `entry`=@OLAKIN;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@MORBIDUS,@LICH,@DHAKAR,@VETERAN) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@DHAKAR*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@LICH,0,0,0,1,0,100,1,0,0,0,0,11,64195,2,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - OOC - Cast cosmetic teleport'),
(@LICH,0,1,0,1,0,100,1,39000,39000,0,0,11,64195,2,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - OOC - Cast cosmetic teleport'),

(@MORBIDUS,0,0,0,25,0,100,0,0,0,0,0,18,768,0,0,0,0,0,1,0,0,0,0,0,0,0,'Morbidus - Reset - Set unit flags'),
(@MORBIDUS,0,1,0,0,0,100,0,8000,8000,16700,18500,11,72728,0,0,0,0,0,2,0,0,0,0,0,0,0,'Morbidus - In combat - Cast Corrode Flesh'),
(@MORBIDUS,0,2,0,0,0,100,0,10000,10000,25000,28900,11,31277,0,0,0,0,0,1,0,0,0,0,0,0,0,'Morbidus - In combat - Cast Stomp'),
(@MORBIDUS,0,3,0,6,0,100,0,0,0,0,0,33,@MORBIDUS,0,0,0,0,0,17,0,40,0,0,0,0,0,'Morbidus - Death - Give credit'),

(@VETERAN,0,0,0,25,0,100,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ebon Blade Veteran - Reset - Remove emote state'),
(@VETERAN,0,1,0,0,0,100,0,5000,8000,25000,25000,11,50688,0,0,0,0,0,2,0,0,0,0,0,0,0,'Ebon Blade Veteran - In combat - Cast Plague Strike'),
(@VETERAN,0,2,0,38,0,100,0,1,1,0,0,49,0,0,0,0,0,0,19,@MORBIDUS,0,0,0,0,0,0,'Ebon Blade Veteran - Data set - Attack Morbidus'),
(@VETERAN,0,3,0,38,0,100,0,2,2,0,0,17,375,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ebon Blade Veteran - Data set - Emote state ready'),

(@DHAKAR,0,0,0,25,0,100,0,0,0,0,0,82,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Margrave Dhakar - Reset - Add gossip npcflag'),
(@DHAKAR,0,1,0,25,0,100,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Margrave Dhakar - Reset - Remove emote state'),
(@DHAKAR,0,2,3,62,0,100,0,@GOSSIP,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Margrave Dhakar - Gossip select - close gossip'),
(@DHAKAR,0,3,0,61,0,100,0,0,0,0,0,80,@DHAKAR*100,2,0,0,0,0,1,0,0,0,0,0,0,0,'Margrave Dhakar - Gossip select - Run script'),
(@DHAKAR*100,9,0,0,0,0,100,0,0,0,0,0,83,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Margrave Dhakar - Script - Remove gossip flags'),
(@DHAKAR*100,9,1,0,0,0,100,0,0,0,0,0,17,375,0,0,0,0,0,1,0,0,0,0,0,0,0,'Margrave Dhakar - Script - Emote state ready'),
(@DHAKAR*100,9,2,0,0,0,100,0,0,0,0,0,45,2,2,0,0,0,0,9,@VETERAN,0,50,0,0,0,0,'Margrave Dhakar - Script - Set data Ebon Blade Veterans'),
(@DHAKAR*100,9,3,0,0,0,100,0,1000,1000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Margrave Dhakar - Script - Say text'),
(@DHAKAR*100,9,4,0,0,0,100,0,0,0,0,0,12,@LICH,3,40000,0,0,0,8,0,0,0,6859.018555,3574.278564,735.808289,5.680399,'Margrave Dhakar - Script - Summon The Lich King'),
(@DHAKAR*100,9,5,0,0,0,100,0,5000,5000,0,0,1,0,0,0,0,0,0,19,@LICH,0,0,0,0,0,0,'Margrave Dhakar - Script - Say text'),
(@DHAKAR*100,9,6,0,0,0,100,0,5000,5000,0,0,1,1,0,0,0,0,0,19,@LICH,0,0,0,0,0,0,'Margrave Dhakar - Script - Say text'),
(@DHAKAR*100,9,7,0,0,0,100,0,5000,5000,0,0,1,2,0,0,0,0,0,19,@LICH,0,0,0,0,0,0,'Margrave Dhakar - Script - Say text'),
(@DHAKAR*100,9,8,0,0,0,100,0,5000,5000,0,0,1,3,0,0,0,0,0,19,@LICH,0,0,0,0,0,0,'Margrave Dhakar - Script - Say text'),
(@DHAKAR*100,9,9,0,0,0,100,0,12000,12000,0,0,1,4,0,0,0,0,0,19,@LICH,0,0,0,0,0,0,'Margrave Dhakar - Script - Say text'),
(@DHAKAR*100,9,10,0,0,0,100,0,8000,8000,0,0,1,0,0,0,0,0,0,19,@OLAKIN,0,0,0,0,0,0,'Margrave Dhakar - Script - Say text'),
(@DHAKAR*100,9,11,0,0,0,100,0,5000,5000,0,0,19,768,0,0,0,0,0,19,@MORBIDUS,0,0,0,0,0,0,'Margrave Dhakar - Script - Remove Morbidus flags'),
(@DHAKAR*100,9,12,0,0,0,100,0,500,500,0,0,49,0,0,0,0,0,0,19,@MORBIDUS,0,0,0,0,0,0,'Margrave Dhakar - Script - Attack Morbidus'),
(@DHAKAR*100,9,13,0,0,0,100,0,500,500,0,0,45,1,1,0,0,0,0,9,@VETERAN,0,50,0,0,0,0,'Margrave Dhakar - Script - Set data Ebon Blade Veterans');

DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(@GOSSIP,13978);

DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(@GOSSIP,0,0,"Let's kill this... thing... and get this over with.",1,1,0,0,0,0,'');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15,@GOSSIP,0,0,0,9,0,13235,0,0,0,0,'','Margrave Dhakar - show gossip if player has quest'),
(15,@GOSSIP,0,0,0,29,0,@MORBIDUS,50,0,0,0,'','Margrave Dhakar - show gossip if near Morbidus'); -- no muestra la opcion si Morbidus esta muerto

DELETE FROM `creature` WHERE `id` IN (@MORBIDUS,@DHAKAR,@VETERAN,@OLAKIN);
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `curhealth`, `curmana`) VALUES
(@MORBIDUS,571,1,64,6856.76,3581.34,735.878,5.78497,900,75600,0),
(@DHAKAR,571,1,64,6868.39,3577.59,735.907,2.93215,300,37800,11982),
(@VETERAN,571,1,64,6866.1,3567.61,735.904,2.59625,300,12600,3994),
(@VETERAN,571,1,64,6868,3570.93,736.025,2.63552,300,12600,3994),
(@VETERAN,571,1,64,6870.28,3575.28,735.791,2.67087,300,12600,3994),
(@VETERAN,571,1,64,6873.58,3580.76,735.814,2.6473,300,12600,3994),
(@OLAKIN,571,1,64,6859.84,3565.41,735.809,1.7614,300,12600,3994);
