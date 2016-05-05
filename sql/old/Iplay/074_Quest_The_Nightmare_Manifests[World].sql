-- Quest - The Nightmare Manifests
DELETE FROM `creature_ai_scripts` WHERE creature_id=15491;
UPDATE `creature_template` SET AIName='SmartAI', ScriptName='', flags_extra=0, type_flags=0, unit_flags=32768, faction_H=1254, faction_A=1254 WHERE entry=15633;
UPDATE `creature_template` SET AIName='SmartAI', ScriptName='', InhabitType=4, Faction_A=35, Faction_H=35, unit_flags=0, Type_flags=0, dynamicflags=128, speed_walk=2, baseattacktime=2000 WHERE entry=15491;
UPDATE `creature_template` SET AIName='SmartAI', ScriptName='', speed_walk=2.5, speed_run=3.75, type_flags=0, unit_flags=32768, faction_H=1254, faction_A=1254 WHERE entry=11832;

DELETE FROM `creature_text` WHERE entry IN (11832,15491,15629,15633,15628);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(11832,0,0,"We will locate the origin of the Nightmare through the fragments you collected, $n. From there, we will pull Eranikus through a rift in the Dream. Steel yourself, $c. We are inviting the embodiment of the Nightmare into our world.",12,0,100,0,0,0,'Keeper Remulos Say 0'),
(11832,1,1,"The rift will be opened there, above the Lake Elun'ara. Prepare yourself, $n. Eranikus's entry into our world will be wrought with chaos and strife.",12,0,100,0,0,0,'Keeper Remulos Say 1'),
(11832,2,2,"He will stop at nothing to get to Malfurion's physical manifistation. That must not happen... We must keep the beast occupied long enough for Tyrande to arrive.",12,0,100,0,0,0,'Keeper Remulos Say 2'),
(11832,3,3,"Defend Nighthaven, hero...",12,0,100,0,0,0,'Keeper Remulos Say 3'),
(11832,4,4,"Fiend! Face the might of Cenarius!",14,0,100,0,0,0,'Keeper Remulos Say 4'),
(11832,5,5,"Who is the predictable one, beast? Surely you did not think that we would summon you on top of Malfurion? Your redemption comes, Eranikus. You will be cleansed of this madness - this corruption.",14,0,100,0,0,0,'Keeper Remulos Say 4'),
(11832,6,6,"Hurry, $N! We must find protective cover!",12,0,100,0,0,0,'Keeper Remulos Say 6'),
(11832,7,7,"Please, champion, protect our people.",12,0,100,0,0,0,'Keeper Remulos Say 7'),
(11832,8,8,"It will be done, Eranikus. Be well, ancient one.",12,0,100,0,0,0,'Keeper Remulos Say 8'),
(11832,9,9,"Let us leave Nighthaven, hero Seek me out at the grove.",12,0,100,0,0,0,'Keeper Remulos Say 9'),
(15491,0,0,"Pitful predictable mortals... You know not what you have done! The master\'s will fulfilled. The Moonglade shall be destroyed and Malfurion along with it!",14,0,100,0,0,0,'Eranikus Say 0'),
(15491,1,1,"Eranikus, Tyrant of the Dream lets loose a sinister laugh.",16,0,100,0,0,0,'Eranikus Say 1'),
(15491,2,2,"You are certanly not your father, insect. Should it interest me, I would crush you with but a swipe of my claws. Turn Shan\'do Stormrage over to me and your pitiful life will be spared along with the lives of your people.",14,0,100,0,0,0,'Eranikus Say 2'),
(15491,3,3,"My redemption? You are bold, little one. My redemption comes by the will of my god.",14,0,100,0,0,0,'Eranikus Say 3'),
(15491,4,4,"Eranikus, Tyrant of the Dream roars furiously",16,0,100,0,0,0,'Eranikus Say 4'),
(15491,5,5,"Rise, servants of the Nightmare! Rise and destroy this world! Let there be no survivors...",14,0,100,0,0,0,'Eranikus Say 5'),
(15491,6,6,"Where is your savior? How long can you hold out against my attacks?",14,0,100,0,0,0,'Eranikus Say 6'),
(15491,7,7,"Remulos, look how easy they fall before me? You can stop this, fool. Turn the druid over to me and it will all be over...",14,0,100,0,0,0,'Eranikus Say 7'),
(15491,8,8,"Defeated my minions? Then face me, mortals!",14,0,100,0,0,0,'Eranikus Say 8'),
(15491,9,9,"IT BURNS! THE PAIN.. SEARING...",14,0,100,0,0,0,'Eranikus Say 9'),
(15491,10,10,"WHY? Why did this happen to... to me? Where were you Tyrande? Where were you when I fell from the grace of Elune?",14,0,100,0,0,0,'Eranikus Say 10'),
(15491,11,11,"I... I feel... I feel the touch of Elune upon my being once more... She smiles upon me... Yes... I...",14,0,100,0,0,0,'Eranikus Say 11'),
(15491,12,12,"Tyrande falls to one knee.",16,0,100,0,0,0,'Eranikus Say 12'),
(15633,0,0,"Seek absolution, Eranikus. All will be forgiven..",14,0,100,0,0,0,'Tyrande Say 0'),
(15633,1,1,"You will be forgiven, Eranikus. Elune will always love you. Break free of the bonds that command you!",14,0,100,0,0,0,'Tyrande Say 0'),
(15633,2,2,"The grasp of the Old Gods is unmoving. He is consumed by their dark thoughts... I... I... I cannot... cannot channel much longer... Elune aide me.",12,0,100,0,0,0,'Tyrande Say 0'),
(15628,0,0,"For so long, I was lost... The Nightmare's corruption had consumed me... And now, you... all of you.. you have saved me. Released me from its grasp.",12,0,100,0,0,0,'Eranikus the Redeemed Say 0'),
(15628,1,1,"But... Malfurion, Cenarius, Ysera... They still fight. They need me. I must return to the Dream at once.",12,0,100,0,0,0,'Eranikus the Redeemed Say 0'),
(15628,2,2,"My lady, I am unworthy of your prayer. Truly, you are an angel of light. Please, assist me in returning to the barrow den so that I may return to the Dream. I like Malfurion, also have a love awaiting me... I must return to her... to protect her...",12,0,100,0,0,0,'Eranikus the Redeemed Say 0'),
(15628,3,3,"And heroes... I hold that which you seek. May it once more see the evil dissolved. Remulos, see to it that our champion receives the shard of the Green Flight.",12,0,100,0,0,0,'Eranikus the Redeemed Say 0'),
(15629,0,0,"Nightmare Phantasm drinks in the suffering of the fallen.",16,0,100,0,0,0,'Nightmare Phantasm Say 0');

