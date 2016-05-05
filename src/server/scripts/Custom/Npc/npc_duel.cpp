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
 
// Cambia Use Token a 1 si es que quieres usar el token en vez de oro
#define USE_TOKEN       0
#define TOKEN_ID        29434

struct BloodMoneyInfo
{
    uint64 guid;
    uint32 amount;
    bool accepted;
};

typedef std::list<BloodMoneyInfo> BloodMoneyList;
typedef std::map<uint64, BloodMoneyList> BloodMoney;
static BloodMoney m_bloodMoney;

bool HasBloodMoneyChallenger(uint64 playerGUID)
{
    return m_bloodMoney.find(playerGUID) != m_bloodMoney.end();
}
 
bool HasBloodMoneyChallenger(uint64 targetGUID, uint64 playerGUID)
{
    if (!HasBloodMoneyChallenger(targetGUID))
        return false;

    BloodMoneyList bml = m_bloodMoney[targetGUID];
    for (BloodMoneyList::const_iterator itr = bml.begin(); itr != bml.end(); ++itr)
        if (itr->guid == playerGUID)
            return true;

    return false;
}
 
void AddBloodMoneyEntry(uint64 targetGUID, uint64 playerGUID, uint32 amount)
{
    BloodMoneyInfo bmi;
    bmi.guid = playerGUID;
    bmi.amount = amount;
    bmi.accepted = false;
    m_bloodMoney[targetGUID].push_back(bmi);
}

void RemoveBloodMoneyEntry(uint64 targetGUID, uint64 playerGUID)
{
    if (!HasBloodMoneyChallenger(targetGUID, playerGUID))
        return;

    BloodMoneyList &list = m_bloodMoney[targetGUID];
    BloodMoneyList::iterator itr;
    for (itr = list.begin(); itr != list.begin(); ++itr)
        if (itr->guid == playerGUID)
            break;
    list.erase(itr);
}

void SetChallengeAccepted(uint64 targetGUID, uint64 playerGUID)
{
    if (!HasBloodMoneyChallenger(targetGUID, playerGUID))
        return;
    BloodMoneyList &list = m_bloodMoney[targetGUID];
    BloodMoneyList::iterator itr;
    for (itr = list.begin(); itr != list.end(); ++itr)
    {
        if (itr->guid == playerGUID)
        {
            itr->accepted = true;
            break;
        }
    }
}

class npc_blood_money : public CreatureScript
{
public :
    npc_blood_money() : CreatureScript("npc_blood_money") {}

