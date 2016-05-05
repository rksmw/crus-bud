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

class Boss_Announcer : public PlayerScript
{
public:
    Boss_Announcer() : PlayerScript ("Boss_Announcer") {}

    void OnCreatureKill(Player* player, Creature* boss)
    {
        if (boss->isWorldBoss())
        {
            std::string plrname = player->GetName();
            std::string bossname = boss->GetName();
            char msg[250];
            snprintf(msg, 250, "|CFF7BBEF7[Boss Announcer]|r:|cffff0000 %s |r and his group killed world boss |CFF18BE00[%s]|r !!!",plrname.c_str(),bossname.c_str());
            sWorld->SendServerMessage(SERVER_MSG_STRING, msg);
        }
    }
};

void AddSC_player_boss_announcer()
{
    // new Boss_Announcer;
}