DELETE FROM `smart_scripts` WHERE `entryorguid`=11832 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=1183200 AND `source_type`=9;
INSERT INTO `smart_scripts` VALUES
(11832,0,0,0,19,0,100,1,8736,0,0,0,1,0,15000,0,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - Quest Accepted - Say 0'),
(11832,0,1,0,52,0,100,0,0,11832,0,0,53,0,11832,0,8736,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - Say 0 - Start WayPoint'),
(11832,0,2,0,52,0,100,0,0,11832,0,0,83,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - Quest Accepted - Remove npcflag'),
(11832,0,3,0,40,0,100,0,13,11832,0,0,54,95000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - WayPoint 13 - Pause'),
(11832,0,4,0,40,0,100,0,13,11832,0,0,1,1,10000,0,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - WayPoint 13 - Say 1'),
(11832,0,5,0,52,0,100,0,1,11832,0,0,1,2,10000,0,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - Say 1 - Say 2'),
(11832,0,6,0,52,0,100,0,2,11832,0,0,11,25813,0,0,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - Say 3 - Cast Conjure Dream Rift'),
(11832,0,7,0,52,0,100,0,2,11832,0,0,12,15491,3,3600000,0,0,0,8,0,0,0,7900.3569,-2654.0896,497.0288,0.63583,'Keeper Remulos - Say 3 - Summon Eranikus'),
(11832,0,8,0,52,0,100,0,2,11832,0,0,1,3,23000,0,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - Say 2 - Say 3'),
(11832,0,9,0,52,0,100,0,3,11832,0,0,1,4,31000,0,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - Say 3 - Say 4'),
(11832,0,10,0,52,0,100,0,4,11832,0,0,1,5,22000,0,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - Say 4 - Say 5'),
(11832,0,11,0,52,0,100,0,5,11832,0,0,1,6,10000,0,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - Say 5 - Say 6'),
(11832,0,12,0,40,0,100,0,20,11832,0,0,54,60000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - WayPoint 20 - Pause'),
(11832,0,13,0,40,0,100,0,20,11832,0,0,1,7,20000,0,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - WayPoint 20 - Say 7'),
(11832,0,14,0,52,0,100,0,7,11832,0,0,12,15629,3,3600000,0,0,0,8,0,0,0,7829.066,-2562.347,489.299,5.234,'Keeper Remulos - Say 7 - Summon 1'),
(11832,0,15,0,52,0,100,0,7,11832,0,0,12,15629,3,3600000,0,0,0,8,0,0,0,7828.889,-2580.694,489.299,0.753,'Keeper Remulos - Say 7 - Summon 2'),
(11832,0,16,0,52,0,100,0,7,11832,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - Say 7 - Aggresive'),
(11832,0,17,0,52,0,100,0,7,11832,0,0,49,0,0,0,0,0,0,19,15629,0,0,0,0,0,0,'Keeper Remulos - Say 7 - Attack'),
(11832,0,18,0,0,0,100,0,7000,14000,6000,12000,11,20665,0,0,0,0,0,18,20,0,0,0,0,0,0,'Keeper Remulos - Combat - Cast Regrowth'),
(11832,0,19,0,0,0,100,0,26000,52000,34000,46000,11,20664,0,0,0,0,0,18,20,0,0,0,0,0,0,'Keeper Remulos - Combat - Cast Regrowth'),
(11832,0,20,0,0,0,100,0,25000,25000,25000,50000,11,23381,0,0,0,0,0,18,20,0,0,0,0,0,0,'Keeper Remulos - Combat - Cast Healing Touch'),
(11832,0,21,0,0,0,100,0,10000,40000,40000,40000,11,25817,0,0,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - Combat - Cast Tranquility'),
(11832,0,22,0,0,0,100,0,16000,21000,19000,25000,11,21668,0,0,0,0,0,2,0,0,0,0,0,0,0,'Keeper Remulos - Combat - Cast Starfall'),
(11832,0,23,0,38,0,100,0,1,1,0,0,1,8,10000,0,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - Data Set - Say 8'),
(11832,0,24,0,52,0,100,0,8,11832,0,0,1,9,10000,0,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - Said 8 8 - Say 9'),
(11832,0,25,0,40,0,100,1,21,11832,0,0,49,0,0,0,0,0,0,11,15491,30,0,0,0,0,0,'Keeper Remulos - Attack - Summon'),
(11832,0,26,0,6,0,100,0,0,0,0,0,6,8736,0,0,0,0,0,18,40,0,0,0,0,0,0,'Keeper Remulos - Death - Fail'),
(11832,0,27,0,40,0,100,1,23,11832,0,0,54,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - WayPoint 23 - Pause'),
(11832,0,28,0,40,0,100,1,23,11832,0,0,66,2.835,0,0,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - WayPoint 23 - Face'),
(11832,0,29,0,52,0,100,0,9,11832,0,0,53,1,1183200,0,8736,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - Said 9 - Go Home'),
(11832,0,30,0,40,0,100,0,12,1183200,0,0,82,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - WayPoint 12 - npcflags'),
(11832,0,31,0,40,0,100,0,12,1183200,0,0,66,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - WayPoint 12 - Face'),
(11832,0,32,0,40,0,100,0,24,11832,0,0,80,1183200,0,1,0,0,0,1,0,0,0,0,0,0,0,'Keeper Remulos - WayPoint 24 - Run Script Only When OOC'),
(1183200,9,0,0,1,0,100,1,60000,60000,0,0,53,1,1183200,0,8736,0,0,1,0,0,0,0,0,0,0,'Script - OOC 1 Mintues - Go Home');

DELETE FROM `smart_scripts` WHERE `entryorguid`=15491 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE entryorguid IN (1549100,1549101) AND `source_type`=9;
INSERT INTO `smart_scripts` VALUES
(15491,0,0,0,1,0,100,1,13000,13000,13000,13000,1,0,15000,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - OOC 13 Sec - Say 0'),
(15491,0,1,0,52,0,100,0,0,15491,0,0,1,1,6000,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - Say 0 - Say 1'),
(15491,0,2,0,52,0,100,0,1,15491,0,0,1,2,34000,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - Say 1 - Say 2'),
(15491,0,3,0,52,0,100,0,2,15491,0,0,1,3,3000,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - Say 2 - Say 3'),
(15491,0,4,0,52,0,100,0,3,15491,0,0,1,4,3000,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - Say 3 - Say 4'),
(15491,0,5,0,52,0,100,0,4,15491,0,0,53,0,15491,0,8736,0,0,1,0,0,0,0,0,0,0,'Eranikus - Say 4 - Start WayPoint'),
(15491,0,6,0,40,0,100,0,3,15491,0,0,54,130000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - WayPoint 3 - Pause'),
(15491,0,7,0,40,0,100,0,3,15491,0,0,1,5,10000,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - WayPoint 3 - Say 5'),
(15491,0,8,0,52,0,100,0,5,15491,0,0,80,1549100,0,2,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - Say 5 - Start Script'),
(1549100,9,0,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7865.966,-2554.104,486.967,5.492,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549100,9,1,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7873.412,-2587.454,486.946,0.924,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549100,9,2,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7901.544,-2581.989,487.178,2.059,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549100,9,3,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7918.844,-2553.987,486.911,3.772,'Eranikus  - On Script - Summon Nightmare Phantasm'),
(1549100,9,4,0,0,0,100,0,5000,5000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7865.966,-2554.104,486.967,5.492,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549100,9,5,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7873.412,-2587.454,486.946,0.924,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549100,9,6,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7901.544,-2581.989,487.178,2.059,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549100,9,7,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7918.844,-2553.987,486.911,3.772,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549100,9,8,0,0,0,100,0,5000,5000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7865.966,-2554.104,486.967,5.492,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549100,9,9,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7873.412,-2587.454,486.946,0.924,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549100,9,10,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7901.544,-2581.989,487.178,2.059,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549100,9,11,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7918.844,-2553.987,486.911,3.772,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549100,9,12,0,0,0,100,0,5000,5000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7865.966,-2554.104,486.967,5.492,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549100,9,13,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7873.412,-2587.454,486.946,0.924,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549100,9,14,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7901.544,-2581.989,487.178,2.059,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549100,9,15,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7918.844,-2553.987,486.911,3.772,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549100,9,16,0,0,0,100,0,1000,1000,0,0,1,6,35000,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - On Script - Say 6'),
(15491,0,9,0,52,0,100,0,6,15491,0,0,80,1549101,0,2,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - Say 6 - Start Script'),
(1549101,9,0,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7865.966,-2554.104,486.967,5.492,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549101,9,1,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7873.412,-2587.454,486.946,0.924,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549101,9,2,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7901.544,-2581.989,487.178,2.059,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549101,9,3,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7918.844,-2553.987,486.911,3.772,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549101,9,4,0,0,0,100,0,5000,5000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7865.966,-2554.104,486.967,5.492,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549101,9,5,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7873.412,-2587.454,486.946,0.924,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549101,9,6,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7901.544,-2581.989,487.178,2.059,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549101,9,7,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7918.844,-2553.987,486.911,3.772,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549101,9,8,0,0,0,100,0,5000,5000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7865.966,-2554.104,486.967,5.492,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549101,9,9,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7873.412,-2587.454,486.946,0.924,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549101,9,10,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7901.544,-2581.989,487.178,2.059,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549101,9,11,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7918.844,-2553.987,486.911,3.772,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549101,9,12,0,0,0,100,0,5000,5000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7865.966,-2554.104,486.967,5.492,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549101,9,13,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7873.412,-2587.454,486.946,0.924,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549101,9,14,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7901.544,-2581.989,487.178,2.059,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549101,9,15,0,0,0,100,0,1000,1000,0,0,12,15629,3,600000,0,0,0,8,0,0,0,7918.844,-2553.987,486.911,3.772,'Eranikus - On Script - Summon Nightmare Phantasm'),
(1549101,9,16,0,0,0,100,0,1000,1000,0,0,1,7,35000,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - On Script - Say 7'),
(15491,0,10,0,40,0,100,0,4,15491,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - Waypont 4 - Enemy'),
(15491,0,38,0,40,0,100,0,4,15491,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - Waypont 4 - Aggresive'),
(15491,0,11,0,2,0,100,0,30,65,12000,35000,12,15629,3,600000,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - Combat - Summon Nightmare Phantasm'),
(15491,0,12,0,4,1,100,0,0,0,0,0,1,8,0,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - AGGRO - Say 8'),
(15491,0,13,0,4,0,100,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - AGGRO - Aggresive'),  
(15491,0,14,0,4,0,100,0,0,0,0,0,49,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Eranikus - AGGRO - Attack'),
(15491,0,15,0,0,0,100,0,2000,4000,55000,60000,11,24818,0,0,0,0,0,2,0,0,0,0,0,0,0,'Eranikus - Combat - Cast Noxious Breath'),
(15491,0,16,0,0,0,100,0,9000,14000,50000,55000,11,24839,0,0,0,0,0,2,0,0,0,0,0,0,0,'Eranikus - Combat - Cast Acid Spit'),
(15491,0,17,0,0,0,100,0,10000,20000,15000,25000,11,22878,0,0,0,0,0,2,0,0,0,0,0,0,0,'Eranikus - Combat - Cast Shadow Bolt Volley'),
(15491,0,18,0,2,0,100,1,0,70,0,0,12,15633,3,3600000,0,0,0,8,0,0,0,7900.216,-2572.621,488.176,2.330,'Eranikus - 70% - Summon Tyrande'),
(15491,0,34,0,2,0,100,1,0,69,0,0,1,0,0,0,0,0,0,11,15633,30,0,0,0,0,0,'Eranikus - 69% - Tyrande Say 0'),
(15491,0,35,0,2,0,100,1,0,30,0,0,1,1,0,0,0,0,0,11,15633,30,0,0,0,0,0,'Eranikus - 30% - Tyrande Say 1'),
(15491,0,19,0,2,0,100,1,0,25,0,0,1,9,0,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - 25% - Say 9'),
(15491,0,20,0,2,0,100,1,0,22,0,0,1,10,0,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - 22% - Say 10'),
(15491,0,21,0,2,0,100,1,0,20,0,0,1,11,0,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - 20% - Say 11'),
(15491,0,22,0,52,0,100,0,11,15491,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - Say 2 - Friendly'),
(15491,0,23,0,52,0,100,0,11,15491,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - Say 2 - Passive'),
(15491,0,24,0,52,0,100,0,11,15491,0,0,18,33555200,0,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - Say 2 - Flags'),
(15491,0,25,0,52,0,100,0,11,15491,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - Say 2 - No AutoAttack'),
(15491,0,26,0,52,0,100,0,11,15491,0,0,1,12,3000,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - Say 11 - Say 12'),
(15491,0,27,0,52,0,100,0,12,15491,0,0,12,15628,3,60000,0,0,0,8,0,0,0,7904.248,-2564.867,488.156,5.116,'Eranikus - Say 12 - Summon Eranikus the Redeemed'),  
(15491,0,28,0,52,0,100,0,12,15491,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - Say 12 - Kill'),
(15491,0,31,0,7,0,100,0,0,0,0,0,6,8736,0,0,0,0,0,18,40,0,0,0,0,0,0,'Eranikus - Evade - Quest Fail'),
(15491,0,32,0,6,0,100,0,0,0,0,0,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - Death - Unseen'),
(15491,0,33,0,40,0,100,0,5,15491,0,0,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus  - WayPoint 5 - Unseen'),
(15491,0,36,0,40,0,100,0,5,15491,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus  - WayPoint 5 - Die'),
(15491,0,37,0,40,0,100,0,5,15491,0,0,6,8736,0,0,0,0,0,18,40,0,0,0,0,0,0,'Eranikus - WayPoint 5 - Quest Fail');

DELETE FROM `smart_scripts` WHERE entryorguid IN(15633);
INSERT INTO `smart_scripts` VALUES
(15633,0,0,0,54,0,100,1,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Tyrande - Summon - Aggresive'),
(15633,0,1,0,1,0,100,1,95000,95000,95000,95000,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Tyrande - OOC 60 Sec - Unseen'),
(15633,0,2,0,1,0,100,1,96000,96000,96000,96000,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Tyrande - OOC 61 Sec - Kill'),
(15633,0,3,0,0,0,100,0,1000,2000,2300,2500,11,21668,0,0,0,0,0,11,15491,20,0,0,0,0,0,'Tyrande - Combat - Cast Starfall');

UPDATE `creature_template` SET AIName='SmartAI', modelid1=6984 WHERE entry=15628;
DELETE FROM `smart_scripts` WHERE entryorguid IN(15628) AND `source_type`=0;
INSERT INTO `smart_scripts` VALUES
(15628,0,0,0,1,0,100,1,7000,7000,7000,7000,1,0,10000,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus the Redeemed - OOC 7 Secs - Say 0'),
(15628,0,1,0,52,0,100,0,0,15628,0,0,1,1,10000,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - Say 0 - Say 1'),
(15628,0,2,0,52,0,100,0,1,15628,0,0,1,2,10000,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - Say 1 - Say 2'),
(15628,0,3,0,52,0,100,0,2,15628,0,0,1,3,10000,0,0,0,0,1,0,0,0,0,0,0,0,'Eranikus - Say 2 - Say 3'),
(15628,0,5,0,52,0,100,0,3,15628,0,0,15,8736,0,0,0,0,0,18,50,0,0,0,0,0,0,'Eranikus - Say 3 - Credit'),
(15628,0,6,0,52,0,100,0,3,15628,0,0,45,1,1,0,0,0,0,11,11832,40,0,0,0,0,0,'Eranikus - Say 3 - Cast Trigger');

UPDATE `creature_template` SET AIName='SmartAI', Faction_A=14, Faction_H=14 WHERE entry=15629;
DELETE FROM `smart_scripts` WHERE entryorguid IN(15629) AND `source_type`=0;
INSERT INTO `smart_scripts` VALUES
(15629,0,0,0,54,0,100,0,0,0,0,0,53,1,15629,0,8736,0,0,1,0,0,0,0,0,0,0,'Nightmare Phantasm - Summon - Start WayPoint'),
(15629,0,1,0,54,0,100,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Nightmare Phantasm - Summon - Aggresive'),
(15629,0,2,0,54,0,100,0,0,0,0,0,49,0,0,0,0,0,0,18,50,0,0,0,0,0,0,'Nightmare Phantasm - Summon - Attack Player'),
(15629,0,3,0,6,0,20,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Nightmare Phantasm - Death - Say 0'),
(15629,0,4,0,40,0,100,0,4,15629,0,0,53,1,15629,0,8736,0,0,1,0,0,0,0,0,0,0,'Nightmare Phantasm - WayPoint 20 - Start Again'),
(15629,0,5,0,1,0,100,1,60000,60000,60000,60000,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Nightmare Phantasm - OOC 60 Secs - Unseen'),
(15629,0,6,0,1,0,100,1,63000,63000,63000,63000,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Nightmare Phantasm - OOC 63 Secs - Despawn'),
(15629,0,7,0,1,0,100,1,5000,5000,5000,5000,53,1,15629,0,8736,0,0,1,0,0,0,0,0,0,0,'Nightmare Phantasm - OOC 5 Secs - Start WayPoint');

-- Waypoints
DELETE FROM `waypoints` WHERE entry=11832;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(11832,1,7829.66,-2244.87,463.87,'Keeper Remulos'),
(11832,2,7817.25,-2306.20,456.00,'Keeper Remulos'),
(11832,3,7866.54,-2312.20,463.32,'Keeper Remulos'),
(11832,4,7908.488,-2309.086,467.677,'Keeper Remulos'),
(11832,5,7933.290,-2314.777,473.674,'Keeper Remulos'),
(11832,6,7942.543457,-2320.170654,476.770355,'Keeper Remulos'),
(11832,7,7953.036133,-2357.953613,486.379303,'Keeper Remulos'),
(11832,8,7962.706055,-2411.155518,488.955231,'Keeper Remulos'),
(11832,9,7976.860352,-2552.697998,490.081390,'Keeper Remulos'),
(11832,10,7949.307617,-2569.120361,489.716248,'Keeper Remulos'),
(11832,11,7950.945801,-2597.000000,489.765564,'Keeper Remulos'),
(11832,12,7948.758301,-2610.823486,492.368988,'Keeper Remulos'),
(11832,13,7928.785156,-2629.920654,492.524933,'Keeper Remulos'), ## stop
(11832,14,7948.697754,-2610.551758,492.363983,'Keeper Remulos'),
(11832,15,7952.019531,-2591.974609,490.081238,'Keeper Remulos'),
(11832,16,7940.567871,-2577.845703,488.946808,'Keeper Remulos'),
(11832,17,7908.662109,-2566.450439,488.634644,'Keeper Remulos'),
(11832,18,7873.132324,-2567.422363,486.946442,'Keeper Remulos'),
(11832,19,7839.844238,-2570.598877,489.286224,'Keeper Remulos'),
(11832,20,7830.678597,-2572.878974,489.286224,'Keeper Remulos'),
(11832,21,7890.504,-2567.259,487.306,'Keeper Remulos'),
(11832,22,7906.447,-2566.105,488.435,'Keeper Remulos'),
(11832,23,7925.861,-2573.601,489.642,'Keeper Remulos'),
(11832,24,7912.283,-2568.500,488.891,'Keeper Remulos');

-- Waypoints
DELETE FROM `waypoints` WHERE entry IN(15491);
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(15491,1,7949.812,-2605.4748,513.591,'Eranikus'),
(15491,2,7931.3330,-2575.2097,489.6286,'Eranikus'),
(15491,3,7925.129,-2573.747,493.901,'Eranikus'),
(15491,4,7910.554,-2565.5534,488.616,'Eranikus'),
(15491,5,7867.442,-2567.334,486.946,'Eranikus');

-- Waypoints
DELETE FROM `waypoints` WHERE entry IN(15629);
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(15629,1,7891.990,-2566.737,487.385,'Phantasm'),
(15629,2,7865.966,-2554.104,486.967,'Phantasm'),
(15629,3,7901.544,-2581.989,487.178,'Phantasm'),
(15629,4,7918.844,-2553.987,486.911,'Phantasm'),
(15629,5,7873.412,-2587.454,486.946,'Phantasm');

-- Waypoints
DELETE FROM `waypoints` WHERE entry=1183200;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(1183200,12,7847.066,-2217.571,470.403,'Keeper Remulos'),
(1183200,11,7829.66,-2244.87,463.87,'Keeper Remulos'),
(1183200,10,7817.25,-2306.20,456.00,'Keeper Remulos'),
(1183200,9,7866.54,-2312.20,463.32,'Keeper Remulos'),
(1183200,8,7908.488,-2309.086,467.677,'Keeper Remulos'),
(1183200,7,7933.290,-2314.777,473.674,'Keeper Remulos'),
(1183200,6,7942.543457,-2320.170654,476.770355,'Keeper Remulos'),
(1183200,5,7953.036133,-2357.953613,486.379303,'Keeper Remulos'),
(1183200,4,7962.706055,-2411.155518,488.955231,'Keeper Remulos'),
(1183200,3,7976.860352,-2552.697998,490.081390,'Keeper Remulos'),
(1183200,2,7949.307617,-2569.120361,489.716248,'Keeper Remulos'),
(1183200,1,7940.567871,-2577.845703,488.946808,'Keeper Remulos');
