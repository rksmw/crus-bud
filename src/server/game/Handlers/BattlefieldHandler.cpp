/*
 * Copyright (C) 2008-2013 TrinityCore <http://www.trinitycore.org/>
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

#include "Common.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Battlefield.h"
#include "BattlefieldMgr.h"
#include "Opcodes.h"

/*
 * Invitacion a la Batalla
 */

// Enviar de inivtacion a la batalla
void WorldSession::SendBfInvitePlayerToBattle(uint32 battleId, uint32 zoneId, uint32 timer)
{
    TC_LOG_DEBUG(LOG_FILTER_NETWORKIO, "WORLD: Send SMSG_BATTLEFIELD_MGR_ENTRY_INVITE (BattleId: %u ZoneId: %u, Timer: %u)", battleId, zoneId, timer);

    WorldPacket data(SMSG_BATTLEFIELD_MGR_ENTRY_INVITE, 12);
    // Id del Battlefield
    data << uint32(battleId);
    // Id de la Zona del Battlefield
    data << uint32(zoneId);
    // Tiempo para aceptar
    data << uint32((time(NULL) + timer));
    SendPacket(&data);
}

// Recepcionar respuesta de invitacion a la batalla
void WorldSession::HandleBfBattleInviteResponse(WorldPacket & recvData)
{
    uint32 battleId;
    uint8 accepted;
    recvData >> battleId >> accepted;

    TC_LOG_DEBUG(LOG_FILTER_NETWORKIO, "WORLD: Recvd CMSG_BATTLEFIELD_MGR_ENTRY_INVITE_RESPONSE (BattleId: %u Accepted: %u)", battleId, accepted);

    if (!_player)
        return;

    Battlefield* bf = sBattlefieldMgr->GetBattlefieldByBattleId(battleId);
    if (!bf)
        return;

    if (accepted)
        bf->AddPlayerToBattle(_player);
    else
        bf->RemovePlayer(_player);
}

// Enviar resultado de recepcion de la respuesta a la batalla
void WorldSession::SendBfBattleInviteResponse(uint32 battleId)
{
    TC_LOG_DEBUG(LOG_FILTER_NETWORKIO, "WORLD: Send SMSG_BATTLEFIELD_MGR_ENTERED (BattleId: %u)", battleId);

    if (!_player)
        return;

    WorldPacket data(SMSG_BATTLEFIELD_MGR_ENTERED, 7);
    // Id del Battlefield
    data << uint32(battleId);
    // UNK
    data << uint8(1);
    // UNK
    data << uint8(1);
    // Limpiar estado AFK
    data << uint8(_player->isAFK() ? 1 : 0);

    SendPacket(&data);
}

/*
 * Invitacion a la Cola
 */

// Enviar de inivtacion a la cola
void WorldSession::SendBfInvitePlayerToQueue(uint32 battleId)
{
    TC_LOG_DEBUG(LOG_FILTER_NETWORKIO, "WORLD: Send SMSG_BATTLEFIELD_MGR_QUEUE_INVITE (BattleId: %u)", battleId);

    WorldPacket data(SMSG_BATTLEFIELD_MGR_QUEUE_INVITE, 5);
    // Id del Battlefield
    data << uint32(battleId);
    // Warmup
    data << uint8(1);
    SendPacket(&data);
}

// Recepcionar respuesta de invitacion a la cola
void WorldSession::HandleBfQueueInviteResponse(WorldPacket & recvData)
{
    uint32 battleId;
    uint8 accepted;
    recvData >> battleId >> accepted;

    TC_LOG_DEBUG(LOG_FILTER_NETWORKIO, "WORLD: Recvd CMSG_BATTLEFIELD_MGR_QUEUE_INVITE_RESPONSE (BattleId: %u Accepted: %u)", battleId, accepted);

    if (!_player)
        return;

    Battlefield* bf = sBattlefieldMgr->GetBattlefieldByBattleId(battleId);
    if (!bf)
        return;

    if (accepted)
        bf->AddPlayerToQueue(_player);
    else if (bf->IsBattleTime())
        bf->RemovePlayer(_player);
}

