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

enum LevelRewards
{
    EMBLEM_OF_TRIUMPH  = 47241
};

class Evento_Bienvenida : public PlayerScript
{
public:
    Evento_Bienvenida() : PlayerScript("Evento_Bienvenida") {}

    void OnLevelChanged(Player* player, uint8 oldLevel)
    {
        if (player->IsGameMaster())
            return;

        uint32 oro = 0;

        switch (oldLevel)
        {
            case 79:
                oro = 2000000;
                break;
        }
        
        
        if (oldLevel == 79) 
        {
            MailSender sender(MAIL_NORMAL, 0, MAIL_STATIONERY_GM);
            MailDraft draft("Premio Nivel 80", "Por tu esfuerzo y dedicacion al progresar para ayudarnos a defender Azeroth, te enviamos este regalo- Consejo de Paz de Azeroth -. :)");
            SQLTransaction trans = CharacterDatabase.BeginTransaction();

            if (oro > 0)
            draft.AddMoney(oro);

            Item* item = Item::CreateItem(EMBLEM_OF_TRIUMPH, 755, 0);
            item->SaveToDB(trans);
            draft.AddItem(item);

            draft.SendMailTo(trans, MailReceiver(player), sender);
            CharacterDatabase.CommitTransaction(trans);
        }
    }
};

void AddSC_player_welcome()
{
    //new Evento_Bienvenida();
}