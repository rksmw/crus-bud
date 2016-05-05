UPDATE creature_template SET scriptname = 'npc_warsong_hold_mage',unit_class = '8',unit_flags2='0',mindmg='295',maxdmg='446',attackpower='300' WHERE entry IN (25420);

UPDATE creature_template SET scriptname = 'npc_warsong_hold_warrior',unit_class = '1',unit_flags2='0',mindmg='295',maxdmg='446',attackpower='300' WHERE entry IN (25414);

UPDATE creature_template SET scriptname = 'npc_warsong_hold_shaman',unit_class = '8',unit_flags2='0',mindmg='295',maxdmg='446',attackpower='300' WHERE entry IN (25421);

UPDATE creature_template SET scriptname = 'npc_warsong_hold_peon' WHERE entry IN (25270);

DELETE FROM `creature_text` WHERE `entry` IN (25420);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(25420,0,0,"Vengeance shall be mine! For Quel'thanas! For the sin'dorei!",12,0,100,0,0,0, "Warsong Hold Mage 1"),
(25420,1,0,"Farewell, friend. I must return to Warsong Hold.",12,0,100,0,0,0, "Warsong Hold Mage 2"),
(25420,1,1,"Until we meet again, hero. Duty calls!",12,0,100,0,0,0, "Warsong Hold Mage 3");

DELETE FROM `creature_text` WHERE `entry` IN (25414);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(25414,0,0,"My axe is your, hero! Together we will destroy these insects!",12,0,100,0,0,0, "Warsong Hold Warrior 1"),
(25414,1,0,"I must return to Warsong Hold, hero. May you swim in the blood of our enemies and feast upon their sorrow!",12,0,100,0,0,0, "Warsong Hold Warrior 2"),
(25414,1,1,"I must return to Warsong Hold. Battle hard, hero",12,0,100,0,0,0, "Warsong Hold Warrior 3");

DELETE FROM `creature_text` WHERE `entry` IN (25421);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(25421,0,0,"We will battle together to rid this quarry of the Scourge!",12,0,100,0,0,0, "Warsong Hold Shaman 1"),
(25421,0,1,"Rescued! You have my thanks and my aid, friend.",12,0,100,0,0,0, "Warsong Hold Shaman 2"),
(25421,1,0,"Ancestors be with you, hero. Farewell!",12,0,100,0,0,0, "Warsong Hold Shaman 3"),
(25421,1,1,"Spirits watch over you, friend. I must make my return to Warsong Hold.",12,0,100,0,0,0, "Warsong Hold Shaman 4");

DELETE FROM `creature_text` WHERE `entry` IN (25270);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(25270,0,0,"Mister Mortuus gonna be so mad! Me go home now.!",12,0,100,0,0,0, "Warsong Hold Peon 1"),
(25270,0,1,"Me no like new cold place.!",12,0,100,0,0,0, "Warsong Hold Peon 2"),
(25270,0,2,"HOORAY! ME FREE!",12,0,100,0,0,0, "Warsong Hold Peon 3"),
(25270,0,3,"Why it keep telling me to put da lotion in da basket? Me no like da lotion!",12,0,100,0,0,0, "Warsong Hold Peon 4"),
(25270,0,4,"Tanks, buddy!",12,0,100,0,0,0, "Warsong Hold Peon 5"),
(25270,0,5,"Why it keep telling me to put da lotion in da basket? Me no like da lotion!",12,0,100,0,0,0, "Warsong Hold Peon 6");

DELETE FROM `creature_equip_template` WHERE `entry` IN (25420);
INSERT INTO creature_equip_template VALUES (25420,1,22980,0,0);
DELETE FROM `creature_equip_template` WHERE `entry` IN (25414);
INSERT INTO creature_equip_template VALUES (25414,1,1461,0,0);
DELETE FROM `creature_equip_template` WHERE `entry` IN (25421);
INSERT INTO creature_equip_template VALUES (25421,1,35812,0,0);
