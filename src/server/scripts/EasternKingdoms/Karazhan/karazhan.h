/*
 * Copyright (C) 2008-2013 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef DEF_KARAZHAN_H
#define DEF_KARAZHAN_H

enum DataTypes
{
    TYPE_ATTUMEN                    = 1,
    TYPE_MOROES                     = 2,
    TYPE_MAIDEN                     = 3,
    TYPE_OPTIONAL_BOSS              = 4,
    TYPE_OPERA                      = 5,
    TYPE_CURATOR                    = 6,
    TYPE_ARAN                       = 7,
    TYPE_TERESTIAN                  = 8,
    TYPE_NETHERSPITE                = 9,
    TYPE_CHESS                      = 10,
    TYPE_MALCHEZZAR                 = 11,
    TYPE_NIGHTBANE                  = 12,

    DATA_OPERA_PERFORMANCE          = 13,
    DATA_OPERA_OZ_DEATHCOUNT        = 14,

    DATA_KILREK                     = 15,
    DATA_TERESTIAN                  = 16,
    DATA_MOROES                     = 17,
    DATA_GO_CURTAINS                = 18,
    DATA_GO_STAGEDOORLEFT           = 19,
    DATA_GO_STAGEDOORRIGHT          = 20,
    DATA_GO_LIBRARY_DOOR            = 21,
    DATA_GO_MASSIVE_DOOR            = 22,
    DATA_GO_NETHER_DOOR             = 23,
    DATA_GO_GAME_DOOR               = 24,
    DATA_GO_GAME_EXIT_DOOR          = 25,

    DATA_IMAGE_OF_MEDIVH            = 26,
    DATA_MASTERS_TERRACE_DOOR_1     = 27,
    DATA_MASTERS_TERRACE_DOOR_2     = 28,
    DATA_GO_SIDE_ENTRANCE_DOOR      = 29
};

enum OperaEvents
{
    EVENT_OZ                        = 1,
    EVENT_HOOD                      = 2,
    EVENT_RAJ                       = 3
};

enum eChessEvent
{
    NPC_ECHO_MEDIVH                 = 16816,
    NPC_INVISIBLE_STALKER           = 22519,                // placeholder for dead chess npcs
    NPC_CHESS_STATUS_BAR            = 22520,                // npc that controlls the transformation of dead pieces
    NPC_CHESS_VICTORY_CONTROLLER    = 22524,
    // NPC_CHESS_SOUND_BUNNY        = 21921,                // npc that handles the encounter sounds
    // NPC_WAITING_ROOM_STALKER     = 17459,                // trigger which marks the teleport location of the players; also used to cast some control spells during he game
    NPC_SQUARE_WHITE                = 17208,                // chess white square
    NPC_SQUARE_BLACK                = 17305,                // chess black square
    // NPC_SQUARE_OUTSIDE_BLACK     = 17316,                // outside chess black square
    // NPC_SQUARE_OUTSIDE_WHITE     = 17317,                // outside chess white square

    // Chess event
    NPC_ORC_GRUNT                   = 17469,                // pawn
    NPC_ORC_WOLF                    = 21748,                // knight
    NPC_ORC_WARLOCK                 = 21750,                // queen
    NPC_ORC_NECROLYTE               = 21747,                // bishop
    NPC_SUMMONED_DAEMON             = 21726,                // rook
    NPC_WARCHIEF_BLACKHAND          = 21752,                // king
    NPC_HUMAN_FOOTMAN               = 17211,                // pawn
    NPC_HUMAN_CHARGER               = 21664,                // knight
    NPC_HUMAN_CONJURER              = 21683,                // queen
    NPC_HUMAN_CLERIC                = 21682,                // bishop
    NPC_CONJURED_WATER_ELEMENTAL    = 21160,                // rook
    NPC_KING_LLANE                  = 21684,                // king

    GO_STAGE_CURTAIN                = 183932,
    GO_STAGE_DOOR_LEFT              = 184278,
    GO_STAGE_DOOR_RIGHT             = 184279,
    GO_PRIVATE_LIBRARY_DOOR         = 184517,
    GO_MASSIVE_DOOR                 = 185521,
    GO_GAMESMANS_HALL_DOOR          = 184276,
    GO_GAMESMANS_HALL_EXIT_DOOR     = 184277,
    GO_NETHERSPACE_DOOR             = 185134,
    GO_SIDE_ENTRANCE_DOOR           = 184275,
    GO_DUST_COVERED_CHEST           = 185119,
    GO_MASTERS_TERRACE_DOOR_1       = 184274,
    GO_MASTERS_TERRACE_DOOR_2       = 184280,

    // Chess event spells
    SPELL_CLEAR_BOARD               = 37366,                // spell cast to clear the board at the end of the event
    SPELL_GAME_IN_SESSION           = 39331,                // debuff on players received while the game is in session
    SPELL_FORCE_KILL_BUNNY          = 45260,                // triggers 45259
    SPELL_GAME_OVER                 = 39401,                // cast by Medivh on game end
    SPELL_VICTORY_VISUAL            = 39395,                // cast by the Victory controller on game end

    FACTION_CHESS_HORDE             = 1689,
    FACTION_CHESS_ALLIANCE          = 1690,
};

enum CreaturesKarazhan
{
    BOSS_NIGHTBANE                  = 17225
};

#define ERROR_INST_DATA(a)          TC_LOG_ERROR(LOG_FILTER_TSCR, "Instance Data for Karazhan not set properly. Encounter for Creature Entry %u may not work properly.", a->GetEntry());

struct ChessEvent
{
public:
    void DoMoveChessPieceToSides(uint32 uiSpellId, uint32 uiFaction, bool bGameEnd, Creature* creature)
    {
        // assign proper faction variables
        std::vector<uint64> vStalkers = uiFaction == FACTION_CHESS_ALLIANCE ? m_vAllianceStalkers : m_vHordeStalkers;
        uint32 uiCount = uiFaction == FACTION_CHESS_ALLIANCE ? m_uiAllianceStalkerCount : m_uiHordeStalkerCount;

        // get the proper statusBar npc
        Creature* pStatusBar = Creature::GetCreature(*creature, uiFaction == FACTION_CHESS_ALLIANCE ? m_AllianceStatusGuid : m_HordeStatusGuid);
        if (!pStatusBar)
            return;

        if (vStalkers.size() < uiCount + 1)
            return;

        // handle stalker transformation
        if (Creature* pStalker = Creature::GetCreature(*creature, vStalkers[uiCount]))
        {
            // need to provide specific target, in order to ensure the logic of the event
            pStatusBar->CastSpell(pStalker, uiSpellId, true);
            uiFaction == FACTION_CHESS_ALLIANCE ? ++m_uiAllianceStalkerCount : ++m_uiHordeStalkerCount;
        }

        // handle emote on end game
        if (bGameEnd)
        {
            // inverse factions
            vStalkers.clear();
            vStalkers = uiFaction == FACTION_CHESS_ALLIANCE ? m_vHordeStalkers : m_vAllianceStalkers;

            for (std::vector<uint64>::const_iterator itr = vStalkers.begin(); itr != vStalkers.end(); ++itr)
            {
                if (Creature* pStalker = Creature::GetCreature(*creature, *itr))
                    pStalker->HandleEmoteCommand(EMOTE_STATE_APPLAUD);
            }
        }
    }

    void SetHordeStalkerCount(uint8 value) { m_uiHordeStalkerCount = value; }
    void SetAllianceStalkerCount(uint8 value) { m_uiAllianceStalkerCount = value; }
    void SetHordeStatusGuid(uint64 guid) { m_HordeStatusGuid = guid; }
    void SetAllianceStatusGuid(uint64 guid) { m_AllianceStatusGuid = guid; }

    uint8 GetHordeStalkerCount() { return m_uiHordeStalkerCount; }
    uint8 GetAllianceStalkerCount() { return m_uiAllianceStalkerCount; }
    uint64 GetHordeStatusGuid() { return m_HordeStatusGuid; }
    uint64 GetAllianceStatusGuid() { return m_AllianceStatusGuid; }

    std::list<uint64> m_lChessPiecesHorde;
    std::list<uint64> m_lChessPiecesAlliance;
    std::list<uint64> m_lChessHordeStalkerList;
    std::list<uint64> m_lChessAllianceStalkerList;
    std::vector<uint64> m_vHordeStalkers;
    std::vector<uint64> m_vAllianceStalkers;

private:
    uint8 m_uiHordeStalkerCount;
    uint8 m_uiAllianceStalkerCount;
    uint64 m_HordeStatusGuid;
    uint64 m_AllianceStatusGuid;
};
#endif
