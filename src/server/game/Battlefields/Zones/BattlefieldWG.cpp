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

#include "ObjectMgr.h"
#include "BattlefieldWG.h"
#include "SpellAuras.h"
#include "ScriptedCreature.h"
#include "Vehicle.h"

bool BattlefieldWG::SetupBattlefield()
{
    _BattleId = BATTLEFIELD_WG;
    _ZoneId = BATTLEFIELD_WG_ZONEID;
    _MapId = BATTLEFIELD_WG_MAPID;

    _MaxPlayers = sWorld->getIntConfig(CONFIG_WINTERGRASP_PLAYER_MAX);
    _MinPlayers = sWorld->getIntConfig(CONFIG_WINTERGRASP_PLAYER_MIN);
    _MinLevel = sWorld->getIntConfig(CONFIG_WINTERGRASP_PLAYER_MIN_LVL);

    _Enable = sWorld->getBoolConfig(CONFIG_WINTERGRASP_ENABLE);
    _BattleTime = sWorld->getWorldState(WG_WORLDSTATE_UI_STATE[0]);
    _DefenderTeam = sWorld->getWorldState(WG_WORLDSTATE_UI_FACTION_CONTROL_STATE[TEAM_HORDE]) ? TEAM_HORDE : TEAM_ALLIANCE;

    _TimeInBattle = sWorld->getIntConfig(CONFIG_WINTERGRASP_TIME_IN_BATTLE) * MINUTE * IN_MILLISECONDS;
    _TimeForBattle = sWorld->getIntConfig(CONFIG_WINTERGRASP_TIME_FOR_BATTLE) * MINUTE * IN_MILLISECONDS;
    _TimeForBattleOnStartup = sWorld->getIntConfig(CONFIG_WINTERGRASP_TIME_ON_STARTUP) * MINUTE * IN_MILLISECONDS;
    _TimeForAcceptInvite = 20 * IN_MILLISECONDS;
    _TimeForInviteToQueue = 15 * MINUTE * IN_MILLISECONDS;
    _TimeForPrepareBattle = MINUTE * IN_MILLISECONDS;

    _Timer = uint32(sWorld->getWorldState(WG_WORLDSTATE_UI_TIMER[0]) ? sWorld->getWorldState(WG_WORLDSTATE_UI_TIMER[0]) : _TimeForBattle);

    for (uint8 i = 0; i < WG_TEAM_MAX; i++)
        sWorld->setWorldState(WG_WORLDSTATE_UI_FACTION_CONTROL_STATE[i], TeamId(i) == _DefenderTeam ? 1 : 0);

    if (_BattleTime || _Timer <= _TimeForBattleOnStartup)
    {
        _BattleTime = false;
        _Timer = _TimeForBattleOnStartup;
    }

    for (uint8 i = 0; i < WG_UI_MISC_MAX; i++)
        sWorld->setWorldState(WG_WORLDSTATE_UI_STATE[i], IsBattleTime() ? !i : i);

    for (uint8 i = 0; i < WG_CLOCK_MAX; i++)
        sWorld->setWorldState(WG_WORLDSTATE_UI_TIMER[i], _Timer);

    RegisterZone(_ZoneId);

    KickPosition[TEAM_ALLIANCE].Relocate(4599.323f, 1639.467f, 280.416f, 0);
    KickPosition[TEAM_HORDE].Relocate(4101.348f, 1753.814f, 195.318f, 0);
    for (uint8 team = 0; team < BF_TEAMS_COUNT; team++)
        KickPosition[team].m_mapId = _MapId;

    UpdateFortressGraveyard();

    for (uint8 team = 0; team < TEAM_NEUTRAL; team++)
        maxVehicles[team] = team == GetDefenderTeam() ? 16 : 8;

    titanRelicGUID = 0;
    doorCollisionGUID = 0;

    for (uint32 i = 0; i < sAreaPOIStore.GetNumRows(); i++)
    {
        const AreaPOIEntry* poiInfo = sAreaPOIStore.LookupEntry(i);
        if (poiInfo && poiInfo->zoneId == BATTLEFIELD_WG_ZONEID)
            areaPOIs.insert(poiInfo);
    }

    LoadGrids();

    return true;
}

void BattlefieldWG::LoadGrids()
{
    Map* map = sMapMgr->CreateBaseMap(_MapId);

    for (uint8 i = 0; i < WG_WORKSHOP_MAX; i++)
        for (AreaPOISet::const_iterator itr = areaPOIs.begin(); itr != areaPOIs.end(); itr++)
            if (const AreaPOIEntry* poiInfo = (*itr))
                if (poiInfo->worldState == WG_WORLDSTATE_WORKSHOP[i])
                    map->LoadGrid(poiInfo->x, poiInfo->y);
}

void BattlefieldWG::FillInitialWorldStates(WorldPacket & data)
{
    for (uint8 i = 0; i < WG_UI_MISC_MAX; i++) // 2
        data << WG_WORLDSTATE_UI_STATE[i] << uint32(IsBattleTime() ? !i : i);

    for (uint8 i = 0; i < WG_UI_MISC_MAX; i++)  // 2
        data << WG_WORLDSTATE_UI_FACTION_CONTROL_STATE[i] << uint32(i == GetDefenderTeam() ? 1 : 0);

    for (uint8 i = 0; i < WG_UI_MISC_MAX; i++)  // 2
        data << WG_WORLDSTATE_UI_TIMER[i] << uint32(time(NULL) + GetTimer() / IN_MILLISECONDS);

    for (uint8 team = 0; team < TEAM_NEUTRAL; team++)  // 2
    {
        data << WG_WORLDSTATE_UI_VEHICLE_MAX[team] << uint32(GetVehicleCount(TeamId(team), true));
        data << WG_WORLDSTATE_UI_VEHICLE_COUNT[team] << uint32(GetVehicleCount(TeamId(team), false));
    }

    for (GameObjectBuildingMap::iterator itr = towers.begin(); itr != towers.end(); itr++) // 3
        data << (*itr).second.worldState << uint32((*itr).second.value);

    for (GameObjectBuildingMap::iterator itr = workshops.begin(); itr != workshops.end(); itr++) // 2
        data << (*itr).second.worldState << uint32((*itr).second.value);

    for (GameObjectBuildingMap::iterator itr = fortressWalls.begin(); itr != fortressWalls.end(); itr++) // 25
        data << (*itr).second.worldState << uint32((*itr).second.value);

    for (GameObjectBuildingMap::iterator itr = fortressTowers.begin(); itr != fortressTowers.end(); itr++) // 4
        data << (*itr).second.worldState << uint32((*itr).second.value);

    for (GameObjectBuildingMap::iterator itr = fortressWorkshops.begin(); itr != fortressWorkshops.end(); itr++) // 2
        data << (*itr).second.worldState << uint32((*itr).second.value);

    for (uint8 i = 0; i < WG_UI_SLIDER_MAX; i++)
        data << WG_WORLDSTATE_UI_SLIDER[i] << uint32(i * 50);
}

void BattlefieldWG::OnSendUpdateWorldState(uint32 field, uint32 value)
{
    switch (field)
    {
        case 3781: // WG_WORLDSTATE_UI_TIMER[0]
        case 4354: // WG_WORLDSTATE_UI_TIMER[1]
            value = GetTimer();
        default:
            sWorld->setWorldState(field, value);
    }
}

