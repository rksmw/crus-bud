-- Quest - The Rune of Command
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (23725,24329,24346,24335);
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry` IN (24335,24336);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (23725,24329,24346,24335) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(23725,0,0,0,0,0,100,0,4000,6000,13000,15000,11,49675,0,0,0,0,0,2,0,0,0,0,0,0,0,'Stone Giant - In combat - Cast Stone Stomp'),
(23725,0,1,0,4,0,100,1,0,0,0,0,11,49717,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stone Giant - Aggro - Cast Rune Fist'),
(23725,0,2,0,2,0,100,1,0,35,0,0,11,49676,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stone Giant - 35% hp - Cast Stone Fist'),
(23725,0,3,4,8,0,100,0,49859,0,0,0,11,43564,3,0,0,0,0,7,0,0,0,0,0,0,0,'Stone Giant - Spellhit - Cast killcredit'),
(23725,0,4,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stone Giant - Spellhit - Despawn'),
(24329,0,0,1,8,0,100,0,49859,0,0,0,11,43564,3,0,0,0,0,7,0,0,0,0,0,0,0,'Runed Stone Giant - Spellhit - Cast killcredit'),
(24329,0,1,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Runed Stone Giant - Spellhit - Despawn'),
(24346,0,0,0,54,0,100,0,0,0,0,0,8,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Enthralled Stone Giant - Just summoned - React deffensive'),
(24346,0,1,0,0,0,100,0,3000,5000,8000,10000,11,38621,0,0,0,0,0,2,0,0,0,0,0,0,0,'Enthralled Stone Giant - In combat - Cast Debilitating Strike'),
(24346,0,2,0,0,0,100,0,10000,15000,10000,15000,11,43612,0,0,0,0,0,2,0,0,0,0,0,0,0,'Enthralled Stone Giant - In combat - Cast Bash'),
(24335,0,0,0,1,0,100,1,0,0,0,0,11,43546,2,0,0,0,0,19,24336,50,0,0,0,0,0,'Runed Orb - Reset - Cast Runed Orb');

UPDATE `creature` SET `position_x`=2125.07, `position_y`=-5742.04, `position_z`=220.333, `MovementType`=0, `spawndist`=0 WHERE `id`=24335;
UPDATE `creature` SET `position_x`=2116.18, `position_y`=-5743.64, `position_z`=222.468, `MovementType`=0, `spawndist`=0 WHERE `id`=24336;
UPDATE `creature_addon` SET `auras`='46933' WHERE `guid`=98173;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=43546;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=49859;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`comment`) VALUES
(13,1,43546,0,31,0,3,24336,'Runed Orb - Implicit Target - Orb target'), 
(17,0,49859,0,31,1,3,23725,'Rune of Command - Explicit Target - Stone Giant'),
(17,0,49859,1,31,1,3,24329,'Rune of Command - Explicit Target - Runed Stone Giant');
