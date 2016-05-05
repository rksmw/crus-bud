-- Quest - The Broken Front
SET @ENTRY := 31273;
SET @GOSSIP := 56059;
UPDATE `creature_template` SET `AIName`= 'SmartAI',`ScriptName`='',`gossip_menu_id`=@GOSSIP WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,25,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Dying Berserker - Reset - React Passive'),
(@ENTRY,0,1,0,62,0,100,0,@GOSSIP,0,0,0,11,58922,2,0,0,0,0,7,0,0,0,0,0,0,0,'Dying Berserker - On Gossip Option Select - Cast Horde Quest Aura on player');

DELETE FROM `gossip_menu` WHERE `entry` IN (@GOSSIP,@GOSSIP+1);
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(@GOSSIP,13930),
(@GOSSIP,13935),
(@GOSSIP+1,13931);

DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `box_coded`, `box_money`, `box_text`) VALUES
(@GOSSIP,0,0,'Hold on friend. Tell me what happened here.',1,1,@GOSSIP+1,0,0,0,'');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,13935,0,28,13228,0,0,0,0,'','Only show gossip text 13932 if player has quest 13228 Complete'),
(14,@GOSSIP,13935,0,14,13230,0,0,0,0,'','Only show gossip text 13932 if player has quest 13230 Not Taken'),
(14,@GOSSIP,13935,1,8,13228,0,0,0,0,'','Only show gossip text 13932 if player has quest 13228 Rewarded'),
(14,@GOSSIP,13935,1,14,13230,0,0,0,0,'','Only show gossip text 13932 if player has quest 13230 Not Taken');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,@GOSSIP,0,0,9,13228,0,0,0,0,'','Only show gossip option 0 if player has quest 13228 active');
