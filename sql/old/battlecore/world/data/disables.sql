DELETE FROM `disables` WHERE `sourceType` = 3;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(3, 11, 0, '', '', '(Arena) Ring of Valor'),
-- (3, 1, 0, '', '', '(Battleground) Alterac Valley'),
(3, 30, 0, '', '', '(Battleground) Isle of Conquest');
