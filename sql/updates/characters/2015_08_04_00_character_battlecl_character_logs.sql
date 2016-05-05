ALTER TABLE battlecl_character_log_racechange DROP PRIMARY KEY, ADD PRIMARY KEY (guid, time);
ALTER TABLE battlecl_character_log_rename ADD PRIMARY KEY (guid, time);
