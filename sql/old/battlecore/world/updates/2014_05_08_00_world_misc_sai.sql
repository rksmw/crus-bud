-- Quest - The Way to His Heart...
SET @BULL	:= 24786;
SET @COW	:= 24797;
SET @GO		:= 186949;
UPDATE `gameobject_template` SET `data5`=1 WHERE `entry`=@GO;
UPDATE `gameobject` SET `spawntimesecs`=120 WHERE `id`=@GO;

DELETE FROM `spell_script_names` WHERE `spell_id`=21014;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(21014,'spell_item_anuniaq_net');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (@BULL,@COW);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@BULL,@COW) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@BULL,0,0,1,8,0,100,0,44454,0,0,0,69,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Reef Bull - Spellhit - Move to invoker position'),
(@BULL,0,1,0,61,0,100,1,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Reef Bull - Spellhit - Store target'),
(@BULL,0,2,3,10,0,100,1,1,5,0,0,11,52148,2,0,0,0,0,1,0,0,0,0,0,0,0,'Reef Bull - Move in LOS - Cast Cosmetic Love (see conditions)'),
(@BULL,0,3,4,61,0,100,1,0,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Reef Bull - Move in LOS - Face Invoker'),
(@BULL,0,4,5,61,0,100,1,0,0,0,0,45,0,1,0,0,0,0,7,0,0,0,0,0,0,0,'Reef Bull - Move in LOS - Set data Invoker'),
(@BULL,0,5,6,61,0,100,1,0,0,0,0,86,44463,2,12,1,0,0,12,1,0,0,0,0,0,0,'Reef Bull - Move in LOS - Complete quest to stored'),
(@BULL,0,6,7,61,0,100,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Reef Bull - Move in LOS - Say text'),
(@BULL,0,7,0,61,0,100,1,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Reef Bull - Move in LOS - Despawn in 5 seconds'),
(@COW,0,0,1,38,0,100,1,0,1,0,0,66,0,0,0,0,0,0,19,@BULL,20,0,0,0,0,0,'Reef Cow - Data set - Face Reef Bull'),
(@COW,0,1,2,61,0,100,1,0,0,0,0,11,52148,2,0,0,0,0,1,0,0,0,0,0,0,0,'Reef Cow - Data set - Cast Cosmetic Love'),
(@COW,0,2,0,61,0,100,1,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Reef Cow - Data set - Despawn in 5 seconds');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=@BULL AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,3,@BULL,0,0,31,0,3,@COW,0,0,0,'','SAI - Reef Bull complete quest invoker must be Reef Cow');

DELETE FROM `creature_text` WHERE `entry`=@BULL;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@BULL,0,0,"The reef cow and her new bull find true love.",16,0,100,0,0,0,'Reef Bull');
