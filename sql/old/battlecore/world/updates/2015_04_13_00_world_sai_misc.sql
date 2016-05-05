-- Quest - Valduran the Stormborn
SET @VALDURAN := 29368;
SET @BRUOR := 30152;
SET @BOULDERCRAG := 29801;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@VALDURAN,@BRUOR,@BOULDERCRAG);
UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `id`=@VALDURAN;

DELETE FROM `event_scripts` WHERE `id`=19576;
INSERT INTO `event_scripts` (`id`,`command`,`datalong`,`datalong2`,`x`,`y`,`z`,`o`) VALUES
(19576,10,@BRUOR,120000,7733.702,110.573,1010.63574,2.940718),
(19576,10,@BOULDERCRAG,120000,7726.098,105.306,1010.63616,1.449245);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=56189;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17,0,56189,0,0,29,0,@VALDURAN,25,0,0,0,'','Sound War Horn can only be casted near Valduran the Stormborn'),
(17,0,56189,0,0,29,0,@BRUOR,50,0,1,0,'','Sound War Horn can only be not near Bruor Ironbane'),
(17,0,56189,0,0,29,0,@BOULDERCRAG,50,0,1,0,'','Sound War Horn can only be casted not near Bouldercrag the Rockshaper');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@VALDURAN,@BRUOR,@BOULDERCRAG) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@BRUOR*100,@BOULDERCRAG*100) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@VALDURAN,0,0,0,25,0,100,0,0,0,0,0,11,56220,3,0,0,0,0,1,0,0,0,0,0,0,0, 'Valduran the Stormborn - Reset - Cast Bladestorm'),
(@VALDURAN,0,1,0,25,0,100,0,0,0,0,0,18,768,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Valduran the Stormborn - Reset - Set unit flags'),
(@VALDURAN,0,2,0,25,0,100,0,0,0,0,0,60,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Valduran the Stormborn - Reset - Fly'),
(@VALDURAN,0,3,0,38,0,100,0,0,1,0,0,28,56220,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Valduran the Stormborn - Data set - Remove bladestorm aura'),
(@VALDURAN,0,4,5,38,0,100,0,0,2,0,0,19,768,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Valduran the Stormborn - Data set - Remove unit flags'),
(@VALDURAN,0,5,0,61,0,100,0,0,0,0,0,60,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Valduran the Stormborn - Data set - Fly off'),
(@VALDURAN,0,6,0,4,0,100,0,0,0,0,0,58,1,56326,3400,4800,35,15,1,0,0,0,0,0,0,0, 'Valduran the Stormborn - Aggro - Set template caster'),
(@VALDURAN,0,7,0,0,0,100,0,15000,18000,29000,33000,11,56322,1,0,0,0,0,1,0,0,0,0,0,0,0, 'Valduran the Stormborn - In combat - Cast Spark Frenzy'),
(@VALDURAN,0,8,0,0,0,100,0,3000,8000,23000,26000,11,56319,0,0,0,0,0,5,0,0,0,0,0,0,0, 'Valduran the Stormborn - In combat - Cast Ball Lightning'),
(@VALDURAN,0,9,0,6,0,100,0,0,0,0,0,33,29368,0,0,0,0,0,18,25,0,0,0,0,0,0, 'Valduran the Stormborn - Death - Give credit'),
(@VALDURAN,0,10,0,6,0,100,0,0,0,0,0,45,0,1,0,0,0,0,19,@BRUOR,20,0,0,0,0,0, 'Valduran the Stormborn - Death - Set Data Bruor Ironbane'),
(@BOULDERCRAG,0,0,1,54,0,100,0,0,0,0,0,83,3,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Bouldercrag the Rockshaper - Just created - Remove npc flags'),
(@BOULDERCRAG,0,1,2,61,0,100,0,0,0,0,0,66,0,0,0,0,0,0,19,@VALDURAN,50,0,0,0,0,0, 'Bouldercrag the Rockshaper - Just created - Face Valduran'),
(@BOULDERCRAG,0,2,3,61,0,100,0,0,0,0,0,2,1986,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Bouldercrag the Rockshaper - Just created - Set faction'),
(@BOULDERCRAG,0,3,0,61,0,100,0,0,0,0,0,80,@BOULDERCRAG*100,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Bouldercrag the Rockshaper - Just created - Run script'),
(@BRUOR,0,0,1,54,0,100,0,0,0,0,0,83,3,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Bruor Ironbane - Just created - Remove npc flags'),
(@BRUOR,0,1,2,61,0,100,0,0,0,0,0,66,0,0,0,0,0,0,19,@VALDURAN,50,0,0,0,0,0, 'Bruor Ironbane - Just created - Face Valduran'),
(@BRUOR,0,2,3,61,0,100,0,0,0,0,0,2,1986,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Bruor Ironbane - Just created - Set faction'),
(@BRUOR,0,3,4,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,19,@VALDURAN,100,0,0,0,0,0, 'Bruor Ironbane - Just created - Set data valduran'),
(@BRUOR,0,4,0,61,0,100,0,0,0,0,0,85,44762,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Bruor Ironbane - Just created - Invoker cast shake'),
(@BRUOR,0,5,0,38,0,100,0,0,1,0,0,80,@BRUOR*100,2,0,0,0,0,1,0,0,0,0,0,0,0, 'Bruor Ironbane - Data set - Run script'),
(@BOULDERCRAG*100,9,0,0,0,0,100,0,3000,3000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Bouldercrag the Rockshaper - Script - Say text'),
(@BOULDERCRAG*100,9,1,0,0,0,100,0,7000,7000,0,0,1,0,0,0,0,0,0,19,@BRUOR,30,0,0,0,0,0, 'Bouldercrag the Rockshaper - Script - Say text'),
(@BOULDERCRAG*100,9,2,0,0,0,100,0,0,0,0,0,17,45,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Bouldercrag the Rockshaper - Script - Set emote state'),
(@BOULDERCRAG*100,9,3,0,0,0,100,0,5000,5000,0,0,1,1,0,0,0,0,0,19,@BRUOR,30,0,0,0,0,0, 'Bouldercrag the Rockshaper - Script - Say text'),
(@BOULDERCRAG*100,9,4,0,0,0,100,0,0,0,0,0,17,45,0,0,0,0,0,19,@BRUOR,20,0,0,0,0,0, 'Bouldercrag the Rockshaper - Script - Set emote state'),
(@BOULDERCRAG*100,9,5,0,0,0,100,0,5000,5000,0,0,1,0,0,0,0,0,0,19,@VALDURAN,30,0,0,0,0,0, 'Bouldercrag the Rockshaper - Script - Say text'),
(@BOULDERCRAG*100,9,6,0,0,0,100,0,5000,5000,0,0,1,1,0,0,0,0,0,19,@VALDURAN,30,0,0,0,0,0, 'Bouldercrag the Rockshaper - Script - Say text'),
(@BOULDERCRAG*100,9,7,0,0,0,100,0,10000,10000,0,0,45,0,2,0,0,0,0,19,@VALDURAN,30,0,0,0,0,0, 'Bouldercrag the Rockshaper - Script - Set data Valduran'),
(@BOULDERCRAG*100,9,8,0,0,0,100,0,500,500,0,0,49,0,0,0,0,0,0,19,@VALDURAN,30,0,0,0,0,0, 'Bouldercrag the Rockshaper - Script - Attack Valduran'),
(@BRUOR*100,9,0,0,0,0,100,0,5000,5000,0,0,1,1,0,0,0,0,0,19,@BOULDERCRAG,0,0,0,0,0,0, 'Bruor Ironbane - Script - Say text'),
(@BRUOR*100,9,1,0,0,0,100,0,5000,5000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Bruor Ironbane - Script - Say text');

DELETE FROM `creature_text` WHERE `entry` IN (@VALDURAN,@BRUOR,@BOULDERCRAG);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@VALDURAN,0,0,'How predictable! But then, who would expect a rock to think like anything other than one?',12,0,100,153,0,0, 'Valduran the Stormborn'),
(@VALDURAN,1,0,'If you\'re so eager to fight, I\'ll oblige you. But know that nothing you do here can prevent the completion of the iron colossus!',12,0,100,35,0,0, 'Valduran the Stormborn'),
(@BOULDERCRAG,0,0,'At last, the tyranny of the stormforged is at its end!',12,0,100,397,0,0,'Bouldercrag the Rockshaper'),
(@BOULDERCRAG,1,0,'We\'ve defeated Valduran and we\'ll fell his colossus.',12,0,100,397,0,0,'Bouldercrag the Rockshaper'),
(@BRUOR,0,0,'No more will your minions assail the creatures of stone and their allies.',12,0,100,1,0,0,'Bruor Ironbane'),
(@BRUOR,1,0,'I am your doom, Valduran!',12,0,100,0,0,0, 'Bruor Ironbane'),
(@BRUOR,2,0,'Well fought! The day is ours, but the war goes on!',12,0,100,4,0,0,'Bruor Ironbane');
