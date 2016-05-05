-- Quest - Banshee's Revenge
SET @VARDMADRA := 31029;
SET @BALARGARDE := 31016;
SET @LICH := 31083;
SET @SAFIRDRANG := 31050;
SET @GO := 193028;

-- War Horn of Jotunheim
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=@GO;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GO AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@GO,1,0,0,70,0,100,0,2,0,0,0,12,@VARDMADRA,7,0,0,0,0,8,0,0,0,7106.908,4297.093,878.8568,2.04669,'War Horn of Jotunheim - on activate - Summon Vardmadra');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@GO AND `SourceId`=1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(22,1,@GO,1,0,29,0,@VARDMADRA,100,0,1,0,0,'', 'War Horn of Jotunheim - Run SAI if not near Vardmadra'),
(22,1,@GO,1,0,29,0,@LICH,100,0,1,0,0,'', 'War Horn of Jotunheim - Run SAI if not near The Lich King');

-- Possessed Vardmadra
UPDATE `creature_template` SET `AIName`='SmartAI', `InhabitType`=4 WHERE `entry`=@VARDMADRA;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@VARDMADRA AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@VARDMADRA,0,0,1,25,0,100,0,0,0,0,0,11,58102,2,0,0,0,0,1,0,0,0,0,0,0,0,'Possessed Vardmadra - Reset - Cast Possession'),
(@VARDMADRA,0,1,2,61,0,100,0,0,0,0,0,90,2,3,0,0,0,0,1,0,0,0,0,0,0,0,'Possessed Vardmadra - Reset - Set hover'),
(@VARDMADRA,0,2,0,61,0,100,0,0,0,0,0,69,1,0,0,0,0,0,8,0,0,0,7092.94,4330.55,877.027,0,'Possessed Vardmadra - Reset - Move to position'),
(@VARDMADRA,0,3,0,34,0,100,0,8,1,0,0,1,0,3000,0,0,0,0,1,0,0,0,0,0,0,0,'Possessed Vardmadra - Movementinform - Say text'),
(@VARDMADRA,0,4,0,52,0,100,0,0,@VARDMADRA,0,0,12,@SAFIRDRANG,7,0,0,0,0,8,0,0,0,7098.329,4422.865,866.218,4.472738,'Possessed Vardmadra - Text over - Summon Safirdrang'),
(@VARDMADRA,0,5,0,38,0,100,0,0,2,0,0,69,2,0,0,0,0,0,8,0,0,0,7092.608,4330.807,869.4844,0,'Possessed Vardmadra - Data set - Move to position'),
(@VARDMADRA,0,6,7,34,0,100,0,8,2,0,0,91,2,3,0,0,0,0,1,0,0,0,0,0,0,0,'Possessed Vardmadra - Movementinform - Remove hover'),
(@VARDMADRA,0,7,8,61,0,100,0,0,0,0,0,66,0,0,0,0,0,0,19,@LICH,0,0,0,0,0,0,'Possessed Vardmadra - Movementinform - Turn to Lich King'),
(@VARDMADRA,0,8,0,61,0,100,0,0,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,'Possessed Vardmadra - Movementinform - Kneel'),
(@VARDMADRA,0,9,10,38,0,100,0,0,3,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,'Possessed Vardmadra - Data set - Remove Kneel'),
(@VARDMADRA,0,10,0,61,0,100,0,0,3,0,0,90,7,0,0,0,0,0,1,0,0,0,0,0,0,0,'Possessed Vardmadra - Data set - Play dead'),
(@VARDMADRA,0,11,0,38,0,100,0,1,1,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Possessed Vardmadra - Data set - Despawn');

DELETE FROM `creature_text` WHERE `entry`=@VARDMADRA;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@VARDMADRA,0,0,'He''s on his way!',14,0,100,0,0,15643,'Possessed Vardmadra'),
(@VARDMADRA,1,0,'Wrong, Balargarde. You WILL accept this challenge!',14,0,100,0,0,15644,'Possessed Vardmadra'),
(@VARDMADRA,2,0,'My lord.',14,0,100,0,0,15645,'Possessed Vardmadra'),
(@VARDMADRA,3,0,'But...!',14,0,100,0,0,15646,'Possessed Vardmadra');

