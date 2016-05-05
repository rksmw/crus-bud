-- Midsummer Reveler - 3 pieces bonus: Infused with the spirit of Midsummer.
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=58933 AND `spell_effect`=45427;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
('58933','45427','2','Midsummer - Bonus Set');
