-- Trashmobs icc 
-- En desarrollo ReanEmu https://github.com/ComunidadRean/ReanEmu
-- Datos base por overy, kayserzero y wowhead.com

-- Trash inicial Martillo de Luz http://www.youtube.com/watch?v=zcSKxoA8eC8
-- Trash de Caminasueños http://www.youtube.com/watch?v=dYXY7QsAI98
-- Trash de Consejo de Sangre http://www.youtube.com/watch?v=-y1jiiaUfC8

-- Scriptnames y ajustes:

/*-----Trash de Martillo de la Luz-----*/
-- Aqui se les sube el daño tambien para que no puedan farmear en solo
UPDATE `creature_template` SET `dmg_multiplier` = '10' WHERE `entry` =37012;
UPDATE `creature_template` SET `dmg_multiplier` = '17.5' WHERE `entry` =38059;
UPDATE `creature_template` SET `mindmg` = '1100',`maxdmg` = '1300' WHERE `entry` =37007;
UPDATE `creature_template` SET `mindmg` = '1100',`maxdmg` = '1200' WHERE `entry` =38031;
UPDATE `creature_template` SET `dmg_multiplier` = '10.5' WHERE `entry` =36724;
UPDATE `creature_template` SET `dmg_multiplier` = '19' WHERE `entry` =38057;
UPDATE `creature_template` SET `dmg_multiplier` = '10' WHERE `entry` =37011;
UPDATE `creature_template` SET `dmg_multiplier` = '16' WHERE `entry` =38061;
UPDATE `creature_template` SET `dmg_multiplier` = '11.2' WHERE `entry` =36725;
UPDATE `creature_template` SET `dmg_multiplier` = '14.7' WHERE `entry` =38058;

