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
 * Scripts for spells with SPELLFAMILY_HUNTER, SPELLFAMILY_PET and SPELLFAMILY_GENERIC spells used by hunter players.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_hun_".
 */

#include "Pet.h"
#include "ScriptMgr.h"
#include "Cell.h"
#include "CellImpl.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"

enum HunterSpells
{
    SPELL_HUNTER_ASPECT_OF_THE_BEAST_PET            = 61669,
    SPELL_HUNTER_ASPECT_OF_THE_VIPER                = 34074,
    SPELL_HUNTER_ASPECT_OF_THE_VIPER_ENERGIZE       = 34075,
    SPELL_HUNTER_BESTIAL_WRATH                      = 19574,
    SPELL_HUNTER_CHIMERA_SHOT_SERPENT               = 53353,
    SPELL_HUNTER_CHIMERA_SHOT_VIPER                 = 53358,
    SPELL_HUNTER_CHIMERA_SHOT_SCORPID               = 53359,
    SPELL_HUNTER_GLYPH_OF_ASPECT_OF_THE_VIPER       = 56851,
    SPELL_HUNTER_IMPROVED_MEND_PET                  = 24406,
    SPELL_HUNTER_INVIGORATION_TRIGGERED             = 53398,
    SPELL_HUNTER_MASTERS_CALL_TRIGGERED             = 62305,
    SPELL_HUNTER_MISDIRECTION_PROC                  = 35079,
    SPELL_HUNTER_PET_LAST_STAND_TRIGGERED           = 53479,
    SPELL_HUNTER_PET_HEART_OF_THE_PHOENIX           = 55709,
    SPELL_HUNTER_PET_HEART_OF_THE_PHOENIX_TRIGGERED = 54114,
    SPELL_HUNTER_PET_HEART_OF_THE_PHOENIX_DEBUFF    = 55711,
    SPELL_HUNTER_PET_CARRION_FEEDER_TRIGGERED       = 54045,
    SPELL_HUNTER_READINESS                          = 23989,
    SPELL_HUNTER_SNIPER_TRAINING_R1                 = 53302,
    SPELL_HUNTER_SNIPER_TRAINING_BUFF_R1            = 64418,
    SPELL_HUNTER_VICIOUS_VIPER                      = 61609,
    SPELL_HUNTER_VIPER_ATTACK_SPEED                 = 60144,
    SPELL_DRAENEI_GIFT_OF_THE_NAARU                 = 59543,
    SPELL_HUNTER_ANIMAL_HANDLER						= 34453
};

enum HunterPetCalculate
{
	SPELL_TAMED_PET_PASSIVE_06 = 19591,
	SPELL_TAMED_PET_PASSIVE_07 = 20784,
	SPELL_TAMED_PET_PASSIVE_08 = 34666,
	SPELL_TAMED_PET_PASSIVE_09 = 34667,
	SPELL_TAMED_PET_PASSIVE_10 = 34675,
	SPELL_HUNTER_PET_SCALING_01 = 34902,
	SPELL_HUNTER_PET_SCALING_02 = 34903,
	SPELL_HUNTER_PET_SCALING_03 = 34904,
	SPELL_HUNTER_PET_SCALING_04 = 61017,
	SPELL_HUNTER_PET_SCALING_05 = 89446
};

// 13161 - Aspect of the Beast
class spell_hun_aspect_of_the_beast : public SpellScriptLoader
{
    public:
        spell_hun_aspect_of_the_beast() : SpellScriptLoader("spell_hun_aspect_of_the_beast") { }

        class spell_hun_aspect_of_the_beast_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_aspect_of_the_beast_AuraScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_ASPECT_OF_THE_BEAST_PET))
                    return false;
                return true;
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Player* caster = GetCaster()->ToPlayer())
                    if (Pet* pet = caster->GetPet())
                        pet->RemoveAurasDueToSpell(SPELL_HUNTER_ASPECT_OF_THE_BEAST_PET);
            }

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Player* caster = GetCaster()->ToPlayer())
                    if (caster->GetPet())
                        caster->CastSpell(caster, SPELL_HUNTER_ASPECT_OF_THE_BEAST_PET, true);
            }

            void Register() OVERRIDE
            {
                AfterEffectApply += AuraEffectApplyFn(spell_hun_aspect_of_the_beast_AuraScript::OnApply, EFFECT_0, SPELL_AURA_UNTRACKABLE, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_hun_aspect_of_the_beast_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_UNTRACKABLE, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_aspect_of_the_beast_AuraScript();
        }
};

// 34074 - Aspect of the Viper
class spell_hun_ascpect_of_the_viper : public SpellScriptLoader
{
    public:
        spell_hun_ascpect_of_the_viper() : SpellScriptLoader("spell_hun_ascpect_of_the_viper") { }

        class spell_hun_ascpect_of_the_viper_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_ascpect_of_the_viper_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_ASPECT_OF_THE_VIPER_ENERGIZE) ||
                    !sSpellMgr->GetSpellInfo(SPELL_HUNTER_GLYPH_OF_ASPECT_OF_THE_VIPER) ||
                    !sSpellMgr->GetSpellInfo(SPELL_HUNTER_VIPER_ATTACK_SPEED) ||
                    !sSpellMgr->GetSpellInfo(SPELL_HUNTER_VICIOUS_VIPER))
                    return false;
                return true;
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
            {
                PreventDefaultAction();

                uint32 maxMana = GetTarget()->GetMaxPower(POWER_MANA);
                int32 mana = CalculatePct(maxMana, GetTarget()->GetAttackTime(RANGED_ATTACK) / 1000.0f);

                if (AuraEffect const* glyph = GetTarget()->GetAuraEffect(SPELL_HUNTER_GLYPH_OF_ASPECT_OF_THE_VIPER, EFFECT_0))
                    AddPct(mana, glyph->GetAmount());

                GetTarget()->CastCustomSpell(SPELL_HUNTER_ASPECT_OF_THE_VIPER_ENERGIZE, SPELLVALUE_BASE_POINT0, mana, GetTarget(), true, NULL, aurEff);
            }

            void OnApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                // Hunter T7 4P Bonus
                if (GetTarget()->HasAura(SPELL_HUNTER_VIPER_ATTACK_SPEED))
                    GetTarget()->CastSpell(GetTarget(), SPELL_HUNTER_VICIOUS_VIPER, true, NULL, aurEff);
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                // Hunter T7 4P Bonus
                if (GetTarget()->HasAura(SPELL_HUNTER_VIPER_ATTACK_SPEED))
                    GetTarget()->RemoveAurasDueToSpell(SPELL_HUNTER_VICIOUS_VIPER);
            }

            void Register() OVERRIDE
            {
                OnEffectProc += AuraEffectProcFn(spell_hun_ascpect_of_the_viper_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_OBS_MOD_POWER);
                AfterEffectApply += AuraEffectApplyFn(spell_hun_ascpect_of_the_viper_AuraScript::OnApply, EFFECT_0, SPELL_AURA_OBS_MOD_POWER, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_hun_ascpect_of_the_viper_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_OBS_MOD_POWER, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_ascpect_of_the_viper_AuraScript();
        }
};

