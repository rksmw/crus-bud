UPDATE quest_template SET ExclusiveGroup = 0 WHERE ExclusiveGroup = 24579;
DELETE FROM pool_template WHERE entry = 5678;
DELETE FROM pool_quest WHERE pool_quest.pool_entry = 5678;
