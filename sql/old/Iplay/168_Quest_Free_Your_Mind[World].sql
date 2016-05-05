-- Fix Quest Icecrown: Free your Mind
SET @VILE := 29769;
SET @LADY := 29770;
SET @LEAPER := 29840;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (13,17) AND `SourceEntry` IN (29070,29071);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,1,29070,0,0,31,0,3,@VILE,0,0,0,'','Sovereign Rod - Implicit target - Vile'),
(13,1,29070,0,0,36,0,0,0,0,1,0,'','Sovereign Rod - Implicit target - Dead'),
(13,1,29070,0,1,31,0,3,@LADY,0,0,0,'','Sovereign Rod - Implicit target - Lady Nightswood'),
(13,1,29070,0,1,36,0,0,0,0,1,0,'','Sovereign Rod - Implicit target - Dead'),
(13,1,29070,0,2,31,0,3,@LEAPER,0,0,0,'','Sovereign Rod - Implicit target - The Leaper'),
(13,1,29070,0,2,36,0,0,0,0,1,0,'','Sovereign Rod - Implicit target - Dead');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@VILE,@LADY,@LEAPER) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Vile
(@VILE,0,0,1,8,0,100,0,29071,0,0,0,70,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Vile - Spell hit - Respawn'),
(@VILE,0,1,2,61,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Vile - Spell hit - React passive'),
(@VILE,0,2,3,61,0,100,0,0,0,0,0,11,43759,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Vile - Spell hit - Cast cosmetic Arcane Explosion'),
(@VILE,0,3,4,61,0,100,0,0,0,0,0,1,0,5000,0,0,0,0,1,0,0,0,0,0,0,0,'The Vile - Spell hit - Say text'),
(@VILE,0,4,0,61,0,100,0,0,0,0,0,33,29845,0,0,0,0,0,7,0,0,0,0,0,0,0,'The Vile - Spell hit - Give credit'),
(@VILE,0,5,0,2,0,100,1,0,30,0,0,11,56646,2,0,0,0,0,1,0,0,0,0,0,0,0,'The Vile - Enrage at 30% HP'),
(@VILE,0,6,0,0,0,80,0,5000,6000,8000,9000,11,6253,0,0,0,0,0,2,0,0,0,0,0,0,0,'The Vile - In combat - Cast Backhand'),
(@VILE,0,7,0,52,0,100,0,0,@VILE,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Vile - Text over - Despawn'),
-- Lady Nightswood
(@LADY,0,0,1,8,0,100,0,29071,0,0,0,70,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Lady Nightswood - Spell hit - Respawn'),
(@LADY,0,1,2,61,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Lady Nightswood - Spell hit - React passive'),
(@LADY,0,2,3,61,0,100,0,0,0,0,0,11,43759,0,0,0,0,0,1,0,0,0,0,0,0,0,'Lady Nightswood - Spell hit - Cast cosmetic Arcane Explosion'),
(@LADY,0,3,4,61,0,100,0,0,0,0,0,1,1,5000,0,0,0,0,1,0,0,0,0,0,0,0,'Lady Nightswood - Spell hit - Say text'),
(@LADY,0,4,0,61,0,100,0,0,0,0,0,33,29846,0,0,0,0,0,7,0,0,0,0,0,0,0,'Lady Nightswood - Spell hit - Give credit'),
(@LADY,0,5,0,4,0,100,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Lady Nightswood - Aggro - Say text'),
(@LADY,0,6,0,0,0,100,0,5000,7000,13000,15000,11,5884,0,0,0,0,0,2,0,0,0,0,0,0,0,'Lady Nightswood - In combat - Cast Banshee Curse'),
(@LADY,0,7,0,0,13,70,0,10000,15000,0,0,11,16838,1,0,0,0,0,7,0,0,0,0,0,0,0,'Lady Nightswood - Target casting - Cast Banshee Shriek'),
(@LADY,0,8,0,52,0,100,0,1,@LADY,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Lady Nightswood - Text over - Despawn'),
-- The Leaper
(@LEAPER,0,0,1,8,0,100,0,29071,0,0,0,70,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Leaper - Spell hit - Respawn'),
(@LEAPER,0,1,2,61,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Leaper - Spell hit - React passive'),
(@LEAPER,0,2,3,61,0,100,0,0,0,0,0,11,43759,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Leaper - Spell hit - Cast cosmetic Arcane Explosion'),
(@LEAPER,0,3,4,61,0,100,0,0,0,0,0,1,1,5000,0,0,0,0,1,0,0,0,0,0,0,0,'The Leaper - Spell hit - Say text'),
(@LEAPER,0,4,0,61,0,100,0,0,0,0,0,33,29847,0,0,0,0,0,7,0,0,0,0,0,0,0,'The Leaper - Spell hit - Give credit'),
(@LEAPER,0,5,0,4,0,100,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Leaper - Aggro - Say text'),
(@LEAPER,0,6,0,0,0,100,0,5000,7000,10000,10000,11,60177,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Leaper - In combat - Cast Hunger For Blood'),
(@LEAPER,0,7,0,0,0,100,0,3000,8000,3000,8000,11,60195,0,0,0,0,0,2,0,0,0,0,0,0,0,'The Leaper - In combat - Cast Sinister Strike'),
(@LEAPER,0,8,0,52,0,100,0,1,@LEAPER,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'The Leaper - Text over - Despawn');

DELETE FROM `creature_text` WHERE `entry` IN (@VILE,@LADY,@LEAPER);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@VILE,0,0,"Vile free! Vile love $n!",12,0,100,0,3,0,'Vile'),
(@LADY,0,0,"Who intrudes upon my ritual?",12,0,100,0,3,0,'Lady Nightswood'),
(@LADY,1,0,"You dare?! Where is Baron Sliver? I would have words with him!",12,0,100,0,3,0,'Lady Nightswood'),
(@LEAPER,0,0,"Mrrfrmrfrmrrrrr!",12,0,100,0,3,0,'The Leaper'),
(@LEAPER,1,0,"Mrmrmmrmrmrmrm... mrmrmrmr?!",12,0,100,0,3,0,'The Leaper');
