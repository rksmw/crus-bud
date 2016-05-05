-- Quest - Riding the Red Rocket
SET @ROCKET := 27593;
SET @BOAT_A := 27688;
SET @BOAT_H := 27702;
SET @BUNNY  := 27689;
UPDATE `creature_template` SET `VehicleId`=43, `ScriptName`='npc_rocket_propelled_warhead' WHERE `entry`=@ROCKET;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@BOAT_A,@BOAT_H,@BUNNY);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@BOAT_A,@BOAT_H,@BUNNY) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@BOAT_A,0,0,1,10,0,100,0,1,5,1000,1000,85,49340,2,0,0,0,0,0,0,0,0,0,0,0,0,'Alliance Lumberboat - Move in LoS - Invoker cast Horde Kill Credit Torpedo (see conditions)'),
(@BOAT_A,0,1,2,61,0,100,0,0,0,0,0,11,49257,2,0,0,0,0,7,0,0,0,0,0,0,0,'Alliance Lumberboat - Move in LoS - Cast Alliance Boat to torpedo'),
(@BOAT_A,0,2,0,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,9,@BUNNY,0,50,0,0,0,0,'Alliance Lumberboat - Move in LoS - Set data Lumberboat explosions'),
(@BOAT_H,0,0,1,10,0,100,0,1,5,1000,1000,85,49510,2,0,0,0,0,0,0,0,0,0,0,0,0,'Horde Lumberboat - Move in LoS - Invoker cast Alliance Kill Credit Torpedo (see conditions)'),
(@BOAT_H,0,1,2,61,0,100,0,0,0,0,0,11,49372,2,0,0,0,0,7,0,0,0,0,0,0,0,'Horde Lumberboat - Move in LoS - Cast Horde Boat to torpedo'),
(@BOAT_H,0,2,0,61,0,100,0,0,0,0,0,45,0,1,0,0,0,0,9,@BUNNY,0,50,0,0,0,0,'Horde Lumberboat - Move in LoS - Set data Lumberboat explosions'),
(@BUNNY,0,0,0,25,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Alliance Lumberboat Explosions - Reset - Set phase 1'),
(@BUNNY,0,1,0,38,0,100,0,0,1,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Alliance Lumberboat Explosions - Data set - Set phase 2'),
(@BUNNY,0,2,0,1,2,100,1,0,1500,0,0,11,67302,2,0,0,0,0,1,0,0,0,0,0,0,0,'Alliance Lumberboat Explosions - Update OOC - Cast Boat Fire'),
(@BUNNY,0,3,4,1,2,100,1,30000,30000,0,0,28,67302,0,0,0,0,0,1,0,0,0,0,0,0,0,'Alliance Lumberboat Explosions - Update OOC - Remove Boat Fire aura'),
(@BUNNY,0,4,0,61,0,100,0,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Alliance Lumberboat Explosions - Update OOC - Reset');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry` IN (@BOAT_A,@BOAT_H) AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,1,@BOAT_A,0,0,31,0,3,@ROCKET,0,0,0,'','Alliance Lumberboat - Invoker should be Rocket Proppelled Warhead'),
(22,1,@BOAT_H,0,0,31,0,3,@ROCKET,0,0,0,'','Horde Lumberboat - Invoker should be Rocket Proppelled Warhead');
