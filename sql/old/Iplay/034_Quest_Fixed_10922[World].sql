DELETE FROM `creature_text` WHERE `entry` IN (22464);
INSERT INTO `creature_text` VALUES
('22464','0','0',"Wow... a drum.",'12','0','0','0','0','0','SAY_01'),
('22464','1','0',"This discovery will surely rock the foundation of modern archaeology.",'12','0','0','0','0','0','SAY_02'),
('22464','2','0',"Yea, great. Can we leave now? This desert is giving me hives.",'12','0','0','0','0','0','SAY_03'),
('22464','3','0',"This reminds me of that one time where you made us search Silithus for evidence of sand gnomes.",'12','0','0','0','0','0','SAY_04'),
('22464','4','0',"Or that time when you told us that you'd discovered the cure for the plague of the 20th century. What is that even? 20th century?.",'12','0','0','0','0','0','SAY_05'),
('22464','5','0',"I don't think it can top the one time where he told us that he'd heard that Arthas's 'cousin's' skeleton was frozen beneath a glacier in Winterspring. I'll never forgive you for that one, Letoll. I mean honestly... Arthas's cousin?",'12','0','0','0','0','0','SAY_06'),
('22464','6','0',"I dunno. It can't possibly beat the time he tried to convince us that we're all actually a figment of some being's imagination and that they only use us for their own personal amusement. That went over well during dinner with the family.",'12','0','0','0','0','0','SAY_07'),
('22464','7','0',"Say, do you guys hear that?",'12','0','0','0','0','0','SAY_08');


DELETE FROM `creature_text` WHERE `entry` IN (22458);
INSERT INTO `creature_text` VALUES
('22458','0','0',"Aright, listen up! Form a circle around me and move out!",'12','0','0','0','0','0','SAY_01'),
('22458','1','0',"Aright, $r, just keep us safe from harm while we work. We'll pay you when we return.",'12','0','0','0','0','0','SAY_00'),
('22458','2','0',"The dig site is just north of here.",'12','0','0','0','0','0','SAY_03'),
('22458','3','0',"We're here! Start diggin'!",'12','0','0','0','0','0','SAY_04'),
('22458','4','0',"I think there's somethin' buried here, beneath the sand!",'12','0','0','0','0','0','SAY_05'),
('22458','5','0',"Almost got it!",'12','0','0','0','0','0','SAY_06'),
('22458','6','0',"By Brann's brittle bananas! What is it!? It... it looks like a drum.",'12','0','0','0','0','0','SAY_07'),
('22458','7','0',"Have ye gone mad? You expect me to leave behind a drum without first beatin' on it? Not this son of Ironforge! No sir!",'12','0','0','0','0','0','SAY_08'),
('22458','8','0',"Shut yer yaps! I'm gonna bang on this drum and that's that!",'12','0','0','0','0','0','SAY_09'),
('22458','9','0',"IN YOUR FACE! I told you there was somethin' here!",'12','0','0','0','0','0','SAY_10'),
('22458','10','0',"Don't just stand there! Help him out!",'12','0','0','0','0','0','SAY_11'),
('22458','11','0',"Chief Archaeologist Letoll picks up the drum.",'16','0','0','0','0','0','SAY_12'),
('22458','12','0',"You've been a tremendous help, $r! Let's get out of here before more of those things show up! I'll let Dwarfowitz know you did the job asked of ya' admirably.",'12','0','0','0','0','0','SAY_13');

DELETE FROM `script_waypoint` WHERE `entry` IN (22458);
INSERT INTO `script_waypoint` VALUES
('22458','1','-3739.23','5394.8','-3.98526','6000',''),
('22458','2','-3749.04','5390.3','-4.76826','0',''),
('22458','3','-3749.04','5390.3','-4.76826','7000',''),
('22458','4','-3749.04','5390.3','-4.76826','6000',''),
('22458','5','-3742.41','5373.3','-8.07055','0',''),
('22458','6','-3727.97','5362.52','-9.87969','0',''),
('22458','7','-3708.62','5361.36','-10.8524','0',''),
('22458','8','-3684.89','5375.09','-10.1881','0',''),
('22458','9','-3654.14','5390.77','-11.4423','0',''),
('22458','10','-3628.12','5389.86','-12.7422','0',''),
('22458','11','-3600.46','5398.74','-14.6838','0',''),
('22458','12','-3575.44','5415.61','-16.3017','0',''),
('22458','13','-3555.37','5440.08','-12.9708','2000',''),
('22458','14','-3553.57','5446.99','-11.9644','6000',''),
('22458','15','-3561.55','5460.15','-8.15195','2000',''),
('22458','16','-3561.55','5460.15','-8.15195','0',''),
('22458','17','-3561.55','5460.15','-8.15195','6000',''),
('22458','18','-3554.23','5452.65','-11.5346','0',''),
('22458','19','-3538.29','5456.23','-12.4662','2000',''),
('22458','20','-3538.29','5456.23','-12.4662','0',''),
('22458','21','-3538.29','5456.23','-12.4662','6000',''),
('22458','22','-3538.29','5456.23','-12.4662','6000',''),
('22458','23','-3551.26','5451.53','-11.93','6000',''),
('22458','24','-3551.26','5451.53','-11.93','7000',''),
('22458','25','-3551.26','5451.53','-11.93','7000',''),
('22458','26','-3551.26','5451.53','-11.93','7000',''),
('22458','27','-3551.26','5451.53','-11.93','7000',''),
('22458','28','-3551.26','5451.53','-11.93','7000',''),
('22458','29','-3551.26','5451.53','-11.93','7000',''),
('22458','30','-3551.26','5451.53','-11.93','7000',''),
('22458','31','-3551.26','5451.53','-11.93','7000',''),
('22458','32','-3551.26','5451.53','-11.93','7000',''),
('22458','33','-3551.26','5451.53','-11.93','7000',''),
('22458','34','-3551.26','5451.53','-11.93','7000',''),
('22458','35','-3551.26','5451.53','-11.93','6000',''),
('22458','36','-3551.26','5451.53','-11.93','3000',''),
('22458','37','-3551.26','5451.53','-11.93','5000','');

DELETE FROM `creature_formations` WHERE `leaderguid` IN (78818);
INSERT INTO `creature_formations` VALUES
(78818,78818,0,0,2),
(78818,78838,3,180,2),
(78818,78840,3,90,2),
(78818,78837,3,0,2),
(78818,78839,3,270,2);

UPDATE `creature_template` SET `scriptname` = 'npc_chief_archaeologist'  WHERE `entry` IN (22458);
UPDATE `creature_template` SET `scriptname` = 'bone_sifter'  WHERE `entry` IN (22466);
DELETE FROM `gameobject` WHERE `id` IN (185577);
