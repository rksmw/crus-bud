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

class player_store_announcer : public PlayerScript
{
public:
    player_store_announcer() : PlayerScript("player_store_announcer") { }

    void OnLogin(Player* player)
    {
        if (!player)
            return;

        PreparedStatement* stmt;

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ORDERS_COUNT);
        stmt->setUInt32(0, player->GetSession()->GetAccountId());
        PreparedQueryResult result = CharacterDatabase.Query(stmt);

        if (result)
        {
            Field* fields = result->Fetch();
            uint32 orders = fields[0].GetUInt32();

            if (orders > 0)
            {
                ChatHandler(player->GetSession()).SendSysMessage("[Battle.cl - Tienda]");
                ChatHandler(player->GetSession()).PSendSysMessage("Ordenes pendientes: %u", orders);
            }
        }
    }
};

void AddSC_player_store_announcer()
{
    new player_store_announcer();
}