// 53209 - Chimera Shot
class spell_hun_chimera_shot : public SpellScriptLoader
{
    public:
        spell_hun_chimera_shot() : SpellScriptLoader("spell_hun_chimera_shot") { }

        class spell_hun_chimera_shot_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_chimera_shot_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_CHIMERA_SHOT_SERPENT) || !sSpellMgr->GetSpellInfo(SPELL_HUNTER_CHIMERA_SHOT_VIPER) || !sSpellMgr->GetSpellInfo(SPELL_HUNTER_CHIMERA_SHOT_SCORPID))
                    return false;
                return true;
            }

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (Unit* unitTarget = GetHitUnit())
                {
                    uint32 spellId = 0;
                    int32 basePoint = 0;
                    Unit::AuraApplicationMap& Auras = unitTarget->GetAppliedAuras();
                    for (Unit::AuraApplicationMap::iterator i = Auras.begin(); i != Auras.end(); ++i)
                    {
                        Aura* aura = i->second->GetBase();
                        if (aura->GetCasterGUID() != caster->GetGUID())
                            continue;

                        // Search only Serpent Sting, Viper Sting, Scorpid Sting auras
                        flag96 familyFlag = aura->GetSpellInfo()->SpellFamilyFlags;
                        if (!(familyFlag[1] & 0x00000080 || familyFlag[0] & 0x0000C000))
                            continue;
                        if (AuraEffect* aurEff = aura->GetEffect(0))
                        {
                            // Serpent Sting - Instantly deals 40% of the damage done by your Serpent Sting.
                            if (familyFlag[0] & 0x4000)
                            {
                                int32 TickCount = aurEff->GetTotalTicks();
                                spellId = SPELL_HUNTER_CHIMERA_SHOT_SERPENT;
                                basePoint = aurEff->GetAmount() + aurEff->GetBonusAmount() * aurEff->GetDonePct();
                                ApplyPct(basePoint, TickCount * 40);
                                basePoint = unitTarget->SpellDamageBonusTaken(caster, aura->GetSpellInfo(), basePoint, DOT, aura->GetStackAmount());
                                if (Player* modOwner = caster->GetSpellModOwner())
                                    modOwner->ApplySpellMod(aura->GetSpellInfo()->Id, SPELLMOD_DOT, basePoint);

                                aurEff->SetBonusAmount(caster->SpellDamageBonusDone(unitTarget, aurEff->GetSpellInfo(), 0, DOT));
                            }
                            // Viper Sting - Instantly restores mana to you equal to 60% of the total amount drained by your Viper Sting.
                            else if (familyFlag[1] & 0x00000080)
                            {
                                int32 TickCount = aura->GetEffect(0)->GetTotalTicks();
                                spellId = SPELL_HUNTER_CHIMERA_SHOT_VIPER;

                                // Amount of one aura tick
                                basePoint = int32(CalculatePct(unitTarget->GetMaxPower(POWER_MANA), aurEff->GetAmount()));
                                int32 casterBasePoint = aurEff->GetAmount() * unitTarget->GetMaxPower(POWER_MANA) / 50; /// @todo WTF? caster uses unitTarget?
                                if (basePoint > casterBasePoint)
                                    basePoint = casterBasePoint;
                                ApplyPct(basePoint, TickCount * 60);
                            }
                            // Scorpid Sting - Attempts to Disarm the target for 10 sec. This effect cannot occur more than once per 1 minute.
                            else if (familyFlag[0] & 0x00008000)
                                spellId = SPELL_HUNTER_CHIMERA_SHOT_SCORPID;
                            // ?? nothing say in spell desc (possibly need addition check)
                            //if (familyFlag & 0x0000010000000000LL || // dot
                            //    familyFlag & 0x0000100000000000LL)   // stun
                            //{
                            //    spellId = 53366; // 53366 Chimera Shot - Wyvern
                            //}

                            // Refresh aura duration
                            aura->RefreshDuration();
                        }
                        break;
                    }
                    if (spellId)
                        caster->CastCustomSpell(unitTarget, spellId, &basePoint, 0, 0, true);
                    if (spellId == SPELL_HUNTER_CHIMERA_SHOT_SCORPID && caster->ToPlayer()) // Scorpid Sting - Add 1 minute cooldown
                        caster->ToPlayer()->AddSpellCooldown(spellId, 0, uint32(time(NULL) + 60));
                }
            }

            void Register() OVERRIDE
            {
                OnEffectHitTarget += SpellEffectFn(spell_hun_chimera_shot_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_chimera_shot_SpellScript();
        }
};

// 781 - Disengage
class spell_hun_disengage : public SpellScriptLoader
{
    public:
        spell_hun_disengage() : SpellScriptLoader("spell_hun_disengage") { }

        class spell_hun_disengage_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_disengage_SpellScript);

            SpellCastResult CheckCast()
            {
                Unit* caster = GetCaster();
                if (caster->GetTypeId() == TYPEID_PLAYER && !caster->IsInCombat())
                    return SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;

                return SPELL_CAST_OK;
            }

            void Register() OVERRIDE
            {
                OnCheckCast += SpellCheckCastFn(spell_hun_disengage_SpellScript::CheckCast);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_disengage_SpellScript();
        }
};

// -19572 - Improved Mend Pet
class spell_hun_improved_mend_pet : public SpellScriptLoader
{
    public:
        spell_hun_improved_mend_pet() : SpellScriptLoader("spell_hun_improved_mend_pet") { }

        class spell_hun_improved_mend_pet_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_improved_mend_pet_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_IMPROVED_MEND_PET))
                    return false;
                return true;
            }

            bool CheckProc(ProcEventInfo& /*eventInfo*/)
            {
                return roll_chance_i(GetEffect(EFFECT_0)->GetAmount());
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
            {
                PreventDefaultAction();
                GetTarget()->CastSpell(GetTarget(), SPELL_HUNTER_IMPROVED_MEND_PET, true, NULL, aurEff);
            }

            void Register() OVERRIDE
            {
                DoCheckProc += AuraCheckProcFn(spell_hun_improved_mend_pet_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_hun_improved_mend_pet_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const OVERRIDE
        {
            return new spell_hun_improved_mend_pet_AuraScript();
        }
};
// 53412 - Invigoration
class spell_hun_invigoration : public SpellScriptLoader
{
    public:
        spell_hun_invigoration() : SpellScriptLoader("spell_hun_invigoration") { }

        class spell_hun_invigoration_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_invigoration_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_INVIGORATION_TRIGGERED))
                    return false;
                return true;
            }

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Unit* unitTarget = GetHitUnit())
                    if (AuraEffect* aurEff = unitTarget->GetDummyAuraEffect(SPELLFAMILY_HUNTER, 3487, 0))
                        if (roll_chance_i(aurEff->GetAmount()))
                            unitTarget->CastSpell(unitTarget, SPELL_HUNTER_INVIGORATION_TRIGGERED, true);
            }

            void Register() OVERRIDE
            {
                OnEffectHitTarget += SpellEffectFn(spell_hun_invigoration_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_invigoration_SpellScript();
        }
};

