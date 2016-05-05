UPDATE `creature_template` SET `modelid1`=11686, `minlevel`=30, `maxlevel`=30, `faction_A`=35, `faction_H`=35, `ScriptName`='npc_apple_trap_bunny' WHERE `entry`=24263;
UPDATE `creature_template` SET `modelid1`=11686, `minlevel`=30, `maxlevel`=30, `ScriptName`='npc_bark_bunny' WHERE `entry` IN (24202,24203,24204,24205);
UPDATE `quest_template` SET `SourceSpellId`=43883 WHERE `Id` IN (11409,11412,11318,11122,11293,11294,11407,11408);
UPDATE `quest_template` SET `RewardItemCount1`=25 WHERE `Id` IN (11293,11294,11407,11408);
UPDATE `creature_template` SET `ScriptName`='npc_keg_delivery' WHERE `entry` IN (24364,24527,24497,23558);
UPDATE `creature_template` SET `npcflag`=3 WHERE `entry` IN (24497,23558);
UPDATE `creature_template` SET `minlevel`=30, `maxlevel`=30 WHERE `entry`=24527;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=43662;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
(13,43662,18,1,24468),
(13,43662,18,1,24510);
DELETE FROM `spell_linked_spell` WHERE `spell_effect`=-43052;
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(-43883,-43052,0, 'Remove Ram Fatigue with Rental Racing Ram');
SET @guid := 303065;
SET @go_guid := 400045;
DELETE FROM `creature` WHERE `id` IN (24202,24203,24204,24205,24527,24263);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@guid,24202,1,1,1,0,0,1652.82,-4425.6,16.7553,1.94068,180,0,0,42,0,0,0,0,0),
(@guid+1,24202,0,1,1,0,0,-4919.44,-941.245,501.562,5.38547,180,0,0,42,0,0,0,0,0),
(@guid+2,24203,1,1,1,0,0,1933.84,-4676.55,27.6472,2.16765,180,0,0,42,0,0,0,0,0),
(@guid+3,24203,0,1,1,0,0,-4959.34,-1199.69,501.659,0.735904,180,0,0,42,0,0,0,0,0),
(@guid+4,24204,1,1,1,0,0,1927.43,-4298.46,25.3459,0.375365,180,0,0,42,0,0,0,0,0),
(@guid+5,24204,0,1,1,0,0,-4690.26,-1235.04,501.66,2.25665,180,0,0,42,0,0,0,0,0),
(@guid+6,24205,1,1,1,0,0,1573.16,-4202.9,43.1776,5.43725,180,0,0,42,0,0,0,0,0),
(@guid+7,24205,0,1,1,0,0,-4679.16,-968.932,501.658,3.88478,180,0,0,42,0,0,0,0,0),
(@guid+8,24527,1,1,1,22508,0,841.342,-4511.96,5.63413,0.134843,10,0,0,44,0,0,0,0,0),
(@guid+9,24263,1,1,1,0,0,1290.72,-4433.38,28.9128,2.38741,180,0,0,102,0,0,0,0,0),
(@guid+10,24263,1,1,1,0,0,1096.47,-4427.09,21.9768,0.600628,180,0,0,102,0,0,0,0,0),
(@guid+11,24263,1,1,1,0,0,1004.37,-4479.23,12.6481,1.44494,180,0,0,102,0,0,0,0,0),
(@guid+12,24263,1,1,1,0,0,813.71,-4550.15,6.76704,0.526026,180,0,0,102,0,0,0,0,0),
(@guid+13,24263,0,1,1,0,0,-5189.01,-482.731,389.012,3.23857,180,0,0,102,0,0,0,0,0),
(@guid+14,24263,0,1,1,0,0,-5355.19,-527.227,393.217,0.866664,180,0,0,102,0,0,0,0,0),
(@guid+15,24263,0,1,1,0,0,-5621.26,-477.593,398.716,6.23093,180,0,0,102,0,0,0,0,0),
(@guid+16,24263,0,1,1,0,0,-5492.14,-528.144,399.901,1.56881,180,0,0,102,0,0,0,0,0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN @go_guid AND @go_guid+3;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@go_guid,'186717','1','1','1','819.338','-4506.86','7.81105','5.85064','0','0','0.214592','-0.976704','300','0','1'),
(@go_guid+1,'186331','0','1','1','-5492.23','-528.114','398.163','1.502','0','0','0.68237','0.731007','300','0','1'),
(@go_guid+2,'186331','0','1','1','-5621.04','-477.656','396.981','6.13355','0','0','0.0747495','-0.997202','300','0','1'),
(@go_guid+3,'186331','1','1','1','813.684','-4550.35','4.98399','0.526033','0','0','0.259995','0.96561','300','0','1');
SET @entry := 86;
SET @guid := 303082;
DELETE FROM `game_event` WHERE `eventEntry` BETWEEN @entry AND @entry+11;
INSERT INTO `game_event` (`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `description`, `world_event`) VALUES
(@entry,'2011-01-01 00:00:00','2020-12-31 06:00:00','525600','44640','0','Brew of the Month - Enero','0'),
(@entry+1,'2011-02-01 00:00:00','2020-12-31 06:00:00','525600','40320','0','Brew of the Month - Febrero','0'),
(@entry+2,'2011-03-01 00:00:00','2020-12-31 06:00:00','525600','44640','0','Brew of the Month - Marzo','0'),
(@entry+3,'2011-04-01 00:00:00','2020-12-31 06:00:00','525600','43200','0','Brew of the Month - Abril','0'),
(@entry+4,'2011-05-01 00:00:00','2020-12-31 06:00:00','525600','44640','0','Brew of the Month - Mayo','0'),
(@entry+5,'2011-06-01 00:00:00','2020-12-31 06:00:00','525600','43200','0','Brew of the Month - Junio','0'),
(@entry+6,'2011-07-01 00:00:00','2020-12-31 06:00:00','525600','44640','0','Brew of the Month - Julio','0'),
(@entry+7,'2011-08-01 00:00:00','2020-12-31 06:00:00','525600','44640','0','Brew of the Month - Agosto','0'),
(@entry+8,'2011-09-01 00:00:00','2020-12-31 06:00:00','525600','43200','0','Brew of the Month - Septiembre','0'),
(@entry+9,'2011-10-01 00:00:00','2020-12-31 06:00:00','525600','44640','0','Brew of the Month - OCtubre','0'),
(@entry+10,'2011-11-01 00:00:00','2020-12-31 06:00:00','525600','43200','0','Brew of the Month - Noviembre','0'),
(@entry+11,'2011-12-01 00:00:00','2020-12-31 06:00:00','525600','44640','0','Brew of the Month - Diciembre','0');
UPDATE `creature_template` SET `gossip_menu_id`=9549, `minlevel`=50, `maxlevel`=50, `faction_A`=35, `faction_H`=35, `npcflag`=129,
      `unit_flags`=768, `ScriptName`='npc_brew_vendor' WHERE `name`='Brew Vendor';
DELETE FROM `creature` WHERE `guid` BETWEEN @guid AND @guid+25;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@guid,'27478','0','1','1','0','356','-4849.93','-862.626','501.914','5.41091','10','0','0','2215','0','0','0','0'),
(@guid+1,'27489','1','1','1','22492','0','1490.75','-4221.22','43.1862','4.71535','10','0','0','2215','0','0','0','0'),
(@guid+2,'27806','0','1','1','0','357','-4845.5','-861.761','501.914','5.019','10','0','0','2215','0','0','0','0'),
(@guid+3,'27806','1','1','1','0','357','1491.61','-4227.44','43.1862','1.75085','10','0','0','2215','0','0','0','0'),
(@guid+4,'27810','0','1','1','0','357','-4845.5','-861.761','501.914','5.019','10','0','0','2215','0','0','0','0'),
(@guid+5,'27810','1','1','1','0','357','1491.61','-4227.44','43.1862','1.75085','10','0','0','2215','0','0','0','0'),
(@guid+6,'27811','0','1','1','0','357','-4845.5','-861.761','501.914','5.019','10','0','0','2215','0','0','0','0'),
(@guid+7,'27811','1','1','1','0','357','1491.61','-4227.44','43.1862','1.75085','10','0','0','2215','0','0','0','0'),
(@guid+8,'27812','0','1','1','0','357','-4845.5','-861.761','501.914','5.019','10','0','0','2215','0','0','0','0'),
(@guid+9,'27812','1','1','1','0','357','1491.61','-4227.44','43.1862','1.75085','10','0','0','2215','0','0','0','0'),
(@guid+10,'27813','0','1','1','0','357','-4845.5','-861.761','501.914','5.019','10','0','0','2215','0','0','0','0'),
(@guid+11,'27813','1','1','1','0','357','1491.61','-4227.44','43.1862','1.75085','10','0','0','2215','0','0','0','0'),
(@guid+12,'27814','0','1','1','0','357','-4845.5','-861.761','501.914','5.019','10','0','0','2215','0','0','0','0'),
(@guid+13,'27814','1','1','1','0','357','1491.61','-4227.44','43.1862','1.75085','10','0','0','2215','0','0','0','0'),
(@guid+14,'27815','0','1','1','0','357','-4845.5','-861.761','501.914','5.019','10','0','0','2215','0','0','0','0'),
(@guid+15,'27815','1','1','1','0','357','1491.61','-4227.44','43.1862','1.75085','10','0','0','2215','0','0','0','0'),
(@guid+16,'27816','0','1','1','0','357','-4845.5','-861.761','501.914','5.019','10','0','0','2215','0','0','0','0'),
(@guid+17,'27816','1','1','1','0','357','1491.61','-4227.44','43.1862','1.75085','10','0','0','2215','0','0','0','0'),
(@guid+18,'27817','0','1','1','0','357','-4845.5','-861.761','501.914','5.019','10','0','0','2215','0','0','0','0'),
(@guid+19,'27817','1','1','1','0','357','1491.61','-4227.44','43.1862','1.75085','10','0','0','2215','0','0','0','0'),
(@guid+20,'27818','0','1','1','0','357','-4845.5','-861.761','501.914','5.019','10','0','0','2215','0','0','0','0'),
(@guid+21,'27818','1','1','1','0','357','1491.61','-4227.44','43.1862','1.75085','10','0','0','2215','0','0','0','0'),
(@guid+22,'27819','0','1','1','0','357','-4845.5','-861.761','501.914','5.019','10','0','0','2215','0','0','0','0'),
(@guid+23,'27819','1','1','1','0','357','1491.61','-4227.44','43.1862','1.75085','10','0','0','2215','0','0','0','0'),
(@guid+24,'27820','0','1','1','0','357','-4845.5','-861.761','501.914','5.019','10','0','0','2215','0','0','0','0'),
(@guid+25,'27820','1','1','1','0','357','1491.61','-4227.44','43.1862','1.75085','10','0','0','2215','0','0','0','0');
DELETE FROM `game_event_creature` WHERE `guid` BETWEEN @guid+2 AND @guid+25;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(@entry,@guid+2),
(@entry,@guid+3),
(@entry+1,@guid+4),
(@entry+1,@guid+5),
(@entry+2,@guid+6),
(@entry+2,@guid+7),
(@entry+3,@guid+8),
(@entry+3,@guid+9),
(@entry+4,@guid+10),
(@entry+4,@guid+11),
(@entry+5,@guid+12),
(@entry+5,@guid+13),
(@entry+6,@guid+14),
(@entry+6,@guid+15),
(@entry+7,@guid+16),
(@entry+7,@guid+17),
(@entry+8,@guid+18),
(@entry+8,@guid+19),
(@entry+9,@guid+20),
(@entry+9,@guid+21),
(@entry+10,@guid+22),
(@entry+10,@guid+23),
(@entry+11,@guid+24),
(@entry+11,@guid+25);
DELETE FROM `npc_vendor` WHERE `entry` IN (27806,27810,27811,27812,27815,27816,27817);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES
('27806','0','37488','0','0','0'),
('27810','0','37489','0','0','0'),
('27811','0','37490','0','0','0'),
('27812','0','37491','0','0','0'),
('27815','0','37494','0','0','0'),
('27816','0','37495','0','0','0'),
('27817','0','37496','0','0','0');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=42436;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
(13,42436,18,1,24108),
(13,42436,18,1,23709);
-- UPDATE `quest_template` SET `RequiredSpellCast1`=42436 WHERE `Id` IN (12022,12191);
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=42436;
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(42436,42435,1, 'Brewfest - Stun');


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
(@event,'2010-09-20 00:00:00','2020-12-31 06:00:00','30','8','0','Braufest - Angriff der Dunkeleisenzwerge','0');

UPDATE `creature_template` SET `ScriptName` = 'npc_coren_direbrew', `flags_extra` = 0, `faction_A` =  '35', `faction_H` =  '35' ,`dmg_multiplier` = 30, `Health_mod` =  '70',`minlevel` =  '83', `maxlevel` =  '83', `lootid` = 23872 WHERE `entry` = 23872;
UPDATE `creature_template` SET  `faction_A` =  '35', `faction_H` =  '35' WHERE `entry` = 26776;
UPDATE `creature_template` SET `ScriptName` = 'npc_brewmaiden' WHERE `entry` IN (26822,26764);
UPDATE `gameobject_template` SET `ScriptName` = 'go_mole_machine_console' WHERE `entry` = 188498;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (47344,47310);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) 
VALUES
(13, 47310, 18, 1, 0),                                 
(13, 47344, 18, 1, 26764), 
(13, 47344, 18, 1, 26822);  

DELETE FROM `creature` WHERE `id` =23872;
INSERT INTO `creature` (`guid`,`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(NULL,23872, 230, 1, 1, 0, 0, 892.649, -130.233, -49.746, 5.12297, 300, 0, 0, 976150, 0, 0, 0, 0, 0);
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(85,(SELECT `guid` FROM `creature` WHERE `id` = 23872 limit 0,1));

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
