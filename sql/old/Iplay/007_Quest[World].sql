-- Fix [Quest] Rallying the Troops
UPDATE creature_template SET `AIName`='SmartAI' WHERE entry=26261;
DELETE FROM `smart_scripts` WHERE entryorguid=26261 AND event_param1=47394;
INSERT INTO `smart_scripts` 
VALUES 
(26261, 0, 0, 0, 8, 0, 100, 0, 47394, 0, 0, 0, 33, 26261, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spellhit call Killcredit for Q 12070');

-- Añadido Fix temporal a [Quest] Mounting Up
UPDATE `creature_template` SET AIName='SmartAI' WHERE entry=26472;
DELETE FROM `creature_ai_scripts` WHERE creature_id=26472;
DELETE FROM `smart_scripts` WHERE entryorguid=26472;
INSERT INTO `smart_scripts` VALUES
(26472,0,0,0,8,0,100,0x1,49319,0,0,0,11,49323,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Highland Mustang - SpellHit - Cast Highland Mustang Spooking Credit'),
(26472,0,1,0,8,0,100,0x1,49319,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Highland Mustang - SpellHit - Despawn'),
(26472,0,2,0,8,0,100,0x1,49266,0,0,0,33,26212,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Highland Mustang - SpellHit - Cast Highland Mustang Spooking Credit'),
(26472,0,3,0,8,0,100,0x1,49266,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Highland Mustang - SpellHit - Despawn');
