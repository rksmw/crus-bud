-- Fix quest Back So Soon
UPDATE `spell_area` SET `quest_start_status`=64, `quest_end_status`=64 WHERE  `spell`=52217 AND `area`=4306 AND `quest_start`=12574;
