DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = '17' AND `SourceEntry` IN('49345','49462','49461');
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
('17', '0', '49345', '0', '0', '4', '0', '4228', '0', '0', '0', '0', '0', '', 'Call Emerald Drake can only be used on The Oculus'),
('17', '0', '49462', '0', '0', '4', '0', '4228', '0', '0', '0', '0', '0', '', 'Call Ruby Drake can only be used on The Oculus'),
('17', '0', '49461', '0', '0', '4', '0', '4228', '0', '0', '0', '0', '0', '', 'Call Amber Drake can only be used on The Oculus');
