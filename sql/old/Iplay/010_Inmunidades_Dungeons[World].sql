-- SELECT `difficulty_entry_1`, `difficulty_entry_2`,`difficulty_entry_3`FROM `creature_template` WHERE `entry`=27975
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|8|0x00000040|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|4194304|8388608|33554432|536870912 WHERE `entry`IN 
(
-- Halls Of Stone
27975, -- Maiden of Grief
31384, -- Maiden of Grief H
27977, -- Krystallus
31381, -- Krystallus H
27978, -- Sjonnir The Ironshaper
31386, -- Sjonnir The Ironshaper H
-- Todo Revisar inmunidades de trash del tribunal.
-- Halls Of Lightning
28586, -- General Bjarngrim
31533, -- General Bjarngrim H
28587, -- Volkhan
31536, -- Volkhan H
28546, -- Ionar
31537, -- Ionar H
28923, -- Loken
31538, -- Loken H
-- The Nexus
26731, -- Grand Magus Telestra
30510, -- Grand Magus Telestra H
26763, -- Anomalus
30529, -- Anomalus H
26794, -- Ormorok the Tree-Shaper
30532, -- Ormorok the Tree-Shaper H
26723, -- Keristrasza 
30540, -- Keristrasza H
26796, -- Commander Stoutbeard
30398, -- Commander Stoutbeard H
26798, -- Commander Kolurg
30397, -- Commander Kolurg H
-- Utgarde Keep
23953, -- Prince Keleseth <The San'layn>
30748, -- Prince Keleseth <The San'layn> H
24200, -- Skarvald the Constructor
31679, -- Skarvald the Constructor H
24201, -- Dalronn the Controller
31656, -- Dalronn the Controller H
23954, -- Ingvar the Plunderer
31673, -- Ingvar the Plunderer H
-- Utgarde Pinnacle
26668, -- Svala Sorrowgrave
30810, -- Svala Sorrowgrave H
26687, -- Gortok Palehoof 
30774, -- Gortok Palehoof H
26693, -- Skadi the Ruthless
30807, -- Skadi the Ruthless H
26861, -- King Ymiron
30788, -- King Ymiron H
-- Gundrak
29304, -- Slad'ran <High Prophet of Sseratus>
31370, -- Slad'ran <High Prophet of Sseratus> H
29307, -- Drakkari Colossus
31365, -- Drakkari Colossus H
29573, -- Drakkari Elemental
31367, -- Drakkari Elemental H
29305, -- Moorabi <High Prophet of Mam'toth>
30530, -- Moorabi <High Prophet of Mam'toth> H
29306, -- Gal'darah <High Prophet of Akali>
31368, -- Gal'darah <High Prophet of Akali> H
29932, -- Eck the Ferocious H
-- Pit of Saron
36494, -- Forgemaster Garfrost
37613, -- Forgemaster Garfrost H
36476, -- Ick <Krick's Minion>
37627, -- Ick <Krick's Minion> H
36658, -- Scourgelord Tyrannus
36938, -- Scourgelord Tyrannus H
-- Drak'Tharon Keep
26630, -- Trollgore
31362, -- Trollgore H
26631, -- Novos the Summoner
31350, -- Novos the Summoner H
27483, -- King Dred
31349, -- King Dred H
26632, -- The Prophet Tharon'ja
31360, -- The Prophet Tharon'ja H
-- The Violet Hold
29315, -- Erekem
31507, -- Erekem H
29316, -- Moragg
31510, -- Moragg H
29313, -- Ichoron
31508, -- Ichoron H
29266, -- Xevozz
31511, -- Xevozz H
29312, -- Lavanthor
31509, -- Lavanthor H
29314, -- Zuramat the Obliterator
31512, -- Zuramat the Obliterator H
31134, -- Cyanigosa
31506, -- Cyanigosa H
-- Trial of the Crusader
34796, -- Gormok the Impaler
35438,
35439,
35440,
35144, -- Acidmaw
35511,
35512,
35513,
34799, -- Dreadscale
35514,
35515,
35516,
34797, -- Icehowl
35447,
35448,
35449,
34780, -- Lord Jaraxxus
35216,
35268,
35269,
34564, -- Anub'arak
34566,
35615,
35616,
34497, -- Fjola Lightbane (Twin Val'kyr)
35350,
35351,
35352,
34496, -- Eydis Darkbane(Twin Val'kyr)
35347,
35348,
35349);

-- Mechanic a todo inmune
-- http://www.trinitycore.info/Creature_template_tc2#type
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|8|0x00000040|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|4194304|8388608|33554432|536870912 WHERE `type` =9;