// 53478 - Last Stand Pet
class spell_hun_last_stand_pet : public SpellScriptLoader
{
    public:
        spell_hun_last_stand_pet() : SpellScriptLoader("spell_hun_last_stand_pet") { }

        class spell_hun_last_stand_pet_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_last_stand_pet_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_PET_LAST_STAND_TRIGGERED))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                int32 healthModSpellBasePoints0 = int32(caster->CountPctFromMaxHealth(30));
                caster->CastCustomSpell(caster, SPELL_HUNTER_PET_LAST_STAND_TRIGGERED, &healthModSpellBasePoints0, NULL, NULL, true, NULL);
            }

            void Register() OVERRIDE
            {
                OnEffectHitTarget += SpellEffectFn(spell_hun_last_stand_pet_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_last_stand_pet_SpellScript();
        }
};

// 53271 - Masters Call
class spell_hun_masters_call : public SpellScriptLoader
{
    public:
        spell_hun_masters_call() : SpellScriptLoader("spell_hun_masters_call") { }

        class spell_hun_masters_call_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_masters_call_SpellScript);

            bool Validate(SpellInfo const* spellInfo) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_MASTERS_CALL_TRIGGERED) || !sSpellMgr->GetSpellInfo(spellInfo->Effects[EFFECT_0].CalcValue()) || !sSpellMgr->GetSpellInfo(spellInfo->Effects[EFFECT_1].CalcValue()))
                    return false;
                return true;
            }

            SpellCastResult CheckCast()
            {
                if (Player* caster = GetCaster()->ToPlayer())
                {
                    if (Pet* pet = caster->GetPet())
                    {
                        if (!pet->IsAlive() || pet->GetUInt32Value(UNIT_FIELD_FLAGS) & (UNIT_FLAG_STUNNED))
                            return SPELL_FAILED_BAD_TARGETS;

                        Unit* target = caster->GetSelectedUnit();
                        if (target && target->IsFriendlyTo(caster))
                        {
                            if (!target->IsAlive())
                                return SPELL_FAILED_TARGETS_DEAD;

                            if (target->GetUInt32Value(UNIT_FIELD_FLAGS) & (UNIT_FLAG_STUNNED))
                                return SPELL_FAILED_BAD_TARGETS; // Or SPELL_FAILED_NO_VALID_TARGETS

                            // Target should always be a player. Blizz tested
                            if (Player* player = target->ToPlayer())
                                return pet->IsWithinLOSInMap(player) ? SPELL_CAST_OK : SPELL_FAILED_LINE_OF_SIGHT;
                            else
                                return SPELL_FAILED_NO_VALID_TARGETS;
                        }
                    } else {
                        return SPELL_FAILED_NO_PET;
                    }
                }
                return SPELL_CAST_OK;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                    if (Player* caster = GetCaster()->ToPlayer())
                        if (Pet* pet = caster->GetPet())
                        {
                            TriggerCastFlags castMask = TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_IGNORE_CASTER_AURASTATE);
                            pet->RemoveMovementImpairingAuras(); // Hacky but 100% effective
                            target->RemoveMovementImpairingAuras();
                            pet->CastSpell(target, GetEffectValue(), castMask);
                            pet->CastSpell(target, GetSpellInfo()->Effects[EFFECT_0].CalcValue(), castMask);
                        }
            }

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                {
                    // Cannot be processed while pet is dead
                    TriggerCastFlags castMask = TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_IGNORE_CASTER_AURASTATE);
                    target->CastSpell(target, SPELL_HUNTER_MASTERS_CALL_TRIGGERED, castMask);
                }
            }

            void Register() OVERRIDE
            {
                OnCheckCast += SpellCheckCastFn(spell_hun_masters_call_SpellScript::CheckCast);
                OnEffectHitTarget += SpellEffectFn(spell_hun_masters_call_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
                OnEffectHitTarget += SpellEffectFn(spell_hun_masters_call_SpellScript::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const OVERRIDE
        {
            return new spell_hun_masters_call_SpellScript();
        }
};

// 34477 - Misdirection
class spell_hun_misdirection : public SpellScriptLoader
{
    public:
        spell_hun_misdirection() : SpellScriptLoader("spell_hun_misdirection") { }

        class spell_hun_misdirection_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_misdirection_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_MISDIRECTION_PROC))
                    return false;
                return true;
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_DEFAULT || !GetTarget()->HasAura(SPELL_HUNTER_MISDIRECTION_PROC))
                    GetTarget()->ResetRedirectThreat();
            }

            bool CheckProc(ProcEventInfo& /*eventInfo*/)
            {
                return GetTarget()->GetRedirectThreatTarget();
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
            {
                PreventDefaultAction();
                GetTarget()->CastSpell(GetTarget(), SPELL_HUNTER_MISDIRECTION_PROC, true, NULL, aurEff);
            }

            void Register() OVERRIDE
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_hun_misdirection_AuraScript::OnRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                DoCheckProc += AuraCheckProcFn(spell_hun_misdirection_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_hun_misdirection_AuraScript::HandleProc, EFFECT_1, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_misdirection_AuraScript();
        }
};

// 35079 - Misdirection (Proc)
class spell_hun_misdirection_proc : public SpellScriptLoader
{
    public:
        spell_hun_misdirection_proc() : SpellScriptLoader("spell_hun_misdirection_proc") { }

        class spell_hun_misdirection_proc_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_misdirection_proc_AuraScript);

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetTarget()->ResetRedirectThreat();
            }

            void Register() OVERRIDE
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_hun_misdirection_proc_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_misdirection_proc_AuraScript();
        }
};

// 54044 - Pet Carrion Feeder
class spell_hun_pet_carrion_feeder : public SpellScriptLoader
{
    public:
        spell_hun_pet_carrion_feeder() : SpellScriptLoader("spell_hun_pet_carrion_feeder") { }

        class spell_hun_pet_carrion_feeder_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_pet_carrion_feeder_SpellScript);

            bool Load()
            {
                if (!GetCaster()->IsPet())
                    return false;
                return true;
            }

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_PET_CARRION_FEEDER_TRIGGERED))
                    return false;
                return true;
            }

            SpellCastResult CheckIfCorpseNear()
            {
                Unit* caster = GetCaster();
                float max_range = GetSpellInfo()->GetMaxRange(false);
                WorldObject* result = NULL;
                // search for nearby enemy corpse in range
                Trinity::AnyDeadUnitSpellTargetInRangeCheck check(caster, max_range, GetSpellInfo(), TARGET_CHECK_ENEMY);
                Trinity::WorldObjectSearcher<Trinity::AnyDeadUnitSpellTargetInRangeCheck> searcher(caster, result, check);
                caster->GetMap()->VisitFirstFound(caster->m_positionX, caster->m_positionY, max_range, searcher);
                if (!result)
                    return SPELL_FAILED_NO_EDIBLE_CORPSES;
                return SPELL_CAST_OK;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                caster->CastSpell(caster, SPELL_HUNTER_PET_CARRION_FEEDER_TRIGGERED, false);
            }

            void Register() OVERRIDE
            {
                OnEffectHit += SpellEffectFn(spell_hun_pet_carrion_feeder_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
                OnCheckCast += SpellCheckCastFn(spell_hun_pet_carrion_feeder_SpellScript::CheckIfCorpseNear);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_pet_carrion_feeder_SpellScript();
        }
};

