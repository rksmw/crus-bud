-- Precious: Plagued Zombies script name
UPDATE `creature_template` SET `ScriptName` = 'npc_plagued_zombie' WHERE `entry` = 38104;

-- Plagued Zombies: movement speed
UPDATE `creature_template` SET `speed_run` = 0.54286 WHERE `entry` IN (38104, 38105);

-- Rotface: Delete extra stalkers
DELETE FROM `creature` WHERE `guid` IN (201388, 201445, 201492, 201018);

-- Rotface: Condition to prevent a Stalker to use Ooze Flood over himself (creating the puddle in the air)
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,3,69783,0,0,35,0,1,3,1,0,0,'','Puddle Stalker - stream caster - not target for Puddle'),
(13,3,69797,0,0,35,0,1,3,1,0,0,'','Puddle Stalker - stream caster - not target for Puddle'),
(13,3,69799,0,0,35,0,1,3,1,0,0,'','Puddle Stalker - stream caster - not target for Puddle'),
(13,3,69802,0,0,35,0,1,3,1,0,0,'','Puddle Stalker - stream caster - not target for Puddle');

-- Rotface: Define a better visual position for "strams" stalkers
UPDATE `creature` SET `position_x` = 4424.16, `position_y` = 3095.29, `position_z` = 369.170, `orientation` = 0.99349 WHERE `guid` = 200922;
UPDATE `creature` SET `position_x` = 4403.96, `position_y` = 3115.36, `position_z` = 369.494, `orientation` = 0.63452 WHERE `guid` = 201441;
UPDATE `creature` SET `position_x` = 4404.45, `position_y` = 3158.61, `position_z` = 369.015, `orientation` = 5.75180 WHERE `guid` = 201648;
UPDATE `creature` SET `position_x` = 4424.35, `position_y` = 3178.94, `position_z` = 368.875, `orientation` = 5.47273 WHERE `guid` = 201600;
UPDATE `creature` SET `position_x` = 4467.70, `position_y` = 3178.48, `position_z` = 369.070, `orientation` = 4.08260 WHERE `guid` = 201494;
UPDATE `creature` SET `position_x` = 4487.84, `position_y` = 3158.91, `position_z` = 369.055, `orientation` = 3.89411 WHERE `guid` = 201651;
UPDATE `creature` SET `position_x` = 4487.33, `position_y` = 3115.23, `position_z` = 369.128, `orientation` = 2.56365 WHERE `guid` = 201332;
UPDATE `creature` SET `position_x` = 4467.75, `position_y` = 3095.20, `position_z` = 369.725, `orientation` = 2.25960 WHERE `guid` = 201602;
