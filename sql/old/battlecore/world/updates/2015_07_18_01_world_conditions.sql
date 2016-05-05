-- Issue 8032: Destroying the Altars
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=1 AND `SourceEntry`=57853;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,57853,0,0,31,0,3,30742,0,0,0,'',"Master Summoner's Staff spell implicit target First Summoning Altar"),
(13,1,57853,0,1,31,0,3,30744,0,0,0,'',"Master Summoner's Staff spell implicit target Second Summoning Altar"),
(13,1,57853,0,2,31,0,3,30745,0,0,0,'',"Master Summoner's Staff spell implicit target Third Summoning Altar"),
(13,1,57853,0,3,31,0,3,30950,0,0,0,'',"Master Summoner's Staff spell implicit target Fourth Summoning Altar");