// 55709 - Pet Heart of the Phoenix
class spell_hun_pet_heart_of_the_phoenix : public SpellScriptLoader
{
    public:
        spell_hun_pet_heart_of_the_phoenix() : SpellScriptLoader("spell_hun_pet_heart_of_the_phoenix") { }

        class spell_hun_pet_heart_of_the_phoenix_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_pet_heart_of_the_phoenix_SpellScript);

            bool Load()
            {
                if (!GetCaster()->IsPet())
                    return false;
                return true;
            }

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_PET_HEART_OF_THE_PHOENIX_TRIGGERED) || !sSpellMgr->GetSpellInfo(SPELL_HUNTER_PET_HEART_OF_THE_PHOENIX_DEBUFF))
                    return false;
                return true;
            }

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (Unit* owner = caster->GetOwner())
                    if (!caster->HasAura(SPELL_HUNTER_PET_HEART_OF_THE_PHOENIX_DEBUFF))
                    {
                        owner->CastCustomSpell(SPELL_HUNTER_PET_HEART_OF_THE_PHOENIX_TRIGGERED, SPELLVALUE_BASE_POINT0, 100, caster, true);
                        caster->CastSpell(caster, SPELL_HUNTER_PET_HEART_OF_THE_PHOENIX_DEBUFF, true);
                    }
            }

            void Register() OVERRIDE
            {
                OnEffectHitTarget += SpellEffectFn(spell_hun_pet_heart_of_the_phoenix_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_pet_heart_of_the_phoenix_SpellScript();
        }
};

// 23989 - Readiness
class spell_hun_readiness : public SpellScriptLoader
{
    public:
        spell_hun_readiness() : SpellScriptLoader("spell_hun_readiness") { }

        class spell_hun_readiness_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_readiness_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Player* caster = GetCaster()->ToPlayer();
                // immediately finishes the cooldown on your other Hunter abilities except Bestial Wrath
                const SpellCooldowns& cm = caster->ToPlayer()->GetSpellCooldownMap();
                for (SpellCooldowns::const_iterator itr = cm.begin(); itr != cm.end();)
                {
                    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itr->first);

                    ///! If spellId in cooldown map isn't valid, the above will return a null pointer.
                    if (spellInfo &&
                        spellInfo->SpellFamilyName == SPELLFAMILY_HUNTER &&
                        spellInfo->Id != SPELL_HUNTER_READINESS &&
                        spellInfo->Id != SPELL_HUNTER_BESTIAL_WRATH &&
                        spellInfo->Id != SPELL_DRAENEI_GIFT_OF_THE_NAARU &&
                        spellInfo->GetRecoveryTime() > 0)
                        caster->RemoveSpellCooldown((itr++)->first, true);
                    else
                        ++itr;
                }
            }

            void Register() OVERRIDE
            {
                OnEffectHitTarget += SpellEffectFn(spell_hun_readiness_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_readiness_SpellScript();
        }
};

// 37506 - Scatter Shot
class spell_hun_scatter_shot : public SpellScriptLoader
{
    public:
        spell_hun_scatter_shot() : SpellScriptLoader("spell_hun_scatter_shot") { }

        class spell_hun_scatter_shot_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_scatter_shot_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Player* caster = GetCaster()->ToPlayer();
                // break Auto Shot and autohit
                caster->InterruptSpell(CURRENT_AUTOREPEAT_SPELL);
                caster->AttackStop();
                caster->SendAttackSwingCancelAttack();
            }

            void Register() OVERRIDE
            {
                OnEffectHitTarget += SpellEffectFn(spell_hun_scatter_shot_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_scatter_shot_SpellScript();
        }
};

// -53302 - Sniper Training
class spell_hun_sniper_training : public SpellScriptLoader
{
    public:
        spell_hun_sniper_training() : SpellScriptLoader("spell_hun_sniper_training") { }

        class spell_hun_sniper_training_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_sniper_training_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_SNIPER_TRAINING_R1) || !sSpellMgr->GetSpellInfo(SPELL_HUNTER_SNIPER_TRAINING_BUFF_R1))
                    return false;
                return true;
            }

            void HandlePeriodic(AuraEffect const* aurEff)
            {
                PreventDefaultAction();
                if (aurEff->GetAmount() <= 0)
                {
                    Unit* target = GetTarget();
                    uint32 spellId = SPELL_HUNTER_SNIPER_TRAINING_BUFF_R1 + GetId() - SPELL_HUNTER_SNIPER_TRAINING_R1;
                    if (!target->HasAura(spellId))
                        target->CastSpell(target, spellId, true, 0, aurEff);
                }
            }

            void HandleUpdatePeriodic(AuraEffect* aurEff)
            {
                if (Player* playerTarget = GetUnitOwner()->ToPlayer())
                {
                    int32 baseAmount = aurEff->GetBaseAmount();
                    int32 amount = playerTarget->isMoving() ?
                    playerTarget->CalculateSpellDamage(playerTarget, GetSpellInfo(), aurEff->GetEffIndex(), &baseAmount) :
                    aurEff->GetAmount() - 1;
                    aurEff->SetAmount(amount);
                }
            }

            void Register() OVERRIDE
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_hun_sniper_training_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
                OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_hun_sniper_training_AuraScript::HandleUpdatePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hun_sniper_training_AuraScript();
        }
};

// 1515 - Tame Beast
class spell_hun_tame_beast : public SpellScriptLoader
{
    public:
        spell_hun_tame_beast() : SpellScriptLoader("spell_hun_tame_beast") { }

        class spell_hun_tame_beast_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_tame_beast_SpellScript);

            SpellCastResult CheckCast()
            {
                Unit* caster = GetCaster();
                if (caster->GetTypeId() != TYPEID_PLAYER)
                    return SPELL_FAILED_DONT_REPORT;

                if (!GetExplTargetUnit())
                    return SPELL_FAILED_BAD_IMPLICIT_TARGETS;

                if (Creature* target = GetExplTargetUnit()->ToCreature())
                {
                    if (target->getLevel() > caster->getLevel())
                        return SPELL_FAILED_HIGHLEVEL;

                    // use SMSG_PET_TAME_FAILURE?
                    if (!target->GetCreatureTemplate()->IsTameable(caster->ToPlayer()->CanTameExoticPets()))
                        return SPELL_FAILED_BAD_TARGETS;

                    if (caster->GetPetGUID())
                        return SPELL_FAILED_ALREADY_HAVE_SUMMON;

                    if (caster->GetCharmGUID())
                        return SPELL_FAILED_ALREADY_HAVE_CHARM;
                }
                else
                    return SPELL_FAILED_BAD_IMPLICIT_TARGETS;

                return SPELL_CAST_OK;
            }

            void Register() OVERRIDE
            {
                OnCheckCast += SpellCheckCastFn(spell_hun_tame_beast_SpellScript::CheckCast);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_tame_beast_SpellScript();
        }
};

