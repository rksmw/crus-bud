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

#include "Battlefield.h"
#include "BattlefieldMgr.h"
#include "Battleground.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Map.h"
#include "MapManager.h"
#include "Group.h"
#include "WorldPacket.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "CellImpl.h"
#include "CreatureTextMgr.h"
#include "GroupMgr.h"

Battlefield::Battlefield()
{
    _BattleId = 0;
    _ZoneId = 0;
    _MapId = 0;

    _MaxPlayers = 0;
    _MinPlayers = 0;
    _MinLevel = 0;

    _Enable = true;
    _BattleTime = false;
    _DefenderTeam = TEAM_NEUTRAL;

    _TimeInBattle = 0;
    _TimeForBattle = 0;
    _TimeForBattleOnStartup = 0;
    _TimeForInviteToQueue = 0;
    _TimeForPrepareBattle = 0;
    _TimeForAcceptInvite = 0;

    _Timer = 0;
    _TickSaveTimer = 5 * MINUTE * IN_MILLISECONDS;
    _ResurectionTimer = 0;

    _VisualEffect = false;
    _QueueReady = false;
    _BattlePrepared = false;
    _QueueInvited = false;

    new BattlefieldGroupHandler(this);
}

Battlefield::~Battlefield() { }

void Battlefield::RegisterZone(uint32 zoneId)
{
    sBattlefieldMgr->AddZone(zoneId, this);
}

uint32 Battlefield::GetBattleId()
{
    return _BattleId;
}

uint32 Battlefield::GetZoneId()
{
    return _ZoneId;
}

void Battlefield::SendUpdateWorldState(uint32 field, uint32 value)
{
    for (uint8 i = 0; i < BG_TEAMS_COUNT; ++i)
        for (GuidSet::iterator itr = _Players[i].begin(); itr != _Players[i].end(); itr++)
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
                player->SendUpdateWorldState(field, value);

    OnSendUpdateWorldState(field, value);
}

bool Battlefield::IsBattleTime()
{
    return _BattleTime;
}

void Battlefield::SetBattleTime(bool value)
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::SetBattleTime(Value: %u)", uint32(value));
    _BattleTime = value;
    OnSetBattleTime(value);
}

void Battlefield::SetTimer(uint32 timer)
{
    _Timer = timer;
    OnSetTimer(timer);
}

uint32 Battlefield::GetTimer()
{
    return _Timer;
}

uint32 Battlefield::GetLastResurrectTime()
{
    return _ResurectionTimer;
}

void Battlefield::SetEnable(bool enable)
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::SetEnable(Enable: %u)", uint32(enable));
    _Enable = enable;
}

bool Battlefield::GetEnable()
{
    return _Enable;
}

void Battlefield::SetDefenderTeam(TeamId team)
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::SetDefenderTeam(Team: %d)", team);
    _DefenderTeam = team;
    OnSetDefenderTeam(team);
}

TeamId Battlefield::GetDefenderTeam()
{
    return _DefenderTeam;
}

TeamId Battlefield::GetAttackerTeam()
{
    return _DefenderTeam == TEAM_ALLIANCE ? TEAM_HORDE : TEAM_ALLIANCE;
}

Group* Battlefield::GetFreeRaid(TeamId team)
{
    for (GroupSet::iterator itr = _Groups[team].begin(); itr != _Groups[team].end(); itr++)
        if (Group* group = (*itr))
            if (!group->IsFull())
                return group;

    return NULL;
}

Group* Battlefield::GetPlayerGroup(uint64 guid, TeamId team)
{
    for (GroupSet::iterator itr = _Groups[team].begin(); itr != _Groups[team].end(); itr++)
        if (Group* group = (*itr))
            if (group->IsMember(guid))
                return group;

    return NULL;
}

void Battlefield::SetBattlefieldState(BattlefieldStates state)
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::SetBattlefieldState(State: %d)", state);

    if (_State == state)
        return;

    OnSetBattlefieldState(state);

    _State = state;

    switch (state)
    {
        case BATTLEFIELD_START:
            SetTimer(_TimeInBattle);
            SetBattleTime(true);
            InviteZone();
            PlaySoundToAll(BF_SOUND_START);
            break;
        case BATTLEFIELD_SUCCESS:
            SetDefenderTeam(GetAttackerTeam());
        case BATTLEFIELD_FAILURE:
            SetTimer(_TimeForBattle);
            SetBattleTime(false);
            ResurrectQueue();

            PlaySoundToAll(GetDefenderTeam() == TEAM_HORDE ? BF_SOUND_HORDE_WINS : BF_SOUND_ALLIANCE_WINS);

            _QueueReady = false;
            _BattlePrepared = false;
            _QueueInvited = false;

            for (uint8 team = 0; team < BF_TEAMS_COUNT; team++)
            {
                _PlayersInQueue[team].clear();
                _PlayersInBattle[team].clear();
                for (GroupSet::const_iterator itr = _Groups[team].begin(); itr != _Groups[team].end();itr++)
                    if (Group* group = (*itr))
                        group->SetBattlefieldGroup(NULL);
                _Groups[team].clear();
            }

            for (CapturePointMap::iterator itr = _CapturePoints.begin(); itr != _CapturePoints.end(); itr++)
                (*itr).second->LinkGraveYard();

            SetBattlefieldState(BATTLEFIELD_WAIT);
            break;
    }
}

