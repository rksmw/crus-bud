-- -----------------------------------------------------------------------
-- Aspirant Daily Quests
-- -----------------------------------------------------------------------
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (19,20) AND `SourceEntry` IN (13625,13671,13670,13669,13666,13673,13674,13675,13676,13677);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- Alliance
(19, 0, 13625, 0, 0, 9, 0, 13672, 0, 0, 0, 0, '', 'Learning The Reins - show if Up To The Challenge taken'),
(20, 0, 13625, 0, 0, 9, 0, 13672, 0, 0, 0, 0, '', 'Learning The Reins - show if Up To The Challenge taken'),
(19, 0, 13671, 0, 0, 9, 0, 13672, 0, 0, 0, 0, '', 'Training In The Field - show if Up To The Challenge taken'),
(20, 0, 13671, 0, 0, 9, 0, 13672, 0, 0, 0, 0, '', 'Training In The Field - show if Up To The Challenge taken'),
(19, 0, 13670, 0, 0, 9, 0, 13672, 0, 0, 0, 0, '', 'The Edge Of Winter - show if Up To The Challenge taken'),
(20, 0, 13670, 0, 0, 9, 0, 13672, 0, 0, 0, 0, '', 'The Edge Of Winter - show if Up To The Challenge taken'),
(19, 0, 13669, 0, 0, 9, 0, 13672, 0, 0, 0, 0, '', 'A Worthy Weapon - show if Up To The Challenge taken'),
(20, 0, 13669, 0, 0, 9, 0, 13672, 0, 0, 0, 0, '', 'A Worthy Weapon - show if Up To The Challenge taken'),
(19, 0, 13666, 0, 0, 9, 0, 13672, 0, 0, 0, 0, '', 'A Blade Fit For A Champion - show if Up To The Challenge taken'),
(20, 0, 13666, 0, 0, 9, 0, 13672, 0, 0, 0, 0, '', 'A Blade Fit For A Champion - show if Up To The Challenge taken'),
-- Horde
(19, 0, 13677, 0, 0, 9, 0, 13678, 0, 0, 0, 0, '', 'Learning The Reins - show if Up To The Challenge taken'),
(20, 0, 13677, 0, 0, 9, 0, 13678, 0, 0, 0, 0, '', 'Learning The Reins - show if Up To The Challenge taken'),
(19, 0, 13676, 0, 0, 9, 0, 13678, 0, 0, 0, 0, '', 'Training In The Field - show if Up To The Challenge taken'),
(20, 0, 13676, 0, 0, 9, 0, 13678, 0, 0, 0, 0, '', 'Training In The Field - show if Up To The Challenge taken'),
(19, 0, 13675, 0, 0, 9, 0, 13678, 0, 0, 0, 0, '', 'The Edge Of Winter - show if Up To The Challenge taken'),
(20, 0, 13675, 0, 0, 9, 0, 13678, 0, 0, 0, 0, '', 'The Edge Of Winter - show if Up To The Challenge taken'),
(19, 0, 13674, 0, 0, 9, 0, 13678, 0, 0, 0, 0, '', 'A Worthy Weapon - show if Up To The Challenge taken'),
(20, 0, 13674, 0, 0, 9, 0, 13678, 0, 0, 0, 0, '', 'A Worthy Weapon - show if Up To The Challenge taken'),
(19, 0, 13673, 0, 0, 9, 0, 13678, 0, 0, 0, 0, '', 'A Blade Fit For A Champion - show if Up To The Challenge taken'),
(20, 0, 13673, 0, 0, 9, 0, 13678, 0, 0, 0, 0, '', 'A Blade Fit For A Champion - show if Up To The Challenge taken');

