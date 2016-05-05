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
#include <iomanip> 

class events_pve_casino_american_roulette : public CreatureScript
{
public:
    events_pve_casino_american_roulette() : CreatureScript("events_pve_casino_american_roulette") { }

    std::string colorstring(int8 type)
    {
        std::string _color;

        switch(type)
        {
        case 1:
            _color = "Negro";
        case 2:
            _color = "Rojo";
        case 3:
            _color = "Verde";
        }
        return _color;
    }

    int8 GenerateNumberMessage(int8 numbervalue)
    {
        int8 black[18] = {2, 28, 26, 11, 20, 17, 22, 15, 24, 13, 10, 29, 8, 31, 6, 33, 4, 35};
        int8 red[18] = {9, 30, 7, 32, 5, 34, 3, 36, 1, 27, 25, 12, 19, 18, 21, 16, 23, 14};
        int8 green[2] = {0, 00};
        int8 _number;

        for(int8 i = 0; i < 18; i++)
        {
            if (numbervalue == black[i])
                _number = 2;
            else if (numbervalue == red[i])
                _number = 3;
            else if (numbervalue == 37 || numbervalue == 0)
                _number = 4;
        }
        return _number;
    }

    bool OnGossipHello(Player * player, Creature * creature)
    {

        player->ADD_GOSSIP_ITEM(3, "Quiero Jugar a la Ruleta Americana", GOSSIP_SENDER_MAIN, 1337);
        player->ADD_GOSSIP_ITEM(3, "¿Como Funciona El Juego?", GOSSIP_SENDER_MAIN, 999);
        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player * player, Creature * creature, uint32 sender, uint32 uiAction) 
    {
        player->PlayerTalkClass->ClearMenus();

        if (uiAction == 1337)
        {
            player->ADD_GOSSIP_ITEM(3, "Quiero Apostar a un Numero.", GOSSIP_SENDER_MAIN,997);
            player->ADD_GOSSIP_ITEM(3, "Quiero Apostar a un color.", GOSSIP_SENDER_MAIN, 996);
            player->ADD_GOSSIP_ITEM(3, "Quiero Apostar a un numero establecido.", GOSSIP_SENDER_MAIN, 995);
            player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }


        if(uiAction == 997)
        {
            player->ADD_GOSSIP_ITEM(3, "Estadisticas para esta mesa:\nOdds 35:1 (1-36, 0, y 00)\n Recompensa: x35", GOSSIP_SENDER_MAIN, 997);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 0.", GOSSIP_SENDER_MAIN, 0, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 1.", GOSSIP_SENDER_MAIN, 1, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 2.", GOSSIP_SENDER_MAIN, 2, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 3.", GOSSIP_SENDER_MAIN, 3, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 4.", GOSSIP_SENDER_MAIN, 4, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 5.", GOSSIP_SENDER_MAIN, 5, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 6.", GOSSIP_SENDER_MAIN, 6, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 7.", GOSSIP_SENDER_MAIN, 7, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 8.", GOSSIP_SENDER_MAIN, 8, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 9.", GOSSIP_SENDER_MAIN, 9, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM(3, "Siguiente", GOSSIP_SENDER_MAIN, 1338);
            player->ADD_GOSSIP_ITEM(3, "Atras", GOSSIP_SENDER_MAIN, 1337);
            player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }

        if(uiAction == 1338)
        {
            player->ADD_GOSSIP_ITEM(3, "Estadisticas para esta mesa:\nOdds 35:1 (1-36, 0, y 00)\n Recompensa: x35", GOSSIP_SENDER_MAIN, 997);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero aposta a 10.", GOSSIP_SENDER_MAIN, 10, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero aposta a 11.", GOSSIP_SENDER_MAIN, 11, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero aposta a 12.", GOSSIP_SENDER_MAIN, 12, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero aposta a 13.", GOSSIP_SENDER_MAIN, 13, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero aposta a 14.", GOSSIP_SENDER_MAIN, 14, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero aposta a 15.", GOSSIP_SENDER_MAIN, 15, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero aposta a 16.", GOSSIP_SENDER_MAIN, 16, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero aposta a 17.", GOSSIP_SENDER_MAIN, 17, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero aposta a 18.", GOSSIP_SENDER_MAIN, 18, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM(3, "Siguiente", GOSSIP_SENDER_MAIN, 1339);
            player->ADD_GOSSIP_ITEM(3, "Atras", GOSSIP_SENDER_MAIN, 997);
            player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }

        if(uiAction == 1339)
        {
            player->ADD_GOSSIP_ITEM(3, "Estadisticas para esta mesa:\nOdds 35:1 (1-36, 0, y 00)\n Recompensa: x35", GOSSIP_SENDER_MAIN, 997);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 19.", GOSSIP_SENDER_MAIN, 19, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 20.", GOSSIP_SENDER_MAIN, 20, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 21.", GOSSIP_SENDER_MAIN, 21, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 22.", GOSSIP_SENDER_MAIN, 22, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 23.", GOSSIP_SENDER_MAIN, 23, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 24.", GOSSIP_SENDER_MAIN, 24, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 25.", GOSSIP_SENDER_MAIN, 25, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 26.", GOSSIP_SENDER_MAIN, 26, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 27.", GOSSIP_SENDER_MAIN, 27, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM(3, "Siguiente", GOSSIP_SENDER_MAIN, 1340);
            player->ADD_GOSSIP_ITEM(3, "Atras", GOSSIP_SENDER_MAIN, 1338);
            player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }

        if(uiAction == 1340)
        {
            player->ADD_GOSSIP_ITEM(3, "Estadisticas para esta mesa:\nOdds 35:1 (1-36, 0, y 00)\n Recompensa: x35", GOSSIP_SENDER_MAIN, 997);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 28.", GOSSIP_SENDER_MAIN, 28, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 29.", GOSSIP_SENDER_MAIN, 29, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 30.", GOSSIP_SENDER_MAIN, 30, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 31.", GOSSIP_SENDER_MAIN, 31, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 32.", GOSSIP_SENDER_MAIN, 32, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 33.", GOSSIP_SENDER_MAIN, 33, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 34.", GOSSIP_SENDER_MAIN, 34, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 35.", GOSSIP_SENDER_MAIN, 35, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 36.", GOSSIP_SENDER_MAIN, 36, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar a 00.", GOSSIP_SENDER_MAIN, 37, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM(3, "Back", GOSSIP_SENDER_MAIN, 1339);
            player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }


        if(uiAction == 996)
        {
            player->ADD_GOSSIP_ITEM(3, "Estadisticas para esta mesa:\nOdds 1:1 (verde es 1:17, ya que es 0 y 00)\n Recompensa: x1 (x17) ", GOSSIP_SENDER_MAIN, 996);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar Rojo.", GOSSIP_SENDER_MAIN, 800, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar Negro.", GOSSIP_SENDER_MAIN, 810, "¿Cuanto oro quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar Verde.", GOSSIP_SENDER_MAIN, 818, "¿Cuanto oro quieres apostar?", 0, true);     
            player->ADD_GOSSIP_ITEM(3, "Atras", GOSSIP_SENDER_MAIN, 1337);
            player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }

        if(uiAction == 995)
        {
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar por 1-12. 2:1,  Recompensa: 3x", GOSSIP_SENDER_MAIN, 700, "¿Cuanto dinero quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar por 13-24. 2:1, Recompensa: 3x", GOSSIP_SENDER_MAIN, 701, "¿Cuanto dinero quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar por 25-36. 2:1, Recompensa: 3x", GOSSIP_SENDER_MAIN, 702, "¿Cuanto dinero quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar por 1-5. 7:1    Recompensa: 7x", GOSSIP_SENDER_MAIN, 703, "¿Cuanto dinero quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar por 6-10. 7:1   Recompensa: 7x", GOSSIP_SENDER_MAIN, 704, "¿Cuanto dinero quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar por 11-15. 7:1  Recompensa: 7x", GOSSIP_SENDER_MAIN, 705, "¿Cuanto dinero quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar por 16-20. 7:1  Recompensa: 7x", GOSSIP_SENDER_MAIN, 706, "¿Cuanto dinero quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar por 21-25. 7:1  Recompensa: 7x", GOSSIP_SENDER_MAIN, 707, "¿Cuanto dinero quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar por 26-30. 7:1  Recompensa: 7x", GOSSIP_SENDER_MAIN, 708, "¿Cuanto dinero quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero apostar por 31-35. 7:1  Recompensa: 7x", GOSSIP_SENDER_MAIN, 709, "¿Cuanto dinero quieres apostar?", 0, true);
            player->ADD_GOSSIP_ITEM(3, "Atras", GOSSIP_SENDER_MAIN, 1337);
            player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }

        if(uiAction == 999)
        {
            player->ADD_GOSSIP_ITEM(7, "Se lanza una pelota en la mesa de la ruleta, cuando la bola se detiene en un numero de colores, usted gana o pierde su apuesta. Usted puede apostar a los numeros especificos, los numeros pares, impares, colores o rangos de 1-18 y 19-36. su recompensa por los colores seran los siguientes: \n Negro: 2, 28, 26, 11, 20, 17, 22, 15, 24, 13, 10, 29, 8, 31, 6, 33, 4, 35 \n rojo: 9, 30, 7, 32, 5, 34, 3, 36, 1, 27, 25, 12, 19, 18, 21, 16, 23, 14 \n verde: 0, 00", GOSSIP_SENDER_MAIN, 666);
            player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }
        else if(uiAction == 666)
        {   
            OnGossipHello(player, creature);
        }
        return true;
    }

    bool OnGossipSelectCode(Player* player, Creature* creature, uint32 sender, uint32 uiAction, const char* code)
    {
        player->PlayerTalkClass->ClearMenus();

        uint32 betnumber = 0;
        uint32 gold = uint32(atol(code)) * 1000; 
        std::ostringstream message;


        if(uiAction >= 0 && uiAction <= 37)
        {
            Gamblemode(player, creature, gold, 35, uiAction, uiAction, 0);
        }
        else
        {
            switch(uiAction)
            {
            case 700:
                Gamblemode(player, creature, gold, 3, 1, 12, 0);
                break;
            case 701:
                Gamblemode(player, creature, gold, 3, 13, 24, 0);
                break;
            case 702:
                Gamblemode(player, creature, gold, 3, 25, 36, 0);
                break;
            case 703:
                Gamblemode(player, creature, gold, 7, 1, 5, 0);
                break;
            case 704:
                Gamblemode(player, creature, gold, 7, 6, 10, 0);
                break;
            case 705:
                Gamblemode(player, creature, gold, 7, 11, 15, 0);
                break;
            case 706:
                Gamblemode(player, creature, gold, 7, 16, 20, 0);
                break;
            case 707:
                Gamblemode(player, creature, gold, 7, 21, 25, 0);
                break;
            case 708:
                Gamblemode(player, creature, gold, 7, 26, 30, 0);
                break;
            case 709:
                Gamblemode(player, creature, gold, 7, 31, 35, 0);
                break;
            case 800:
                Gamblemode(player, creature, gold, 2, 0, 37, 2);
                break;
            case 810:
                Gamblemode(player, creature, gold, 2, 0, 37, 1);
                break;
            case 818:
                Gamblemode(player, creature, gold, 17, 0, 37, 3);
                break;
            }
        }
        OnGossipHello(player, creature);
        return true;
    }

    bool Gamblemode(Player* player, Creature * creature, uint32 moneybet, uint32 multiplier, uint32 minimum, uint32 maximum, int8 color)
    {
        std::ostringstream message;
        uint32 winningnumber = 0;
        winningnumber = urand(0,37);
        uint32 winnings = moneybet * multiplier;

        if (winningnumber == 37)
            winningnumber = 00;

        if(player->GetMoney() < moneybet)
        {
            player->GetSession()->SendNotification("Usted no tiene suficiente dinero");
            return false;
        }

        if(color)
        {
            if(GenerateNumberMessage(winningnumber) == color)
            {   

                player->ModifyMoney(player->GetMoney() + winnings);
                player->PlayDirectSound(3337);
                player->CastSpell(player, 47292);
                player->CastSpell(player, 44940);
                message << "AAAAANaaaa y la bolita cae en..." << std::setw(1)  << colorstring(color) << std::setw(1)  << "Felicitaciones" << std::setw(1) << player->GetName() << std::setw(1)  << " Has ganado" << std::setw(1) << winnings << std::setw(1) << "oros!";
                player->MonsterWhisper(message.str().c_str(), player);
                return true;

            }
            else
            {
                player->ModifyMoney(player->GetMoney() - moneybet);
                message << "AAAAANaaaa y la bolita cae en..." << std::setw(1) << colorstring(color) << std::setw(1) << "..buuuuu lo sentimos, " << std::setw(1) << player->GetName() << std::setw(1) << ", as perdido, mejor suerte para el proximo juego";
                player->MonsterWhisper(message.str().c_str(), player);
                return false;
            }
        }
        else 
        {
            if(winningnumber >= minimum && winningnumber <= maximum)
            {   
                player->ModifyMoney(player->GetMoney() + winnings);
                player->PlayDirectSound(3337);
                player->CastSpell(player, 47292);
                player->CastSpell(player, 44940);
                message << "AAAAANaaaa y la bolita cae en..." << std::setw(1)  << winningnumber << std::setw(1) << "Felicitaciones" << std::setw(1) << player->GetName() << std::setw(1) << " Has ganado" << std::setw(1) << winnings << std::setw(1) << "oros!";
                player->MonsterWhisper(message.str().c_str(), player);
                return true;
            }
            else
            {
                player->ModifyMoney(player->GetMoney() - moneybet);
                message << "AAAAANaaaa y la bolita cae en..." << std::setw(1) << winningnumber << std::setw(1)  <<  "..buuuuu lo sentimos, " << std::setw(1) << player->GetName() << std::setw(1) << ", as perdido, mejor suerte para el proximo juego";
                player->MonsterWhisper(message.str().c_str(), player);
                return false;
            }
        }
    }

    struct events_pve_casino_american_roulette_passiveAI : public ScriptedAI
    {
        events_pve_casino_american_roulette_passiveAI(Creature * c) : ScriptedAI(c){ }

        uint32 uiAdATimer;
        uint32 uiAdBTimer;
        uint32 uiAdCTimer;

        void Reset()
        {
            uiAdATimer = 1000;
            uiAdBTimer = 23000;
            uiAdCTimer = 11000;
        }


        void UpdateAI(uint32 diff)
        {

            if(uiAdATimer <= diff)
            {
                me->MonsterSay("Vengan uno vengan todos, hagan su apuesta en la Ruleta Americana Ya!", LANG_UNIVERSAL, NULL);
                me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                me->CastSpell(me, 44940);
                uiAdATimer = 61000;
            }
            else
                uiAdATimer -= diff;

            if(uiAdBTimer <= diff)
            {
                me->MonsterSay("Vamos Chicos! Hagan sus apuestas, o acaso eres una gallina?", LANG_UNIVERSAL, NULL);
                me->HandleEmoteCommand(EMOTE_ONESHOT_CHICKEN);
                uiAdBTimer = 61000;
            }
            else
                uiAdBTimer -= diff;

            if(uiAdCTimer <= diff)
            {
                me->MonsterSay("Quieres ser millonario?, entonces no llores mas y ven a probar suerte en la ruleta americana", LANG_UNIVERSAL, NULL);
                me->HandleEmoteCommand(EMOTE_ONESHOT_CRY);
                uiAdCTimer = 61000;
            }
            else
                uiAdCTimer -= diff;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new events_pve_casino_american_roulette_passiveAI(creature);
    }
};