BattlefieldStates Battlefield::GetBattlefieldState()
{
    return _State;
}

void Battlefield::OnCreatureCreate(Creature* creature)
{
    if (creature->IsSpiritGuide() || creature->IsSpiritHealer())
    {
        _Spirits.insert(creature->GetGUID());
        if (creature->IsSpiritGuide())
            creature->SetVisible(IsBattleTime(), SERVERSIDE_VISIBILITY_GHOST);
        creature->SetVisible(creature->IsSpiritGuide() ? IsBattleTime() : !IsBattleTime());
    }
}

void Battlefield::Update(uint32 diff)
{
    if (GetTimer() <= diff)
    {
        if (IsBattleTime())
            SetBattlefieldState(BATTLEFIELD_FAILURE);
        else
            SetBattlefieldState(BATTLEFIELD_START);
    }
    else
        _Timer -= diff;

    if (_TickSaveTimer <= diff)
    {
        SetTimer(GetTimer());
        _TickSaveTimer = 5 * MINUTE * IN_MILLISECONDS;
    }
    else
        _TickSaveTimer -= diff;

    if (!IsBattleTime())
    {
        if (!_QueueReady && GetTimer() <= _TimeForInviteToQueue)
        {
            _QueueReady = true;
            InviteZone();
        }

        if (!_BattlePrepared && GetTimer() <= _TimeForPrepareBattle)
        {
            _BattlePrepared = true;
            SetBattlefieldState(BATTLEFIELD_PREPARE);
        }
    }
    else
    {
        ProcessRessurect(diff);

        for (CapturePointMap::iterator itr = _CapturePoints.begin(); itr != _CapturePoints.end(); itr++)
            (*itr).second->Update(diff);

        for (uint8 team = 0; team < 2; team++)
        {
            GuidTimerMap::iterator next;
            for (GuidTimerMap::iterator itr = _PlayersRemoving[team].begin(); itr != _PlayersRemoving[team].end(); itr = next)
            {
                next = itr;
                next++;

                if ((*itr).second <= diff)
                {
                    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) ha cumplido el tiempo restante de expulsion", (*itr).first);
                    if (Player* player = ObjectAccessor::FindPlayer((*itr).first))
                        RemovePlayer(player);
                }
                else
                {
                    (*itr).second -= diff;
                    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) sera removido en %u ms", (*itr).first, (*itr).second);
                }
            }
        }

        for (uint8 team = 0; team < 2; team++)
        {
            GuidSet::iterator next;
            for (GuidSet::iterator itr = _PlayersInBattle[team].begin(); itr != _PlayersInBattle[team].end(); itr = next)
            {
                next = itr;
                next++;

                if (Player* player = ObjectAccessor::FindPlayer(*itr))
                    if (player->isAFK() || !player->GetGroup())
                        RemovePlayer(player);
            }
        }

        InviteZone(); // Invitamos a quienes esten en tierra
        InviteQueue(); // Procesamos la cola continuamente
    }

    OnUpdate(diff);
}

void Battlefield::HandlePlayerEnterZone(Player* player, uint32 /*zone*/)
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::HandlePlayerEnterZone(PlayerGUID: %u)", player->GetGUIDLow());
    _Players[player->GetTeamId()].insert(player->GetGUID());

    InvitePlayer(player);

    OnPlayerEnterZone(player);
}

void Battlefield::HandlePlayerLeaveZone(Player* player, uint32 /*zone*/)
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::HandlePlayerLeaveZone(PlayerGUID: %u)", player->GetGUIDLow());

    _Players[player->GetTeamId()].erase(player->GetGUID());
    _PlayersRemoving[player->GetTeamId()].erase(player->GetGUID());

    if (IsBattleTime() && (HasPlayerInInviting(player) || HasPlayerInBattle(player)))
    {
        TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::HandlePlayerLeaveZone(PlayerGUID: %u) -> OnPlayerLeaveBattle(...)", player->GetGUIDLow());
        RemovePlayer(player);
    }

    for (CapturePointMap::iterator itr = _CapturePoints.begin(); itr != _CapturePoints.end(); itr++)
        (*itr).second->HandlePlayerLeave(player);

    OnPlayerLeaveZone(player);
}

