-- Quest - Second Chances
SET @ARETE              := 29560; -- LC Arete
SET @LANDGREN           := 29542; -- Landgren
SET @LANDGRENS_SOUL     := 29572; -- Landgren's Soul
SET @CORPSE_SFOCUS      := 22965;  -- Spell focus for the corpse
SET @SOUL_COAX          := 22966;  -- Soul Coax Spell
SET @SUMMON_GATE        := 26560; -- Summon Arete Gateway spell
SET @ARETE_GATE         := 191579; -- Arete Gateway Object
SET @LANDGREN_CORPSE    := 191578; -- Landgrens Corpse Object

UPDATE `gameobject_template` SET `faction`=114, `AIName`='SmartGameObjectAI' WHERE `entry`=@ARETE_GATE;
DELETE FROM `gameobject` WHERE `id`=300226;
DELETE FROM `gameobject_template` WHERE `entry`=@LANDGREN_CORPSE;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`data0`,`data1`,`data6`) VALUES
(@LANDGREN_CORPSE,8,0,'Archbishop Landgren''s Corpse',1566,20,0);

UPDATE `creature_template` SET `npcflag`=2, `unit_flags`=33280, `ScriptName`='npc_lord_commander_arete' WHERE `entry`=@ARETE;
UPDATE `creature_template` SET `faction_A`=14, `faction_H`=14, `speed_walk`=0.4, `unit_flags`=256, `dynamicflags`=32, `InhabitType`=4 WHERE `entry`=@LANDGRENS_SOUL;
UPDATE `creature_template` SET AIName='SmartAI' WHERE `entry`=@LANDGREN;

UPDATE `creature_model_info` SET `bounding_radius`=0.5745, `combat_reach`=2.25 WHERE `modelid`=26197;
UPDATE `creature_model_info` SET `bounding_radius`=0.3825, `combat_reach`=1.875 WHERE `modelid`=26346;

DELETE FROM `creature_text` WHERE `entry` IN (@ARETE,@LANDGRENS_SOUL);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ARETE,0,0,'Well done. Let''s get this over with.',12,0,100,1,0,0,''),
(@ARETE,1,0,'Come, Landgren, cough up your soul so that I can ask you a very important question.',12,0,100,0,0,0,''),
(@ARETE,2,0,'YOU WILL TELL ME WHERE WESTWIND IS OR I WILL DESTROY YOUR SOUL!',14,0,100,25,0,0,''),
(@ARETE,3,0,'Then you leave me no choice. I won''t say that I won''t enjoy this.',12,0,100,1,0,0,''),
(@ARETE,4,0,'Very well. Tell me!',12,0,100,0,0,0,''),
(@ARETE,5,0,'A hidden hollow? How very interesting. You''ve served your purpose, Landgren, but I''m afraid there''ll be no resurrection for you this time!',12,0,100,6,0,0,''),
(@ARETE,6,0,'Now that the unpleasantness is finished with, let''s talk about you dealing with Grand Admiral Westwind.',12,0,100,11,0,0,''),
(@LANDGRENS_SOUL,0,0,'You''ll get nothing out of me, monster. I am beyond your ability to influence.',12,0,100,0,0,0,''),
(@LANDGRENS_SOUL,1,0,'No.',12,0,100,0,0,0,''),
(@LANDGRENS_SOUL,2,0,'STOP! It isn''t worth it. I''ll tell you where he is.',12,0,100,0,0,0,''),
(@LANDGRENS_SOUL,3,0,'On the south end of the island is a cave -- a hidden hollow. The grand admiral has holed himself up in there, preparing for the final battle against the Lich King.',12,0,100,0,0,0,''),
(@LANDGRENS_SOUL,4,0,'AAAEEEEIIIiiiiiiiiiiiiiiiiiiiiiiiiiiii........................................',14,0,100,0,0,0,'');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (@SOUL_COAX,@SUMMON_GATE);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,@SOUL_COAX,0,0,31,0,3,@LANDGREN,0,0,0,'','Spell Soul Coax targets Archbishop Landgren'),
(13,2,@SUMMON_GATE,0,0,31,0,3,@LANDGREN,0,0,0,'','Spell Summon Arete''s Gate effect1 targets Archbishop Landgren');

DELETE FROM `smart_scripts` WHERE `entryorguid`=@LANDGREN AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ARETE_GATE AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@LANDGREN,0,1,0,6,0,100,1,0,1,0,0,11,@CORPSE_SFOCUS,2,0,0,0,0,1,0,0,0,0,0,0,0,'Archbishop Landgren - On death - Spellcast Summon Archbishop Landgren''s Corpse Spell Focus'),
(@ARETE_GATE,1,0,0,60,0,100,1,4000,4000,0,0,12,@ARETE,7,0,0,0,0,1,0,0,0,0,0,0,0,'Arete''s Gateway - On Data Set - Start Action Script');
