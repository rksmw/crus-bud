DELETE FROM `player_factionchange_items` WHERE `alliance_id` IN (16478, 16477, 16480, 16479, 16484, 16483, 28701, 28699, 28703, 28702, 28700) OR `horde_id` IN (16542, 16541, 16544, 16543, 16548, 16545, 28853, 28851, 28855, 28854, 28852);
INSERT INTO `player_factionchange_items` (`race_A`, `alliance_id`, `commentA`, `race_H`, `horde_id`, `commentH`) VALUES
(0, 16478, 'Field Marshal\'s Plate Helm', 0, 16542, 'Warlord\'s Plate Headpiece'),
(0, 16477, 'Field Marshal\'s Plate Armor', 0, 16541, 'Warlord\'s Plate Armor'),
(0, 16480, 'Field Marshal\'s Plate Shoulderguards', 0, 16544, 'Warlord\'s Plate Shoulders'),
(0, 16479, 'Marshal\'s Plate Legguards', 0, 16543, 'General\'s Plate Leggings'),
(0, 16484, 'Marshal\'s Plate Gauntlets', 0, 16548, 'General\'s Plate Gauntlets'),
(0, 16483, 'Marshal\'s Plate Boots', 0, 16545, 'General\'s Plate Boots'),
(0, 28701, 'Grand Marshal\'s Plate Helm', 0, 28853, 'High Warlord\'s Plate Helm'),
(0, 28699, 'Grand Marshal\'s Plate Chestpiece', 0, 28851, 'High Warlord\'s Plate Chestpiece'),
(0, 28703, 'Grand Marshal\'s Plate Shoulders', 0, 28855, 'High Warlord\'s Plate Shoulders'),
(0, 28702, 'Grand Marshal\'s Plate Legguards', 0, 28854, 'High Warlord\'s Plate Legguards'),
(0, 28700, 'Grand Marshal\'s Plate Gauntlets', 0, 28852, 'High Warlord\'s Plate Gauntlets');
