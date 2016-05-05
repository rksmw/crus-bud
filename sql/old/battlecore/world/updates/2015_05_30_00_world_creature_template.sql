UPDATE `creature_template` SET `ScriptName`='npc_mob_land_mine_bunny' WHERE `entry` = '29397'; 
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` = 5258 AND `type`= 11;
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(5258,11,0,0, 'achievement_mine_sweeper');