-- -----------------------------------------------------------------------
-- Valiant Daily Quests
-- -----------------------------------------------------------------------
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (19,20) AND `ConditionTypeOrReference`=9 AND `ConditionValue1` IN (13719,13720,13721,13722,13697,13718,13715,13716,13717,13714);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- Darnassus
(19, 0, 13760, 0, 0, 9, 0, 13717, 0, 0, 0, 0, '', 'A Valiants Field Training (Darnassus) - show if The Valiant Charge (Darnassus) Taken'),
(20, 0, 13760, 0, 0, 9, 0, 13717, 0, 0, 0, 0, '', 'A Valiants Field Training (Darnassus) - show if The Valiant Charge (Darnassus) Taken'),
(19, 0, 13757, 0, 0, 9, 0, 13717, 0, 0, 0, 0, '', 'A Blade Fit For A Champion (Darnassus) - show if The Valiant Charge (Darnassus) Taken'),
(20, 0, 13757, 0, 0, 9, 0, 13717, 0, 0, 0, 0, '', 'A Blade Fit For A Champion (Darnassus) - show if The Valiant Charge (Darnassus) Taken'),
(19, 0, 13758, 0, 0, 9, 0, 13717, 0, 0, 0, 0, '', 'A Worthy Weapon (Darnassus) - show if The Valiant Charge (Darnassus) Taken'),
(20, 0, 13758, 0, 0, 9, 0, 13717, 0, 0, 0, 0, '', 'A Worthy Weapon (Darnassus) - show if The Valiant Charge (Darnassus) Taken'),
(19, 0, 13759, 0, 0, 9, 0, 13717, 0, 0, 0, 0, '', 'The Edge of Winter (Darnassus) - show if The Valiant Charge (Darnassus) Taken'),
(20, 0, 13759, 0, 0, 9, 0, 13717, 0, 0, 0, 0, '', 'The Edge of Winter (Darnassus) - show if The Valiant Charge (Darnassus) Taken'),
(19, 0, 13855, 0, 0, 9, 0, 13717, 0, 0, 0, 0, '', 'At The Enemy Gates (Darnassus) - show if The Valiant Charge (Darnassus) Taken'),
(20, 0, 13855, 0, 0, 9, 0, 13717, 0, 0, 0, 0, '', 'At The Enemy Gates (Darnassus) - show if The Valiant Charge (Darnassus) Taken'),
(19, 0, 13761, 0, 0, 9, 0, 13717, 0, 0, 0, 0, '', 'The Grand Melee (Darnassus) - show if The Valiant Charge (Darnassus) Taken'),
(20, 0, 13761, 0, 0, 9, 0, 13717, 0, 0, 0, 0, '', 'The Grand Melee (Darnassus) - show if The Valiant Charge (Darnassus) Taken'),
-- Exodar
(19, 0, 13755, 0, 0, 9, 0, 13716, 0, 0, 0, 0, '', 'A Valiants Field Training (Exodar) - show if The Valiant Charge (Exodar) Taken'),
(20, 0, 13755, 0, 0, 9, 0, 13716, 0, 0, 0, 0, '', 'A Valiants Field Training (Exodar) - show if The Valiant Charge (Exodar) Taken'),
(19, 0, 13752, 0, 0, 9, 0, 13716, 0, 0, 0, 0, '', 'A Blade Fit For A Champion (Exodar) - show if The Valiant Charge (Exodar) Taken'),
(20, 0, 13752, 0, 0, 9, 0, 13716, 0, 0, 0, 0, '', 'A Blade Fit For A Champion (Exodar) - show if The Valiant Charge (Exodar) Taken'),
(19, 0, 13753, 0, 0, 9, 0, 13716, 0, 0, 0, 0, '', 'A Worthy Weapon (Exodar) - show if The Valiant Charge (Exodar) Taken'),
(20, 0, 13753, 0, 0, 9, 0, 13716, 0, 0, 0, 0, '', 'A Worthy Weapon (Exodar) - show if The Valiant Charge (Exodar) Taken'),
(19, 0, 13754, 0, 0, 9, 0, 13716, 0, 0, 0, 0, '', 'The Edge of Winter (Exodar) - show if The Valiant Charge (Exodar) Taken'),
(20, 0, 13754, 0, 0, 9, 0, 13716, 0, 0, 0, 0, '', 'The Edge of Winter (Exodar) - show if The Valiant Charge (Exodar) Taken'),
(19, 0, 13854, 0, 0, 9, 0, 13716, 0, 0, 0, 0, '', 'At The Enemy Gates (Exodar) - show if The Valiant Charge (Exodar) Taken'),
(20, 0, 13854, 0, 0, 9, 0, 13716, 0, 0, 0, 0, '', 'At The Enemy Gates (Exodar) - show if The Valiant Charge (Exodar) Taken'),
(19, 0, 13756, 0, 0, 9, 0, 13716, 0, 0, 0, 0, '', 'The Grand Melee (Exodar) - show if The Valiant Charge (Exodar) Taken'),
(20, 0, 13756, 0, 0, 9, 0, 13716, 0, 0, 0, 0, '', 'The Grand Melee (Exodar) - show if The Valiant Charge (Exodar) Taken'),
-- Stormwind
(19, 0, 13592, 0, 0, 9, 0, 13718, 0, 0, 0, 0, '', 'A Valiants Field Training (Stormwind) - show if The Valiant Charge (Stormwind) Taken'),
(20, 0, 13592, 0, 0, 9, 0, 13718, 0, 0, 0, 0, '', 'A Valiants Field Training (Stormwind) - show if The Valiant Charge (Stormwind) Taken'),
(19, 0, 13603, 0, 0, 9, 0, 13718, 0, 0, 0, 0, '', 'A Blade Fit For A Champion (Stormwind) - show if The Valiant Charge (Stormwind) Taken'),
(20, 0, 13603, 0, 0, 9, 0, 13718, 0, 0, 0, 0, '', 'A Blade Fit For A Champion (Stormwind) - show if The Valiant Charge (Stormwind) Taken'),
(19, 0, 13600, 0, 0, 9, 0, 13718, 0, 0, 0, 0, '', 'A Worthy Weapon (Stormwind) - show if The Valiant Charge (Stormwind) Taken'),
(20, 0, 13600, 0, 0, 9, 0, 13718, 0, 0, 0, 0, '', 'A Worthy Weapon (Stormwind) - show if The Valiant Charge (Stormwind) Taken'),
(19, 0, 13616, 0, 0, 9, 0, 13718, 0, 0, 0, 0, '', 'The Edge of Winter (Stormwind) - show if The Valiant Charge (Stormwind) Taken'),
(20, 0, 13616, 0, 0, 9, 0, 13718, 0, 0, 0, 0, '', 'The Edge of Winter (Stormwind) - show if The Valiant Charge (Stormwind) Taken'),
(19, 0, 13847, 0, 0, 9, 0, 13718, 0, 0, 0, 0, '', 'At The Enemy Gates (Stormwind) - show if The Valiant Charge (Stormwind) Taken'),
(20, 0, 13847, 0, 0, 9, 0, 13718, 0, 0, 0, 0, '', 'At The Enemy Gates (Stormwind) - show if The Valiant Charge (Stormwind) Taken'),
(19, 0, 13665, 0, 0, 9, 0, 13718, 0, 0, 0, 0, '', 'The Grand Melee (Stormwind) - show if The Valiant Charge (Stormwind) Taken'),
(20, 0, 13665, 0, 0, 9, 0, 13718, 0, 0, 0, 0, '', 'The Grand Melee (Stormwind) - show if The Valiant Charge (Stormwind) Taken'),
-- Ironforge
(19, 0, 13744, 0, 0, 9, 0, 13714, 0, 0, 0, 0, '', 'A Valiants Field Training (Ironforge) - show if The Valiant Charge (Ironforge) Taken'),
(20, 0, 13744, 0, 0, 9, 0, 13714, 0, 0, 0, 0, '', 'A Valiants Field Training (Ironforge) - show if The Valiant Charge (Ironforge) Taken'),
(19, 0, 13741, 0, 0, 9, 0, 13714, 0, 0, 0, 0, '', 'A Blade Fit For A Champion (Ironforge) - show if The Valiant Charge (Ironforge) Taken'),
(20, 0, 13741, 0, 0, 9, 0, 13714, 0, 0, 0, 0, '', 'A Blade Fit For A Champion (Ironforge) - show if The Valiant Charge (Ironforge) Taken'),
(19, 0, 13742, 0, 0, 9, 0, 13714, 0, 0, 0, 0, '', 'A Worthy Weapon (Ironforge) - show if The Valiant Charge (Ironforge) Taken'),
(20, 0, 13742, 0, 0, 9, 0, 13714, 0, 0, 0, 0, '', 'A Worthy Weapon (Ironforge) - show if The Valiant Charge (Ironforge) Taken'),
(19, 0, 13743, 0, 0, 9, 0, 13714, 0, 0, 0, 0, '', 'The Edge of Winter (Ironforge) - show if The Valiant Charge (Ironforge) Taken'),
(20, 0, 13743, 0, 0, 9, 0, 13714, 0, 0, 0, 0, '', 'The Edge of Winter (Ironforge) - show if The Valiant Charge (Ironforge) Taken'),
(19, 0, 13851, 0, 0, 9, 0, 13714, 0, 0, 0, 0, '', 'At The Enemy Gates (Ironforge) - show if The Valiant Charge (Ironforge) Taken'),
(20, 0, 13851, 0, 0, 9, 0, 13714, 0, 0, 0, 0, '', 'At The Enemy Gates (Ironforge) - show if The Valiant Charge (Ironforge) Taken'),
(19, 0, 13745, 0, 0, 9, 0, 13714, 0, 0, 0, 0, '', 'The Grand Melee (Ironforge) - show if The Valiant Charge (Ironforge) Taken'),
(20, 0, 13745, 0, 0, 9, 0, 13714, 0, 0, 0, 0, '', 'The Grand Melee (Ironforge) - show if The Valiant Charge (Ironforge) Taken'),
-- Gnomeregan
(19, 0, 13749, 0, 0, 9, 0, 13715, 0, 0, 0, 0, '', 'A Valiants Field Training (Gnomeregan) - show if The Valiant Charge (Gnomeregan) Taken'),
(20, 0, 13749, 0, 0, 9, 0, 13715, 0, 0, 0, 0, '', 'A Valiants Field Training (Gnomeregan) - show if The Valiant Charge (Gnomeregan) Taken'),
(19, 0, 13746, 0, 0, 9, 0, 13715, 0, 0, 0, 0, '', 'A Blade Fit For A Champion (Gnomeregan) - show if The Valiant Charge (Gnomeregan) Taken'),
(20, 0, 13746, 0, 0, 9, 0, 13715, 0, 0, 0, 0, '', 'A Blade Fit For A Champion (Gnomeregan) - show if The Valiant Charge (Gnomeregan) Taken'),
(19, 0, 13747, 0, 0, 9, 0, 13715, 0, 0, 0, 0, '', 'A Worthy Weapon (Gnomeregan) - show if The Valiant Charge (Gnomeregan) Taken'),
(20, 0, 13747, 0, 0, 9, 0, 13715, 0, 0, 0, 0, '', 'A Worthy Weapon (Gnomeregan) - show if The Valiant Charge (Gnomeregan) Taken'),
(19, 0, 13748, 0, 0, 9, 0, 13715, 0, 0, 0, 0, '', 'The Edge of Winter (Gnomeregan) - show if The Valiant Charge (Gnomeregan) Taken'),
(20, 0, 13748, 0, 0, 9, 0, 13715, 0, 0, 0, 0, '', 'The Edge of Winter (Gnomeregan) - show if The Valiant Charge (Gnomeregan) Taken'),
(19, 0, 13852, 0, 0, 9, 0, 13715, 0, 0, 0, 0, '', 'At The Enemy Gates (Gnomeregan) - show if The Valiant Charge (Gnomeregan) Taken'),
(20, 0, 13852, 0, 0, 9, 0, 13715, 0, 0, 0, 0, '', 'At The Enemy Gates (Gnomeregan) - show if The Valiant Charge (Gnomeregan) Taken'),
(19, 0, 13750, 0, 0, 9, 0, 13715, 0, 0, 0, 0, '', 'The Grand Melee (Gnomeregan) - show if The Valiant Charge (Gnomeregan) Taken'),
(20, 0, 13750, 0, 0, 9, 0, 13715, 0, 0, 0, 0, '', 'The Grand Melee (Gnomeregan) - show if The Valiant Charge (Gnomeregan) Taken'),
-- Orgrimmar
(19, 0, 13765, 0, 0, 9, 0, 13697, 0, 0, 0, 0, '', 'A Valiants Field Training (Orgrimmar) - show if The Valiant Charge (Orgrimmar) Taken'),
(20, 0, 13765, 0, 0, 9, 0, 13697, 0, 0, 0, 0, '', 'A Valiants Field Training (Orgrimmar) - show if The Valiant Charge (Orgrimmar) Taken'),
(19, 0, 13762, 0, 0, 9, 0, 13697, 0, 0, 0, 0, '', 'A Blade Fit For A Champion (Orgrimmar) - show if The Valiant Charge (Orgrimmar) Taken'),
(20, 0, 13762, 0, 0, 9, 0, 13697, 0, 0, 0, 0, '', 'A Blade Fit For A Champion (Orgrimmar) - show if The Valiant Charge (Orgrimmar) Taken'),
(19, 0, 13763, 0, 0, 9, 0, 13697, 0, 0, 0, 0, '', 'A Worthy Weapon (Orgrimmar) - show if The Valiant Charge (Orgrimmar) Taken'),
(20, 0, 13763, 0, 0, 9, 0, 13697, 0, 0, 0, 0, '', 'A Worthy Weapon (Orgrimmar) - show if The Valiant Charge (Orgrimmar) Taken'),
(19, 0, 13764, 0, 0, 9, 0, 13697, 0, 0, 0, 0, '', 'The Edge of Winter (Orgrimmar) - show if The Valiant Charge (Orgrimmar) Taken'),
(20, 0, 13764, 0, 0, 9, 0, 13697, 0, 0, 0, 0, '', 'The Edge of Winter (Orgrimmar) - show if The Valiant Charge (Orgrimmar) Taken'),
(19, 0, 13856, 0, 0, 9, 0, 13697, 0, 0, 0, 0, '', 'At The Enemy Gates (Orgrimmar) - show if The Valiant Charge (Orgrimmar) Taken'),
(20, 0, 13856, 0, 0, 9, 0, 13697, 0, 0, 0, 0, '', 'At The Enemy Gates (Orgrimmar) - show if The Valiant Charge (Orgrimmar) Taken'),
(19, 0, 13767, 0, 0, 9, 0, 13697, 0, 0, 0, 0, '', 'The Grand Melee (Orgrimmar) - show if The Valiant Charge (Orgrimmar) Taken'),
(20, 0, 13767, 0, 0, 9, 0, 13697, 0, 0, 0, 0, '', 'The Grand Melee (Orgrimmar) - show if The Valiant Charge (Orgrimmar) Taken'),
-- Thunder Bluff
(19, 0, 13776, 0, 0, 9, 0, 13720, 0, 0, 0, 0, '', 'A Valiants Field Training (Thunder Bluff) - show if The Valiant Charge (Thunder Bluff) Taken'),
(20, 0, 13776, 0, 0, 9, 0, 13720, 0, 0, 0, 0, '', 'A Valiants Field Training (Thunder Bluff) - show if The Valiant Charge (Thunder Bluff) Taken'),
(19, 0, 13773, 0, 0, 9, 0, 13720, 0, 0, 0, 0, '', 'A Blade Fit For A Champion (Thunder Bluff) - show if The Valiant Charge (Thunder Bluff) Taken'),
(20, 0, 13773, 0, 0, 9, 0, 13720, 0, 0, 0, 0, '', 'A Blade Fit For A Champion (Thunder Bluff) - show if The Valiant Charge (Thunder Bluff) Taken'),
(19, 0, 13774, 0, 0, 9, 0, 13720, 0, 0, 0, 0, '', 'A Worthy Weapon (Thunder Bluff) - show if The Valiant Charge (Thunder Bluff) Taken'),
(20, 0, 13774, 0, 0, 9, 0, 13720, 0, 0, 0, 0, '', 'A Worthy Weapon (Thunder Bluff) - show if The Valiant Charge (Thunder Bluff) Taken'),
(19, 0, 13775, 0, 0, 9, 0, 13720, 0, 0, 0, 0, '', 'The Edge of Winter (Thunder Bluff) - show if The Valiant Charge (Thunder Bluff) Taken'),
(20, 0, 13775, 0, 0, 9, 0, 13720, 0, 0, 0, 0, '', 'The Edge of Winter (Thunder Bluff) - show if The Valiant Charge (Thunder Bluff) Taken'),
(19, 0, 13858, 0, 0, 9, 0, 13720, 0, 0, 0, 0, '', 'At The Enemy Gates (Thunder Bluff) - show if The Valiant Charge (Thunder Bluff) Taken'),
(20, 0, 13858, 0, 0, 9, 0, 13720, 0, 0, 0, 0, '', 'At The Enemy Gates (Thunder Bluff) - show if The Valiant Charge (Thunder Bluff) Taken'),
(19, 0, 13777, 0, 0, 9, 0, 13720, 0, 0, 0, 0, '', 'The Grand Melee (Thunder Bluff) - show if The Valiant Charge (Thunder Bluff) Taken'),
(20, 0, 13777, 0, 0, 9, 0, 13720, 0, 0, 0, 0, '', 'The Grand Melee (Thunder Bluff) - show if The Valiant Charge (Thunder Bluff) Taken'),
-- Undercity
(19, 0, 13781, 0, 0, 9, 0, 13721, 0, 0, 0, 0, '', 'A Valiants Field Training (Undercity) - show if The Valiant Charge (Undercity) Taken'),
(20, 0, 13781, 0, 0, 9, 0, 13721, 0, 0, 0, 0, '', 'A Valiants Field Training (Undercity) - show if The Valiant Charge (Undercity) Taken'),
(19, 0, 13778, 0, 0, 9, 0, 13721, 0, 0, 0, 0, '', 'A Blade Fit For A Champion (Undercity) - show if The Valiant Charge (Undercity) Taken'),
(20, 0, 13778, 0, 0, 9, 0, 13721, 0, 0, 0, 0, '', 'A Blade Fit For A Champion (Undercity) - show if The Valiant Charge (Undercity) Taken'),
(19, 0, 13779, 0, 0, 9, 0, 13721, 0, 0, 0, 0, '', 'A Worthy Weapon (Undercity) - show if The Valiant Charge (Undercity) Taken'),
(20, 0, 13779, 0, 0, 9, 0, 13721, 0, 0, 0, 0, '', 'A Worthy Weapon (Undercity) - show if The Valiant Charge (Undercity) Taken'),
(19, 0, 13780, 0, 0, 9, 0, 13721, 0, 0, 0, 0, '', 'The Edge of Winter (Undercity) - show if The Valiant Charge (Undercity) Taken'),
(20, 0, 13780, 0, 0, 9, 0, 13721, 0, 0, 0, 0, '', 'The Edge of Winter (Undercity) - show if The Valiant Charge (Undercity) Taken'),
(19, 0, 13860, 0, 0, 9, 0, 13721, 0, 0, 0, 0, '', 'At The Enemy Gates (Undercity) - show if The Valiant Charge (Undercity) Taken'),
(20, 0, 13860, 0, 0, 9, 0, 13721, 0, 0, 0, 0, '', 'At The Enemy Gates (Undercity) - show if The Valiant Charge (Undercity) Taken'),
(19, 0, 13782, 0, 0, 9, 0, 13721, 0, 0, 0, 0, '', 'The Grand Melee (Undercity) - show if The Valiant Charge (Undercity) Taken'),
(20, 0, 13782, 0, 0, 9, 0, 13721, 0, 0, 0, 0, '', 'The Grand Melee (Undercity) - show if The Valiant Charge (Undercity) Taken'),
-- Silvermoon
(19, 0, 13786, 0, 0, 9, 0, 13722, 0, 0, 0, 0, '', 'A Valiants Field Training (Silvermoon) - show if The Valiant Charge (Silvermoon) Taken'),
(20, 0, 13786, 0, 0, 9, 0, 13722, 0, 0, 0, 0, '', 'A Valiants Field Training (Silvermoon) - show if The Valiant Charge (Silvermoon) Taken'),
(19, 0, 13783, 0, 0, 9, 0, 13722, 0, 0, 0, 0, '', 'A Blade Fit For A Champion (Silvermoon) - show if The Valiant Charge (Silvermoon) Taken'),
(20, 0, 13783, 0, 0, 9, 0, 13722, 0, 0, 0, 0, '', 'A Blade Fit For A Champion (Silvermoon) - show if The Valiant Charge (Silvermoon) Taken'),
(19, 0, 13784, 0, 0, 9, 0, 13722, 0, 0, 0, 0, '', 'A Worthy Weapon (Silvermoon) - show if The Valiant Charge (Silvermoon) Taken'),
(20, 0, 13784, 0, 0, 9, 0, 13722, 0, 0, 0, 0, '', 'A Worthy Weapon (Silvermoon) - show if The Valiant Charge (Silvermoon) Taken'),
(19, 0, 13785, 0, 0, 9, 0, 13722, 0, 0, 0, 0, '', 'The Edge of Winter (Silvermoon) - show if The Valiant Charge (Silvermoon) Taken'),
(20, 0, 13785, 0, 0, 9, 0, 13722, 0, 0, 0, 0, '', 'The Edge of Winter (Silvermoon) - show if The Valiant Charge (Silvermoon) Taken'),
(19, 0, 13859, 0, 0, 9, 0, 13722, 0, 0, 0, 0, '', 'At The Enemy Gates (Silvermoon) - show if The Valiant Charge (Silvermoon) Taken'),
(20, 0, 13859, 0, 0, 9, 0, 13722, 0, 0, 0, 0, '', 'At The Enemy Gates (Silvermoon) - show if The Valiant Charge (Silvermoon) Taken'),
(19, 0, 13787, 0, 0, 9, 0, 13722, 0, 0, 0, 0, '', 'The Grand Melee (Silvermoon) - show if The Valiant Charge (Silvermoon) Taken'),
(20, 0, 13787, 0, 0, 9, 0, 13722, 0, 0, 0, 0, '', 'The Grand Melee (Silvermoon) - show if The Valiant Charge (Silvermoon) Taken'),
-- Sen'Jin
(19, 0, 13771, 0, 0, 9, 0, 13719, 0, 0, 0, 0, '', 'A Valiants Field Training (SenJin) - show if The Valiant Charge (SenJin) Taken'),
(20, 0, 13771, 0, 0, 9, 0, 13719, 0, 0, 0, 0, '', 'A Valiants Field Training (SenJin) - show if The Valiant Charge (SenJin) Taken'),
(19, 0, 13768, 0, 0, 9, 0, 13719, 0, 0, 0, 0, '', 'A Blade Fit For A Champion (SenJin) - show if The Valiant Charge (SenJin) Taken'),
(20, 0, 13768, 0, 0, 9, 0, 13719, 0, 0, 0, 0, '', 'A Blade Fit For A Champion (SenJin) - show if The Valiant Charge (SenJin) Taken'),
(19, 0, 13769, 0, 0, 9, 0, 13719, 0, 0, 0, 0, '', 'A Worthy Weapon (SenJin) - show if The Valiant Charge (SenJin) Taken'),
(20, 0, 13769, 0, 0, 9, 0, 13719, 0, 0, 0, 0, '', 'A Worthy Weapon (SenJin) - show if The Valiant Charge (SenJin) Taken'),
(19, 0, 13770, 0, 0, 9, 0, 13719, 0, 0, 0, 0, '', 'The Edge of Winter (SenJin) - show if The Valiant Charge (SenJin) Taken'),
(20, 0, 13770, 0, 0, 9, 0, 13719, 0, 0, 0, 0, '', 'The Edge of Winter (SenJin) - show if The Valiant Charge (SenJin) Taken'),
(19, 0, 13857, 0, 0, 9, 0, 13719, 0, 0, 0, 0, '', 'At The Enemy Gates (SenJin) - show if The Valiant Charge (SenJin) Taken'),
(20, 0, 13857, 0, 0, 9, 0, 13719, 0, 0, 0, 0, '', 'At The Enemy Gates (SenJin) - show if The Valiant Charge (SenJin) Taken'),
(19, 0, 13772, 0, 0, 9, 0, 13719, 0, 0, 0, 0, '', 'The Grand Melee (SenJin) - show if The Valiant Charge (SenJin) Taken'),
(20, 0, 13772, 0, 0, 9, 0, 13719, 0, 0, 0, 0, '', 'The Grand Melee (SenJin) - show if The Valiant Charge (SenJin) Taken');
-- Exclusive Group for same versions of Valiant dailies, so they all can't be done the same day
UPDATE `quest_template` SET `ExclusiveGroup`=13592 WHERE `Id` IN (13592,13744,13749,13755,13760,13765,13776,13781,13786,13771); -- A Valiant's Field Training
UPDATE `quest_template` SET `ExclusiveGroup`=13600 WHERE `Id` IN (13757,13758,13759,13768,13769,13770,13773,13774,13775,13778,13779,13780,13783,13784,13785,13762,13763,13764,13741,13742,13743,13746,13747,13748,13752,13753,13754,13600,13603,13616); -- A Blade Fit For A Champion, A Worthy Weapon and The Edge of Winter
UPDATE `quest_template` SET `ExclusiveGroup`=13847 WHERE `Id` IN (13847,13851,13852,13854,13855,13856,13857,13858,13859,13860); -- At The Enemy Gates
UPDATE `quest_template` SET `ExclusiveGroup`=13665 WHERE `Id` IN (13665,13745,13750,13756,13761,13767,13772,13777,13782,13787); -- The Grand Melee
-- update Next quest in Valiant of X to be The Valiant's Charge
UPDATE `quest_template` SET `PrevQuestId`=13700, `NextQuestId`=13718, `ExclusiveGroup`=13684, `NextQuestIdChain`=13718 WHERE `Id`=13593; -- Stormwind
UPDATE `quest_template` SET `PrevQuestId`=13700, `NextQuestId`=13714, `ExclusiveGroup`=13685, `NextQuestIdChain`=13714 WHERE `Id`=13703; -- Ironforge
UPDATE `quest_template` SET `PrevQuestId`=13700, `NextQuestId`=13715, `ExclusiveGroup`=13688, `NextQuestIdChain`=13715 WHERE `Id`=13704; -- Gnomeregan
UPDATE `quest_template` SET `PrevQuestId`=13700, `NextQuestId`=13716, `ExclusiveGroup`=13690, `NextQuestIdChain`=13716 WHERE `Id`=13705; -- Exodar
UPDATE `quest_template` SET `PrevQuestId`=13700, `NextQuestId`=13717, `ExclusiveGroup`=13689, `NextQuestIdChain`=13717 WHERE `Id`=13706; -- Darnassus
UPDATE `quest_template` SET `PrevQuestId`=13701, `NextQuestId`=13697, `ExclusiveGroup`=13691, `NextQuestIdChain`=13697 WHERE `Id`=13707; -- Orgrimmar
UPDATE `quest_template` SET `PrevQuestId`=13701, `NextQuestId`=13721, `ExclusiveGroup`=13695, `NextQuestIdChain`=13721 WHERE `Id`=13710; -- Undercity
UPDATE `quest_template` SET `PrevQuestId`=13701, `NextQuestId`=13720, `ExclusiveGroup`=13694, `NextQuestIdChain`=13720 WHERE `Id`=13709; -- Thunder Bluff
UPDATE `quest_template` SET `PrevQuestId`=13701, `NextQuestId`=13722, `ExclusiveGroup`=13696, `NextQuestIdChain`=13722 WHERE `Id`=13711; -- Silvermoon
UPDATE `quest_template` SET `PrevQuestId`=13701, `NextQuestId`=13719, `ExclusiveGroup`=13693, `NextQuestIdChain`=13719 WHERE `Id`=13708; -- Sen'jin
-- update Next quest in A valiant of X to be The Valiant's Charge
UPDATE `quest_template` SET `NextQuestId`=13718, `ExclusiveGroup`=13684, `NextQuestIdChain`=13718 WHERE `Id`=13684; -- Stormwind
UPDATE `quest_template` SET `NextQuestId`=13714, `ExclusiveGroup`=13685, `NextQuestIdChain`=13714 WHERE `Id`=13685; -- Ironforge
UPDATE `quest_template` SET `NextQuestId`=13715, `ExclusiveGroup`=13688, `NextQuestIdChain`=13715 WHERE `Id`=13688; -- Gnomeregan
UPDATE `quest_template` SET `NextQuestId`=13716, `ExclusiveGroup`=13690, `NextQuestIdChain`=13716 WHERE `Id`=13690; -- Exodar
UPDATE `quest_template` SET `NextQuestId`=13717, `ExclusiveGroup`=13689, `NextQuestIdChain`=13717 WHERE `Id`=13689; -- Darnassus
UPDATE `quest_template` SET `NextQuestId`=13697, `ExclusiveGroup`=13691, `NextQuestIdChain`=13697 WHERE `Id`=13691; -- Orgrimmar
UPDATE `quest_template` SET `NextQuestId`=13721, `ExclusiveGroup`=13695, `NextQuestIdChain`=13721 WHERE `Id`=13695; -- Undercity
UPDATE `quest_template` SET `NextQuestId`=13720, `ExclusiveGroup`=13694, `NextQuestIdChain`=13720 WHERE `Id`=13694; -- Thunder Bluff
UPDATE `quest_template` SET `NextQuestId`=13722, `ExclusiveGroup`=13696, `NextQuestIdChain`=13722 WHERE `Id`=13696; -- Silvermoon
UPDATE `quest_template` SET `NextQuestId`=13719, `ExclusiveGroup`=13693, `NextQuestIdChain`=13719 WHERE `Id`=13693; -- Sen'jin
-- No race requisites for The Valiant's Charge, Valiant dailies and The Valiant's Challenge
UPDATE `quest_template` SET `RequiredRaces`=0 WHERE `Id` IN (13719,13720,13721,13722,13697,13718,13715,13716,13717,13714);
UPDATE `quest_template` SET `RequiredRaces`=0 WHERE `Id` IN (13592,13744,13749,13755,13760,13765,13776,13781,13786,13771);
UPDATE `quest_template` SET `RequiredRaces`=0 WHERE `Id` IN (13757,13758,13759,13768,13769,13770,13773,13774,13775,13778,13779,13780,13783,13784,13785,13762,13763,13764,13741,13742,13743,13746,13747,13748,13752,13753,13754,13600,13603,13616);
UPDATE `quest_template` SET `RequiredRaces`=0 WHERE `Id` IN (13847,13851,13852,13854,13855,13856,13857,13858,13859,13860);
UPDATE `quest_template` SET `RequiredRaces`=0 WHERE `Id` IN (13665,13745,13750,13756,13761,13767,13772,13777,13782,13787);
UPDATE `quest_template` SET `RequiredRaces`=0 WHERE `Id` IN (13699,13713,13723,13724,13725,13726,13727,13728,13729,13731);

