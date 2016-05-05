SET @ENTRY :=5000000;
UPDATE `gameobject_template` SET `ScriptName` = 'battleground_fast_arena_crystal' WHERE `entry` = @ENTRY+6;
