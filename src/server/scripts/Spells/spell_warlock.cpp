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
 * Scripts for spells with SPELLFAMILY_WARLOCK and SPELLFAMILY_GENERIC spells used by warlock players.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_warl_".
 */

#include "Player.h"
#include "ScriptMgr.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "Pet.h"

enum WarlockSpells
{
    SPELL_WARLOCK_CURSE_OF_DOOM_EFFECT              = 18662,
    SPELL_WARLOCK_DEMONIC_CIRCLE_SUMMON             = 48018,
    SPELL_WARLOCK_DEMONIC_CIRCLE_TELEPORT           = 48020,
    SPELL_WARLOCK_DEMONIC_CIRCLE_ALLOW_CAST         = 62388,
    SPELL_WARLOCK_DEMONIC_EMPOWERMENT_SUCCUBUS      = 54435,
    SPELL_WARLOCK_DEMONIC_EMPOWERMENT_VOIDWALKER    = 54443,
    SPELL_WARLOCK_DEMONIC_EMPOWERMENT_FELGUARD      = 54508,
    SPELL_WARLOCK_DEMONIC_EMPOWERMENT_FELHUNTER     = 54509,
    SPELL_WARLOCK_DEMONIC_EMPOWERMENT_IMP           = 54444,
    SPELL_WARLOCK_FEL_SYNERGY_HEAL                  = 54181,
    SPELL_WARLOCK_GLYPH_OF_SHADOWFLAME              = 63311,
    SPELL_WARLOCK_GLYPH_OF_SIPHON_LIFE              = 63106,
    SPELL_WARLOCK_HAUNT                             = 48181,
    SPELL_WARLOCK_HAUNT_HEAL                        = 48210,
    SPELL_WARLOCK_IMPROVED_HEALTHSTONE_R1           = 18692,
    SPELL_WARLOCK_IMPROVED_HEALTHSTONE_R2           = 18693,
    SPELL_WARLOCK_IMPROVED_HEALTH_FUNNEL_R1         = 18703,
    SPELL_WARLOCK_IMPROVED_HEALTH_FUNNEL_R2         = 18704,
    SPELL_WARLOCK_IMPROVED_HEALTH_FUNNEL_BUFF_R1    = 60955,
    SPELL_WARLOCK_IMPROVED_HEALTH_FUNNEL_BUFF_R2    = 60956,
    SPELL_WARLOCK_LIFE_TAP_ENERGIZE                 = 31818,
    SPELL_WARLOCK_LIFE_TAP_ENERGIZE_2               = 32553,
    SPELL_WARLOCK_SOULSHATTER                       = 32835,
    SPELL_WARLOCK_SIPHON_LIFE_HEAL                  = 63106,
    SPELL_WARLOCK_UNSTABLE_AFFLICTION_DISPEL        = 31117,
    SPELL_WARLOCK_GLYPH_OF_SUCCUBUS                 = 56250,
    PRIEST_SHADOW_WORD_DEATH                        = 32409,
};

enum WarlockSpellIcons
{
    WARLOCK_ICON_ID_IMPROVED_LIFE_TAP               = 208,
    WARLOCK_ICON_ID_MANA_FEED                       = 1982
};

enum WarlockPetCalculate
{
	SPELL_PET_PASSIVE_CRIT				= 35695,
	SPELL_PET_PASSIVE_DAMAGE_TAKEN		= 35697,
	SPELL_WARLOCK_PET_SCALING_01		= 34947,
	SPELL_WARLOCK_PET_SCALING_02		= 34956,
	SPELL_WARLOCK_PET_SCALING_03		= 34957,
	SPELL_WARLOCK_PET_SCALING_04		= 34958,
	SPELL_WARLOCK_PET_SCALING_05		= 61013,
	ENTRY_FELGUARD						= 17252,
	ENTRY_VOIDWALKER					= 1860,
	ENTRY_FELHUNTER						= 417,
	ENTRY_SUCCUBUS						= 1863,
	ENTRY_IMP							= 416,
	SPELL_WARLOCK_GLYPH_OF_VOIDWALKER	= 56247
};

// -710 - Banish
class spell_warl_banish : public SpellScriptLoader
{
    public:
        spell_warl_banish() : SpellScriptLoader("spell_warl_banish") { }

        class spell_warl_banish_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_banish_SpellScript);

            bool Load() OVERRIDE
            {
                _removed = false;
                return true;
            }

            void HandleBanish()
            {
                if (Unit* target = GetHitUnit())
                {
                    if (target->GetAuraEffect(SPELL_AURA_SCHOOL_IMMUNITY, SPELLFAMILY_WARLOCK, 0, 0x08000000, 0))
                    {
                        // No need to remove old aura since its removed due to not stack by current Banish aura
                        PreventHitDefaultEffect(EFFECT_0);
                        PreventHitDefaultEffect(EFFECT_1);
                        PreventHitDefaultEffect(EFFECT_2);
                        _removed = true;
                    }
                }
            }

            void RemoveAura()
            {
                if (_removed)
                    PreventHitAura();
            }

            void Register() OVERRIDE
            {
                BeforeHit += SpellHitFn(spell_warl_banish_SpellScript::HandleBanish);
                AfterHit += SpellHitFn(spell_warl_banish_SpellScript::RemoveAura);
            }

            bool _removed;
        };

        SpellScript* GetSpellScript() const OVERRIDE
        {
            return new spell_warl_banish_SpellScript();
        }
};

// 6201 - Create Healthstone (and ranks)
class spell_warl_create_healthstone : public SpellScriptLoader
{
    public:
        spell_warl_create_healthstone() : SpellScriptLoader("spell_warl_create_healthstone") { }