void Battlefield::HandlePlayerKill(Player* killer, Unit* killed)
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::HandlePlayerKill(KillerGUID: %u, KilledGUID: %u)", killer->GetGUIDLow(), killed->GetGUIDLow());
    OnPlayerKill(killer, killed);
}

void Battlefield::HandlePlayerResurrects(Player* player, uint32 areaFlag)
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::HandlePlayerResurrects(PlayerGUID: %u, AreaFlag: %u)", player->GetGUIDLow(), areaFlag);
    OnPlayerResurrects(player, areaFlag);
}

void Battlefield::InviteZone()
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::InviteZone");

    GuidSet::iterator next;
    for (uint8 team = 0; team < BF_TEAMS_COUNT; ++team)
        for (GuidSet::iterator itr = _Players[team].begin(); itr != _Players[team].end(); itr++)
        {
            next = itr;
            next++;

            if (Player* player = ObjectAccessor::FindPlayer(*itr))
                InvitePlayer(player);
        }
}

void Battlefield::InviteQueue()
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::InviteQueue");

    GuidSet::iterator next;
    for (uint8 team = 0; team < BG_TEAMS_COUNT; ++team)
        for (GuidSet::iterator itr = _PlayersInQueue[team].begin(); itr != _PlayersInQueue[team].end(); itr = next)
        {
            next = itr;
            next++;

            if (Player* player = ObjectAccessor::FindPlayer(*itr))
                InvitePlayer(player);
        }
}

void Battlefield::InvitePlayer(Player* player)
{
    if (!player)
        return;

    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::InvitePlayer(PlayerGUID: %u)", player->GetGUIDLow());

    // En proceso de expulsion
    if (HasPlayerInRemoving(player))
    {
        TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) esta en proceso de expulsion", player->GetGUIDLow());
        return;
    }

    // Esta en la batalla
    if (HasPlayerInBattle(player))
    {
        TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) ya esta en la batalla", player->GetGUIDLow());
        return;
    }

    // Es la batalla, se encuentra en la zona, no se encuentra en la cola y esta volando
    if ((IsBattleTime() || player->getLevel() < _MinLevel) && HasPlayerInZone(player) && !HasPlayerInQueue(player) && player->IsFlying())
    {
        TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) solo esta volando sobre la zona", player->GetGUIDLow());
        return;
    }

    // En maestro de vuelo
    if (player->IsInFlight())
    {
        TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) esta en ruta de hipogrifo", player->GetGUIDLow());
        return;
    }

    // En Arena o Battleground
    if (player->InArena() || player->GetBattleground())
    {
        TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) se encuentra en BattleGround o Arena", player->GetGUIDLow());
        return;
    }

    // Esta teletrasportandose
    if (player->IsBeingTeleported())
    {
        TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) esta siendo teletrasportado", player->GetGUIDLow());
        return;
    }

    // No posee el nivel minimo
    if (IsBattleTime() && player->getLevel() < _MinLevel && HasPlayerInZone(player) && !player->IsFlying())
    {
        TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) no tiene nivel suficiente para la batalla", player->GetGUIDLow());
        RemovePlayer(player);
        return;
    }

    // Esta a tiempo para invitar a la batalla
    if (IsBattleTime())
    {
        // El jugador esta en la cola o la cola esta vacia
        if (HasPlayerInQueue(player) || _PlayersInQueue[player->GetTeamId()].size() == 0)
        {
            // No esta lleno
            if (_PlayersInBattle[player->GetTeamId()].size() + _PlayersInviting[player->GetTeamId()].size() < _MaxPlayers)
            {
                TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) sera invitado a la batalla", player->GetGUIDLow());

                // Se elimina de la cola
                RemovePlayerFromQueue(player);

                // Se aniade a los que estan siendo invitados
                _PlayersInviting[player->GetTeamId()].insert(player->GetGUID());

                // Remover al jugador si se acaba el tiempo para aceptar la invitacion
                RemovePlayer(player, _TimeForAcceptInvite);

                // Enviamos paquete de invitacion a la batalla
                player->GetSession()->SendBfInvitePlayerToBattle(_BattleId, _ZoneId, _TimeForAcceptInvite / IN_MILLISECONDS);

                return;
            }
            else if (HasPlayerInQueue(player) && HasPlayerInZone(player) && !player->IsFlying())
            {
                TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) no pudo ser invitado a la batalla, sera expulsado de la zona porque esta llena", player->GetGUIDLow());

                // Enviamos paquete de advertencia de expulsion
                player->GetSession()->SendBfLeavePending(GetBattleId());

                // Remover al jugador tras unos segundos
                RemovePlayer(player, 10 * IN_MILLISECONDS);

                return;
            }
            else
                TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) no pudo ser invitado a la batalla porque esta llena", player->GetGUIDLow());
        }
        else
            TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) no pudo ser invitado a la batalla porque la cola tiene prioridad", player->GetGUIDLow());
    }
    else
        TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) no pudo ser invitado a la batalla porque aun no es tiempo", player->GetGUIDLow());

    // Si no lograr invitarlo a la batalla, invitar a la cola

    // No se encuentra en la cola
    if (!HasPlayerInQueue(player))
    {
        // La batalla esta en progreso o la batalla esta a tiempo de invitar a la cola (15m)
        if (IsBattleTime() || GetTimer() <= _TimeForInviteToQueue)
        {
            TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) sera invitado a la cola", player->GetGUIDLow());

            player->GetSession()->SendBfInvitePlayerToQueue(_BattleId);
            // Si el jugador no respondiera estando en la zona y con la batalla en curso, sera expulsado
            if (IsBattleTime() && HasPlayerInZone(player) && !player->IsFlying())
                RemovePlayer(player, 10 * IN_MILLISECONDS);
        }
        else
            TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) no pudo ser invitado a la cola porque no es tiempo", player->GetGUIDLow());
    }
    else
        TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) ya se encuentra en la cola", player->GetGUIDLow());
}

