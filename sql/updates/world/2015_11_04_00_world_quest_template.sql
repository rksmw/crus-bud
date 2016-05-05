-- Fire Brigade Practice (Alliance) (Only 1 may be completed)
UPDATE `quest_template` SET `ExclusiveGroup` = 11360 WHERE `id` IN (11360, 11439, 11440);
-- Fire Training (Horde) (Only 1 may be completed)
UPDATE `quest_template` SET `ExclusiveGroup` = 11361 WHERE `id` IN (11361, 11449, 11450);
-- "Let the fires come" and Stop the Fires! (Only 1 may be completed)
UPDATE `quest_template` SET `ExclusiveGroup` = 12135, `PrevQuestId` = 0 WHERE `id`IN (12135, 11131); -- Alliance
UPDATE `quest_template` SET `ExclusiveGroup` = 12139, `PrevQuestId` = 0 WHERE `id`IN (12139, 11219); -- Horde
-- The Headless Horseman may only be taken if completed the quest "Smashing the pumpkin"
UPDATE `quest_template` SET `RequiredRaces` = 1101, `ExclusiveGroup` = 0, `PrevQuestId` = 12133 WHERE `id` = 11135; -- Alliance
UPDATE `quest_template` SET `RequiredRaces` = 690, `ExclusiveGroup` = 0, `PrevQuestId` = 12155 WHERE `id` = 11220; -- Horde
-- Remove quest giver for Stop the fires! (It's added to offered quests via script only when Horseman is already Spawned)
DELETE FROM `creature_queststarter` WHERE `quest` IN (11131, 11219);