void BattlefieldWG::OnCreatureCreate(Creature* creature)
{
    if (!creature)
        return;

    Battlefield::OnCreatureCreate(creature);
    switch (creature->GetEntry())
    {
        case WG_NPC_SIEGE_TURRET_A:
        case WG_NPC_SIEGE_TURRET_H:
            break;
        case WG_NPC_SIEGE_ENGINE_A:
        case WG_NPC_SIEGE_ENGINE_H:
        case WG_NPC_CATAPULT:
        case WG_NPC_DEMOLISHER:
            AddVehicle(creature);
            break;
        case WG_NPC_WATER_REVENANT:
        case WG_NPC_SHADOW_REVENANT:
        case WG_NPC_TEMPEST_REVENANT:
        case WG_NPC_FLAME_REVENANT:
        case WG_NPC_GLACIAL_SPIRIT:
        case WG_NPC_LIVING_LASHER:
        case WG_NPC_MATURE_LASHER:
        case WG_NPC_RAGING_FLAME:
        case WG_NPC_WHISPERING_WIND:
        case WG_NPC_WANDERING_SHADOW:
        case WG_NPC_EARTHBOUND_REVENANT:
        case WG_NPC_CHILLED_EARTH_ELEMENTAL:
            mobs.insert(creature->GetGUID());
            SetVisible(creature, !IsBattleTime());
            break;
        case WG_NPC_CANNON:
            SetVisible(creature, IsBattleTime());

            for (uint8 i = 0; i < WG_TOWER_MAX; i++)
                for (AreaPOISet::const_iterator itr = areaPOIs.begin(); itr != areaPOIs.end(); itr++)
                    if (const AreaPOIEntry* poiInfo = (*itr))
                        if (poiInfo->worldState == WG_WORLDSTATE_TOWER[i] && creature->GetDistance2d(poiInfo->x, poiInfo->y) < 50.0f)
                        {
                            cannons[i].insert(creature->GetGUID());
                            creature->setFaction(WG_FACTION[GetAttackerTeam()]);
                            return;
                        }

            for (uint8 i = 0; i < WG_FORTRESS_TOWER_MAX; i++)
                for (AreaPOISet::const_iterator itr = areaPOIs.begin(); itr != areaPOIs.end(); itr++)
                    if (const AreaPOIEntry* poiInfo = (*itr))
                        if (poiInfo->worldState == WG_WORLDSTATE_FORTRESS_TOWER[i])
                        {
                            if (creature->GetDistance2d(poiInfo->x, poiInfo->y) < 50.0f)
                            {
                                fortressCannons[i].insert(creature->GetGUID());
                                creature->setFaction(WG_FACTION[GetDefenderTeam()]);
                                return;
                            }
                            else
                            {
                                fortressCannons[4].insert(creature->GetGUID());
                                creature->setFaction(WG_FACTION[GetDefenderTeam()]);
                                return;
                            }
                        }
    }
}

void BattlefieldWG::OnCreatureRemove(Creature *creature)
{
    switch (creature->GetEntry())
    {
        case WG_NPC_SIEGE_ENGINE_A:
        case WG_NPC_SIEGE_ENGINE_H:
        case WG_NPC_CATAPULT:
        case WG_NPC_DEMOLISHER:
            RemoveVehicle(creature);
        case WG_NPC_WATER_REVENANT:
        case WG_NPC_SHADOW_REVENANT:
        case WG_NPC_TEMPEST_REVENANT:
        case WG_NPC_GLACIAL_SPIRIT:
        case WG_NPC_WHISPERING_WIND:
        case WG_NPC_WANDERING_SHADOW:
        case WG_NPC_EARTHBOUND_REVENANT:
        case WG_NPC_CHILLED_EARTH_ELEMENTAL:
            mobs.erase(creature->GetGUID());
            break;
        case WG_NPC_CANNON:
            for (uint8 i = 0; i < WG_TOWER_MAX; i++)
                cannons[i].erase(creature->GetGUID());
            for (uint8 i = 0; i < WG_FORTRESS_CANNONS_MAX; i++)
                fortressCannons[i].erase(creature->GetGUID());
            break;
    }
}

void BattlefieldWG::OnGameObjectCreate(GameObject* go)
{
    if (!go)
        return;

    if (go->GetEntry() == WG_GO_TITAN_RELIC)
    {
        titanRelicGUID = go->GetGUID();
        go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
        return;
    }

    if (go->GetEntry() == WG_GO_DOOR_COLLISION)
    {
        doorCollisionGUID = go->GetGUID();
        return;
    }

    if (go->GetEntry() == WG_GO_DOOR_COLLISION2) // De donde salio esta?
    {
        go->SetPhaseMask(2, true);
        return;
    }

    if (go->GetGoType() == GAMEOBJECT_TYPE_CAPTURE_POINT)
    {
        for (uint8 i = 0; i < WG_WORKSHOP_MAX; i++)
            if (go->GetEntry() == WG_GO_WORKSHOP_BANNER[i])
            {
                bool founded = false;
                for (CapturePointMap::iterator itr = _CapturePoints.begin(); itr != _CapturePoints.end(); itr++)
                    if ((*itr).first == i)
                    {
                        (*itr).second->SetCapturePointObject(go);
                        founded = true;
                        break;
                    }

                if (!founded)
                    AddCapturePoint(new BfCapturePointWG(this, go, i < 2 ? GetDefenderTeam() : GetAttackerTeam()), i);

                break;
            }
        return;
    }

    for (uint8 i = 0; i < WG_FORTRESS_TELE_MAX; i++)
        if (go->GetEntry() == WG_GO_FORTRESS_TELE[i])
        {
            fortressTeleports[i].insert(go->GetGUID());
            go->SetUInt32Value(GAMEOBJECT_FACTION, WG_FACTION[GetDefenderTeam()]);
            break;
        }

    if (!go->IsDestructibleBuilding())
        return;

    WorldState ws;
    ws.value = STATE_NONE;
    ws.worldState = 0;
    bool found = false;

    for (uint8 i = 0; i < WG_TOWER_MAX; i++)
        if (go->GetEntry() == WG_GO_TOWER[i])
        {
            go->SetUInt32Value(GAMEOBJECT_FACTION, WG_FACTION[GetAttackerTeam()]);
            ws.worldState = WG_WORLDSTATE_TOWER[i];
            ws.value = GetAttackerTeam() ? STATE_HORDE_INTACT : STATE_ALLIANCE_INTACT;
            towers[go->GetGUID()] = ws;
            found = true;
            break;
        }

    if (!found)
        for (uint8 i = 0; i < WG_WORKSHOP_MAX; i++)
            if (go->GetEntry() == WG_GO_WORKSHOP[i])
            {
                go->SetUInt32Value(GAMEOBJECT_FACTION, WG_FACTION[TEAM_NEUTRAL]);
                ws.worldState = WG_WORLDSTATE_WORKSHOP[i];
                ws.value = i < 2 ? (GetDefenderTeam() ? STATE_HORDE_INTACT : STATE_ALLIANCE_INTACT) : (GetAttackerTeam() ? STATE_HORDE_INTACT : STATE_ALLIANCE_INTACT);
                workshops[go->GetGUID()] = ws;
                found = true;
                break;
            }

    if (!found)
        for (uint8 i = 0; i < WG_FORTRESS_TOWER_MAX; i++)
            if (go->GetEntry() == WG_GO_FORTRESS_TOWER[i])
            {
                go->SetUInt32Value(GAMEOBJECT_FACTION, WG_FACTION[GetDefenderTeam()]);
                ws.worldState = WG_WORLDSTATE_FORTRESS_TOWER[i];
                ws.value = GetDefenderTeam() ? STATE_HORDE_INTACT : STATE_ALLIANCE_INTACT;
                fortressTowers[go->GetGUID()] = ws;
                break;
            }

    if (!found)
        for (uint8 i = 0; i < WG_FORTRESS_WALL_MAX; i++)
            if (go->GetEntry() == WG_GO_FORTRESS_WALL[i])
            {
                if (i == 24)
                    mainDoorGUID = go->GetGUID();

                go->SetUInt32Value(GAMEOBJECT_FACTION, WG_FACTION[GetDefenderTeam()]);
                ws.worldState = WG_WORLDSTATE_FORTRESS_WALL[i];
                ws.value = GetDefenderTeam() ? STATE_HORDE_INTACT : STATE_ALLIANCE_INTACT;
                fortressWalls[go->GetGUID()] = ws;
                found = true;
                break;
            }

    if (!found)
        for (uint8 i = 0; i < WG_FORTRESS_WORKSHOP_MAX; i++)
            if (go->GetEntry() == WG_GO_FORTRESS_WORKSHOP[i])
            {
                go->SetUInt32Value(GAMEOBJECT_FACTION, WG_FACTION[TEAM_NEUTRAL]);
                ws.worldState = WG_WORLDSTATE_FORTRESS_WORKSHOP[i];
                ws.value = GetDefenderTeam() ? STATE_HORDE_INTACT : STATE_ALLIANCE_INTACT;
                fortressWorkshops[go->GetGUID()] = ws;
                found = true;

                for (CapturePointMap::iterator itr = _CapturePoints.begin(); itr != _CapturePoints.end(); itr++)
                    if ((*itr).first == i)
                    {
                        BfCapturePointWG* cp = (BfCapturePointWG*)(*itr).second;
                        cp->ClearWorkshopGUID();
                        break;
                    }

                break;
            }

    if (go->GetDestructibleState() != GO_DESTRUCTIBLE_INTACT)
        go->SetDestructibleState(GO_DESTRUCTIBLE_REBUILDING, NULL, true);

    if (ws.worldState && ws.value)
        SendUpdateWorldState(ws.worldState, ws.value);
}

