-- Quest - Still At It
SET @ENTRY = 28566;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_tipsy_mcmanus' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100+0,@ENTRY*100+1,@ENTRY*100+2,@ENTRY*100+3,@ENTRY*100+4,@ENTRY*100+5,@ENTRY*100+6,@ENTRY*100+7,@ENTRY*100+8) AND `source_type`=9;