-- ---------------------------------------------------------------------------------------------------------------------
-- Exalted Argent Champion of the Alliance or Exalted Argent Champion of the Horde  daily quests (need achievement)
-- ---------------------------------------------------------------------------------------------------------------------
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (19,20) AND `SourceEntry` IN (14105,14101,14102,14104,14108,14107);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- Deathspeaker Kharos
(19, 0, 14105, 0, 0, 17, 0, 2770, 0, 0, 0, 0, '', 'Deathspeaker Kharos - Need to have completed Exalted Argent Champion of the Alliance achievement'),
(19, 0, 14105, 0, 1, 17, 0, 2816, 0, 0, 0, 0, '', 'Deathspeaker Kharos - Need to have completed Exalted Argent Champion of the Horde achievement'),
(20, 0, 14105, 0, 0, 17, 0, 2770, 0, 0, 0, 0, '', 'Deathspeaker Kharos - Need to have completed Exalted Argent Champion of the Alliance achievement'),
(20, 0, 14105, 0, 1, 17, 0, 2816, 0, 0, 0, 0, '', 'Deathspeaker Kharos - Need to have completed Exalted Argent Champion of the Horde achievement'),
-- Drottinn Hrothgar
(19, 0, 14101, 0, 0, 17, 0, 2770, 0, 0, 0, 0, '', 'Drottinn Hrothgar - Need to have completed Exalted Argent Champion of the Alliance achievement'),
(19, 0, 14101, 0, 1, 17, 0, 2816, 0, 0, 0, 0, '', 'Drottinn Hrothgar - Need to have completed Exalted Argent Champion of the Horde achievement'),
(20, 0, 14101, 0, 0, 17, 0, 2770, 0, 0, 0, 0, '', 'Drottinn Hrothgar - Need to have completed Exalted Argent Champion of the Alliance achievement'),
(20, 0, 14101, 0, 1, 17, 0, 2816, 0, 0, 0, 0, '', 'Drottinn Hrothgar - Need to have completed Exalted Argent Champion of the Horde achievement'),
-- Mistcaller Yngvar
(19, 0, 14102, 0, 0, 17, 0, 2770, 0, 0, 0, 0, '', 'Mistcaller Yngvar - Need to have completed Exalted Argent Champion of the Alliance achievement'),
(19, 0, 14102, 0, 1, 17, 0, 2816, 0, 0, 0, 0, '', 'Mistcaller Yngvar - Need to have completed Exalted Argent Champion of the Horde achievement'),
(20, 0, 14102, 0, 0, 17, 0, 2770, 0, 0, 0, 0, '', 'Mistcaller Yngvar - Need to have completed Exalted Argent Champion of the Alliance achievement'),
(20, 0, 14102, 0, 1, 17, 0, 2816, 0, 0, 0, 0, '', 'Mistcaller Yngvar - Need to have completed Exalted Argent Champion of the Horde achievement'),
-- Ornolf The Scarred
(19, 0, 14104, 0, 0, 17, 0, 2770, 0, 0, 0, 0, '', 'Mistcaller Yngvar - Need to have completed Exalted Argent Champion of the Alliance achievement'),
(19, 0, 14104, 0, 1, 17, 0, 2816, 0, 0, 0, 0, '', 'Mistcaller Yngvar - Need to have completed Exalted Argent Champion of the Horde achievement'),
(20, 0, 14104, 0, 0, 17, 0, 2770, 0, 0, 0, 0, '', 'Mistcaller Yngvar - Need to have completed Exalted Argent Champion of the Alliance achievement'),
(20, 0, 14104, 0, 1, 17, 0, 2816, 0, 0, 0, 0, '', 'Mistcaller Yngvar - Need to have completed Exalted Argent Champion of the Horde achievement'),
-- Get Kraken!
(19, 0, 14108, 0, 0, 17, 0, 2770, 0, 0, 0, 0, '', 'Get Kraken! - Need to have completed Exalted Argent Champion of the Alliance achievement'),
(19, 0, 14108, 0, 1, 17, 0, 2816, 0, 0, 0, 0, '', 'Get Kraken! - Need to have completed Exalted Argent Champion of the Horde achievement'),
(20, 0, 14108, 0, 0, 17, 0, 2770, 0, 0, 0, 0, '', 'Get Kraken! - Need to have completed Exalted Argent Champion of the Alliance achievement'),
(20, 0, 14108, 0, 1, 17, 0, 2816, 0, 0, 0, 0, '', 'Get Kraken! - Need to have completed Exalted Argent Champion of the Horde achievement'),
-- The Fate Of The Fallen
(19, 0, 14107, 0, 0, 17, 0, 2770, 0, 0, 0, 0, '', 'The Fate Of The Fallen - Need to have completed Exalted Argent Champion of the Alliance achievement'),
(19, 0, 14107, 0, 1, 17, 0, 2816, 0, 0, 0, 0, '', 'The Fate Of The Fallen - Need to have completed Exalted Argent Champion of the Horde achievement'),
(20, 0, 14107, 0, 0, 17, 0, 2770, 0, 0, 0, 0, '', 'The Fate Of The Fallen - Need to have completed Exalted Argent Champion of the Alliance achievement'),
(20, 0, 14107, 0, 1, 17, 0, 2816, 0, 0, 0, 0, '', 'The Fate Of The Fallen - Need to have completed Exalted Argent Champion of the Horde achievement');

