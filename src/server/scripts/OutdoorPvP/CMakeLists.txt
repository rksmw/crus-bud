# Copyright (C) 2008-2013 TrinityCore <http://www.trinitycore.org/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

set(scripts_STAT_SRCS
  ${scripts_STAT_SRCS}
  OutdoorPvP/OutdoorPvPTF.cpp
  OutdoorPvP/OutdoorPvPSI.cpp
  OutdoorPvP/OutdoorPvPSI.h
  OutdoorPvP/OutdoorPvPZM.cpp
  OutdoorPvP/OutdoorPvPNA.cpp
  OutdoorPvP/OutdoorPvPHP.cpp
  OutdoorPvP/OutdoorPvPTF.h
  OutdoorPvP/OutdoorPvPEP.h
  OutdoorPvP/OutdoorPvPEP.cpp
  OutdoorPvP/OutdoorPvPHP.h
  OutdoorPvP/OutdoorPvPZM.h
  OutdoorPvP/OutdoorPvPNA.h
)

SOURCE_GROUP(Outland FILES
  Outland/blades_edge_mountains.cpp
  Outland/boss_doomlord_kazzak.cpp
  Outland/boss_doomwalker.cpp
  Outland/hellfire_peninsula.cpp
  Outland/nagrand.cpp
  Outland/netherstorm.cpp
  Outland/shadowmoon_valley.cpp
  Outland/shattrath_city.cpp
  Outland/terokkar_forest.cpp
  Outland/zangarmarsh.cpp)
SOURCE_GROUP(Outland\\Auchindoun\\AuchenaiCrypts REGULAR_EXPRESSION .*/Outland/Auchindoun/AuchenaiCrypts/.*)
SOURCE_GROUP(Outland\\Auchindoun\\ManaTombs REGULAR_EXPRESSION .*/Outland/Auchindoun/ManaTombs/.*)
SOURCE_GROUP(Outland\\Auchindoun\\SethekkHalls REGULAR_EXPRESSION .*/Outland/Auchindoun/SethekkHalls/.*)
SOURCE_GROUP(Outland\\Auchindoun\\ShadowLabyrinth REGULAR_EXPRESSION .*/Outland/Auchindoun/ShadowLabyrinth/.*)
SOURCE_GROUP(Outland\\BlackTemple REGULAR_EXPRESSION .*/Outland/BlackTemple/.*)
SOURCE_GROUP(Outland\\CoilfangReservoir\\SerpentShrine REGULAR_EXPRESSION .*/Outland/CoilfangReservoir/SerpentShrine/.*)
SOURCE_GROUP(Outland\\CoilfangReservoir\\SteamVault REGULAR_EXPRESSION .*/Outland/CoilfangReservoir/SteamVault/.*)
SOURCE_GROUP(Outland\\CoilfangReservoir\\underbog REGULAR_EXPRESSION .*/Outland/CoilfangReservoir/underbog/.*)
SOURCE_GROUP(Outland\\GruulsLair REGULAR_EXPRESSION .*/Outland/GruulsLair/.*)
SOURCE_GROUP(Outland\\HellfireCitadel\\BloodFurnace REGULAR_EXPRESSION .*/Outland/HellfireCitadel/BloodFurnace/.*)
SOURCE_GROUP(Outland\\HellfireCitadel\\HellfireRamparts REGULAR_EXPRESSION .*/Outland/HellfireCitadel/HellfireRamparts/.*)
SOURCE_GROUP(Outland\\HellfireCitadel\\MagtheridonsLair REGULAR_EXPRESSION .*/Outland/HellfireCitadel/MagtheridonsLair/.*)
SOURCE_GROUP(Outland\\HellfireCitadel\\ShatteredHalls REGULAR_EXPRESSION .*/Outland/HellfireCitadel/ShatteredHalls/.*)
SOURCE_GROUP(Outland\\TempestKeep\\arcatraz REGULAR_EXPRESSION .*/Outland/TempestKeep/arcatraz/.*)
SOURCE_GROUP(Outland\\TempestKeep\\botanica REGULAR_EXPRESSION .*/Outland/TempestKeep/botanica/.*)
SOURCE_GROUP(Outland\\TempestKeep\\Eye REGULAR_EXPRESSION .*/Outland/TempestKeep/Eye/.*)
SOURCE_GROUP(Outland\\TempestKeep\\Mechanar REGULAR_EXPRESSION .*/Outland/TempestKeep/Mechanar/.*)

message("  -> Prepared: Outdoor PVP Zones")
