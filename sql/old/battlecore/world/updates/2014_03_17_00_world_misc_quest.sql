-- -----------------------------
-- Quest - The Plains of Nasam
-- -----------------------------

-- Horde Siege Tank
UPDATE `creature_template` SET `spell1`=50672, `spell2`=45750,`spell3`=50677, `spell4`=47849, `spell5`=47962, `Health_mod`=5, `Mana_mod`=5, `AIName`='SmartAI' WHERE `entry`=25334;
DELETE FROM `creature` WHERE `id`=25334;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`) VALUES
(25334,571,1,1,0,0,2800.85,6735.15,7.55704,4.27899,600,0,0,53892,15775,0),
(25334,571,1,1,0,0,2789.28,6740.63,7.70007,4.29445,600,0,0,53892,15775,0),
(25334,571,1,1,0,0,2777.9,6745.56,7.80592,4.29317,600,0,0,53892,15775,0),
(25334,571,1,1,0,0,2766.15,6751.18,7.19781,4.34369,600,0,0,53892,15775,0);

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=25334 AND `spell_id`=46598;
INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`cast_flags`) VALUES
(25334,46598,1);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=16 AND `SourceEntry`=25334;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(16,0,25334,0,0,23,0,4027,0,0,0,0,'','Horde Siege Tank - only mount in area 4027'),
(16,0,25334,0,1,23,0,4130,0,0,0,0,'','Horde Siege Tank - only mount in area 4130');

DELETE FROM `smart_scripts` WHERE `entryorguid`=25334 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25334,0,0,1,25,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Horde Siege Tank - Reset - React Passive'),
(25334,0,1,2,61,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Horde Siege Tank - Reset - Set phase 1'),
(25334,0,2,0,61,0,100,0,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Horde Siege Tank - Reset - Run'),
(25334,0,3,4,38,0,100,0,0,1,0,0,45,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Horde Siege Tank - data set - Set data'),
(25334,0,4,0,61,0,100,0,0,1,0,0,11,47967,2,0,0,0,0,23,0,0,0,0,0,0,0,'Horde Siege Tank - data set - Cast credit on summoner'),
(25334,0,5,0,23,1,100,0,46598,1,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Horde Siege Tank - Has Ride Aura - Set phase 2'),
(25334,0,6,0,23,2,100,0,46598,0,0,0,51,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Horde Siege Tank - Missing Ride Aura - Die');

-- Abandoned fuel tank
UPDATE `creature_template` SET `faction_A`=1978, `faction_H`=1978, `unit_flags`=`unit_flags`|2|33554432, `AIName`='SmartAI' WHERE `entry`=27064;    
DELETE FROM `smart_scripts` WHERE `entryorguid`=27064 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27064,0,0,1,10,0,100,1,1,2,0,0,85,47916,2,0,0,0,0,7,0,0,0,0,0,0,0,'Abandoned Fuel Tank - On OOC LOS 2yd - Cast Fuel'),
(27064,0,1,0,61,0,100,1,1,2,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Abandoned Fuel Tank - On OOC LOS 2yd - Despawn');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=27064 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,27064,0,0,31,0,3,25334,0,0,0,'','SAI - Abandoned Fuel Tank invoker must be Horde Siege Tank');

-- Injured Warsong Soldiers
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (27107,27110,27106,27108);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (27107,27110,27106,27108) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Injured Warsong Mage
(27107,0,0,1,8,0,100,0,47962,0,0,0,45,0,1,0,0,0,0,7,0,0,0,0,0,0,0,'Injured Warsong Mage - Spellhit - Set data'),
(27107,0,1,2,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Injured Warsong Mage - Spellhit - Say text'),
(27107,0,2,3,61,0,100,0,0,0,0,0,41,3000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Injured Warsong Mage - Spellhit - despawn'),
-- Injured Warsong Engineer
(27110,0,0,1,8,0,100,0,47962,0,0,0,45,0,1,0,0,0,0,7,0,0,0,0,0,0,0,'Injured Warsong Engineer - Spellhit - Set data'),
(27110,0,1,2,61,0,100,0,0,0,0,0,85,47969,2,0,0,0,0,7,0,0,0,0,0,0,0,'Injured Warsong Engineer - Spellhit - Cast tune up'),
(27110,0,2,3,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Injured Warsong Engineer - Spellhit - Say text'),
(27110,0,3,0,61,0,100,0,0,0,0,0,41,3000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Injured Warsong Engineer - Spellhit - Despawn'),
-- Injured Warsong Warrior
(27106,0,0,1,8,0,100,0,47962,0,0,0,45,0,1,0,0,0,0,7,0,0,0,0,0,0,0,'Injured Warsong Warrior - Spellhit - Set data'),
(27106,0,1,2,61,0,100,0,0,0,0,0,85,47975,2,0,0,0,0,7,0,0,0,0,0,0,0,'Injured Warsong Warrior - Spellhit - Cast shield'),
(27106,0,2,3,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Injured Warsong Warrior - Spellhit - Say text'),
(27106,0,3,0,61,0,100,0,0,0,0,0,41,3000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Injured Warsong Warrior - Spellhit - Despawn'),
-- Injured Warsong Shaman
(27108,0,0,1,8,0,100,0,47962,0,0,0,45,0,1,0,0,0,0,7,0,0,0,0,0,0,0,'Injured Warsong Shaman - Spellhit - Set data'),
(27108,0,1,0,61,0,100,0,0,0,0,0,41,3000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Injured Warsong Shaman - Spellhit - despawn');

DELETE FROM `creature_text` WHERE `entry` IN (27107,27110,27106);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(27107,0,0,"Thank you, friend. Now these beasts shall feel the fury of the Sunwell!",12,0,100,0,0,0,'Injured Warsong Mage'),
(27110,0,0,"Thanks, buddy! Let's see if I can't get this hunk o' junk movin' faster!",12,0,100,0,0,0,'Injured Warsong Engineer'),
(27106,0,0,"I will protect you, friend!",12,0,100,0,0,0,'Injured Warsong Warrior');

-- Scourge Leader identified
DELETE FROM `areatrigger_involvedrelation` WHERE `id`=4963;
INSERT INTO `areatrigger_involvedrelation` (`id`,`quest`) VALUES
(4963,11652);
