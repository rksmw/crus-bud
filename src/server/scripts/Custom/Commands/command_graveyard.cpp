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

class command_graveyard : public CommandScript
{
public:
    command_graveyard() : CommandScript("command_graveyard") { }

    ChatCommand* GetCommands() const
    {
        static ChatCommand commandTable[] =
        {
            { "cementerio",             RBAC_PERM_COMMAND_GRAVEYARD,             false, &HandleGraveyard,                  "", NULL},
            { NULL,                     0,                                       false, NULL,                              "", NULL}
        };

        return commandTable;
    }

    // .cementerio
    static bool HandleGraveyard(ChatHandler* handler, const char* args)
    {
        Player* player = handler->GetSession()->GetPlayer();
        if (!player)
            return false;

        Map* map = player->GetMap();
        if (!map)
            return false;

        handler->SetSentErrorMessage(true);

        if (map->Instanceable())
        {
            handler->SendSysMessage("Esta accion se encuentra bloqueada en Instancias, Arenas y Battlegrounds.");
            return false;
        }

        if (!player->isDead())
        {
            handler->SendSysMessage("Deebe estar muerto.");
            return false;
        }

        WorldSafeLocsEntry const* closestGraveyard = sObjectMgr->GetClosestGraveYard(player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), player->GetMapId(), player->GetTeam());
        if (closestGraveyard)
            player->TeleportTo(closestGraveyard->map_id, closestGraveyard->x, closestGraveyard->y, closestGraveyard->z, player->GetOrientation());
        else
        {
            handler->PSendSysMessage("No se ha podido encontrar un cementerio cercano.");
            return false;
        }

        return true;
    }
};

void AddSC_command_graveyard()
{
    new command_graveyard();
}