class events_pve_casino_npc_cachipun : public CreatureScript
{
public:
    events_pve_casino_npc_cachipun() : CreatureScript("events_pve_casino_npc_cachipun") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        player->ADD_GOSSIP_ITEM(0, "Eligo Piedra.", GOSSIP_SENDER_MAIN, 100);
        player->ADD_GOSSIP_ITEM(0, "Eligo Papel.", GOSSIP_SENDER_MAIN, 101);
        player->ADD_GOSSIP_ITEM(0, "Eligo Tijera.", GOSSIP_SENDER_MAIN, 102);
        player->ADD_GOSSIP_ITEM(0, "Salir", GOSSIP_SENDER_MAIN, 103);
        player->SEND_GOSSIP_MENU(1, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 actions)
    {
        player->PlayerTalkClass->ClearMenus();
        switch(actions)
        {
        case 100:
            switch(rand()%3)
            {
            case 0:
                ChatHandler(player->GetSession()).PSendSysMessage("Empate los dos Eligimos piedra");
                player->CLOSE_GOSSIP_MENU();
                break;
            case 1:
                ChatHandler(player->GetSession()).PSendSysMessage("Ganaste Eligiste Papel");
                player->CLOSE_GOSSIP_MENU();
                break;
            case 2:
                ChatHandler(player->GetSession()).PSendSysMessage("Eligiste Tijeras perdiste.");
                player->CLOSE_GOSSIP_MENU();
                break;
            }
            break;

        case 101:
            switch(rand()%3)
            {
            case 0:
                ChatHandler(player->GetSession()).PSendSysMessage("Ganaste Eligiste piedra");
                player->CLOSE_GOSSIP_MENU();
                break;
            case 1:
                ChatHandler(player->GetSession()).PSendSysMessage("Empate los dos Eligimos papel");
                player->CLOSE_GOSSIP_MENU();
                break;
            case 2:
                ChatHandler(player->GetSession()).PSendSysMessage("Ganaste Eligiste Tijeras ");
                player->CLOSE_GOSSIP_MENU();
                break;
            }
            break;

        case 102:
            switch(rand()%3)
            {
            case 0:
                ChatHandler(player->GetSession()).PSendSysMessage("Ganaste Eligiste piedra");
                player->CLOSE_GOSSIP_MENU();
                break;
            case 1:
                ChatHandler(player->GetSession()).PSendSysMessage("Eligiste papel perdiste.");
                player->CLOSE_GOSSIP_MENU();
                break;
            case 2:
                ChatHandler(player->GetSession()).PSendSysMessage("Empate los dos Eligimos tijeras!");
                player->CLOSE_GOSSIP_MENU();
                break;
            }
            break;

        case 103:
            player->CLOSE_GOSSIP_MENU();
            break;
        }
        return true;
    }
};

void AddSC_events_pve_casino()
{
    new events_pve_casino_american_roulette();
    new events_pve_casino_npc_cachipun();
}
