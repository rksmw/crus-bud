UPDATE `gameobject_template` SET `type` = 1, `flags` = `flags` | 4 WHERE `entry` IN(194582, 194586); -- type=11, flags=40
DELETE FROM `gameobject_template` WHERE `entry` IN(42001, 42002, 42003, 42004);
INSERT INTO `gameobject_template` VALUES
(42001, 0, 8259, 'Doodad_org_arena_axe_pillar01',       '', '', '', 0, 4|8|32, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 12340),
(42002, 0, 8260, 'Doodad_org_arena_lightning_pillar01', '', '', '', 0, 4|8|32, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 12340),
(42003, 0, 7966, 'Doodad_org_arena_pillar01',           '', '', '', 0, 4|8|32, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 12340),
(42004, 0, 8261, 'Doodad_org_arena_ivory_pillar01',     '', '', '', 0, 4|8|32, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 12340);