    bool OnGossipHello(Player * player, Creature * creature)
    {
        player->PlayerTalkClass->ClearMenus();
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "Reta a un Jugador", 11, 1000);   
        if (HasBloodMoneyChallenger(player->GetGUID()))
        {
            BloodMoneyList list = m_bloodMoney[player->GetGUID()];
            for (BloodMoneyList::const_iterator itr = list.begin(); itr != list.end(); ++itr)
            {
                char msg[50];

                if (Player* plr = Player::GetPlayer(*player, itr->guid))
                {
                    if (USE_TOKEN)
                    {
                        sprintf(msg, "Aceptas un reto de %s's por %u medallas", plr->GetName().c_str(), itr->amount);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, msg, GOSSIP_SENDER_MAIN, itr->guid);
                        sprintf(msg, "Rechazas un reto de %s's por %u medallas", plr->GetName().c_str(), itr->amount);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, msg, GOSSIP_SENDER_INFO, itr->guid);
                    }
                    else
                    {
                        sprintf(msg, "Aceptas un reto de %s's por %ug oros", plr->GetName().c_str(), itr->amount/10000);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, msg, GOSSIP_SENDER_MAIN, itr->guid);
                        sprintf(msg, "Rechazas un reto de %s's por %ug oros", plr->GetName().c_str(), itr->amount/10000);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, msg, GOSSIP_SENDER_INFO, itr->guid);
                    }

                }
            }
        }
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "No Importa", GOSSIP_SENDER_MAIN, 1);
        player->SEND_GOSSIP_MENU(80025, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player * player, Creature * creature, uint32 uiSender, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        if (uiAction == 1)
        {
            player->CLOSE_GOSSIP_MENU();
            return true;
        }
        switch(uiSender)
        {
            case GOSSIP_SENDER_MAIN:
                if (Player* target = Player::GetPlayer(*player, uiAction))
                {
                    SetChallengeAccepted(player->GetGUID(), target->GetGUID());
                    char msg[60];
                    sprintf(msg, "%s ha aceptado el reto", player->GetName().c_str());
                    creature->MonsterWhisper(msg, target, true);
                    player->CLOSE_GOSSIP_MENU();
                }
                break;
            case GOSSIP_SENDER_INFO:
                if (Player* target = Player::GetPlayer(*player, uiAction))
                {
                    char msg[60];
                    sprintf(msg, "%s ha declinado tu reto!", player->GetName().c_str());
                    creature->MonsterWhisper(msg, target, true);
                    RemoveBloodMoneyEntry(player->GetGUID(), uiAction);
                    OnGossipHello(player, creature);
                }
                break;
            case 11:
                if (USE_TOKEN)
                {
                    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Apuesta  5 tokens", GOSSIP_SENDER_MAIN, 5, "Escribe el nombre del jugador", 0, true);
                    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Apuesta  10 tokens", GOSSIP_SENDER_MAIN, 10, "Escribe el nombre del jugador", 0, true);
                    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Apuesta  15 tokens", GOSSIP_SENDER_MAIN, 15, "Escribe el nombre del jugador", 0, true);
                    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Apuesta  25 tokens", GOSSIP_SENDER_MAIN, 25, "Escribe el nombre del jugador", 0, true);
                    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Apuesta  50 tokens", GOSSIP_SENDER_MAIN, 50, "Escribe el nombre del jugador", 0, true);
                    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Apuesta  100 tokens", GOSSIP_SENDER_MAIN, 100, "Escribe el nombre del jugador", 0, true);
                    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Apuesta  150 tokens", GOSSIP_SENDER_MAIN, 150, "Escribe el nombre del jugador", 0, true);
                    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Apuesta  200 tokens", GOSSIP_SENDER_MAIN, 200, "Escribe el nombre del jugador", 0, true);
                    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Apuesta  250 tokens", GOSSIP_SENDER_MAIN, 250, "Escribe el nombre del jugador", 0, true);
                    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Apuesta  500 tokens", GOSSIP_SENDER_MAIN, 500, "Escribe el nombre del jugador", 0, true);
                }
                else
                {
                    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Apuesta  5g", GOSSIP_SENDER_MAIN, 5, "Escribe el nombre del jugador", 0, true);
                    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Apuesta  10g", GOSSIP_SENDER_MAIN, 10, "Escribe el nombre del jugador", 0, true);
                    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Apuesta  15g", GOSSIP_SENDER_MAIN, 15, "Escribe el nombre del jugador", 0, true);
                    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Apuesta  25g", GOSSIP_SENDER_MAIN, 25, "Escribe el nombre del jugador", 0, true);
                    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Apuesta  50g", GOSSIP_SENDER_MAIN, 50, "Escribe el nombre del jugador", 0, true);
                    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Apuesta  100g", GOSSIP_SENDER_MAIN, 100, "Escribe el nombre del jugador", 0, true);
                    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Apuesta  150g", GOSSIP_SENDER_MAIN, 150, "Escribe el nombre del jugador", 0, true);
                    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Apuesta  200g", GOSSIP_SENDER_MAIN, 200, "Escribe el nombre del jugador", 0, true);
                    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Apuesta  250g", GOSSIP_SENDER_MAIN, 250, "Escribe el nombre del jugador", 0, true);
                    player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_MONEY_BAG, "Apuesta  500g", GOSSIP_SENDER_MAIN, 500, "Escribe el nombre del jugador", 0, true);
                }
                player->SEND_GOSSIP_MENU(80025, creature->GetGUID());
                break;
        }
        return true;
    }

    bool OnGossipSelectCode(Player* player, Creature* creature, uint32 sender, uint32 action, const char* code)
    {
        if (player->GetName().c_str() == code)
        {
            ChatHandler(player->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFAhora, ¿por que quiere ponerse a prueba??");
            return false;
        }
        if (uint64 targetGUID = sObjectMgr->GetPlayerGUIDByName(code))
        {
            if (Player* target = Player::GetPlayer(*player, targetGUID))
            {
                if (target->GetGUID() == player->GetGUID())
                {
                    ChatHandler(player->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFAhora, ¿por qué quiere ponerse a prueba?");
                    return false;
                }
                if (target->GetZoneId() == player->GetZoneId())
                {
                    if (USE_TOKEN)
                    {
                        if (target->GetItemCount(TOKEN_ID) < action)
                        {
                            ChatHandler(player->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFEl jugador no tiene las suficientes medallas para aceptar la apuesta !");
                            player->CLOSE_GOSSIP_MENU();
                            return false;
                        }
                        if (player->GetItemCount(TOKEN_ID) < action)
                        {
                            ChatHandler(player->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFTu no tienes suficientes medallas para realizar esta apuesta !");
                            player->CLOSE_GOSSIP_MENU();
                            return false;
                        }
                        bool found = false;
                        if (HasBloodMoneyChallenger(player->GetGUID()))
                        {
                            BloodMoneyList list = m_bloodMoney[player->GetGUID()];
                            for (BloodMoneyList::const_iterator itr = list.begin(); itr != list.end(); ++itr)
                                if (itr->guid == target->GetGUID())
                                    found = true;
                        }
                        if (!found)
                        {
                            if (!HasBloodMoneyChallenger(target->GetGUID(), player->GetGUID()))
                            {
                                AddBloodMoneyEntry(target->GetGUID(), player->GetGUID(), action);
                                char msg[60];
                                sprintf(msg, "%s te ha retado a un duelo atravez de BattleCore", player->GetName().c_str());
                                creature->MonsterWhisper(msg, target, true);
                            }
                            else
                                ChatHandler(target->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFUsted no puede solicitar un duelo con la misma persona!");
                        }
                        else
                            ChatHandler(player->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFUsted no puede solictar un duelo con alguien que ya tenga un duelo solicitado!");
                        player->CLOSE_GOSSIP_MENU();
                        return true;
                    }
                    else
                    {
                        uint32 money = action*10000;
                        if (target->GetMoney() < money)
                        {
                            ChatHandler(player->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFEse jugador no tiene suficiente dinero para hacer la Apuesta!");
                            player->CLOSE_GOSSIP_MENU();
                            return false;
                        }
                        if (player->GetMoney() < money)
                        {
                            ChatHandler(player->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFUsted no tiene el dinero suficiente para hacer la Apuesta !");
                            player->CLOSE_GOSSIP_MENU();
                            return false;
                        }

                        bool found = false;
                        if (HasBloodMoneyChallenger(player->GetGUID()))
                        {
                            BloodMoneyList list = m_bloodMoney[player->GetGUID()];
                            for (BloodMoneyList::const_iterator itr = list.begin(); itr != list.end(); ++itr)
                                if (itr->guid == target->GetGUID())
                                    found = true;
                        }
                        if (!found)
                        {
                            if (!HasBloodMoneyChallenger(target->GetGUID(), player->GetGUID()))
                            {
                                AddBloodMoneyEntry(target->GetGUID(), player->GetGUID(), money);
                                char msg[60];
                                sprintf(msg, "%s ha solitado un duelo con usted atravez de BattleCore !", player->GetName().c_str());
                                creature->MonsterWhisper(msg, target, true);
                            }
                            else
                                ChatHandler(target->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFUsted no puede solicitar un duelo con la misma persona!");
                        }
                        else
                            ChatHandler(player->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFUsted no puede solicitar un duelo con alguien que te ha desafiado!");
                        player->CLOSE_GOSSIP_MENU();
                        return true;
                    }

                }
                else
                {
                    ChatHandler(player->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFEse jugador no está en su zona!");
                    player->CLOSE_GOSSIP_MENU();
                    return false;
                }
            }
            else
            {
                ChatHandler(player->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFEse jugador no se ha encontrado!");
                player->CLOSE_GOSSIP_MENU();
                return false;
            }
                }
                else
                {
                    ChatHandler(player->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFEse jugador no se ha encontrado!");
                    player->CLOSE_GOSSIP_MENU();
                    return false;
                }
                player->CLOSE_GOSSIP_MENU();
                return true;
        }

};

class BloodMoneyReward : public PlayerScript
{
public:
    BloodMoneyReward() : PlayerScript("BloodMoneyReward") {}

    void OnDuelEnd(Player* winner, Player* loser, DuelCompleteType type)
    {
        if (HasBloodMoneyChallenger(winner->GetGUID()) || HasBloodMoneyChallenger(loser->GetGUID()))
        {                        
            BloodMoneyList list1 = m_bloodMoney[winner->GetGUID()];
            BloodMoneyList list2 = m_bloodMoney[loser->GetGUID()];

            BloodMoneyList::const_iterator itr;
            for (itr = list1.begin(); itr != list1.end(); ++itr)
            {
                if (itr->guid == loser->GetGUID() && itr->accepted)
                {
                    if (USE_TOKEN)
                    {
                        if (winner->GetItemCount(TOKEN_ID) < itr->amount)
                        {
                            winner->AddAura(15007, winner);         // Aplicamos aura de sickenes por posible tramposo
                            ChatHandler(winner->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFHas ganado Enfermedad Resurrection posiblemente, tratas de abusar del sistema.");
                            ChatHandler(loser->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFSu oponente trató de hacer trampa. No se preocupe, usted no perderá ningún tokens debido a esto.");
                            RemoveBloodMoneyEntry(winner->GetGUID(), itr->guid);
                            return;
                        }
                        if (loser->GetItemCount(TOKEN_ID) >= itr->amount)
                        {
                            winner->AddItem(TOKEN_ID, itr->amount);
                            ChatHandler(winner->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFF Felicitaciones por ganar haz consgido %u tokens!", itr->amount);
                            Item* item = loser->GetItemByEntry(TOKEN_ID);
                            loser->DestroyItemCount(TOKEN_ID, itr->amount, true);
                            RemoveBloodMoneyEntry(winner->GetGUID(), itr->guid);
                        }
                        else
                        {
                            loser->AddAura(15007, loser);           // Aplicamos aura de sickenes por posible tramposo
                            ChatHandler(winner->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFSu oponente trató de hacer trampa. El no tiene fichas suficientes para pagar la Apuesta.");
                            ChatHandler(loser->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFHas ganado Enfermedad Resurrection posiblemente, tratas de abusar del sistema.");
                            RemoveBloodMoneyEntry(winner->GetGUID(), itr->guid);
                        }
                        return;
                    }
                    else
                    {
                        if (winner->GetMoney() < itr->amount)
                        {
                            winner->AddAura(15007, winner);         // Aplicamos aura de sickenes por posible tramposo
                            ChatHandler(winner->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFHas ganado Enfermedad Resurrection posiblemente, tratas de abusar del sistema..");
                            ChatHandler(loser->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFSu oponente trató de hacer trampa. No se preocupe, usted no pierde dinero debido a esto.");
                            RemoveBloodMoneyEntry(winner->GetGUID(), itr->guid);
                            return;
                        }
                        if (loser->GetMoney() >= itr->amount)
                        {
                            winner->ModifyMoney(itr->amount);
                            ChatHandler(winner->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFFelicitaciones ganaste %ug!", itr->amount/10000);
                            loser->ModifyMoney(-(int32)(itr->amount));
                            RemoveBloodMoneyEntry(winner->GetGUID(), itr->guid);
                        }
                        else
                        {
                            loser->AddAura(15007, loser);           // Aplicamos aura de sickenes por posible tramposo
                            ChatHandler(winner->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFSu oponente trató de hacer trampa. No tenía suficiente dinero para pagar la Apuesta.");
                            ChatHandler(loser->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFHas ganado Enfermedad Resurrection posiblemente, tratas de abusar del sistema.");
                            RemoveBloodMoneyEntry(winner->GetGUID(), itr->guid);
                        }
                        return;
                    }
                }
            }
            for (itr = list2.begin(); itr != list2.end(); ++itr)
            {                                
                if (itr->guid == winner->GetGUID() && itr->accepted)
                {
                    if (USE_TOKEN)
                    {
                        if (winner->GetItemCount(TOKEN_ID) < itr->amount)
                        {
                            winner->AddAura(15007, winner);         // Aplicamos aura de sickenes por posible tramposo
                            ChatHandler(winner->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFHas ganado Enfermedad Resurrection posiblemente, tratas de abusar del sistema..");
                            ChatHandler(loser->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFSu oponente trató de hacer trampa. No se preocupe, usted no perderá ningún tokens debido a esto.");
                            RemoveBloodMoneyEntry(loser->GetGUID(), itr->guid);
                            return;
                        }
                        if (loser->GetItemCount(TOKEN_ID) >= itr->amount)
                        {
                            winner->AddItem(TOKEN_ID, itr->amount);
                            ChatHandler(winner->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFFelicitaciones ganaste %u tokens!", itr->amount);
                            Item* item = loser->GetItemByEntry(TOKEN_ID);
                            loser->DestroyItemCount(TOKEN_ID, itr->amount, true);
                            RemoveBloodMoneyEntry(loser->GetGUID(), itr->guid);      
                        }
                        else
                        {
                            loser->AddAura(15007, loser);           // Aplicamos aura de sickenes por posible tramposo
                            ChatHandler(winner->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFSu oponente trató de hacer trampa. El no tiene fichas suficientes para pagar la Apuesta.");
                            ChatHandler(loser->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFHas ganado Enfermedad Resurrection posiblemente, tratas de abusar del sistema..");
                            RemoveBloodMoneyEntry(loser->GetGUID(), itr->guid);
                        }
                        return;
                    }
                    else
                    {
                        if (winner->GetMoney() < itr->amount)
                        {
                            winner->AddAura(15007, winner);         // Aplicamos aura de sickenes por posible tramposo
                            ChatHandler(winner->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFHas ganado Enfermedad Resurrection posiblemente, tratas de abusar del sistema..");
                            ChatHandler(loser->GetSession()).PSendSysMessage("|cff800C0C[BBattleCore] |cffFFFFFFSu oponente trató de hacer trampa. No se preocupe, usted no pierde dinero debido a esto.");
                            RemoveBloodMoneyEntry(loser->GetGUID(), itr->guid);
                            return;
                        }
                        if (loser->GetMoney() >= itr->amount)
                        {
                            winner->ModifyMoney(itr->amount);
                            ChatHandler(winner->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFFelicitaciones as ganado %ug!", itr->amount/10000);                                                        
                            loser->ModifyMoney(-(int32)(itr->amount));
                            RemoveBloodMoneyEntry(loser->GetGUID(), itr->guid);
                        }
                        else
                        {
                            loser->AddAura(15007, loser);           // Aplicamos aura de sickenes por posible tramposo
                            ChatHandler(winner->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFSu oponente trató de hacer trampa. No se preocupe, usted no pierde dinero debido a esto. .");
                            ChatHandler(loser->GetSession()).PSendSysMessage("|cff800C0C[BattleCore] |cffFFFFFFHas ganado Enfermedad Resurrection posiblemente, tratas de abusar del sistema.");
                            RemoveBloodMoneyEntry(loser->GetGUID(), itr->guid);
                        }
                        return;
                    }
                }
            }
        }
    }
};

void AddSC_npc_duel()
{
    //new BloodMoneyReward();
    //new npc_blood_money();
}