        class spell_warl_create_healthstone_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_create_healthstone_SpellScript);

            static uint32 const iTypes[8][3];

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_IMPROVED_HEALTHSTONE_R1) || !sSpellMgr->GetSpellInfo(SPELL_WARLOCK_IMPROVED_HEALTHSTONE_R2))
                    return false;
                return true;
            }

            SpellCastResult CheckCast()
            {
                if (Player* caster = GetCaster()->ToPlayer())
                {
                    uint8 spellRank = GetSpellInfo()->GetRank();
                    ItemPosCountVec dest;
                    InventoryResult msg = caster->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, iTypes[spellRank - 1][0], 1, NULL);
                    if (msg != EQUIP_ERR_OK)
                        return SPELL_FAILED_TOO_MANY_OF_ITEM;
                }
                return SPELL_CAST_OK;
            }

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                if (Unit* unitTarget = GetHitUnit())
                {
                    uint32 rank = 0;
                    // Improved Healthstone
                    if (AuraEffect const* aurEff = unitTarget->GetDummyAuraEffect(SPELLFAMILY_WARLOCK, 284, 0))
                    {
                        switch (aurEff->GetId())
                        {
                            case SPELL_WARLOCK_IMPROVED_HEALTHSTONE_R1:
                                rank = 1;
                                break;
                            case SPELL_WARLOCK_IMPROVED_HEALTHSTONE_R2:
                                rank = 2;
                                break;
                            default:
                                TC_LOG_ERROR(LOG_FILTER_SPELLS_AURAS, "Unknown rank of Improved Healthstone id: %d", aurEff->GetId());
                                break;
                        }
                    }
                    uint8 spellRank = GetSpellInfo()->GetRank();
                    if (spellRank > 0 && spellRank <= 8)
                        CreateItem(effIndex, iTypes[spellRank - 1][rank]);
                }
            }

            void Register() OVERRIDE
            {
                OnEffectHitTarget += SpellEffectFn(spell_warl_create_healthstone_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
                OnCheckCast += SpellCheckCastFn(spell_warl_create_healthstone_SpellScript::CheckCast);
            }
        };

        SpellScript* GetSpellScript() const OVERRIDE
        {
            return new spell_warl_create_healthstone_SpellScript();
        }
};

uint32 const spell_warl_create_healthstone::spell_warl_create_healthstone_SpellScript::iTypes[8][3] = {
    { 5512, 19004, 19005},              // Minor Healthstone
    { 5511, 19006, 19007},              // Lesser Healthstone
    { 5509, 19008, 19009},              // Healthstone
    { 5510, 19010, 19011},              // Greater Healthstone
    { 9421, 19012, 19013},              // Major Healthstone
    {22103, 22104, 22105},              // Master Healthstone
    {36889, 36890, 36891},              // Demonic Healthstone
    {36892, 36893, 36894}               // Fel Healthstone
};

// -603 - Curse of Doom
class spell_warl_curse_of_doom : public SpellScriptLoader
{
    public:
        spell_warl_curse_of_doom() : SpellScriptLoader("spell_warl_curse_of_doom") { }

