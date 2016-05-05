UPDATE `quest_template` SET `RequiredRaces`=1101 WHERE `ID`=11580;
UPDATE `quest_template` SET `RequiredRaces`=690 WHERE `ID`=11581;

-- Fix A Thief's Reward
DELETE FROM `creature_queststarter` WHERE `quest` IN (9365, 9339);
UPDATE `quest_template` SET `NextQuestId`=9365 WHERE `Id` IN (9324,9325,9326,11935);
UPDATE `quest_template` SET `NextQuestId`=9339 WHERE `Id` IN (9330,9331,9332,11933);