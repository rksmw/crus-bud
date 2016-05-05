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

  Custom/Battleground/battleground_arena_spectate.cpp
  Custom/Battleground/battleground_titles_pvp.cpp
  Custom/Battleground/battleground_guildwars.cpp
  Custom/Battleground/battleground_soloqueue.cpp
  Custom/Battleground/battleground_soloqueue.h

  Custom/Commands/command_bc.cpp
  Custom/Commands/command_graveyard.cpp
  Custom/Commands/command_json.cpp
  Custom/Commands/command_go_move.cpp
  Custom/Commands/command_phase_system.cpp
  Custom/Commands/command_quest_completer.cpp

  Custom/Events/events_pvp_tournament.cpp
  Custom/Events/events_pvp_cerdoball.cpp
  Custom/Events/events_pvp_gurabashi.cpp
  Custom/Events/events_pve_strategy_battle.cpp
  Custom/Events/events_pve_casino.cpp
  Custom/Events/events_new_year.cpp

  Custom/Gameobject/gameobject_mineral_veins_and_herbs.cpp

  Custom/Item/item_arena_battlemaster_summoner.cpp
  Custom/Item/item_enchant_visual.cpp
  Custom/Item/item_custom_rates.cpp
  Custom/Item/item_custom_guild_leveling_system.cpp
  Custom/Item/item_radio_wow.cpp
  Custom/Item/item_shirt_ilusion.cpp  

  Custom/Npc/npc_duel.cpp
  Custom/Npc/npc_store.cpp
  Custom/Npc/npc_goku.cpp
  Custom/Npc/npc_recovery_rings_icc.cpp
  Custom/Npc/npc_change_items.cpp

  Custom/Player/player_bienvenida.cpp
  Custom/Player/player_anunciador_boss.cpp
  Custom/Player/player_check_invalid_spells.cpp
  Custom/Player/player_store_announcer.cpp
  Custom/Player/player_duel.cpp
  Custom/Player/player_channel_factions.cpp
  Custom/Player/player_raid_info_announce.cpp
  Custom/Player/player_learn_spells_on_level_up.cpp
  Custom/Player/player_channel_pvp.cpp

  Custom/Transmog/Transmogrification.cpp
  Custom/Transmog/Transmogrification.h
  Custom/Transmog/Transmogrifier.cpp
  
  Custom/house.cpp
  Custom/world_query_callback.cpp
  Custom/world_save_update.cpp
  Custom/chat_spy.cpp
)

SOURCE_GROUP(Custom REGULAR_EXPRESSION .*/Custom/.*)

message("  -> Prepared: Custom")