        class spell_warl_curse_of_doom_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_curse_of_doom_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_CURSE_OF_DOOM_EFFECT))
                    return false;
                return true;
            }

            bool Load() OVERRIDE
            {
                return GetCaster() && GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            void OnRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                if (!GetCaster())
                    return;

                AuraRemoveMode removeMode = GetTargetApplication()->GetRemoveMode();
                if (removeMode != AURA_REMOVE_BY_DEATH || !IsExpired())
                    return;

                if (GetCaster()->ToPlayer()->isHonorOrXPTarget(GetTarget()))
                    GetCaster()->CastSpell(GetTarget(), SPELL_WARLOCK_CURSE_OF_DOOM_EFFECT, true, NULL, aurEff);
            }

            void Register() OVERRIDE
            {
                 AfterEffectRemove += AuraEffectRemoveFn(spell_warl_curse_of_doom_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const OVERRIDE
        {
            return new spell_warl_curse_of_doom_AuraScript();
        }
};

// 48018 - Demonic Circle: Summon
class spell_warl_demonic_circle_summon : public SpellScriptLoader
{
    public:
        spell_warl_demonic_circle_summon() : SpellScriptLoader("spell_warl_demonic_circle_summon") { }

        class spell_warl_demonic_circle_summon_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_demonic_circle_summon_AuraScript);

            void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes mode)
            {
                // If effect is removed by expire remove the summoned demonic circle too.
                if (!(mode & AURA_EFFECT_HANDLE_REAPPLY))
                    GetTarget()->RemoveGameObject(GetId(), true);

                GetTarget()->RemoveAura(SPELL_WARLOCK_DEMONIC_CIRCLE_ALLOW_CAST);
            }

            void HandleDummyTick(AuraEffect const* /*aurEff*/)
            {
                if (GameObject* circle = GetTarget()->GetGameObject(GetId()))
                {
                    // Here we check if player is in demonic circle teleport range, if so add
                    // WARLOCK_DEMONIC_CIRCLE_ALLOW_CAST; allowing him to cast the WARLOCK_DEMONIC_CIRCLE_TELEPORT.
                    // If not in range remove the WARLOCK_DEMONIC_CIRCLE_ALLOW_CAST.

                    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(SPELL_WARLOCK_DEMONIC_CIRCLE_TELEPORT);

                    if (GetTarget()->IsWithinDist(circle, spellInfo->GetMaxRange(true)))
                    {
                        if (!GetTarget()->HasAura(SPELL_WARLOCK_DEMONIC_CIRCLE_ALLOW_CAST))
                            GetTarget()->CastSpell(GetTarget(), SPELL_WARLOCK_DEMONIC_CIRCLE_ALLOW_CAST, true);
                    }
                    else
                        GetTarget()->RemoveAura(SPELL_WARLOCK_DEMONIC_CIRCLE_ALLOW_CAST);
                }
            }

            void Register() OVERRIDE
            {
                OnEffectRemove += AuraEffectApplyFn(spell_warl_demonic_circle_summon_AuraScript::HandleRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_warl_demonic_circle_summon_AuraScript::HandleDummyTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const OVERRIDE
        {
            return new spell_warl_demonic_circle_summon_AuraScript();
        }
};

// 48020 - Demonic Circle: Teleport
class spell_warl_demonic_circle_teleport : public SpellScriptLoader
{
    public:
        spell_warl_demonic_circle_teleport() : SpellScriptLoader("spell_warl_demonic_circle_teleport") { }

        class spell_warl_demonic_circle_teleport_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_demonic_circle_teleport_AuraScript);

            void HandleTeleport(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Player* player = GetTarget()->ToPlayer())
                {
                    if (GameObject* circle = player->GetGameObject(SPELL_WARLOCK_DEMONIC_CIRCLE_SUMMON))
                    {
                        player->NearTeleportTo(circle->GetPositionX(), circle->GetPositionY(), circle->GetPositionZ(), circle->GetOrientation());
                        player->RemoveMovementImpairingAuras();
                    }
                }
            }

            void Register() OVERRIDE
            {
                OnEffectApply += AuraEffectApplyFn(spell_warl_demonic_circle_teleport_AuraScript::HandleTeleport, EFFECT_0, SPELL_AURA_MECHANIC_IMMUNITY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const OVERRIDE
        {
            return new spell_warl_demonic_circle_teleport_AuraScript();
        }
};

// 47193 - Demonic Empowerment
class spell_warl_demonic_empowerment : public SpellScriptLoader
{
    public:
        spell_warl_demonic_empowerment() : SpellScriptLoader("spell_warl_demonic_empowerment") { }

        class spell_warl_demonic_empowerment_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_demonic_empowerment_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_DEMONIC_EMPOWERMENT_SUCCUBUS) || !sSpellMgr->GetSpellInfo(SPELL_WARLOCK_DEMONIC_EMPOWERMENT_VOIDWALKER) || !sSpellMgr->GetSpellInfo(SPELL_WARLOCK_DEMONIC_EMPOWERMENT_FELGUARD) || !sSpellMgr->GetSpellInfo(SPELL_WARLOCK_DEMONIC_EMPOWERMENT_FELHUNTER) || !sSpellMgr->GetSpellInfo(SPELL_WARLOCK_DEMONIC_EMPOWERMENT_IMP))
                    return false;
                return true;
            }

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Creature* targetCreature = GetHitCreature())
                {
                    if (targetCreature->IsPet())
                    {
                        CreatureTemplate const* ci = sObjectMgr->GetCreatureTemplate(targetCreature->GetEntry());
                        switch (ci->family)
                        {
                            case CREATURE_FAMILY_SUCCUBUS:
                                targetCreature->CastSpell(targetCreature, SPELL_WARLOCK_DEMONIC_EMPOWERMENT_SUCCUBUS, true);
                                break;
                            case CREATURE_FAMILY_VOIDWALKER:
                            {
                                SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(SPELL_WARLOCK_DEMONIC_EMPOWERMENT_VOIDWALKER);
                                int32 hp = int32(targetCreature->CountPctFromMaxHealth(GetCaster()->CalculateSpellDamage(targetCreature, spellInfo, 0)));
                                targetCreature->CastCustomSpell(targetCreature, SPELL_WARLOCK_DEMONIC_EMPOWERMENT_VOIDWALKER, &hp, NULL, NULL, true);
                                //unitTarget->CastSpell(unitTarget, 54441, true);
                                break;
                            }
                            case CREATURE_FAMILY_FELGUARD:
                                targetCreature->CastSpell(targetCreature, SPELL_WARLOCK_DEMONIC_EMPOWERMENT_FELGUARD, true);
                                break;
                            case CREATURE_FAMILY_FELHUNTER:
                                targetCreature->CastSpell(targetCreature, SPELL_WARLOCK_DEMONIC_EMPOWERMENT_FELHUNTER, true);
                                break;
                            case CREATURE_FAMILY_IMP:
                                targetCreature->CastSpell(targetCreature, SPELL_WARLOCK_DEMONIC_EMPOWERMENT_IMP, true);
                                break;
                        }
                    }
                }
            }

            void Register() OVERRIDE
            {
                OnEffectHitTarget += SpellEffectFn(spell_warl_demonic_empowerment_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const OVERRIDE
        {
            return new spell_warl_demonic_empowerment_SpellScript();
        }
};

// 47422 - Everlasting Affliction
class spell_warl_everlasting_affliction : public SpellScriptLoader
{
    public:
        spell_warl_everlasting_affliction() : SpellScriptLoader("spell_warl_everlasting_affliction") { }

        class spell_warl_everlasting_affliction_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_everlasting_affliction_SpellScript);

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (Unit* target = GetHitUnit())
                    // Refresh corruption on target
                    if (AuraEffect* aur = target->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_WARLOCK, 0x2, 0, 0, caster->GetGUID()))
                    {
                        aur->SetBonusAmount(caster->SpellDamageBonusDone(target, aur->GetSpellInfo(), 0, DOT));
                        aur->CalculatePeriodic(caster, false, false);
                        aur->GetBase()->RefreshDuration(true);
                    }
            }

            void Register() OVERRIDE
            {
                OnEffectHitTarget += SpellEffectFn(spell_warl_everlasting_affliction_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const OVERRIDE
        {
            return new spell_warl_everlasting_affliction_SpellScript();
        }
};

// -47230 - Fel Synergy
class spell_warl_fel_synergy : public SpellScriptLoader
{
    public:
        spell_warl_fel_synergy() : SpellScriptLoader("spell_warl_fel_synergy") { }

        class spell_warl_fel_synergy_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_fel_synergy_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_FEL_SYNERGY_HEAL))
                    return false;
                return true;
            }

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                return GetTarget()->GetGuardianPet() && eventInfo.GetDamageInfo()->GetDamage();
            }

            void OnProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();

                int32 heal = CalculatePct(int32(eventInfo.GetDamageInfo()->GetDamage()), aurEff->GetAmount());
                GetTarget()->CastCustomSpell(SPELL_WARLOCK_FEL_SYNERGY_HEAL, SPELLVALUE_BASE_POINT0, heal, (Unit*)NULL, true, NULL, aurEff); // TARGET_UNIT_PET
            }

            void Register() OVERRIDE
            {
                DoCheckProc += AuraCheckProcFn(spell_warl_fel_synergy_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_warl_fel_synergy_AuraScript::OnProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const OVERRIDE
        {
            return new spell_warl_fel_synergy_AuraScript();
        }
};

// 63310 - Glyph of Shadowflame
class spell_warl_glyph_of_shadowflame : public SpellScriptLoader
{
    public:
        spell_warl_glyph_of_shadowflame() : SpellScriptLoader("spell_warl_glyph_of_shadowflame") { }

        class spell_warl_glyph_of_shadowflame_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_glyph_of_shadowflame_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_GLYPH_OF_SHADOWFLAME))
                    return false;
                return true;
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();
                GetTarget()->CastSpell(eventInfo.GetProcTarget(), SPELL_WARLOCK_GLYPH_OF_SHADOWFLAME, true, NULL, aurEff);
            }

            void Register() OVERRIDE
            {
                OnEffectProc += AuraEffectProcFn(spell_warl_glyph_of_shadowflame_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const OVERRIDE
        {
            return new spell_warl_glyph_of_shadowflame_AuraScript();
        }
};

// -48181 - Haunt
class spell_warl_haunt : public SpellScriptLoader
{
    public:
        spell_warl_haunt() : SpellScriptLoader("spell_warl_haunt") { }

        class spell_warl_haunt_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_haunt_SpellScript);

            void HandleAfterHit()
            {
                if (Aura* aura = GetHitAura())
                    if (AuraEffect* aurEff = aura->GetEffect(EFFECT_1))
                        aurEff->SetAmount(CalculatePct(aurEff->GetAmount(), GetHitDamage()));
            }

            void Register() OVERRIDE
            {
                AfterHit += SpellHitFn(spell_warl_haunt_SpellScript::HandleAfterHit);
            }
        };

        class spell_warl_haunt_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_haunt_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_HAUNT_HEAL))
                    return false;
                return true;
            }

            void HandleRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* caster = GetCaster())
                {
                    int32 amount = aurEff->GetAmount();
                    GetTarget()->CastCustomSpell(caster, SPELL_WARLOCK_HAUNT_HEAL, &amount, NULL, NULL, true, NULL, aurEff, GetCasterGUID());
                }
            }

            void Register() OVERRIDE
            {
                OnEffectRemove += AuraEffectApplyFn(spell_warl_haunt_AuraScript::HandleRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
            }
        };

        SpellScript* GetSpellScript() const OVERRIDE
        {
            return new spell_warl_haunt_SpellScript();
        }

        AuraScript* GetAuraScript() const OVERRIDE
        {
            return new spell_warl_haunt_AuraScript();
        }
};

