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

#include "ScriptMgr.h"
#include "ArenaTeamMgr.h"
#include "Common.h"
#include "DisableMgr.h"
#include "BattlegroundMgr.h"
#include "Battleground.h"
#include "ArenaTeam.h"
#include "Language.h"
#include "battleground_soloqueue.h"
#include "BattlegroundQueue.h"


class battleground_solo_queue : public CreatureScript
{
public:
    battleground_solo_queue() : CreatureScript("battleground_solo_queue")
    {
        for (int i = 0; i < MAX_TALENT_CAT; i++)
            cache3v3Queue[i] = 0;

        lastFetchQueueList = 0;
    }

    bool OnGossipHello(Player* player, Creature* me)
    {
        if (!player || !me)
            return true;

        if (sWorld->getBoolConfig(CONFIG_SOLO_3V3_ENABLE) == false)
        {
            ChatHandler(player->GetSession()).SendSysMessage("Script Disabled");
            return true;
        }

        fetchQueueList();
        std::stringstream infoQueue;
        infoQueue << "Solo 3v3 Arena\n";
        infoQueue << "Queued Players: " << (cache3v3Queue[MELEE] + cache3v3Queue[RANGE] + cache3v3Queue[HEALER]);

        if (sWorld->getBoolConfig(CONFIG_SOLO_3V3_FILTER_TALENTS))
        {
            infoQueue << "\n\n";
            infoQueue << "Queued Melees: " << cache3v3Queue[MELEE] << "\n";
            infoQueue << "Queued Casters: " << cache3v3Queue[RANGE] << "\n";
            infoQueue << "Queued Healers: " << cache3v3Queue[HEALER] << "\n";
        }

        if (player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_5v5)
            || player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_3v3_SOLO))
			player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_TALK, "Leave Solo queue / 1v1", GOSSIP_SENDER_MAIN, 3, "Are you sure you want to remove the solo queue / 1v1?", 0, false);

        if (player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_5v5) == false &&
            player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_3v3_SOLO) == false)
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Queue up for 1v1\n", GOSSIP_SENDER_MAIN, 21);

            if (player->GetArenaTeamId(ArenaTeam::GetSlotByType(ARENA_TEAM_5v5)) == NULL)
				player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Create new Solo arena team", GOSSIP_SENDER_MAIN, 1, "Create new solo arena team?", sWorld->getIntConfig(CONFIG_SOLO_3V3_COSTS), false);
            else
            {
                //player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Anotar 1v1 Arena\n", GOSSIP_SENDER_MAIN, 20);
				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Queue up for 3vs3 Arena Solo\n", GOSSIP_SENDER_MAIN, 2);
            }
        }

        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, infoQueue.str().c_str(), GOSSIP_SENDER_MAIN, 0);
        player->SEND_GOSSIP_MENU(68, me->GetGUID());
        return true;
    }
    
    bool OnGossipSelect(Player* player, Creature* me, uint32 /*uiSender*/, uint32 uiAction)
    {
        if (!player || !me)
            return true;

        player->PlayerTalkClass->ClearMenus();

        switch (uiAction)
        {
        case 1: // Create new Arenateam
        {
            if (sWorld->getIntConfig(CONFIG_SOLO_3V3_MIN_LEVEL) <= player->getLevel())
            {
                if (player->GetMoney() >= sWorld->getIntConfig(CONFIG_SOLO_3V3_COSTS) && CreateArenateam(player, me))
                    player->ModifyMoney(sWorld->getIntConfig(CONFIG_SOLO_3V3_COSTS) * -1);
            }
            else
            {
				ChatHandler(player->GetSession()).PSendSysMessage("You need level %u+ to create an arena team.", sWorld->getIntConfig(CONFIG_SOLO_3V3_MIN_LEVEL));
                player->CLOSE_GOSSIP_MENU();
                return true;
            }
        }
            break;

        case 2: // 3v3 Join Queue Arena (rated)
        {
            // check Deserter debuff
            if (player->HasAura(26013) &&
                (sWorld->getBoolConfig(CONFIG_SOLO_3V3_CAST_DESERTER_ON_AFK) || sWorld->getBoolConfig(CONFIG_SOLO_3V3_CAST_DESERTER_ON_LEAVE)))
            {
                WorldPacket data;
                sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, ERR_GROUP_JOIN_BATTLEGROUND_DESERTERS);
                player->GetSession()->SendPacket(&data);
            }
            else
                if (ArenaCheckFullEquipAndTalents(player)
                    && JoinQueueArena(player, me, true, ARENA_TYPE_3v3_SOLO) == false)
					ChatHandler(player->GetSession()).SendSysMessage("Something went wrong while joining queue. Already in another queue?");

            player->CLOSE_GOSSIP_MENU();
            return true;
        }

        case 20: // 1v1 Join Queue Arena (rated)
        {
            if (ArenaCheckFullEquipAndTalents(player) && Arena1v1CheckTalents(player)
                && JoinQueueArena(player, me, true, ARENA_TYPE_5v5) == false)
                ChatHandler(player->GetSession()).SendSysMessage("Something went wrong while trying to join the queue. Check that you are not in another queue?.");

            player->CLOSE_GOSSIP_MENU();
            return true;
        }

        case 21: // 1v1 Join Queue Skirmish
        {
            if (ArenaCheckFullEquipAndTalents(player) && Arena1v1CheckTalents(player)
                && JoinQueueArena(player, me, false, ARENA_TYPE_5v5) == false)
				ChatHandler(player->GetSession()).SendSysMessage("Something went wrong while trying to join the queue. Check that you are not in another queue?.");

            player->CLOSE_GOSSIP_MENU();
            return true;
        }

        case 3: // Leave Queue
        {
            uint8 arenaType = ARENA_TYPE_5v5;
            if (player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_3v3_SOLO))
                arenaType = ARENA_TYPE_3v3_SOLO;

            WorldPacket Data;
            Data << arenaType << (uint8)0x0 << (uint32)BATTLEGROUND_AA << (uint16)0x0 << (uint8)0x0;
            player->GetSession()->HandleBattleFieldPortOpcode(Data);
            player->CLOSE_GOSSIP_MENU();
            return true;
        }
        }

        OnGossipHello(player, me);
        return true;
    }

