UPDATE `creature_template` SET `ScriptName` = 'npc_ruby_keeper' WHERE `entry` IN (27530);
UPDATE `creature` SET `spawntimesecs` = '30' WHERE `guid` IN ('108202','108203','108311','108312','108315','108316','108317','108318','108328','108329','108330');
UPDATE `creature` SET `position_x` = '3616.21',`position_y` = '971.35', `position_z` = '57.7282' WHERE `guid` IN(108329);
UPDATE `creature` SET `position_x` = '3714.15',`position_y` = '1035.49', `position_z` = '57.4093' WHERE `guid` IN(108203);
UPDATE `creature` SET `position_x` = '3677.64',`position_y` = '922.17', `position_z` = '56.5227' WHERE `guid` IN(108330);