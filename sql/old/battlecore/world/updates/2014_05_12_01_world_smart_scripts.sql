-- Quest - There Exists No Honor Among Birds
UPDATE `creature_template` SET `spell1`=44422, `spell2`=44423, `spell3`=44424, `InhabitType`=5 WHERE `entry`=24783;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=44422;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17,0,44422,0,0,30,0,186946,5,0,0,0,'','Scavenge can only be casted near Fjord Hawk Egg');