// -755 - Health Funnel
class spell_warl_health_funnel : public SpellScriptLoader
{
    public:
        spell_warl_health_funnel() : SpellScriptLoader("spell_warl_health_funnel") { }

        class spell_warl_health_funnel_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_health_funnel_AuraScript);

            void ApplyEffect(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* caster = GetCaster();
                if (!caster)
                    return;

                Unit* target = GetTarget();
                if (caster->HasAura(SPELL_WARLOCK_IMPROVED_HEALTH_FUNNEL_R2))
                    target->CastSpell(target, SPELL_WARLOCK_IMPROVED_HEALTH_FUNNEL_BUFF_R2, true);
                else if (caster->HasAura(SPELL_WARLOCK_IMPROVED_HEALTH_FUNNEL_R1))
                    target->CastSpell(target, SPELL_WARLOCK_IMPROVED_HEALTH_FUNNEL_BUFF_R1, true);
            }

            void RemoveEffect(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                target->RemoveAurasDueToSpell(SPELL_WARLOCK_IMPROVED_HEALTH_FUNNEL_BUFF_R1);
                target->RemoveAurasDueToSpell(SPELL_WARLOCK_IMPROVED_HEALTH_FUNNEL_BUFF_R2);
            }

            void Register() OVERRIDE
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_warl_health_funnel_AuraScript::RemoveEffect, EFFECT_0, SPELL_AURA_PERIODIC_HEAL, AURA_EFFECT_HANDLE_REAL);
                OnEffectApply += AuraEffectApplyFn(spell_warl_health_funnel_AuraScript::ApplyEffect, EFFECT_0, SPELL_AURA_PERIODIC_HEAL, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const OVERRIDE
        {
            return new spell_warl_health_funnel_AuraScript();
        }
};

// -1454 - Life Tap
class spell_warl_life_tap : public SpellScriptLoader
{
    public:
        spell_warl_life_tap() : SpellScriptLoader("spell_warl_life_tap") { }

