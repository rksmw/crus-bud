-- fix stacking enrage(with other enrages) and death wish/wreckincg crew
DELETE FROM `spell_group` WHERE `spell_id`IN(12880,14201,14202,14203,14204,57518,57519,57520,57521,57522) AND `id` = 1107;
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1107, 12880),
(1107, 14201),
(1107, 14202),
(1107, 14203),
(1107, 14204),
(1107, 57518),
(1107, 57519),
(1107, 57520),
(1107, 57521),
(1107, 57522);
