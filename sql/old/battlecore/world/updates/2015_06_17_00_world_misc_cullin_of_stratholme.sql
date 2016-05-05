-- script_waypoints for Arthas movements inside Culling
DELETE FROM `script_waypoint` WHERE `entry`=26499;
INSERT INTO `script_waypoint` (`entry`, `pointid`, `location_x`, `location_y`, `location_z`, `waittime`, `point_comment`) VALUES
(26499,0,1903.167,1291.573,143.32,0, 'culling Bridge WP1'),
(26499,1,1911.087,1314.263,150.026,0, 'culling Bridge WP2'),
(26499,2,1902.959,1295.127,143.388,10000, 'culling Bridge WP3'),
(26499,3,1913.726,1287.407,141.927,0, 'culling Bridge WP4'),
(26499,4,1990.833,1293.391,145.467,0, 'culling Bridge WP5'),
(26499,5,1997.003,1317.776,142.963,0, 'culling Bridge WP6'),
(26499,6,2019.631,1326.084,142.929,0, 'culling Bridge WP7'),
(26499,7,2026.469,1287.088,143.596,0, 'culling Bridge WP8'),
(26499,8,2050.660,1287.333,142.671,0, 'culling Bridge WP9'),
(26499,9,2081.447,1287.770,141.324,0, 'culling Streets WP1'),
(26499,10,2087.689,1280.344,140.730,0, 'culling Streets WP2'),
(26499,11,2092.154,1276.645,140.520,0, 'culling Streets WP3'),
(26499,12,2099.876,1280.21,138.55,0, 'culling Streets WP4'),
(26499,13,2120.757,1286.97,136.343,0, 'culling Streets WP5'),
(26499,14,2165.073,1279.338,133.40,0, 'culling Streets WP6'),
(26499,15,2186.441,1234.445,136.524,0, 'culling Streets WP7'),
(26499,16,2210.385,1207.550,136.259,0, 'culling Streets WP8'),
(26499,17,2243.594,1177.705,137.144,0, 'culling Streets WP9'),
(26499,18,2286.883,1177.262,137.631,0, 'culling Streets WP10'),
(26499,19,2320.374,1179.954,133.926,0, 'culling Streets WP11'),
(26499,20,2365.626,1194.838,131.974,0, 'culling Streets WP12'),
(26499,21,2366.559,1197.759,132.382,0, 'culling House WP1'),
(26499,22,2394.011,1205.148,134.125,0, 'culling House WP2'),
(26499,23,2395.854,1206.345,134.039,0, 'culling House WP3'),
(26499,24,2442.023,1219.205,133.999,0, 'culling House WP3'),
(26499,25,2447.105,1191.182,148.076,0, 'culling House WP4'),
(26499,26,2444.250,1190.510,148.076,0, 'culling House WP5'),
(26499,27,2418.487,1196.059,148.076,0, 'culling House WP6'),
(26499,28,2401.221,1191.705,148.076,0, 'culling House WP7'),
(26499,29,2409.205,1157.425,148.190,0, 'culling House WP8'),
(26499,30,2417.584,1121.026,148.082,0, 'culling House WP9'),
(26499,31,2423.123,1119.431,148.076,0, 'culling House WP10'),
(26499,32,2447.833,1112.714,148.076,0, 'culling House WP11'),
(26499,33,2457.133,1120.941,150.008,0, 'culling House WP12'),
(26499,34,2459.694,1127.012,150.008,0, 'culling House WP13'),
(26499,35,2469.617,1122.274,150.008,0, 'culling House WP14'),
(26499,36,2470.437,1122.794,150.008,3000, 'culling House WP15'),
(26499,37,2471.662,1123.077,150.035,3000, 'culling House WP16'),
(26499,38,2483.183,1125.042,149.905,0, 'culling Secret WP1'),
(26499,39,2487.867,1099.760,144.858,0, 'culling Secret WP2'),
(26499,40,2498.270,1101.929,144.599,0, 'culling Secret WP3'),
(26499,41,2492.114,1128.238,139.967,0, 'culling Secret WP4'),
(26499,42,2500.286,1130.183,139.982,0, 'culling Room WP1'),
(26499,43,2503.010,1119.241,139.978,0, 'culling Room WP2'),
(26499,44,2517.820,1122.645,132.066,0, 'culling Room WP3'),
(26499,45,2540.479,1129.061,130.868,7000, 'culling Fire Street WP1'),
(26499,46,2568.619,1157.794,126.906,0, 'culling Fire Street WP2'),
(26499,47,2556.074,1222.058,125.412,20000, 'culling Fire Street WP3'),
(26499,48,2521.531,1295.209,130.573,0, 'culling Fire Street WP4'),
(26499,49,2504.362,1348.667,132.944,0, 'culling Fire Street WP5'),
(26499,50,2450.594,1431.544,131.361,0, 'culling Fire Street WP6'),
(26499,51,2353.485,1404.839,128.531,0, 'culling Market WP1'),
(26499,52,2329.882,1406.273,128.013,0, 'culling Market WP2'),
(26499,53,2329.882,1406.273,128.013,12000, 'culling Market WP3'),
(26499,54,2327.391,1412.475,127.692,0, 'culling Market WP4'),
(26499,55,2303.016,1480.070,128.139,0, 'culling Crusader WP1'),
(26499,56,2296.665,1502.362,128.362,0, 'culling Crusader WP2');

