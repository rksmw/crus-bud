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

#ifndef BATTLEFIELD_MGR_H_
#define BATTLEFIELD_MGR_H_

#include "Common.h"
#include "DBCEnums.h"
#include "Battlefield.h"
#include <ace/Singleton.h>

#define BATTLEFIELD_OBJECTIVE_UPDATE_INTERVAL 1000

class Player;
class GameObject;
class Creature;
class ZoneScript;

class BattlefieldMgr
{
    friend class ACE_Singleton<BattlefieldMgr, ACE_Null_Mutex>;

    public:
        BattlefieldMgr();
        ~BattlefieldMgr();

        void InitBattlefield();

        void AddZone(uint32 zoneid, Battlefield* bf);

        Battlefield* GetBattlefieldByZoneId(uint32 zoneId);
        Battlefield* GetBattlefieldByBattleId(uint32 battleId);

        ZoneScript* GetZoneScript(uint32 zoneId);

        void HandlePlayerEnterZone(Player* player, uint32 areaflag);
        void HandlePlayerLeaveZone(Player* player, uint32 areaflag);
        void HandlePlayerResurrects(Player* player, uint32 areaflag);

        void Update(uint32 diff);

        void SendAreaSpiritHealerQueryOpcode(Player* player, Battlefield* bf, uint64 guid);

        typedef std::vector<Battlefield*> BattlefieldSet;
        typedef std::map<uint32 /*zoneid*/, Battlefield*> BattlefieldMap;

    private:
        BattlefieldSet _Battlefields;
        BattlefieldMap _BattlefieldMap;
        uint32 _UpdateTimer;
};

#define sBattlefieldMgr ACE_Singleton<BattlefieldMgr, ACE_Null_Mutex>::instance()

#endif  /*BATTLEFIELD_MGR_H_*/
