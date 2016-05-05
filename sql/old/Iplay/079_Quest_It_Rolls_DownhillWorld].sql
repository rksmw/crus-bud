-- Quest - It Rolls Downhill
UPDATE `creature_template` SET `spell4`=52245, `AIName`='SmartAI' WHERE entry=28750;
DELETE FROM `smart_scripts` WHERE `entryorguid`=28750 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(28750,0,0,0,25,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Blight Geist - Reset - Set phase 1'),
(28750,0,1,4,8,1,100,0,52245,0,0,0,69,1,0,0,0,0,0,20,190716,10,0,0,0,0,0,'Blight Geist - Spellhit - Move to closest Crystallized Blight'),
(28750,0,2,4,8,1,100,0,52245,0,0,0,69,1,0,0,0,0,0,20,190939,10,0,0,0,0,0,'Blight Geist - Spellhit - Move to closest Crystallized Blight'),
(28750,0,3,4,8,1,100,0,52245,0,0,0,69,1,0,0,0,0,0,20,190940,10,0,0,0,0,0,'Blight Geist - Spellhit - Move to closest Crystallized Blight'),
(28750,0,4,0,61,0,100,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Blight Geist - Link - Set phase 2'),
(28750,0,5,6,34,0,100,0,0,1,0,0,11,52248,2,0,0,0,0,23,0,0,0,0,0,0,0,'Blight Geist - Movementinform - Give credit'),
(28750,0,6,7,61,0,100,0,0,1,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Blight Geist - Movementinform - Despawn'),
(28750,0,7,0,61,0,100,0,0,1,0,0,5,35,0,0,0,0,0,1,0,0,0,0,0,0,0,'Blight Geist - Movementinform - Play emote');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=28750 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(22,2,28750,0,30,1,190716,10,0,0,0,'','Blight Geist - Activate SAI if Crystallized Blight Near'),
(22,3,28750,0,30,1,190716,10,0,1,0,'','Blight Geist - Activate SAI if not Crystallized Blight Near'),
(22,3,28750,0,30,1,190939,10,0,0,0,'','Blight Geist - Activate SAI if Crystallized Blight Near'),
(22,4,28750,0,30,1,190716,10,0,1,0,'','Blight Geist - Activate SAI if not Crystallized Blight Near'),
(22,4,28750,0,30,1,190939,10,0,1,0,'','Blight Geist - Activate SAI if not Crystallized Blight Near'),
(22,4,28750,0,30,1,190940,10,0,0,0,'','Blight Geist - Activate SAI if Crystallized Blight Near');