UPDATE `instance_template` SET `script`='instance_culling_of_stratholme' WHERE `map`=595;
UPDATE `creature_template` SET `Scriptname`='npc_arthas' WHERE `entry`=26499;
UPDATE `creature_template` SET `Scriptname`='boss_salramm' WHERE `entry`=26530;
UPDATE `creature_template` SET `Scriptname`='boss_meathook' WHERE `entry`=26529;
UPDATE `creature_template` SET `Scriptname`='boss_epoch' WHERE `entry`=26532;
UPDATE `creature_template` SET `Scriptname`='boss_mal_ganis' WHERE `entry`=26533;
UPDATE `creature_template` SET `Scriptname`='boss_infinite_corruptor' WHERE `entry`=32273;


-- culling of stratholme
DELETE FROM `creature_text` WHERE `entry` IN (26499,26528,31126,28169,28167,26497);
INSERT INTO `creature_text`(`entry`,`groupid`,`id`,`type`,`sound`,`probability`,`comment`,`text`) VALUES
-- 26499
(26499,0,0,12,12828,100,"culling SAY_PHASE101","Glad you could make it, Uther."),
(26499,1,0,12,12829,100,"culling SAY_PHASE103","As if I could forget. Listen, Uther, there's something about the plague you should know..."),
(26499,2,0,12,12830,100,"culling SAY_PHASE104","Oh, no. We're too late. These people have all been infected! They may look fine now, but it's just a matter of time before they turn into the undead!"),
(26499,3,0,12,12831,100,"culling SAY_PHASE106","This entire city must be purged."),
(26499,4,0,12,12832,100,"culling SAY_PHASE108","Damn it, Uther! As your future king, I order you to purge this city!"),
(26499,5,0,12,12833,100,"culling SAY_PHASE110","Then I must consider this an act of treason."),
(26499,6,0,12,12834,100,"culling SAY_PHASE112","Have I? Lord Uther, by my right of succession and the sovereignty of my crown, I hereby relieve you of your command and suspend your paladins from service."),
(26499,7,0,12,12835,100,"culling SAY_PHASE114","It's done! Those of you who have the will to save this land, follow me! The rest of you... get out of my sight!"),
(26499,8,0,12,12836,100,"culling SAY_PHASE116","Jaina?"),
(26499,9,0,14,14327,100,"culling SAY_PHASE118","Take position here, and I will lead a small force inside Stratholme to begin the culling. We must contain and purge the infected for the sake of all of Lordaeron!"),
(26499,10,0,12,14293,100,"culling SAY_PHASE201","Everyone looks ready. Remember, these people are all infected with the plague and will die soon. We must purge Stratholme to protect the remainder of Lordaeron from the Scourge. Let's go."),
(26499,11,0,12,14294,100,"culling SAY_PHASE203","I can only help you with a clean death."),
(26499,12,0,12,14295,100,"culling SAY_PHASE205","That was just the beginning."),
(26499,13,0,14,14296,100,"culling SAY_PHASE208","I won't allow it, Mal'Ganis! Better that these people die by my hand than serve as your slaves in death!"),
(26499,14,0,14,14885,100,"culling SAY_PHASE209","Mal'ganis will send out some of his Scourge minions to interfere with us. Those of you with the strongest steel and magic shall go forth and destroy them. I will lead the rest of my forces in purging Stratholme of the infected."),
(26499,15,0,14,14297,100,"culling SAY_PHASE210","Champions, meet me at the Town Hall at once. We must take the fight to Mal'Ganis."),
(26499,16,0,12,14298,100,"culling SAY_PHASE301","Follow me, I know the way through."),
(26499,17,0,12,14299,100,"culling SAY_PHASE303","Yes, I'm glad I could get to you before the plague."),
(26499,18,0,12,14300,100,"culling SAY_PHASE304","What is this sorcery?"),
(26499,19,0,12,14301,100,"culling SAY_PHASE306. NEEDS VERIFICATION","Mal'Ganis appears to have more than scourge in his arsenal. We should make haste."),
(26499,20,0,12,14302,100,"culling SAY_PHASE307","More vile sorcery! Be ready for anything!"),
(26499,21,0,12,14303,100,"culling SAY_PHASE308","Let's move on."),
(26499,22,0,12,14304,100,"culling SAY_PHASE309","Watch your backs: they have us surrounded in this hall."),
(26499,23,0,12,0,100,"culling SAY_PHASE310. NEEDS VERIFICATION","One less obstacle to deal with."),
(26499,24,0,12,14305,100,"culling SAY_PHASE311","Mal'Ganis is not making this easy."),
(26499,25,0,12,14306,100,"culling SAY_PHASE312","They're very persistent."),
(26499,26,0,12,14307,100,"culling SAY_PHASE313","What else can he put in my way?"),
(26499,27,0,12,14309,100,"culling SAY_PHASE315","I do what I must for Lordaeron, and neither your words nor your actions will stop me."),
(26499,28,0,12,14308,100,"culling SAY_PHASE401","The quickest path to Mal'Ganis lies behind that bookshelf ahead."),
(26499,29,0,12,14310,100,"culling SAY_PHASE402","This will only take a moment."),
(26499,30,0,12,14311,100,"culling SAY_PHASE403","I'm relieved this secret passage still works."),
(26499,31,0,12,14312,100,"culling SAY_PHASE404","Let's move through here as quickly as possible. If the undead don't kill us, the fires might."),
(26499,32,0,12,14313,100,"culling SAY_PHASE405","Rest a moment and clear your lungs, but we must move again soon."),
(26499,33,0,12,14314,100,"culling SAY_PHASE406","That's enough; we must move again. Mal'Ganis awaits."),
(26499,34,0,12,14315,100,"culling SAY_PHASE407","At last some good luck. Market Row has not caught fire yet. Mal'Ganis is supposed to be in Crusaders' Square, which is just ahead. Tell me when you're ready to move forward."),
(26499,35,0,12,14316,100,"culling SAY_PHASE501","Justice will be done."),
(26499,36,0,12,14317,100,"culling SAY_PHASE502","We're going to finish this right now, Mal'Ganis. Just you... and me."),
(26499,37,0,12,14318,100,"culling SAY_PHASE503","I'll hunt you to the ends of the earth if I have to! Do you hear me? To the ends of the earth!"),
(26499,38,0,12,14319,100,"culling SAY_PHASE504","You performed well this day. Anything that Mal'Ganis has left behind is yours. Take it as your reward. I must now begin plans for an expedition to Northrend."),
-- 26528
(26528,0,0,12,12839,100,"culling SAY_PHASE102","Watch your tone with me, boy. You may be the prince, but I'm still your superior as a paladin!"),
(26528,1,0,12,12840,100,"culling SAY_PHASE105","What?"),
(26528,2,0,12,12841,100,"culling SAY_PHASE107","How can you even consider that? There's got to be some other way."),
(26528,3,0,12,12842,100,"culling SAY_PHASE109","You are not my king yet, boy! Nor would I obey that command even if you were!"),
(26528,4,0,12,12843,100,"culling SAY_PHASE111","Treason? Have you lost your mind, Arthas?"),
(26528,5,0,12,12844,100,"culling SAY_PHASE115","You've just crossed a terrible threshold, Arthas."),
-- 26497
(26497,0,0,12,12837,100,"culling SAY_PHASE113","Arthas! You can't just--"),
(26497,1,0,12,12838,100,"culling SAY_PHASE117","I'm sorry, Arthas. I can't watch you do this."),
-- 28167
(28167,0,0,12,0,100,"culling SAY_PHASE202","Prince Arthas, may the light be praised! Many people in the town have begun to fall seriously ill, can you help us?"),
-- 28169
(28169,0,0,12,0,100,"culling SAY_PHASE204","What? This can't be!"),
-- 31126
(31126,0,0,12,0,100,"culling SAY_PHASE302","Ah, you've finally arrived Prince Arthas. You're here just in the nick of time."),
(31126,1,0,12,0,100,"culling SAY_PHASE305","There's no need for you to understand, Arthas. All you need to do is die.");

