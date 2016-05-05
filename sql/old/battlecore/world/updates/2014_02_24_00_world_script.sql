-- Boss Scripts
UPDATE `creature_template` SET `ScriptName`='npc_apothecary_baxter' WHERE `entry`=36565;
UPDATE `creature_template` SET `ScriptName`='npc_apothecary_hummel' WHERE `entry`=36296;
UPDATE `creature_template` SET `ScriptName`='npc_apothecary_frye' WHERE `entry`=36272;
UPDATE `creature_template` SET `ScriptName`='npc_crazed_apothecary' WHERE `entry`=36568;

-- Creature Text
SET @HUMMEL  := 36296;
SET @FRYE    := 36272;
SET @BAXTER  := 36565;
DELETE FROM `creature_text` WHERE `entry` IN (@HUMMEL,@FRYE,@BAXTER);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(@HUMMEL,0,0,'Did they bother to tell you who I am and why I am doing this?',12,0,100,0,0,0,'Apothecary Hummel - SAY_AGGRO_1'),
(@HUMMEL,1,0,'...or are they just using you like they do everybody else?',12,0,100,0,0,0,'Apothecary Hummel - SAY_AGGRO_2'),
(@HUMMEL,2,0,'But what does it matter. It is time for this to end.',12,0,100,0,0,0,'Apothecary Hummel - SAY_AGGRO_3'),
(@HUMMEL,3,0,'Baxter! Get in there and help! NOW!',12,0,100,0,0,0,'Apothecary Hummel - SAY_CALL_BAXTER'),
(@HUMMEL,4,0,'It is time, Frye! Attack!',12,0,100,0,0,0,'Apothecary Hummel - SAY_CALL_FRYE'),
(@HUMMEL,5,0,'Apothecaries! Give your life for the Crown!',12,0,100,0,0,0,'Apothecary Hummel - SAY_SUMMON_ADDS'),
(@HUMMEL,6,0,'...please don''t think less of me.',12,0,100,0,0,0,'Apothecary Hummel - SAY_DEATH'),
(@FRYE,0,0,'Great. We''re not gutless, we''re incompetent.',12,0,100,0,0,0,'Apothecary Frye - SAY_DEATH'),
(@BAXTER,0,0,'It has been the greatest honor of my life to serve with you, Hummel.',12,0,100,0,0,0,'Apothecary Baxter - SAY_DEATH');

-- Spell Scripts
DELETE FROM `spell_script_names` WHERE `spell_id` IN (68798,68614);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(68798,'spell_trio_alluring_perfume'),
(68614,'spell_trio_irresistible_cologne');

-- Only one Immunity can be present on player at the time
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (68530,68529);
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(68530,-68529,0,'Remove Perfume Immune when Cologne Immune is applied'),
(68529,-68530,0,'Remove Cologne Immune when Perfume Immune is applied');

-- Loot Template
DELETE FROM `creature_loot_template` WHERE `entry`=36296 AND `item` IN (49715,50250,50471,50446,50741);
-- Insert items into Heart-Shaped Box
SET @BOX := 54537; -- Heart-Shaped Box
DELETE FROM `item_loot_template` WHERE `entry`=@BOX;
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(@BOX,50250,2,1,0,1,1), -- Big Love Rocket
(@BOX,50446,2,1,0,1,1), -- Toxic Wasteling
(@BOX,50471,5,1,0,1,1), -- The Heartbreaker
(@BOX,50741,5,1,0,1,1), -- Vile Fumigator's Mask
(@BOX,49715,5,1,0,1,1), -- Forever-Lovely Rose
(@BOX,49426,100,1,1,2,2); -- 1-2 Emblems of Frost
