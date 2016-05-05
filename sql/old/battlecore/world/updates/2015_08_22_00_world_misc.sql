-- Quest - Sniffing Out the Perpetrator
SET @ENTRY_A := 29677;
SET @ENTRY_H := 29903;
SET @PURSUER := 29696;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_frosthound', `spell1`=54997, `spell2`=54996 WHERE `entry`=@ENTRY_A;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_frostbite', `spell1`=54997, `spell2`=54996, `minlevel`=79, `maxlevel`=79, `Health_mod`=1.5, `unit_class`=1 WHERE `entry`=@ENTRY_H;
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_A`=1954, `faction_H`=1954, `speed_run`=1.64285 WHERE `entry`=@PURSUER;

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=29857;
INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`cast_flags`,`user_type`) VALUES
(29857,55460,3,0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=18 AND `SourceEntry`=55460;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`comment`) VALUES
(18,29857,55460,0,9,0,12910,0,'Frostbite - Spelclick - Need quest 12910 taken'),
(18,29857,55460,0,9,0,12855,0,'Frostbite - Spelclick - Need quest 12855 taken');

DELETE FROM `creature_template_addon` WHERE `entry` IN (@ENTRY_A,@ENTRY_H);
INSERT INTO `creature_template_addon` (`entry`,`auras`) VALUES
(@ENTRY_A,'54993'),
(@ENTRY_H,'54993');

DELETE FROM `creature_text` WHERE `entry` IN (@ENTRY_A,@ENTRY_H);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY_A,0,0,'You''ve been seen! Use the net and Ice Slick to keep the dwarves away!',42,0,100,0,0,0,'Frosthound'),
(@ENTRY_A,1,0,'The frosthound has located the thief''s hiding place. Confront him!',42,0,100,0,0,0,'Frosthound'),
(@ENTRY_H,0,0,'The iron dwarves followed you! Use the net and Ice Slick to escape!',42,0,100,0,0,0,'Frostbite');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@PURSUER) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@PURSUER,0,0,0,9,0,100,0,5,30,7000,11000,11,55007,2,0,0,0,0,2,0,0,0,0,0,0,0,'Stormforged Pursuer - At distance - Cast Throw Hammer'),
(@PURSUER,0,1,0,1,0,100,1,1000,1000,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormforged Pursuer - 1 sec OOC - Despawn');

UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=100 WHERE `item`=40971;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceEntry`=40971;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`comment`) VALUES
(1,29695,40971,0,9,0,12910,0,'Brann Communicator - Drop if quest 12910 taken'),
(1,29695,40971,1,28,0,12910,0,'Brann Communicator - Drop if quest 12910 completed'),
(1,29695,40971,2,9,0,12855,0,'Brann Communicator - Drop if quest 12855 taken'),
(1,29695,40971,3,28,0,12855,0,'Brann Communicator - Drop if quest 12855 completed');
