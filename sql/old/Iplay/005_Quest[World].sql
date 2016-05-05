-- Fix [Quest] A Dark Influence
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (27263,27264,27265);
INSERT INTO `smart_scripts` VALUES 
(27263,0,0,0,8,0,100,0,48218,1,0,0,33,27263,0,0,0,0,0,7,0,0,0,0,0,0,0,'Vordrasills Heart Kill credit'),
(27264,0,0,0,8,0,100,0,48218,1,0,0,33,27264,0,0,0,0,0,7,0,0,0,0,0,0,0,'Vordrasills Limb Kill credit'),
(27265,0,0,0,8,0,100,0,48218,1,0,0,33,27265,0,0,0,0,0,7,0,0,0,0,0,0,0,'Vordrasills Tears Kill credit');
UPDATE `creature_template`  SET `AIName`  = "SmartAI" WHERE `entry`  IN  (27263,27264,27265);

-- Fix [Quest] Seared Scoruge
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=26570);
DELETE FROM `creature_template_addon` WHERE (`entry`=26570);
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=26570;
DELETE FROM `smart_scripts` WHERE (`entryorguid`=26570 AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26570, 0, 0, 0, 8, 0, 100, 0, 47214, 0, 0, 0, 11, 42726, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Famished Scourge Troll in Spellhit Cast Cosmetic Immolation (Whole Body)'),
(26570, 0, 1, 0, 8, 0, 100, 0, 47214, 0, 0, 0, 11, 47208, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Famished Scourge Troll in Spell Hit Cast Kill Credit Spell For Player'),
(26570, 0, 2, 0, 8, 0, 100, 0, 47214, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Famished Scourge Troll Dies In Spell Hit'),
(26570, 0, 3, 0, 1, 0, 100, 0, 100, 100, 5000, 5000, 11, 47178, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Famished Scourge Troll Cast Cosmetic Plague in Self ICC');


UPDATE `quest_template` SET `RequiredNpcOrGo1` =26612,`RequiredNpcOrGoCount1` =20 WHERE `Id` =12029;
UPDATE `quest_template` SET `RequiredNpcOrGo1` =26612,`RequiredNpcOrGoCount1` =30 WHERE `Id` =12038;
UPDATE `creature` SET `spawntimesecs` = 60, `MovementType` = 1, `spawndist` = 10 WHERE `id` =26570;
UPDATE `creature_template` SET `speed_run` = 6, `spell1` = 51744 WHERE `entry` =26570;


-- [Quest] Wanton Warlord
DELETE FROM `event_scripts` WHERE `id`=17767;
INSERT INTO `event_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(17767,0,10,27002,300000,0,2791.477,381.7451,77.19083,2.6067);
DELETE FROM `creature_text` WHERE `entry`=27002;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(27002,0,0,'I''ll consume your flesh and pick my teeth with your bones!',14,0,100,0,0,0,'Grom''thar the Thunderbringer'),
(27002,1,0,'You''re no magnataur!  Where... did you... find... such strength?',14,0,100,0,0,0,'Grom''thar the Thunderbringer');

-- Fix de TC en  e2cf1b018646dc9bbae449e36def0dc455f21468 DB/Quests: Fix Conversing With the Depths, closes #3048
-- -- Conversing with the Deeps
-- DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=26570);
-- DELETE FROM `creature_template_addon` WHERE (`entry`=26570);
-- UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=26570;
-- DELETE FROM `smart_scripts` WHERE (`entryorguid`=26570 AND `source_type`=0);
-- INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- (26570, 0, 0, 0, 8, 0, 100, 0, 47214, 0, 0, 0, 11, 42726, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Famished Scourge Troll in Spellhit Cast Cosmetic Immolation (Whole Body)'),
-- (26570, 0, 1, 0, 8, 0, 100, 0, 47214, 0, 0, 0, 11, 47208, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Famished Scourge Troll in Spell Hit Cast Kill Credit Spell For Player'),
-- (26570, 0, 2, 0, 8, 0, 100, 0, 47214, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Famished Scourge Troll Dies In Spell Hit'),
-- (26570, 0, 3, 0, 1, 0, 100, 0, 100, 100, 5000, 5000, 11, 47178, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Famished Scourge Troll Cast Cosmetic Plague in Self ICC');
-- DELETE FROM `conditions` WHERE `SourceEntry` = 47214;
-- INSERT INTO `conditions` VALUES ('13', '0', '47214', '0', '18', '1', '26570', '0', '0', '0','0','0','0', '', 'Spell Burninate Effect only Famished Scourge Troll');
-- UPDATE `quest_template` SET `RequiredNpcOrGo1` =26612,`RequiredNpcOrGoCount1` =20 WHERE `Id` =12029;
-- UPDATE `quest_template` SET `RequiredNpcOrGo1` =26612,`RequiredNpcOrGoCount1` =30 WHERE `Id` =12038;
-- UPDATE `creature` SET `spawntimesecs` = 60, `MovementType` = 1, `spawndist` = 10 WHERE `id` =26570;
-- UPDATE `creature_template` SET `speed_run` = 6, `spell1` = 51744 WHERE `entry` =26570;

-- [Quest] Lumber hack
UPDATE `creature_template` SET `VehicleId`=42,`spell1`=47938,`spell2`=47921,`spell3`=49857,`spell4`=47966,`spell6`=47939,`RegenHealth`=0 WHERE `entry`=27061;
-- Creature Gossip_menu_option Update from sniff
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (9422) AND `id` IN (0);
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(9422,0,0, 'I seem to have misplaced your Shredder Control Device... might you have another?',1,1,0,0,0,0, '');
-- Gossip option conditions "Quest marked from  w1sht0l1v3"
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=15 AND `SourceGroup`=9422);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,9422,0,1,9,12050,0,0,0,'','Show gossip only if Lumber Hack quest is taken'),
(15,9422,0,1,26,36734,0,0,0,'','Show gossip only if player does not have item Xink''s Shredder Control Device'),
(15,9422,0,2,26,36734,0,0,0,'','Show gossip option if player does not have item Xink''s Shredder Control Device'),
(15,9422,0,2,9,12052,0,0,0,'','Show gossip option if player has quest marked as taken');
-- NPC talk text insert from sniff
DELETE FROM `creature_text` WHERE `entry` IN (26660,27061) AND `groupid` IN (0);
DELETE FROM `creature_text` WHERE `entry` IN (26660,27061) AND `groupid` IN (1);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(26660,0,0, 'About time!  Get that lumber and get moving.  The horde won''t be up there fighting forever, there''s money to be made!',12,0,100,25,1000,0, 'Xink'),
(27061,0,0, 'Xink''s Shredder ready and available for woodland destruction.',16,0,100,0,0,0, 'Xink''s Shredder'),
(27061,1,0, 'Xink''s Shredder security features activated.  Returning to base.',16,0,100,0,0,0, 'Xink''s Shredder');
-- SAI for Xink
SET @ENTRY := 26660; -- NPC entry
SET @SPELL := 52872; -- Forceitem Xink's Shredder
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,0,0,0,19,0,100,0,12050,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Xink - On Quest Accept - say 0'),
(@ENTRY,0,1,2,62,0,100,0,9422,0,0,0,11,@SPELL,0,0,0,0,0,7,0,0,0,0,0,0,0,'Xink - On Gossip option select - Cast Forceitem Xink''s Shredder'),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Xink - On Gossip option select - Close Gossip');
DELETE FROM npc_spellclick_spells WHERE npc_entry=27061;
INSERT INTO npc_spellclick_spells (npc_entry, spell_id, cast_flags) VALUES (27061, 47920, 1);

-- Quest: Slim Pickings(12075)
DELETE FROM `creature_ai_scripts` WHERE (`creature_id`=26809);
UPDATE `creature_template` SET npcflag = '1', `AIName`='SmartAI' WHERE `entry`= 26809;
DELETE FROM `smart_scripts` WHERE (`entryorguid`=26809);
INSERT INTO `smart_scripts` VALUES
(26809, 0, 0, 1, 64, 0, 100, 0, 0, 0, 0, 0, 56, 36765, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0,''),
(26809, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'');
