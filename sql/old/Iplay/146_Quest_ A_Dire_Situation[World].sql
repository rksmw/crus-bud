-- Quest 10506: A Dire Situation
SET @npc:= 20058;
SET @aura:=36310;
SET @KILL:=21176;

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@npc;
DELETE FROM creature_ai_scripts WHERE creature_id=@npc;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` =@npc;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@NPC, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 18950, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'Bloodmaul Dire Wolf - Invisibility and Stealth Detection'),
(@NPC, 0, 1, 0, 8, 0, 100, 1, @aura, 0, 0, 0, 33, @KILL, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0,'Bloodmaul Dire Wolf - With aura 36310 - Cast Understanding Ravenspeech - q10607');
