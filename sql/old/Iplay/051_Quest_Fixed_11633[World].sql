UPDATE `creature_template` SET `flags_extra`='128',`scriptname` ='npc_killcredit_templeA',`ainame`='' WHERE `entry` IN (25471);
DELETE FROM `creature` WHERE `id` IN (25471); 
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
('25471','571','1','1','0','0','4110.83','3734.49','91.7654','0.386984','300','0','0','8982','3155','0','0','0','0');
UPDATE `creature_template` SET `scriptname` ='npc_killcredit_templeB',`ainame`='' WHERE `entry` IN (25472);
UPDATE `creature_template` SET `scriptname` ='npc_killcredit_templeC',`ainame`='' WHERE `entry` IN (25473);
