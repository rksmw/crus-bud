-- Quest - Decoy!
SET @GO := 600000;
UPDATE `creature_template` SET `baseattacktime`=2000 WHERE `entry`=15554;
DELETE FROM `gameobject_template` WHERE `entry`=@GO;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `AIName`, `ScriptName`, `WDBVerified`) VALUES
(@GO,8,299,'TEMP Drop-Off Point','','','',0,0,1,0,0,0,0,0,0,1348,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',-1);

DELETE FROM `gameobject` WHERE `id`=@GO;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(NULL,@GO,1,1,1,5086.19,-5116.32,931.162,4.78877,0,0,0.679593,-0.733589,-150,0,1);