// -24604 - Furious Howl
//  53434 - Call of the Wild
class spell_hun_target_only_pet_and_owner : public SpellScriptLoader
{
    public:
        spell_hun_target_only_pet_and_owner() : SpellScriptLoader("spell_hun_target_only_pet_and_owner") { }

        class spell_hun_target_only_pet_and_owner_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_hun_target_only_pet_and_owner_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                targets.clear();
                targets.push_back(GetCaster());
                if (Unit* owner = GetCaster()->GetOwner())
                    targets.push_back(owner);
            }

            void Register() OVERRIDE
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_hun_target_only_pet_and_owner_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_CASTER_AREA_PARTY);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_hun_target_only_pet_and_owner_SpellScript::FilterTargets, EFFECT_1, TARGET_UNIT_CASTER_AREA_PARTY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_hun_target_only_pet_and_owner_SpellScript();
        }
};

// 60144 - Viper Attack Speed
class spell_hun_viper_attack_speed : public SpellScriptLoader
{
    public:
        spell_hun_viper_attack_speed() : SpellScriptLoader("spell_hun_viper_attack_speed") { }

        class spell_hun_viper_attack_speed_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hun_viper_attack_speed_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_HUNTER_ASPECT_OF_THE_VIPER) ||
                    !sSpellMgr->GetSpellInfo(SPELL_HUNTER_VICIOUS_VIPER))
                    return false;
                return true;
            }

            void OnApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                if (GetTarget()->HasAura(SPELL_HUNTER_ASPECT_OF_THE_VIPER))
                    GetTarget()->CastSpell(GetTarget(), SPELL_HUNTER_VICIOUS_VIPER, true, NULL, aurEff);
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                // possible exploit
                GetTarget()->RemoveAurasDueToSpell(SPELL_HUNTER_VICIOUS_VIPER);
            }

            void Register() OVERRIDE
            {
                AfterEffectApply += AuraEffectApplyFn(spell_hun_viper_attack_speed_AuraScript::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_hun_viper_attack_speed_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const OVERRIDE
        {
            return new spell_hun_viper_attack_speed_AuraScript();
        }
};

// Hackfix for Entrapment //
enum Entrapment
{
    TALENT_ENTRAPMENT_RANK_1    = 19184,
    TALENT_ENTRAPMENT_RANK_2    = 19387,
    TALENT_ENTRAPMENT_RANK_3    = 19388,

    SPELL_ENTRAPMENT_TRIGGER_1  = 19185,
    SPELL_ENTRAPMENT_TRIGGER_2  = 64803,
    SPELL_ENTRAPMENT_TRIGGER_3  = 64804,
};

class spell_hun_entrapment_frost : public SpellScriptLoader
{
public:
    spell_hun_entrapment_frost() : SpellScriptLoader("spell_hun_entrapment_frost") { }

    class spell_hun_entrapment_frost_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_hun_entrapment_frost_SpellScript);

        bool Validate(SpellInfo const* /*spellEntry*/) OVERRIDE
        {
            if (!sSpellMgr->GetSpellInfo(TALENT_ENTRAPMENT_RANK_1) || !sSpellMgr->GetSpellInfo(TALENT_ENTRAPMENT_RANK_2) ||
                !sSpellMgr->GetSpellInfo(TALENT_ENTRAPMENT_RANK_3) || !sSpellMgr->GetSpellInfo(SPELL_ENTRAPMENT_TRIGGER_1) ||
                !sSpellMgr->GetSpellInfo(SPELL_ENTRAPMENT_TRIGGER_2) || !sSpellMgr->GetSpellInfo(SPELL_ENTRAPMENT_TRIGGER_3))
                return false;
            return true;
        }

        void FrostTrap(SpellEffIndex /*effIndex*/)
        {
            Unit* caster = GetCaster();
            if (Unit* target = GetHitUnit())
            {
                if (Unit* owner = caster->GetOwner())
                {
                    if (owner->HasAura(TALENT_ENTRAPMENT_RANK_3))
                        caster->AddAura(SPELL_ENTRAPMENT_TRIGGER_3,target);
                    else if (owner->HasAura(TALENT_ENTRAPMENT_RANK_2))
                        caster->AddAura(SPELL_ENTRAPMENT_TRIGGER_2,target);
                    else if (owner->HasAura(TALENT_ENTRAPMENT_RANK_1))
                        caster->AddAura(SPELL_ENTRAPMENT_TRIGGER_1,target);
                }
            }
        }

        void SnakeTrap(SpellEffIndex /*effIndex*/)
        {
            Unit* caster = GetCaster();
            if (Unit* target = GetHitUnit())
            {
                if (Unit* owner = caster->GetOwner())
                {
                    if (owner->HasAura(TALENT_ENTRAPMENT_RANK_3))
                        caster->AddAura(SPELL_ENTRAPMENT_TRIGGER_3,target);
                    else if (owner->HasAura(TALENT_ENTRAPMENT_RANK_2))
                        caster->AddAura(SPELL_ENTRAPMENT_TRIGGER_2,target);
                    else if (owner->HasAura(TALENT_ENTRAPMENT_RANK_1))
                        caster->AddAura(SPELL_ENTRAPMENT_TRIGGER_1,target);
                }
            }
        }

        void Register() OVERRIDE
        {
            OnEffectHitTarget += SpellEffectFn(spell_hun_entrapment_frost_SpellScript::FrostTrap, EFFECT_0, SPELL_EFFECT_TRIGGER_SPELL);
        }
    };

    SpellScript* GetSpellScript() const OVERRIDE
    {
        return new spell_hun_entrapment_frost_SpellScript();
    }
};

class spell_hun_entrapment_snake : public SpellScriptLoader
{
public:
    spell_hun_entrapment_snake() : SpellScriptLoader("spell_hun_entrapment_snake") { }