void BattlefieldWG::OnPlayerEnterZone(Player* player)
{
    if (!HasPlayerInBattle(player))
        return;

    InstallPlayer(player);
}

void BattlefieldWG::OnPlayerJoinBattle(Player* player)
{
    if (player->GetZoneId() != _ZoneId)
    {
        if (player->GetTeamId() == GetDefenderTeam())
            player->TeleportTo(571, 5345, 2842, 410, 3.14f);
        else
            player->GetTeamId() ? player->TeleportTo(571, 5025.857422f, 3674.628906f, 362.737122f, 4.135169f) : player->TeleportTo(571, 5101.284f, 2186.564f, 373.549f, 3.812f);
    }
    else
        InstallPlayer(player);
}

void BattlefieldWG::InstallPlayer(Player* player)
{
    // Removemos monturas voladoras y/o auras
    if (player->HasAuraType(SPELL_AURA_FLY) || player->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED) || player->IsFlying() || player->IsFalling())
    {
        bool flying = player->IsMounted() && (player->IsFlying() || player->IsFalling());

        if (player->IsMounted())
            player->Dismount();

        player->RemoveAurasByType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED);
        player->RemoveAurasByType(SPELL_AURA_FLY);
        player->RemoveAurasDueToSpell(WG_SPELL_SWIFT_FLIGHT_FORM);
        player->RemoveAurasDueToSpell(WG_SPELL_FLIGHT_FORM);

        if (flying)
        {
            player->StopMoving(); // Evita que el paracaidas se ejecute con trayectoria angular
            player->AddAura(WG_SPELL_PARACHUTE, player);
        }
    }

    // Removemos auras (por si a caso)
    player->RemoveAurasDueToSpell(WG_SPELL_ESSENCE_OF_WINTERGRASP);
    player->RemoveAurasDueToSpell(WG_SPELL_RECRUIT);
    player->RemoveAurasDueToSpell(WG_SPELL_CORPORAL);
    player->RemoveAurasDueToSpell(WG_SPELL_LIEUTENANT);
    player->RemoveAurasDueToSpell(WG_SPELL_TOWER_CONTROL);
    player->RemoveAurasDueToSpell(WG_SPELL_SPIRITUAL_IMMUNITY);
    player->RemoveAurasDueToSpell(WG_SPELL_TENACITY);
    player->RemoveAurasDueToSpell(WG_SPELL_GREAT_HONOR);
    player->RemoveAurasDueToSpell(WG_SPELL_GREATER_HONOR);
    player->RemoveAurasDueToSpell(WG_SPELL_GREATEST_HONOR);
    player->RemoveAurasDueToSpell(WG_SPELL_TOWER_CONTROL);
    player->RemoveAurasDueToSpell(WG_SPELL_WINTERGRASP_RESTRICTED_FLIGHT_AREA);
    player->RemoveAurasDueToSpell(WG_SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT);
    player->RemoveAurasDueToSpell(WG_SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT);
    player->RemoveAurasDueToSpell(WG_SPELL_ALLIANCE_CONTROL_PHASE_SHIFT);
    player->RemoveAurasDueToSpell(WG_SPELL_HORDE_CONTROL_PHASE_SHIFT);

    // Aplicamos grado Recluta
    player->CastSpell(player, WG_SPELL_RECRUIT, true);

    uint32 brokenTowers = 0;
    for (GameObjectBuildingMap::iterator itr = towers.begin(); itr != towers.end(); itr++)
        if ((*itr).second.value == STATE_ALLIANCE_DESTROY || (*itr).second.value == STATE_HORDE_DESTROY)
            brokenTowers++;

    // Aura Control Tower
    if (player->GetTeamId() == GetAttackerTeam())
    {
        if (brokenTowers < 3)
            player->SetAuraStack(WG_SPELL_TOWER_CONTROL, player, 3 - brokenTowers);
    }
    else
    {
        if (brokenTowers > 0)
            player->SetAuraStack(WG_SPELL_TOWER_CONTROL, player, brokenTowers);
    }

    // Actualizamos la tenacidad
    UpdateTenacity();
}

void BattlefieldWG::OnPlayerLeaveBattle(Player* player)
{
    UninstallPlayer(player, IsBattleTime());
}

void BattlefieldWG::OnPlayerLeaveZone(Player* player)
{
    // Cuando es la batalla UninstallPlayer es ejecutado por OnPlayerLeaveBattle
    if (!IsBattleTime())
        UninstallPlayer(player);
}

void BattlefieldWG::UninstallPlayer(Player* player, bool dismount)
{
    // Removemos todas las auras
    player->RemoveAurasDueToSpell(WG_SPELL_ESSENCE_OF_WINTERGRASP);
    player->RemoveAurasDueToSpell(WG_SPELL_RECRUIT);
    player->RemoveAurasDueToSpell(WG_SPELL_CORPORAL);
    player->RemoveAurasDueToSpell(WG_SPELL_LIEUTENANT);
    player->RemoveAurasDueToSpell(WG_SPELL_TOWER_CONTROL);
    player->RemoveAurasDueToSpell(WG_SPELL_SPIRITUAL_IMMUNITY);
    player->RemoveAurasDueToSpell(WG_SPELL_TENACITY);
    player->RemoveAurasDueToSpell(WG_SPELL_GREAT_HONOR);
    player->RemoveAurasDueToSpell(WG_SPELL_GREATER_HONOR);
    player->RemoveAurasDueToSpell(WG_SPELL_GREATEST_HONOR);
    player->RemoveAurasDueToSpell(WG_SPELL_TOWER_CONTROL);
    player->RemoveAurasDueToSpell(WG_SPELL_WINTERGRASP_RESTRICTED_FLIGHT_AREA);
    player->RemoveAurasDueToSpell(WG_SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT);
    player->RemoveAurasDueToSpell(WG_SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT);
    player->RemoveAurasDueToSpell(WG_SPELL_ALLIANCE_CONTROL_PHASE_SHIFT);
    player->RemoveAurasDueToSpell(WG_SPELL_HORDE_CONTROL_PHASE_SHIFT);

    // Actualizamos la tenacidad
    UpdateTenacity();

    // Expulsamos del vehiculo al jugador si la batalla esta en curso,
    // pues solo en este caso el jugador fue expulsado de la batalla.
    if (dismount)
    {
        if (Vehicle* vehicle = player->GetVehicle())
        {
            switch (vehicle->GetBase()->GetEntry())
            {
                case WG_NPC_SIEGE_TURRET_A:
                case WG_NPC_SIEGE_TURRET_H:
                case WG_NPC_SIEGE_ENGINE_A:
                case WG_NPC_SIEGE_ENGINE_H:
                case WG_NPC_CATAPULT:
                case WG_NPC_DEMOLISHER:
                    vehicle->RemovePassenger(player);
                    break;
            }
        }
    }
}

void BattlefieldWG::OnSetBattlefieldState(BattlefieldStates state)
{
    // GetDefenderTeam() y GetAttackerTeam() se actualizan despues de esta funcion
    switch (state)
    {
        case BATTLEFIELD_WAIT:
            break;
        case BATTLEFIELD_PREPARE:   // Minuto previo al inicio de la batalla
            PrepareZoneForBattle();
            break;
        case BATTLEFIELD_START:     // Cuando se inicia la batalla
            SendWarningToAll(WG_LANG_TO_BEGUN);
            break;
        case BATTLEFIELD_SUCCESS:   // Cuando ejecutan el orbe de la fortaleza
        case BATTLEFIELD_FAILURE:   // Cuando el tiempo de la batalla ha finalizado
            bool captured = (state == BATTLEFIELD_SUCCESS);

            if (GameObject* doorCollision = HashMapHolder<GameObject>::Find(doorCollisionGUID))
                doorCollision->SetPhaseMask((captured ? GetAttackerTeam() : GetDefenderTeam()) == TEAM_HORDE ? WG_PHASEMASK_ALLIANCE_CONTROL : WG_PHASEMASK_HORDE_CONTROL, true);

            for (uint8 i = 0; i < WG_TEAM_MAX; i++)
                for (GuidSet::iterator itr = vehicles[i].begin(); itr != vehicles[i].end(); itr++)
                    if (Creature* vehicle = HashMapHolder<Creature>::Find((*itr)))
                        vehicle->DespawnOrUnsummon(MINUTE * IN_MILLISECONDS);

            RewardPlayers(captured);
            UpdateMaxVehicle((captured ? GetAttackerTeam() : GetDefenderTeam()), true);
            SendWarningToAll(captured ? WG_LANG_TAKEN : WG_LANG_DEFENDED, WG_LANG_FORTRES, WG_LANG_TEAM[(captured ? GetAttackerTeam() : GetDefenderTeam())]);
            break;
    }
}

