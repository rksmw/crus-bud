CREATE TABLE IF NOT EXISTS `battlecl_transmogrification_sets` (
  `Owner` int(10) unsigned NOT NULL COMMENT 'Player guidlow',
  `PresetID` tinyint(3) unsigned NOT NULL COMMENT 'Preset identifier',
  `SetName` text COMMENT 'SetName',
  `SetData` text COMMENT 'Slot1 Entry1 Slot2 Entry2',
  PRIMARY KEY (`Owner`,`PresetID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `battlecl_transmogrification` ADD COLUMN `Owner` INT(10) NULL AFTER `FakeEntry`; 

ALTER TABLE `battlecl_transmogrification`
    COMMENT='6_1',
    ADD INDEX `Owner` (`Owner`);
	
ALTER TABLE `battlecl_transmogrification_sets`
    COMMENT='6_1';

ALTER TABLE `battlecl_transmogrification`
	COMMENT='6_2',
	COLLATE='utf8_general_ci';

UPDATE battlecl_transmogrification JOIN item_instance SET battlecl_transmogrification.Owner = item_instance.owner_guid WHERE item_instance.guid = battlecl_transmogrification.GUID;
