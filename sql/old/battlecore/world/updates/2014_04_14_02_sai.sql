-- Fix Quest Whispers of the Raven God
SET @NPC_1		:= 19988;
SET @NPC_2		:= 19989;
SET @NPC_3		:= 19990;
SET @NPC_4		:= 20329;
SET @SPELL		:= 37642;
SET @GO_1		:= 184950;
SET @GO_2		:= 184967;
SET @GO_3		:= 184968;
SET @GO_4		:= 184969;
SET @KILL_1		:= 22798;
SET @KILL_2		:= 22799;
SET @KILL_3		:= 22800;
SET @KILL_4		:= 22801;
SET @VOICE		:= 21851;

DELETE FROM `creature_text` WHERE `entry` =@VOICE;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@VOICE,0,0,'From the darkest night shall rise again the raven, shall take flight in the shadows, shall reveal the nature of its kind. Prepare yourself for its coming, for the faithful shall be elevated to take flight with the raven, the rest be forgotten to walk upon the ground, clipped wings and shame.',15,0,100,1,0,0,'The Voice of the Raven God - first prophecy'),
(@VOICE,1,0,'Steel your minds and guard your thoughts. The dark wings will cloud and consume the minds of the weak, a flock of thralls whose feet may never leave the ground.',15,0,100,1,0,0,'The Voice of the Raven God - 2nd prophecy'),
(@VOICE,2,0,'The old blood will flow once again with the coming of the raven, the return of the darkness in the skies. Scarlet night, and the rise of the old.',15,0,100,1,0,0,'The Voice of the Raven God - 3rd prophecy'),
(@VOICE,3,0,'The raven was struck down once for flying too high, unready. The aeons have prepared the Dark Watcher for its ascent, to draw the dark cloak across the horizon.',15,0,100,1,0,0,'The Voice of the Raven God - 4th prophecy');

DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry IN (@GO_1, @GO_2, @GO_3, @GO_4);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, @GO_1, 1, 0, 1, 0, @SPELL, 0, 0, 0, 0, 'q10607 - smart_scripts if player has aura 37466'),
(22, 1, @GO_2, 1, 0, 1, 0, @SPELL, 0, 0, 0, 0, 'q10607 - smart_scripts if player has aura 37466'),
(22, 1, @GO_3, 1, 0, 1, 0, @SPELL, 0, 0, 0, 0, 'q10607 - smart_scripts if player has aura 37466'),
(22, 1, @GO_4, 1, 0, 1, 0, @SPELL, 0, 0, 0, 0, 'q10607 - smart_scripts if player has aura 37466');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@NPC_1, @NPC_2, @NPC_3, @NPC_4);
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (@NPC_1, @NPC_2, @NPC_3, @NPC_4);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@NPC_1, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 85, @SPELL, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0,'Grishna - On Death - Cast Understanding Ravenspeech - q10607'),
(@NPC_2, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 85, @SPELL, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0,'Grishna - On Death - Cast Understanding Ravenspeech - q10607'),
(@NPC_3, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 85, @SPELL, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0,'Grishna - On Death - Cast Understanding Ravenspeech - q10607'),
(@NPC_4, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 85, @SPELL, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0,'Grishna - On Death - Cast Understanding Ravenspeech - q10607');


UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry` IN (@GO_1, @GO_2, @GO_3, @GO_4);
DELETE FROM `smart_scripts` WHERE `source_type`=1 AND `entryorguid` IN (@GO_1, @GO_2, @GO_3, @GO_4);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@GO_1, 1, 0, 0, 70, 0, 100, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 9, @VOICE, 0, 30, 0, 0, 0, 0,'Grishna - On gossip hello - Read the first prophecy - q10607'),
(@GO_1, 1, 1, 0, 70, 0, 100, 0, 2, 0, 0, 0, 33, @KILL_1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0,'Grishna - On gossip hello - Call creature killed the first prophecy - q10607'),
(@GO_2, 1, 0, 0, 70, 0, 100, 0, 2, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 9, @VOICE, 0, 30, 0, 0, 0, 0,'Grishna - On gossip hello - Read the second prophecy - q10607'),
(@GO_2, 1, 1, 0, 70, 0, 100, 0, 2, 0, 0, 0, 33, @KILL_2, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0,'Grishna - On gossip hello - Call creature killed the 2nd prophecy - q10607'),
(@GO_3, 1, 0, 0, 70, 0, 100, 0, 2, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 9, @VOICE, 0, 30, 0, 0, 0, 0,'Grishna - On gossip hello - Read the third prophecy - q10607'),
(@GO_3, 1, 1, 0, 70, 0, 100, 0, 2, 0, 0, 0, 33, @KILL_3, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0,'Grishna - On gossip hello - Call creature killed the 3rd prophecy - q10607'),
(@GO_4, 1, 0, 0, 70, 0, 100, 0, 2, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 9, @VOICE, 0, 30, 0, 0, 0, 0,'Grishna - On gossip hello - Read the fourth prophecy - q10607'),
(@GO_4, 1, 1, 0, 70, 0, 100, 0, 2, 0, 0, 0, 33, @KILL_4, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0,'Grishna - On gossip hello - Call creature killed the 4th prophecy - q10607');
