UPDATE `creature_template` SET `exp`= 2 WHERE `entry` IN (36839, 36838); -- Alliance Gunship Cannon & Horde Gunship Cannon Fix Hp
DELETE FROM `spell_script_names` WHERE `spell_id` IN (70713, 68645,69471,69488);
UPDATE `item_template` SET ScriptName = '' WHERE entry = 49278;
UPDATE `gameobject_template` SET `ScriptName` = '' WHERE `entry` IN (201580, 201812);
UPDATE `creature_template` SET `ScriptName` = '' WHERE `entry` IN (37547,37032,37030,37003,36998);
DELETE FROM `creature` WHERE `id` IN (37003);
UPDATE `creature_template` SET `flags_extra` = 128 WHERE `entry` = 37547;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (71193,71195,69193);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` = 72959;
