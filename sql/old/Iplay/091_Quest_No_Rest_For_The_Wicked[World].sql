-- "No Rest For the Wicked" 
-- H:13367/13368 - daily, A:13346/13350 - daily
SET @SummonBunny := 32347;
SET @Alumeth     := 32300;
SET @Trigger     := 60831; -- Spell Alumeth's Remains that can hit only summoning bunny to trigger it
SET @Equip       := 30999;
SET @Spell2      := 60834;
UPDATE `creature_template` SET `AIName`='SmartAI',`unit_flags`=4,`flags_extra`=128 WHERE `entry`=@SummonBunny;
UPDATE `creature_template` SET `AIName`='SmartAI',`faction_A`=21,`faction_H`=21  WHERE `entry`=@Alumeth; -- faction from sniffs
UPDATE `creature` SET `spawndist`= 0,`MovementType`= 0 WHERE `guid`=122317; -- Summon Bunny should stay at spawn point

DELETE FROM `creature_equip_template` WHERE `entry`=@Equip;
INSERT INTO `creature_equip_template` VALUES (@Equip,1,13524,0,0);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@SummonBunny,@Alumeth) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@SummonBunny*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@SummonBunny,0,0,0,8,0,100,0,@Trigger,0,5000,5000,80,@SummonBunny*100,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Alumeth Summon Bunny - On Spellhit - Trigger Timed Event'),
(@SummonBunny*100,9,0,0,1,0,100,0,3000,3000,0,0,12,@Alumeth,2,150000,0,1,0,8,0,0,0,8219.157,2187.093,499.8201,3.106686,'Alumeth Summon Bunny - On Spellhit - Summon Alumeth the Ascended'),
(@SummonBunny*100,9,1,0,1,0,100,0,0,0,0,0,85,@Spell2,1,0,0,0,0,7,0,0,0,0,0,0,0,'Cast spell 60834'),
(@Alumeth,0,0,0,0,0,100,0,8000,9000,8000,9000,11,60472,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Alumeth - IC - Cast Mindflay'),
(@Alumeth,0,1,0,0,0,100,0,8000,10000,8000,10000,11,34322,1,0,0,0,0,2,0,0,0,0,0,0,0, 'Alumeth - IC - Cast Psychicscream'),
(@Alumeth,0,2,0,0,0,100,0,9000,12000,9000,12000,11,37978,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Alumeth - IC - Cast Renew'),
(@Alumeth,0,3,0,0,0,100,0,7000,10000,7000,10000,11,34942,1,0,0,0,0,2,0,0,0,0,0,0,0, 'Alumeth - IC - Cast Shadow Word: Pain');
-- Fix Alumeth Soulstone GO spell focus data range
UPDATE `gameobject_template` SET `data1`=25 WHERE `entry`=300241; -- This GO isn't sniffed and is temp for that reason
-- Add conditions for spell trigger to summon boss
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (@Trigger,@Spell2);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES 
(13,1,@Trigger,0,0,31,0,3,@SummonBunny,0,0,0,'', 'Alumeth''s Remains can hit only summoning bunny'),
(13,1,@Trigger,0,0,29,1,@Alumeth,40,0,1,0,'', 'Alumeth''s Remains can be used only, if he is not near caster in 40 yards'),
(13,1,@Spell2,0,0,33,0,0,0,0,0,0,'', 'Spell 60834 - Implicit target - Self');
