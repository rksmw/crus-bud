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
#include "EventMgr.h"

#define EVENT_TELEPORT_ENTRY 10000100
#define EVENT_TELEPORT_NAME "ClubDeLosCinco"
#define EVENT_TICKET_SELL_BASETIME 1392163200
#define EVENT_TICKET_PER_DAY 20
#define EVENT_TICKET_COST 1000*100*100

#define MAP_ID 0
static Position TeleportPosition[2] =
{
    {-13165.392578f, 215.673553f, 43.0f, 2.164925f},
    {-13275.181641f, 290.717773f, 50.0f, 6.064428f},
};

enum Actions
{
    ACTION_NONE        = 0,
    ACTION_BUYTICKET   = 1,
    ACTION_TICKETLIMIT = 2,
    ACTION_CLOSE       = 3,

};

class PvP_Tournament_teleport : public ItemScript
{
public:
    PvP_Tournament_teleport() : ItemScript("PvP_Tournament_teleport") {}

    bool OnUse(Player* player, Item* /*item*/, SpellCastTargets const& /*targets*/)
    {
        Event* ev = sEventMgr->GetEventByName(EVENT_TELEPORT_NAME);
        if (!ev || !ev->IsVisible())
            player->GetSession()->SendNotification("El evento no se encuentra activo");
        else if (player->IsInCombat())
            player->GetSession()->SendNotification("No puedes ir al evento estando en combate");
        else if (player->isMoving() || player->IsFlying() || player->IsFalling() || player->IsInFlight())
            player->GetSession()->SendNotification("No puedes ir al evento estando en movimiento");
        else if (player->GetMap()->Instanceable() || player->GetTransport() || player->GetMap()->IsBattlegroundOrArena())
            player->GetSession()->SendNotification("No puedes ir al evento estando en este lugar");
        else
        {
            // Teleport player to event position in ally/horde
            Position pos = TeleportPosition[player->GetTeamId()];
            player->TeleportTo(MAP_ID, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation());
            player->SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_GHOST);
        }
        return true;
    }
};

class PvP_Tournament_Seller : public CreatureScript 
{
public:
    PvP_Tournament_Seller() : CreatureScript("PvP_Tournament_Seller")
    {
        // Cargamos los tickets vendidos
        QueryResult result = CharacterDatabase.Query("SELECT COUNT(*) FROM tournement_tickets WHERE teamid = 0");
        Field* fields = result->Fetch();
        ticketCount[0] = (uint32)fields[0].GetUInt64();

        result = CharacterDatabase.Query("SELECT COUNT(*) FROM tournement_tickets WHERE teamid = 1");
        fields = result->Fetch();
        ticketCount[1] = (uint32)fields[0].GetUInt64();
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        uint32 maxTicketsPerFaction = EVENT_TICKET_PER_DAY;

        if (player->IsGameMaster())
        {
            std::stringstream streamAly, streamHorde, streamMax, resetTime;
            streamAly << "Tickets alianza vendidos: " << ticketCount[TEAM_ALLIANCE];
            streamHorde << "Tickets horda vendidos: " << ticketCount[TEAM_HORDE];
            streamMax << "Tickets maximos por faccion: " << maxTicketsPerFaction;
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, streamAly.str().c_str(), GOSSIP_SENDER_MAIN, ACTION_NONE);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, streamHorde.str().c_str(), GOSSIP_SENDER_MAIN, ACTION_NONE);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, streamMax.str().c_str(), GOSSIP_SENDER_MAIN, ACTION_NONE);
        }

        if (player->GetItemCount(EVENT_TELEPORT_ENTRY) > 0)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Usted ya posee la entrada", GOSSIP_SENDER_MAIN, ACTION_CLOSE);
        else if (ticketCount[player->GetTeamId()] >= maxTicketsPerFaction)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Se han vendido todas las entradas del dia", GOSSIP_SENDER_MAIN, ACTION_CLOSE);
        else
        {
            // Vemos si ya se a comprado un item en esta ip
            uint32 ip = inet_addr(player->GetSession()->GetRemoteAddress().c_str());
            EndianConvertReverse(ip);
            QueryResult result = CharacterDatabase.PQuery("SELECT COUNT(*) FROM tournement_tickets WHERE ip = %u", ip);
            if (!result)
                return true;

            Field* fields = result->Fetch();
            uint32 count = (uint32)fields[0].GetUInt64();

            if (count > 0)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Usted ya a comprado la entrada con otro personaje", GOSSIP_SENDER_MAIN, ACTION_CLOSE);
            else
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Comprar entrada torneo PvP (1000 oro)", GOSSIP_SENDER_MAIN, ACTION_BUYTICKET);
        }
        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
    {
        if (action != ACTION_NONE)
            player->PlayerTalkClass->ClearMenus();

        switch (action)
        {
        case ACTION_NONE:
            return true;
        case ACTION_CLOSE:
            player->PlayerTalkClass->SendCloseGossip();
            return true;
        case ACTION_BUYTICKET:
            {
                uint32 delta = time(NULL) - EVENT_TICKET_SELL_BASETIME;
                uint32 maxTicketsPerFaction = EVENT_TICKET_PER_DAY * ((uint32)(delta/DAY) + 1);

                if (ticketCount[player->GetTeamId()] >= maxTicketsPerFaction)
                    return OnGossipSelect(player, creature, sender, ACTION_TICKETLIMIT);
                if (player->GetMoney() < EVENT_TICKET_COST)
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Usted no posee dinero suficiente para comprar la entrada", GOSSIP_SENDER_MAIN, ACTION_CLOSE);
                else if (AddTicket(player))
                {
                    player->ModifyMoney(-EVENT_TICKET_COST);
                    player->SaveToDB();

                    uint32 ip = inet_addr(player->GetSession()->GetRemoteAddress().c_str());
                    EndianConvertReverse(ip);
                    CharacterDatabase.PExecute("INSERT INTO tournement_tickets (ip, teamid) VALUES (%u, %u)", ip, player->GetTeamId());

                    ticketCount[player->GetTeamId()] += 1;
                    return OnGossipSelect(player, creature, sender, ACTION_CLOSE);
                }
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "A ocurrido un error comprando el ticket", GOSSIP_SENDER_MAIN, ACTION_CLOSE);
                break;
            }
        case ACTION_TICKETLIMIT:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Se han vendido todas las entradas del dia", GOSSIP_SENDER_MAIN, ACTION_CLOSE);
            break;
        }

        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        return true;
    }

    bool AddTicket(Player* player)
    {
        const ItemTemplate* itemTemplate = sObjectMgr->GetItemTemplate(EVENT_TELEPORT_ENTRY);
        if (!itemTemplate)
            return false;

        ItemPosCountVec dest;
        InventoryResult msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, EVENT_TELEPORT_ENTRY, 1);
        if (msg == EQUIP_ERR_OK)
        {
            if (!dest.empty())
            {
                player->SendNewItem(player->StoreNewItem(dest, EVENT_TELEPORT_ENTRY, true), 1, true, true);
                return true;
            }
        }
        else
            player->SendEquipError(msg, NULL, NULL, EVENT_TELEPORT_ENTRY);
        return false;
    }

private:
    uint32 ticketCount[2];
};

void AddSC_events_pvp_tournament()
{
    new PvP_Tournament_teleport();
    new PvP_Tournament_Seller();
}