void BattlefieldWG::OnUpdate(uint32 diff)
{
    GameObject* mainDoor = HashMapHolder<GameObject>::Find(mainDoorGUID);

    for (uint8 team = 0; team < BF_TEAMS_COUNT; team++)
        for (GuidSet::iterator itr = _Players[team].begin(); itr != _Players[team].end(); itr++)
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
            {
                // If the Wintergrasp Door is not destroyed yet
                if (mainDoor && (!IsBattleTime() || mainDoor->GetDestructibleState() == GO_DESTRUCTIBLE_DAMAGED || mainDoor->GetDestructibleState() == GO_DESTRUCTIBLE_INTACT))
                {
                    // Players in Room
                    float x, y, z;
                    player->GetPosition(x, y, z);
                    if ((!player->GetMap()->IsOutdoors(x, y, z) && 5500 > x && x > 5400 && y < 2880 && y > 2800 && z < 480) && (IsBattleTime() || (!IsBattleTime() && player->GetTeamId() == GetAttackerTeam())))
                        player->TeleportTo(571, 5349.8686f, 2838.481f, 409.240f, 0.046328f);
                }

                if (!IsBattleTime())
                    continue;

                if (player->HasAura(WG_SPELL_SPIRITUAL_IMMUNITY))
                {
                    const WorldSafeLocsEntry* graveyard = sObjectMgr->GetClosestGraveYard(player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), player->GetMapId(), player->GetTeam());
                    if (graveyard)
                        if (player->GetDistance2d(graveyard->x, graveyard->y) > 20.0f)
                            player->RemoveAurasDueToSpell(WG_SPELL_SPIRITUAL_IMMUNITY);
                }
            }

    if (!IsBattleTime())
        return;

    // Hack fix para evitar cannons fuera de lugar
    for (uint8 i = 0; i < WG_TOWER_MAX; i++)
        for (GuidSet::iterator itr = cannons[i].begin(); itr != cannons[i].end(); itr++)
            if (Creature* cannon = HashMapHolder<Creature>::Find((*itr)))
            {
                if (!cannon->IsWithinDist3d(cannon->GetPositionX(), cannon->GetPositionY(), cannon->GetPositionZ(), CONTACT_DISTANCE))
                    cannon->NearTeleportTo(cannon->GetPositionX(), cannon->GetPositionY(), cannon->GetPositionZ(), cannon->GetOrientation());
            }

    for (uint8 team = 0; team < TEAM_NEUTRAL; team++)
        for (GuidSet::iterator itr = vehicles[team].begin(); itr != vehicles[team].end(); itr++)
            if (Creature* creature = HashMapHolder<Creature>::Find((*itr)))
            {
                // Queue to enter into vehicle
                if (vehicleQueue[(*itr)])
                {
                    if (vehicleQueue[(*itr)] <= diff)
                    {
                        creature->ToTempSummon()->GetSummoner()->ToPlayer()->CastSpell(creature, WG_SPELL_RIDE_VEHICLE, true);
                        vehicleQueue.erase((*itr));
                    } else vehicleQueue[(*itr)] -= diff;
                }

                if (creature->IsInWater() && !creature->HasAura(WG_SPELL_WINTERGRASP_WATER))
                    creature->AddAura(WG_SPELL_WINTERGRASP_WATER, creature);
                if (!creature->IsInWater() && creature->HasAura(WG_SPELL_WINTERGRASP_WATER))
                    creature->RemoveAurasDueToSpell(WG_SPELL_WINTERGRASP_WATER);
            }

    // Vehicle Teleport
    for (GuidSet::iterator itr = fortressTeleports[1].begin(); itr != fortressTeleports[1].end(); itr++)
        if (GameObject* teleport = HashMapHolder<GameObject>::Find(*itr))
            for (uint8 i = 0; i < 4; i++)
                if (Creature* vehicle = teleport->FindNearestCreature(WG_NPC_VEHICLES[i], 3.0f, true))
                {
                    Creature * trigger = NULL;
                    std::list<Creature*> triggers;
                    teleport->GetCreatureListWithEntryInGrid(triggers, WG_NPC_TRIGGER, 55.0f);
                    for (std::list<Creature*>::iterator itr = triggers.begin(); itr != triggers.end(); ++itr)
                        if (trigger == NULL || (*itr)->GetDistance(teleport) > trigger->GetDistance(teleport))
                            trigger = (*itr);

                    if (!vehicle->HasAura(WG_SPELL_VEHICLE_TELEPORT))
                        trigger->CastSpell(vehicle, WG_SPELL_VEHICLE_TELEPORT, true);
                }
}

void BattlefieldWG::PrepareZoneForBattle()
{
    LoadGrids();

    WorldState ws;
    ws.value = STATE_NONE;
    ws.worldState = 0;

    for (GameObjectBuildingMap::iterator itr = towers.begin(); itr != towers.end(); itr++)
        if (GameObject* go = HashMapHolder<GameObject>::Find((*itr).first))
        {
            go->SetDestructibleState(GO_DESTRUCTIBLE_REBUILDING, NULL, true);
            go->SetUInt32Value(GAMEOBJECT_FACTION, WG_FACTION[GetAttackerTeam()]);
            ws.worldState = (*itr).second.worldState;
            ws.value = GetAttackerTeam() ? STATE_HORDE_INTACT : STATE_ALLIANCE_INTACT;
            towers[go->GetGUID()] = ws;
            if (ws.worldState && ws.value)
                SendUpdateWorldState(ws.worldState, ws.value);;
        }

    for (GameObjectBuildingMap::iterator itr = workshops.begin(); itr != workshops.end(); itr++)
        if (GameObject* go = HashMapHolder<GameObject>::Find((*itr).first))
            for (uint8 i = 0; i < WG_WORKSHOP_MAX; i++)
                if (go->GetEntry() == WG_GO_WORKSHOP[i])
                {
                    go->SetUInt32Value(GAMEOBJECT_FACTION, WG_FACTION[TEAM_NEUTRAL]);
                    ws.worldState = (*itr).second.worldState;
                    if (i < 2)
                        ws.value = GetDefenderTeam() ? STATE_HORDE_INTACT : STATE_ALLIANCE_INTACT;
                    else
                        ws.value = GetAttackerTeam() ? STATE_HORDE_INTACT : STATE_ALLIANCE_INTACT;
                    workshops[go->GetGUID()] = ws;
                    if (ws.worldState && ws.value)
                        SendUpdateWorldState(ws.worldState, ws.value);
                }

    for (GameObjectBuildingMap::iterator itr = fortressWalls.begin(); itr != fortressWalls.end(); itr++)
        if (GameObject* go = HashMapHolder<GameObject>::Find((*itr).first))
        {
            go->SetDestructibleState(GO_DESTRUCTIBLE_REBUILDING, NULL, true);
            go->SetUInt32Value(GAMEOBJECT_FACTION, WG_FACTION[GetDefenderTeam()]);
            ws.worldState = (*itr).second.worldState;
            ws.value = GetDefenderTeam() ? STATE_HORDE_INTACT : STATE_ALLIANCE_INTACT;
            fortressWalls[go->GetGUID()] = ws;
            if (ws.worldState && ws.value)
                SendUpdateWorldState(ws.worldState, ws.value);
        }

    for (GameObjectBuildingMap::iterator itr = fortressTowers.begin(); itr != fortressTowers.end(); itr++)
        if (GameObject* go = HashMapHolder<GameObject>::Find((*itr).first))
        {
            go->SetDestructibleState(GO_DESTRUCTIBLE_REBUILDING, NULL, true);
            go->SetUInt32Value(GAMEOBJECT_FACTION, WG_FACTION[GetDefenderTeam()]);
            ws.worldState = (*itr).second.worldState;
            ws.value = GetDefenderTeam() ? STATE_HORDE_INTACT : STATE_ALLIANCE_INTACT;
            fortressTowers[go->GetGUID()] = ws;
            if (ws.worldState && ws.value)
                SendUpdateWorldState(ws.worldState, ws.value);
        }

    for (GameObjectBuildingMap::iterator itr = fortressWorkshops.begin(); itr != fortressWorkshops.end(); itr++)
        if (GameObject* go = HashMapHolder<GameObject>::Find((*itr).first))
        {
            go->SetUInt32Value(GAMEOBJECT_FACTION, WG_FACTION[TEAM_NEUTRAL]);
            ws.worldState = (*itr).second.worldState;
            ws.value = GetDefenderTeam() ? STATE_HORDE_INTACT : STATE_ALLIANCE_INTACT;
            fortressWorkshops[go->GetGUID()] = ws;
            if (ws.worldState && ws.value)
                SendUpdateWorldState(ws.worldState, ws.value);
        }
}