/*-------------- SAI traducido de mi C++ original al SmartAI por Muzashi https://github.com/Muzashi ----------------*/
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (37011, 37007, 36724, 37012, 36725, 36805, 36808, 36807, 3681, 36829, 37022, 37038, 10404, 37023, 36880, 37664, 37595, 37663, 37901, 37571, 37662, 37666, 37665, 37132, 36811, 38125, 37127, 37134, 37133) AND `source_type`=0;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName`='' WHERE `entry` IN (37011, 37007, 36724, 37012, 36725, 36805, 36808, 36807, 3681, 36829, 37022, 37038, 10404, 37023, 36880, 37664, 37595, 37663, 37901, 37571, 37662, 37666, 37665, 37132, 36811, 38125, 37127, 37134, 37133);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
/*-----Trash de Martillo de la Luz-----*/
--  SAI
(37012, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 10000, 10000, 11, 70964, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ancient Skeletal Soldier - Shield Bash'),
(37007, 0, 0, 0, 0, 0, 100, 0, 12000, 15000, 15000, 15000, 11, 71022, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathbound Ward - Disrupting Shout'),
(37007, 0, 1, 0, 0, 0, 100, 0, 7000, 7000, 7000, 7000, 11, 71021, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deathbound Ward - Saber Lash'),
(36724, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 6000, 12000, 11, 71029, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Servant of the Throne - Glacial Blast'),
(37011, 0, 0, 0, 2, 0, 100, 0, 5, 30, 15000, 20000, 75, 70960, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Damned - Bone Flurry at 5-30%'),
(37011, 0, 1, 2, 6, 0, 100, 1, 0, 0, 0, 0, 11, 70961, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Damned - Shattered Bones on death'),
(36725, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 69887, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Broodkeeper - Aggro - Cast Web Beam'),
(36725, 0, 1, 0, 10, 0, 100, 1, 0, 45, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Broodkeeper - OOC LOS - Attack Invoker'),
(36725, 0, 2, 0, 0, 1, 100, 0, 2000, 2000, 8000, 8000, 11, 70965, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Broodkeeper - In Combat - Crypt Scarabs'),
(36725, 0, 3, 0, 14, 1, 100, 0, 5000, 40, 5000, 5000, 11, 71020, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Broodkeeper - Friendly missing 5k HP - Dark Mending'),
(36725, 0, 4, 0, 0, 1, 100, 0, 5000, 5000, 5000, 5000, 11, 70980, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Broodkeeper - In Combat - Web Wrap'),
(36725, 0, 5, 0, 9, 0, 100, 1, 0, 5, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerubar Broodkeeper - Target at 5 yards - Set phase 1'),
/*--Trash de Oratorio de los Malditos--*/
-- SAI
(36805, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 8000, 15000, 11, 69405, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Servant - Consuming Shadows'),
(36805, 0, 1, 0, 0, 0, 100, 10, 2000, 2000, 3000, 4000, 11, 69576, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Servant - Chaos Bolt'),
(36805, 0, 2, 0, 0, 0, 100, 20, 2000, 2000, 3000, 4000, 11, 71108, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Servant - Chaos Bolt'),
(36805, 0, 3, 0, 0, 0, 100, 10, 3000, 5000, 15000, 20000, 11, 69404, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Servant - Curse of Agony'),
(36805, 0, 4, 0, 0, 0, 100, 20, 3000, 5000, 15000, 20000, 11, 71112, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Servant - Curse of Agony'),
(36807, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 8000, 15000, 11, 69391, 0, 0, 0, 0, 0, 9, 0, 0, 30, 0, 0, 0, 0, 'Deathspeaker Disciple - Dark Blessing'),
(36807, 0, 1, 0, 0, 0, 100, 0, 2000, 2000, 3000, 7000, 11, 69387, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Disciple - Shadow Bolt'),
(36807, 0, 2, 0, 0, 0, 100, 10, 5000, 10000, 8000, 10000, 11, 69389, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Disciple - Shadow Mend'),
(36807, 0, 3, 0, 0, 0, 100, 20, 3000, 5000, 5000, 8000, 11, 69389, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Disciple - Shadow Mend'),
(36808, 0, 0, 0, 0, 0, 100, 0, 6000, 6000, 6000, 6000, 11, 69492, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Zealot - Shadow Cleave'),
(36811, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 3000, 5000, 11, 69387, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Attendant - Shadow Bolt'),
(36811, 0, 1, 0, 0, 0, 100, 10, 5000, 10000, 5000, 10000, 11, 69355, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Attendant - Shadow Nova'),
(36811, 0, 2, 0, 0, 0, 100, 20, 5000, 8000, 5000, 10000, 11, 71106, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker Attendant - Shadow Nova'),
(36829, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 69491, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker High Priest - Aura of Darkness on Aggro'),
(36829, 0, 1, 0, 0, 0, 100, 0, 2000, 2000, 10000, 12000, 11, 69483, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker High Priest - Dark Reckoning'),
(36829, 0, 2, 0, 7, 0, 100, 0, 0, 0, 0, 0, 28, 69491, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deathspeaker High Priest - Remove Aura of Darkness On Evade'),
/*----Trash de Talleres de la Peste----*/
(37022, 0, 0, 0, 0, 0, 100, 0, 4000, 4000, 6000, 6000, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blighted Abomination - Cleave'),
(37022, 0, 1, 0, 0, 0, 100, 0, 10000, 10000, 20000, 20000, 11, 71150, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blighted Abomination - Plague Cloud'),
(37022, 0, 2, 0, 0, 0, 100, 0, 5000, 5000, 12000, 20000, 11, 71140, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Blighted Abomination - Scourge Hook'),
(37038, 0, 0, 0, 0, 0, 100, 0, 3000, 20000, 20000, 40000, 11, 71164, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Vengeful Fleshreaper - Leaping Face Maul'),
(37023, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 8000, 12000, 11, 71103, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Plague Scientist - Combobulating Spray'),
(37023, 0, 1, 0, 0, 0, 100, 0, 2000, 2000, 2000, 3000, 11, 73079, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Plague Scientist - Plague Blast'),
(37023, 0, 2, 0, 0, 0, 100, 0, 8000, 12000, 15000, 20000, 11, 69871, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Plague Scientist - Plague Stream'),
(10404, 0, 0, 0, 2, 0, 100, 1, 0, 15, 0, 0, 11, 71088, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pustulating Horror - Blight Bomb'),
(10404, 0, 1, 0, 0, 0, 100, 10, 2000, 2000, 15000, 20000, 11, 71089, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Pustulating Horror - Bubbling Pus'),
(10404, 0, 2, 0, 0, 0, 100, 20, 2000, 2000, 15000, 20000, 11, 71090, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Pustulating Horror - Bubbling Pus'),
(36880, 0, 0, 0, 0, 0, 100, 10, 5000, 5000, 15000, 25000, 11, 71114, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Decaying Colossus - Massive Stomp'),
(36880, 0, 1, 0, 0, 0, 100, 20, 5000, 5000, 15000, 25000, 11, 71115, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Decaying Colossus - Massive Stomp'),
/*--------Trash de Salas Carmesi--------*/
(37664, 0, 0, 0, 0, 0, 100, 0, 9000, 12000, 15000, 18000, 11, 70410, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Polymorph Spider'),
(37664, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 15000, 25000, 11, 70299, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Siphon Essence'),
(37664, 0, 2, 0, 0, 0, 100, 10, 10000, 15000, 15000, 20000, 11, 70408, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Amplify Magic'),
(37664, 0, 3, 0, 0, 0, 100, 10, 8000, 10000, 10000, 20000, 11, 70407, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Blast Wave'),
(37664, 0, 4, 0, 0, 0, 100, 10, 2000, 2000, 3000, 4000, 11, 70409, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Fireball'),
(37664, 0, 5, 0, 0, 0, 100, 20, 10000, 15000, 10000, 15000, 11, 72336, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Amplify Magic'),
(37664, 0, 6, 0, 0, 0, 100, 20, 8000, 10000, 10000, 20000, 11, 71151, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Blast Wave'),
(37664, 0, 7, 0, 0, 0, 100, 20, 2000, 2000, 2000, 3000, 11, 71153, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Archmage - Fireball'),
(37595, 0, 0, 0, 0, 0, 100, 0, 4000, 5000, 32000, 37000, 11, 70450, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Blood Knight - Blood Mirror'),
(37595, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 15000, 25000, 11, 70299, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Blood Knight - Siphon Essence'),
(37595, 0, 2, 0, 0, 0, 100, 0, 2000, 3000, 3000, 4000, 11, 70437, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Blood Knight - Unholy Strike'),
(37595, 0, 3, 0, 4, 0, 100, 0, 0, 0, 12000, 15000, 11, 71736, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Blood Knight - Vampiric Aura'),
(37663, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 20000, 25000, 11, 70645, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Noble - Chains of Shadow'),
(37663, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 15000, 25000, 11, 70299, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Noble - Siphon Essence'),
(37663, 0, 2, 0, 0, 0, 100, 10, 3000, 5000, 4000, 5000, 11, 72960, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Noble - Shadow Bolt'),
(37663, 0, 3, 0, 0, 0, 100, 20, 3000, 5000, 3000, 4000, 11, 72961, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Noble - Shadow Bolt'),
(37901, 0, 0, 0, 0, 0, 100, 1, 5000, 5000, 0, 0, 11, 41290, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vampiric Fiend - Disease Cloud'),
(37901, 0, 1, 0, 0, 0, 100, 0, 10000, 10000, 10000, 10000, 11, 70671, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vampiric Fiend - Leeching Rot'),
(37571, 0, 0, 0, 0, 0, 100, 0, 10000, 15000, 15000, 20000, 11, 72065, 0, 0, 0, 0, 0, 9, 0, 0, 40, 0, 0, 0, 0, 'Darkfallen Advisor - Shroud of Protection'),
(37571, 0, 1, 0, 0, 0, 100, 0, 10000, 15000, 15000, 20000, 11, 72066, 0, 0, 0, 0, 0, 9, 0, 0, 40, 0, 0, 0, 0, 'Darkfallen Advisor - Shroud of Spell Warding'),
(37571, 0, 2, 0, 0, 0, 100, 10, 2000, 5000, 10000, 10000, 11, 72057, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Advisor - Lich Slap'),
(37571, 0, 3, 0, 0, 0, 100, 20, 2000, 5000, 5000, 8000, 11, 72421, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Advisor - Lich Slap'),
(37662, 0, 0, 0, 0, 0, 100, 0, 8000, 10000, 15000, 20000, 11, 70750, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Commander - Battle Shout'),
(37662, 0, 1, 0, 0, 0, 100, 10, 4000, 8000, 10000, 15000, 11, 70449, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Commander - Vampire Rush'),
(37662, 0, 2, 0, 0, 0, 100, 20, 4000, 8000, 10000, 15000, 11, 71155, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Commander - Vampire Rush'),
(37665, 0, 0, 0, 0, 0, 100, 0, 8000, 15000, 10000, 20000, 11, 70423, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Lieutenant - Vampiric Curse'),
(37665, 0, 1, 0, 0, 0, 100, 10, 1000, 2000, 25000, 25000, 11, 70435, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Lieutenant - Rend Flesh'),
(37665, 0, 2, 0, 0, 0, 100, 20, 1000, 2000, 25000, 25000, 11, 71154, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Lieutenant - Rend Flesh'),
(37666, 0, 0, 0, 0, 0, 100, 0, 5000, 15000, 15000, 25000, 11, 70432, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Tactician - Blood Sap'),
(37666, 0, 1, 0, 0, 0, 100, 0, 2000, 3000, 6000, 6000, 11, 70437, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Tactician - Unholy Strike'),
(37666, 0, 2, 0, 0, 0, 100, 0, 1000, 2000, 15000, 20000, 11, 70431, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Tactician - Shadowstep'),
/*---Trash de Camaras de Alaescarcha---*/	
(38125, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 15000, 25000, 11, 71298, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Banish'),	  	
(38125, 0, 1, 0, 0, 0, 100, 0, 1000, 2000, 25000, 25000, 11, 69929, 0, 0, 0, 0, 0, 9, 0, 0, 80, 0, 0, 0, 0, 'Ymirjar Deathbringer - Spirit Stream'),
(38125, 0, 2, 0, 0, 0, 100, 0, 1000, 2000, 25000, 25000, 11, 71303, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Summon Ymirjar'),
(38125, 0, 3, 0, 0, 0, 100, 10, 10000, 15000, 15000, 25000, 11, 71299, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Deaths Embrace'),
(38125, 0, 4, 0, 0, 0, 100, 10, 1000, 2000, 2000, 2000, 11, 71300, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Shadow Bolt'),
(38125, 0, 5, 0, 0, 0, 100, 20, 5000, 10000, 15000, 20000, 11, 71296, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Deaths Embrace'),
(38125, 0, 6, 0, 0, 0, 100, 20, 1000, 2000, 2000, 2000, 11, 71297, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Shadow Bolt'),
(37127, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 3000, 5000, 11, 71274, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Frostbinder - Frozen Orb'),
(37127, 0, 1, 0, 0, 0, 100, 0, 1000, 2000, 25000, 25000, 11, 69929, 0, 0, 0, 0, 0, 9, 0, 0, 80, 0, 0, 0, 0, 'Ymirjar Frostbinder - Spirit Stream'),
(37134, 0, 0, 0, 0, 0, 100, 0, 5000, 30000, 25000, 25000, 11, 71249, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Ice Trap'),
(37134, 0, 1, 0, 0, 0, 100, 0, 10000, 15000, 25000, 25000, 11, 71251, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Rapid Shot'),
(37134, 0, 2, 0, 0, 0, 100, 0, 1000, 2000, 1000, 1000, 11, 71253, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Shoot'),
(37134, 0, 3, 0, 0, 0, 100, 0, 5000, 10000, 15000, 25000, 11, 71252, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Volley'),
(37134, 0, 4, 0, 0, 0, 100, 20, 1000, 2000, 25000, 25000, 11, 71705, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Summon Warhawk'),
(37133, 0, 0, 0, 0, 0, 100, 0, 5000, 15000, 12000, 20000, 11, 41056, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Warlord - Whirlwind');

-- Inmunidades del trash de icc:
-- ancient skeletal soldier
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37012,38059);
-- deathbound ward
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37007,38031);
-- servant of the throne
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (36724,38057);
-- the damned
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37011,38061);
-- nerubar broodkeeper
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (36725,38058);
-- deathspeaker servant
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (36805,38075);
-- deathspeaker disciple
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (36807,38073);
-- deathspeaker zealot
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (36808,38076);
-- deathspeaker attendant
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (36811,38072);
-- deathspeaker high priest
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (36829,38074);
-- blighted abomination
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37022,38108);
-- vengeful fleshreapert
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37038,38063);
-- plague scientist
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37023,38062);
-- pustulating horror
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (10404,38110);
-- decaying colossus
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (36880,37655);
-- darkfallen archmage
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37664,38099);
-- darkfallen blood knight
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37595,38100);
-- darkfallen noble
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37663,38480);
-- vampiric fiend
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry`=37901;
-- darkfallen advisor
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37571,38098);
-- darkfallen commander
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37662,38102);
-- darkfallen lieutenant
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37665,38101);
-- darkfallen tactician
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37666,38479);
-- ymirjar deathbringer
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (38125,38130);
-- ymirjar frostbinder
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37127,38126);
-- ymirjar battlemaiden
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry`=38132;
-- ymirjar huntress
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry`=38134;
-- ymirjar warlord
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry`=38133;

-- Corregidas las Spirit Alarm
UPDATE `gameobject` SET `position_x`=-192.116287, `position_y`=2167.751465,`position_z`=37.985165 WHERE `guid`=150166;
UPDATE `gameobject_template` SET `data4`=1, `data11`=1 WHERE `entry` IN (201814,201815,201816,201817);

-- The Damned pathing
SET @NPC1 := 201107;
SET @NPC2 := 201146;
UPDATE `creature` SET `position_x`=-175.160233, `position_y`=2180.252441, `position_z`=37.985165, `orientation`=1.621184 WHERE `guid`=@NPC1;
UPDATE `creature` SET `currentwaypoint`=1, `MovementType`=2 WHERE `guid` IN (@NPC1,@NPC2);
DELETE FROM `creature_addon` WHERE `guid` IN (@NPC1, @NPC2);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(@NPC1,@NPC1*10,0,0,0,0,''),
(@NPC2,@NPC2*10,0,0,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` IN (@NPC1*10, @NPC2*10);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_Z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@NPC1*10,1,-175.160233,2180.252441,37.985165,1.621184,0,0,0,100,0),
(@NPC1*10,2,-178.473145,2245.945801,37.985241,1.621184,0,0,0,100,0),
(@NPC2*10,1,-170.416,2180.83,37.8201,1.36136,0,0,0,100,0),
(@NPC2*10,4,-173.728912,2246.52336,37.985241,1.36136,0,0,0,100,0);