void Battlefield::AddPlayerToQueue(Player* player)
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::AddPlayerToQueue(PlayerGUID: %u)", player->GetGUIDLow());

    _PlayersInQueue[player->GetTeamId()].insert(player->GetGUID());
    _PlayersRemoving[player->GetTeamId()].erase(player->GetGUID());

    BattlefieldQueueResponses response;
    if (_PlayersInBattle[player->GetTeamId()].size() + _PlayersInviting[player->GetTeamId()].size() < _MaxPlayers)
        response = BF_QUEUE_RESPONSE_SUCCESS;
    else
        response = BF_QUEUE_RESPONSE_FULL;

    player->GetSession()->SendBfQueueInviteResponse(_BattleId, _ZoneId, response);
}

void Battlefield::AddPlayerToBattle(Player* player)
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::AddPlayerToBattle(PlayerGUID: %u)", player->GetGUIDLow());
    if (AddPlayerToRaid(player))
    {
        player->GetSession()->SendBfBattleInviteResponse(_BattleId);
        _PlayersInBattle[player->GetTeamId()].insert(player->GetGUID());
        _PlayersInviting[player->GetTeamId()].erase(player->GetGUID());
        _PlayersRemoving[player->GetTeamId()].erase(player->GetGUID());
    }
    else
    {
        RemovePlayer(player);
        return;
    }

    if (!player->IsAlive())
        player->ResurrectPlayer(100.0f);

    OnPlayerJoinBattle(player);
}

void Battlefield::AddPlayerToResurrectQueue(uint64 guidCreature, uint64 guidPlayer)
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::AddPlayerToResurrectQueue(CreatureGUID: %u, PlayerGUID: %u)", uint32(GUID_LOPART(guidCreature)), uint32(GUID_LOPART(guidPlayer)));
    Player* player = ObjectAccessor::FindPlayer(guidPlayer);

    if (!player || !IsBattleTime() || player->IsAlive() || _PlayersInResurrectQueue.find(guidPlayer) != _PlayersInResurrectQueue.end())
        return;

    _PlayersInResurrectQueue.insert(guidPlayer);
    player->CastSpell(player, SPELL_WAITING_FOR_RESURRECT, true);

    OnAddPlayerToResurrectQueue(guidCreature, guidPlayer);
}

bool Battlefield::AddPlayerToRaid(Player* player)
{
    if (!player || !player->IsInWorld())
        return false;

    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::AddPlayerToRaid(PlayerGUID: %u)", player->GetGUIDLow());

    Group* raid = GetFreeRaid(player->GetTeamId());

    if (raid)
    {
        if (!raid->IsMember(player->GetGUID()))
        {
            if (Group* group = player->GetGroup())
                group->RemoveMember(player->GetGUID());
            raid->AddMember(player);
        }
        else
            return false;
    }
    else
    {
        if (Group* group = player->GetGroup())
            group->RemoveMember(player->GetGUID());
        raid = new Group;
        raid->SetBattlefieldGroup(this);
        raid->Create(player);
        sGroupMgr->AddGroup(raid);
        _Groups[player->GetTeamId()].insert(raid);
    }

    return true;
}

