CREATE TABLE IF NOT EXISTS `battlecl_item_enchant_visual` (
    `item_guid` INT(10) UNSIGNED NOT NULL COMMENT 'item_instance guid',
    `display` INT(10) UNSIGNED NOT NULL COMMENT 'enchantID',
    PRIMARY KEY (`item_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
