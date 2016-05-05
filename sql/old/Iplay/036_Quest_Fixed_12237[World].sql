-- Quest - Flight of the Wintergarde Defender
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_helpless_wintergarde_villager' WHERE `entry` IN (27336,27315);
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_wintergarde_gryphon' WHERE `entry`=27258;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (27336,27315) AND `source_type`=0;

DELETE FROM `creature_text` WHERE `entry` IN (27336,27315);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(27336,0,0,"HELP! HELP!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27336,0,1,"I'll die before I let one of you fiends turn me!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27336,0,2,"THEY'RE TRYING TO KILL ME! HELP!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27336,0,3,"Where did this all come from! Somebody help!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27336,0,4,"YOU'LL NEVER CATCH ME, FIENDS!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27336,1,0,"Are you sure you know how to fly this thing? Feels a little wobbly.",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27336,1,1,"For the love of the Light, get me out of here!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27336,1,2,"I don't mean to sound ungrateful, but could you fly a little closer to the ground? I hate heights!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27336,1,3,"I picked a bad day to stop drinking!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27336,1,4,"I'm gettin' a little woozy... Oooooof...",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27336,1,5,"Who woulda thought that we'd have this problem again? Oh wait, EVERYBODY DID!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27336,2,0,"How can I ever repay you for this, friend?",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27336,2,1,"HURRAY!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27336,2,2,"Kindness is not lost with this one, Urik. Thank you, hero!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27336,2,3,"My shop's doors will always be open to you, friend.",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27336,2,4,"Safe at last! Thank you, stranger!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27336,2,5,"Thanks for your help, hero!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27336,2,6,"We made it! We actually made it!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27336,2,7,"You are my guardian angel! Like a white knight you flew in from the heavens and lifted me from the pit of damnation!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27336,2,8,"You saved my life! Thanks!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27315,0,0,"HELP! HELP!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27315,0,1,"I'll die before I let one of you fiends turn me!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27315,0,2,"THEY'RE TRYING TO KILL ME! HELP!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27315,0,3,"Where did this all come from! Somebody help!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27315,0,4,"YOU'LL NEVER CATCH ME, FIENDS!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27315,1,0,"Are you sure you know how to fly this thing? Feels a little wobbly.",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27315,1,1,"For the love of the Light, get me out of here!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27315,1,2,"I don't mean to sound ungrateful, but could you fly a little closer to the ground? I hate heights!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27315,1,3,"I picked a bad day to stop drinking!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27315,1,4,"I'm gettin' a little woozy... Oooooof...",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27315,1,5,"Who woulda thought that we'd have this problem again? Oh wait, EVERYBODY DID!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27315,2,0,"How can I ever repay you for this, friend?",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27315,2,1,"HURRAY!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27315,2,2,"Kindness is not lost with this one, Urik. Thank you, hero!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27315,2,3,"My shop's doors will always be open to you, friend.",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27315,2,4,"Safe at last! Thank you, stranger!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27315,2,5,"Thanks for your help, hero!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27315,2,6,"We made it! We actually made it!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27315,2,7,"You are my guardian angel! Like a white knight you flew in from the heavens and lifted me from the pit of damnation!",12,0,100,0,0,0, "Helpless Wintergarde Villager"),
(27315,2,8,"You saved my life! Thanks!",12,0,100,0,0,0, "Helpless Wintergarde Villager");

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry` IN (48363,48397);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=48363;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,1,48363,0,0,31,0,3,27336,0,0,0,'',''),
(13,1,48363,0,1,31,0,3,27315,0,0,0,'',''),
(17,0,48363,0,0,1,0,43671,0,0,1,0,'',''),
(17,0,48397,0,0,1,0,43671,0,0,0,0,'',''),
(17,0,48397,0,0,30,0,300199,10,0,0,0,'','');

DELETE FROM `creature` WHERE `id` IN (27336,27315);
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `curhealth`, `curmana`) VALUES
(27315, 571, 1, 1, 3633.06, -1272.1, 112.434, 4.0006, 120, 4979, 0),
(27315, 571, 1, 1, 3631.63, -1275.4, 112.679, 2.77538, 120, 4979, 0),
(27315, 571, 1, 1, 3625.83, -1287.8, 112.494, 1.98212, 120, 4979, 0),
(27315, 571, 1, 1, 3582.22, -1416.01, 108.911, 0.855081, 120, 4979, 0),
(27315, 571, 1, 1, 3598.07, -1419.06, 109.073, 1.65226, 120, 4979, 0),
(27315, 571, 1, 1, 3591.05, -1396.51, 105.846, 5.02162, 120, 4979, 0),
(27315, 571, 1, 1, 3626.64, -1380.84, 109.345, 2.75967, 120, 4979, 0),
(27315, 571, 1, 1, 3630, -1379.77, 109.781, 2.68113, 120, 4979, 0),
(27315, 571, 1, 1, 3629.16, -1383.99, 109.892, 2.41802, 120, 4979, 0),
(27315, 571, 1, 1, 3579.84, -1276.13, 111.799, 6.03478, 120, 4979, 0),
(27315, 571, 1, 1, 3579.33, -1271.84, 111.62, 5.76382, 120, 4979, 0),
(27315, 571, 1, 1, 3586.99, -1275.51, 112.334, 4.80171, 120, 4979, 0),
(27336, 571, 1, 1, 3615.24, -1324.24, 112.096, 4.11057, 120, 4979, 0),
(27336, 571, 1, 1, 3614.94, -1320.64, 112.443, 4.0556, 120, 4979, 0),
(27336, 571, 1, 1, 3611.2, -1322, 111.987, 4.13021, 120, 4979, 0),
(27336, 571, 1, 1, 3527.66, -1354.28, 108.609, 3.60792, 120, 4979, 0),
(27336, 571, 1, 1, 3526.98, -1350.24, 108.199, 4.05952, 120, 4979, 0),
(27336, 571, 1, 1, 3523.91, -1354.88, 108.479, 5.73242, 120, 4979, 0),
(27336, 571, 1, 1, 3534.19, -1447.35, 106.594, 5.24548, 120, 4979, 0),
(27336, 571, 1, 1, 3531.15, -1449.14, 106.277, 5.91699, 120, 4979, 0),
(27336, 571, 1, 1, 3539.22, -1448.91, 106.952, 3.73751, 120, 4979, 0),
(27336, 571, 1, 1, 3557.25, -1496.55, 109.853, 5.7874, 120, 4979, 0),
(27336, 571, 1, 1, 3565.13, -1494.59, 110.055, 0.383859, 120, 4979, 0),
(27336, 571, 1, 1, 3564.05, -1500.27, 110.32, 2.02141, 120, 4979, 0);
