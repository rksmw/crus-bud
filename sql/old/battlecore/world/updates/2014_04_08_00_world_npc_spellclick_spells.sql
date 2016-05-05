-- 12270 Shred the Alliance : 12244 Shredder Repair
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`='27354' AND `spell_id`='48533';
INSERT INTO `npc_spellclick_spells`(`npc_entry`,`spell_id`,`cast_flags`,`user_type`) VALUES 
('27354','48533','1','0');

UPDATE creature  SET `spawntimesecs`='100' WHERE id='27354';

UPDATE `creature_template` SET `spell1`='48558',`spell2`='48604',`spell3`='48548',`spell4`='48610' WHERE `entry`='27354';

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=48610;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES 
('17','0','48610','0','0','29','0','27423','5','0','0','0','','Cast Shredder Delivery 48610 - near Grekk 27423'),
('17','0','48610','0','1','29','0','27371','5','0','0','0','','Cast Shredder Delivery 48610 - near Synipus 27371');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`='48610' AND `spell_effect`='-48533';
INSERT INTO `spell_linked_spell`(`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES 
('48610','-48533','0','Unmount when Shredder Delivery');

DELETE FROM `spell_scripts` WHERE `id`='48610' AND `command`='18';
INSERT INTO `spell_scripts`(`id`,`effIndex`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES 
('48610','0','0','18','3','0','0','0','0','0','0');
