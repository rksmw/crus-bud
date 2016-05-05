/*
 * Copyright (C) 2008-2013 TrinityCore <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/*
 * Spells used in holidays/game events that do not fit any other category.
 * Ordered alphabetically using scriptname.
 * Scriptnames in this file should be prefixed with "spell_#holidayname_".
 */

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "CellImpl.h"

// 45102 Romantic Picnic
enum SpellsPicnic
{
    SPELL_BASKET_CHECK              = 45119, // Holiday - Valentine - Romantic Picnic Near Basket Check
    SPELL_MEAL_PERIODIC             = 45103, // Holiday - Valentine - Romantic Picnic Meal Periodic - effect dummy
    SPELL_MEAL_EAT_VISUAL           = 45120, // Holiday - Valentine - Romantic Picnic Meal Eat Visual
    //SPELL_MEAL_PARTICLE             = 45114, // Holiday - Valentine - Romantic Picnic Meal Particle - unused
    SPELL_DRINK_VISUAL              = 45121, // Holiday - Valentine - Romantic Picnic Drink Visual
    SPELL_ROMANTIC_PICNIC_ACHIEV    = 45123, // Romantic Picnic periodic = 5000
};

class spell_love_is_in_the_air_romantic_picnic : public SpellScriptLoader
{
    public:
        spell_love_is_in_the_air_romantic_picnic() : SpellScriptLoader("spell_love_is_in_the_air_romantic_picnic") { }