    class spell_hun_entrapment_snake_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_hun_entrapment_snake_SpellScript);

        bool Validate(SpellInfo const* /*spellEntry*/) OVERRIDE
        {
            if (!sSpellMgr->GetSpellInfo(TALENT_ENTRAPMENT_RANK_1) || !sSpellMgr->GetSpellInfo(TALENT_ENTRAPMENT_RANK_2) ||
                !sSpellMgr->GetSpellInfo(TALENT_ENTRAPMENT_RANK_3) || !sSpellMgr->GetSpellInfo(SPELL_ENTRAPMENT_TRIGGER_1) ||
                !sSpellMgr->GetSpellInfo(SPELL_ENTRAPMENT_TRIGGER_2) || !sSpellMgr->GetSpellInfo(SPELL_ENTRAPMENT_TRIGGER_3))
                return false;
            return true;
        }

        void SnakeTrap(SpellEffIndex /*effIndex*/)
        {
            Unit* caster = GetCaster();
            if (Unit* target = GetHitUnit())
            {
                if (Unit* owner = caster->GetOwner())
                {
                    if (owner->HasAura(TALENT_ENTRAPMENT_RANK_3))
                        caster->AddAura(SPELL_ENTRAPMENT_TRIGGER_3,target);
                    else if (owner->HasAura(TALENT_ENTRAPMENT_RANK_2))
                        caster->AddAura(SPELL_ENTRAPMENT_TRIGGER_2,target);
                    else if (owner->HasAura(TALENT_ENTRAPMENT_RANK_1))
                        caster->AddAura(SPELL_ENTRAPMENT_TRIGGER_1,target);
                }
            }
        }

        void Register() OVERRIDE
        {
            OnEffectHitTarget += SpellEffectFn(spell_hun_entrapment_snake_SpellScript::SnakeTrap, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const OVERRIDE
    {
        return new spell_hun_entrapment_snake_SpellScript();
    }
};

class spell_hun_pet_scaling_01 : public SpellScriptLoader
{
public:
    spell_hun_pet_scaling_01() : SpellScriptLoader("spell_hun_pet_scaling_01") { }

    class spell_hun_pet_scaling_01_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hun_pet_scaling_01_AuraScript);

        void CalculateStaminaAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* pet = GetUnitOwner())
            {
                if (!pet->IsPet())
                    return;

                Unit* owner = pet->ToPet()->GetOwner();
                if (!owner)
                    return;

                float mod = 0.45f;
                float ownerBonus = 0.0f;

                PetSpellMap::const_iterator itr = (pet->ToPet()->m_spells.find(62758)); // Wild Hunt rank 1
                if (itr == pet->ToPet()->m_spells.end())
                    itr = pet->ToPet()->m_spells.find(62762); // Wild Hunt rank 2

                if (itr != pet->ToPet()->m_spells.end()) // If pet has Wild Hunt
                {
                    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itr->first); // Then get the SpellProto and add the dummy effect value
                    AddPct(mod, spellInfo->Effects[EFFECT_0].CalcValue());
                }

                ownerBonus = owner->GetStat(STAT_STAMINA)*mod;

                amount += ownerBonus;
            }
        }

        void ApplyEffect(AuraEffect const* /* aurEff */, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* pet = GetUnitOwner())
                if (_tempHealth)
                    pet->SetHealth(_tempHealth);
        }

        void RemoveEffect(AuraEffect const* /* aurEff */, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* pet = GetUnitOwner())
                _tempHealth = pet->GetHealth();
        }

        void CalculateAttackPowerAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* pet = GetUnitOwner())
            {
                if (!pet->IsPet())
                    return;

                Unit* owner = pet->ToPet()->GetOwner();
                if (!owner)
                    return;

                float mod = 1.0f; //Hunter contribution modifier
                float bonusAP = 0.0f;

                PetSpellMap::const_iterator itr = (pet->ToPet()->m_spells.find(62758)); // Wild Hunt rank 1
                if (itr == pet->ToPet()->m_spells.end())
                    itr = pet->ToPet()->m_spells.find(62762); // Wild Hunt rank 2

                if (itr != pet->ToPet()->m_spells.end()) // If pet has Wild Hunt
                {
                    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itr->first); // Then get the SpellProto and add the dummy effect value
                    mod += CalculatePct(1.0f, spellInfo->Effects[EFFECT_1].CalcValue());
                }

                bonusAP = owner->GetTotalAttackPowerValue(RANGED_ATTACK) * 0.22f * mod;
                amount += bonusAP;
            }
        }

        void CalculateDamageDoneAmount(AuraEffect const* /* aurEff */, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* pet = GetUnitOwner())
            {
                if (!pet->IsPet())
                    return;

                Unit* owner = pet->ToPet()->GetOwner();
                if (!owner)
                    return;

                float mod = 1.0f;
                float bonusDamage = 0.0f;

                /*PetSpellMap::const_iterator itr = (pet->ToPet()->m_spells.find(62758)); // Wild Hunt rank 1
                if (itr == pet->ToPet()->m_spells.end())
                itr = pet->ToPet()->m_spells.find(62762); // Wild Hunt rank 2

                if (itr != pet->ToPet()->m_spells.end()) // If pet has Wild Hunt
                {
                SpellInfo const* spellInfo = sSpellMgr->EnsureSpellInfo(itr->first); // Then get the SpellProto and add the dummy effect value
                mod += CalculatePct(1.0f, spellInfo->Effects[EFFECT_1].CalcValue());
                }*/
                ((Guardian*)pet)->SetBonusDamage(int32(owner->GetTotalAttackPowerValue(RANGED_ATTACK) * 0.1287f * mod));
            }
        }

        void Register() OVERRIDE
        {
            switch (m_scriptSpellId)
            {
            case SPELL_HUNTER_PET_SCALING_01:
                OnEffectRemove += AuraEffectRemoveFn(spell_hun_pet_scaling_01_AuraScript::RemoveEffect, EFFECT_0, SPELL_AURA_MOD_STAT, AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK);
                AfterEffectApply += AuraEffectApplyFn(spell_hun_pet_scaling_01_AuraScript::ApplyEffect, EFFECT_0, SPELL_AURA_MOD_STAT, AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_01_AuraScript::CalculateStaminaAmount, EFFECT_0, SPELL_AURA_MOD_STAT);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_01_AuraScript::CalculateAttackPowerAmount, EFFECT_1, SPELL_AURA_MOD_ATTACK_POWER);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_01_AuraScript::CalculateDamageDoneAmount, EFFECT_2, SPELL_AURA_MOD_DAMAGE_DONE);
                break;
            default:
                break;
            }
        }
    private:
        uint32 _tempHealth;
    };

    AuraScript* GetAuraScript() const OVERRIDE
    {
        return new spell_hun_pet_scaling_01_AuraScript();
    }

};

class spell_hun_pet_scaling_02 : public SpellScriptLoader
{
public:
    spell_hun_pet_scaling_02() : SpellScriptLoader("spell_hun_pet_scaling_02") { }

    class spell_hun_pet_scaling_02_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hun_pet_scaling_02_AuraScript);

        void CalculateFrostResistanceAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* pet = GetUnitOwner())
            {
                if (!pet->IsPet())
                    return;

                Unit* owner = pet->ToPet()->GetOwner();
                if (!owner)
                    return;

                float ownerBonus = 0.0f;

                ownerBonus = CalculatePct(owner->GetResistance(SPELL_SCHOOL_FROST), 40);

                amount += ownerBonus;
            }
        }

        void CalculateFireResistanceAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* pet = GetUnitOwner())
            {
                if (!pet->IsPet())
                    return;

                Unit* owner = pet->ToPet()->GetOwner();
                if (!owner)
                    return;

                float ownerBonus = 0.0f;

                ownerBonus = CalculatePct(owner->GetResistance(SPELL_SCHOOL_FIRE), 40);

                amount += ownerBonus;
            }
        }

        void CalculateNatureResistanceAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* pet = GetUnitOwner())
            {
                if (!pet->IsPet())
                    return;

                Unit* owner = pet->ToPet()->GetOwner();
                if (!owner)
                    return;

                float ownerBonus = 0.0f;

                ownerBonus = CalculatePct(owner->GetResistance(SPELL_SCHOOL_NATURE), 40);

                amount += ownerBonus;
            }
        }

        void Register() OVERRIDE
        {
            switch (m_scriptSpellId)
            {
            case SPELL_HUNTER_PET_SCALING_02:
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_02_AuraScript::CalculateFrostResistanceAmount, EFFECT_1, SPELL_AURA_MOD_RESISTANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_02_AuraScript::CalculateFireResistanceAmount, EFFECT_0, SPELL_AURA_MOD_RESISTANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_02_AuraScript::CalculateNatureResistanceAmount, EFFECT_2, SPELL_AURA_MOD_RESISTANCE);
                break;
            default:
                break;
            }
        }

    };

    AuraScript* GetAuraScript() const OVERRIDE
    {
        return new spell_hun_pet_scaling_02_AuraScript();
    }
};

