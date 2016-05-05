-- -------------------
-- Ruby Sanctum trash
-- -------------------

-- Charscale Invoker SAI
SET @ENTRY := 40417;
SET @SPELL1 := 75413; -- Spell Flame Wave
SET @SPELL2 := 75412; -- Spell Scorch (10 man)
SET @SPELL3 := 75419; -- Spell Scorch (25 man)
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,8000,13000,8000,13000,11,@SPELL1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Charscale Invoker - In combat - Cast Flame Wave'),
(@ENTRY,0,1,0,0,0,100,10,3000,3000,8000,8000,11,@SPELL2,0,0,0,0,0,2,0,0,0,0,0,0,0,'Charscale Invoker - In combat (10 man) - Cast Scorch'),
(@ENTRY,0,2,0,0,0,100,20,3000,3000,8000,8000,11,@SPELL3,0,0,0,0,0,2,0,0,0,0,0,0,0,'Charscale Invoker - In combat (25 man) - Cast Scorch');

-- Charscale Assaulter SAI
SET @ENTRY := 40419;
SET @SPELL1 := 15284; -- Spell Cleave
SET @SPELL2 := 75417; -- Spell Shockwave (10 man)
SET @SPELL3 := 75418; -- Spell Shockwave (25 man)
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,5000,11000,11000,11,@SPELL1,0,0,0,0,0,2,0,0,0,0,0,0,0,'Charscale Assaulter - In combat - Cast Cleave'),
(@ENTRY,0,1,0,0,0,100,10,9000,9000,17000,17000,11,@SPELL2,0,0,0,0,0,2,0,0,0,0,0,0,0,'Charscale Assaulter - In combat (10 man) - Cast Shockwave'),
(@ENTRY,0,2,0,0,0,100,20,9000,9000,17000,17000,11,@SPELL3,0,0,0,0,0,2,0,0,0,0,0,0,0,'Charscale Assaulter - In combat (25 man) - Cast Shockwave');

-- Charscale Elite SAI
SET @ENTRY := 40421;
SET @SPELL := 15621; -- Spell Skull Crack
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,5000,12000,12000,11,@SPELL,0,0,0,0,0,2,0,0,0,0,0,0,0,'Charscale Elite - In combat - Cast Skull Crack');

-- Charscale Commander SAI
SET @ENTRY := 40423;
SET @SPELL1 := 13737; -- Spell Mortal Strike
SET @SPELL2 := 75414; -- Spell Rallying Shout
SET @SPELL3 := 75416; -- Spell Rally
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,75,@SPELL2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Charscale Commander - Aggro - Apply aura Rallying Shout'),
(@ENTRY,0,1,0,0,0,100,0,9000,9000,9000,9000,11,@SPELL2,0,0,0,0,0,2,0,0,0,0,0,0,0,'Charscale Commander - In combat - Cast Mortal Strike'),
(@ENTRY,0,2,0,6,0,100,0,0,0,0,0,28,@SPELL3,0,0,0,0,0,11,0,10,0,0,0,0,0,'Charscale Commander - Death - Remove Rally aura from nearby creatures');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=@SPELL2;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,1,@SPELL2,0,0,31,0,3,@ENTRY,0,0,0,'','Rallying Shout - Implicit target - Charscale Commander');

-- Rallying Shout spell effect
SET @SPELL1 := 75415; -- Spell Rallying Shout
SET @SPELL2 := 75416; -- Spell Rally
SET @ENTRY1 := 40417; -- Charscale Invoker
SET @ENTRY2 := 40419; -- Charscale Assaulter
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=@SPELL1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,1,@SPELL1,0,0,31,0,3,@ENTRY1,0,0,0,'','Rallying Shout - Implicit target - Charscale Invoker'),
(13,1,@SPELL1,0,1,31,0,3,@ENTRY2,0,0,0,'','Rallying Shout - Implicit target - Charscale Assaulter');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=@SPELL1;
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(@SPELL1,@SPELL2,1,'Rallying Shout - Rally');