        class spell_love_is_in_the_air_romantic_picnic_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_love_is_in_the_air_romantic_picnic_AuraScript);

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                target->SetStandState(UNIT_STAND_STATE_SIT);
                target->CastSpell(target, SPELL_MEAL_PERIODIC, false);
            }

            void OnPeriodic(AuraEffect const* /*aurEff*/)
            {
                // Every 5 seconds
                Unit* target = GetTarget();
                Unit* caster = GetCaster();

                // If our player is no longer sit, remove all auras
                if (target->getStandState() != UNIT_STAND_STATE_SIT)
                {
                    target->RemoveAura(SPELL_ROMANTIC_PICNIC_ACHIEV);
                    target->RemoveAura(GetAura());
                    return;
                }

                target->CastSpell(target, SPELL_BASKET_CHECK, false); // unknown use, it targets Romantic Basket
                target->CastSpell(target, RAND(SPELL_MEAL_EAT_VISUAL, SPELL_DRINK_VISUAL), false);

                bool foundSomeone = false;
                // For nearby players, check if they have the same aura. If so, cast Romantic Picnic (45123)
                // required by achievement and "hearts" visual
                std::list<Player*> playerList;
                Trinity::AnyPlayerInObjectRangeCheck checker(target, INTERACTION_DISTANCE*2);
                Trinity::PlayerListSearcher<Trinity::AnyPlayerInObjectRangeCheck> searcher(target, playerList, checker);
                target->VisitNearbyWorldObject(INTERACTION_DISTANCE*2, searcher);
                for (std::list<Player*>::const_iterator itr = playerList.begin(); itr != playerList.end(); ++itr)
                {
                    if ((*itr) != target && (*itr)->HasAura(GetId())) // && (*itr)->getStandState() == UNIT_STAND_STATE_SIT)
                    {
                        if (caster)
                        {
                            caster->CastSpell(*itr, SPELL_ROMANTIC_PICNIC_ACHIEV, true);
                            caster->CastSpell(target, SPELL_ROMANTIC_PICNIC_ACHIEV, true);
                        }
                        foundSomeone = true;
                        // break;
                    }
                }

                if (!foundSomeone && target->HasAura(SPELL_ROMANTIC_PICNIC_ACHIEV))
                    target->RemoveAura(SPELL_ROMANTIC_PICNIC_ACHIEV);
            }

            void Register() OVERRIDE
            {
                AfterEffectApply += AuraEffectApplyFn(spell_love_is_in_the_air_romantic_picnic_AuraScript::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_love_is_in_the_air_romantic_picnic_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const OVERRIDE
        {
            return new spell_love_is_in_the_air_romantic_picnic_AuraScript();
        }
};

// 24750 Trick
enum TrickSpells
{
    SPELL_PIRATE_COSTUME_MALE           = 24708,
    SPELL_PIRATE_COSTUME_FEMALE         = 24709,
    SPELL_NINJA_COSTUME_MALE            = 24710,
    SPELL_NINJA_COSTUME_FEMALE          = 24711,
    SPELL_LEPER_GNOME_COSTUME_MALE      = 24712,
    SPELL_LEPER_GNOME_COSTUME_FEMALE    = 24713,
    SPELL_SKELETON_COSTUME              = 24723,
    SPELL_GHOST_COSTUME_MALE            = 24735,
    SPELL_GHOST_COSTUME_FEMALE          = 24736,
    SPELL_TRICK_BUFF                    = 24753,
};

class spell_hallow_end_trick : public SpellScriptLoader
{
    public:
        spell_hallow_end_trick() : SpellScriptLoader("spell_hallow_end_trick") { }

        class spell_hallow_end_trick_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hallow_end_trick_SpellScript);

            bool Validate(SpellInfo const* /*spell*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_PIRATE_COSTUME_MALE) || !sSpellMgr->GetSpellInfo(SPELL_PIRATE_COSTUME_FEMALE) || !sSpellMgr->GetSpellInfo(SPELL_NINJA_COSTUME_MALE)
                    || !sSpellMgr->GetSpellInfo(SPELL_NINJA_COSTUME_FEMALE) || !sSpellMgr->GetSpellInfo(SPELL_LEPER_GNOME_COSTUME_MALE) || !sSpellMgr->GetSpellInfo(SPELL_LEPER_GNOME_COSTUME_FEMALE)
                    || !sSpellMgr->GetSpellInfo(SPELL_SKELETON_COSTUME) || !sSpellMgr->GetSpellInfo(SPELL_GHOST_COSTUME_MALE) || !sSpellMgr->GetSpellInfo(SPELL_GHOST_COSTUME_FEMALE) || !sSpellMgr->GetSpellInfo(SPELL_TRICK_BUFF))
                    return false;
                return true;
            }

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (Player* target = GetHitPlayer())
                {
                    uint8 gender = target->getGender();
                    uint32 spellId = SPELL_TRICK_BUFF;
                    switch (urand(0, 5))
                    {
                        case 1:
                            spellId = gender ? SPELL_LEPER_GNOME_COSTUME_FEMALE : SPELL_LEPER_GNOME_COSTUME_MALE;
                            break;
                        case 2:
                            spellId = gender ? SPELL_PIRATE_COSTUME_FEMALE : SPELL_PIRATE_COSTUME_MALE;
                            break;
                        case 3:
                            spellId = gender ? SPELL_GHOST_COSTUME_FEMALE : SPELL_GHOST_COSTUME_MALE;
                            break;
                        case 4:
                            spellId = gender ? SPELL_NINJA_COSTUME_FEMALE : SPELL_NINJA_COSTUME_MALE;
                            break;
                        case 5:
                            spellId = SPELL_SKELETON_COSTUME;
                            break;
                        default:
                            break;
                    }

                    caster->CastSpell(target, spellId, true);
                }
            }

            void Register() OVERRIDE
            {
                OnEffectHitTarget += SpellEffectFn(spell_hallow_end_trick_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const OVERRIDE
        {
            return new spell_hallow_end_trick_SpellScript();
        }
};

// 24751 Trick or Treat
enum TrickOrTreatSpells
{
    SPELL_TRICK                 = 24714,
    SPELL_TREAT                 = 24715,
    SPELL_TRICKED_OR_TREATED    = 24755,
    SPELL_TRICKY_TREAT_SPEED    = 42919,
    SPELL_TRICKY_TREAT_TRIGGER  = 42965,
    SPELL_UPSET_TUMMY           = 42966
};

class spell_hallow_end_trick_or_treat : public SpellScriptLoader
{
    public:
        spell_hallow_end_trick_or_treat() : SpellScriptLoader("spell_hallow_end_trick_or_treat") {}

        class spell_hallow_end_trick_or_treat_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hallow_end_trick_or_treat_SpellScript);

            bool Validate(SpellInfo const* /*spell*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_TRICK) || !sSpellMgr->GetSpellInfo(SPELL_TREAT) || !sSpellMgr->GetSpellInfo(SPELL_TRICKED_OR_TREATED))
                    return false;
                return true;
            }

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (Player* target = GetHitPlayer())
                {
                    caster->CastSpell(target, roll_chance_i(50) ? SPELL_TRICK : SPELL_TREAT, true);
                    caster->CastSpell(target, SPELL_TRICKED_OR_TREATED, true);
                }
            }

            void Register() OVERRIDE
            {
                OnEffectHitTarget += SpellEffectFn(spell_hallow_end_trick_or_treat_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const OVERRIDE
        {
            return new spell_hallow_end_trick_or_treat_SpellScript();
        }
};

class spell_hallow_end_tricky_treat : public SpellScriptLoader
{
    public:
        spell_hallow_end_tricky_treat() : SpellScriptLoader("spell_hallow_end_tricky_treat") { }

        class spell_hallow_end_tricky_treat_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hallow_end_tricky_treat_SpellScript);

            bool Validate(SpellInfo const* /*spell*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_TRICKY_TREAT_SPEED))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_TRICKY_TREAT_TRIGGER))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_UPSET_TUMMY))
                    return false;
                return true;
            }

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (caster->HasAura(SPELL_TRICKY_TREAT_TRIGGER) && caster->GetAuraCount(SPELL_TRICKY_TREAT_SPEED) > 3 && roll_chance_i(33))
                    caster->CastSpell(caster, SPELL_UPSET_TUMMY, true);
            }

            void Register() OVERRIDE
            {
                OnEffectHitTarget += SpellEffectFn(spell_hallow_end_tricky_treat_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const OVERRIDE
        {
            return new spell_hallow_end_tricky_treat_SpellScript();
        }
};

enum Mistletoe
{
    SPELL_CREATE_MISTLETOE          = 26206,
    SPELL_CREATE_HOLLY              = 26207,
    SPELL_CREATE_SNOWFLAKES         = 45036
};

class spell_winter_veil_mistletoe : public SpellScriptLoader
{
    public:
        spell_winter_veil_mistletoe() : SpellScriptLoader("spell_winter_veil_mistletoe") { }

        class spell_winter_veil_mistletoe_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_winter_veil_mistletoe_SpellScript);

            bool Validate(SpellInfo const* /*spell*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_CREATE_MISTLETOE) ||
                    !sSpellMgr->GetSpellInfo(SPELL_CREATE_HOLLY) ||
                    !sSpellMgr->GetSpellInfo(SPELL_CREATE_SNOWFLAKES))
                    return false;
                return true;
            }

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                if (Player* target = GetHitPlayer())
                {
                    uint32 spellId = RAND(SPELL_CREATE_HOLLY, SPELL_CREATE_MISTLETOE, SPELL_CREATE_SNOWFLAKES);
                    GetCaster()->CastSpell(target, spellId, true);
                }
            }

            void Register() OVERRIDE
            {
                OnEffectHitTarget += SpellEffectFn(spell_winter_veil_mistletoe_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const OVERRIDE
        {
            return new spell_winter_veil_mistletoe_SpellScript();
        }
};

// 26275 - PX-238 Winter Wondervolt TRAP
enum PX238WinterWondervolt
{
    SPELL_PX_238_WINTER_WONDERVOLT_TRANSFORM_1  = 26157,
    SPELL_PX_238_WINTER_WONDERVOLT_TRANSFORM_2  = 26272,
    SPELL_PX_238_WINTER_WONDERVOLT_TRANSFORM_3  = 26273,
    SPELL_PX_238_WINTER_WONDERVOLT_TRANSFORM_4  = 26274
};

class spell_winter_veil_px_238_winter_wondervolt : public SpellScriptLoader
{
    public:
        spell_winter_veil_px_238_winter_wondervolt() : SpellScriptLoader("spell_winter_veil_px_238_winter_wondervolt") { }

        class spell_winter_veil_px_238_winter_wondervolt_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_winter_veil_px_238_winter_wondervolt_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_PX_238_WINTER_WONDERVOLT_TRANSFORM_1) ||
                    !sSpellMgr->GetSpellInfo(SPELL_PX_238_WINTER_WONDERVOLT_TRANSFORM_2) ||
                    !sSpellMgr->GetSpellInfo(SPELL_PX_238_WINTER_WONDERVOLT_TRANSFORM_3) ||
                    !sSpellMgr->GetSpellInfo(SPELL_PX_238_WINTER_WONDERVOLT_TRANSFORM_4))
                    return false;
                return true;
            }

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);

                uint32 const spells[4] =
                {
                    SPELL_PX_238_WINTER_WONDERVOLT_TRANSFORM_1,
                    SPELL_PX_238_WINTER_WONDERVOLT_TRANSFORM_2,
                    SPELL_PX_238_WINTER_WONDERVOLT_TRANSFORM_3,
                    SPELL_PX_238_WINTER_WONDERVOLT_TRANSFORM_4
                };

                if (Unit* target = GetHitUnit())
                {
                    for (uint8 i = 0; i < 4; ++i)
                        if (target->HasAura(spells[i]))
                            return;

                    target->CastSpell(target, spells[urand(0, 3)], true);
                }
            }

            void Register() OVERRIDE
            {
                OnEffectHitTarget += SpellEffectFn(spell_winter_veil_px_238_winter_wondervolt_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }

        private:

        };

        SpellScript* GetSpellScript() const OVERRIDE
        {
            return new spell_winter_veil_px_238_winter_wondervolt_SpellScript();
        }
};

// 45819 - Throw Torch
enum SpellsTorch
{
    SPELL_JUGGLE_TORCH_SLOW    = 45792,
    SPELL_JUGGLE_TORCH_MEDIUM  = 45806,
    SPELL_JUGGLE_TORCH_FAST    = 45816
};

class spell_midsummer_throw_torch : public SpellScriptLoader
{
public:
    spell_midsummer_throw_torch() : SpellScriptLoader("spell_midsummer_throw_torch") { }

    class spell_midsummer_throw_torchSpellScript : public SpellScript
    {
        PrepareSpellScript(spell_midsummer_throw_torchSpellScript);

        void HandleDummyHit(SpellEffIndex /*effIndex*/)
        {
            Unit* caster = GetCaster();
            uint32 spellId = 0;

            switch (urand(1,3))
            {
                case 1:
                    spellId = SPELL_JUGGLE_TORCH_SLOW;
                    break;
                case 2:
                    spellId = SPELL_JUGGLE_TORCH_MEDIUM;
                    break;
                case 3:
                    spellId = SPELL_JUGGLE_TORCH_FAST;
                    break;
            }

            caster->CastSpell(GetExplTargetDest()->GetPositionX(),GetExplTargetDest()->GetPositionY(),GetExplTargetDest()->GetPositionZ(),spellId,true,0,0,0);
        }

        void Register() OVERRIDE
        {
            OnEffectHit += SpellEffectFn(spell_midsummer_throw_torchSpellScript::HandleDummyHit, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const OVERRIDE
    {
        return new spell_midsummer_throw_torchSpellScript();
    }
};

// 45724 - Braziers Hit!
enum TorchTossing
{
    QUEST_TORCH_TOSSING_A       = 11731,
    QUEST_TORCH_TOSSING_H       = 11922,
    QUEST_MORE_TORCH_TOSSING_A  = 11921,
    QUEST_MORE_TORCH_TOSSING_H  = 11926
};

class spell_midsummer_braziers_hit : public SpellScriptLoader
{
public:
    spell_midsummer_braziers_hit() : SpellScriptLoader("spell_midsummer_braziers_hit") { }

    class spell_midsummer_braziers_hit_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_midsummer_braziers_hit_AuraScript);

        void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit* target = GetTarget();
            if (Player* player = target->ToPlayer())                
                switch (GetStackAmount())
                {
                    case 8:
                        if (player->GetQuestStatus(QUEST_TORCH_TOSSING_A) == QUEST_STATUS_INCOMPLETE)
                            player->AreaExploredOrEventHappens(QUEST_TORCH_TOSSING_A);
                        if (player->GetQuestStatus(QUEST_TORCH_TOSSING_H) == QUEST_STATUS_INCOMPLETE)
                            player->AreaExploredOrEventHappens(QUEST_TORCH_TOSSING_H);
                        break;
                    case 20:
                        if (player->GetQuestStatus(QUEST_MORE_TORCH_TOSSING_A) == QUEST_STATUS_INCOMPLETE)
                            player->AreaExploredOrEventHappens(QUEST_MORE_TORCH_TOSSING_A);
                        if (player->GetQuestStatus(QUEST_MORE_TORCH_TOSSING_H) == QUEST_STATUS_INCOMPLETE)
                            player->AreaExploredOrEventHappens(QUEST_MORE_TORCH_TOSSING_H);
                        break;
                    default:
                        break;
            }
        }

        void Register() OVERRIDE
        {
            AfterEffectApply += AuraEffectApplyFn(spell_midsummer_braziers_hit_AuraScript::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        }
    };

    AuraScript* GetAuraScript() const OVERRIDE
    {
        return new spell_midsummer_braziers_hit_AuraScript();
    }
};