class spell_hun_pet_scaling_03 : public SpellScriptLoader
{
public:
    spell_hun_pet_scaling_03() : SpellScriptLoader("spell_hun_pet_scaling_03") { }

    class spell_hun_pet_scaling_03_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hun_pet_scaling_03_AuraScript);

        void CalculateShadowResistanceAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* pet = GetUnitOwner())
            {
                if (!pet->IsPet())
                    return;

                Unit* owner = pet->ToPet()->GetOwner();
                if (!owner)
                    return;

                float ownerBonus = 0.0f;

                ownerBonus = CalculatePct(owner->GetResistance(SPELL_SCHOOL_SHADOW), 40);

                amount += ownerBonus;
            }
        }

        void CalculateArcaneResistanceAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* pet = GetUnitOwner())
            {
                if (!pet->IsPet())
                    return;

                Unit* owner = pet->ToPet()->GetOwner();
                if (!owner)
                    return;

                float ownerBonus = 0.0f;

                ownerBonus = CalculatePct(owner->GetResistance(SPELL_SCHOOL_ARCANE), 40);

                amount += ownerBonus;
            }
        }

        void CalculateArmorAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* pet = GetUnitOwner())
            {
                if (!pet->IsPet())
                    return;

                Unit* owner = pet->ToPet()->GetOwner();
                if (!owner)
                    return;

                float ownerBonus = 0.0f;

                ownerBonus = CalculatePct(owner->GetArmor(), 35);

                amount += ownerBonus;
            }
        }

        void Register() OVERRIDE
        {
            switch (m_scriptSpellId)
            {
            case SPELL_HUNTER_PET_SCALING_03:
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_03_AuraScript::CalculateShadowResistanceAmount, EFFECT_0, SPELL_AURA_MOD_RESISTANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_03_AuraScript::CalculateArcaneResistanceAmount, EFFECT_1, SPELL_AURA_MOD_RESISTANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_03_AuraScript::CalculateArmorAmount, EFFECT_2, SPELL_AURA_MOD_RESISTANCE);
                break;
            default:
                break;
            }
        }
    };

    AuraScript* GetAuraScript() const OVERRIDE
    {
        return new spell_hun_pet_scaling_03_AuraScript();
    }
};

class spell_hun_pet_scaling_04 : public SpellScriptLoader
{
public:
    spell_hun_pet_scaling_04() : SpellScriptLoader("spell_hun_pet_scaling_04") { }

    class spell_hun_pet_scaling_04_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hun_pet_scaling_04_AuraScript);

        bool Load() OVERRIDE
        {
            if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
            return false;
            return true;
        }

            void CalculateAmountMeleeHit(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (!GetCaster() || !GetCaster()->GetOwner())
                return;

            if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
            {
                // For others recalculate it from:
                float HitMelee = 0.0f;
                // Increase hit from SPELL_AURA_MOD_HIT_CHANCE
                HitMelee += owner->GetTotalAuraModifier(SPELL_AURA_MOD_HIT_CHANCE);
                // Increase hit melee from meele hit ratings
                HitMelee += owner->GetRatingBonusValue(CR_HIT_MELEE);

                amount += int32(HitMelee);
            }
        }

        void CalculateAmountSpellHit(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (!GetCaster() || !GetCaster()->GetOwner())
                return;

            if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
            {
                // For others recalculate it from:
                float HitSpell = 0.0f;
                // Increase hit from SPELL_AURA_MOD_SPELL_HIT_CHANCE
                HitSpell += owner->GetTotalAuraModifier(SPELL_AURA_MOD_SPELL_HIT_CHANCE);
                // Increase hit spell from spell hit ratings
                HitSpell += owner->GetRatingBonusValue(CR_HIT_SPELL);

                amount += int32(HitSpell);
            }
        }

        void CalculateAmountExpertise(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (!GetCaster() || !GetCaster()->GetOwner())
                return;

            if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
            {
                // For others recalculate it from:
                float Expertise = 0.0f;
                // Increase hit from SPELL_AURA_MOD_EXPERTISE
                Expertise += owner->GetTotalAuraModifier(SPELL_AURA_MOD_EXPERTISE);
                // Increase Expertise from Expertise ratings
                Expertise += owner->GetRatingBonusValue(CR_EXPERTISE);

                amount += int32(Expertise);
            }
        }

        void Register() OVERRIDE
        {
            switch (m_scriptSpellId)
            {
            case SPELL_HUNTER_PET_SCALING_04:
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_04_AuraScript::CalculateAmountMeleeHit, EFFECT_0, SPELL_AURA_MOD_HIT_CHANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_04_AuraScript::CalculateAmountSpellHit, EFFECT_1, SPELL_AURA_MOD_SPELL_HIT_CHANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_scaling_04_AuraScript::CalculateAmountExpertise, EFFECT_2, SPELL_AURA_MOD_EXPERTISE);
                break;
            default:
                break;
            }
        }
    };

    AuraScript* GetAuraScript() const OVERRIDE
    {
        return new spell_hun_pet_scaling_04_AuraScript();
    }
};

class spell_hun_pet_passive_crit : public SpellScriptLoader
{
public:
    spell_hun_pet_passive_crit() : SpellScriptLoader("spell_hun_pet_passive_crit") { }