        class spell_warl_life_tap_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_life_tap_SpellScript);

            bool Load() OVERRIDE
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            bool Validate(SpellInfo const* /*spell*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_LIFE_TAP_ENERGIZE) || !sSpellMgr->GetSpellInfo(SPELL_WARLOCK_LIFE_TAP_ENERGIZE_2))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Player* caster = GetCaster()->ToPlayer();
                if (Unit* target = GetHitUnit())
                {
                    int32 damage = GetEffectValue();
                    int32 mana = int32(damage + (caster->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS+SPELL_SCHOOL_SHADOW) * 0.5f));

                    // Shouldn't Appear in Combat Log
                    target->ModifyHealth(-damage);

                    // Improved Life Tap mod
                    if (AuraEffect const* aurEff = caster->GetDummyAuraEffect(SPELLFAMILY_WARLOCK, WARLOCK_ICON_ID_IMPROVED_LIFE_TAP, 0))
                        AddPct(mana, aurEff->GetAmount());

                    caster->CastCustomSpell(target, SPELL_WARLOCK_LIFE_TAP_ENERGIZE, &mana, NULL, NULL, false);

                    // Mana Feed
                    int32 manaFeedVal = 0;
                    if (AuraEffect const* aurEff = caster->GetAuraEffect(SPELL_AURA_ADD_FLAT_MODIFIER, SPELLFAMILY_WARLOCK, WARLOCK_ICON_ID_MANA_FEED, 0))
                        manaFeedVal = aurEff->GetAmount();

                    if (manaFeedVal > 0)
                    {
                        ApplyPct(manaFeedVal, mana);
                        caster->CastCustomSpell(caster, SPELL_WARLOCK_LIFE_TAP_ENERGIZE_2, &manaFeedVal, NULL, NULL, true, NULL);
                    }
                }
            }

            SpellCastResult CheckCast()
            {
                if ((int32(GetCaster()->GetHealth()) > int32(GetSpellInfo()->Effects[EFFECT_0].CalcValue() + (6.3875 * GetSpellInfo()->BaseLevel))))
                    return SPELL_CAST_OK;
                return SPELL_FAILED_FIZZLE;
            }

            void Register() OVERRIDE
            {
                OnEffectHitTarget += SpellEffectFn(spell_warl_life_tap_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
                OnCheckCast += SpellCheckCastFn(spell_warl_life_tap_SpellScript::CheckCast);
            }
        };

        SpellScript* GetSpellScript() const OVERRIDE
        {
            return new spell_warl_life_tap_SpellScript();
        }
};

// 18541 - Ritual of Doom Effect
class spell_warl_ritual_of_doom_effect : public SpellScriptLoader
{
    public:
        spell_warl_ritual_of_doom_effect() : SpellScriptLoader("spell_warl_ritual_of_doom_effect") { }

        class spell_warl_ritual_of_doom_effect_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_ritual_of_doom_effect_SpellScript);

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                caster->CastSpell(caster, GetEffectValue(), true);
            }

            void Register() OVERRIDE
            {
                OnEffectHit += SpellEffectFn(spell_warl_ritual_of_doom_effect_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const OVERRIDE
        {
            return new spell_warl_ritual_of_doom_effect_SpellScript();
        }
};

// -27285 - Seed of Corruption
class spell_warl_seed_of_corruption : public SpellScriptLoader
{
    public:
        spell_warl_seed_of_corruption() : SpellScriptLoader("spell_warl_seed_of_corruption") { }

        class spell_warl_seed_of_corruption_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_seed_of_corruption_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                if (GetExplTargetUnit())
                    targets.remove(GetExplTargetUnit());
            }

            void Register() OVERRIDE
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_warl_seed_of_corruption_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const OVERRIDE
        {
            return new spell_warl_seed_of_corruption_SpellScript();
        }
};

// -7235 - Shadow Ward
class spell_warl_shadow_ward : public SpellScriptLoader
{
    public:
        spell_warl_shadow_ward() : SpellScriptLoader("spell_warl_shadow_ward") { }

        class spell_warl_shadow_ward_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_shadow_ward_AuraScript);

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& canBeRecalculated)
            {
                canBeRecalculated = false;
                if (Unit* caster = GetCaster())
                {
                    // +80.68% from sp bonus
                    float bonus = 0.8068f;

                    bonus *= caster->SpellBaseHealingBonusDone(GetSpellInfo()->GetSchoolMask());
                    bonus *= caster->CalculateLevelPenalty(GetSpellInfo());

                    amount += int32(bonus);
                }
            }

            void Register() OVERRIDE
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_shadow_ward_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
            }
        };

        AuraScript* GetAuraScript() const OVERRIDE
        {
            return new spell_warl_shadow_ward_AuraScript();
        }
};

// 63108 - Siphon Life
class spell_warl_siphon_life : public SpellScriptLoader
{
    public:
        spell_warl_siphon_life() : SpellScriptLoader("spell_warl_siphon_life") { }

        class spell_warl_siphon_life_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_siphon_life_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_SIPHON_LIFE_HEAL))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_GLYPH_OF_SIPHON_LIFE))
                    return false;
                return true;
            }

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                return eventInfo.GetDamageInfo()->GetDamage() && GetTarget()->IsAlive();
            }

            void OnProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();

                int32 amount = int32(CalculatePct(eventInfo.GetDamageInfo()->GetDamage(), aurEff->GetAmount()));
                // Glyph of Siphon Life
                if (AuraEffect const* glyph = GetTarget()->GetAuraEffect(SPELL_WARLOCK_GLYPH_OF_SIPHON_LIFE, EFFECT_0))
                    AddPct(amount, glyph->GetAmount());

                GetTarget()->CastCustomSpell(SPELL_WARLOCK_SIPHON_LIFE_HEAL, SPELLVALUE_BASE_POINT0, amount, GetTarget(), true, NULL, aurEff);
            }

            void Register() OVERRIDE
            {
                DoCheckProc += AuraCheckProcFn(spell_warl_siphon_life_AuraScript::CheckProc);
                OnEffectProc += AuraEffectProcFn(spell_warl_siphon_life_AuraScript::OnProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const OVERRIDE
        {
            return new spell_warl_siphon_life_AuraScript();
        }
};

// 29858 - Soulshatter
class spell_warl_soulshatter : public SpellScriptLoader
{
    public:
        spell_warl_soulshatter() : SpellScriptLoader("spell_warl_soulshatter") { }

        class spell_warl_soulshatter_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_warl_soulshatter_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_SOULSHATTER))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (Unit* target = GetHitUnit())
                {
                    if (target->CanHaveThreatList() && target->getThreatManager().getThreat(caster) > 0.0f)
                        caster->CastSpell(target, SPELL_WARLOCK_SOULSHATTER, true);
                }
            }

            void Register() OVERRIDE
            {
                OnEffectHitTarget += SpellEffectFn(spell_warl_soulshatter_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const OVERRIDE
        {
            return new spell_warl_soulshatter_SpellScript();
        }
};

// -30108 - Unstable Affliction
class spell_warl_unstable_affliction : public SpellScriptLoader
{
    public:
        spell_warl_unstable_affliction() : SpellScriptLoader("spell_warl_unstable_affliction") { }

        class spell_warl_unstable_affliction_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_warl_unstable_affliction_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/) OVERRIDE
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_WARLOCK_UNSTABLE_AFFLICTION_DISPEL))
                    return false;
                return true;
            }

            void HandleDispel(DispelInfo* dispelInfo)
            {
                if (Unit* caster = GetCaster())
                    if (AuraEffect const* aurEff = GetEffect(EFFECT_0))
                    {
                        int32 damage = aurEff->GetAmount() * 9;
                        // backfire damage and silence
                        caster->CastCustomSpell(dispelInfo->GetDispeller(), SPELL_WARLOCK_UNSTABLE_AFFLICTION_DISPEL, &damage, NULL, NULL, true, NULL, aurEff);
                    }
            }

            void Register() OVERRIDE
            {
                AfterDispel += AuraDispelFn(spell_warl_unstable_affliction_AuraScript::HandleDispel);
            }
        };

        AuraScript* GetAuraScript() const OVERRIDE
        {
            return new spell_warl_unstable_affliction_AuraScript();
        }
};


class spell_warl_glyph_seduction : public SpellScriptLoader
{
public:
    spell_warl_glyph_seduction() : SpellScriptLoader("spell_warl_glyph_seduction") { }

    class spell_warl_glyph_seduction_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_warl_glyph_seduction_SpellScript);

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            Unit* caster = GetCaster();
            if (Unit* target = GetHitUnit())
            {
                if (caster->GetOwner() && caster->GetOwner()->HasAura(SPELL_WARLOCK_GLYPH_OF_SUCCUBUS))
                {
                    target->RemoveAurasByType(SPELL_AURA_PERIODIC_DAMAGE, 0, target->GetAura(PRIEST_SHADOW_WORD_DEATH)); // SW:D shall not be removed.
                    target->RemoveAurasByType(SPELL_AURA_PERIODIC_DAMAGE_PERCENT);
                    target->RemoveAurasByType(SPELL_AURA_PERIODIC_LEECH);
                }
            }
        }

        void Register() OVERRIDE
        {
            OnEffectHitTarget += SpellEffectFn(spell_warl_glyph_seduction_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_warl_glyph_seduction_SpellScript();
    }
};

class spell_warl_pet_scaling_01 : public SpellScriptLoader
{
public:
    spell_warl_pet_scaling_01() : SpellScriptLoader("spell_warl_pet_scaling_01") { }

    class spell_warl_pet_scaling_01_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_warl_pet_scaling_01_AuraScript);

        bool Load() OVERRIDE
        {
            if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
            return false;
            return true;
        }

            void CalculateStaminaAmount(AuraEffect const* /* aurEff */, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* pet = GetUnitOwner())
            {
                Unit* owner = pet->GetOwner();
                if (!owner)
                    return;

                if (pet->IsGuardian())
                {
                    if (Unit* owner = pet->GetOwner())
                    {
                        float mod = 0.75f;
                        float ownerBonus = float(owner->GetStat(STAT_STAMINA)) * mod;
                        amount += ownerBonus;
                    }
                }
            }
        }

        void ApplyEffect(AuraEffect const* /* aurEff */, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* pet = GetUnitOwner())
                if (_tempHealth)
                    pet->SetHealth(_tempHealth);
            return;
        }

        void RemoveEffect(AuraEffect const* /* aurEff */, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* pet = GetUnitOwner())
                _tempHealth = pet->GetHealth();
            return;
        }

        void CalculateAttackPowerAmount(AuraEffect const* /* aurEff */, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* pet = GetUnitOwner())
                if (pet->IsPet())
                    if (Unit* owner = pet->ToPet()->GetOwner())
                    {
                int32 fire = int32(owner->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS + SPELL_SCHOOL_FIRE)) - owner->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_NEG + SPELL_SCHOOL_FIRE);
                int32 shadow = int32(owner->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS + SPELL_SCHOOL_SHADOW)) - owner->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_NEG + SPELL_SCHOOL_SHADOW);
                int32 maximum = (fire > shadow) ? fire : shadow;
                if (maximum < 0)
                    maximum = 0;

                float bonusAP = maximum * 0.57f;
                amount += bonusAP;

                // Glyph of felguard
                if (pet->GetEntry() == ENTRY_FELGUARD)
                {
                    if (AuraEffect* AurEff = owner->GetAuraEffect(56246, EFFECT_0))
                    {
                        float base_attPower = pet->GetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_VALUE) * pet->GetModifierValue(UNIT_MOD_ATTACK_POWER, BASE_PCT);
                        amount += CalculatePct(amount + base_attPower, AurEff->GetAmount());
                    }
                }
                    }
        }
        void CalculateDamageDoneAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* pet = GetUnitOwner())
            {
                if (!pet->IsPet())
                    return;

                Unit* owner = pet->ToPet()->GetOwner();
                if (!owner)
                    return;

                //the damage bonus used for pets is either fire or shadow damage, whatever is higher
                int32 fire = int32(owner->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS + SPELL_SCHOOL_FIRE)) - owner->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_NEG + SPELL_SCHOOL_FIRE);
                int32 shadow = int32(owner->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS + SPELL_SCHOOL_SHADOW)) - owner->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_NEG + SPELL_SCHOOL_SHADOW);
                int32 maximum = (fire > shadow) ? fire : shadow;
                float bonusDamage = 0.0f;
                if (maximum > 0)
                    bonusDamage = maximum * 0.15f;
                amount += bonusDamage;
            }
        }

        void Register() OVERRIDE
        {
            switch (m_scriptSpellId)
            {
            case SPELL_WARLOCK_PET_SCALING_01:
                OnEffectRemove += AuraEffectRemoveFn(spell_warl_pet_scaling_01_AuraScript::RemoveEffect, EFFECT_0, SPELL_AURA_MOD_STAT, AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK);
                AfterEffectApply += AuraEffectApplyFn(spell_warl_pet_scaling_01_AuraScript::ApplyEffect, EFFECT_0, SPELL_AURA_MOD_STAT, AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_01_AuraScript::CalculateStaminaAmount, EFFECT_0, SPELL_AURA_MOD_STAT);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_01_AuraScript::CalculateAttackPowerAmount, EFFECT_1, SPELL_AURA_MOD_ATTACK_POWER);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_01_AuraScript::CalculateDamageDoneAmount, EFFECT_2, SPELL_AURA_MOD_DAMAGE_DONE);
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
        return new spell_warl_pet_scaling_01_AuraScript();
    }
};