-- malganis
/*DELETE FROM `creature_text` WHERE `entry`=26533;
INSERT INTO `creature_text`(`entry`,`groupid`,`id`,`type`,`sound`,`probability`,`comment`,`text`) VALUES
(26533,0,0,14,14410,100,"malganis SAY_INTRO_1 | culling SAY_PHASE206","Yes, this is the beginning. I've been waiting for you, young prince. I am Mal'Ganis."),
(26533,1,0,14,14411,100,"malganis SAY_INTRO_2 | culling SAY_PHASE207","As you can see, your people are now mine. I will now turn this city household by household, until the flame of life has been snuffed out... forever.");
(26533,2,0,14,14413,100,"malganis SAY_AGGRO","This will be a fine test...Prince Arthas..."),
(26533,3,0,14,14416,100,"malganis SAY_KILL_1","All too easy..."),
(26533,3,1,14,14417,100,"malganis SAY_KILL_2","The dark lord is displeased with your interference..."),
(26533,3,2,14,14418,100,"malganis SAY_KILL_3","It is Prince Arthas I want... not you..."),
(26533,4,0,14,14422,100,"malganis SAY_SLAY_1","Anak'Keri..."),
(26533,4,1,14,14423,100,"malganis SAY_SLAY_2","My onslaught will wash over the Lich King's forces..."),
(26533,4,2,14,14424,100,"malganis SAY_SLAY_3","Your death is in vain, tiny mortal..."),
(26533,4,3,14,14425,100,"malganis SAY_SLAY_4","Your time has come to an end!"),
(26533,5,0,14,14414,100,"malganis SAY_SLEEP_1","Time out..."),
(26533,5,1,14,14415,100,"malganis SAY_SLEEP_2","You seem...tired..."),
(26533,6,0,14,14426,100,"malganis SAY_30HEALTH","I spent too much time in that weak little shell..."),
(26533,7,0,14,14427,100,"malganis SAY_15HEALTH","(Eredun) I AM MAL'GANIS! I AM ETERNAL!"),
(26533,8,0,14,14428,100,"malganis SAY_ESCAPE_SPEECH_1","ENOUGH! I waste my time here...I must gather my strength on the home world..."),
(26533,9,0,14,14429,100,"malganis SAY_ESCAPE_SPEECH_2","You'll never defeat the Lich King without my forces! I'll have my revenge...on him, AND you..."),
(26533,10,0,14,14412,100,"malganis SAY_OUTRO","Your journey has just begun, young prince. Gather your forces and meet me in the artic land of Northrend. It is there that we shall settle the score between us. It is there that your true destiny will unfold.");
*/
-- chrono lord deja
DELETE FROM `creature_text` WHERE `entry`=17879;
INSERT INTO `creature_text`(`entry`,`groupid`,`id`,`type`,`sound`,`probability`,`comment`,`text`) VALUES
(17879,0,0,14,10412,100,"chrono lord deja SAY_ENTER","Why do you aid the Magus? Just think of how many lives could be saved if the portal is never opened, if the resulting wars could be erased ..."),
(17879,1,0,14,10414,100,"chrono lord deja SAY_AGGRO","If you will not cease this foolish quest, then you will die!"),
(17879,2,0,14,10413,100,"chrono lord deja SAY_BANISH","You have outstayed your welcome, Timekeeper. Begone!"),
(17879,3,0,14,10415,100,"chrono lord deja SAY_SLAY1","I told you it was a fool's quest!"),
(17879,3,1,14,10416,100,"chrono lord deja SAY_SLAY2","Leaving so soon?"),
(17879,4,0,14,10417,100,"chrono lord deja SAY_DEATH","Time ... is on our side.");

