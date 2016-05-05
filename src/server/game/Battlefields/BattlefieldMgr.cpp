/*
 * Copyright (C) 2010-2012 Battle.cl <http://www.battle.cl/>
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

#include "BattlefieldMgr.h"
#include "Zones/BattlefieldWG.h"
#include "ObjectMgr.h"
#include "Player.h"

BattlefieldMgr::BattlefieldMgr()
{
    _UpdateTimer = 0;
}

BattlefieldMgr::~BattlefieldMgr()
{
    for (BattlefieldSet::iterator itr = _Battlefields.begin(); itr != _Battlefields.end(); ++itr)
        delete *itr;
}

void BattlefieldMgr::InitBattlefield()
{
    Battlefield* bf = new BattlefieldWG;
    if (!bf->SetupBattlefield())
    {
        sLog->outInfo(LOG_FILTER_SERVER_LOADING, ">> Wintergrasp not started.");
        delete bf;
    }
    else
    {
        _Battlefields.push_back(bf);
        sLog->outInfo(LOG_FILTER_SERVER_LOADING, ">> Wintergrasp successfully started.");
    }

    /* Tol Barad

    Battlefield* bf = new BattlefieldTB;
    if (!bf->SetupBattlefield())
    {
        sLog->outString(">> Tol Barad not started.");
        delete bf;
    }
    else
    {
       _Battlefields.push_back(bf);
       sLog->outString(">> successfully started.");
    }
    */
}

void BattlefieldMgr::AddZone(uint32 zoneId, Battlefield* bf)
{
    _BattlefieldMap[zoneId] = bf;
}

Battlefield *BattlefieldMgr::GetBattlefieldByZoneId(uint32 zoneid)
{
    BattlefieldMap::iterator itr = _BattlefieldMap.find(zoneid);
    if (itr == _BattlefieldMap.end() || !itr->second->GetEnable())
        return NULL;

    return itr->second;
}

Battlefield *BattlefieldMgr::GetBattlefieldByBattleId(uint32 battleid)
{
    for (BattlefieldSet::iterator itr = _Battlefields.begin(); itr != _Battlefields.end(); ++itr)
        if ((*itr)->GetBattleId() == battleid)
            return (*itr);

    return NULL;
}

ZoneScript *BattlefieldMgr::GetZoneScript(uint32 zoneId)
{
    BattlefieldMap::iterator itr = _BattlefieldMap.find(zoneId);
    if (itr != _BattlefieldMap.end())
        return itr->second;
    else
        return NULL;
}

void BattlefieldMgr::HandlePlayerEnterZone(Player* player, uint32 zoneid)
{
    BattlefieldMap::iterator itr = _BattlefieldMap.find(zoneid);
    if (itr == _BattlefieldMap.end() || itr->second->HasPlayerInZone(player) || !itr->second->GetEnable())
        return;

    itr->second->HandlePlayerEnterZone(player, zoneid);
}

void BattlefieldMgr::HandlePlayerLeaveZone(Player* player, uint32 zoneid)
{
    BattlefieldMap::iterator itr = _BattlefieldMap.find(zoneid);
    if (itr == _BattlefieldMap.end() || !itr->second->HasPlayerInZone(player))
        return;

    itr->second->HandlePlayerLeaveZone(player, zoneid);
}

void BattlefieldMgr::HandlePlayerResurrects(Player* player, uint32 zoneId)
{
    BattlefieldMap::iterator itr = _BattlefieldMap.find(zoneId);
    if (itr == _BattlefieldMap.end())
        return;

    if (itr->second->HasPlayerInZone(player))
        itr->second->HandlePlayerResurrects(player, zoneId);
}

void BattlefieldMgr::Update(uint32 diff)
{
    _UpdateTimer += diff;
    if (_UpdateTimer > BATTLEFIELD_OBJECTIVE_UPDATE_INTERVAL)
    {
        for (BattlefieldSet::iterator itr = _Battlefields.begin(); itr != _Battlefields.end(); ++itr)
            if ((*itr)->GetEnable())
                (*itr)->Update(_UpdateTimer);
        _UpdateTimer = 0;
    }
}

void BattlefieldMgr::SendAreaSpiritHealerQueryOpcode(Player* player, Battlefield* bf, uint64 guid)
{
    WorldPacket data(SMSG_AREA_SPIRIT_HEALER_TIME, 12);
    uint32 time_ = 30000 - bf->GetLastResurrectTime();      // resurrect every 30 seconds
    if (time_ == uint32(-1))
        time_ = 0;
    data << guid << time_;
    player->GetSession()->SendPacket(&data);
}