class spell_warl_pet_scaling_02 : public SpellScriptLoader
{
public:
    spell_warl_pet_scaling_02() : SpellScriptLoader("spell_warl_pet_scaling_02") { }

    class spell_warl_pet_scaling_02_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_warl_pet_scaling_02_AuraScript);

        bool Load() OVERRIDE
        {
            if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
            return false;
            return true;
        }

            void CalculateIntellectAmount(AuraEffect const* /* aurEff */, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* pet = GetUnitOwner())
            {
                Unit* owner = pet->GetOwner();
                if (!owner)
                    return;

                if (pet->IsGuardian())
                {
                    if (Unit* owner = pet->GetOwner())
                    {
                        float mod = 0.3f;
                        float ownerBonus = float(owner->GetStat(STAT_INTELLECT)) * mod;
                        amount += ownerBonus;
                    }
                }
            }
        }

        void ApplyEffect(AuraEffect const* /* aurEff */, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* pet = GetUnitOwner())
                if (_tempMana)
                    pet->SetPower(POWER_MANA, _tempMana);
            return;
        }

        void RemoveEffect(AuraEffect const* /* aurEff */, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* pet = GetUnitOwner())
                _tempMana = pet->GetPower(POWER_MANA);
            return;
        }

        void CalculateArmorAmount(AuraEffect const* /* aurEff */, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* pet = GetUnitOwner())
                if (pet->IsPet())
                    if (Unit* owner = pet->ToPet()->GetOwner())
                    {
                float ownerBonus = 0.0f;
                ownerBonus = CalculatePct(owner->GetArmor(), 35);
                amount += ownerBonus;
                    }
        }

        void CalculateFireResistanceAmount(AuraEffect const* /* aurEff */, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* pet = GetUnitOwner())
                if (pet->IsPet())
                    if (Unit* owner = pet->ToPet()->GetOwner())
                    {
                float ownerBonus = 0.0f;
                ownerBonus = CalculatePct(owner->GetResistance(SPELL_SCHOOL_FIRE), 40);
                amount += ownerBonus;
                    }
        }

        void Register() OVERRIDE
        {
            switch (m_scriptSpellId)
            {
            case SPELL_WARLOCK_PET_SCALING_02:
                OnEffectRemove += AuraEffectRemoveFn(spell_warl_pet_scaling_02_AuraScript::RemoveEffect, EFFECT_0, SPELL_AURA_MOD_STAT, AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK);
                AfterEffectApply += AuraEffectApplyFn(spell_warl_pet_scaling_02_AuraScript::ApplyEffect, EFFECT_0, SPELL_AURA_MOD_STAT, AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_02_AuraScript::CalculateIntellectAmount, EFFECT_0, SPELL_AURA_MOD_STAT);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_02_AuraScript::CalculateArmorAmount, EFFECT_1, SPELL_AURA_MOD_RESISTANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_02_AuraScript::CalculateFireResistanceAmount, EFFECT_2, SPELL_AURA_MOD_RESISTANCE);
                break;
            default:
                break;
            }
        }
    private:
        uint32 _tempMana;
    };
    AuraScript* GetAuraScript() const OVERRIDE
    {
        return new spell_warl_pet_scaling_02_AuraScript();
    }
};
class spell_warl_pet_scaling_03 : public SpellScriptLoader
{
public:
    spell_warl_pet_scaling_03() : SpellScriptLoader("spell_warl_pet_scaling_03") { }

