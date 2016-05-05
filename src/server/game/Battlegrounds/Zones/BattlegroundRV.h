/*
 * Copyright (C) 2008-2013 TrinityCore <http://www.trinitycore.org/>
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
#ifndef __BATTLEGROUNDRV_H
#define __BATTLEGROUNDRV_H

#include "Battleground.h"

enum BattlegroundRVObjectTypes
{
    BG_RV_OBJECT_BUFF_1,
    BG_RV_OBJECT_BUFF_2,
    BG_RV_OBJECT_FIRE_1,
    BG_RV_OBJECT_FIRE_2,
    BG_RV_OBJECT_FIREDOOR_1,
    BG_RV_OBJECT_FIREDOOR_2,

    BG_RV_OBJECT_PILAR_1,
    BG_RV_OBJECT_PILAR_3,
    BG_RV_OBJECT_GEAR_1,
    BG_RV_OBJECT_GEAR_2,

    BG_RV_OBJECT_PILAR_2,
    BG_RV_OBJECT_PILAR_4,
    BG_RV_OBJECT_PULLEY_1,
    BG_RV_OBJECT_PULLEY_2,

    BG_RV_OBJECT_PILAR_1_FLOOR,
    BG_RV_OBJECT_PILAR_2_FLOOR,
    BG_RV_OBJECT_PILAR_3_FLOOR,
    BG_RV_OBJECT_PILAR_4_FLOOR,

    BG_RV_OBJECT_PILAR_COLLISION_1,
    BG_RV_OBJECT_PILAR_COLLISION_2,
    BG_RV_OBJECT_PILAR_COLLISION_3,
    BG_RV_OBJECT_PILAR_COLLISION_4,


    BG_RV_OBJECT_ELEVATOR_1,
    BG_RV_OBJECT_ELEVATOR_2,

    BG_RV_OBJECT_FENCE_1,
    BG_RV_OBJECT_FENCE_2,

    BG_RV_OBJECT_MAX
};

enum BattlegroundRVObjects
{
    BG_RV_OBJECT_TYPE_BUFF_1                     = 184663,
    BG_RV_OBJECT_TYPE_BUFF_2                     = 184664,
    BG_RV_OBJECT_TYPE_FIRE_1                     = 192704,
    BG_RV_OBJECT_TYPE_FIRE_2                     = 192705,

    BG_RV_OBJECT_TYPE_FIREDOOR_2                 = 192387,
    BG_RV_OBJECT_TYPE_FIREDOOR_1                 = 192388,
    BG_RV_OBJECT_TYPE_PULLEY_1                   = 192389,
    BG_RV_OBJECT_TYPE_PULLEY_2                   = 192390,
    BG_RV_OBJECT_TYPE_GEAR_1                     = 192393,
    BG_RV_OBJECT_TYPE_GEAR_2                     = 192394,
    BG_RV_OBJECT_TYPE_ELEVATOR_1                 = 194582,
    BG_RV_OBJECT_TYPE_ELEVATOR_2                 = 194586,
    BG_RV_OBJECT_TYPE_FENCE_1                    = 192391,
    BG_RV_OBJECT_TYPE_FENCE_2                    = 192392,

    BG_RV_OBJECT_TYPE_PILAR_COLLISION_1          = 194580, // axe
    BG_RV_OBJECT_TYPE_PILAR_COLLISION_2          = 194579, // arena
    BG_RV_OBJECT_TYPE_PILAR_COLLISION_3          = 194581, // lightning
    BG_RV_OBJECT_TYPE_PILAR_COLLISION_4          = 194578, // ivory

    BG_RV_OBJECT_TYPE_PILAR_1                    = 194583, // axe
    BG_RV_OBJECT_TYPE_PILAR_2                    = 194584, // arena
    BG_RV_OBJECT_TYPE_PILAR_3                    = 194585, // lightning
    BG_RV_OBJECT_TYPE_PILAR_4                    = 194587, // ivory

    BG_RV_OBJECT_TYPE_FLOOR_PILAR_1              = 42001, // axe
    BG_RV_OBJECT_TYPE_FLOOR_PILAR_2              = 42002, // lightning
    BG_RV_OBJECT_TYPE_FLOOR_PILAR_3              = 42003, // arena
    BG_RV_OBJECT_TYPE_FLOOR_PILAR_4              = 42004  // ivory
};

enum BattlegroundRVData
{
    BG_RV_STATE_OPEN_FENCES,
    BG_RV_STATE_SWITCH_PILLARS,
    BG_RV_STATE_CLOSE_FIRE,
    BG_RV_PILLAR_STATUS_ON						 = 1,
    BG_RV_PILLAR_STATUS_OFF						 = 2,

    BG_RV_PILLAR_SWITCH_TIMER                    = 25000,
    BG_RV_FIRE_TO_PILLAR_TIMER                   = 20000,
    BG_RV_CLOSE_FIRE_TIMER                       = 5000,
    BG_RV_FIRST_TIMER                            = 20133,
    BG_RV_WORLD_STATE_A                          = 0xe10,
    BG_RV_WORLD_STATE_H                          = 0xe11,
    BG_RV_WORLD_STATE                            = 0xe1a
};

class BattlegroundRV : public Battleground
{
    public:
        BattlegroundRV();
        ~BattlegroundRV();

        /* inherited from BattlegroundClass */
        void AddPlayer(Player* player);
        void StartingEventCloseDoors();
        void StartingEventOpenDoors();
        void Reset();
        void FillInitialWorldStates(WorldPacket &d);

        void RemovePlayer(Player* player, uint64 guid, uint32 team);
        void HandleAreaTrigger(Player* Source, uint32 Trigger);
        bool SetupBattleground();
        bool IsPlayerUnderMap(Player* player, float x, float y, float z);
        void HandleKillPlayer(Player* player, Player* killer);

    private:
        uint32 Timer;
        uint32 State;
        bool   PillarCollision;
        uint32 fenceStatus;
        uint32 BP1Status;
        uint32 BP2Status;
        uint32 SP1Status;
        uint32 SP2Status;

        void PostUpdateImpl(uint32 diff);

    protected:
        uint32 getTimer() { return Timer; }
        void setTimer(uint32 timer) { Timer = timer; }

        uint32 getState() { return State; }
        void setState(uint32 state) { State = state; }
        void TogglePillarCollision();
        bool GetPillarCollision() { return PillarCollision; }
        void SetPillarCollision(bool apply) { PillarCollision = apply; }
        void UseGameObject(uint32 type);

        void setFenceStatus(uint8 status) { fenceStatus = status; }
        uint32 getBigPillar1Status() { return BP1Status; }
        void setBigPillar1Status(uint8 status) { BP1Status = status; }
        uint32 getBigPillar2Status() { return BP2Status; }
        void setBigPillar2Status(uint8 status) { BP2Status = status; }
        uint32 getSmallPillar1Status() { return SP1Status; }
        void setSmallPillar1Status(uint8 status) { SP1Status = status; }
        uint32 getSmallPillar2Status() { return SP2Status; }
        void setSmallPillar2Status(uint8 status) { SP2Status = status; }
};
#endif