void Battlefield::RemovePlayer(Player* player, uint32 time)
{
    if (!player)
        return;

    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::RemovePlayer(PlayerGUID: %u)", player->GetGUIDLow());

    if (HasPlayerInZone(player) && !player->IsBeingTeleported())
    {
        if (!HasPlayerInRemoving(player))
        {
            TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) se ha aniadido al proceso de expulsion", player->GetGUIDLow());
            _PlayersRemoving[player->GetTeamId()][player->GetGUID()] = time;
        }

        if (time == 0)
        {
            TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) sera teletrasportado innmediatamente", player->GetGUIDLow());
            player->TeleportTo(KickPosition[player->GetTeamId()]);
        }
        else
            TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) sera teletrasportado dentro de %u ms", player->GetGUIDLow(), time);

        return;
    }

    // Ya esta siendo removido
    if (HasPlayerInRemoving(player))
    {
        TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) esta en proceso de expulsion", player->GetGUIDLow());
        return;
    }

    // Obtenemos la razon
    BattlefieldLeaveReason reason;
    if (player->getLevel() < _MinLevel)
        reason = BF_LEAVE_REASON_LOW_LEVEL;
    else
        reason = BF_LEAVE_REASON_EXITED;

    // Eliminaos al jugador de la lista de invitados
    _PlayersInviting[player->GetTeamId()].erase(player->GetGUID());

    if (HasPlayerInBattle(player))
    {
        TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield: El jugador (GUID: %u) sera removido de la batalla", player->GetGUIDLow());
        RemovePlayerFromBattle(player);
    }

    player->GetSession()->SendBfLeaveMessage(GetBattleId(), reason);
}

void Battlefield::RemovePlayerFromQueue(Player* player)
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::RemovePlayerFromQueue(PlayerGUID: %u)", player->GetGUIDLow());
    _PlayersInQueue[player->GetTeamId()].erase(player->GetGUID());
}

void Battlefield::RemovePlayerFromBattle(Player* player)
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::RemovePlayerFromBattle(PlayerGUID: %u)", player->GetGUIDLow());

    _PlayersInBattle[player->GetTeamId()].erase(player->GetGUID());

    if (Group* group = player->GetGroup())
        if (_Groups[player->GetTeamId()].find(group) != _Groups[player->GetTeamId()].end())
        {
            if (group->GetMembersCount() == 1)
                _Groups[player->GetTeamId()].erase(group);
            group->RemoveMember(player->GetGUID()); // Borra el grupo en caso de que sea un solo jugador
        }

    OnPlayerLeaveBattle(player);
}

void Battlefield::RemovePlayerFromResurrectQueue(uint64 guid)
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::RemovePlayerFromResurrectQueue(PlayerGUID: %u)", uint32(GUID_LOPART(guid)));
    _PlayersInResurrectQueue.erase(guid);

    if (Player* player = ObjectAccessor::FindPlayer(guid))
        player->RemoveAurasDueToSpell(SPELL_WAITING_FOR_RESURRECT);

    OnRemovePlayerFromResurrectQueue(guid);
}

void Battlefield::RemoveGroup(Group* group)
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "");
    _Groups[TEAM_ALLIANCE].erase(group);
    _Groups[TEAM_HORDE].erase(group);
}

void Battlefield::UpdateSpirits()
{
    for (GuidSet::iterator itr = _Spirits.begin(); itr != _Spirits.end(); itr++)
        if (Creature* spirit = HashMapHolder<Creature>::Find((*itr)))
        {
            if (spirit->IsSpiritGuide())
                spirit->SetVisible(IsBattleTime(), SERVERSIDE_VISIBILITY_GHOST);
            spirit->SetVisible(spirit->IsSpiritGuide() ? IsBattleTime() : !IsBattleTime());
        }
}

void Battlefield::ProcessRessurect(uint32 diff)
{
    // *********************************************************
    // ***         BATTLEFIELD RESSURECTION SYSTEM           ***
    // *********************************************************
    // this should be handled by spell system
    _ResurectionTimer += diff;
    if (_ResurectionTimer >= RESURRECTION_INTERVAL) // only for visual effect
    {
        TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::ProcessRessurect(EFFECT STEP)");
        for (GuidSet::iterator itr = _Spirits.begin(); itr != _Spirits.end(); itr++)
            if (Creature* spirit = HashMapHolder<Creature>::Find((*itr)))
                if (spirit->IsSpiritGuide())
                    // Spirit Heal, effect 117
                    spirit->CastSpell(spirit, SPELL_SPIRIT_HEAL, true);

        for (GuidSet::iterator itr = _PlayersInResurrectQueue.begin(); itr != _PlayersInResurrectQueue.end(); itr++)
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
                player->CastSpell(player, SPELL_RESURRECTION_VISUAL, true);

        _VisualEffect = true;
        _ResurectionTimer = 0;
    }
    else if (_ResurectionTimer > IN_MILLISECONDS / 2 && _VisualEffect) // Resurrect players only half a second later, to see spirit heal effect on NPC
    {
        TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::ProcessRessurect(REVIVE STEP)");

        ResurrectQueue();
        _VisualEffect = false;
    }
}

void Battlefield::ResurrectQueue()
{
    for (GuidSet::iterator itr = _PlayersInResurrectQueue.begin(); itr != _PlayersInResurrectQueue.end(); ++itr)
    {
        Player* player = ObjectAccessor::FindPlayer(*itr);
        if (!player)
            continue;

        player->ResurrectPlayer(1.0f);
        player->CastSpell(player, 6962, true);
        player->CastSpell(player, SPELL_SPIRIT_HEAL_MANA, true);
        sObjectAccessor->ConvertCorpseForPlayer(*itr);
    }
    _PlayersInResurrectQueue.clear();
}

