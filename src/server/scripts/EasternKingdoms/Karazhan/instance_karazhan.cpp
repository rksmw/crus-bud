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

/* ScriptData
SDName: Instance_Karazhan
SD%Complete: 70
SDComment: Instance Script for Karazhan to help in various encounters. @todo GameObject visibility for Opera event.
SDCategory: Karazhan
EndScriptData */

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "karazhan.h"

#define MAX_ENCOUNTER      12

/*
0  - Attumen + Midnight (optional)
1  - Moroes
2  - Maiden of Virtue (optional)
3  - Hyakiss the Lurker /  Rokad the Ravager  / Shadikith the Glider
4  - Opera Event
5  - Curator
6  - Shade of Aran (optional)
7  - Terestian Illhoof (optional)
8  - Netherspite (optional)
9  - Chess Event
10 - Prince Malchezzar
11 - Nightbane
*/

class instance_karazhan : public InstanceMapScript
{
public:
    instance_karazhan() : InstanceMapScript("instance_karazhan", 532) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const OVERRIDE
    {
        return new instance_karazhan_InstanceMapScript(map);
    }

    struct instance_karazhan_InstanceMapScript : public InstanceScript
    {
        instance_karazhan_InstanceMapScript(Map* map) : InstanceScript(map) {}

        uint32 m_auiEncounter[MAX_ENCOUNTER];
        std::string strSaveData;

        uint32 m_uiOperaEvent;
        uint32 m_uiOzDeathCount;

        uint64 m_uiCurtainGUID;
        uint64 m_uiStageDoorLeftGUID;
        uint64 m_uiStageDoorRightGUID;
        uint64 m_uiKilrekGUID;
        uint64 m_uiTerestianGUID;
        uint64 m_uiMoroesGUID;
        uint64 m_uiLibraryDoor;                                     // Door at Shade of Aran
        uint64 m_uiMassiveDoor;                                     // Door at Netherspite
        uint64 m_uiSideEntranceDoor;                                // Side Entrance
        uint64 m_uiGamesmansDoor;                                   // Door before Chess
        uint64 m_uiGamesmansExitDoor;                               // Door after Chess
        uint64 m_uiNetherspaceDoor;                                // Door at Malchezaar
        uint64 MastersTerraceDoor[2];
        uint64 ImageGUID;
        uint64 DustCoveredChest;
        uint64 bossNightbaneGUID;
        uint32 m_uiChessResetTimer;

        ChessEvent chess;

        void Initialize() OVERRIDE
        {
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));

            // 1 - OZ, 2 - HOOD, 3 - RAJ, this never gets altered.
            m_uiOperaEvent          = urand(1, 3);
            m_uiOzDeathCount        = 0;

            m_uiCurtainGUID         = 0;
            m_uiStageDoorLeftGUID   = 0;
            m_uiStageDoorRightGUID  = 0;

            m_uiKilrekGUID          = 0;
            m_uiTerestianGUID       = 0;
            m_uiMoroesGUID          = 0;

            m_uiLibraryDoor         = 0;
            m_uiMassiveDoor         = 0;
            m_uiSideEntranceDoor    = 0;
            m_uiGamesmansDoor       = 0;
            m_uiGamesmansExitDoor   = 0;
            m_uiNetherspaceDoor     = 0;
            MastersTerraceDoor[0]   = 0;
            MastersTerraceDoor[1]   = 0;
            ImageGUID               = 0;
            DustCoveredChest        = 0;
            bossNightbaneGUID       = 0;
            chess.SetAllianceStalkerCount(0);
            chess.SetHordeStalkerCount(0);
            chess.SetHordeStatusGuid(0);
            chess.SetAllianceStatusGuid(0);
            m_uiChessResetTimer = 0;