void BattlefieldWG::UpdateCannons()
{
    for (uint8 i = 0; i < WG_TOWER_MAX; i++)
        for (GuidSet::iterator itr = cannons[i].begin(); itr != cannons[i].end(); itr++)
            if (Creature* cannon = HashMapHolder<Creature>::Find((*itr)))
            {
                SetVisible(cannon, IsBattleTime());
                cannon->setFaction(WG_FACTION[GetAttackerTeam()]);
            }

    for (uint8 i = 0; i < WG_FORTRESS_CANNONS_MAX; i++)
        for (GuidSet::iterator itr = fortressCannons[i].begin(); itr != fortressCannons[i].end(); itr++)
            if (Creature* cannon = HashMapHolder<Creature>::Find((*itr)))
            {
                SetVisible(cannon, IsBattleTime());
                cannon->setFaction(WG_FACTION[GetDefenderTeam()]);
            }
}

void BattlefieldWG::UpdateMobs()
{
    for (GuidSet::iterator itr = mobs.begin(); itr != mobs.end(); itr++)
        if (Creature* creature = HashMapHolder<Creature>::Find((*itr)))
            SetVisible(creature, !IsBattleTime());
}

void BattlefieldWG::UpdateTeleports()
{
    for (uint8 i = 0; i < WG_FORTRESS_TELE_MAX; i++)
        for (GuidSet::iterator itr = fortressTeleports[i].begin(); itr != fortressTeleports[i].end(); itr++)
            if (GameObject* go = HashMapHolder<GameObject>::Find((*itr)))
                go->SetUInt32Value(GAMEOBJECT_FACTION, WG_FACTION[GetDefenderTeam()]);
}

void BattlefieldWG::UpdateTitanRelic()
{
    if (GameObject* titanRelic = HashMapHolder<GameObject>::Find(titanRelicGUID))
    {
        titanRelic->SetUInt32Value(GAMEOBJECT_FACTION, WG_FACTION[GetAttackerTeam()]);
        titanRelic->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
    }
}

void BattlefieldWG::UpdateFortressGraveyard()
{
    sObjectMgr->RemoveGraveYardLink(WG_GRAVEYARD[6], GetZoneId(), HORDE, false);
    sObjectMgr->RemoveGraveYardLink(WG_GRAVEYARD[6], GetZoneId(), ALLIANCE, false);
    sObjectMgr->RemoveGraveYardLink(WG_GRAVEYARD[6], GetZoneId(), TEAM_OTHER, false);

    sObjectMgr->AddGraveYardLink(WG_GRAVEYARD[6], GetZoneId(), GetDefenderTeam() == TEAM_ALLIANCE ? ALLIANCE : HORDE, false);
}

void BattlefieldWG::RewardPlayers(bool captured)
{
    bool damagedBuilding = false;
    uint32 brokenTowers[WG_TEAM_MAX];
    uint32 damagedTowers[WG_TEAM_MAX];
    for (uint8 team = 0; team < WG_TEAM_MAX; team++)
    {
        brokenTowers[team] = 0;
        damagedTowers[team] = 0;
    }

    // Si fue capturado al menos la puerta del orbe fue dañada
    if (!captured)
    {
        // Revisamos si hay objetos dañados
        for (GameObjectBuildingMap::iterator itr = fortressWalls.begin(); itr != fortressWalls.end(); itr++)
            if (HashMapHolder<GameObject>::Find((*itr).first))
            {
                if ((*itr).second.value == STATE_ALLIANCE_DESTROY ||
                    (*itr).second.value == STATE_ALLIANCE_DAMAGE ||
                    (*itr).second.value == STATE_HORDE_DESTROY ||
                    (*itr).second.value == STATE_HORDE_DAMAGE)
                {
                    damagedBuilding = true;
                    break;
                }
            }
    }

    // Contamos las torres destruidas y dañadas de la fortaleza
    for (GameObjectBuildingMap::iterator itr = fortressTowers.begin(); itr != fortressTowers.end(); itr++)
        if ((*itr).second.value == STATE_ALLIANCE_DAMAGE || (*itr).second.value == STATE_HORDE_DAMAGE)
            damagedTowers[GetDefenderTeam()]++;
        else if ((*itr).second.value == STATE_ALLIANCE_DESTROY || (*itr).second.value == STATE_HORDE_DESTROY)
            brokenTowers[GetDefenderTeam()]++;

    // Contamos las torres destruidas y dañadas del atacante
    for (GameObjectBuildingMap::iterator itr = towers.begin(); itr != towers.end(); itr++)
        if ((*itr).second.value == STATE_ALLIANCE_DAMAGE || (*itr).second.value == STATE_HORDE_DAMAGE)
            damagedTowers[GetAttackerTeam()]++;
        else if ((*itr).second.value == STATE_ALLIANCE_DESTROY || (*itr).second.value == STATE_HORDE_DESTROY)
            brokenTowers[GetAttackerTeam()]++;

    // Ciclo de premacion
    for (uint8 team = 0; team < TEAM_NEUTRAL; team++)
        for (GuidSet::iterator itr = _PlayersInBattle[team].begin(); itr != _PlayersInBattle[team].end(); itr++)
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
            {
                if (GetAttackerTeam() == team)
                {
                    if (captured)
                    {
                        player->CastSpell(player, WG_SPELL_VICTORY_REWARD);
                        player->CastSpell(player, WG_SPELL_DAMAGED_BUILDING);

                        // Completamos objetivo de "Victoria en Wintergrasp"
                        IncrementQuest(player, WG_QUEST[player->GetTeamId()][1], NULL, NULL, true);
                    }
                    else
                    {
                        player->CastSpell(player, WG_SPELL_DEFEAT_REWARD);
                        if (damagedBuilding)
                            player->CastSpell(player, WG_SPELL_DAMAGED_BUILDING);
                    }

                    if (damagedTowers[GetDefenderTeam()])
                        for (uint8 i = 0; i < damagedTowers[GetDefenderTeam()]; i++)
                            player->CastSpell(player, WG_SPELL_DAMAGED_TOWER);

                    if (brokenTowers[GetDefenderTeam()])
                        for (uint8 i = 0; i < brokenTowers[GetDefenderTeam()]; i++)
                            player->CastSpell(player, WG_SPELL_DESTROYED_TOWER);
                }
                else
                {
                    if (!captured)
                    {
                        player->CastSpell(player, WG_SPELL_VICTORY_REWARD);
                        if (!damagedBuilding)
                            player->CastSpell(player, WG_SPELL_INTACT_BUILDING);
                    }
                    else
                        player->CastSpell(player, WG_SPELL_DEFEAT_REWARD);

                    if (damagedTowers[GetAttackerTeam()])
                        for (uint8 i = 0; i < damagedTowers[GetAttackerTeam()]; i++)
                            player->CastSpell(player, WG_SPELL_DAMAGED_TOWER);

                    if (brokenTowers[GetAttackerTeam()])
                        for (uint8 i = 0; i < brokenTowers[GetAttackerTeam()]; i++)
                            player->CastSpell(player, WG_SPELL_DESTROYED_TOWER);
                }

                UninstallPlayer(player);
            }
}