// Quest - Torch Catching
enum TorchCatch
{
    SPELL_FLING_TORCH                 = 45669,
    SPELL_TORCH_TOSS_SHADOW           = 46105,
    SPELL_JUGGLE_TORCH_QUEST_MISSED   = 45676,
    SPELL_TORCHES_CAUGHT              = 45693,

    QUEST_TORCH_CATCHING_A            = 11657,
    QUEST_TORCH_CATCHING_H            = 11923,
    QUEST_MORE_TORCH_CATCHING_A       = 11924,
    QUEST_MORE_TORCH_CATCHING_H       = 11925,
};

class spell_midsummer_fling_torch : public SpellScriptLoader
{
public:
    spell_midsummer_fling_torch() : SpellScriptLoader("spell_midsummer_fling_torch") { }

    class spell_midsummer_fling_torchSpellScript : public SpellScript
    {
        PrepareSpellScript(spell_midsummer_fling_torchSpellScript);

        void HandleAfterCast()
        {
            Unit* caster = GetCaster();
            Position pos;
            caster->GetRandomNearPosition(pos, frand(20.0f, 30.0f));

            while (!caster->IsWithinLOS(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ()))
            {
                caster->GetFirstCollisionPosition(pos, caster->GetDistance2d(pos.GetPositionX(), pos.GetPositionY()), caster->GetAngle(pos.GetPositionX(), pos.GetPositionY()));
                if (caster->GetDistance2d(pos.GetPositionX(), pos.GetPositionY()) < 20.0f)
                    caster->GetRandomNearPosition(pos, frand(20.0f, 30.0f));
            }

            caster->CastSpell(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), SPELL_FLING_TORCH, true, 0, 0, caster->GetGUID());
            caster->CastSpell(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), SPELL_TORCH_TOSS_SHADOW, true, 0, 0, caster->GetGUID());
        }

        void Register() OVERRIDE
        {
            AfterCast += SpellCastFn(spell_midsummer_fling_torchSpellScript::HandleAfterCast);
        }
    };

    SpellScript* GetSpellScript() const OVERRIDE
    {
        return new spell_midsummer_fling_torchSpellScript();
    }
};