    class spell_warl_pet_scaling_03_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_warl_pet_scaling_03_AuraScript);

        bool Load() OVERRIDE
        {
            if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
            return false;
            return true;
        }

            void CalculateFrostResistanceAmount(AuraEffect const* /* aurEff */, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* pet = GetUnitOwner())
                if (pet->IsPet())
                    if (Unit* owner = pet->ToPet()->GetOwner())
                    {
                float ownerBonus = 0.0f;
                ownerBonus = CalculatePct(owner->GetResistance(SPELL_SCHOOL_FROST), 40);
                amount += ownerBonus;
                    }
        }

        void CalculateArcaneResistanceAmount(AuraEffect const* /* aurEff */, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* pet = GetUnitOwner())
                if (pet->IsPet())
                    if (Unit* owner = pet->ToPet()->GetOwner())
                    {
                float ownerBonus = 0.0f;
                ownerBonus = CalculatePct(owner->GetResistance(SPELL_SCHOOL_ARCANE), 40);
                amount += ownerBonus;
                    }
        }

        void CalculateNatureResistanceAmount(AuraEffect const* /* aurEff */, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* pet = GetUnitOwner())
                if (pet->IsPet())
                    if (Unit* owner = pet->ToPet()->GetOwner())
                    {
                float ownerBonus = 0.0f;
                ownerBonus = CalculatePct(owner->GetResistance(SPELL_SCHOOL_NATURE), 40);
                amount += ownerBonus;
                    }
        }

        void Register() OVERRIDE
        {
            switch (m_scriptSpellId)
            {
            case SPELL_WARLOCK_PET_SCALING_03:
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_03_AuraScript::CalculateFrostResistanceAmount, EFFECT_0, SPELL_AURA_MOD_RESISTANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_03_AuraScript::CalculateArcaneResistanceAmount, EFFECT_1, SPELL_AURA_MOD_RESISTANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_03_AuraScript::CalculateNatureResistanceAmount, EFFECT_2, SPELL_AURA_MOD_RESISTANCE);
                break;
            default:
                break;
            }
        }
    };
    AuraScript* GetAuraScript() const OVERRIDE
    {
        return new spell_warl_pet_scaling_03_AuraScript();
    }
};
class spell_warl_pet_scaling_04 : public SpellScriptLoader
{
public:
    spell_warl_pet_scaling_04() : SpellScriptLoader("spell_warl_pet_scaling_04") { }

    class spell_warl_pet_scaling_04_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_warl_pet_scaling_04_AuraScript);

        bool Load() OVERRIDE
        {
            if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
            return false;
            return true;
        }

            void CalculateShadowResistanceAmount(AuraEffect const* /* aurEff */, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* pet = GetUnitOwner())
                if (pet->IsPet())
                    if (Unit* owner = pet->ToPet()->GetOwner())
                    {
                float ownerBonus = 0.0f;
                ownerBonus = CalculatePct(owner->GetResistance(SPELL_SCHOOL_SHADOW), 40);
                amount += ownerBonus;
                    }
        }

        void Register() OVERRIDE
        {
            switch (m_scriptSpellId)
            {
            case SPELL_WARLOCK_PET_SCALING_04:
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_04_AuraScript::CalculateShadowResistanceAmount, EFFECT_0, SPELL_AURA_MOD_RESISTANCE);
                break;
            default:
                break;
            }
        }
    };
    AuraScript* GetAuraScript() const OVERRIDE
    {
        return new spell_warl_pet_scaling_04_AuraScript();
    }
};
class spell_warl_pet_scaling_05 : public SpellScriptLoader
{
public:
    spell_warl_pet_scaling_05() : SpellScriptLoader("spell_warl_pet_scaling_05") { }

    class spell_warl_pet_scaling_05_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_warl_pet_scaling_05_AuraScript);

        bool Load() OVERRIDE
        {
            if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
            return false;
            return true;
        }

            void CalculateAmountMeleeHit(AuraEffect const* /* aurEff */, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
            {	// For others recalculate it from:
                float HitMelee = 0.0f;
                // Increase hit from SPELL_AURA_MOD_SPELL_HIT_CHANCE
                HitMelee += owner->GetTotalAuraModifier(SPELL_AURA_MOD_SPELL_HIT_CHANCE);
                // Increase hit spell from spell hit ratings
                HitMelee += owner->GetRatingBonusValue(CR_HIT_SPELL);
                amount += int32(HitMelee);
            }
        }

        void CalculateAmountSpellHit(AuraEffect const* /* aurEff */, int32& amount, bool& /*canBeRecalculated*/)
        {
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

        void CalculateAmountExpertise(AuraEffect const* /* aurEff */, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
            {
                // For others recalculate it from:
                float Expertise = 0.0f;
                // Increase hit from SPELL_AURA_MOD_SPELL_HIT_CHANCE
                Expertise += owner->GetTotalAuraModifier(SPELL_AURA_MOD_SPELL_HIT_CHANCE);
                // Increase hit spell from spell hit ratings
                Expertise += owner->GetRatingBonusValue(CR_HIT_SPELL);
                amount += int32(Expertise);
            }
        }

        void Register() OVERRIDE
        {
            switch (m_scriptSpellId)
            {
            case SPELL_WARLOCK_PET_SCALING_05:
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_05_AuraScript::CalculateAmountMeleeHit, EFFECT_0, SPELL_AURA_MOD_HIT_CHANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_05_AuraScript::CalculateAmountSpellHit, EFFECT_1, SPELL_AURA_MOD_SPELL_HIT_CHANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_scaling_05_AuraScript::CalculateAmountExpertise, EFFECT_2, SPELL_AURA_MOD_EXPERTISE);
                break;
            default:
                break;
            }
        }
    };
    AuraScript* GetAuraScript() const OVERRIDE
    {
        return new spell_warl_pet_scaling_05_AuraScript();
    }
};

class spell_warl_pet_passive : public SpellScriptLoader
{
public:
    spell_warl_pet_passive() : SpellScriptLoader("spell_warl_pet_passive") { }

    class spell_warl_pet_passive_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_warl_pet_passive_AuraScript);

        bool Load() OVERRIDE
        {
            if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
            return false;
            return true;
        }

            void CalculateAmountCritSpell(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
        {
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

                amount += int32(CritSpell);
                if (AuraApplication* improvedDemonicTacticsApp = owner->GetAuraApplicationOfRankedSpell(54347))
                    if (Aura* improvedDemonicTactics = improvedDemonicTacticsApp->GetBase())
                        if (AuraEffect* improvedDemonicTacticsEffect = improvedDemonicTactics->GetEffect(EFFECT_0))
                            amount += CalculatePct(CritSpell, improvedDemonicTacticsEffect->GetAmount());
            }
        }

        void CalculateAmountCritMelee(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
        {
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
                // Increase crit melee from melee crit ratings
                CritMelee += owner->GetRatingBonusValue(CR_CRIT_MELEE);

                amount += int32(CritMelee);
                if (AuraApplication* improvedDemonicTacticsApp = owner->GetAuraApplicationOfRankedSpell(54347))
                    if (Aura* improvedDemonicTactics = improvedDemonicTacticsApp->GetBase())
                        if (AuraEffect* improvedDemonicTacticsEffect = improvedDemonicTactics->GetEffect(EFFECT_0))
                            amount += CalculatePct(CritMelee, improvedDemonicTacticsEffect->GetAmount());
            }
        }

        void Register() OVERRIDE
        {
            switch (m_scriptSpellId)
            {
            case SPELL_PET_PASSIVE_CRIT:
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_passive_AuraScript::CalculateAmountCritSpell, EFFECT_0, SPELL_AURA_MOD_SPELL_CRIT_CHANCE);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_passive_AuraScript::CalculateAmountCritMelee, EFFECT_1, SPELL_AURA_MOD_WEAPON_CRIT_PERCENT);
                break;
            default:
                break;
            }
        }
    };
    AuraScript* GetAuraScript() const OVERRIDE
    {
        return new spell_warl_pet_passive_AuraScript();
    }
};

