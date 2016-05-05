/*
 * Copyright (C) 2008-2010 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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

#ifndef BATTLEFIELD_H_
#define BATTLEFIELD_H_

#include "Utilities/Util.h"
#include "SharedDefines.h"
#include "OutdoorPvP.h"
#include "ZoneScript.h"
#include "Common.h"
#include "DBCEnums.h"
#include "ScriptPCH.h"

#define BF_TEAMS_COUNT 2

enum Battlefields
{
    BATTLEFIELD_WG = 1, // Wintergrasp
    BATTLEFIELD_TB = 2, // Tol Barad
};

enum BattlefieldStates
{
    BATTLEFIELD_FAILURE,
    BATTLEFIELD_SUCCESS,
    BATTLEFIELD_WAIT,
    BATTLEFIELD_PREPARE,
    BATTLEFIELD_START
};

enum BuildingStates
{
    STATE_NONE,
    STATE_NEUTRAL_INTACT,
    STATE_NEUTRAL_DAMAGE,
    STATE_NEUTRAL_DESTROY,
    STATE_HORDE_INTACT,
    STATE_HORDE_DAMAGE,
    STATE_HORDE_DESTROY,
    STATE_ALLIANCE_INTACT,
    STATE_ALLIANCE_DAMAGE,
    STATE_ALLIANCE_DESTROY
};

enum Sounds
{
    BF_SOUND_HORDE_WINS               = 8454,
    BF_SOUND_ALLIANCE_WINS            = 8455,
    BF_SOUND_START                    = 3439
};

class Player;
class GameObject;
class WorldPacket;
class Creature;
class Unit;

class Battlefield;
class BfCapturePoint;

struct WorldState
{
    uint32 worldState;
    BuildingStates value;
};

class BfCapturePoint
{
    friend class Battlefield;

    public:
        typedef std::set<uint64> GuidSet;

        BfCapturePoint(Battlefield* bf, GameObject* go, TeamId team);
        virtual ~BfCapturePoint() {}

        bool DelCapturePoint();

        void SendUpdateWorldState(uint32 field, uint32 value);

        bool HandlePlayerEnter(Player* player);
        void HandlePlayerLeave(Player* player);

        TeamId GetTeamId();

        bool IsInsideObjective(Player* player) const;
        void SendObjectiveComplete(uint32 id, uint64 guid);

        void Update(uint32 diff);

        void SendChangePhase();

        void CastToAllPlayers(uint32 spell);

        void SetCapturePointObject(GameObject* capturePoint);

        /** Scripts **/
        virtual void FillInitialWorldStates(WorldPacket & /*data*/) {}

        virtual void OnSendUpdateWorldState(uint32 /*field*/, uint32 /*value*/) {}

        virtual bool OnPlayerEnter(Player* /*player*/) { return true; }
        virtual void OnPlayerLeave(Player* /*player*/) {}

        virtual void OnUpdate(uint32 /*diff*/) {}

        virtual void ChangeTeam(TeamId /*oldTeam*/) {}
        virtual void ChangeState() {}

        virtual void UpdateState() {}
        virtual void LinkGraveYard() {}

        uint64 _CapturePoint;

    protected:
        Battlefield* _bf;
        WorldState ws;

        GuidSet _Players[2];

        TeamId _Team;

        ObjectiveStates _OldState;
        ObjectiveStates _State;

        float _Value;
        float _MaxValue;
        float _MinValue;
        float _MaxSpeed;

        uint32 _NeutralValuePct;
};

class Battlefield : public ZoneScript
{
    friend class BattlefieldMgr;
    friend class BfCapturePoint;

    public:
        typedef std::map<uint64, uint32> GuidTimerMap;
        typedef std::map<uint64, uint64> GuidsMap;
        typedef std::map<uint64, WorldState> GameObjectBuildingMap;
        typedef std::map<uint8, BfCapturePoint*> CapturePointMap;

        typedef std::set<const AreaPOIEntry*> AreaPOISet;
        typedef std::set<Group*> GroupSet;
        typedef std::set<uint64> GuidSet;

        Battlefield();
        virtual ~Battlefield();

        void RegisterZone(uint32 zoneId);
        void SendUpdateWorldState(uint32 field, uint32 value);

        void SetBattlefieldState(BattlefieldStates state);
        void SetBattleTime(bool value);
        void SetTimer(uint32 timer);
        void SetEnable(bool enable);
        void SetDefenderTeam(TeamId team);

        BattlefieldStates GetBattlefieldState();
        TeamId GetDefenderTeam();
        TeamId GetAttackerTeam();
        uint32 GetBattleId();
        uint32 GetZoneId();
        uint32 GetTimer();
        uint32 GetLastResurrectTime();
        bool GetEnable();
        bool IsBattleTime();
        bool HasPlayerInZone(Player* player) { return player && _Players[player->GetTeamId()].find(player->GetGUID()) != _Players[player->GetTeamId()].end(); }
        bool HasPlayerInQueue(Player* player) { return player && _PlayersInQueue[player->GetTeamId()].find(player->GetGUID()) != _PlayersInQueue[player->GetTeamId()].end(); }
        bool HasPlayerInBattle(Player* player) { return player && _PlayersInBattle[player->GetTeamId()].find(player->GetGUID()) != _PlayersInBattle[player->GetTeamId()].end(); }
        bool HasPlayerInRemoving(Player* player) { return player && _PlayersRemoving[player->GetTeamId()].find(player->GetGUID()) != _PlayersRemoving[player->GetTeamId()].end(); }
        bool HasPlayerInInviting(Player* player) { return player && _PlayersInviting[player->GetTeamId()].find(player->GetGUID()) != _PlayersInviting[player->GetTeamId()].end(); }

