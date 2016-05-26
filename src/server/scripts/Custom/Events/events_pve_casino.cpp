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
            _color = "Black";
        case 2:
            _color = "Red";
        case 3:
            _color = "Green";
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

        player->ADD_GOSSIP_ITEM(3, "I want to play American Roulette", GOSSIP_SENDER_MAIN, 1337);
        player->ADD_GOSSIP_ITEM(3, "How to play?", GOSSIP_SENDER_MAIN, 999);
        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player * player, Creature * creature, uint32 sender, uint32 uiAction) 
    {
        player->PlayerTalkClass->ClearMenus();

        if (uiAction == 1337)
        {
            player->ADD_GOSSIP_ITEM(3, "I want to bet on a number.", GOSSIP_SENDER_MAIN,997);
            player->ADD_GOSSIP_ITEM(3, "I want to bet on a color.", GOSSIP_SENDER_MAIN, 996);
            player->ADD_GOSSIP_ITEM(3, "I want to bet on a number set.", GOSSIP_SENDER_MAIN, 995);
            player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }


        if(uiAction == 997)
        {
            player->ADD_GOSSIP_ITEM(3, "Statistics for this table:\nOdds 35:1 (1-36, 0, y 00)\n Reward: x35", GOSSIP_SENDER_MAIN, 997);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 0.", GOSSIP_SENDER_MAIN, 0, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 1.", GOSSIP_SENDER_MAIN, 1, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 2.", GOSSIP_SENDER_MAIN, 2, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 3.", GOSSIP_SENDER_MAIN, 3, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 4.", GOSSIP_SENDER_MAIN, 4, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 5.", GOSSIP_SENDER_MAIN, 5, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 6.", GOSSIP_SENDER_MAIN, 6, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 7.", GOSSIP_SENDER_MAIN, 7, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 8.", GOSSIP_SENDER_MAIN, 8, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 9.", GOSSIP_SENDER_MAIN, 9, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM(3, "Incoming", GOSSIP_SENDER_MAIN, 1338);
            player->ADD_GOSSIP_ITEM(3, "Attracted", GOSSIP_SENDER_MAIN, 1337);
            player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }

        if(uiAction == 1338)
        {
            player->ADD_GOSSIP_ITEM(3, "Statistics for this table:\nOdds 35:1 (1-36, 0, y 00)\n Reward: x35", GOSSIP_SENDER_MAIN, 997);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero aposta a 10.", GOSSIP_SENDER_MAIN, 10, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero aposta a 11.", GOSSIP_SENDER_MAIN, 11, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero aposta a 12.", GOSSIP_SENDER_MAIN, 12, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero aposta a 13.", GOSSIP_SENDER_MAIN, 13, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero aposta a 14.", GOSSIP_SENDER_MAIN, 14, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero aposta a 15.", GOSSIP_SENDER_MAIN, 15, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero aposta a 16.", GOSSIP_SENDER_MAIN, 16, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero aposta a 17.", GOSSIP_SENDER_MAIN, 17, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "Quiero aposta a 18.", GOSSIP_SENDER_MAIN, 18, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM(3, "Incoming", GOSSIP_SENDER_MAIN, 1339);
            player->ADD_GOSSIP_ITEM(3, "Attracted", GOSSIP_SENDER_MAIN, 997);
            player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }

        if(uiAction == 1339)
        {
            player->ADD_GOSSIP_ITEM(3, "Statistics for this table:\nOdds 35:1 (1-36, 0, y 00)\n Reward: x35", GOSSIP_SENDER_MAIN, 997);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 19.", GOSSIP_SENDER_MAIN, 19, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 20.", GOSSIP_SENDER_MAIN, 20, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 21.", GOSSIP_SENDER_MAIN, 21, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 22.", GOSSIP_SENDER_MAIN, 22, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 23.", GOSSIP_SENDER_MAIN, 23, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 24.", GOSSIP_SENDER_MAIN, 24, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 25.", GOSSIP_SENDER_MAIN, 25, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 26.", GOSSIP_SENDER_MAIN, 26, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 27.", GOSSIP_SENDER_MAIN, 27, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM(3, "Incoming", GOSSIP_SENDER_MAIN, 1340);
            player->ADD_GOSSIP_ITEM(3, "Attracted", GOSSIP_SENDER_MAIN, 1338);
            player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }

        if(uiAction == 1340)
        {
            player->ADD_GOSSIP_ITEM(3, "Statistics for this table:\nOdds 35:1 (1-36, 0, y 00)\n Reward: x35", GOSSIP_SENDER_MAIN, 997);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 28.", GOSSIP_SENDER_MAIN, 28, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 29.", GOSSIP_SENDER_MAIN, 29, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 30.", GOSSIP_SENDER_MAIN, 30, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 31.", GOSSIP_SENDER_MAIN, 31, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 32.", GOSSIP_SENDER_MAIN, 32, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 33.", GOSSIP_SENDER_MAIN, 33, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 34.", GOSSIP_SENDER_MAIN, 34, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 35.", GOSSIP_SENDER_MAIN, 35, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 36.", GOSSIP_SENDER_MAIN, 36, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 00.", GOSSIP_SENDER_MAIN, 37, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM(3, "Back", GOSSIP_SENDER_MAIN, 1339);
            player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }


        if(uiAction == 996)
        {
            player->ADD_GOSSIP_ITEM(3, "Statistics for this table:\nOdds 1:1 (green is 1:17, as it is 0 to 00)\n Reward: x1 (x17) ", GOSSIP_SENDER_MAIN, 996);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet Red.", GOSSIP_SENDER_MAIN, 800, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet Black.", GOSSIP_SENDER_MAIN, 810, "How much you wanna bet gold?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet Green.", GOSSIP_SENDER_MAIN, 818, "How much you wanna bet gold?", 0, true);     
            player->ADD_GOSSIP_ITEM(3, "Attracted", GOSSIP_SENDER_MAIN, 1337);
            player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }

        if(uiAction == 995)
        {
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 1-12. 2:1,  Reward: 3x", GOSSIP_SENDER_MAIN, 700, "How much money do you want to bet?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 13-24. 2:1, Reward: 3x", GOSSIP_SENDER_MAIN, 701, "How much money do you want to bet?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 25-36. 2:1, Reward: 3x", GOSSIP_SENDER_MAIN, 702, "How much money do you want to bet?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 1-5. 7:1    Reward: 7x", GOSSIP_SENDER_MAIN, 703, "How much money do you want to bet?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 6-10. 7:1   Reward: 7x", GOSSIP_SENDER_MAIN, 704, "How much money do you want to bet?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 11-15. 7:1  Reward: 7x", GOSSIP_SENDER_MAIN, 705, "How much money do you want to bet?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 16-20. 7:1  Reward: 7x", GOSSIP_SENDER_MAIN, 706, "How much money do you want to bet?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 21-25. 7:1  Reward: 7x", GOSSIP_SENDER_MAIN, 707, "How much money do you want to bet?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 26-30. 7:1  Reward: 7x", GOSSIP_SENDER_MAIN, 708, "How much money do you want to bet?", 0, true);
            player->ADD_GOSSIP_ITEM_EXTENDED(3, "I want to bet on 31-35. 7:1  Reward: 7x", GOSSIP_SENDER_MAIN, 709, "How much money do you want to bet?", 0, true);
            player->ADD_GOSSIP_ITEM(3, "Attracted", GOSSIP_SENDER_MAIN, 1337);
            player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }

        if(uiAction == 999)
        {
            player->ADD_GOSSIP_ITEM(7, "A ball is thrown in the roulette table when the ball stops in a number of colors, you win or lose your bet. You can bet on specific numbers, pairs, odd colors or ranges 1-18 and 19-36 numbers. Reward for their colors will be the Incomings: \n Black: 2, 28, 26, 11, 20, 17, 22, 15, 24, 13, 10, 29, 8, 31, 6, 33, 4, 35 \n red: 9, 30, 7, 32, 5, 34, 3, 36, 1, 27, 25, 12, 19, 18, 21, 16, 23, 14 \n green: 0, 00", GOSSIP_SENDER_MAIN, 666);
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
            player->GetSession()->SendNotification("You do not have enough money");
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
                message << "AAAAANaaaa and the ball falls into..." << std::setw(1)  << colorstring(color) << std::setw(1)  << "Felicitaciones" << std::setw(1) << player->GetName() << std::setw(1)  << " Has ganado" << std::setw(1) << winnings << std::setw(1) << "oros!";
                player->MonsterWhisper(message.str().c_str(), player);
                return true;

            }
            else
            {
                player->ModifyMoney(player->GetMoney() - moneybet);
                message << "AAAAANaaaa and the ball falls into..." << std::setw(1) << colorstring(color) << std::setw(1) << "..buuuuu lo sentimos, " << std::setw(1) << player->GetName() << std::setw(1) << ", as perdido, mejor suerte para el proximo juego";
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
                message << "AAAAANaaaa and the ball falls into..." << std::setw(1)  << winningnumber << std::setw(1) << "Congratulation" << std::setw(1) << player->GetName() << std::setw(1) << " You've won" << std::setw(1) << winnings << std::setw(1) << "golds!";
                player->MonsterWhisper(message.str().c_str(), player);
                return true;
            }
            else
            {
                player->ModifyMoney(player->GetMoney() - moneybet);
                message << "AAAAANaaaa and the ball falls into..." << std::setw(1) << winningnumber << std::setw(1)  <<  "..buuuuu we are sorry, " << std::setw(1) << player->GetName() << std::setw(1) << ", you lost, better luck next game";
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
                me->MonsterSay("Come one come all, make your bet on the American Roulette Now!", LANG_UNIVERSAL, NULL);
                me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                me->CastSpell(me, 44940);
                uiAdATimer = 61000;
            }
            else
                uiAdATimer -= diff;

            if(uiAdBTimer <= diff)
            {
                me->MonsterSay("Come on guys! Place your bets, or perhaps you are a chicken?", LANG_UNIVERSAL, NULL);
                me->HandleEmoteCommand(EMOTE_ONESHOT_CHICKEN);
                uiAdBTimer = 61000;
            }
            else
                uiAdBTimer -= diff;

            if(uiAdCTimer <= diff)
            {
                me->MonsterSay("Want to be a Millionaire ?, then do not cry and come to try their luck in the American roulette", LANG_UNIVERSAL, NULL);
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
        player->ADD_GOSSIP_ITEM(0, "Choose Rock.", GOSSIP_SENDER_MAIN, 100);
        player->ADD_GOSSIP_ITEM(0, "Choose Paper.", GOSSIP_SENDER_MAIN, 101);
        player->ADD_GOSSIP_ITEM(0, "Choose Scissors.", GOSSIP_SENDER_MAIN, 102);
        player->ADD_GOSSIP_ITEM(0, "Leave", GOSSIP_SENDER_MAIN, 103);
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
                ChatHandler(player->GetSession()).PSendSysMessage("We choose the two rock tie.");
                player->CLOSE_GOSSIP_MENU();
                break;
            case 1:
                ChatHandler(player->GetSession()).PSendSysMessage("You chose Paper and you won.");
                player->CLOSE_GOSSIP_MENU();
                break;
            case 2:
                ChatHandler(player->GetSession()).PSendSysMessage("Your choice Scissors lost.");
                player->CLOSE_GOSSIP_MENU();
                break;
            }
            break;

        case 101:
            switch(rand()%3)
            {
            case 0:
                ChatHandler(player->GetSession()).PSendSysMessage("You choose stone and you win.");
                player->CLOSE_GOSSIP_MENU();
                break;
            case 1:
                ChatHandler(player->GetSession()).PSendSysMessage("Tie the two choose paper.");
                player->CLOSE_GOSSIP_MENU();
                break;
            case 2:
                ChatHandler(player->GetSession()).PSendSysMessage("Your choice Scissors win.");
                player->CLOSE_GOSSIP_MENU();
                break;
            }
            break;

        case 102:
            switch(rand()%3)
            {
            case 0:
                ChatHandler(player->GetSession()).PSendSysMessage("You choose stone and you win.");
                player->CLOSE_GOSSIP_MENU();
                break;
            case 1:
                ChatHandler(player->GetSession()).PSendSysMessage("You choose paper and you lost.");
                player->CLOSE_GOSSIP_MENU();
                break;
            case 2:
                ChatHandler(player->GetSession()).PSendSysMessage("Draw the two choose scissors.");
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