class spell_warl_pet_passive_damage_done : public SpellScriptLoader
{
public:
    spell_warl_pet_passive_damage_done() : SpellScriptLoader("spell_warl_pet_passive_damage_done") { }

    class spell_warl_pet_passive_damage_done_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_warl_pet_passive_damage_done_AuraScript);

        bool Load() OVERRIDE
        {
            if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
            return false;
            return true;
        }

            void CalculateAmountMeleeDamageDone(AuraEffect const* /* aurEff */, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (!GetCaster() || !GetCaster()->GetOwner())
                return;

            if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
            {
                Unit::AuraEffectList const& auraDamagePctList = owner->GetAuraEffectsByType(SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
                for (Unit::AuraEffectList::const_iterator itr = auraDamagePctList.begin(); itr != auraDamagePctList.end(); ++itr)
                    if ((*itr)->GetMiscValue() & SPELL_SCHOOL_MASK_NORMAL)
                        amount += (*itr)->GetAmount();
            }

        }

        void CalculateAmountSpellDamageDone(AuraEffect const* /* aurEff */, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (!GetCaster() || !GetCaster()->GetOwner())
                return;

            if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
            {
                Unit::AuraEffectList const& auraDamagePctList = owner->GetAuraEffectsByType(SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
                for (Unit::AuraEffectList::const_iterator itr = auraDamagePctList.begin(); itr != auraDamagePctList.end(); ++itr)
                    if ((*itr)->GetMiscValue() & SPELL_SCHOOL_MASK_MAGIC)
                        amount += (*itr)->GetAmount();
            }
        }

        void Register() OVERRIDE
        {
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_passive_damage_done_AuraScript::CalculateAmountMeleeDamageDone, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_passive_damage_done_AuraScript::CalculateAmountSpellDamageDone, EFFECT_1, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
        }
    };
    AuraScript* GetAuraScript() const OVERRIDE
    {
        return new spell_warl_pet_passive_damage_done_AuraScript();
    }
};

class spell_warlock_avoidance_passive : public SpellScriptLoader
{
public:
    spell_warlock_avoidance_passive() : SpellScriptLoader("spell_warlock_avoidance_passive") { }

    class spell_warlock_avoidance_passive_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_warlock_avoidance_passive_AuraScript);

        bool Load() OVERRIDE
        {
            if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
            return false;
            return true;
        }

            void CalculateAvoidanceAmount(AuraEffect const* /* aurEff */, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (!GetCaster() || !GetCaster()->GetOwner())
                return;

            if (Player* owner = GetCaster()->GetOwner()->ToPlayer())
            {
                switch (GetCaster()->GetEntry())
                {
                case ENTRY_IMP:
                case ENTRY_VOIDWALKER:
                case ENTRY_FELHUNTER:
                case ENTRY_SUCCUBUS:
                case ENTRY_FELGUARD:
                    amount = -90.0f;
                    break;
                }
            }
        }

        void Register() OVERRIDE
        {
            switch (m_scriptSpellId)
            {
            case SPELL_PET_PASSIVE_DAMAGE_TAKEN:
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warlock_avoidance_passive_AuraScript::CalculateAvoidanceAmount, EFFECT_0, SPELL_AURA_MOD_CREATURE_AOE_DAMAGE_AVOIDANCE);
                break;
            default:
                break;
            }
        }
    };

    AuraScript* GetAuraScript() const OVERRIDE
    {
        return new spell_warlock_avoidance_passive_AuraScript();
    }
};

class spell_warl_pet_passive_voidwalker : public SpellScriptLoader
{
public:
    spell_warl_pet_passive_voidwalker() : SpellScriptLoader("spell_warl_pet_passive_voidwalker") { }

    class spell_warl_pet_passive_voidwalker_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_warl_pet_passive_voidwalker_AuraScript);

        bool Load()
        {
            if (!GetCaster() || !GetCaster()->GetOwner() || GetCaster()->GetOwner()->GetTypeId() != TYPEID_PLAYER)
                return false;
            return true;
        }

        void CalculateAmount(AuraEffect const* /* aurEff */, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* pet = GetUnitOwner())
                if (pet->IsPet())
                    if (Unit* owner = pet->ToPet()->GetOwner())
                        if (AuraEffect* aurEffect = owner->GetAuraEffect(SPELL_WARLOCK_GLYPH_OF_VOIDWALKER, EFFECT_0))
                            amount += aurEffect->GetAmount();
        }

        void Register() OVERRIDE
        {
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warl_pet_passive_voidwalker_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE);
        }
    };

    AuraScript* GetAuraScript() const OVERRIDE
    {
        return new spell_warl_pet_passive_voidwalker_AuraScript();
    }
};

void AddSC_warlock_spell_scripts()
{
    new spell_warl_banish();
    new spell_warl_create_healthstone();
    new spell_warl_curse_of_doom();
    new spell_warl_demonic_circle_summon();
    new spell_warl_demonic_circle_teleport();
    new spell_warl_demonic_empowerment();
    new spell_warl_everlasting_affliction();
    new spell_warl_fel_synergy();
    new spell_warl_glyph_of_shadowflame();
    new spell_warl_haunt();
    new spell_warl_health_funnel();
    new spell_warl_life_tap();
    new spell_warl_ritual_of_doom_effect();
    new spell_warl_seed_of_corruption();
    new spell_warl_shadow_ward();
    new spell_warl_siphon_life();
    new spell_warl_soulshatter();
    new spell_warl_unstable_affliction();
    new spell_warl_glyph_seduction();
    new spell_warl_pet_scaling_01();
    new spell_warl_pet_scaling_02();
    new spell_warl_pet_scaling_03();
    new spell_warl_pet_scaling_04();
    new spell_warl_pet_scaling_05();
    new spell_warl_pet_passive();
    new spell_warl_pet_passive_damage_done();
    new spell_warlock_avoidance_passive();
    new spell_warl_pet_passive_voidwalker();
}
