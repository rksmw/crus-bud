-- Quest 13069 Shoot 'Em Up
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`='30330';
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`='30332';

DELETE FROM `smart_scripts` WHERE `entryorguid`='30330' AND `source_type`='0' AND `event_type`=8 AND `event_param1`='56578';
DELETE FROM `smart_scripts` WHERE `entryorguid`='30332' AND `source_type`='0' AND `event_type`=8 AND `event_param1`='56578';
INSERT INTO `smart_scripts`(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)VALUES
('30330','0','0','1','8','0','100','0','56578','0','0','0','33','30330','0','0','0','0','0','7','0','0','0','0','0','0','0','Jotunheim Proto-Drake - On spellhit - call KC'),
('30330','0','1','2','8','0','100','0','56578','0','0','0','37','0','0','0','0','0','0','1','0','0','0','0','0','0','0','Jotunheim Proto-Drake - On spellhit - Die'),
('30330','0','2','0','8','0','100','0','56578','0','0','0','41','5000','0','0','0','0','0','1','0','0','0','0','0','0','0','Jotunheim Proto-Drake - On spellhit - Despawn'),
('30332','0','0','0','8','0','100','0','56578','0','0','0','41','0','0','0','0','0','0','1','0','0','0','0','0','0','0','Jotunheim Proto-Drake Rider - On spellhit - Despawn');
