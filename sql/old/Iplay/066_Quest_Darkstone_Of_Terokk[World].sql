-- Veil Skith: Darkstone of Terokk (10839)
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`='38736' AND `spell_effect`='38729'; 
INSERT INTO `spell_linked_spell`(`spell_trigger`,`spell_effect`,`type`,`comment`)VALUES
('38736','38729','0','');
 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`='17' AND `SourceEntry`='38736';
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES 
( '17','0','38736','0','0','30','0','185191','5','0','0','0','','');