-- Vengeful Fleshreaper pathing
SET @NPC1 := 201373;
SET @NPC2 := 201389;
UPDATE `creature` SET `position_x`=4370.501953, `position_y`=3063.313477, `position_z`=371.682373, `orientation`=4.678616, `currentwaypoint`=1,`MovementType`=2 WHERE `guid`=@NPC1;
UPDATE `creature` SET `position_x`=4342.688965, `position_y`=3062.161133, `position_z`=371.673218, `orientation`=4.695860, `currentwaypoint`=1,`MovementType`=2 WHERE `guid`=@NPC2;
DELETE FROM `creature_addon` WHERE `guid` IN (@NPC1, @NPC2);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(@NPC1,@NPC1*10,0,0,0,0,''),
(@NPC2,@NPC2*10,0,0,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` IN (@NPC1*10, @NPC2*10);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_Z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@NPC1*10,1,4370.501953,3063.313477,371.682373,4.678616,0,0,0,100,0),
(@NPC1*10,2,4370.446777,3041.886475,372.798065,6.239988,0,0,0,100,0),
(@NPC1*10,3,4431.955078,3040.562012,372.796875,1.515033,0,0,0,100,0),
(@NPC1*10,4,4432.262695,3079.419189,372.941071,4.673120,0,0,0,100,0),
(@NPC1*10,5,4432.354004,3041.560547,372.790863,3.114890,0,0,0,100,0),
(@NPC1*10,6,4370.663086,3040.779785,372.800293,1.551947,0,0,0,100,0),
(@NPC2*10,1,4342.688965,3062.161133,371.673218,4.695860,0,0,0,100,0),
(@NPC2*10,2,4342.340820,3041.446533,372.792023,3.113284,0,0,0,100,0),
(@NPC2*10,3,4281.295410,3040.479004,372.788544,1.588826,0,0,0,100,0),
(@NPC2*10,4,4280.906738,3073.233643,371.702759,4.732776,0,0,0,100,0),
(@NPC2*10,5,4280.291504,3041.645020,372.785004,6.281582,0,0,0,100,0),
(@NPC2*10,6,4342.137695,3041.630127,372.792053,1.557411,0,0,0,100,0);

-- Argent & Ebon Champions SAI
SET @ARGENT := 37928; -- Argent Champion
SET @EBON := 37996; -- Ebon Champion
SET @SPELL1 := 53625; -- Heroic Leap
SET @SPELL2 := 67939; -- Icy Touch
SET @SPELL3 := 66023; -- Icebound Fortitude
SET @SPELL4 := 66019; -- Death Coil
SET @SPELL5 := 66047; -- Frost Strike
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@ARGENT,@EBON);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ARGENT,@EBON) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ARGENT,0,0,0,9,0,100,0,8,40,7000,10000,11,@SPELL1,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Argent Champion - Target at 8-40 yards - Heroic Leap'),
(@EBON,0,0,0,0,0,100,0,5000,7000,10000,15000,11,@SPELL2,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Ebon Champion - In combat - Icy Touch'),
(@EBON,0,1,0,0,0,100,0,10000,15000,7000,8000,11,@SPELL4,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Ebon Champion - In combat - Death Coil'),
(@EBON,0,2,0,0,0,100,0,10000,15000,10000,15000,11,@SPELL5,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Ebon Champion - In combat - Frost Strike'),
(@EBON,0,3,0,2,0,100,0,0,80,60000,60000,11,@SPELL3,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Ebon Champion - 80% HP - Icebound Fortitude');

-- Aura of Darkness spell difficulties
DELETE FROM `spelldifficulty_dbc` WHERE `id`=69490 AND `spellid0`=69490;
INSERT INTO `spelldifficulty_dbc` (`id`,`spellid0`,`spellid1`) VALUES
(69490,69490,72629);
