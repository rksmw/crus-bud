-- Quest - Out of Body Experience
-- ------------------------------------------------------------------------------------------------------
SET @Arug       = 27620;    -- Shade of Arugal
SET @Vala       = 27619;    -- Valanar
SET @Ther       = 27624;    -- Theraldis
SET @Kele       = 27618;    -- Keleseth
SET @Athe       = 27616;    -- Atherann    
SET @Channel    = 49128;    -- Arugal Event Channel
SET @NPCAura    = 49130;    -- Arugal Event Invisibility 
SET @PAura      = 49097;    -- Out of Body Experience Invisibility + Detection + Teleport Silverpine
SET @Teleb      = 49098;    -- Quest Credit??? + Teleport back
SET @QCredit    = 49131;    -- Out of Body Experience Quest Credit
SET @Bunny      = 27622;    -- Arugal Rotation Bunny
-- ------------------------------------------------------------------------------------------------------
-- update creature_templates
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `AIName` = 'SmartAI' ,`unit_flags` = 2, `flags_extra`=0 WHERE entry IN (@Vala,@Kele,@Athe);
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `AIName` = 'SmartAI' ,`unit_flags` =unit_flags|2|131072, `flags_extra`= flags_extra|2 WHERE entry=@Ther;
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `InhabitType` = 4, `unit_flags` =unit_flags|2|131072 WHERE entry = @Arug;
UPDATE `creature_template` SET `unit_flags` = 2, `flags_extra` = 128, `InhabitType` = 4, `type_flags` = 1024 WHERE entry = @Bunny;
-- spawn Creatures
DELETE FROM `creature` WHERE `id` IN (@Arug,@Vala,@Ther,@Kele,@Athe,@Bunny);
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@Arug,0,1,1,0,0,-463.526,1499.51,20.4721,1.55035,300,0,0,10635,0,0,0,0,0),
(@Athe,0,1,1,0,0,-458.712,1504.8,16.9815,3.93558,300,0,0,29820,0,0,0,0,0),
(@Kele,0,1,1,0,0,-471.433,1500.51,18.4603,0.024287,300,0,0,28830,0,0,0,0,0),
(@Vala,0,1,1,0,0,-462.81,1491.7,17.2292,1.65734,300,0,0,96100,3309,0,0,0,0),
(@Ther,0,1,1,0,0,-472.925,1495.71,18.3354,0.577431,300,0,0,28830,0,0,0,0,0),
(@Bunny,0,1,1,0,0,-463.526,1499.51,20.4721,4.4418,300,0,0,10635,0,0,0,0,0);
-- Cast: Teleport back on AuraRemove: Out of Body Experience 
DELETE FROM `spell_linked_spell` WHERE `spell_effect` = @Teleb;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES 
(-@PAura,@Teleb,0,'on Remove Out of Body Experience - Tele back');
-- define Teleport Destinations
DELETE FROM `spell_target_position` WHERE `id` IN (@PAura,@Teleb);
INSERT INTO `spell_target_position` (`id`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES 
(@PAura,0,-465.413,1496.71,17.379,1.068),       -- Silverpine Forrest
(@Teleb,571,3842.16,-3428.43,293.105,1.8776);   -- Grizzly Hills
-- creature_text
DELETE FROM `creature_text` WHERE `entry` IN (@Vala,@Ther);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(@Vala,0,0,"Rise, Arugal! The power of the Lich King commands you!",12,0,100,0,0,0,'Prince Valanar at SilverpineForrest - say text'),
(@Ther,0,0,"Yes... he shall suit our needs perfectly. Have him sent to Solstice Village when you're ready. Arthas will not be pleased if we fall behind schedule.",12,0,100,0,0,0,'Prince Theraldis at SilverpineForrest - say text');
-- Auras
DELETE FROM `creature_template_addon` WHERE `entry` IN (@Arug,@Vala,@Ther,@Kele,@Athe,@Bunny);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES 
(@Ther,0,10721,0,4097,0,'49130'), -- Theraldis add Mount: Purple Skeletal Warhorse
(@Vala,0,0,0,4097,0,'49130'),
(@Kele,0,0,0,4097,0,'49130'),
(@Athe,0,0,0,4097,0,'49130'),
(@Arug,0,0,0,4097,26,'49130'),
(@Bunny,0,0,0,4097,0,'49130');
-- SAI
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (@Vala,@Ther,@Kele,@Athe);
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` = @Ther*100;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
-- Valanar
(@Vala,0,0,0,25,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Prince Valanar - Reset - React Passive'),
(@Vala,0,1,0,1,0,100,1,0,0,0,0,11,@Channel,2,0,0,0,0,19,@Bunny,15,0,0,0,0,0, 'Prince Valanar - OOC - cast Channelspell at Arugal'),
-- Keleseth
(@Kele,0,0,0,25,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Prince Keleseth - Reset - React Passive'),
(@Kele,0,1,0,1,0,100,1,0,0,0,0,11,@Channel,2,0,0,0,0,19,@Bunny,15,0,0,0,0,0, 'Prince Keleseth - OOC - cast Channelspell at Arugal'),
-- Atherann
(@Athe,0,0,0,25,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Prince Atherann - Reset - React Passive'),
(@Athe,0,1,0,1,0,100,1,0,0,0,0,11,@Channel,2,0,0,0,0,19,@Bunny,15,0,0,0,0,0, 'Prince Atherann - OOC - cast Channelspell at Arugal'),
-- Theraldis
(@Ther,0,0,0,25,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Prince Theraldis - Reset - Set phase 1'),
(@Ther,0,1,0,10,1,100,0,0,10,0,0,80,@Ther*100,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Prince Theraldis - on LOS - start script'),
(@Ther*100,9,0,0,0,0,100,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Prince Theraldis - Script - Set phase 2'),
(@Ther*100,9,1,0,0,0,100,0,5000,5000,0,0,1,0,0,0,0,0,0,19,@Vala,15,0,0,0,0,0, 'Prince Theraldis - Script - Say text (Valanar)'),
(@Ther*100,9,2,0,0,0,100,0,7000,7000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Prince Theraldis - Script - Say text'),
(@Ther*100,9,3,0,0,0,100,0,5000,5000,0,0,11,@QCredit,2,0,0,0,0,7,0,0,0,0,0,0,0, 'Prince Theraldis - Script - give quest credit'),
(@Ther*100,9,4,0,0,0,100,0,1000,1000,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Prince Theraldis - Script - Set phase 1');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@Ther AND `SourceId`=0;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=@Channel;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(22,2,@Ther,0,9,12327,0,0,0,'','Prince Theraldis - activate SAI if invoker has quest'),
(13,1,@Channel,0,31,3,@Bunny,0,0,'','Arugal Event Channel - implicit target - Arugal Rotation Bunny');