    class spell_hun_pet_passive_crit_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hun_pet_passive_crit_AuraScript);

        bool Load() OVERRIDE
        {
            if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
            return false;
            return true;
        }

            void CalculateAmountCritSpell(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (!GetCaster() || !GetCaster()->GetOwner())
                return;

            if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
            {
                // For others recalculate it from:
                float CritSpell = 0.0f;
                // Crit from Intellect
                CritSpell += owner->GetSpellCritFromIntellect();
                // Increase crit from SPELL_AURA_MOD_SPELL_CRIT_CHANCE
                CritSpell += owner->GetTotalAuraModifier(SPELL_AURA_MOD_SPELL_CRIT_CHANCE);
                // Increase crit from SPELL_AURA_MOD_CRIT_PCT
                CritSpell += owner->GetTotalAuraModifier(SPELL_AURA_MOD_CRIT_PCT);
                // Increase crit spell from spell crit ratings
                CritSpell += owner->GetRatingBonusValue(CR_CRIT_SPELL);

                amount += (CritSpell*0.8f);
            }
        }

        void CalculateAmountCritMelee(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (!GetCaster() || !GetCaster()->GetOwner())
                return;

            if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
            {
                // For others recalculate it from:
                float CritMelee = 0.0f;
                // Crit from Agility
                CritMelee += owner->GetMeleeCritFromAgility();
                // Increase crit from SPELL_AURA_MOD_WEAPON_CRIT_PERCENT
                CritMelee += owner->GetTotalAuraModifier(SPELL_AURA_MOD_WEAPON_CRIT_PERCENT);
                // Increase crit from SPELL_AURA_MOD_CRIT_PCT
                CritMelee += owner->GetTotalAuraModifier(SPELL_AURA_MOD_CRIT_PCT);
                //Increase crit melee from melee crit ratings
                CritMelee += owner->GetRatingBonusValue(CR_CRIT_MELEE);

                amount += (CritMelee*0.8f);
            }
        }

        void Register() OVERRIDE
        {
            switch (m_scriptSpellId)
            {
            case SPELL_TAMED_PET_PASSIVE_06:
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_passive_crit_AuraScript::CalculateAmountCritSpell, EFFECT_1, SPELL_AURA_MOD_SPELL_CRIT_CHANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_passive_crit_AuraScript::CalculateAmountCritMelee, EFFECT_0, SPELL_AURA_MOD_WEAPON_CRIT_PERCENT);
                break;
            default:
                break;
            }
        }
    };

    AuraScript* GetAuraScript() const OVERRIDE
    {
        return new spell_hun_pet_passive_crit_AuraScript();
    }
};

class spell_hun_pet_passive_damage_done : public SpellScriptLoader
{
public:
    spell_hun_pet_passive_damage_done() : SpellScriptLoader("spell_hun_pet_passive_damage_done") { }

    class spell_hun_pet_passive_damage_done_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hun_pet_passive_damage_done_AuraScript);

        bool Load() OVERRIDE
        {
            if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
            return false;
            return true;
        }

            void CalculateAmountDamageDone(AuraEffect const* /* aurEff */, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (!GetCaster() || !GetCaster()->GetOwner())
                return;

            if (GetCaster()->GetOwner()->ToPlayer())
            {
                //  Pet's base damage changes depending on happiness
                if (GetCaster()->IsPet() && GetCaster()->ToPet()->IsHunterPet())
                {
                    switch (GetCaster()->ToPet()->GetHappinessState())
                    {
                    case HAPPY:
                        // 125% of normal damage
                        amount += 25.0f;
                        break;
                    case CONTENT:
                        // 100% of normal damage, nothing to modify
                        break;
                    case UNHAPPY:
                        // 75% of normal damage
                        amount += -25.0f;
                        break;
                    }
                }
                // Cobra Reflexes
                if (AuraEffect* cobraReflexes = GetCaster()->GetAuraEffectOfRankedSpell(61682, EFFECT_0))
                    amount -= cobraReflexes->GetAmount();
            }
        }

        void Register() OVERRIDE
        {
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_pet_passive_damage_done_AuraScript::CalculateAmountDamageDone, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
        }
    };

    AuraScript* GetAuraScript() const OVERRIDE
    {
        return new spell_hun_pet_passive_damage_done_AuraScript();
    }
};

class spell_hun_animal_handler : public SpellScriptLoader
{
public:
    spell_hun_animal_handler() : SpellScriptLoader("spell_hun_animal_handler") { }

    class spell_hun_animal_handler_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hun_animal_handler_AuraScript);

        bool Load() OVERRIDE
        {
            if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
            return false;
            return true;
        }

            void CalculateAmountDamageDone(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (!GetCaster() || !GetCaster()->GetOwner())
                return;

            if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
            {
                if (AuraEffect* aurEffect = owner->GetAuraEffectOfRankedSpell(SPELL_HUNTER_ANIMAL_HANDLER, EFFECT_1))
                    amount = aurEffect->GetAmount();
                else
                    amount = 0;
            }
        }

        void Register() OVERRIDE
        {
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_hun_animal_handler_AuraScript::CalculateAmountDamageDone, EFFECT_0, SPELL_AURA_MOD_ATTACK_POWER_PCT);
        }
    };

    AuraScript* GetAuraScript() const OVERRIDE
    {
        return new spell_hun_animal_handler_AuraScript();
    }
};

enum RoarOfSacrifice
{
    SPELL_ROAR_OF_SACRIFICE_DMG = 67481
};

// 53480 - Roar of Sacrifice
class spell_hun_roar_of_sacrifice : public SpellScriptLoader
{
public:
    spell_hun_roar_of_sacrifice() : SpellScriptLoader("spell_hun_roar_of_sacrifice") { }

    class spell_hun_roar_of_sacrifice_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hun_roar_of_sacrifice_AuraScript);

        bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
        {
            if (!sSpellMgr->GetSpellInfo(SPELL_ROAR_OF_SACRIFICE_DMG))
            return false;
            return true;
        }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
        {
            PreventDefaultAction();
            if (eventInfo.GetDamageInfo())
            {
                int32 damage = CalculatePct(eventInfo.GetDamageInfo()->GetDamage(), 20);
                GetTarget()->CastCustomSpell(SPELL_ROAR_OF_SACRIFICE_DMG, SPELLVALUE_BASE_POINT0, damage, GetCaster(), true, NULL, aurEff);
            }
        }

        void Register() OVERRIDE
        {
            OnEffectProc += AuraEffectProcFn(spell_hun_roar_of_sacrifice_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_MOD_ATTACKER_SPELL_AND_WEAPON_CRIT_CHANCE);
        }
    };

    AuraScript* GetAuraScript() const OVERRIDE
    {
        return new spell_hun_roar_of_sacrifice_AuraScript();
    }
};

void AddSC_hunter_spell_scripts()
{
    new spell_hun_aspect_of_the_beast();
    new spell_hun_ascpect_of_the_viper();
    new spell_hun_chimera_shot();
    new spell_hun_disengage();
    new spell_hun_improved_mend_pet();
    new spell_hun_invigoration();
    new spell_hun_last_stand_pet();
    new spell_hun_masters_call();
    new spell_hun_misdirection();
    new spell_hun_misdirection_proc();
    new spell_hun_pet_carrion_feeder();
    new spell_hun_pet_heart_of_the_phoenix();
    new spell_hun_readiness();
    new spell_hun_scatter_shot();
    new spell_hun_sniper_training();
    new spell_hun_tame_beast();
    new spell_hun_target_only_pet_and_owner();
    new spell_hun_viper_attack_speed();
    new spell_hun_entrapment_frost();
    new spell_hun_entrapment_snake();
    new spell_hun_pet_scaling_01();
    new spell_hun_pet_scaling_02();
    new spell_hun_pet_scaling_03();
    new spell_hun_pet_scaling_04();
    new spell_hun_pet_passive_crit();
    new spell_hun_pet_passive_damage_done();
    new spell_hun_animal_handler();
    new spell_hun_roar_of_sacrifice();
}
