-- A Hero's Burden
SET @ARTRUIS := 28659;
SET @JALOOT := 28667;
SET @ZEPIK := 28668;

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@ARTRUIS,@JALOOT,@ZEPIK);
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ARTRUIS;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ARTRUIS,@JALOOT,@ZEPIK) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
-- Artruis the Heartless SAI
(@ARTRUIS,0,0,1,4,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Artruis - Aggro - Set phase 1'),
(@ARTRUIS,0,1,2,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Artruis - Aggro - Say text'),
(@ARTRUIS,0,2,3,61,0,100,0,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Artruis - Aggro - Disable combat movement'),
(@ARTRUIS,0,3,0,61,0,100,0,0,0,0,0,11,15530,0,0,0,0,0,2,0,0,0,0,0,0,0,'Artruis - Aggro - Cast Frost Bolt'),
(@ARTRUIS,0,4,0,9,5,100,1,35,80,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Artruis - Distance 35 yards - Allow combat movement'),
(@ARTRUIS,0,5,0,9,5,100,1,0,5,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Artruis - Distance 5 yards - Allow combat movement'),
(@ARTRUIS,0,6,0,9,5,100,1,5,15,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Artruis - Distance 15 yards - Disable combat movement'),
(@ARTRUIS,0,7,0,3,5,100,0,0,7,100,100,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Artruis - Mana below 7% - Allow combat movement'),
(@ARTRUIS,0,8,0,0,5,100,0,2000,3000,25000,35000,11,54792,0,0,0,0,0,1,0,0,0,0,0,0,0,'Artruis - In combat - Cast Icy Veins'),
(@ARTRUIS,0,9,0,9,5,100,0,0,40,3400,4800,11,15530,0,0,0,0,0,2,0,0,0,0,0,0,0,'Artruis - In combat - Cast Frost Bolt'),
(@ARTRUIS,0,10,0,9,5,100,0,0,35,7000,9000,11,54261,1,0,0,0,0,5,0,0,0,0,0,0,0,'Artruis - In combat - Cast Ice Lance'),
(@ARTRUIS,0,11,0,9,5,100,0,0,10,14000,18000,11,11831,1,0,0,0,0,1,0,0,0,0,0,0,0,'Artruis - In combat - Cast Frost Nova'),
(@ARTRUIS,0,12,0,2,1,100,1,0,75,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Artruis - 75% HP - Say text'),
(@ARTRUIS,0,13,0,2,1,100,1,0,50,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Artruis - 50% HP - Say text'),
(@ARTRUIS,0,14,0,2,1,100,1,0,30,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Artruis - 30% HP - Switch to phase 2'),
(@ARTRUIS,0,15,16,0,2,100,1,0,0,0,0,45,0,1,0,0,0,0,19,@ZEPIK,100,0,0,0,0,0,'Artruis - Phase 2 - Set data Jaloot'),
(@ARTRUIS,0,16,17,61,2,100,1,0,0,0,0,45,0,1,0,0,0,0,19,@JALOOT,100,0,0,0,0,0,'Artruis - Phase 2 - Set data Zepik'),
(@ARTRUIS,0,17,18,61,2,100,1,0,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Artruis - Phase 2 - Say text'),
(@ARTRUIS,0,18,0,61,2,100,1,0,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,'Artruis - 2 secs Phase 2 - Say text'),
(@ARTRUIS,0,19,20,38,2,100,1,0,1,0,0,45,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Artruis - Data set - Set data self'),
(@ARTRUIS,0,20,21,61,2,100,1,0,1,0,0,28,52185,0,0,0,0,0,1,0,0,0,0,0,0,0,'Artruis - Data set - Remove auras Bindings of Submission'),
(@ARTRUIS,0,21,0,61,2,100,1,0,1,0,0,22,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Artruis - Data set - Switch to phase 3'),
(@ARTRUIS,0,22,23,6,0,100,0,0,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,'Artruis - Death - Say text'),
(@ARTRUIS,0,23,0,61,0,100,0,0,0,0,0,11,52518,2,0,0,0,0,1,0,0,0,0,0,0,0,'Artruis - Death - Cast Summon Artruis Quest Complete'),
(@ARTRUIS,0,24,0,7,0,100,0,0,0,0,0,28,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Artruis - Evade - Remove all auras'),
-- Jaloot SAI
(@JALOOT,0,0,1,11,0,100,0,0,571,3711,0,11,52182,2,0,0,0,0,1,0,0,0,0,0,0,0,'Jaloot - Spawn - Cast Tomb of the Hearthless'),
(@JALOOT,0,1,2,61,0,100,0,0,0,0,0,18,512,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jaloot - Spawn - Set unit flags'),
(@JALOOT,0,2,0,61,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jaloot - Spawn - Reset faction'),
(@JALOOT,0,3,4,38,0,100,1,0,1,0,0,45,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jaloot - Data set 1 - Set data self'),
(@JALOOT,0,4,5,61,0,100,1,0,0,0,0,28,52182,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jaloot - Data set 1 - Remove auras Cast Tomb of the Hearthless'),
(@JALOOT,0,5,6,61,0,100,1,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jaloot - Data set 1 - Set faction 14'),
(@JALOOT,0,6,7,61,0,100,1,0,0,0,0,86,52185,0,19,@ARTRUIS,100,0,1,0,0,0,0,0,0,0,'Jaloot - Data set 1 - Cross cast Bindings of Submission'),
(@JALOOT,0,7,0,61,0,100,1,0,0,0,0,49,0,0,0,0,0,0,21,40,0,0,0,0,0,0,'Jaloot - Data set 1 - Attack closest player'),
(@JALOOT,0,8,9,6,0,100,0,0,0,0,0,45,0,2,0,0,0,0,19,@ZEPIK,100,0,0,0,0,0,'Jaloot - Death - Set data Zepik'),
(@JALOOT,0,9,0,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,19,@ARTRUIS,100,0,0,0,0,0,'Jaloot - Death - Set data Artruis'),
(@JALOOT,0,10,11,38,0,100,1,0,2,0,0,45,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jaloot - Data set 2 - Set data self'),
(@JALOOT,0,11,12,61,0,100,1,0,0,0,0,19,512,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jaloot - Data set 2 - Remove unit flags'),
(@JALOOT,0,12,13,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jaloot - Data set 2 - Reset faction'),
(@JALOOT,0,13,14,61,0,100,1,0,0,0,0,49,0,0,0,0,0,0,19,@ARTRUIS,100,0,0,0,0,0,'Jaloot - Data set 2 - Attack Artruis'),
(@JALOOT,0,14,0,61,0,100,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jaloot - Data set 2 - Say text'),
(@JALOOT,0,15,16,1,0,100,1,40000,40000,0,0,11,52182,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jaloot - 40 sec OOC - Cast Cast Tomb of the Hearthless'),
(@JALOOT,0,16,17,61,0,100,0,0,0,0,0,18,512,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jaloot - 40 sec OOC - Set unit flags'),
(@JALOOT,0,17,0,61,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Jaloot - 40 sec OOC- Reset faction'),
-- Zepik SAI
(@ZEPIK,0,0,1,11,0,100,0,0,571,3711,0,11,52182,2,0,0,0,0,1,0,0,0,0,0,0,0,'Zepik - Spawn - Cast Tomb of the Hearthless'),
(@ZEPIK,0,1,2,61,0,100,0,0,0,0,0,18,512,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zepik - Spawn - Set unit flags'),
(@ZEPIK,0,2,0,61,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zepik - Spawn - Reset faction'),
(@ZEPIK,0,3,4,38,0,100,1,0,1,0,0,45,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zepik - Data set 1 - Set data self'),
(@ZEPIK,0,4,5,61,0,100,1,0,0,0,0,28,52182,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zepik - Data set 1 - Remove auras Cast Tomb of the Hearthless'),
(@ZEPIK,0,5,6,61,0,100,1,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zepik - Data set 1 - Set faction 14'),
(@ZEPIK,0,6,7,61,0,100,1,0,0,0,0,86,52185,0,19,@ARTRUIS,100,0,1,0,0,0,0,0,0,0,'Zepik - Data set 1 - Cross cast Bindings of Submission'),
(@ZEPIK,0,7,0,61,0,100,1,0,0,0,0,49,0,0,0,0,0,0,21,40,0,0,0,0,0,0,'Zepik - Data set 1 - Attack closest player'),
(@ZEPIK,0,8,9,6,0,100,0,0,0,0,0,45,0,2,0,0,0,0,19,@JALOOT,100,0,0,0,0,0,'Zepik - Death - Set data Jaloot'),
(@ZEPIK,0,9,0,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,19,@ARTRUIS,100,0,0,0,0,0,'Zepik - Death - Set data Artruis'),
(@ZEPIK,0,10,11,38,0,100,1,0,2,0,0,45,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zepik - Data set 2 - Set data self'),
(@ZEPIK,0,11,12,61,0,100,1,0,0,0,0,19,512,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zepik - Data set 2 - Remove unit flags'),
(@ZEPIK,0,12,13,61,0,100,1,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zepik - Data set 2 - Reset faction'),
(@ZEPIK,0,13,14,61,0,100,1,0,0,0,0,49,0,0,0,0,0,0,19,@ARTRUIS,100,0,0,0,0,0,'Zepik - Data set 2 - Attack Artruis'),
(@ZEPIK,0,14,0,61,0,100,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zepik - Data set 2 - Say text'),
(@ZEPIK,0,15,16,1,0,100,1,40000,40000,0,0,11,52182,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zepik - 40 sec OOC - Cast Cast Tomb of the Hearthless'),
(@ZEPIK,0,16,17,61,0,100,0,0,0,0,0,18,512,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zepik - 40 sec OOC - Set unit flags'),
(@ZEPIK,0,17,0,61,0,100,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zepik - 40 sec OOC- Reset faction');

DELETE FROM`conditions`WHERE`SourceTypeOrReferenceId`=13 AND`SourceEntry`=52185;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,52185,0,31,3,@JALOOT,0,0,'','Bindings of Submission can target only Jaloot'),
(13,1,52185,1,31,3,@ZEPIK,0,0,'','Bindings of Submission can target only Zepik');

DELETE FROM `creature_text` WHERE `entry` IN (@ARTRUIS,@JALOOT,@ZEPIK);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
-- Artruis texts
(@ARTRUIS,0,0,"Ah, the hero. Your little friends said you would come. This certainly saves me the trouble of hunting you down myself.",14,0,100,2,0,0,'Artruis the Heartless'),
(@ARTRUIS,1,0,"I have weathered a hundred years of war and suffering. Do you truly think it wise to pit your mortals boddies against a being that cannot die? I'd venture you have more to lose",14,0,100,2,0,0,'Artruis the Heartless'),
(@ARTRUIS,2,0,"Even shattered into countless pieces, the crystals all around weaken me... perhaps I should not have underestimated the titans so...",14,0,100,2,0,0,'Artruis the Heartless'),
(@ARTRUIS,3,0,"These two brave, ignorant fools despise each other, yet somehow they both spoke of you as a hero. Perhaps you just lack the will to choose a side... let me extend you that opportunity.",14,0,100,2,0,0,'Artruis the Heartless'),
(@ARTRUIS,4,0,"Artruis is shielded. You must choose your side quickly to break his spell.",41,0,100,2,0,0,'Artruis the Heartless'),
(@ARTRUIS,5,0,"Arthas once mustered strength...of the very same sort... perhaps his is the path that you will follow.",14,0,100,2,0,0,'Artruis the Heartless'),
-- Jaloot and Zepik texts
(@JALOOT,0,0,"Now you not catch us with back turned! Now we hurt you bad undead, BAD!",12,0,100,1,0,0,'Jaloot'),
(@ZEPIK,0,0,"You going die big bad undead thing! You not catch Zepik sleeping this time!",12,0,100,1,0,0,'Zepik the Gorloc Hunter');

-- Fix for quests "Hand of the Oracles" and "Frenzyheart Champion"
UPDATE `creature_questender` SET `id`=@JALOOT WHERE `quest`=12689;
UPDATE `creature_questender` SET `id`=@ZEPIK WHERE `quest`=12582;
UPDATE `creature_queststarter` SET `id`=@ZEPIK WHERE `quest`=12582;