-- Mechanic Immunities, everething except Sleep and Sapped
UPDATE `creature_template` SET `mechanic_immune_mask`=399064543 WHERE `entry` BETWEEN 40417 AND 40424;


-- Añadido damage a los adds de Halion en modo hero, hasta ahora hacian 1 de daño.
UPDATE `creature_template` SET `mindmg`=488, `maxdmg`=642, `attackpower`=782, `dmg_multiplier`=8, `baseattacktime`=1500 WHERE `entry` IN (40681,40683);
UPDATE `creature_template` SET `mindmg`=488, `maxdmg`=642, `attackpower`=782, `dmg_multiplier`=12, `baseattacktime`=1500 WHERE `entry` IN (40682,40684);

-- Onyx Flamecaller
UPDATE `creature_template` SET `mechanic_immune_mask`=534722559 WHERE `entry` IN(39815,39814);
UPDATE `creature_template` SET `faction_A`=103, `faction_H`=103, `minlevel`=82, `maxlevel`=82, `speed_walk`=0.888888, `speed_run`=1.42857, `unit_flags`=unit_flags|64|32768, `baseattacktime`=2000 WHERE entry IN (39815,39814);
UPDATE `creature` SET `position_x`=3043.649170, `position_y`=452.039093, `position_z`=85.533585, `spawntimesecs`=604800,`curhealth`=12600 WHERE `guid`=202797 AND `id`=39794;
UPDATE `creature` SET `position_x`=3048.162109, `position_y`=601.734741, `position_z`=86.851151, `spawntimesecs`=604800,`curhealth`=12600 WHERE `guid`=202798 AND `id`=39794;

-- Bosses spawntime & corpse remove time
UPDATE `creature` SET `spawntimesecs` = 604800 WHERE `id` IN (39863,39751,39746,39747);
UPDATE `creature_template` SET `rank` = 3 WHERE `entry` IN  (39863,39751,39746,39747);


-- Trash spawntime
UPDATE `creature` SET `spawntimesecs`=1209600 WHERE `map`=724 AND `id` NOT IN (39863,39751,39746,39747);

-- Ruby Sanctum bosses id saving
UPDATE `creature_template` SET `flags_extra` = 1 WHERE `entry` IN
(39863,39864,39944,39945, -- Halion
39751,39920, -- Baltharus
39746,39805, -- General Zarithrian
39747,39823); -- Saviana Ragefire

-- Solucionamos que el boss Saviana Ragefire cuando usa su spell conflagration la use volando no bajo el agua xD
UPDATE creature_template SET InhabitType = InhabitType | 4 WHERE entry IN (39747,39823); -- Saviana Ragefire 

-- Cambiamos VehicleID para que no haya problemas cuando estan los cuatro orbes.
-- Ahora si aparecerán de forma correcta los orbes, y un pequeño arreglo al spawn de orbes hero.
UPDATE `creature_template` SET `VehicleId` = '746' WHERE `entry` IN('40081','40470');

-- Damage --
-- Charscale Invoker
UPDATE creature_template SET mindmg = '600',maxdmg = '725',dmg_multiplier = '7.5' WHERE entry =40417;
UPDATE creature_template SET mindmg = '600',maxdmg = '725',dmg_multiplier = '12.5' WHERE entry =40418;

-- Charscale Assaulter
UPDATE creature_template SET mindmg = '600',maxdmg = '725',dmg_multiplier = '25' WHERE entry =40419;
UPDATE creature_template SET mindmg = '600',maxdmg = '725',dmg_multiplier = '35.5' WHERE entry =40420;

-- Charscale Elite
UPDATE creature_template SET mindmg = '855',maxdmg = '1225',dmg_multiplier = '25' WHERE entry =40421;
UPDATE creature_template SET mindmg = '855',maxdmg = '1225',dmg_multiplier = '35.5' WHERE entry =40600;

-- Charscale Commander
UPDATE creature_template SET mindmg = '600',maxdmg = '725',dmg_multiplier = '7.5' WHERE entry =40423;
UPDATE creature_template SET mindmg = '600',maxdmg = '725',dmg_multiplier = '12.5' WHERE entry =40424;