-- Overthane Balargarde
UPDATE `creature_template` SET `faction_A`=14, `faction_H`=14, `AIName`='', `ScriptName`='npc_overthane_balargarde' WHERE `entry`=@BALARGARDE;
DELETE FROM `creature_text` WHERE `entry`=@BALARGARDE;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@BALARGARDE,0,0,'You dare to challenge me? You haven''t earned the right!',14,0,100,1,0,15633,'Overthane Balargarde'),
(@BALARGARDE,1,0,'Vardmadra?! Did the Lich King send you personally?',14,0,100,1,0,15634,'Overthane Balargarde'),
(@BALARGARDE,2,0,'Very well. I will dispatch these creatures. It is only an inconvenience. Prepare to die!',14,0,100,0,0,15635,'Overthane Balargarde'),
(@BALARGARDE,3,0,'Safirdrang, let them feel the chill of Icecrown!',14,0,100,0,0,15636,'Overthane Balargarde'),
(@BALARGARDE,4,0,'STOP! Kneel you fools, it''s the Lich King!',14,0,100,0,0,15637,'Overthane Balargarde'),
(@BALARGARDE,5,0,'But, my lord...?',14,0,100,0,0,15638,'Overthane Balargarde'),
(@BALARGARDE,6,0,'DIE DOGS!',14,0,100,0,0,15639,'Overthane Balargarde');