-- ----------------------------------------------------------------------------------------------
-- The Silver Covenant daily quests require achievement A Silver Confidant 
-- ----------------------------------------------------------------------------------------------
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (19,20) AND `SourceEntry` IN (14074,14152,14080,14077,14096,14076,14090,14112);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- A Leg Up
(19, 0, 14074, 0, 0, 17, 0, 3676, 0, 0, 0, 0, '', 'A Leg Up - Need to have completed A Silver Confidant achievement'),
(20, 0, 14074, 0, 0, 17, 0, 3676, 0, 0, 0, 0, '', 'A Leg Up - Need to have completed A Silver Confidant achievement'),
-- Rescue at Sea
(19, 0, 14152, 0, 0, 17, 0, 3676, 0, 0, 0, 0, '', 'Rescue at Sea - Need to have completed A Silver Confidant achievement'),
(20, 0, 14152, 0, 0, 17, 0, 3676, 0, 0, 0, 0, '', 'Rescue at Sea - Need to have completed A Silver Confidant achievement'),
-- Stop The Aggressors
(19, 0, 14080, 0, 0, 17, 0, 3676, 0, 0, 0, 0, '', 'Stop The Aggressors - Need to have completed A Silver Confidant achievement'),
(20, 0, 14080, 0, 0, 17, 0, 3676, 0, 0, 0, 0, '', 'Stop The Aggressors - Need to have completed A Silver Confidant achievement'),
-- The Light's Mercy
(19, 0, 14077, 0, 0, 17, 0, 3676, 0, 0, 0, 0, '', 'The Light''s Mercy - Need to have completed A Silver Confidant achievement'),
(20, 0, 14077, 0, 0, 17, 0, 3676, 0, 0, 0, 0, '', 'The Light''s Mercy - Need to have completed A Silver Confidant achievement'),
-- You've Really Done It This Time, Kul
(19, 0, 14096, 0, 0, 17, 0, 3676, 0, 0, 0, 0, '', 'You''ve Really Done It This Time, Kul - Need to have completed A Silver Confidant achievement'),
(20, 0, 14096, 0, 0, 17, 0, 3676, 0, 0, 0, 0, '', 'You''ve Really Done It This Time, Kul - Need to have completed A Silver Confidant achievement'),
-- Breakfast Of Champions
(19, 0, 14076, 0, 0, 17, 0, 3676, 0, 0, 0, 0, '', 'Breakfast Of Champions - Need to have completed A Silver Confidant achievement'),
(20, 0, 14076, 0, 0, 17, 0, 3676, 0, 0, 0, 0, '', 'Breakfast Of Champions - Need to have completed A Silver Confidant achievement'),
-- Gormok Wants His Snobolds
(19, 0, 14090, 0, 0, 17, 0, 3676, 0, 0, 0, 0, '', 'Gormok Wants His Snobolds - Need to have completed A Silver Confidant achievement'),
(20, 0, 14090, 0, 0, 17, 0, 3676, 0, 0, 0, 0, '', 'Gormok Wants His Snobolds - Need to have completed A Silver Confidant achievement'),
-- What Do You Feed a Yeti, Anyway?
(19, 0, 14112, 0, 0, 17, 0, 3676, 0, 0, 0, 0, '', 'What Do You Feed a Yeti, Anyway? - Need to have completed A Silver Confidant achievement'),
(20, 0, 14112, 0, 0, 17, 0, 3676, 0, 0, 0, 0, '', 'What Do You Feed a Yeti, Anyway? - Need to have completed A Silver Confidant achievement');

