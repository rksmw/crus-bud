DELETE FROM `creature_text` WHERE `entry` = 25740;
INSERT INTO `creature_text` (`entry`, `groupid`, `text`, `type`, `comment`) VALUES 
(25740, 0, '%s will emerge soon!', 41, 'Ahune - SAY_EMERGE'),
(25740, 1, '%s submerged!', 41, 'Ahune - SAY_SUBMERGE'),
(25740, 2, '%s leaves the battle!', 41, 'Ahune - SAY_EVADE'),
(25740, 3, '%s enters the battle!', 41, 'Ahune - SAY_AGGRO');