void BattlefieldWG::OnPlayerKill(Player* killer, Unit* victim)
{
    if (!killer || !victim || killer == victim)
        return;

    if (victim->GetTypeId() == TYPEID_PLAYER)
    {
        IncrementQuest(killer, WG_QUEST[killer->GetTeamId()][4], victim);
        IncrementQuest(killer, WG_QUEST[killer->GetTeamId()][5], victim);

        if (IsBattleTime() && HasPlayerInBattle(killer))
            PromotePlayerArea(killer);
    }
    else
    {
        switch (victim->GetEntry())
        {
            case WG_NPC_SIEGE_ENGINE_A:
            case WG_NPC_SIEGE_ENGINE_H:
            case WG_NPC_CATAPULT:
            case WG_NPC_DEMOLISHER:
                if (IsBattleTime())
                    IncrementQuest(killer, WG_QUEST[killer->GetTeamId()][0], victim);
                break;
            case WG_NPC_VIERON_BLAZEFEATHER:
            case WG_NPC_STONE_GUARD_MUKAR:
            case WG_NPC_HOODOO_MASTER_FUJIN:
            case WG_NPC_COMMANDER_DARDOSH:
            case WG_NPC_TACTICAL_OFFICER_KILRATH:
            case WG_NPC_SIEGESMITH_STRONGHOOF:
            case WG_NPC_PRIMALIST_MULFORT:
            case WG_NPC_LIEUTENANT_MURP:
            case WG_NPC_GUARD_H:
            case WG_NPC_BOWYER_RANDOLPH:
            case WG_NPC_KNIGHT_DAMERON:
            case WG_NPC_SORCERESS_KAYLANA:
            case WG_NPC_COMMANDER_ZANNETH:
            case WG_NPC_TACTICAL_OFFICER_AHBRAMIS:
            case WG_NPC_SIEGE_MASTER_STOUTHANDLE:
            case WG_NPC_ANCHORITE_TESSA:
            case WG_NPC_SENIOR_DEMOLITIONIST_LEGOSO:
            case WG_NPC_GUARD_A:
                IncrementQuest(killer, WG_QUEST[killer->GetTeamId()][4], victim);
                IncrementQuest(killer, WG_QUEST[killer->GetTeamId()][5], victim);
                if (IsBattleTime() && HasPlayerInBattle(killer))
                    PromotePlayerArea(killer);
                break;
        }
    }
}

void BattlefieldWG::PromotePlayerArea(Player* killer)
{
    TeamId team = killer->GetTeamId();
    for (GuidSet::iterator itr = _PlayersInBattle[team].begin(); itr != _PlayersInBattle[team].end(); itr++)
        if (Player* player = ObjectAccessor::FindPlayer(*itr))
            if (player->IsWithinDist(killer, sWorld->getFloatConfig(CONFIG_GROUP_XP_DISTANCE), false))
                PromotePlayer(player);
}

void BattlefieldWG::PromotePlayer(Player* killer)
{
    if (!IsBattleTime())
        return;

    // Updating rank of player
    if (Aura* aur = killer->GetAura(WG_SPELL_RECRUIT))
    {
        if (aur->GetStackAmount() >= 5)     // 7 or more TODO:
        {
            killer->RemoveAura(WG_SPELL_RECRUIT);
            killer->CastSpell(killer, WG_SPELL_CORPORAL, true);
            SendWarning(killer, WG_LANG_FIRSTRANK);
        }
        else
            killer->CastSpell(killer, WG_SPELL_RECRUIT, true);
    }
    else if (Aura* aur = killer->GetAura(WG_SPELL_CORPORAL))
    {
        if (aur->GetStackAmount() >= 5)     // 7 or more TODO:
        {
            killer->RemoveAura(WG_SPELL_CORPORAL);
            killer->CastSpell(killer, WG_SPELL_LIEUTENANT, true);
            SendWarning(killer, WG_LANG_SECONDRANK);
        }
        else
            killer->CastSpell(killer, WG_SPELL_CORPORAL, true);
    }
}

void BattlefieldWG::EventPlayerDamagedGO(Player* player, GameObject* go, uint32 eventType)
{
    if (!go || !eventType || !IsBattleTime())
        return;

    WorldState ws;
    ws.value = STATE_NONE;
    ws.worldState = 0;

    if (eventType == go->GetGOInfo()->building.damagedEvent)
        ws.value = player->GetTeamId() ? STATE_ALLIANCE_DAMAGE : STATE_HORDE_DAMAGE;
    else if (eventType == go->GetGOInfo()->building.destroyedEvent)
        ws.value = player->GetTeamId() ? STATE_ALLIANCE_DESTROY : STATE_HORDE_DESTROY;

    if (!ws.value)
        return;

    for (uint8 i = 0; i < WG_TOWER_MAX; i++)
        if (go->GetEntry() == WG_GO_TOWER[i])
        {
            ws.worldState = towers[go->GetGUID()].worldState;
            towers[go->GetGUID()] = ws;
            if (ws.value == STATE_ALLIANCE_DAMAGE || ws.value == STATE_HORDE_DAMAGE)
                SendWarningToAll(WG_LANG_DAMAGE, WG_LANG_TOWER[i]);
            else if (ws.value == STATE_ALLIANCE_DESTROY || ws.value == STATE_HORDE_DESTROY)
            {
                SendWarningToAll(WG_LANG_DESTROY, WG_LANG_TOWER[i]);
                OnDestroyedTower(i);
            }
            break;
        }

    if (!ws.worldState)
        for (uint8 i = 0; i < WG_FORTRESS_TOWER_MAX; i++)
            if (go->GetEntry() == WG_GO_FORTRESS_TOWER[i])
            {
                ws.worldState = fortressTowers[go->GetGUID()].worldState;
                fortressTowers[go->GetGUID()] = ws;
                if (ws.value == STATE_ALLIANCE_DAMAGE || ws.value == STATE_HORDE_DAMAGE)
                    SendWarningToAll(WG_LANG_DAMAGE, WG_LANG_FORTRESS_TOWER[i]);
                else if (ws.value == STATE_ALLIANCE_DESTROY || ws.value == STATE_HORDE_DESTROY)
                {
                    SendWarningToAll(WG_LANG_DESTROY, WG_LANG_FORTRESS_TOWER[i]);
                    OnDestroyedFortressTower(i);
                }
                break;
            }

    if (!ws.worldState)
        for (uint8 i = 0; i < WG_FORTRESS_WALL_MAX; i++)
            if (go->GetEntry() == WG_GO_FORTRESS_WALL[i])
            {
                ws.worldState = fortressWalls[go->GetGUID()].worldState;
                fortressWalls[go->GetGUID()] = ws;
                if (go->GetEntry() == WG_GO_FORTRESS_WALL[24])
                {
                    if (ws.value == STATE_ALLIANCE_DAMAGE || ws.value == STATE_HORDE_DAMAGE)
                        SendWarningToAll(WG_LANG_DAMAGE, WG_LANG_FORTRES);
                    if (ws.value == STATE_ALLIANCE_DESTROY || ws.value == STATE_HORDE_DESTROY)
                    {
                        if (GameObject* titanRelic = HashMapHolder<GameObject>::Find(titanRelicGUID))
                            titanRelic->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
                        if (GameObject* doorCollision = HashMapHolder<GameObject>::Find(doorCollisionGUID))
                            doorCollision->SetPhaseMask(WG_PHASEMASK_INVISIBLE, true);
                        SendWarningToAll(WG_LANG_DESTROY, WG_LANG_FORTRES);
                    }
                }
                else
                    SendWarningToAll(WG_LANG_ATTACK, WG_LANG_FORTRES, WG_LANG_TEAM[player->GetTeamId()]);
                break;
            }

    if (!ws.worldState)
        return;

    SendUpdateWorldState(ws.worldState, ws.value);
}

void BattlefieldWG::EventPlayerUsedGO(Player* /*player*/, GameObject* go)
{
    if (!IsBattleTime() || go->GetEntry() != WG_GO_TITAN_RELIC)
        return;

    SetBattlefieldState(BATTLEFIELD_SUCCESS);
}

void BattlefieldWG::OnDestroyedFortressTower(uint8 towerId)
{
    GameObject* fortressTower = NULL;

    for (GameObjectBuildingMap::iterator itr = fortressTowers.begin(); itr != fortressTowers.end(); itr++)
        if (GameObject* go = HashMapHolder<GameObject>::Find((*itr).first))
            if (go->GetEntry() == WG_GO_FORTRESS_TOWER[towerId])
                fortressTower = go;

    if (fortressTower != NULL)
        for (GuidSet::iterator itr = _PlayersInBattle[GetAttackerTeam()].begin(); itr != _PlayersInBattle[GetAttackerTeam()].end(); itr++)
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
                if (player->GetDistance(fortressTower) < 100.0f)
                {
                    IncrementQuest(player, WG_QUEST[player->GetTeamId()][2], NULL, NULL, true);
                    player->SetCompletedAchievement(sAchievementStore.LookupEntry(WG_ACHIEVEMENT_LEANING_TOWER));
                }

    for (GuidSet::iterator itr = fortressCannons[towerId].begin(); itr != fortressCannons[towerId].end(); itr++)
        if (Creature* cannon = HashMapHolder<Creature>::Find((*itr)))
            if (cannon->IsAlive())
                cannon->setDeathState(JUST_DIED);
}

