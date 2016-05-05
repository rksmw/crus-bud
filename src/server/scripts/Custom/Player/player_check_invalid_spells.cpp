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
#include "SpellMgr.h"
#include "SpellInfo.h"
#include "Player.h"

class player_check_invalid_spells : public PlayerScript
{
public:
    std::vector<uint32> ignoreSpells;

    player_check_invalid_spells() : PlayerScript("player_check_invalid_spells") {}

    void OnLogin(Player* player)
   	{
   		if (!player)
   			return;

        if (!AccountMgr::IsPlayerAccount(player->GetSession()->GetSecurity()))
            return;

        ChrClassesEntry const* classEntry = sChrClassesStore.LookupEntry(player->getClass());
        if (!classEntry)
            return;

        uint32 family = classEntry->spellfamily;

        for (uint32 i = 0; i < sSkillLineAbilityStore.GetNumRows(); ++i)
        {
            SkillLineAbilityEntry const* entry = sSkillLineAbilityStore.LookupEntry(i);
            if (!entry)
                continue;

            // Descartamos profesiones primarias y secundarias, lenguajes y weapon (si es que son el skill)
            for (uint32 i = 0; i < sSkillLineStore.GetNumRows(); ++i)
            {
                SkillLineEntry const* skillInfo = sSkillLineStore.LookupEntry(i);
                if (!skillInfo)
                    continue;

                if ((skillInfo->categoryId == SKILL_CATEGORY_PROFESSION ||
                     skillInfo->categoryId == SKILL_CATEGORY_SECONDARY ||
                     skillInfo->categoryId == SKILL_CATEGORY_LANGUAGES ||
                     skillInfo->categoryId == SKILL_CATEGORY_WEAPON) && skillInfo->id == entry->spellId)
                    continue;
            }

            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(entry->spellId);
            if (!spellInfo)
                continue;

            // Casos especiales
            switch (spellInfo->Id)
            {
                case 33388: // Apprentice Riding
                case 33391: // Journeyman Riding
                case 34091: // Artisan Riding
                case 34090: // Expert Riding
                case 54197: // Cold Weather Flying
                    continue;
            }

            // Ignoramos los ranks
            if (sSpellMgr->GetSpellRank(spellInfo->Id) > 1)
                continue;

            // Saltamos cuando no tiene la spell
            if (!player->HasSpell(spellInfo->Id))
                continue;

            bool isDefaultSpell = false;
            PlayerInfo const* info = sObjectMgr->GetPlayerInfo(player->getORace(), player->getClass());
            for (PlayerCreateInfoSpells::const_iterator itr = info->spell.begin(); itr != info->spell.end(); ++itr)
            {
                uint32 spellId = *itr;
                if (spellId == spellInfo->Id)
                {
                    isDefaultSpell = true;
                    break;
                }
            }

            // Saltamos las spells defaults
            if (isDefaultSpell)
                continue;

            bool isRewardQuest = false;
            for (RewardedQuestSet::const_iterator itr = player->getRewardedQuests().begin(); itr != player->getRewardedQuests().end(); ++itr)
            {
                Quest const* quest = sObjectMgr->GetQuestTemplate(*itr);
                if (!quest)
                    continue;

                int32 spell_id = quest->GetRewSpellCast();
                uint32 src_spell_id = quest->GetSrcSpell();

                // if RewSpellCast = -1 we remove aura do to SrcSpell from player.
                if (spell_id == -1 && src_spell_id)
                {
                    player->RemoveAurasDueToSpell(src_spell_id);
                    continue;
                }

                SpellInfo const* spellInfo2 = sSpellMgr->GetSpellInfo(spell_id);
                if (!spellInfo2)
                    continue;

                // check learned spells state
                for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                    if (spellInfo2->Effects[i].Effect == SPELL_EFFECT_LEARN_SPELL && spellInfo2->Effects[i].TriggerSpell == spellInfo->Id)
                    {
                        isRewardQuest = true;
                        break;
                    }

                if (isRewardQuest)
                    break;
            }

            // Satalmos las habilidades obtenidas por misiones
            if (isRewardQuest)
                continue;

            // skip server-side/triggered spells
            if (spellInfo->SpellLevel == 0)
            {
                player->removeSpell(spellInfo->Id, false);
                continue;
            }

            // skip wrong class/race skills
            if (!player->IsSpellFitByClassAndRace(spellInfo->Id))
            {
                player->removeSpell(spellInfo->Id, false);
                continue;
            }

            // skip other spell families
            if (spellInfo->SpellFamilyName != family)
            {
                player->removeSpell(spellInfo->Id, false);
                continue;
            }

            // skip spells with first rank learned as talent (and all talents then also)
            if (GetTalentSpellCost(spellInfo->Id) > 0)
            {
                player->removeSpell(spellInfo->Id, false);
                continue;
            }

            // skip broken spells
            if (!SpellMgr::IsSpellValid(spellInfo, player, false))
            {
                player->removeSpell(spellInfo->Id, false);
                continue;
            }
        }
    }
};

void AddSC_player_check_invalid_spells()
{
    //new player_check_invalid_spells();
}