private:
    int cache3v3Queue[MAX_TALENT_CAT];
    uint32 lastFetchQueueList;

    bool ArenaCheckFullEquipAndTalents(Player* player)
    {
        if (!player)
            return false;

        if (player->IsGameMaster())
            return true;

        if (sWorld->getBoolConfig(CONFIG_ARENA_CHECK_EQUIP_AND_TALENTS) == false)
            return true;

        std::stringstream err;

        if (player->GetFreeTalentPoints() > 0)
			err << "You have currently " << player->GetFreeTalentPoints() << " free talent points. Please spend all your talent points before queueing arena.\n";

        Item* newItem = NULL;
        for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
        {
            if (slot == EQUIPMENT_SLOT_OFFHAND || slot == EQUIPMENT_SLOT_RANGED || slot == EQUIPMENT_SLOT_TABARD || slot == EQUIPMENT_SLOT_BODY)
                continue;

            newItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
            if (newItem == NULL)
            {
				err << "Your character is not fully equipped.\n";
                break;
            }
        }

        if (err.str().length() > 0)
        {
            ChatHandler(player->GetSession()).SendSysMessage(err.str().c_str());
            return false;
        }
        return true;
    }


    bool JoinQueueArena(Player* player, Creature* me, bool isRated, uint8 arenatype)
    {
        if (!player || !me)
            return false;

        if (sWorld->getIntConfig(CONFIG_SOLO_3V3_MIN_LEVEL) > player->getLevel())
            return false;

        uint64 guid = player->GetGUID();
        uint8 arenaslot = ArenaTeam::GetSlotByType(ARENA_TEAM_5v5);
        uint32 arenaRating = 0;
        uint32 matchmakerRating = 0;

        // ignore if we already in BG or BG queue
        if (player->InBattleground() || player->InBattlegroundQueue())
            return false;

        //check existance
        Battleground* bg = sBattlegroundMgr->GetBattlegroundTemplate(BATTLEGROUND_AA);
        if (!bg)
            return false;

        if (DisableMgr::IsDisabledFor(DISABLE_TYPE_BATTLEGROUND, BATTLEGROUND_AA, NULL))
        {
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_ARENA_DISABLED);
            return false;
        }

        BattlegroundTypeId bgTypeId = bg->GetTypeID();
        BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(bgTypeId, arenatype);
        PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketByLevel(bg->GetMapId(), player->getLevel());
        if (!bracketEntry)
            return false;

        // check if already in queue
        if (player->GetBattlegroundQueueIndex(bgQueueTypeId) < PLAYER_MAX_BATTLEGROUND_QUEUES)
            //player is already in this queue
            return false;
        // check if has free queue slots
        if (!player->HasFreeBattlegroundQueueId())
            return false;

        uint32 ateamId = 0;

        if (isRated)
        {
            ateamId = player->GetArenaTeamId(arenaslot);
            ArenaTeam* at = sArenaTeamMgr->GetArenaTeamById(ateamId);
            if (!at)
            {
                player->GetSession()->SendNotInArenaTeamPacket(arenatype);
                return false;
            }

            // get the team rating for queueing
            arenaRating = at->GetRating();
            matchmakerRating = at->GetAverageMMR();
            // the arenateam id must match for everyone in the group

            if (arenaRating <= 0)
                arenaRating = 1;
        }

        BattlegroundQueue &bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);
        bg->SetRated(isRated);

        GroupQueueInfo* ginfo = bgQueue.AddGroup(player, NULL, bgTypeId, bracketEntry, arenatype, isRated, false, arenaRating, matchmakerRating, ateamId);
        uint32 avgTime = bgQueue.GetAverageQueueWaitTime(ginfo, bracketEntry->GetBracketId());
        uint32 queueSlot = player->AddBattlegroundQueueId(bgQueueTypeId, true);

        WorldPacket data;
        // send status packet (in queue)
        sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_WAIT_QUEUE, avgTime, 0, arenatype, 0);
        player->GetSession()->SendPacket(&data);

        sBattlegroundMgr->ScheduleQueueUpdate(matchmakerRating, arenatype, bgQueueTypeId, bgTypeId, bracketEntry->GetBracketId());

        return true;
    }


    bool CreateArenateam(Player* player, Creature* me)
    {
        if (!player || !me)
            return false;

        uint8 slot = ArenaTeam::GetSlotByType(ARENA_TEAM_5v5);
        if (slot >= MAX_ARENA_SLOT)
            return false;

        // Check if player is already in an arena team
        if (player->GetArenaTeamId(slot))
        {
            player->GetSession()->SendArenaTeamCommandResult(ERR_ARENA_TEAM_CREATE_S, player->GetName(), "", ERR_ALREADY_IN_ARENA_TEAM);
            return false;
        }

        // Teamname = playername
        // if team name exist, we have to choose another name (playername + number)
        int i = 1;
        std::stringstream teamName;
        teamName << player->GetName();
        do
        {
            if (sArenaTeamMgr->GetArenaTeamByName(teamName.str()) != NULL) // teamname exist, so choose another name
            {
                teamName.str(std::string());
                teamName << player->GetName() << i++;
            }
            else
                break;
        } while (i < 100); // should never happen

        // Create arena team
        ArenaTeam* arenaTeam = new ArenaTeam();

        if (!arenaTeam->Create(player->GetGUID(), ARENA_TEAM_5v5, teamName.str(), 4283124816, 45, 4294242303, 5, 4294705149))
        {
            delete arenaTeam;
            return false;
        }

        // Register arena team
        sArenaTeamMgr->AddArenaTeam(arenaTeam);
        arenaTeam->AddMember(player->GetGUID());

		ChatHandler(player->GetSession()).SendSysMessage("Arena team successful created!");

        return true;
    }

    
    void fetchQueueList()
    {
        if (GetMSTimeDiffToNow(lastFetchQueueList) < 1000)
            return; // prevent spamming
        lastFetchQueueList = getMSTime();

        BattlegroundQueue* queue = &sBattlegroundMgr->GetBattlegroundQueue(BATTLEGROUND_QUEUE_3v3_SOLO);

        for (int i = 0; i < MAX_TALENT_CAT; i++)
            cache3v3Queue[i] = 0;

        for (uint32 k = 0; k < BG_QUEUE_GUILD_BOOL; ++k)
        for (int i = BG_BRACKET_ID_FIRST; i <= BG_BRACKET_ID_LAST; i++)
        for (int j = 0; j < 2; j++)
        {
            for (BattlegroundQueue::GroupsQueueType::iterator itr = queue->m_QueuedGroups[i][j][k].begin(); itr != queue->m_QueuedGroups[i][j][k].end(); itr++)
            {
                if ((*itr)->IsInvitedToBGInstanceGUID) // Skip when invited
                    continue;

                std::map<uint64, PlayerQueueInfo*> *grpPlr = &(*itr)->Players;
                for (std::map<uint64, PlayerQueueInfo*>::iterator grpPlrItr = grpPlr->begin(); grpPlrItr != grpPlr->end(); grpPlrItr++)
                {
                    Player* plr = sObjectAccessor->FindPlayer(grpPlrItr->first);
                    if (!plr)
                        continue;

                    Solo3v3TalentCat plrCat = GetTalentCatForSolo3v3(plr); // get talent cat
                    cache3v3Queue[plrCat]++;
                }
            }
        }
    }
};

void AddSC_battleground_solo_queue()
{
    new battleground_solo_queue();
}