-- The Lich King
UPDATE `creature_template` SET `faction_A`=14, `faction_H`=14, `unit_flags`=unit_flags|256|512, `AIName`='SmartAI', `speed_walk`=2 WHERE `entry`=@LICH;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@LICH AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@LICH,0,0,1,54,0,100,0,0,0,0,0,11,34776,2,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Text over - Set data Safirdrang'),
(@LICH,0,1,2,61,0,100,0,0,0,0,0,45,0,2,0,0,0,0,19,@VARDMADRA,0,0,0,0,0,0,'The Lich King - Just summoned - Set data Vardmadra'),
(@LICH,0,2,0,61,0,100,0,0,0,0,0,1,4,5000,0,0,0,0,19,@BALARGARDE,0,0,0,0,0,0,'The Lich King - Just summoned - Say text (Balargarde)'),
(@LICH,0,3,0,52,0,100,0,4,@BALARGARDE,0,0,1,0,7000,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Text over - Say text'),
(@LICH,0,4,5,52,0,100,0,0,@LICH,0,0,1,1,10000,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Text over - Say text'),
(@LICH,0,5,0,61,0,100,0,0,0,0,0,69,1,0,0,0,0,0,8,0,0,0,7093.125,4335.934,871.5744,0,'The Lich King - Text over - Move to position'),
(@LICH,0,6,0,34,0,100,0,8,1,0,0,66,0,0,0,0,0,0,19,@VARDMADRA,0,0,0,0,0,0,'The Lich King - Movementinform - Face Vardmadra'),
(@LICH,0,7,0,52,0,100,0,1,@LICH,0,0,1,2,2500,0,0,0,0,19,@VARDMADRA,0,0,0,0,0,0,'The Lich King - Text over - Say text (Vardmadra)'),
(@LICH,0,8,0,52,0,100,0,2,@VARDMADRA,0,0,1,2,10000,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Text over - Say text (Vardmadra)'),
(@LICH,0,9,10,52,0,100,0,2,@LICH,0,0,1,3,5000,0,0,0,0,19,@VARDMADRA,0,0,0,0,0,0,'The Lich King - Text over - Say text (Vardmadra)'),
(@LICH,0,10,11,61,0,100,0,0,0,0,0,45,0,3,0,0,0,0,19,@VARDMADRA,0,0,0,0,0,0,'The Lich King - Text over - Say text (Vardmadra)'),
(@LICH,0,11,0,61,0,100,0,0,0,0,0,5,36,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Text over - Play emote'),
(@LICH,0,12,13,52,0,100,0,3,@VARDMADRA,0,0,66,0,0,0,0,0,0,19,@BALARGARDE,0,0,0,0,0,0,'The Lich King - Text over - Face Balargarde'),
(@LICH,0,13,0,61,0,100,0,0,0,0,0,1,3,5000,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Text over - Say text'),
(@LICH,0,14,0,52,0,100,0,3,@LICH,0,0,1,5,3000,0,0,0,0,19,@BALARGARDE,0,0,0,0,0,0,'The Lich King - Text over - Say text (Balargarde)'),
(@LICH,0,15,0,52,0,100,0,5,@BALARGARDE,0,0,1,4,5000,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Text over - Say text'),
(@LICH,0,16,0,52,0,100,0,4,@LICH,0,0,69,2,0,0,0,0,0,8,0,0,0,7088.302,4382.2,872.3046,0,'The Lich King - Text over - Move to position'),
(@LICH,0,17,18,34,0,100,0,8,2,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Movementinform - Set orientation'),
(@LICH,0,18,0,61,0,100,0,0,0,0,0,45,0,2,0,0,0,0,19,@BALARGARDE,0,0,0,0,0,0,'The Lich King - Movementinform - Set data Balargarde'),
(@LICH,0,19,0,34,0,100,0,8,3,0,0,1,5,7000,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Movementinform - Say text'),
(@LICH,0,20,0,52,0,100,0,5,@LICH,0,0,1,6,5000,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Text over - Say text'),
(@LICH,0,21,22,52,0,100,0,6,@LICH,0,0,45,1,1,0,0,0,0,19,@SAFIRDRANG,0,0,0,0,0,0,'The Lich King - Text over - Set data Safirdrang'),
(@LICH,0,22,23,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,@VARDMADRA,0,0,0,0,0,0,'The Lich King - Text over - Set data Safirdrang'),
(@LICH,0,23,24,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,9,@ELITE,0,100,0,0,0,0,'The Lich King - Text over - Set data Safirdrang'),
(@LICH,0,24,25,61,0,100,0,0,0,0,0,11,34776,2,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Text over - Cast cosmetic teleport'),
(@LICH,0,25,0,61,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Lich King - Text over - Despawn');

DELETE FROM `creature_text` WHERE `entry`=@LICH;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@LICH,0,0,'Honor guard stay where you are.',14,0,100,0,0,15600,'The Lich King - Banshee''s Revenge'),
(@LICH,1,0,'Vardmadra. I''d wondered where you disappeared to. How is Iskalder?',14,0,100,0,0,15601,'The Lich King - Banshee''s Revenge'),
(@LICH,2,0,'I see through your disguse, Lady Nightswood. YOU THINK THAT YOU CAN FOOL ME?!',14,0,100,0,0,15602,'The Lich King - Banshee''s Revenge'),
(@LICH,3,0,'You may continue your combat, overthane.',14,0,100,0,0,15603,'The Lich King - Banshee''s Revenge'),
(@LICH,4,0,'But nothing! Finish them! DO NOT FAIL ME, BALARGARDE!',14,0,100,0,0,15604,'The Lich King - Banshee''s Revenge'),
(@LICH,5,0,'You have bested one of my finest, but your efforts are for naught.',14,0,100,0,0,15605,'The Lich King - Banshee''s Revenge'),
(@LICH,6,0,'The frozen heart of Icecrown awaits...',14,0,100,0,0,15606,'The Lich King - Banshee''s Revenge');

-- Safirdrang
UPDATE `creature_template` SET `AIName`='SmartAI', `InhabitType`=4, `faction_A`=14, `faction_H`=14, `VehicleId`=108 WHERE `entry`=@SAFIRDRANG;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@SAFIRDRANG AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@SAFIRDRANG,0,0,1,54,0,100,0,0,0,0,0,12,@BALARGARDE,6,15000,0,0,0,1,0,0,0,0,0,0,0,'Safirdrang - Just summoned - Summon Balargarde'),
(@SAFIRDRANG,0,1,0,61,0,100,0,0,0,0,0,53,0,@SAFIRDRANG,0,0,0,0,1,0,0,0,0,0,0,0,'Safirdrang - Just summoned - Wp start'),
(@SAFIRDRANG,0,2,0,40,0,100,0,2,@SAFIRDRANG,0,0,1,0,8000,0,0,0,0,19,@BALARGARDE,0,0,0,0,0,0,'Safirdrang - Wp reached - Balargarde say text'),
(@SAFIRDRANG,0,3,0,52,0,100,0,0,@BALARGARDE,0,0,1,1,8000,0,0,0,0,19,@VARDMADRA,0,0,0,0,0,0,'Safirdrang - Text over - Vardmadra say text'),
(@SAFIRDRANG,0,4,0,52,0,100,0,1,@VARDMADRA,0,0,1,1,7000,0,0,0,0,19,@BALARGARDE,0,0,0,0,0,0,'Safirdrang - Text over - Balargarde say text'),
(@SAFIRDRANG,0,5,6,52,0,100,0,1,@BALARGARDE,0,0,28,46598,0,0,0,0,0,1,0,0,0,0,0,0,0,'Safirdrang - Text over - Vardmadra say text'),
(@SAFIRDRANG,0,6,0,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,19,@BALARGARDE,0,0,0,0,0,0,'Safirdrang - Text over - Set data Balargarde'),
(@SAFIRDRANG,0,7,0,38,0,100,0,1,1,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Safirdrang - Text over - Vardmadra say text');

DELETE FROM `waypoints` WHERE `entry`=@SAFIRDRANG;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@SAFIRDRANG,1,7091.547363,4396.269043,887.361,'Safirdrang'),
(@SAFIRDRANG,2,7085.461,4370.887,887.361,'Safirdrang');

DELETE FROM `creature_template_addon` WHERE `entry`=@SAFIRDRANG;
INSERT INTO `creature_template_addon` (`entry`,`bytes1`) VALUES
(@SAFIRDRANG,50331648);
