/*
 * Copyright (C) 2010-2014 BattleCore3 <http://www.battle.cl/>
 *
 * BattleCore es un proyecto privado basado en TrinityCore
 * que tiene como finalidad el desarrollo de WoWChile, el estudio
 * y la practica de la informatica en World of Warcraft.
 *
 *  ____        _   _   _         ____                
 * | __ )  __ _| |_| |_| | ___   / ___|___  _ __ ___  
 * |  _ \ / _` | __| __| |/ _ \ | |   / _ \| '__/ _ \
 * | |_) | (_| | |_| |_| |  __/ | |__| (_) | | |  __/ 
 * |____/ \__,_|\__|\__|_|\___|  \____\___/|_|  \___|
 *                                               _____
 *                                              |__  /
 *                                               /_ < 
 *                                             ___/ / 
 *                                            /____/  
 */

#include "ScriptPCH.h"
#include "Battleground.h"
#include "BattlegroundMgr.h"
#include "Chat.h"
#include "GuildMgr.h"
#include "DisableMgr.h"
#include "Group.h"
#include "Language.h"

#define GOSSIP_ITEM_1   "Arathi Basin"
#define GOSSIP_ITEM_2   "Warsong Gulch"
#define GOSSIP_ITEM_3   "Arathi Basin (Grupo)"
#define GOSSIP_ITEM_4   "Warsong Gulch (Grupo)"

enum GossipActions
{
    GOSSIP_ACTION_1 = 1001,
    GOSSIP_ACTION_2 = 1002,
    GOSSIP_ACTION_3 = 1003,
    GOSSIP_ACTION_4 = 1004
};