void BattlefieldWG::OnDestroyedTower(uint8 towerId)
{
    for (uint8 team = 0; team < TEAM_NEUTRAL; team++)
        for (GuidSet::iterator itr = _PlayersInBattle[team].begin(); itr != _PlayersInBattle[team].end(); itr++)
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
            {
                if (team == GetAttackerTeam())
                    player->RemoveAuraFromStack(WG_SPELL_TOWER_CONTROL);
                else
                    player->CastSpell(player, WG_SPELL_TOWER_CONTROL, true);
            }

    GameObject* tower = NULL;

    for (GameObjectBuildingMap::iterator itr = towers.begin(); itr != towers.end(); itr++)
        if (GameObject* go = HashMapHolder<GameObject>::Find((*itr).first))
            if (go->GetEntry() == WG_GO_TOWER[towerId])
                tower = go;

    if (tower != NULL)
        for (GuidSet::iterator itr = _PlayersInBattle[GetDefenderTeam()].begin(); itr != _PlayersInBattle[GetDefenderTeam()].end(); itr++)
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
                if (player->GetDistance(tower) < 100.0f)
                {
                    IncrementQuest(player, WG_QUEST[player->GetTeamId()][3], NULL, NULL, true);
                    player->SetCompletedAchievement(sAchievementStore.LookupEntry(WG_ACHIEVEMENT_LEANING_TOWER));
                }

    for (GuidSet::iterator itr = cannons[towerId].begin(); itr != cannons[towerId].end(); itr++)
        if (Creature* cannon = HashMapHolder<Creature>::Find((*itr)))
            if (cannon->IsAlive())
                cannon->setDeathState(JUST_DIED);

    SetTimer(GetTimer() < 5 * MINUTE * IN_MILLISECONDS ? 0 : GetTimer() - 5 * MINUTE * IN_MILLISECONDS);
}

void BattlefieldWG::OnSetBattleTime(bool /*value*/)
{
    for (uint8 i = 0; i < WG_UI_MISC_MAX; i++)
        SendUpdateWorldState(WG_WORLDSTATE_UI_STATE[i], uint32(IsBattleTime() ? !i : i));

    UpdateCannons();
    UpdateMobs();
    UpdateSpirits();
    UpdateTeleports();
    UpdateTitanRelic();
    UpdateFortressGraveyard();

    for (CapturePointMap::iterator itr = _CapturePoints.begin(); itr != _CapturePoints.end(); itr++)
        (*itr).second->UpdateState();
}

void BattlefieldWG::OnSetTimer(uint32 timer)
{
    for (uint8 i = 0; i < WG_CLOCK_MAX; i++)
        SendUpdateWorldState(WG_WORLDSTATE_UI_TIMER[i], uint32(time(NULL) + timer / IN_MILLISECONDS));
}

void BattlefieldWG::OnSetDefenderTeam(TeamId team)
{
    for (uint8 i = 0; i < WG_UI_MISC_MAX; i++)
        SendUpdateWorldState(WG_WORLDSTATE_UI_FACTION_CONTROL_STATE[i], TeamId(i) == team ? 1 : 0);
}

void BattlefieldWG::AddVehicle(Creature* vehicle)
{
    if (vehicle->ToTempSummon() && vehicle->ToTempSummon()->GetSummoner())
        if (Player* player = vehicle->ToTempSummon()->GetSummoner()->ToPlayer())
        {
            TeamId team = player->GetTeamId();
            if (IsBattleTime() && GetVehicleCount(team, false) < GetVehicleCount(team, true))
            {
                vehicle->setFaction(WG_FACTION[player->GetTeamId()]);
                vehicle->AddAura(team ? WG_SPELL_HORDE_FLAG : WG_SPELL_ALLIANCE_FLAG, vehicle);
                vehicles[team].insert(vehicle->GetGUID());
                vehicleQueue[vehicle->GetGUID()] = IN_MILLISECONDS;
                SendUpdateWorldState(WG_WORLDSTATE_UI_VEHICLE_COUNT[team], GetVehicleCount(team, false));
                return;
            }
        }

    vehicle->DespawnOrUnsummon();
}

void BattlefieldWG::RemoveVehicle(Creature* vehicle)
{
    for (uint8 team = 0; team < WG_TEAM_MAX; team++)
        if (vehicles[team].find(vehicle->GetGUID()) != vehicles[team].end())
        {
            vehicles[team].erase(vehicle->GetGUID());
            SendUpdateWorldState(WG_WORLDSTATE_UI_VEHICLE_COUNT[team], GetVehicleCount(TeamId(team), false));
        }
}

void BattlefieldWG::UpdateMaxVehicle(TeamId team, bool end)
{
    if (end)
    {
        for (uint8 i = 0; i < WG_TEAM_MAX; i++)
            maxVehicles[i] = i == team ? 16 : 8;
    }
    else if (maxVehicles[team == TEAM_ALLIANCE ? TEAM_HORDE : TEAM_ALLIANCE] != 0)
    {
        maxVehicles[team] += 4;
        maxVehicles[team == TEAM_ALLIANCE ? TEAM_HORDE : TEAM_ALLIANCE] -= 4;
    }

    for (uint8 i = 0; i < WG_TEAM_MAX; i++)
        SendUpdateWorldState(WG_WORLDSTATE_UI_VEHICLE_MAX[i], GetVehicleCount(TeamId(i), true));
}

void BattlefieldWG::UpdateTenacity()
{
    if (!IsBattleTime())
        return;

    TeamId teamTenacity = _PlayersInBattle[TEAM_ALLIANCE].size() < _PlayersInBattle[TEAM_HORDE].size() ? TEAM_ALLIANCE : TEAM_HORDE;
    uint8 stack = (_PlayersInBattle[teamTenacity == TEAM_ALLIANCE ? TEAM_HORDE : TEAM_ALLIANCE].size() - _PlayersInBattle[teamTenacity].size()) / 10;

    for (uint8 team = 0; team < 2; team++)
    {
        for (GuidSet::iterator itr = _PlayersInBattle[team].begin(); itr != _PlayersInBattle[team].end(); itr++)
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
            {
                if (stack != 0 && team == teamTenacity)
                {
                    player->RemoveAurasDueToSpell(WG_SPELL_GREAT_HONOR);
                    player->RemoveAurasDueToSpell(WG_SPELL_GREATER_HONOR);
                    player->RemoveAurasDueToSpell(WG_SPELL_GREATEST_HONOR);
                    if (!player->HasAura(WG_SPELL_TENACITY))
                        player->CastSpell(player, WG_SPELL_TENACITY);
                    if (Aura* aura = player->GetAura(WG_SPELL_TENACITY))
                        if (aura->GetStackAmount() != stack)
                            aura->SetStackAmount(stack);
                }
                else
                {
                    player->RemoveAurasDueToSpell(WG_SPELL_TENACITY);
                    switch (stack)
                    {
                        case 5:
                            player->RemoveAurasDueToSpell(WG_SPELL_GREATER_HONOR);
                            player->RemoveAurasDueToSpell(WG_SPELL_GREATEST_HONOR);
                            if (!player->HasAura(WG_SPELL_GREAT_HONOR))
                                player->CastSpell(player, WG_SPELL_GREAT_HONOR);
                            break;
                        case 10:
                            player->RemoveAurasDueToSpell(WG_SPELL_GREAT_HONOR);
                            player->RemoveAurasDueToSpell(WG_SPELL_GREATEST_HONOR);
                            if (!player->HasAura(WG_SPELL_GREATER_HONOR))
                                player->CastSpell(player, WG_SPELL_GREATER_HONOR);
                            break;
                        case 20:
                            player->RemoveAurasDueToSpell(WG_SPELL_GREAT_HONOR);
                            player->RemoveAurasDueToSpell(WG_SPELL_GREATER_HONOR);
                            if (!player->HasAura(WG_SPELL_GREATEST_HONOR))
                                player->CastSpell(player, WG_SPELL_GREATEST_HONOR);
                            break;
                    }
                }
            }

        for (GuidSet::iterator itr = vehicles[team].begin(); itr != vehicles[team].end(); itr++)
            if (Creature* creature = HashMapHolder<Creature>::Find((*itr)))
                if (creature->IsVehicle())
                {
                    if (stack != 0 && team == teamTenacity)
                    {
                        if (!creature->HasAura(WG_SPELL_TENACITY_VEHICLE))
                            creature->CastSpell(creature, WG_SPELL_TENACITY_VEHICLE);
                        if (Aura* aura = creature->GetAura(WG_SPELL_TENACITY_VEHICLE))
                            if (aura->GetStackAmount() != stack)
                                aura->SetStackAmount(stack);
                    }
                    else
                        creature->RemoveAurasDueToSpell(WG_SPELL_TENACITY_VEHICLE);
                }
    }
}