UPDATE `conditions` SET `ConditionValue2`=27827,`Comment`='Dispelling Illusions: Crate Dummy target' WHERE `SourceEntry`=49590;
DELETE FROM `creature` WHERE `id`=30996;
UPDATE `creature` SET `modelId`=0,`spawndist`=0,`MovementType`=0 WHERE `id` IN (27827,28960);
UPDATE `creature_template` SET `modelid1`=22712,`modelid2`=17200,`flags_extra`=`flags_extra`|128 WHERE `entry`=27827; -- reverse models (parsers fault)
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry`=28960; -- reverse models (parsers fault)

DELETE FROM `creature_text` WHERE `entry`=27915;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(27915,0,0, 'Good work with the crates! Come talk to me in front of Stratholme for your next assignment!',4,0,0,0,0,0, 'Chromie - SAY_EVENT_START');

UPDATE `creature_template` SET `ScriptName`='npc_create_helper_cot' WHERE `entry`=27827;


DELETE FROM `creature_text` WHERE `entry`=26527;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`, `BroadcastTextId`) VALUES
(26527, 0, 0, 'Oh, no! Adventurers, something awful has happened! A colleague of mine has been captured by the Infinite Dragonflight, and they''re doing something horrible to him! Keeping Arthas is still your highest priority, but if you act fast you could help save a Guardian of Time!', 15, 0, 100, 0, 0, 0, 'Chromie', 32670),
(26527, 1, 0, 'Adventurers, you must hurry! The Guardian of Time cannot last for much longer!', 15, 0, 100, 0, 0, 0, 'Chromie', 32678),
(26527, 2, 0, 'I can barely sense the Guardian of Time! His timeline is fading quickly!', 15, 0, 100, 0, 0, 0, 'Chromie', 32679);

DELETE FROM `conditions` WHERE `SourceEntry`=60422;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `Comment`) VALUES
(13, 1, 60422, 0, 0, 31, 1, 3, 32281, 0, 0, 0, 0, 'Corruption of Time (60422) can hit only Guardian of Time');
