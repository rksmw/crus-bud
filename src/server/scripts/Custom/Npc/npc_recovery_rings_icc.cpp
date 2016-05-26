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
#include "ReputationMgr.h"

#define GMSG 537006

class npc_icc_rep_rings : public CreatureScript
{
public:
 npc_icc_rep_rings() : CreatureScript("npc_icc_rep_rings") { }

 enum AshenRings
 {
     ASHEN_VERDICT      = 1156,
     C_F                = 50377,
     H_F                = 50378,
     MS_F               = 52569,
     MA_F               = 50376,
     T_F                = 50375,
     C_H                = 50384,
     H_H                = 50386,
     MS_H               = 52570,
     MA_H               = 50387,
     T_H                = 50388,
     C_R                = 50397,
     H_R                = 50399,
     MS_R               = 52571,
     MA_R               = 50401,
     T_R                = 50403,
     C_E                = 50398,
     H_E                = 50400,
     MS_E               = 52572,
     MA_E               = 50402,
     T_E                = 50404,
     QUEST_CHOOSE_YOUR_PATH = 24815
 };

 bool OnGossipHello(Player* player, Creature* creature)
 {
     switch (player->GetReputationRank(ASHEN_VERDICT))
     {
         case REP_HATED:
         case REP_HOSTILE:
         case REP_UNFRIENDLY:
         case REP_NEUTRAL:
             player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"You are not allied with Ashen Verdict",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+21);
             break;
         case REP_FRIENDLY:
             if (!player->HasItemCount(C_F,1,true) && !player->HasItemCount(H_F,1,true) && !player->HasItemCount(MS_F,1,true) && !player->HasItemCount(MA_F,1,true) &&
                 !player->HasItemCount(T_F,1,true) && player->GetQuestStatus(QUEST_CHOOSE_YOUR_PATH) == QUEST_STATUS_COMPLETE)
             {
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"Ring caster dps (friendly)",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+1);
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"Ring healer (friendly)",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+2);
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"Ring melee - strenght (friendly)",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+3);
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"Ring melee - agility (friendly)",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+4);
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"Ring tank (friendly)",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+5);
             }
             else
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"You already have a Ring of Ashen Verdict",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+21);
             break;
         case REP_HONORED:
             if (!player->HasItemCount(C_F,1,true) && !player->HasItemCount(H_F,1,true) && !player->HasItemCount(MS_F,1,true) && !player->HasItemCount(MA_F,1,true) &&
                 !player->HasItemCount(T_F,1,true) && !player->HasItemCount(C_H,1,true) && !player->HasItemCount(H_H,1,true) && !player->HasItemCount(MS_H,1,true) &&
                 !player->HasItemCount(MA_H,1,true) && !player->HasItemCount(T_H,1,true))
             {
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"Ring caster dps (honored)",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+6);
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"Ring healer (honored)",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+7);
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"Ring melee - strenght (honored)",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+8);
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"Ring melee - agility (honored)",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+9);
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"Ring tank (honored)",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+10);
             }
             else
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"You already have a Ring of Ashen Verdict",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+21);
             break;
         case REP_REVERED:
             if (!player->HasItemCount(C_F,1,true) && !player->HasItemCount(H_F,1,true) && !player->HasItemCount(MS_F,1,true) && !player->HasItemCount(MA_F,1,true) &&
                 !player->HasItemCount(T_F,1,true) && !player->HasItemCount(C_H,1,true) && !player->HasItemCount(H_H,1,true) && !player->HasItemCount(MS_H,1,true) &&
                 !player->HasItemCount(MA_H,1,true) && !player->HasItemCount(T_H,1,true) && !player->HasItemCount(C_R,1,true) && !player->HasItemCount(H_R,1,true) &&
                 !player->HasItemCount(MS_R,1,true) && !player->HasItemCount(MA_R,1,true) && !player->HasItemCount(T_R,1,true))
             {
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"Ring caster dps (revered)",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+11);
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"Ring healer (revered)",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+12);
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"Ring melee - strenght (revered)",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+13);
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"Ring melee - agility (revered)",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+14);
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"Ring tank (revered)",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+15);
             }
             else
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"You already have a Ring of Ashen Verdict",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+21);
             break;
         case REP_EXALTED:
             if (!player->HasItemCount(C_F,1,true) && !player->HasItemCount(H_F,1,true) && !player->HasItemCount(MS_F,1,true) && !player->HasItemCount(MA_F,1,true) &&
                 !player->HasItemCount(T_F,1,true) && !player->HasItemCount(C_H,1,true) && !player->HasItemCount(H_H,1,true) && !player->HasItemCount(MS_H,1,true) &&
                 !player->HasItemCount(MA_H,1,true) && !player->HasItemCount(T_H,1,true) && !player->HasItemCount(C_R,1,true) && !player->HasItemCount(H_R,1,true) &&
                 !player->HasItemCount(MS_R,1,true) && !player->HasItemCount(MA_R,1,true) && !player->HasItemCount(T_R,1,true) && !player->HasItemCount(C_E,1,true) &&
                 !player->HasItemCount(H_E,1,true) && !player->HasItemCount(MS_E,1,true) && !player->HasItemCount(MA_E,1,true) && !player->HasItemCount(T_E,1,true))
             {
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"Ring caster dps (exalted)",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+16);
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"Ring healer (exalted)",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+17);
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"Ring melee - strenght (exalted)",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+18);
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"Ring melee - agility (exalted)",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+19);
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"Ring tank (exalted)",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+20);
             }
             else
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,"You already have a Ring of Ashen Verdict",GOSSIP_SENDER_MAIN,GOSSIP_ACTION_INFO_DEF+21);
             break;
     }

     player->SEND_GOSSIP_MENU(GMSG, creature->GetGUID());
     return true;
 }

 bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*uiSender*/, uint32 uiAction)
 {
     player->PlayerTalkClass->ClearMenus();

     if (!player->HasItemCount(C_F,1,true) && !player->HasItemCount(H_F,1,true) && !player->HasItemCount(MS_F,1,true) && !player->HasItemCount(MA_F,1,true) &&
         !player->HasItemCount(T_F,1,true) && !player->HasItemCount(C_H,1,true) && !player->HasItemCount(H_H,1,true) && !player->HasItemCount(MS_H,1,true) &&
         !player->HasItemCount(MA_H,1,true) && !player->HasItemCount(T_H,1,true) && !player->HasItemCount(C_R,1,true) && !player->HasItemCount(H_R,1,true) &&
         !player->HasItemCount(MS_R,1,true) && !player->HasItemCount(MA_R,1,true) && !player->HasItemCount(T_R,1,true) && !player->HasItemCount(C_E,1,true) &&
         !player->HasItemCount(H_E,1,true) && !player->HasItemCount(MS_E,1,true) && !player->HasItemCount(MA_E,1,true) && !player->HasItemCount(T_E,1,true))
     {
         switch (uiAction)
         {
             case GOSSIP_ACTION_INFO_DEF+1:
                 player->AddItem(C_F,1);
                 break;
             case GOSSIP_ACTION_INFO_DEF+2:
                 player->AddItem(H_F,1);
                 break;
             case GOSSIP_ACTION_INFO_DEF+3:
                 player->AddItem(MS_F,1);
                 break;
             case GOSSIP_ACTION_INFO_DEF+4:
                 player->AddItem(MA_F,1);
                 break;
             case GOSSIP_ACTION_INFO_DEF+5:
                 player->AddItem(T_F,1);
                 break;
             case GOSSIP_ACTION_INFO_DEF+6:
                 player->AddItem(C_H,1);
                 break;
             case GOSSIP_ACTION_INFO_DEF+7:
                 player->AddItem(H_H,1);
                 break;
             case GOSSIP_ACTION_INFO_DEF+8:
                 player->AddItem(MS_H,1);
                 break;
             case GOSSIP_ACTION_INFO_DEF+9:
                 player->AddItem(MA_H,1);
                 break;
             case GOSSIP_ACTION_INFO_DEF+10:
                 player->AddItem(T_H,1);
                 break;
             case GOSSIP_ACTION_INFO_DEF+11:
                 player->AddItem(C_R,1);
                 break;
             case GOSSIP_ACTION_INFO_DEF+12:
                 player->AddItem(H_R,1);
                 break;
             case GOSSIP_ACTION_INFO_DEF+13:
                 player->AddItem(MS_R,1);
                 break;
             case GOSSIP_ACTION_INFO_DEF+14:
                 player->AddItem(MA_R,1);
                 break;
             case GOSSIP_ACTION_INFO_DEF+15:
                 player->AddItem(T_R,1);
                 break;
             case GOSSIP_ACTION_INFO_DEF+16:
                 player->AddItem(C_E,1);
                 break;
             case GOSSIP_ACTION_INFO_DEF+17:
                 player->AddItem(H_E,1);
                 break;
             case GOSSIP_ACTION_INFO_DEF+18:
                 player->AddItem(MS_E,1);
                 break;
             case GOSSIP_ACTION_INFO_DEF+19:
                 player->AddItem(MA_E,1);
                 break;
             case GOSSIP_ACTION_INFO_DEF+20:
                 player->AddItem(T_E,1);
                 break;
             case GOSSIP_ACTION_INFO_DEF+21:
                 break;
         }
     }
     player->CLOSE_GOSSIP_MENU();
     return true;
 }
};

void AddSC_rings_icc()
{
    new npc_icc_rep_rings();
}