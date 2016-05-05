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
#include "Channel.h"
#include "Player.h"
#include <sstream>

class channel_factions : public PlayerScript
{
    public:
        channel_factions() : PlayerScript("channel_factions") { }

    void OnChat(Player* player, uint32 /*type*/, uint32 lang, std::string& msg, Channel* channel)
    {
        if (!player || !channel)
            return;

        std::stringstream ssMsg;
        ssMsg << ((player->GetTeam() == HORDE) ? "|TInterface\\PVPFrame\\PVP-Currency-Horde:18:18:-3:-3|t" : "|TInterface\\PVPFrame\\PVP-Currency-Alliance:18:18:-3:-3|t") << msg;
        msg = ssMsg.str();
    }
};

void AddSC_player_icon_channel()
{
    /*new channel_factions();*/
}