-- Baltharus the Warborn 
UPDATE creature_template SET mindmg = '835',maxdmg = '955',dmg_multiplier = '35' WHERE entry =39751;
UPDATE creature_template SET mindmg = '835',maxdmg = '955',dmg_multiplier = '45' WHERE entry =39920;

-- Baltharus Clone
UPDATE creature_template SET mindmg = '835',maxdmg = '955',dmg_multiplier = '35' WHERE entry =39899;
UPDATE creature_template SET mindmg = '835',maxdmg = '955',dmg_multiplier = '45' WHERE entry =39922;

-- Saviana Ragefire // Daño demasiado bajo, subir al menos al doble.

UPDATE creature_template SET mindmg = '785',maxdmg = '890',dmg_multiplier = '35' WHERE entry =39747;
UPDATE creature_template SET mindmg = '785',maxdmg = '890',dmg_multiplier = '45' WHERE entry =39823;

-- General Zarithrian // Daño demasiado bajo, subir al menos al doble.

UPDATE creature_template SET mindmg = '1050',maxdmg = '1150',dmg_multiplier = '35' WHERE entry =39746;
UPDATE creature_template SET mindmg = '1050',maxdmg = '1150',dmg_multiplier = '45' WHERE entry =39805;

-- Onyx Flamecaller // BIEN
UPDATE creature_template SET mindmg = '600',maxdmg = '725',dmg_multiplier = '7.5' WHERE entry =39814;
UPDATE creature_template SET mindmg = '600',maxdmg = '725',dmg_multiplier = '12.5' WHERE entry =39815;

-- Halion
UPDATE creature_template SET mindmg = '690',maxdmg = '779',dmg_multiplier = '35' WHERE entry =39863;
UPDATE creature_template SET mindmg = '690',maxdmg = '779',dmg_multiplier = '45' WHERE entry =39864;
UPDATE creature_template SET mindmg = '690',maxdmg = '779',dmg_multiplier = '55' WHERE entry =39944;
UPDATE creature_template SET mindmg = '690',maxdmg = '779',dmg_multiplier = '75' WHERE entry =39945;

-- Twilight Halion
UPDATE creature_template SET mindmg = '690',maxdmg = '779',dmg_multiplier = '35' WHERE entry =40142;
UPDATE creature_template SET mindmg = '690',maxdmg = '779',dmg_multiplier = '45' WHERE entry =40143;
UPDATE creature_template SET mindmg = '690',maxdmg = '779',dmg_multiplier = '55' WHERE entry =40144;
UPDATE creature_template SET mindmg = '690',maxdmg = '779',dmg_multiplier = '75' WHERE entry =40145;
-- Immunity
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` | 
1|          -- charm
2|          -- disorient
4|          -- disarm
8|          -- distract
16|         -- fear
32|         -- grip
64|         -- root
256|        -- silence
512|        -- sleep
1024|       -- snare
2048|       -- stun
4096|       -- freeze
8192|       -- knockout
65536|      -- polymorph
131072|     -- banish
524288|     -- shackle
1048576|    -- mount
4194304|    -- turn
8388608|    -- horror
33554432|   -- interrupt
67108864|   -- daze
536870912   -- sapped
where `entry` IN (
39747, 39823   -- Saviana Ragefire
);

UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` | 
1|          -- charm
2|          -- disorient
4|          -- disarm
8|          -- distract
16|         -- fear
32|         -- grip
64|         -- root
128|        -- pacify
256|        -- silence
512|        -- sleep
1024|       -- snare
2048|       -- stun
4096|       -- freeze
8192|       -- knockout
65536|      -- polymorph
131072|     -- banish
524288|     -- shackle
1048576|    -- mount
4194304|    -- turn
8388608|    -- horror
33554432|   -- interrupt
67108864|   -- daze
536870912   -- sapped
where `entry` IN (
39751, 39920,   -- Baltharus the Warborn
39899, 39922,   -- Baltharus the Warborn Clone
39746, 39805,    -- General Zarithrian
39863, 39864, 39944, 39945, -- Halion
40142, 40143, 40144, 40145 -- Twilight Halion
);