// Enviar resultado de recepcion de la respuesta a la cola
void WorldSession::SendBfQueueInviteResponse(uint32 battleId, uint32 zoneId, BattlefieldQueueResponses response)
{
    TC_LOG_DEBUG(LOG_FILTER_NETWORKIO, "WORLD: Send SMSG_BATTLEFIELD_MGR_QUEUE_REQUEST_RESPONSE (BattleId: %u ZoneId: %u)", battleId, zoneId);

    WorldPacket data(SMSG_BATTLEFIELD_MGR_QUEUE_REQUEST_RESPONSE, 11);
    // Id del Battlefield
    data << uint32(battleId);
    // Id de la Zona del Battlefield
    data << uint32(zoneId);

    switch (response)
    {
        case BF_QUEUE_RESPONSE_SUCCESS:
            data << uint8(1);
            break;
        case BF_QUEUE_RESPONSE_FULL:
            data << uint16(1);
            break;
        case BF_QUEUE_RESPONSE_FAILED:
        default:
            data << uint16(0);
    }

    // Warmup ?? unused
    //data << uint8(1);
    SendPacket(&data);
}

// Recepcionar solicitud a la cola
void WorldSession::HandleBfQueueRequest(WorldPacket & recvData)
{
    uint32 battleId;
    recvData >> battleId;
    TC_LOG_DEBUG(LOG_FILTER_NETWORKIO, "WORLD: Recvd CMSG_BATTLEFIELD_MGR_QUEUE_REQUEST (BattleId: %u)", battleId);

    Battlefield* bf = sBattlefieldMgr->GetBattlefieldByBattleId(battleId);
    if (!bf || !_player)
        return;

    bf->InvitePlayer(_player);
}

/*
 * Expulsion del Battlfield
 */

// Recepcion de solicitud de salida (de la cola)
void WorldSession::HandleBfExitRequest(WorldPacket & recvData)
{
    uint32 battleId;
    recvData >> battleId;

    TC_LOG_DEBUG(LOG_FILTER_NETWORKIO, "WORLD: Recvd CMSG_BATTLEFIELD_MGR_EXIT_REQUEST (BattleId: %u)", battleId);

    Battlefield* bf = sBattlefieldMgr->GetBattlefieldByBattleId(battleId);
    if (!bf || !_player)
        return;

    bf->RemovePlayerFromQueue(_player);
}

void WorldSession::SendBfLeavePending(uint32 battleId)
{
    TC_LOG_DEBUG(LOG_FILTER_NETWORKIO, "WORLD: Send SMSG_BATTLEFIELD_MGR_EJECT_PENDING (BattleId: %u)", battleId);

    Battlefield* bf = sBattlefieldMgr->GetBattlefieldByBattleId(battleId);
    if (!bf)
        return;

    WorldPacket data(SMSG_BATTLEFIELD_MGR_EJECT_PENDING, 5);
    // Id del Battlefield
    data << uint32(battleId);
    // 0 -> Conquista del invierno esta llena. Estas en cola pero aun no te han llamado para la batalla. Se te teletransportara fuera en breves instantes.
    // 1 -> Conquista del Invierno esta llena. Estas en cola pero aun no te han llamado para la batalla.
    data << uint8(bf->HasPlayerInZone(_player) ? 0 : 1);
    SendPacket(&data);
}


// Enviar mensajes de salida
void WorldSession::SendBfLeaveMessage(uint32 battleId, BattlefieldLeaveReason reason)
{
    TC_LOG_DEBUG(LOG_FILTER_NETWORKIO, "WORLD: Send SMSG_BATTLEFIELD_MGR_EJECTED (BattleId: %u)", battleId);

    Battlefield* bf = sBattlefieldMgr->GetBattlefieldByBattleId(battleId);
    if (!bf)
        return;

    WorldPacket data(SMSG_BATTLEFIELD_MGR_EJECTED, 7);
    // Id del Battlefield
    data << uint32(battleId);
    // Razon
    switch (reason)
    {
        default:
        case BF_LEAVE_REASON_EXITED:
            data << uint8(8);
            data << uint8(2);
            break;
        case BF_LEAVE_REASON_LOW_LEVEL:
            data << uint8(10);
            break;
    }

    // Relocated
    data << uint8(0);
    SendPacket(&data);
}

void WorldSession::HandleBfManagerAdvanceState(WorldPacket & recvData)
{
    TC_LOG_DEBUG(LOG_FILTER_NETWORKIO, "WORLD: Recvd CMSG_BATTLEFIELD_MANAGER_ADVANCE_STATE (Size: %u)", (unsigned long)recvData.size());
}

void WorldSession::HandleBfManagerTransitionTime(WorldPacket & recvData)
{
    TC_LOG_DEBUG(LOG_FILTER_NETWORKIO, "WORLD: Recvd CMSG_BATTLEFIELD_MANAGER_SET_NEXT_TRANSITION_TIME (Size: %u)", (unsigned long)recvData.size());
}