class spell_midsummer_juggle_torch_catch_quest : public SpellScriptLoader
{
public:
    spell_midsummer_juggle_torch_catch_quest() : SpellScriptLoader("spell_midsummer_juggle_torch_catch_quest") { }

    class spell_midsummer_juggle_torch_catch_questSpellScript : public SpellScript
    {
        PrepareSpellScript(spell_midsummer_juggle_torch_catch_questSpellScript);

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            Unit* target = GetHitUnit();
            if (Player* player = target->ToPlayer())
            {
                if (Aura* aura= player->GetAura(SPELL_TORCHES_CAUGHT))
                {
                    if (aura->GetStackAmount() == 3)
                    {
                        if (player->GetQuestStatus(QUEST_TORCH_CATCHING_A) == QUEST_STATUS_INCOMPLETE)
                        {
                            player->AreaExploredOrEventHappens(QUEST_TORCH_CATCHING_A);
                            player->RemoveAura(SPELL_TORCHES_CAUGHT);
                            return;
                        }
                        if (player->GetQuestStatus(QUEST_TORCH_CATCHING_H) == QUEST_STATUS_INCOMPLETE)
                        {
                            player->AreaExploredOrEventHappens(QUEST_TORCH_CATCHING_H);
                            player->RemoveAura(SPELL_TORCHES_CAUGHT);
                            return;
                        }
                    }
                    if (aura->GetStackAmount() == 9)
                    {
                        if (player->GetQuestStatus(QUEST_MORE_TORCH_CATCHING_A) == QUEST_STATUS_INCOMPLETE)
                        {
                            player->AreaExploredOrEventHappens(QUEST_MORE_TORCH_CATCHING_A);
                            player->RemoveAura(SPELL_TORCHES_CAUGHT);
                            return;
                        }
                        if (player->GetQuestStatus(QUEST_MORE_TORCH_CATCHING_H) == QUEST_STATUS_INCOMPLETE)
                        {
                            player->AreaExploredOrEventHappens(QUEST_MORE_TORCH_CATCHING_H);
                            player->RemoveAura(SPELL_TORCHES_CAUGHT);
                            return;
                        }
                    }
                }

                target->CastSpell(target, SPELL_TORCHES_CAUGHT, true);
                Position pos;
                target->GetRandomNearPosition(pos, frand(20.0f, 30.0f));

                while (!target->IsWithinLOS(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ()))
                {
                    target->GetFirstCollisionPosition(pos, target->GetDistance2d(pos.GetPositionX(), pos.GetPositionY()), target->GetAngle(pos.GetPositionX(), pos.GetPositionY()));
                    if (target->GetDistance2d(pos.GetPositionX(), pos.GetPositionY()) < 20.0f)
                        target->GetRandomNearPosition(pos, frand(20.0f, 30.0f));
                }

                target->CastSpell(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), SPELL_FLING_TORCH, true, 0, 0, target->GetGUID());
                target->CastSpell(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), SPELL_TORCH_TOSS_SHADOW, true, 0, 0, target->GetGUID());
                return;    
            }
            // This last part does not work, would have to leave if the torch falls to the ground
            Unit* caster = GetOriginalCaster();
            caster->CastSpell(GetExplTargetDest()->GetPositionX(),GetExplTargetDest()->GetPositionY(),GetExplTargetDest()->GetPositionZ(), SPELL_JUGGLE_TORCH_QUEST_MISSED, true);
            caster->RemoveAura(SPELL_TORCHES_CAUGHT);
        }

        void Register() OVERRIDE
        {
            OnEffectHitTarget += SpellEffectFn(spell_midsummer_juggle_torch_catch_questSpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const OVERRIDE
    {
        return new spell_midsummer_juggle_torch_catch_questSpellScript();
    }
};

// 45406 - Holiday - Midsummer, Ribbon Pole Periodic Visual
enum SpellsRibbon
{
    GO_RIBBON_POLE        = 181605,
    SPELL_DANCE_PERIODIC  = 45406,
    SPELL_CHANNEL_1       = 29705,
    SPELL_CHANNEL_2       = 29726,
    SPELL_CHANNEL_3       = 29727
};

class spell_midsummer_ribbon_pole_visual : public SpellScriptLoader
{
public:
    spell_midsummer_ribbon_pole_visual() : SpellScriptLoader("spell_midsummer_ribbon_pole_visual") { }

    class spell_midsummer_ribbon_pole_visual_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_midsummer_ribbon_pole_visual_AuraScript);

        void OnPeriodic(AuraEffect const* /*aurEff*/)
        {
            Unit* target = GetTarget();
            if (!target->FindNearestGameObject(GO_RIBBON_POLE,10.0f))
            {
                target->RemoveAura(SPELL_CHANNEL_1);
                target->RemoveAura(SPELL_CHANNEL_2);
                target->RemoveAura(SPELL_CHANNEL_3);
                target->RemoveAura(SPELL_DANCE_PERIODIC);
            }

        }

        void Register() OVERRIDE
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_midsummer_ribbon_pole_visual_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const OVERRIDE
    {
        return new spell_midsummer_ribbon_pole_visual_AuraScript();
    }
};

void AddSC_holiday_spell_scripts()
{
    // Love is in the Air
    new spell_love_is_in_the_air_romantic_picnic();
    // Hallow's End
    new spell_hallow_end_trick();
    new spell_hallow_end_trick_or_treat();
    new spell_hallow_end_tricky_treat();
    // Winter Veil
    new spell_winter_veil_mistletoe();
    new spell_winter_veil_px_238_winter_wondervolt();
    // Midsummer
    new spell_midsummer_throw_torch();
    new spell_midsummer_braziers_hit();
    new spell_midsummer_fling_torch();
    new spell_midsummer_juggle_torch_catch_quest();
    new spell_midsummer_ribbon_pole_visual();
}