void BattlefieldWG::OnSetVisible(Creature* creature, bool visible)
{
    switch (creature->GetEntry())
    {
        case WG_NPC_WATER_REVENANT:
        case WG_NPC_SHADOW_REVENANT:
        case WG_NPC_TEMPEST_REVENANT:
        case WG_NPC_FLAME_REVENANT:
        case WG_NPC_GLACIAL_SPIRIT:
        case WG_NPC_LIVING_LASHER:
        case WG_NPC_MATURE_LASHER:
        case WG_NPC_RAGING_FLAME:
        case WG_NPC_WHISPERING_WIND:
        case WG_NPC_WANDERING_SHADOW:
        case WG_NPC_EARTHBOUND_REVENANT:
        case WG_NPC_CHILLED_EARTH_ELEMENTAL:
        {
            const CreatureData* creatureData = creature->GetCreatureData();
            creature->SetRespawnDelay(!visible ? _TimeInBattle / IN_MILLISECONDS : (creatureData ? creatureData->spawntimesecs : 5 * MINUTE));
            break;
        }
        case WG_NPC_CANNON:
            creature->SetRespawnDelay((visible ? _TimeInBattle : _TimeForBattle) / IN_MILLISECONDS);
    }
}

BfCapturePointWG::BfCapturePointWG(Battlefield* bf, GameObject* capturePoint, TeamId team) : BfCapturePoint(bf, capturePoint, team)
{
    ClearWorkshopGUID();
    wg = (BattlefieldWG*)_bf;
    for (uint8 i = 0; i < WG_WORKSHOP_MAX; i++)
        if (capturePoint->GetEntry() == WG_GO_WORKSHOP_BANNER[i])
        {
            id = WGWorkshop(i);
            ws.value = _Team ? STATE_HORDE_INTACT : STATE_ALLIANCE_INTACT;
            ws.worldState = WG_WORLDSTATE_WORKSHOP[i];
        }

    LinkGraveYard();
}

bool BfCapturePointWG::OnPlayerEnter(Player* /*player*/)
{
    return GetWorkshopGUID() != 0;
}

void BfCapturePointWG::ChangeState()
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "BfCapturePointWG::ChangeState(WorkshopGUID: %u, State: %d, WS: %d, WSvalue: %u)", uint32(GUID_LOPART(workshopGUID)), _State, ws.value, ws.worldState);

    if (GetWorkshopGUID() == 0)
        return;

    switch (_State)
    {
        case OBJECTIVESTATE_NEUTRAL:
            break;
        case OBJECTIVESTATE_ALLIANCE:
            wg->UpdateMaxVehicle(TEAM_ALLIANCE);
            ws.value = STATE_ALLIANCE_INTACT;
            wg->SendWarningToAll(WG_LANG_TAKEN, WG_LANG_WORKSHOP[id], WG_LANG_TEAM[TEAM_ALLIANCE]);
            break;
        case OBJECTIVESTATE_HORDE:
            wg->UpdateMaxVehicle(TEAM_HORDE);
            ws.value = STATE_HORDE_INTACT;
            wg->SendWarningToAll(WG_LANG_TAKEN, WG_LANG_WORKSHOP[id], WG_LANG_TEAM[TEAM_HORDE]);
            break;
        case OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE:
            //wg->SendWarningToAll(WG_LANG_LOST, WG_LANG_WORKSHOP[id], WG_LANG_TEAM[TEAM_HORDE]);
            break;
        case OBJECTIVESTATE_HORDE_ALLIANCE_CHALLENGE:
            wg->SendWarningToAll(WG_LANG_ATTACK, WG_LANG_WORKSHOP[id], WG_LANG_TEAM[TEAM_ALLIANCE]);
            return;
        case OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE:
            //wg->SendWarningToAll(WG_LANG_LOST, WG_LANG_WORKSHOP[id], WG_LANG_TEAM[TEAM_ALLIANCE]);
            break;
        case OBJECTIVESTATE_ALLIANCE_HORDE_CHALLENGE:
            wg->SendWarningToAll(WG_LANG_ATTACK, WG_LANG_WORKSHOP[id], WG_LANG_TEAM[TEAM_HORDE]);
            return;
    }

    if (GameObject* go = HashMapHolder<GameObject>::Find(_CapturePoint))
        go->SetGoArtKit(_Team == TEAM_ALLIANCE ? GO_ART_KIT_BATTLEFIELD_BANNER_FLAG_ALLIANCE : GO_ART_KIT_BATTLEFIELD_BANNER_FLAG_HORDE);
    wg->workshops[GetWorkshopGUID()] = ws;
    wg->SendUpdateWorldState(ws.worldState, ws.value);
    CastToAllPlayers(_Team == TEAM_ALLIANCE ? WG_SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT : WG_SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT);
    LinkGraveYard();
}

void BfCapturePointWG::UpdateState()
{
    if (GetWorkshopGUID() == 0)
        return;

    _Team = wg->workshops[GetWorkshopGUID()].value == STATE_ALLIANCE_INTACT ? TEAM_ALLIANCE : TEAM_HORDE;
    _Value = _Team ? -_MaxValue : _MaxValue;
    _State = (_Team == TEAM_ALLIANCE ? OBJECTIVESTATE_ALLIANCE : OBJECTIVESTATE_HORDE);
    _OldState = (_Team == TEAM_ALLIANCE ? OBJECTIVESTATE_HORDE : OBJECTIVESTATE_ALLIANCE);

    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "BfCapturePointWG::UpdateState(WorkshopGUID: %u, Value: %f, Team: %d, State: %d, OldState: %d)", uint32(GUID_LOPART(workshopGUID)), _Value, _Team, _State, _OldState);

    LinkGraveYard();

    if (GameObject* go = HashMapHolder<GameObject>::Find(_CapturePoint))
        go->SetGoArtKit(_Team == TEAM_ALLIANCE ? GO_ART_KIT_BATTLEFIELD_BANNER_FLAG_ALLIANCE : GO_ART_KIT_BATTLEFIELD_BANNER_FLAG_HORDE);
}

void BfCapturePointWG::LinkGraveYard()
{
    TC_LOG_DEBUG(LOG_FILTER_BATTLEFIELD, "BfCapturePointWG::LinkGraveYard(WorkshopGUID: %u, Team: %d)", uint32(GUID_LOPART(workshopGUID)), _Team);

    if (!_bf)
        return;

    sObjectMgr->RemoveGraveYardLink(WG_GRAVEYARD[id], _bf->GetZoneId(), HORDE, false);
    sObjectMgr->RemoveGraveYardLink(WG_GRAVEYARD[id], _bf->GetZoneId(), ALLIANCE, false);
    sObjectMgr->RemoveGraveYardLink(WG_GRAVEYARD[id], _bf->GetZoneId(), TEAM_OTHER, false);

    sObjectMgr->AddGraveYardLink(WG_GRAVEYARD[id], _bf->GetZoneId(), _bf->IsBattleTime() ? (_Team == TEAM_ALLIANCE ? ALLIANCE : HORDE) : TEAM_OTHER, false);
}

uint64 BfCapturePointWG::GetWorkshopGUID()
{
    if (workshopGUID == 0)
        for (Battlefield::GameObjectBuildingMap::iterator itr = wg->workshops.begin(); itr != wg->workshops.end(); itr++)
            if (GameObject* go = HashMapHolder<GameObject>::Find((*itr).first))
                if (go->GetEntry() == WG_GO_WORKSHOP[id])
                {
                    workshopGUID = go->GetGUID();
                    break;
                }

    return workshopGUID;
}

void BfCapturePointWG::ClearWorkshopGUID()
{
    workshopGUID = 0;
}
