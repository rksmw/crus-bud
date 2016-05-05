DELETE FROM `conditions` WHERE `SourceEntry` IN (42393) AND `ConditionValue2` IN (23702,23700,23706,24373,24372);
DELETE FROM `conditions` WHERE `SourceEntry`=42299 AND `ConditionValue2`=0;
SET @GUID := 1000179;
DELETE FROM `creature` WHERE `id` IN (23703,24536) AND `guid` IN (@GUID+0,@GUID+1,@GUID+2,@GUID+3);
DELETE FROM `game_event_creature` WHERE `eventEntry`=24 AND `guid` IN (@GUID+0,@GUID+1,@GUID+2,@GUID+3);
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=42535 AND `spell_effect`=42518;
DELETE FROM `conditions` WHERE `SourceEntry` IN (42695,42794,42341) AND `ConditionValue2` IN (23709);
SET @ENTRY := 23703;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-(@GUID+0),-(@GUID+3),@ENTRY*100,@ENTRY*100+1,@ENTRY*100+2,@ENTRY*100+3);
SET @ENTRY := 23894;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100);
SET @ENTRY := 24536;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-(@GUID+1),-(@GUID+2),@ENTRY*100,@ENTRY*100+1,@ENTRY*100+2);
SET @ENTRY1 := 23702; -- Thunderbrew Festive Keg
SET @ENTRY2 := 23700; -- Barleybrew Festive Keg
SET @ENTRY3 := 23706; -- Gordok Festive Keg
SET @ENTRY4 := 24373; -- T'chalis's Festive Keg
SET @ENTRY5 := 24372; -- Drohn's Festive Keg
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY1,@ENTRY2,@ENTRY3,@ENTRY4,@ENTRY5);
SET @ENTRY1 := 186184;
SET @ENTRY2 := 186189;
SET @ENTRY3 := 186185;
SET @ENTRY4 := 186187;
SET @ENTRY5 := 186186;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY1,@ENTRY2,@ENTRY3,@ENTRY4,@ENTRY5);

-- --------------------
-- Dark IRON EVENT
-- ----------------------
SET @guid := 303108;
SET @event := 85;
UPDATE `creature_template` SET `ScriptName`='npc_dark_iron_herald' WHERE `entry`=24536;
UPDATE `creature_template` SET `ScriptName`='npc_dark_iron_guzzler' WHERE `entry`=23709;
UPDATE `gameobject_queststarter` SET `id`=189989 WHERE `quest`=12020;
UPDATE `quest_template` SET `PrevQuestId`=0 WHERE `Id`=12020;
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (3557,3558);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
('3557','0','0','0',''),
('3558','0','0','0','');
DELETE FROM `creature` WHERE `id`=24536;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@guid,'24536','1','1','1','0','0','1199.34','-4293.03','21.2255','2.15038','420','0','0','16026','0','0','0','0','0'),
(@guid+1,'24536','0','1','1','0','0','-5158.79','-604.12','398.199','5.00486','420','0','0','16026','0','0','0','0','0');
DELETE FROM `game_event_creature` WHERE `eventEntry`=@event;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(@event,@guid),
(@event,@guid+1);
DELETE FROM `game_event` WHERE `eventEntry`=@event;
INSERT INTO `game_event` (`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `description`, `world_event`) VALUES
(@event,'2010-09-20 00:00:00','2020-12-31 06:00:00','30','8','0','Brewfest - Dark Iron Attack','0');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (47344,47310);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) 
VALUES
(13, 47310, 18, 1, 0),                                 
(13, 47344, 18, 1, 26764), (13, 47344, 18, 1, 26822);  

DELETE FROM `spell_scripts` WHERE `id`=47344;
INSERT INTO `spell_scripts` (`id`, `effIndex`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) 
VALUES 
(47344, 0, 0, 15, 47339, 3, 0, 0, 0, 0, 0); 
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 47371;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) 
VALUES
(47371, -47376, 1, 'Remove Visual Buff'),
(47371, -47331, 1, 'Remove Has Brew Aura');
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (23872,26822,26764);
UPDATE `quest_template` SET `SpecialFlags`=9 WHERE `Id`=25483;
UPDATE `creature_template` SET `npcflag`=3 WHERE `entry`=23872;
