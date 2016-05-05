-- Quest - The Last of Her Kind
UPDATE `creature` SET `phaseMask`=1 WHERE `id`=29563;
DELETE FROM `spell_area` WHERE `spell`=55857;
UPDATE `smart_scripts` SET `target_type`=23 WHERE `entryorguid`=30468 AND `source_type`=0 AND `id`=2;
