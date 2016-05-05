-- Deathbringer Saurfang: ahora al morir un jugador con Mark of the Fallen Champion el boss se curara
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN(72260, 72278, 72279, 72280);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- 10man Normal
(13,1,72260,0,0,31,0,3,37813,0,0,0,'','Mark of the Fallen Champion - Implicit target - Saurfang - 10N'),
-- 10man Heroic
(13,1,72278,0,0,31,0,3,37813,0,0,0,'','Mark of the Fallen Champion - Implicit target - Saurfang - 10H'),
-- 25man Normal
(13,1,72279,0,0,31,0,3,37813,0,0,0,'','Mark of the Fallen Champion - Implicit target - Saurfang - 25N'),
-- 25man Heroic
(13,1,72280,0,0,31,0,3,37813,0,0,0,'','Mark of the Fallen Champion - Implicit target - Saurfang - 25H');