void Battlefield::SetVisible(Creature* creature, bool visible)
{
    if (!creature)
        return;

    OnSetVisible(creature, visible);

    if (visible)
    {
        creature->Respawn(true);
        const CreatureData* creatureData = creature->GetCreatureData();
        if (creatureData)
            creature->SetPhaseMask(creatureData->phaseMask, true);
        creature->SetVisible(true);
    }
    else
    {
        creature->setDeathState(JUST_DIED);
        creature->SetPhaseMask(0x8000, true);
        creature->SetVisible(false);
    }
}

bool Battlefield::IncrementQuest(Player* player, uint32 questId, Unit* unit, GameObject* go, bool complete)
{
    if (!player)
        return false;

    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "Battlefield::IncrementQuest(PlayerGUID: %u, QuestID: %u, Complete: %u)", player->GetGUIDLow(), questId, uint32(complete));

    Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
    if (!quest || player->GetQuestStatus(questId) != QUEST_STATUS_INCOMPLETE)
        return false;

    if (complete)
    {
        player->CompleteQuest(questId);
        return true;
    }
    else
    {
        for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
        {
            int32 entry = quest->RequiredNpcOrGo[i];
            uint32 playersSlain = quest->GetPlayersSlain();
            if (entry)
            {
                if (!unit && !go)
                    return false;

                uint64 guid = entry > 0 ? unit->GetGUID() : go->GetGUID();

                player->KilledMonsterCredit(entry, guid);

                return true;
            }
            if (playersSlain && unit && unit->ToPlayer())
            {
                player->KilledPlayerCredit();
                return true;
            }
        }
    }
    return false;
}

void Battlefield::SendWarningToAll(int32 entry, int32 entry2 /*= 0*/, int32 entry3 /*= 0*/)
{
    for (uint8 team = 0; team < 2; ++team)
        for (GuidSet::iterator itr = _Players[team].begin(); itr != _Players[team].end(); itr++)
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
            {
                LocaleConstant locale = player->GetSession()->GetSessionDbcLocale();
                if (entry3 != 0)
                    SendWarning(player, entry, sObjectMgr->GetTrinityString(entry2, locale), sObjectMgr->GetTrinityString(entry3, locale));
                else if (entry2 != 0)
                    SendWarning(player, entry, sObjectMgr->GetTrinityString(entry2, locale));
                else
                    SendWarning(player, entry);
            }
}

void Battlefield::SendWarning(Player* player, int32 entry, ...)
{
    if(!player)
        return;
    const char *format = sObjectMgr->GetTrinityString(entry, player->GetSession()->GetSessionDbcLocale());

    char str[1024];
    va_list ap;
    va_start(ap, entry);
    vsnprintf(str, 1024, format, ap);
    va_end(ap);
    std::string msg(str);

    WorldPacket data(SMSG_MESSAGECHAT, 200);

    data << (uint8)CHAT_MSG_RAID_BOSS_EMOTE;
    data << (uint32)LANG_UNIVERSAL;
    data << (uint64)0;
    data << (uint32)0;                                     // 2.1.0
    data << (uint32)1;
    data << (uint8)0;
    data << (uint64)0;
    data << (uint32)(strlen(msg.c_str())+1);
    data << msg.c_str();
    data << (uint8)0;

    player->GetSession()->SendPacket(&data);
}

void Battlefield::PlaySoundToAll(uint32 soundID)
{
    WorldPacket data;
    data.Initialize(SMSG_PLAY_SOUND, 4);
    data << uint32(soundID);

    for (uint8 team = 0; team < BG_TEAMS_COUNT; team++)
        for (GuidSet::iterator itr = _PlayersInBattle[team].begin(); itr != _PlayersInBattle[team].end(); itr++)
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
                player->GetSession()->SendPacket(&data);
}

void Battlefield::AddCapturePoint(BfCapturePoint* cp, uint8 id)
{
    _CapturePoints[id] = cp;
}

