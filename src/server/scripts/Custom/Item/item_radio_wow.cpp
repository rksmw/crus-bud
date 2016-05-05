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

#include "ScriptMgr.h"

enum itemradiowow
{
    // Item template
    ITEM_BLOOD_ELF_WITH_GUITAR      = 1000037,
    ITEM_SINGING_ORC                = 1000038,
    ITEM_TROLL_WITH_GUITAR          = 1000039,
    ITEM_TAUREN_ON_DRUMS            = 1000040,
    ITEM_UNDEAD_WITH_GUITAR         = 1000041,

    //Display ID
    DISPLAY_BLOOD_ELF_WITH_GUITAR   = 21666,
    DISPLAY_SINGING_ORC             = 21665,
    DISPLAY_TROLL_WITH_GUITAR       = 21662,
    DISPLAY_TAUREN_ON_DRUMS         = 21661,
    DISPLAY_UNDEAD_WITH_GUITAR      = 21659,
};

class item_radio_wow : public ItemScript
{
public:
    item_radio_wow() : ItemScript("item_radio_wow"){}


    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/) OVERRIDE
    {
        uint32 itemId = item->GetEntry();

        switch (itemId)
        {
            case ITEM_BLOOD_ELF_WITH_GUITAR:
                player->SetDisplayId(DISPLAY_BLOOD_ELF_WITH_GUITAR);
                break;
            case ITEM_SINGING_ORC:
                player->SetDisplayId(DISPLAY_SINGING_ORC);
                break;
            case ITEM_TROLL_WITH_GUITAR:
                player->SetDisplayId(DISPLAY_TROLL_WITH_GUITAR);
                break;
            case ITEM_TAUREN_ON_DRUMS:
                player->SetDisplayId(DISPLAY_TAUREN_ON_DRUMS);
                break;
            case ITEM_UNDEAD_WITH_GUITAR:
                player->SetDisplayId(DISPLAY_UNDEAD_WITH_GUITAR);
                break;
        }
        return true;
    }
};

void AddSC_item_radio_wow()
{
    new item_radio_wow();
}
