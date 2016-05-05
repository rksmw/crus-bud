-- Quest - That's Abominable!
UPDATE `creature_template` SET `ScriptName`='npc_reanimated_abomination', `AIName`='', `spell1`=59564, `spell2`=59576, `minlevel`=80, `maxlevel`=80 WHERE `entry`=31692;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=59576;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTarget`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`Comment`) VALUES
(13,2,59576,0,0,31,3,31142,'Burst at the Seams - Implicit target - Icy Ghoul'),
(13,2,59576,1,0,31,3,31147,'Burst at the Seams - Implicit target - Vicious Geist'),
(13,2,59576,2,0,31,3,31205,'Burst at the Seams - Implicit target - Risen Alliance Soldier');