BfCapturePoint::BfCapturePoint(Battlefield* bf, GameObject* capturePoint, TeamId team) : _bf(bf), _CapturePoint(capturePoint->GetGUID()), _Team(team)
{
    ASSERT(capturePoint);

    GameObjectTemplate const* goinfo = sObjectMgr->GetGameObjectTemplate(capturePoint->GetEntry());

    ASSERT(goinfo);

    _MaxValue = float(goinfo->capturePoint.maxTime);
    _MaxSpeed = float(_MaxValue / (goinfo->capturePoint.minTime ? goinfo->capturePoint.minTime : 60));
    _NeutralValuePct = goinfo->capturePoint.neutralPercent;
    _MinValue = float(_MaxValue * goinfo->capturePoint.neutralPercent / 100);
    _Value = _Team ? -_MaxValue : _MaxValue;

    _State = (_Team == TEAM_ALLIANCE ? OBJECTIVESTATE_ALLIANCE : OBJECTIVESTATE_HORDE);
    _OldState = (_Team == TEAM_ALLIANCE ? OBJECTIVESTATE_HORDE : OBJECTIVESTATE_ALLIANCE);

    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "BfCapturePoint::BfCapturePoint(CapturePoint: %u, Team: %d, MaxValue: %f, MaxSpeed: %f, NeutralValuePct: %u, MinValue: %f, Value: %f, State: %d, OldState: %d)", uint32(GUID_LOPART(_CapturePoint)), _Team, _MaxValue, _MaxSpeed, _NeutralValuePct, _MinValue, _Value, _State, _OldState);

    capturePoint->SetGoArtKit(_Team == TEAM_ALLIANCE ? GO_ART_KIT_BATTLEFIELD_BANNER_FLAG_ALLIANCE : GO_ART_KIT_BATTLEFIELD_BANNER_FLAG_HORDE);
}

bool BfCapturePoint::DelCapturePoint()
{
    if (GameObject* go = HashMapHolder<GameObject>::Find(_CapturePoint))
    {
        go->SetRespawnTime(0);  // not save respawn time
        go->Delete();
        go = NULL;
    }

    return true;
}

void BfCapturePoint::SendUpdateWorldState(uint32 field, uint32 value)
{
    for (uint8 team = 0; team < 2; ++team)
        for (GuidSet::iterator itr = _Players[team].begin(); itr != _Players[team].end(); itr++)
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
                player->SendUpdateWorldState(field, value);
}

bool BfCapturePoint::HandlePlayerEnter(Player* player)
{
    if (!OnPlayerEnter(player) || !_bf->IsBattleTime())
        return false;

    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "BfCapturePoint::HandlePlayerEnter(PlayerGUID: %u)", player->GetGUIDLow());

    if (GameObject* go = HashMapHolder<GameObject>::Find(_CapturePoint))
    {
        player->SendUpdateWorldState(go->GetGOInfo()->capturePoint.worldState1, 1);
        player->SendUpdateWorldState(go->GetGOInfo()->capturePoint.worldstate2, (uint32) ceil((_Value + _MaxValue) / (2 * _MaxValue) * 100.0f));
        player->SendUpdateWorldState(go->GetGOInfo()->capturePoint.worldstate3, _NeutralValuePct);
    }

    return _Players[player->GetTeamId()].insert(player->GetGUID()).second;
}

void BfCapturePoint::HandlePlayerLeave(Player* player)
{
    if (GameObject* go = HashMapHolder<GameObject>::Find(_CapturePoint))
        player->SendUpdateWorldState(go->GetGOInfo()->capturePoint.worldState1, 0);
    _Players[player->GetTeamId()].erase(player->GetGUID());

    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "BfCapturePoint::HandlePlayerLeave(PlayerGUID: %u)", player->GetGUIDLow());

    OnPlayerLeave(player);
}

void BfCapturePoint::SendObjectiveComplete(uint32 id, uint64 guid)
{
    if (!_State)
        return;

    uint8 team = _Team;

    for (GuidSet::iterator itr = _Players[team].begin(); itr != _Players[team].end(); itr++)
        if (Player* player = ObjectAccessor::FindPlayer(*itr))
            player->KilledMonsterCredit(id, guid);
}

bool BfCapturePoint::IsInsideObjective(Player* player) const
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "BfCapturePoint::IsInsideObjective(PlayerGUID: %u, Value: %u)", player->GetGUIDLow(), uint32(_Players[player->GetTeamId()].find(player->GetGUID()) != _Players[player->GetTeamId()].end()));
    return _Players[player->GetTeamId()].find(player->GetGUID()) != _Players[player->GetTeamId()].end();
}

TeamId BfCapturePoint::GetTeamId()
{
    return _Team;
}

