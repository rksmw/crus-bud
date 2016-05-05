-- Quest - Destroy the Forges!
SET @NORTH := 30209;
SET @CENTRAL := 30211;
SET @SOUTH := 30212;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@NORTH,@CENTRAL,@SOUTH);
UPDATE `creature` SET `spawndist`=0 WHERE `MovementType`=0 IN (@NORTH,@CENTRAL,@SOUTH);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@NORTH,@CENTRAL,@SOUTH) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@NORTH,0,0,1,8,0,100,0,56275,0,0,0,33,@NORTH,0,0,0,0,0,7,0,0,0,0,0,0,0, 'North Lightning Forge - On spell hit - Give credit'),
(@NORTH,0,1,0,61,0,100,0,0,0,0,0,11,64079,2,0,0,0,0,1,0,0,0,0,0,0,0, 'North Lightning Forge - On spell hit - Cast cosmetic explosion'),
(@CENTRAL,0,0,1,8,0,100,0,56275,0,0,0,33,@CENTRAL,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Central Lightning Forge - On spell hit - Give credit'),
(@CENTRAL,0,1,0,61,0,100,0,0,0,0,0,11,64079,2,0,0,0,0,1,0,0,0,0,0,0,0, 'Central Lightning Forge - On spell hit - Cast cosmetic explosion'),
(@SOUTH,0,0,1,8,0,100,0,56275,0,0,0,33,@SOUTH,0,0,0,0,0,7,0,0,0,0,0,0,0, 'South Lightning Forge - On spell hit - Give credit'),
(@SOUTH,0,1,0,61,0,100,0,0,0,0,0,11,64079,2,0,0,0,0,1,0,0,0,0,0,0,0, 'South Lightning Forge - On spell hit - Cast cosmetic explosion');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=56275;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=56275;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,56275,0,0,31,0,3,@NORTH,0,0,0,'',"Bouldercrag Bomb - Implicit target - North Lightning Forge"),
(13,1,56275,0,1,31,0,3,@CENTRAL,0,0,0,'',"Bouldercrag Bomb - Implicit target - Central Lightning Forge"),
(13,1,56275,0,2,31,0,3,@SOUTH,0,0,0,'',"Bouldercrag Bomb - Implicit target - South Lightning Forge"),
(17,0,56275,0,0,29,0,@NORTH,10,0,0,0,'',"Bouldercrag Bomb can only be casted near North Lightning Forge"),
(17,0,56275,0,1,29,0,@CENTRAL,10,0,0,0,'',"Bouldercrag Bomb can only be casted near Central Lightning Forge"),
(17,0,56275,0,2,29,0,@SOUTH,10,0,0,0,'',"Bouldercrag Bomb can only be casted near South Lightning Forge");