            chess.m_lChessHordeStalkerList.clear();
            chess.m_lChessAllianceStalkerList.clear();
            chess.m_lChessPiecesHorde.clear();
            chess.m_lChessPiecesAlliance.clear();
            chess.m_vHordeStalkers.clear();
            chess.m_vAllianceStalkers.clear();
        }

        bool IsEncounterInProgress() const OVERRIDE
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (m_auiEncounter[i] == IN_PROGRESS)
                    return true;

            return false;
        }

        void OnCreatureCreate(Creature* creature) OVERRIDE
        {
            switch (creature->GetEntry())
            {
                case 17229:   m_uiKilrekGUID = creature->GetGUID();      break;
                case 15688:   m_uiTerestianGUID = creature->GetGUID();   break;
                case 15687:   m_uiMoroesGUID = creature->GetGUID();      break;
                case NPC_INVISIBLE_STALKER:
                    if (creature->GetPositionY() < -1870.0f)
                        chess.m_lChessHordeStalkerList.push_back(creature->GetGUID());
                    else
                        chess.m_lChessAllianceStalkerList.push_back(creature->GetGUID());
                    break;
                case NPC_CHESS_STATUS_BAR:
                    if (creature->GetPositionY() < -1870.0f)
                        chess.SetHordeStatusGuid(creature->GetGUID());
                    else
                        chess.SetAllianceStatusGuid(creature->GetGUID());
                    break;
                case NPC_HUMAN_CHARGER:
                case NPC_HUMAN_CLERIC:
                case NPC_HUMAN_CONJURER:
                case NPC_HUMAN_FOOTMAN:
                case NPC_CONJURED_WATER_ELEMENTAL:
                case NPC_KING_LLANE:
                    chess.m_lChessPiecesAlliance.push_back(creature->GetGUID());
                    break;
                case NPC_ORC_GRUNT:
                case NPC_ORC_NECROLYTE:
                case NPC_ORC_WARLOCK:
                case NPC_ORC_WOLF:
                case NPC_SUMMONED_DAEMON:
                case NPC_WARCHIEF_BLACKHAND:
                    chess.m_lChessPiecesHorde.push_back(creature->GetGUID());
                    break;
            }
        }

        void DoPrepareChessEvent()
        {
            if (!instance)
            {
                TC_LOG_ERROR(LOG_FILTER_MAPSCRIPTS, "Instance Karazhan: ERROR DoPrepareChessEvent() no instance!");
                return;
            }

            // Allow all the chess pieces to init start position
            for (std::list<uint64>::const_iterator itr = chess.m_lChessPiecesAlliance.begin(); itr != chess.m_lChessPiecesAlliance.end(); ++itr)
            {
                if (Creature* pChessPiece = instance->GetCreature(*itr))
                {
                    Creature* pSquare = GetClosestCreatureWithEntry(pChessPiece, NPC_SQUARE_BLACK, 2.0f);
                    if (!pSquare)
                        pSquare = GetClosestCreatureWithEntry(pChessPiece, NPC_SQUARE_WHITE, 2.0f);
                    if (!pSquare)
                    {
                        TC_LOG_ERROR(LOG_FILTER_MAPSCRIPTS, "Instance Karazhan: ERROR Failed to properly load the Chess square Alliance.");
                        return;
                    }

                    // send event which will prepare the current square
                    pChessPiece->AI()->SetGUID(pSquare->GetGUID(), 0);
                }
            }

            for (std::list<uint64>::const_iterator itr = chess.m_lChessPiecesHorde.begin(); itr != chess.m_lChessPiecesHorde.end(); ++itr)
            {
                if (Creature* pChessPiece = instance->GetCreature(*itr))
                {
                    Creature* pSquare = GetClosestCreatureWithEntry(pChessPiece, NPC_SQUARE_BLACK, 2.0f);
                    if (!pSquare)
                        pSquare = GetClosestCreatureWithEntry(pChessPiece, NPC_SQUARE_WHITE, 2.0f);
                    if (!pSquare)
                    {
                        TC_LOG_ERROR(LOG_FILTER_MAPS, "Instance Karazhan: ERROR Failed to properly load the Chess square Horde.");
                        return;
                    }

                    // send event which will prepare the current square
                    pChessPiece->AI()->SetGUID(pSquare->GetGUID(), 0);
                }
            }

            // add silence debuff
            Map::PlayerList const& players = instance->GetPlayers();
            for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            {
                if (Player* pPlayer = itr->GetSource())
                    pPlayer->CastSpell(pPlayer, SPELL_GAME_IN_SESSION, true);
            }

            chess.SetAllianceStalkerCount(0);
            chess.SetHordeStalkerCount(0);
            chess.m_vHordeStalkers.clear();
            chess.m_vAllianceStalkers.clear();

            // sort stalkers depending on side
            std::list<Creature*> lStalkers;
            for (std::list<uint64>::const_iterator itr = chess.m_lChessHordeStalkerList.begin(); itr != chess.m_lChessHordeStalkerList.end(); ++itr)
            {
                if (Creature* pTemp = instance->GetCreature(*itr))
                    lStalkers.push_back(pTemp);
            }

            if (lStalkers.empty())
            {
                TC_LOG_ERROR(LOG_FILTER_MAPSCRIPTS, "Instance Karazhan: ERROR Failed to properly load the horde side stalkers for the Chess Event.");
                return;
            }

            // get the proper statusBar npc
            Creature* pStatusBar = instance->GetCreature(chess.GetHordeStatusGuid());
            if (!pStatusBar)
            {
                TC_LOG_ERROR(LOG_FILTER_MAPSCRIPTS, "Instance Karazhan: ERROR cannot load horde pStatusBar.");
                return;
            }

            lStalkers.sort(Trinity::ObjectDistanceOrderPred(pStatusBar));
            for (std::list<Creature*>::const_iterator itr = lStalkers.begin(); itr != lStalkers.end(); ++itr)
                chess.m_vHordeStalkers.push_back((*itr)->GetGUID());

            lStalkers.clear();
            for (std::list<uint64>::const_iterator itr = chess.m_lChessAllianceStalkerList.begin(); itr != chess.m_lChessAllianceStalkerList.end(); ++itr)
            {
                if (Creature* pTemp = instance->GetCreature(*itr))
                    lStalkers.push_back(pTemp);
            }

            if (lStalkers.empty())
            {
                TC_LOG_ERROR(LOG_FILTER_MAPSCRIPTS, "Instance Karazhan: ERROR Failed to properly load the alliance side stalkers for the Chess Event.");
                return;
            }

            // get the proper statusBar npc
            pStatusBar = instance->GetCreature(chess.GetAllianceStatusGuid());
            if (!pStatusBar)
            {
                TC_LOG_ERROR(LOG_FILTER_MAPSCRIPTS, "Instance Karazhan: ERROR cannot load alliance pStatusBar.");
                return;
            }

            lStalkers.sort(Trinity::ObjectDistanceOrderPred(pStatusBar));
            for (std::list<Creature*>::const_iterator itr = lStalkers.begin(); itr != lStalkers.end(); ++itr)
                chess.m_vAllianceStalkers.push_back((*itr)->GetGUID());
        }

        void SetData(uint32 type, uint32 uiData) OVERRIDE
        {
            switch (type)
            {
                case TYPE_ATTUMEN:              m_auiEncounter[0] = uiData; break;
                case TYPE_MOROES:
                    if (m_auiEncounter[1] == DONE)
                        break;
                    m_auiEncounter[1] = uiData;
                    break;
                case TYPE_MAIDEN:               m_auiEncounter[2] = uiData; break;
                case TYPE_OPTIONAL_BOSS:        m_auiEncounter[3] = uiData; break;
                case TYPE_OPERA:
                    m_auiEncounter[4] = uiData;
                    if (uiData == DONE)
                        UpdateEncounterState(ENCOUNTER_CREDIT_KILL_CREATURE, 16812, NULL);
                    break;
                case TYPE_CURATOR:              m_auiEncounter[5] = uiData; break;
                case TYPE_ARAN:                 m_auiEncounter[6] = uiData; break;
                case TYPE_TERESTIAN:            m_auiEncounter[7] = uiData; break;
                case TYPE_NETHERSPITE:          m_auiEncounter[8] = uiData; break;
                case TYPE_CHESS:
                    if (uiData == DONE)
                        {
                        // doors and loot are not handled for friendly games
                        if (GetData(TYPE_CHESS) != SPECIAL)
                        {
                            DoUseDoorOrButton(GO_GAMESMANS_HALL_EXIT_DOOR);
                            DoRespawnGameObject(DustCoveredChest, DAY);
                        }
                        
                        // remove silence debuff
                        Map::PlayerList const& players = instance->GetPlayers();
                        if (!players.isEmpty())
                        {
                            Creature* pMedivh = NULL;

                            for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                            {
                                if (Player* pPlayer = itr->GetSource())
                                {
                                    pPlayer->RemoveAurasDueToSpell(SPELL_GAME_IN_SESSION);

                                    if (pMedivh == NULL)
                                    {
                                        if (pMedivh = pPlayer->FindNearestCreature(NPC_ECHO_MEDIVH, 200.0f))
                                        {
                                            // cast game end spells
                                            pMedivh->CastSpell(pMedivh, SPELL_FORCE_KILL_BUNNY, true);
                                            pMedivh->CastSpell(pMedivh, SPELL_GAME_OVER, true);
                                            pMedivh->CastSpell(pMedivh, SPELL_CLEAR_BOARD, true);

                                            if (Creature* pController = pMedivh->FindNearestCreature(NPC_CHESS_VICTORY_CONTROLLER, 128.0f))
                                                pController->CastSpell(pController, SPELL_VICTORY_VISUAL, true);
                                        }
                                    }
                                }
                            }
                        }

                        m_uiChessResetTimer = 35000;
                    }
                    else if (uiData == FAIL)
                    {
                        // remove silence debuff
                        Map::PlayerList const& players = instance->GetPlayers();
                        if (!players.isEmpty())
                        {
                            Creature* pMedivh = NULL;

                            for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                            {
                                if (Player* pPlayer = itr->GetSource())
                                {
                                    pPlayer->RemoveAurasDueToSpell(SPELL_GAME_IN_SESSION);

                                    if (pMedivh == NULL)
                                    {
                                        if (pMedivh = pPlayer->FindNearestCreature(NPC_ECHO_MEDIVH, 200.0f))
                                        {
                                            // clean the board for reset
                                            pMedivh->CastSpell(pMedivh, SPELL_GAME_OVER, true);
                                            pMedivh->CastSpell(pMedivh, SPELL_CLEAR_BOARD, true);
                                        }
                                    }
                                    else
                                    {
                                        // clean the board for reset
                                        pMedivh->CastSpell(pMedivh, SPELL_GAME_OVER, true);
                                        pMedivh->CastSpell(pMedivh, SPELL_CLEAR_BOARD, true);
                                    }
                                }
                            }
                        }

                        m_uiChessResetTimer = 35000;
                    }
                    else if (uiData == IN_PROGRESS || uiData == SPECIAL)
                        DoPrepareChessEvent();
                    m_auiEncounter[9]  = uiData;
                    break;
                case TYPE_MALCHEZZAR:           m_auiEncounter[10] = uiData; break;
                case TYPE_NIGHTBANE:
                    if (m_auiEncounter[11] != DONE)
                        m_auiEncounter[11] = uiData;
                    break;
                case DATA_OPERA_OZ_DEATHCOUNT:
                    if (uiData == SPECIAL)
                        ++m_uiOzDeathCount;
                    else if (uiData == IN_PROGRESS)
                        m_uiOzDeathCount = 0;
                    break;
            }

            if (uiData == DONE)
            {
                OUT_SAVE_INST_DATA;

                std::ostringstream saveStream;
                saveStream << m_auiEncounter[0] << ' ' << m_auiEncounter[1] << ' ' << m_auiEncounter[2] << ' '
                    << m_auiEncounter[3] << ' ' << m_auiEncounter[4] << ' ' << m_auiEncounter[5] << ' ' << m_auiEncounter[6] << ' '
                    << m_auiEncounter[7] << ' ' << m_auiEncounter[8] << ' ' << m_auiEncounter[9] << ' ' << m_auiEncounter[10] << ' ' << m_auiEncounter[11];

                strSaveData = saveStream.str();

                SaveToDB();
                OUT_SAVE_INST_DATA_COMPLETE;
            }
        }

        void Update(uint32 uiDiff)
        {
            if (m_uiChessResetTimer)
            {
                // respawn all chess pieces and side stalkers on the original position
                if (m_uiChessResetTimer <= uiDiff)
                {
                    for (std::list<uint64>::const_iterator itr = chess.m_lChessPiecesAlliance.begin(); itr != chess.m_lChessPiecesAlliance.end(); ++itr)
                    {
                        if (Creature* pTemp = instance->GetCreature(*itr))
                            pTemp->Respawn();
                    }

                    for (std::list<uint64>::const_iterator itr = chess.m_lChessPiecesHorde.begin(); itr != chess.m_lChessPiecesHorde.end(); ++itr)
                    {
                        if (Creature* pTemp = instance->GetCreature(*itr))
                            pTemp->Respawn();
                    }

                    for (std::list<uint64>::const_iterator itr = chess.m_lChessAllianceStalkerList.begin(); itr != chess.m_lChessAllianceStalkerList.end(); ++itr)
                    {
                        if (Creature* pTemp = instance->GetCreature(*itr))
                        {
                            pTemp->Respawn();
                            pTemp->HandleEmoteCommand(EMOTE_STATE_NONE);
                        }
                    }
                    for (std::list<uint64>::const_iterator itr = chess.m_lChessHordeStalkerList.begin(); itr != chess.m_lChessHordeStalkerList.end(); ++itr)
                    {
                        if (Creature* pTemp = instance->GetCreature(*itr))
                        {
                            pTemp->Respawn();
                            pTemp->HandleEmoteCommand(EMOTE_STATE_NONE);
                        }
                    }

                    if (GetData(TYPE_CHESS) == FAIL)
                        SetData(TYPE_CHESS, NOT_STARTED);

                    m_uiChessResetTimer = 0;
                }
                else
                    m_uiChessResetTimer -= uiDiff;
            }
        }

        void SetData64(uint32 identifier, uint64 data) OVERRIDE
        {
            if (identifier == DATA_IMAGE_OF_MEDIVH)
            {
                ImageGUID = data;
                bossNightbaneGUID = data;
            }
        }

        void OnGameObjectCreate(GameObject* go) OVERRIDE
        {
            switch (go->GetEntry())
            {
                case 183932:   m_uiCurtainGUID          = go->GetGUID();         break;
                case 184278:
                    m_uiStageDoorLeftGUID = go->GetGUID();
                    if (m_auiEncounter[4] == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case 184279:
                    m_uiStageDoorRightGUID = go->GetGUID();
                    if (m_auiEncounter[4] == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case 184517:   m_uiLibraryDoor          = go->GetGUID();         break;
                case 185521:   m_uiMassiveDoor          = go->GetGUID();         break;
                case 184276:   m_uiGamesmansDoor        = go->GetGUID();         break;
                case 184277:   m_uiGamesmansExitDoor    = go->GetGUID();         break;
                case 185134:   m_uiNetherspaceDoor      = go->GetGUID();         break;
                case 184274:    MastersTerraceDoor[0] = go->GetGUID();  break;
                case 184280:    MastersTerraceDoor[1] = go->GetGUID();  break;
                case 184275:
                    m_uiSideEntranceDoor = go->GetGUID();
                    if (m_auiEncounter[4] == DONE)
                        go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
                    else
                        go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
                    break;
                case 185119: DustCoveredChest = go->GetGUID(); break;
            }

            switch (m_uiOperaEvent)
            {
                /// @todo Set Object visibilities for Opera based on performance
                case EVENT_OZ:
                    break;

                case EVENT_HOOD:
                    break;

                case EVENT_RAJ:
                    break;
            }
        }

        std::string GetSaveData() OVERRIDE
        {
            return strSaveData;
        }

        uint32 GetData(uint32 uiData) const OVERRIDE
        {
            switch (uiData)
            {
                case TYPE_ATTUMEN:              return m_auiEncounter[0];
                case TYPE_MOROES:               return m_auiEncounter[1];
                case TYPE_MAIDEN:               return m_auiEncounter[2];
                case TYPE_OPTIONAL_BOSS:        return m_auiEncounter[3];
                case TYPE_OPERA:                return m_auiEncounter[4];
                case TYPE_CURATOR:              return m_auiEncounter[5];
                case TYPE_ARAN:                 return m_auiEncounter[6];
                case TYPE_TERESTIAN:            return m_auiEncounter[7];
                case TYPE_NETHERSPITE:          return m_auiEncounter[8];
                case TYPE_CHESS:                return m_auiEncounter[9];
                case TYPE_MALCHEZZAR:           return m_auiEncounter[10];
                case TYPE_NIGHTBANE:            return m_auiEncounter[11];
                case DATA_OPERA_PERFORMANCE:    return m_uiOperaEvent;
                case DATA_OPERA_OZ_DEATHCOUNT:  return m_uiOzDeathCount;
            }

            return 0;
        }

        uint64 GetData64(uint32 uiData) const OVERRIDE
        {
            switch (uiData)
            {
                case DATA_KILREK:                   return m_uiKilrekGUID;
                case DATA_TERESTIAN:                return m_uiTerestianGUID;
                case DATA_MOROES:                   return m_uiMoroesGUID;
                case DATA_GO_STAGEDOORLEFT:         return m_uiStageDoorLeftGUID;
                case DATA_GO_STAGEDOORRIGHT:        return m_uiStageDoorRightGUID;
                case DATA_GO_CURTAINS:              return m_uiCurtainGUID;
                case DATA_GO_LIBRARY_DOOR:          return m_uiLibraryDoor;
                case DATA_GO_MASSIVE_DOOR:          return m_uiMassiveDoor;
                case DATA_GO_SIDE_ENTRANCE_DOOR:    return m_uiSideEntranceDoor;
                case DATA_GO_GAME_DOOR:             return m_uiGamesmansDoor;
                case DATA_GO_GAME_EXIT_DOOR:        return m_uiGamesmansExitDoor;
                case DATA_GO_NETHER_DOOR:           return m_uiNetherspaceDoor;
                case DATA_MASTERS_TERRACE_DOOR_1:   return MastersTerraceDoor[0];
                case DATA_MASTERS_TERRACE_DOOR_2:   return MastersTerraceDoor[1];
                case DATA_IMAGE_OF_MEDIVH:          return ImageGUID;
                case BOSS_NIGHTBANE:                return bossNightbaneGUID;
            }

            return 0;
        }

        void Load(char const* chrIn)
        {
            if (!chrIn)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(chrIn);
            std::istringstream loadStream(chrIn);

            loadStream >> m_auiEncounter[0] >> m_auiEncounter[1] >> m_auiEncounter[2] >> m_auiEncounter[3]
                >> m_auiEncounter[4] >> m_auiEncounter[5] >> m_auiEncounter[6] >> m_auiEncounter[7]
                >> m_auiEncounter[8] >> m_auiEncounter[9] >> m_auiEncounter[10] >> m_auiEncounter[11];
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (m_auiEncounter[i] == IN_PROGRESS)                // Do not load an encounter as "In Progress" - reset it instead.
                    m_auiEncounter[i] = NOT_STARTED;
            OUT_LOAD_INST_DATA_COMPLETE;
        }
    };
};

void AddSC_instance_karazhan()
{
    new instance_karazhan();
}