void BfCapturePoint::Update(uint32 diff)
{
    OnUpdate(diff);

    if (GameObject* go = HashMapHolder<GameObject>::Find(_CapturePoint))
    {
        float radius = float(go->GetGOInfo()->capturePoint.radius);

        for (uint8 team = 0; team < 2; ++team)
        {
            GuidSet::iterator next = _Players[team].begin();
            for (GuidSet::iterator itr = _Players[team].begin(); itr != _Players[team].end(); itr = next)
            {
                next = itr;
                ++next;
                if (Player* player = ObjectAccessor::FindPlayer(*itr))
                    if (!go->IsWithinDistInMap(player, radius) || !player->IsOutdoorPvPActive())
                        HandlePlayerLeave(player);
            }
        }

        std::list<Player*> playerList;
        Trinity::AnyPlayerInObjectRangeCheck checker(go, radius);
        Trinity::PlayerListSearcher<Trinity::AnyPlayerInObjectRangeCheck> searcher(go, playerList, checker);
        go->VisitNearbyWorldObject(radius, searcher);

        for (std::list<Player*>::iterator itr = playerList.begin(); itr != playerList.end(); itr++)
            if (Player* player = (*itr))
                if (player->IsOutdoorPvPActive())
                    HandlePlayerEnter(player);

        // get the difference of numbers
        float fact_diff = ((float) _Players[0].size() - (float) _Players[1].size()) * diff / BATTLEFIELD_OBJECTIVE_UPDATE_INTERVAL;
        if (!fact_diff)
            return;

        uint32 Challenger = 0;
        float maxDiff = _MaxSpeed * diff;

        if (fact_diff < 0)
        {
            // horde is in majority, but it's already horde-controlled -> no change
            if (_State == OBJECTIVESTATE_HORDE && _Value <= -_MaxValue)
                return;

            if (fact_diff < -maxDiff)
                fact_diff = -maxDiff;

            Challenger = HORDE;
        }
        else
        {
            // ally is in majority, but it's already ally-controlled -> no change
            if (_State == OBJECTIVESTATE_ALLIANCE && _Value >= _MaxValue)
                return;

            if (fact_diff > maxDiff)
                fact_diff = maxDiff;

            Challenger = ALLIANCE;
        }

        float oldValue = _Value;
        TeamId oldTeam = _Team;

        _OldState = _State;

        _Value += fact_diff;

        if (_Value < -_MinValue)                              // red
        {
            if (_Value < -_MaxValue)
                _Value = -_MaxValue;
            _State = OBJECTIVESTATE_HORDE;
            _Team = TEAM_HORDE;
        }
        else if (_Value > _MinValue)                          // blue
        {
            if (_Value > _MaxValue)
                _Value = _MaxValue;
            _State = OBJECTIVESTATE_ALLIANCE;
            _Team = TEAM_ALLIANCE;
        }
        else if (oldValue * _Value <= 0)                       // grey, go through mid point
        {
            // if challenger is ally, then n->a challenge
            if (Challenger == ALLIANCE)
                _State = OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE;
            // if challenger is horde, then n->h challenge
            else if (Challenger == HORDE)
                _State = OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE;
            _Team = TEAM_NEUTRAL;
        }
        else                                                    // grey, did not go through mid point
        {
            // old phase and current are on the same side, so one team challenges the other
            if (Challenger == ALLIANCE && (_OldState == OBJECTIVESTATE_HORDE || _OldState == OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE))
                _State = OBJECTIVESTATE_HORDE_ALLIANCE_CHALLENGE;
            else if (Challenger == HORDE && (_OldState == OBJECTIVESTATE_ALLIANCE || _OldState == OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE))
                _State = OBJECTIVESTATE_ALLIANCE_HORDE_CHALLENGE;
            _Team = TEAM_NEUTRAL;
        }

        if (_Value != oldValue)
            SendChangePhase();

        if (_OldState != _State)
        {
            if (oldTeam != _Team)
                ChangeTeam(oldTeam);
            ChangeState();
        }
    }
}

void BfCapturePoint::SendChangePhase()
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "BfCapturePoint::SendChangePhase()");
    if (GameObject* go = HashMapHolder<GameObject>::Find(_CapturePoint))
    {
        SendUpdateWorldState(go->GetGOInfo()->capturePoint.worldState1, 1);
        SendUpdateWorldState(go->GetGOInfo()->capturePoint.worldstate2, (uint32) ceil((_Value + _MaxValue) / (2 * _MaxValue) * 100.0f));
        SendUpdateWorldState(go->GetGOInfo()->capturePoint.worldstate3, _NeutralValuePct);
    }
}

void BfCapturePoint::CastToAllPlayers(uint32 spell)
{
    for (uint8 team = 0; team < 2; ++team)
        for (GuidSet::iterator itr = _Players[team].begin(); itr != _Players[team].end(); itr++)
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
                player->CastSpell(player, spell);
}

BattlefieldGroupHandler::BattlefieldGroupHandler(Battlefield* battlefield) : GroupScript("BattlefieldGroupHandler"), bf(battlefield) { }

void BattlefieldGroupHandler::OnDisband(Group *group)
{
    if (group->isBFGroup())
        bf->RemoveGroup(group);
}

void BfCapturePoint::SetCapturePointObject(GameObject* capturePoint)
{
    _CapturePoint = capturePoint->GetGUID();
    capturePoint->SetGoArtKit(_Team == TEAM_ALLIANCE ? GO_ART_KIT_BATTLEFIELD_BANNER_FLAG_ALLIANCE : GO_ART_KIT_BATTLEFIELD_BANNER_FLAG_HORDE);
}
