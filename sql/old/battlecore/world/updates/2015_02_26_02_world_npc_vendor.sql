SET @ENTRY := 35826;
UPDATE `creature_template` SET `npcflag`=`npcflag`|128 WHERE `entry`=@ENTRY;

DELETE FROM `npc_vendor` WHERE `entry`=@ENTRY;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES
(@ENTRY,0,10609,1,1800,0),
(@ENTRY,1,16054,1,1800,0),
(@ENTRY,2,13311,1,1800,0);