-- -------------------------------------------------------------------------------------
-- The Sunreavers daily quests require achievement The Sunreavers 
-- -------------------------------------------------------------------------------------
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (19,20) AND `SourceEntry` IN (14143,14136,14140,14144,14142,14092,14141,14145);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- A Leg Up
(19, 0, 14143, 0, 0, 17, 0, 3677, 0, 0, 0, 0, '', 'A Leg Up - Need to have completed The Sunreavers achievement'),
(20, 0, 14143, 0, 0, 17, 0, 3677, 0, 0, 0, 0, '', 'A Leg Up - Need to have completed The Sunreavers achievement'),
-- Rescue at Sea
(19, 0, 14136, 0, 0, 17, 0, 3677, 0, 0, 0, 0, '', 'Rescue at Sea - Need to have completed The Sunreavers achievement'),
(20, 0, 14136, 0, 0, 17, 0, 3677, 0, 0, 0, 0, '', 'Rescue at Sea - Need to have completed The Sunreavers achievement'),
-- Stop The Aggressors
(19, 0, 14140, 0, 0, 17, 0, 3677, 0, 0, 0, 0, '', 'Stop The Aggressors - Need to have completed The Sunreavers achievement'),
(20, 0, 14140, 0, 0, 17, 0, 3677, 0, 0, 0, 0, '', 'Stop The Aggressors - Need to have completed The Sunreavers achievement'),
-- The Light's Mercy
(19, 0, 14144, 0, 0, 17, 0, 3677, 0, 0, 0, 0, '', 'The Light''s Mercy - Need to have completed The Sunreavers achievement'),
(20, 0, 14144, 0, 0, 17, 0, 3677, 0, 0, 0, 0, '', 'The Light''s Mercy - Need to have completed The Sunreavers achievement'),
-- You've Really Done It This Time, Kul
(19, 0, 14142, 0, 0, 17, 0, 3677, 0, 0, 0, 0, '', 'You''ve Really Done It This Time, Kul - Need to have completed The Sunreavers achievement'),
(20, 0, 14142, 0, 0, 17, 0, 3677, 0, 0, 0, 0, '', 'You''ve Really Done It This Time, Kul - Need to have completed The Sunreavers achievement'),
-- Breakfast Of Champions
(19, 0, 14092, 0, 0, 17, 0, 3677, 0, 0, 0, 0, '', 'Breakfast Of Champions - Need to have completed The Sunreavers achievement'),
(20, 0, 14092, 0, 0, 17, 0, 3677, 0, 0, 0, 0, '', 'Breakfast Of Champions - Need to have completed The Sunreavers achievement'),
-- Gormok Wants His Snobolds
(19, 0, 14141, 0, 0, 17, 0, 3677, 0, 0, 0, 0, '', 'Gormok Wants His Snobolds - Need to have completed The Sunreavers achievement'),
(20, 0, 14141, 0, 0, 17, 0, 3677, 0, 0, 0, 0, '', 'Gormok Wants His Snobolds - Need to have completed The Sunreavers achievement'),
-- What Do You Feed a Yeti, Anyway?
(19, 0, 14145, 0, 0, 17, 0, 3677, 0, 0, 0, 0, '', 'What Do You Feed a Yeti, Anyway? - Need to have completed The Sunreavers achievement'),
(20, 0, 14145, 0, 0, 17, 0, 3677, 0, 0, 0, 0, '', 'What Do You Feed a Yeti, Anyway? - Need to have completed The Sunreavers achievement');

