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
#include "ScriptMgr.h"

class learn_spells_on_level_up : public PlayerScript
{
public:
    learn_spells_on_level_up() : PlayerScript ("learn_spells_on_level_up") {}

    void OnLevelChanged(Player* player, uint8 oldLevel)
    {
        uint8 newLevel = player->getLevel();
        if (newLevel < oldLevel) return;
        uint32 entry;

        switch (player->getClass()) 
        {
            case CLASS_ROGUE: 
                entry = 917;
                break;
            case CLASS_PRIEST: 
                entry = 377; 
                break;
            case CLASS_MAGE: 
                entry = 328; 
                break;
            case CLASS_PALADIN: 
                entry = 927; 
                break;
            case CLASS_WARRIOR: 
                entry = 913; 
                break;
            case CLASS_SHAMAN: 
                entry = 20407; 
                break;
            case CLASS_DRUID: 
                entry = 5505; 
                break;
            case CLASS_HUNTER: 
                entry = 5515; 
                break;
            case CLASS_WARLOCK: 
                entry = 5496; 
                break;
            case CLASS_DEATH_KNIGHT: 
                entry = 29196; 
                break;
        }

        TrainerSpellData const* t_spells = (sObjectMgr->GetNpcTrainerSpells(entry));
        for (TrainerSpellMap::const_iterator itr = t_spells->spellList.begin(); itr != t_spells->spellList.end(); ++itr) 
        {
            uint32 f_spell = itr->first;
            TrainerSpell const* spell = t_spells->Find(f_spell);
            if (!spell) continue;
            if ((spell->reqLevel > newLevel) || (player->HasSpell(f_spell))) continue;
            const SpellInfo* prevSpellInfo = sSpellMgr->GetSpellInfo(f_spell)->GetPrevRankSpell();
            if ((prevSpellInfo && player->HasSpell(prevSpellInfo->Id)) || !prevSpellInfo) player->learnSpell(f_spell, false);
        }
    }
};

void AddSC_player_learn_spells_on_level_up()
{
    /*new learn_spells_on_level_up();*/
}