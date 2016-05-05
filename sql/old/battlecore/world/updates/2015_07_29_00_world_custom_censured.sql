-- ----------------------------
-- Table structure for `letter_analogs`
-- ----------------------------
CREATE TABLE IF NOT EXISTS `letter_analogs` (
  `letter` varchar(1) NOT NULL DEFAULT '',
  `analogs` varchar(128) DEFAULT '',
  PRIMARY KEY (`letter`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=26;

-- ----------------------------
-- Records of letter_analogs
-- ----------------------------
DELETE FROM `letter_analogs` WHERE `letter` >= 'a' AND `letter` <= 'z';
INSERT INTO `letter_analogs` VALUES 
('a', '?@'),
('b', '???'),
('c', '?'),
('d', '?'),
('e', '??'),
('f', '?'),
('g', '?'),
('h', '??'),
('i', '??'),
('j', '??'),
('k', '?'),
('l', '?'),
('m', '?'),
('n', '?'),
('o', '?0'),
('p', '??'),
('q', '?'),
('r', '??'),
('s', '?$'),
('t', '?'),
('u', '??'),
('v', '?'),
('w', '???'),
('x', '?'),
('y', '??'),
('z', '?3');

-- ----------------------------
-- Table structure for `bad_word`
-- ----------------------------
DROP TABLE IF EXISTS `custom_censure_word`;
CREATE TABLE `custom_censure_word` (
  `censure_word` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`censure_word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Custom Censure Word';

-- ----------------------------
-- Records of bad_word
-- ----------------------------
INSERT INTO `custom_censure_word` (`censure_word`) 
VALUES
('c*h*i*l*e*w*o*w'),
('c.h.i.l.e.w.o.w'),
('chil3w0w'),
('chilewow'),
('c_h_i_l_e_w_o_w');

DELETE FROM `trinity_string` WHERE `entry` IN (11344,11345);
INSERT INTO `trinity_string` VALUES 
(11344, 'Mensaje bloqueado por spam, la información será enviada a la administracion, Razon: contiene la palabra %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '????????? ?? ???? ??????????, ?????? ??? ? ??? ??????? ??????????? ????? \'%s\'.'),
(11345, 'Mensaje bloqueado por spam, la información será enviada a la administracion, Razon: contiene la palabra %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '????? ?? ???? ??????????, ?????? ??? ? ??? ??????? ??????????? ????? \'%s\'.');

DELETE FROM `command` WHERE `name` IN ('filter mod', 'filter add', 'filter remove', 'filter list', 'reload filter', 'reload letter_analogs');
INSERT INTO `command` VALUES
('filter mod', 1028, 'Syntax: .filter mod on/off'),
('filter add', 1029, 'Syntax: .filter add #word'),
('filter remove', 1030, 'Syntax: .filter remove #word'),
('filter list', 1031, 'Syntax: .filter list'),
('reload filter', 1032, 'Syntax: .reload bad_word\nReload bad_word table.'),
('reload letter_analogs', 1033, 'Syntax: .reload letter_analogs\nReload letter_analogs table.');