-- -------------------------------------------------------------
-- Eadric the pure, The Scourgebane and champion daily quests
-- -------------------------------------------------------------
-- DK quest require dk
UPDATE `quest_template` SET `RequiredClasses`=32 WHERE `Id` IN (13795,13788,13812,13791,13813,13793,13814,13864,13863);
-- Other quests for all other classes
UPDATE `quest_template` SET `RequiredClasses`=1503 WHERE `Id` IN (13794,13682,13809,13789,13810,13790,13811,13861,13862);
-- DK champion dailies requisites
UPDATE `quest_template` SET `PrevQuestId`=13795 WHERE `Id` IN (13863,13864,13788,13812,13791,13813,13793,13814);
-- Other classes champion dailies requisites
UPDATE `quest_template` SET `PrevQuestId`=13794 WHERE `Id` IN (13682,13809,13789,13810,13790,13811,13861,13862);
-- Threat From Above also requires The Black Knight's Fall
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (19,20) AND `SourceEntry` IN (13682,13788,13809,13812);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 13682, 0, 0, 8, 0, 13664, 0, 0, 0, 0, '', 'Threat From Above - Need to have completed The Black Knight Fall'),
(20, 0, 13682, 0, 0, 8, 0, 13664, 0, 0, 0, 0, '', 'Threat From Above - Need to have completed The Black Knight Fall'),
(19, 0, 13788, 0, 0, 8, 0, 13664, 0, 0, 0, 0, '', 'Threat From Above - Need to have completed The Black Knight Fall'),
(20, 0, 13788, 0, 0, 8, 0, 13664, 0, 0, 0, 0, '', 'Threat From Above - Need to have completed The Black Knight Fall'),
(19, 0, 13809, 0, 0, 8, 0, 13664, 0, 0, 0, 0, '', 'Threat From Above - Need to have completed The Black Knight Fall'),
(20, 0, 13809, 0, 0, 8, 0, 13664, 0, 0, 0, 0, '', 'Threat From Above - Need to have completed The Black Knight Fall'),
(19, 0, 13812, 0, 0, 8, 0, 13664, 0, 0, 0, 0, '', 'Threat From Above - Need to have completed The Black Knight Fall'),
(20, 0, 13812, 0, 0, 8, 0, 13664, 0, 0, 0, 0, '', 'Threat From Above - Need to have completed The Black Knight Fall');
-- Add condtions for Eadric the pure, The Scourgebane and The Black Knight's Fall
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (19,20) AND `SourceEntry` IN (13794,13795,13664);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 13794, 0, 0, 8, 0, 13702, 0, 0, 0, 0, '', 'Eadric the pure - Need to have completed A Champions Rises'),
(19, 0, 13794, 0, 1, 8, 0, 13732, 0, 0, 0, 0, '', 'Eadric the pure - Need to have completed A Champions Rises'),
(19, 0, 13794, 0, 2, 8, 0, 13733, 0, 0, 0, 0, '', 'Eadric the pure - Need to have completed A Champions Rises'),
(19, 0, 13794, 0, 3, 8, 0, 13734, 0, 0, 0, 0, '', 'Eadric the pure - Need to have completed A Champions Rises'),
(19, 0, 13794, 0, 4, 8, 0, 13735, 0, 0, 0, 0, '', 'Eadric the pure - Need to have completed A Champions Rises'),
(19, 0, 13794, 0, 5, 8, 0, 13736, 0, 0, 0, 0, '', 'Eadric the pure - Need to have completed A Champions Rises'),
(19, 0, 13794, 0, 6, 8, 0, 13737, 0, 0, 0, 0, '', 'Eadric the pure - Need to have completed A Champions Rises'),
(19, 0, 13794, 0, 7, 8, 0, 13738, 0, 0, 0, 0, '', 'Eadric the pure - Need to have completed A Champions Rises'),
(19, 0, 13794, 0, 8, 8, 0, 13739, 0, 0, 0, 0, '', 'Eadric the pure - Need to have completed A Champions Rises'),
(19, 0, 13794, 0, 9, 8, 0, 13740, 0, 0, 0, 0, '', 'Eadric the pure - Need to have completed A Champions Rises'),
(20, 0, 13794, 0, 0, 8, 0, 13702, 0, 0, 0, 0, '', 'Eadric the pure - Need to have completed A Champions Rises'),
(20, 0, 13794, 0, 1, 8, 0, 13732, 0, 0, 0, 0, '', 'Eadric the pure - Need to have completed A Champions Rises'),
(20, 0, 13794, 0, 2, 8, 0, 13733, 0, 0, 0, 0, '', 'Eadric the pure - Need to have completed A Champions Rises'),
(20, 0, 13794, 0, 3, 8, 0, 13734, 0, 0, 0, 0, '', 'Eadric the pure - Need to have completed A Champions Rises'),
(20, 0, 13794, 0, 4, 8, 0, 13735, 0, 0, 0, 0, '', 'Eadric the pure - Need to have completed A Champions Rises'),
(20, 0, 13794, 0, 5, 8, 0, 13736, 0, 0, 0, 0, '', 'Eadric the pure - Need to have completed A Champions Rises'),
(20, 0, 13794, 0, 6, 8, 0, 13737, 0, 0, 0, 0, '', 'Eadric the pure - Need to have completed A Champions Rises'),
(20, 0, 13794, 0, 7, 8, 0, 13738, 0, 0, 0, 0, '', 'Eadric the pure - Need to have completed A Champions Rises'),
(20, 0, 13794, 0, 8, 8, 0, 13739, 0, 0, 0, 0, '', 'Eadric the pure - Need to have completed A Champions Rises'),
(20, 0, 13794, 0, 9, 8, 0, 13740, 0, 0, 0, 0, '', 'Eadric the pure - Need to have completed A Champions Rises'),
(19, 0, 13795, 0, 0, 8, 0, 13702, 0, 0, 0, 0, '', 'The Scourgebane - Need to have completed A Champions Rises'),
(19, 0, 13795, 0, 1, 8, 0, 13732, 0, 0, 0, 0, '', 'The Scourgebane - Need to have completed A Champions Rises'),
(19, 0, 13795, 0, 2, 8, 0, 13733, 0, 0, 0, 0, '', 'The Scourgebane - Need to have completed A Champions Rises'),
(19, 0, 13795, 0, 3, 8, 0, 13734, 0, 0, 0, 0, '', 'The Scourgebane - Need to have completed A Champions Rises'),
(19, 0, 13795, 0, 4, 8, 0, 13735, 0, 0, 0, 0, '', 'The Scourgebane - Need to have completed A Champions Rises'),
(19, 0, 13795, 0, 5, 8, 0, 13736, 0, 0, 0, 0, '', 'The Scourgebane - Need to have completed A Champions Rises'),
(19, 0, 13795, 0, 6, 8, 0, 13737, 0, 0, 0, 0, '', 'The Scourgebane - Need to have completed A Champions Rises'),
(19, 0, 13795, 0, 7, 8, 0, 13738, 0, 0, 0, 0, '', 'The Scourgebane - Need to have completed A Champions Rises'),
(19, 0, 13795, 0, 8, 8, 0, 13739, 0, 0, 0, 0, '', 'The Scourgebane - Need to have completed A Champions Rises'),
(19, 0, 13795, 0, 9, 8, 0, 13740, 0, 0, 0, 0, '', 'The Scourgebane - Need to have completed A Champions Rises'),
(20, 0, 13795, 0, 0, 8, 0, 13702, 0, 0, 0, 0, '', 'The Scourgebane - Need to have completed A Champions Rises'),
(20, 0, 13795, 0, 1, 8, 0, 13732, 0, 0, 0, 0, '', 'The Scourgebane - Need to have completed A Champions Rises'),
(20, 0, 13795, 0, 2, 8, 0, 13733, 0, 0, 0, 0, '', 'The Scourgebane - Need to have completed A Champions Rises'),
(20, 0, 13795, 0, 3, 8, 0, 13734, 0, 0, 0, 0, '', 'The Scourgebane - Need to have completed A Champions Rises'),
(20, 0, 13795, 0, 4, 8, 0, 13735, 0, 0, 0, 0, '', 'The Scourgebane - Need to have completed A Champions Rises'),
(20, 0, 13795, 0, 5, 8, 0, 13736, 0, 0, 0, 0, '', 'The Scourgebane - Need to have completed A Champions Rises'),
(20, 0, 13795, 0, 6, 8, 0, 13737, 0, 0, 0, 0, '', 'The Scourgebane - Need to have completed A Champions Rises'),
(20, 0, 13795, 0, 7, 8, 0, 13738, 0, 0, 0, 0, '', 'The Scourgebane - Need to have completed A Champions Rises'),
(20, 0, 13795, 0, 8, 8, 0, 13739, 0, 0, 0, 0, '', 'The Scourgebane - Need to have completed A Champions Rises'),
(20, 0, 13795, 0, 9, 8, 0, 13740, 0, 0, 0, 0, '', 'The Scourgebane - Need to have completed A Champions Rises'),
(19, 0, 13664, 0, 0, 8, 0, 13702, 0, 0, 0, 0, '', 'The Black Knight Fall - Need to have completed A Champions Rises'),
(19, 0, 13664, 0, 1, 8, 0, 13732, 0, 0, 0, 0, '', 'The Black Knight Fall - Need to have completed A Champions Rises'),
(19, 0, 13664, 0, 2, 8, 0, 13733, 0, 0, 0, 0, '', 'The Black Knight Fall - Need to have completed A Champions Rises'),
(19, 0, 13664, 0, 3, 8, 0, 13734, 0, 0, 0, 0, '', 'The Black Knight Fall - Need to have completed A Champions Rises'),
(19, 0, 13664, 0, 4, 8, 0, 13735, 0, 0, 0, 0, '', 'The Black Knight Fall - Need to have completed A Champions Rises'),
(19, 0, 13664, 0, 5, 8, 0, 13736, 0, 0, 0, 0, '', 'The Black Knight Fall - Need to have completed A Champions Rises'),
(19, 0, 13664, 0, 6, 8, 0, 13737, 0, 0, 0, 0, '', 'The Black Knight Fall - Need to have completed A Champions Rises'),
(19, 0, 13664, 0, 7, 8, 0, 13738, 0, 0, 0, 0, '', 'The Black Knight Fall - Need to have completed A Champions Rises'),
(19, 0, 13664, 0, 8, 8, 0, 13739, 0, 0, 0, 0, '', 'The Black Knight Fall - Need to have completed A Champions Rises'),
(19, 0, 13664, 0, 9, 8, 0, 13740, 0, 0, 0, 0, '', 'The Black Knight Fall - Need to have completed A Champions Rises'),
(20, 0, 13664, 0, 0, 8, 0, 13702, 0, 0, 0, 0, '', 'The Black Knight Fall - Need to have completed A Champions Rises'),
(20, 0, 13664, 0, 1, 8, 0, 13732, 0, 0, 0, 0, '', 'The Black Knight Fall - Need to have completed A Champions Rises'),
(20, 0, 13664, 0, 2, 8, 0, 13733, 0, 0, 0, 0, '', 'The Black Knight Fall - Need to have completed A Champions Rises'),
(20, 0, 13664, 0, 3, 8, 0, 13734, 0, 0, 0, 0, '', 'The Black Knight Fall - Need to have completed A Champions Rises'),
(20, 0, 13664, 0, 4, 8, 0, 13735, 0, 0, 0, 0, '', 'The Black Knight Fall - Need to have completed A Champions Rises'),
(20, 0, 13664, 0, 5, 8, 0, 13736, 0, 0, 0, 0, '', 'The Black Knight Fall - Need to have completed A Champions Rises'),
(20, 0, 13664, 0, 6, 8, 0, 13737, 0, 0, 0, 0, '', 'The Black Knight Fall - Need to have completed A Champions Rises'),
(20, 0, 13664, 0, 7, 8, 0, 13738, 0, 0, 0, 0, '', 'The Black Knight Fall - Need to have completed A Champions Rises'),
(20, 0, 13664, 0, 8, 8, 0, 13739, 0, 0, 0, 0, '', 'The Black Knight Fall - Need to have completed A Champions Rises'),
(20, 0, 13664, 0, 9, 8, 0, 13740, 0, 0, 0, 0, '', 'The Black Knight Fall - Need to have completed A Champions Rises');