        Group* GetFreeRaid(TeamId team);
        Group* GetPlayerGroup(uint64 guid, TeamId team);

        void Update(uint32 diff);

        void HandlePlayerEnterZone(Player* player, uint32 zone);
        void HandlePlayerLeaveZone(Player* player, uint32 zone);
        void HandlePlayerKill(Player* killer, Unit* killed);
        void HandlePlayerResurrects(Player* player, uint32 areaFlag);

        void InviteZone();
        void InviteQueue();
        void InvitePlayer(Player* player);

        void AddPlayerToQueue(Player* player);
        void AddPlayerToBattle(Player* player);
        void AddPlayerToResurrectQueue(uint64 guidCreature, uint64 guidPlayer);
        bool AddPlayerToRaid(Player* player);

        void RemovePlayer(Player* player, uint32 time = 0);
        void RemovePlayerFromQueue(Player* player);
        void RemovePlayerFromBattle(Player* player);
        void RemovePlayerFromResurrectQueue(uint64 guid);

        void RemoveGroup(Group* group);

        void UpdateSpirits();
        void ProcessRessurect(uint32 diff);
        void ResurrectQueue();

        void SetVisible(Creature* creature, bool visible);

        bool IncrementQuest(Player* player, uint32 questId, Unit* unit = NULL, GameObject* go = NULL, bool complete = false);

        void SendWarningToAll(int32 entry, int32 entry2 = 0, int32 entry3 = 0);
        void SendWarning(Player* player, int32 entry, ...);
        void PlaySoundToAll(uint32 soundID);

        void AddCapturePoint(BfCapturePoint* cp, uint8 id);

        /** Scripts **/
        virtual bool SetupBattlefield() { return true; }
        virtual void LoadGrids() {}
        virtual void FillInitialWorldStates(WorldPacket & /*data*/) {}
        virtual void OnSendUpdateWorldState(uint32 /*field*/, uint32 /*value*/) {}

        virtual void OnGameObjectCreate(GameObject* /*go*/) {}
        virtual void OnGameObjectRemove(GameObject* /*go*/) {}
        virtual void OnCreatureCreate(Creature* /*creature*/);
        virtual void OnCreatureRemove(Creature* /*creture*/) {}

        virtual void OnSetBattleTime(bool /*value*/) {}
        virtual void OnSetTimer(uint32 /*timer*/) {}
        virtual void OnSetDefenderTeam(TeamId /*team*/) {}
        virtual void OnSetBattlefieldState(BattlefieldStates /*state*/) {}

        virtual void OnUpdate(uint32 /*diff*/) {}

        virtual void OnPlayerEnterZone(Player* /*player*/) {}
        virtual void OnPlayerLeaveZone(Player* /*player*/) {}
        virtual void OnPlayerJoinBattle(Player* /*player*/) {}
        virtual void OnPlayerLeaveBattle(Player* /*player*/) {}
        virtual void OnPlayerKill(Player* /*killer*/, Unit* /*killed*/) {}
        virtual void OnPlayerResurrects(Player* /*player*/, uint32 /*areaFlag*/) {}
        virtual void OnAddPlayerToResurrectQueue(uint64 /*guidCreature*/, uint64 /*guidPlayer*/) {}
        virtual void OnRemovePlayerFromResurrectQueue(uint64 /*guid*/) {}

        virtual void OnGroupReady() {}

        virtual void EventPlayerDamagedGO(Player* /*player*/, GameObject* /*go*/, uint32 /*eventType*/) {}
        virtual void EventPlayerUsedGO(Player* /*player*/, GameObject* /*go*/) {}

        virtual void OnSetVisible(Creature* /*creature*/, bool /*visible*/) {}

    protected:
        CapturePointMap _CapturePoints;

        // Players set
        GuidSet _Players[BF_TEAMS_COUNT];
        GuidSet _PlayersInQueue[BF_TEAMS_COUNT];
        GuidSet _PlayersInBattle[BF_TEAMS_COUNT];
        GuidSet _PlayersInviting[BF_TEAMS_COUNT];

        GuidTimerMap _PlayersRemoving[BF_TEAMS_COUNT];

        // Static variables of Battlefield
        uint32 _BattleId;
        uint32 _ZoneId;
        uint32 _MapId;
        uint32 _MaxPlayers;
        uint32 _MinPlayers;
        uint32 _MinLevel;
        uint32 _TimeInBattle;
        uint32 _TimeForBattle;
        uint32 _TimeForBattleOnStartup;
        uint32 _TimeForInviteToQueue;
        uint32 _TimeForPrepareBattle;
        uint32 _TimeForAcceptInvite;

        WorldLocation KickPosition[BF_TEAMS_COUNT];

        // Dynamic variables of Batlefield
        BattlefieldStates _State;

        uint32 _Timer;
        uint32 _TickSaveTimer;

        TeamId _DefenderTeam;

        bool _Enable;
        bool _BattleTime;

        // Graveyard variables
        GuidSet _Spirits;
        GuidSet _PlayersInResurrectQueue;
        uint32 _ResurectionTimer;           // Timer for resurect player every 30 sec
        bool _VisualEffect;

        // Group
        GroupSet _Groups[BF_TEAMS_COUNT];

        bool _QueueReady;
        bool _BattlePrepared;
        bool _QueueInvited;
};

class BattlefieldGroupHandler : public GroupScript
{
    public:
        BattlefieldGroupHandler(Battlefield* bf);

        // Groop Hooks
        void OnDisband(Group* group);

    private:
        Battlefield* bf;
};

#endif
