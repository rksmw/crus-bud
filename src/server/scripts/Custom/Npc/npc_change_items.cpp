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

enum CambiaNpc
{
    BADGE_OF_JUSTICIE   = 29434,
    EMBLEM_OF_FROST     = 49426,
    EMBLEM_OF_TRIUMPH   = 47241,
};

class Cambia_Npc : public CreatureScript
{
public:
    Cambia_Npc() : CreatureScript("Cambia_Npc") { }

    bool OnGossipHello(Player *player, Creature *_creature) OVERRIDE
    {
        // Si estas en combate no podras usar el npc
        if (player->IsInCombat())
        {
            _creature->MonsterWhisper("You are in combat!", player);
            player->CLOSE_GOSSIP_MENU();
            return true;
        }
        else
        {
            player->ADD_GOSSIP_ITEM( 0, "120 Badge of Justice -> Reset de Instances"  , GOSSIP_SENDER_MAIN, 1);
            player->ADD_GOSSIP_ITEM( 0, "120 Badge of Justice -> 120 Arena Points" , GOSSIP_SENDER_MAIN, 2);
            player->ADD_GOSSIP_ITEM( 0, "120 Badge of Justice -> 10 Emblem of Frost" , GOSSIP_SENDER_MAIN, 3);
            player->ADD_GOSSIP_ITEM( 0, "120 Badge of Justice -> 20 Emblem of Triumph" , GOSSIP_SENDER_MAIN, 4);
            player->ADD_GOSSIP_ITEM( 0, "120 Badge of Justice -> 50k HONOR" , GOSSIP_SENDER_MAIN, 5);
            player->ADD_GOSSIP_ITEM( 0, "120 Badge of Justice -> Faction Change" , GOSSIP_SENDER_MAIN, 6);
            player->ADD_GOSSIP_ITEM( 0, "120 Badge of Justice -> Race Change" , GOSSIP_SENDER_MAIN, 7);
            player->ADD_GOSSIP_ITEM( 0, "120 Badge of Justice -> Name Change" , GOSSIP_SENDER_MAIN, 8);

        }
        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player *player, Creature *_creature, uint32 sender, uint32 uiAction) OVERRIDE
    {

        if (sender != GOSSIP_SENDER_MAIN)
            return true;

        player->PlayerTalkClass->ClearMenus();

        switch(uiAction)
        {
            case 1:
                if (player->HasItemCount(BADGE_OF_JUSTICIE, 120, true))
                {
                    player->DestroyItemCount(BADGE_OF_JUSTICIE, 120, true);
                    // Reset todas las Instancias
                    for (uint8 i = 0; i < MAX_DIFFICULTY; ++i)
                    {
                        Player::BoundInstancesMap &binds = player->GetBoundInstances(Difficulty(i));
                        for (Player::BoundInstancesMap::iterator itr = binds.begin(); itr != binds.end();)
                        {
                            InstanceSave* save = itr->second.save;
                            if (itr->first != player->GetMapId())
                                player->UnbindInstance(itr, Difficulty(i));
                            else
                                ++itr;
                        }
                    }
                    _creature->MonsterWhisper("Reset De Instancias Completo!", player);
                    player->CLOSE_GOSSIP_MENU();
                }
                else
                {
                    //_creature->Talk(TEXT_1,player->GetGUID());
                    _creature->MonsterWhisper("Te Faltan Los items para completar esta accion", player);
                    player->CLOSE_GOSSIP_MENU();
                }
                break;
            case 2:
                if (player->HasItemCount(BADGE_OF_JUSTICIE, 120, true))
                {
                    player->DestroyItemCount(BADGE_OF_JUSTICIE, 120, true);
                    player->ModifyArenaPoints(+120);
                    _creature->MonsterWhisper("Ya Obtuviste Tus 120 Puntos de Arena", player);
                    player->CLOSE_GOSSIP_MENU();
                }
                else
                {
                    _creature->MonsterWhisper("Te Faltan Los items para completar esta accion.", player);
                    player->CLOSE_GOSSIP_MENU();
                }
                break;
            case 3:
                if (player->HasItemCount(BADGE_OF_JUSTICIE, 120, true))
                {
                    player->DestroyItemCount(BADGE_OF_JUSTICIE, 120, true);
                    player->AddItem(EMBLEM_OF_FROST, 10);
                    _creature->MonsterWhisper("Ya Obtuviste Tus 10 Emblem Of Frost!", player);
                    player->CLOSE_GOSSIP_MENU();

                }
                else
                {
                    _creature->MonsterWhisper("Te Faltan Los items para completar esta accion!", player);
                    player->CLOSE_GOSSIP_MENU();
                }
                break;
            case 4:
                if (player->HasItemCount(BADGE_OF_JUSTICIE, 120, true))
                {
                    player->DestroyItemCount(BADGE_OF_JUSTICIE, 120, true);
                    player->AddItem(EMBLEM_OF_TRIUMPH, 20);
                    _creature->MonsterWhisper("Ya Obtuviste Tus 20 Emblem OF Triumph", player);
                    player->CLOSE_GOSSIP_MENU();
                }
                else
                {
                    _creature->MonsterWhisper("Te Faltan Los items para completar esta accion!", player);
                    player->CLOSE_GOSSIP_MENU();
                }
                break;
            case 5:
                if (player->HasItemCount(BADGE_OF_JUSTICIE, 120, true))
                {
                    player->DestroyItemCount(BADGE_OF_JUSTICIE, 120, true);
                    player->ModifyHonorPoints(+50000);
                    _creature->MonsterWhisper("Ya Obtuviste tus 50k de Honor", player);
                    player->CLOSE_GOSSIP_MENU();

                }
                else
                {
                    _creature->MonsterWhisper("Te Faltan Los items para completar esta accion!", player);
                    player->CLOSE_GOSSIP_MENU();

                }
                break;
            case 6:
                if (player->HasItemCount(BADGE_OF_JUSTICIE, 120, true))
                {
                    player->DestroyItemCount(BADGE_OF_JUSTICIE, 120, true);
                    player->SetAtLoginFlag(AT_LOGIN_CHANGE_FACTION);
                    _creature->MonsterWhisper("Al relogear obtendras tu cambio de faccion", player);
                    player->CLOSE_GOSSIP_MENU();

                }
                else
                {
                    _creature->MonsterWhisper("Te Faltan Los items para completar esta accion!", player);
                    player->CLOSE_GOSSIP_MENU();

                }
                break;
            case 7:
                if (player->HasItemCount(BADGE_OF_JUSTICIE, 120, true))
                {
                    player->DestroyItemCount(BADGE_OF_JUSTICIE, 120, true);
                    player->SetAtLoginFlag(AT_LOGIN_CHANGE_RACE);
                    _creature->MonsterWhisper("Al relogear obtendras tu cambio de raza", player);
                    player->CLOSE_GOSSIP_MENU();

                }
                else
                {
                    _creature->MonsterWhisper("Te Faltan Los items para completar esta accion!", player);
                    player->CLOSE_GOSSIP_MENU();

                }
                break;
            case 8:
                if (player->HasItemCount(BADGE_OF_JUSTICIE, 120, true))
                {
                    player->DestroyItemCount(BADGE_OF_JUSTICIE, 120, true);
                    player->SetAtLoginFlag(AT_LOGIN_RENAME);
                    _creature->MonsterWhisper("Al relogear obtendras tu cambio de Nick", player);
                    player->CLOSE_GOSSIP_MENU();

                }
                else
                {
                    _creature->MonsterWhisper("Te Faltan Los items para completar esta accion!", player);
                    player->CLOSE_GOSSIP_MENU();

                }
                break;
            default:
                break;
        }
        return true;
    }
};

void AddSC_npc_change_items()
{
    //new Cambia_Npc();
}