-- ---------------------------------------
-- Quest missing pools
-- ---------------------------------------
DELETE FROM `pool_template` WHERE `entry` IN (6000,6001,6002,6003,6004);
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES
(6000,1,'Crusader Silverdawn quests'),
(6001,1,'Savinia Loresong quests'),
(6002,1,'Narasi Snowdawn quests'),
(6003,1,'Tylos Dawnrunner quests'),
(6004,1,'Girana the Blooded quests');

DELETE FROM `pool_quest` WHERE `pool_entry` IN (6000,6001,6002,6003,6004);
INSERT INTO `pool_quest` (`entry`,`pool_entry`,`description`) VALUES
-- Crusader Silverdawn
(14107,6000,"The Fate Of The Fallen"),
(14108,6000,"Get Kraken!"),
-- Savinia Loresong
(14076,6001,"Breakfast Of Champions (The Silver Covenant)"),
(14090,6001,"Gormok Wants His Snobolds (The Silver Covenant)"),
(14112,6001,"What Do You Feed a Yeti, Anyway? (The Silver Covenant)"),
-- Narasi Snowdawn
(14074,6002,"A Leg Up (The Silver Covenant)"),
(14077,6002,"The Light's Mercy (The Silver Covenant)"),
(14080,6002,"Stop The Aggressors (The Silver Covenant)"),
(14152,6002,"Rescue at Sea (The Silver Covenant)"),
-- Tylos Dawnrunner
(14092,6003,"Breakfast Of Champions (The Sunreavers)"),
(14141,6003,"Gormok Wants His Snobolds (The Sunreavers)"),
(14145,6003,"What Do You Feed a Yeti, Anyway? (The Sunreavers)"),
-- Girana the Blooded
(14143,6004,"A Leg Up (The Sunreavers)"),
(14144,6004,"The Light's Mercy (The Sunreavers)"),
(14140,6004,"Stop The Aggressors (The Sunreavers)"),
(14136,6004,"Rescue at Sea (The Sunreavers)");
