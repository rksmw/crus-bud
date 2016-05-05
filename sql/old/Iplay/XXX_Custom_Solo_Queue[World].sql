-- Solo Queue NPC
SET @CUSTOM := 5000000;
DELETE FROM `creature_template` WHERE (`entry`=@CUSTOM+17);
INSERT INTO `creature_template` (`entry`,`modelid1`,`name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `unit_flags`, `npcflag`, `type_flags`, `speed_walk`, `speed_run`, `scale`, `flags_extra` ,`ScriptName`) VALUES
(@CUSTOM+17,9069,'Solo Queue Master', 'Required 5v5 Team', 'Speak',50002,80, 80, 2, 35, 35, 2, 3,138936390, 1, 1.14286, 1,1,'npc_solo_queue');


REPLACE INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) 
VALUES (873, '|cffff0000[Arena Queue]:|r %s -- Joined Solo Queue: %s|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- 5000017