-- Quest - The Champion of Anguish
UPDATE `creature_template` SET `ScriptName`='npc_enormos' WHERE `entry`=30021;
UPDATE `creature_template` SET `ScriptName`='npc_vladof_the_butcher' WHERE `entry`=30022;

DELETE FROM `creature_text` WHERE `entry` IN (30022,30007);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(30022,0,0,"Yes, my precious, we will tear them apart! For the one true king!",14,0,100,0,0,0,"Vladof the Butcher"),
(30022,1,0,"Useless mongrel! I'll kill 'em myself!",14,0,100,0,0,0,"Vladof the Butcher"),
(30007,0,0,"From the Savage Ledge of Icecrown, Vladof the Butcher and his mammoth, Enormos! There ain't gonna be a thing left of our challengers, folks! Prepare for a downpour of blood, guts and tears!",14,0,100,0,0,0,"Gurgthock"),
(30007,1,0,"I DON'T BELIEVE IT! WE HAVE A NEW CHAMPION OF ANGUISH!!! Vladof the Butcher has been defeated by a ragtag crew of nobodies! Incredible finish!",14,0,100,0,0,0,"Gurgthock");
