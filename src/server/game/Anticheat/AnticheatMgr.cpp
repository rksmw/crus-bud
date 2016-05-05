/*
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

#include "AnticheatMgr.h"
#include "AnticheatScripts.h"
#include "MapManager.h"
#include "AnticheatData.h"

#define CLIMB_ANGLE 1.9f

AnticheatMgr::AnticheatMgr() : updateTime(0)
{
}

AnticheatMgr::~AnticheatMgr()
{
    m_Players.clear();
    m_Reports.clear();
}

bool AnticheatMgr::JumpHackDetection(Player* player, MovementInfo& movementInfo, uint32 opcode, AnticheatData& anticheatData)
{
    if ((sWorld->getIntConfig(CONFIG_ANTICHEAT_DETECTIONS_ENABLED) & JUMP_HACK_DETECTION) == 0)
        return false;

    if (anticheatData.GetLastOpcode() == MSG_MOVE_JUMP && opcode == MSG_MOVE_JUMP)
    {
        IncreaseReport(player, anticheatData, JUMP_HACK_REPORT);
        sLog->outInfo(LOG_FILTER_CHARACTER, "AnticheatMgr:: Jump-Hack detected player GUID (low) %u",player->GetGUIDLow());
        return true;
    }
    return false;
}

bool AnticheatMgr::WalkOnWaterHackDetection(Player* player, MovementInfo& movementInfo, AnticheatData& anticheatData)
{
    if ((sWorld->getIntConfig(CONFIG_ANTICHEAT_DETECTIONS_ENABLED) & WALK_WATER_HACK_DETECTION) == 0)
        return false;

    if (!movementInfo.HasMovementFlag(MOVEMENTFLAG_WATERWALKING))
        return false;

    // if we are a ghost we can walk on water
    if (!player->IsAlive())
        return false;

    if (player->HasAuraType(SPELL_AURA_FEATHER_FALL) ||
        player->HasAuraType(SPELL_AURA_SAFE_FALL) ||
        player->HasAuraType(SPELL_AURA_WATER_WALK))
        return false;

    sLog->outInfo(LOG_FILTER_CHARACTER, "AnticheatMgr:: Walk on Water - Hack detected player GUID (low) %u",player->GetGUIDLow());
    IncreaseReport(player, anticheatData, WALK_WATER_HACK_REPORT);
    return true;

}

bool AnticheatMgr::FlyHackDetection(Player* player, MovementInfo& movementInfo, AnticheatData& anticheatData)
{
    if ((sWorld->getIntConfig(CONFIG_ANTICHEAT_DETECTIONS_ENABLED) & FLY_HACK_DETECTION) == 0)
        return false;

    if (!movementInfo.HasMovementFlag(MOVEMENTFLAG_FLYING))
        return false;

    if (player->HasAuraType(SPELL_AURA_FLY) ||
        player->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED) ||
        player->HasAuraType(SPELL_AURA_MOD_INCREASE_FLIGHT_SPEED))
        return false;

    sLog->outInfo(LOG_FILTER_CHARACTER, "AnticheatMgr:: Fly-Hack detected player GUID (low) %u",player->GetGUIDLow());
    IncreaseReport(player, anticheatData, FLY_HACK_REPORT);
    return true;
}

bool AnticheatMgr::TeleportPlaneHackDetection(Player* player, MovementInfo& movementInfo, AnticheatData& anticheatData)
{
    if ((sWorld->getIntConfig(CONFIG_ANTICHEAT_DETECTIONS_ENABLED) & TELEPORT_PLANE_HACK_DETECTION) == 0)
        return false;

    if (player->GetPositionZ() != 0 ||
        movementInfo.pos.GetPositionZ() != 0)
        return false;

    if (movementInfo.HasMovementFlag(MOVEMENTFLAG_FALLING))
        return false;

    //DEAD_FALLING was deprecated
    //if (player->getDeathState() == DEAD_FALLING)
    //    return;
    float x, y, z;
    player->GetPosition(x, y, z);
    float ground_Z = player->GetMap()->GetHeight(x, y, z);
    float z_diff = fabs(ground_Z - z);

    // we are not really walking there
    if (z_diff > 1.0f)
    {
        sLog->outInfo(LOG_FILTER_CHARACTER, "AnticheatMgr:: Teleport To Plane - Hack detected player GUID (low) %u",player->GetGUIDLow());
        IncreaseReport(player, anticheatData, TELEPORT_PLANE_HACK_REPORT);
        return true;
    }
    return false;
}

// basic detection
bool AnticheatMgr::ClimbHackDetection(Player *player, MovementInfo& movementInfo, uint32 opcode, AnticheatData& anticheatData)
{
    if ((sWorld->getIntConfig(CONFIG_ANTICHEAT_DETECTIONS_ENABLED) & CLIMB_HACK_DETECTION) == 0)
        return false;

    if (opcode != MSG_MOVE_HEARTBEAT ||
        anticheatData.GetLastOpcode() != MSG_MOVE_HEARTBEAT)
        return false;

    // in this case we don't care if they are "legal" flags, they are handled in another parts of the Anticheat Manager.
    if (player->IsInWater() ||
        player->IsFlying() ||
        player->IsFalling())
        return false;

    Position playerPos;
    player->GetPosition(&playerPos);

    float deltaZ = fabs(playerPos.GetPositionZ() - movementInfo.pos.GetPositionZ());
    float deltaXY = movementInfo.pos.GetExactDist2d(&playerPos);

    float angle = Position::NormalizeOrientation(tan(deltaZ/deltaXY));

    if (angle > CLIMB_ANGLE)
    {
        sLog->outInfo(LOG_FILTER_CHARACTER, "AnticheatMgr:: Climb-Hack detected player GUID (low) %u", player->GetGUIDLow());
        IncreaseReport(player, anticheatData, CLIMB_HACK_REPORT);
        return true;
    }
    return false;
}

bool AnticheatMgr::TeleportHackDetection(Player* player, MovementInfo& movementInfo, AnticheatData& anticheatData)
{
    if ((sWorld->getIntConfig(CONFIG_ANTICHEAT_DETECTIONS_ENABLED) & TELEPORT_HACK_DETECTION) == 0)
        return false;

    // Comparamos la distancia con una constante
    float distance2dSq = movementInfo.pos.GetExactDist2dSq(player->GetPositionX(), player->GetPositionY());
    if (distance2dSq > 4000.0f*4000.0f && player->GetMapId() != 369)
    {
        // Excluimos a icc si se caen al vacio
        if (player->GetMapId() != 631 || player->GetPositionZ() > -20.0f)
        {
            IncreaseReport(player, anticheatData, TELEPORT_HACK_REPORT);
            return true;
        }
    }
    return false;
}

void AnticheatMgr::SpeedHackDetection(Player* player, MovementInfo& movementInfo, AnticheatData& anticheatData)
{
    if ((sWorld->getIntConfig(CONFIG_ANTICHEAT_DETECTIONS_ENABLED) & SPEED_HACK_DETECTION) == 0)
        return;

    // We also must check the map because the movementFlag can be modified by the client.
    // If we just check the flag, they could always add that flag and always skip the speed hacking detection.
    // 369 == DEEPRUN TRAM
    if (movementInfo.HasMovementFlag(MOVEMENTFLAG_ONTRANSPORT) && player->GetMapId() == 369)
        return;

    uint32 distance2D = (uint32)movementInfo.pos.GetExactDist2d(player->GetPositionX(), player->GetPositionY());
    uint8 moveType;

    // we need to know HOW is the player moving
    // TO-DO: Should we check the incoming movement flags?
    if (player->HasUnitMovementFlag(MOVEMENTFLAG_SWIMMING))
        moveType = MOVE_SWIM;
    else if (player->IsFlying())
        moveType = MOVE_FLIGHT;
    //else if (player->HasUnitMovementFlag(MOVEMENTFLAG_WALKING))
    //    moveType = MOVE_WALK;
    else
        moveType = MOVE_RUN;

    // how many yards the player can do in one sec.
    float speedRate = player->GetSpeed(UnitMoveType(moveType)) + movementInfo.jump.xyspeed + sWorld->getFloatConfig(CONFIG_ANTICHEAT_MAX_SPEED_DIFF_ALLOWED);

    // how long the player took to move to here.
    uint32 timeDiff = getMSTimeDiff(anticheatData.GetLastMovementInfo().time,movementInfo.time);

    if (timeDiff == 0)
        timeDiff = 1;

    // this is the distance doable by the player in 1 sec, using the time done to move to this point.
    float clientSpeedRate = distance2D * 1000 / timeDiff;

    if (clientSpeedRate > speedRate)
    {
        IncreaseReport(player, anticheatData, SPEED_HACK_REPORT);
        sLog->outInfo(LOG_FILTER_CHARACTER, "AnticheatMgr:: Speed-Hack detected player GUID (low) %u",player->GetGUIDLow());
    }
}

void AnticheatMgr::StartHackDetection(Player* player, MovementInfo movementInfo, uint32 opcode)
{
    if (!sWorld->getBoolConfig(CONFIG_ANTICHEAT_ENABLE))
        return;

    if (player->IsGameMaster())
        return;

    AnticheatData& data = m_Players[player->GetGUIDLow()];

    if (player->IsInFlight() || player->GetTransport() || player->GetVehicle())
    {
        data.SetLastMovementInfo(movementInfo);
        data.SetLastOpcode(opcode);
        return;
    }


    if (!TeleportHackDetection(player, movementInfo, data))
        if (!FlyHackDetection(player, movementInfo, data))
            SpeedHackDetection(player, movementInfo, data);

    //JumpHackDetection(player,movementInfo, opcode, data);
    //ClimbHackDetection(player,movementInfo, opcode, data);

    data.SetLastMovementInfo(movementInfo);
    data.SetLastOpcode(opcode);
}

void AnticheatMgr::BuildReport(Player* player, uint32 reportType, uint32 reportCount)
{
    std::stringstream str;
    WorldSession* session = player->GetSession();
    ChatHandler chat = ChatHandler(session);

    switch (reportType)
    {
    case SPEED_HACK_REPORT:
        str << "[Speed]: " << chat.GetNameLink() << " Warnings: " << reportCount << " Latencia: " << session->GetLatency();
        break;
    case FLY_HACK_REPORT:
        str << "[Fly]: " << chat.GetNameLink() << " Warnings: " << reportCount << " Latencia: " << session->GetLatency();
        break;
    case TELEPORT_HACK_REPORT:
    case TELEPORT_PLANE_HACK_REPORT:
        str << "[Teleport]: " << chat.GetNameLink() << " Warnings: " << reportCount << " Latencia: " << session->GetLatency();
        break;
    case WALK_WATER_HACK_REPORT:
        str << "[WalkOnWater]: " << chat.GetNameLink() << " Warnings: " << reportCount << " Latencia: " << session->GetLatency();
        break;
    case JUMP_HACK_REPORT:
        str << "[Jump]: " << chat.GetNameLink() << " Warnings: " << reportCount << " Latencia: " << session->GetLatency();
        break;
    case CLIMB_HACK_REPORT:
        str << "[Climb]: " << chat.GetNameLink() << " Warnings: " << reportCount << " Latencia: " << session->GetLatency();
        break;
    default:
        break;
    }

    SendReportToAll(str.str().c_str(), reportType);
}

void AnticheatMgr::SendReportToAll(const char* report, uint32 reportType)
{
    uint32 playerFlags;
    switch (reportType)
    {
        case SPEED_HACK_REPORT: // Speed
            playerFlags = PLAYER_FLAGS_UNK29;
            break;
        case FLY_HACK_REPORT: // Fly
            playerFlags = PLAYER_FLAGS_UNK28;
            break;
        case TELEPORT_HACK_REPORT: // Tele
        case TELEPORT_PLANE_HACK_REPORT:
            playerFlags = PLAYER_FLAGS_UNK26;
            break;
        default:
            return;
    }

    SessionMap const& sessions = sWorld->GetAllSessions();
    for (SessionMap::const_iterator itr = sessions.begin(); itr != sessions.end(); itr++)
    {
        Player* player = itr->second->GetPlayer();
        if (!player || itr->second->GetSecurity() < SEC_GAMEMASTER || !player->IsInWorld() || !player->HasFlag(PLAYER_FLAGS, playerFlags))
            continue;
        ChatHandler(itr->second).SendSysMessage(report);
    }
}

void AnticheatMgr::Update(uint32 diff)
{
    if (updateTime < diff)
    {
        uint32 msTime = getMSTime();
        AnticheatReported::iterator next = m_Reports.begin();
        for (AnticheatReported::iterator itr = m_Reports.begin(); itr != m_Reports.end(); itr = next)
        {
            next++;
            if (getMSTimeDiff(itr->second, msTime) < 5000)
                continue;

            if (Player* player = sObjectMgr->GetPlayerByLowGUID(itr->first))
            {
                uint32 reportType = 0;
                uint32 reportCount = 0;
                AnticheatData& data = m_Players[itr->first];
                // Solo utilizamos el reporte maximo
                for (uint8 i = 0; i < MAX_REPORT_TYPES; i++)
                {
                    uint32 count = data.GetTypeReports(i);
                    if (count > reportCount)
                    {
                        reportType = i;
                        reportCount = count;
                    }

                    data.SetTypeReports(i, 0);
                }

                BuildReport(player, reportType, reportCount);
            }
            m_Reports.erase(itr);
        }

        updateTime = 2 * IN_MILLISECONDS;
    }
    else updateTime -= diff;

}

void AnticheatMgr::IncreaseReport(Player* player, AnticheatData& data, uint8 reportType)
{
    data.SetTypeReports(reportType, data.GetTypeReports(reportType) + 1);
    if (m_Reports.find(player->GetGUIDLow()) == m_Reports.end())
        m_Reports[player->GetGUIDLow()] = getMSTime();
}

void AnticheatMgr::StartScripts()
{
    new AnticheatScripts();
}

void AnticheatMgr::HandlePlayerLogin(Player* player)
{
    m_Players[player->GetGUIDLow()].SetPosition(player->GetPositionX(),player->GetPositionY(),player->GetPositionZ(),player->GetOrientation());
}

void AnticheatMgr::HandlePlayerLogout(Player* player)
{
    // Delete not needed data from the memory.
    m_Players.erase(player->GetGUIDLow());
    m_Reports.erase(player->GetGUIDLow());
}