class npc_battlemaster_guildwars : public CreatureScript
{
public:
    npc_battlemaster_guildwars() : CreatureScript("npc_battlemaster_guildwars") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_1);
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_2);
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_3);
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_4);

        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action) OVERRIDE
    {
        player->PlayerTalkClass->ClearMenus();

        if (player->IsInCombat())
        {
            player->GetSession()->SendNotification("No puedes hacer esto mientras estas en combate");
            player->CLOSE_GOSSIP_MENU();
            return true;
        }

        if (!player->GetGuild())
        {
            player->GetSession()->SendNotification("No puedes unirte a la cola sin estar en una Hermandad/Guild");
            player->CLOSE_GOSSIP_MENU();
            return true;
        }

        BattlegroundTypeId choice;
        bool isGrp;

        switch (action)
        {
            case GOSSIP_ACTION_1:
                choice = BATTLEGROUND_AB;
                isGrp = false;
                break;
            case GOSSIP_ACTION_2:
                choice = BATTLEGROUND_WS;
                isGrp = false;
                break;
            case GOSSIP_ACTION_3:
                choice = BATTLEGROUND_AB;
                isGrp = true;
                break;
            case GOSSIP_ACTION_4:
                choice = BATTLEGROUND_WS;
                isGrp = true;
                break;
            default:
                player->GetSession()->SendNotification("No haz seleccionado un Campo de Batalla/Battle Ground valido");
                player->CLOSE_GOSSIP_MENU();
                return true;
        }

        if (isGrp && !player->GetGroup())
        {
            player->GetSession()->SendNotification("No esta en un Grupo/Party o Banda/Raid");
            player->CLOSE_GOSSIP_MENU();
            return true;
        }

        BattlegroundGuildWars(choice, player, isGrp);

        player->CLOSE_GOSSIP_MENU();

        return true;
    }

    void BattlegroundGuildWars(BattlegroundTypeId bgTypeId, Player* player, bool isGrp)
    {
        if (!player)
            return;

        bool isPremade = false;
        uint32 guildId = player->GetGuildId();
        if (!guildId)
            return;

        BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(bgTypeId, 0);
        BattlegroundQueueTypeId bgQueueTypeIdRandom = BattlegroundMgr::BGQueueTypeId(BATTLEGROUND_RB, 0);

        if (DisableMgr::IsDisabledFor(DISABLE_TYPE_BATTLEGROUND, bgTypeId, NULL))
        {
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_BG_DISABLED);
            return;
        }

        // get bg template
        Battleground *bg = NULL;
        bg = sBattlegroundMgr->GetBattlegroundTemplate(bgTypeId);
        if (!bg)
            return;

        PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketByLevel(bg->GetMapId(), player->getLevel());
        if (!bracketEntry)
            return;

        GroupJoinBattlegroundResult err;

        // ignore if player is already in BG
        if (player->InBattleground())
            return;

        if (!isGrp)
        {
            if (player->isUsingLfg())
            {
                // player is using dungeon finder or raid finder
                WorldPacket data;
                sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, ERR_LFG_CANT_USE_BATTLEGROUND);
                player->GetSession()->SendPacket(&data);
                return;
            }

            // check Deserter debuff
            if (!player->CanJoinToBattleground(bg))
            {
                WorldPacket data;
                sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, ERR_GROUP_JOIN_BATTLEGROUND_DESERTERS);
                player->GetSession()->SendPacket(&data);
                return;
            }

            if (player->GetBattlegroundQueueIndex(bgQueueTypeIdRandom) < PLAYER_MAX_BATTLEGROUND_QUEUES)
            {
                // player is already in random queue
                WorldPacket data;
                sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, ERR_IN_RANDOM_BG);
                player->GetSession()->SendPacket(&data);
                return;
            }

            if (player->InBattlegroundQueue() && bgTypeId == BATTLEGROUND_RB)
            {
                // player is already in queue, can't start random queue
                WorldPacket data;
                sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, ERR_IN_NON_RANDOM_BG);
                player->GetSession()->SendPacket(&data);
                return;
            }

            // check if already in queue
            if (player->GetBattlegroundQueueIndex(bgQueueTypeId) < PLAYER_MAX_BATTLEGROUND_QUEUES)
                // player is already in this queue
                return;

            // check if has free queue slots
            if (!player->HasFreeBattlegroundQueueId())
            {
                WorldPacket data;
                sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, ERR_BATTLEGROUND_TOO_MANY_QUEUES);
                player->GetSession()->SendPacket(&data);
                return;
            }

            BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);

            GroupQueueInfo* ginfo = bgQueue.AddGroup(player, NULL, bgTypeId, bracketEntry, 0, false, isPremade, 0, 0, 0, guildId);
            uint32 avgTime = bgQueue.GetAverageQueueWaitTime(ginfo, bracketEntry->GetBracketId());
            // already checked if queueSlot is valid, now just get it
            uint32 queueSlot = player->AddBattlegroundQueueId(bgQueueTypeId, true);

            WorldPacket data;
                                                                // send status packet (in queue)
            sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_WAIT_QUEUE, avgTime, 0, ginfo->ArenaType, 0);
            player->GetSession()->SendPacket(&data);
            sLog->outDebug(LOG_FILTER_BATTLEGROUND, "Battleground: player joined queue for bg queue type %u bg type %u: GUID %u, NAME %s", bgQueueTypeId, bgTypeId, player->GetGUIDLow(), player->GetName().c_str());
        }
        else
        {
            Group * grp = player->GetGroup();
            // no group found, error
            if (!grp)
                return;
            if (grp->GetLeaderGUID() != player->GetGUID())
                return;
            for (GroupReference *itr = grp->GetFirstMember(); itr != NULL; itr = itr->next())
            {
                Player* member = itr->GetSource();
                if (!member)
                    continue;   // this should never happen

                if (player->GetGuildId() != member->GetGuildId())
                {
                    ChatHandler(member->GetSession()).PSendSysMessage(LANG_GUILD_NOT_CREATED);
                    return;
                }
            }
            err = grp->CanJoinBattlegroundQueue(bg, bgQueueTypeId, 0, bg->GetMaxPlayersPerTeam(), false, 0);
            isPremade = (grp->GetMembersCount() >= bg->GetMinPlayersPerTeam());
            BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);
            GroupQueueInfo* ginfo = NULL;
            uint32 avgTime = 0;

            if (err > 0)
            {
                sLog->outDebug(LOG_FILTER_BATTLEGROUND, "Battleground: the following players are joining as group:");
                ginfo = bgQueue.AddGroup(player, grp, bgTypeId, bracketEntry, 0, false, isPremade, 0, 0, 0, guildId);
                avgTime = bgQueue.GetAverageQueueWaitTime(ginfo, bracketEntry->GetBracketId());
            }

            for (GroupReference *itr = grp->GetFirstMember(); itr != NULL; itr = itr->next())
            {
                Player* member = itr->GetSource();
                if (!member)
                    continue;   // this should never happen

                WorldPacket data;

                if (err <= 0)
                {
                    sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, err);
                    member->GetSession()->SendPacket(&data);
                    continue;
                }

                // add to queue
                uint32 queueSlot = member->AddBattlegroundQueueId(bgQueueTypeId, false);
                // send status packet (in queue)
                sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_WAIT_QUEUE, avgTime, 0, ginfo->ArenaType, 0);
                member->GetSession()->SendPacket(&data);
                sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, err);
                member->GetSession()->SendPacket(&data);
                sLog->outDebug(LOG_FILTER_BATTLEGROUND, "Battleground: player joined queue for bg queue type %u bg type %u: GUID %u, NAME %s", bgQueueTypeId, bgTypeId, member->GetGUIDLow(), member->GetName().c_str());
            }
            sLog->outDebug(LOG_FILTER_BATTLEGROUND, "Battleground: group end");
        }
        sBattlegroundMgr->ScheduleQueueUpdate(0, 0, bgQueueTypeId, bgTypeId, bracketEntry->GetBracketId());
    }
};

void AddSC_battleground_npc_battlemaster_guildwars()
{
    new npc_battlemaster_guildwars();
}
