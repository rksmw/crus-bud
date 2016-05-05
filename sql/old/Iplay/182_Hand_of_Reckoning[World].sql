-- Hand of Reckoning solo debe afectar a criaturas
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 67485;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `NegativeCondition`, `ErrorType`, `Comment`) VALUES (17, 67485, 32, 1, 16, 1, 12, 'Hand of Reckoning - Only target Creatures');
