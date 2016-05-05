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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "PassiveAI.h"
#include "BattlegroundIC.h"
#include "BattlefieldMgr.h"
#include "Player.h"
#include "Vehicle.h"
#include "SpellScript.h"
#include "SpellInfo.h"

// TO-DO: This should be done with SmartAI, but yet it does not correctly support vehicles's AIs.
//        Even adding ReactState Passive we still have issues using SmartAI.

enum BossSpells
{
    SPELL_DAGGER_THROW  = 67280,
    SPELL_BRUTAL_STRIKE = 58460,
    SPELL_CRUSHING_LEAP = 68506
};

enum EventTypes
{
    EVENT_DAGGER_THROW  = 1,
    EVENT_BRUTAL_STRIKE = 2,
    EVENT_CRUSHING_LEAP = 3
};

uint32 const  AURA_RAGE     = 66776;
float  const  ZPOS_GROUND   = 67.0f;

class npc_four_car_garage : public CreatureScript
{
    public:
        npc_four_car_garage() : CreatureScript("npc_four_car_garage") {}

        struct npc_four_car_garageAI : public NullCreatureAI
        {
            npc_four_car_garageAI(Creature* creature) : NullCreatureAI(creature) { }

            void PassengerBoarded(Unit* who, int8 /*seatId*/, bool apply) OVERRIDE
            {
                if (apply)
                {
                    uint32 spellId = 0;

                    switch (me->GetEntry())
                    {
                        case NPC_DEMOLISHER:
                            spellId = SPELL_DRIVING_CREDIT_DEMOLISHER;
                            break;
                        case NPC_GLAIVE_THROWER_A:
                        case NPC_GLAIVE_THROWER_H:
                            spellId = SPELL_DRIVING_CREDIT_GLAIVE;
                            break;
                        case NPC_SIEGE_ENGINE_H:
                        case NPC_SIEGE_ENGINE_A:
                            spellId = SPELL_DRIVING_CREDIT_SIEGE;
                            break;
                        case NPC_CATAPULT:
                            spellId = SPELL_DRIVING_CREDIT_CATAPULT;
                            break;
                        default:
                            return;
                    }

                    me->CastSpell(who, spellId, true);
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const OVERRIDE
        {
            return new npc_four_car_garageAI(creature);
        }
};

class boss_overlord_agmar : public CreatureScript
{
public:
    boss_overlord_agmar() : CreatureScript("boss_overlord_agmar") { }

    struct boss_overlord_agmarAI : public ScriptedAI
    {
        boss_overlord_agmarAI(Creature* creature) : ScriptedAI(creature) {}

        void Reset()
        {
            _events.Reset();
            _events.ScheduleEvent(EVENT_BRUTAL_STRIKE, 15000);
            _events.ScheduleEvent(EVENT_DAGGER_THROW, urand(10000, 15000));
            _events.ScheduleEvent(EVENT_CRUSHING_LEAP, urand(20000, 30000));
        }

        void JustDied(Unit* /*killer*/)
        {
            _events.Reset();
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            _events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_DAGGER_THROW:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 0.0f, true))
                    {
                        DoCast(target, SPELL_DAGGER_THROW);
                    }
                    _events.ScheduleEvent(EVENT_DAGGER_THROW, 15000);
                    break;
                case EVENT_BRUTAL_STRIKE:
                    DoCastVictim(SPELL_BRUTAL_STRIKE);
                    _events.ScheduleEvent(EVENT_BRUTAL_STRIKE, urand(15000, 15000));
                    break;
                case EVENT_CRUSHING_LEAP:
                    DoCastVictim(SPELL_CRUSHING_LEAP);
                    _events.ScheduleEvent(EVENT_CRUSHING_LEAP, urand(20000, 35000));
                    break;
                default:
                    break;
                }
            }
            // check if creature is  outside of room
            float HomeReference = me->GetDistance2d(me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY());
            float height = me->GetPositionZ();
            if (!me->GetAura(AURA_RAGE))
            {
                if (height < ZPOS_GROUND || HomeReference > 40.0f)
                {
                    DoCast(me, AURA_RAGE);
                }
            }
            else if (height > ZPOS_GROUND && HomeReference < 40.0f)
            {
                me->RemoveAura(AURA_RAGE);
            }
            DoMeleeAttackIfReady();
        }
    private:
        EventMap _events;
    };
    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_overlord_agmarAI(creature);
    }
};

class boss_halford_aterravermis : public CreatureScript
{
public:
    boss_halford_aterravermis() : CreatureScript("boss_halford_aterravermis") { }

    struct boss_halford_aterravermisAI : public ScriptedAI
    {
        boss_halford_aterravermisAI(Creature* creature) : ScriptedAI(creature) {}

        void Reset()
        {
            _events.Reset();
            _events.ScheduleEvent(EVENT_BRUTAL_STRIKE, 15000);
            _events.ScheduleEvent(EVENT_DAGGER_THROW, urand(10000, 15000));
            _events.ScheduleEvent(EVENT_CRUSHING_LEAP, urand(20000, 30000));
        }

        void JustDied(Unit* /*killer*/)
        {
            _events.Reset();
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            _events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_DAGGER_THROW:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 0.0f, true))
                    {
                        DoCast(target, SPELL_DAGGER_THROW);
                    }
                    _events.ScheduleEvent(EVENT_DAGGER_THROW, 15000);
                    break;
                case EVENT_BRUTAL_STRIKE:
                    DoCastVictim(SPELL_BRUTAL_STRIKE);
                    _events.ScheduleEvent(EVENT_BRUTAL_STRIKE, urand(15000, 15000));
                    break;
                case EVENT_CRUSHING_LEAP:
                    DoCastVictim(SPELL_CRUSHING_LEAP);
                    _events.ScheduleEvent(EVENT_CRUSHING_LEAP, urand(20000, 35000));
                    break;
                default:
                    break;
                }
            }
            // check if creature is  outside of room
            float HomeReference = me->GetDistance2d(me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY());
            if (!me->GetAura(AURA_RAGE))
            {
                if (HomeReference > 20.0f)
                {
                    DoCast(me, AURA_RAGE);
                }
            }
            else if (HomeReference < 20.0f)
            {
                me->RemoveAura(AURA_RAGE);
            }
            DoMeleeAttackIfReady();
        }
    private:
        EventMap _events;
    };
    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_halford_aterravermisAI(creature);
    }
};

enum Events
{
    EVENT_TALK = 1,
};

enum Texts
{
    SAY_ONBOARD = 0
};

class npc_ioc_gunship_captain : public CreatureScript
{
public:
    npc_ioc_gunship_captain() : CreatureScript("npc_ioc_gunship_captain") { }

    struct npc_ioc_gunship_captainAI : public ScriptedAI
    {
        npc_ioc_gunship_captainAI(Creature* creature) : ScriptedAI(creature) { }

        void DoAction(int32 action) OVERRIDE
        {
            if (action == ACTION_GUNSHIP_READY)
            {
                DoCast(me, SPELL_SIMPLE_TELEPORT);
                _events.ScheduleEvent(EVENT_TALK, 3000);
            }
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            _events.Update(diff);
            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_TALK:
                    Talk(SAY_ONBOARD);
                    DoCast(me, SPELL_TELEPORT_VISUAL_ONLY);
                    break;      
                default:
                    break;
                }
            }
        }

    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_ioc_gunship_captainAI(creature);
    }
};

class spell_ioc_gunship_portal : public SpellScriptLoader
{
public:
    spell_ioc_gunship_portal() : SpellScriptLoader("spell_ioc_gunship_portal") { }

    class spell_ioc_gunship_portal_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_ioc_gunship_portal_SpellScript);

        bool Load() OVERRIDE
        {
            return GetCaster()->GetTypeId() == TYPEID_PLAYER;
        }

        void HandleScript(SpellEffIndex /*effIndex*/)
        {
            Player* caster = GetCaster()->ToPlayer();
            /*
            * HACK: GetWorldLocation() returns real position and not transportposition.
            * ServertoClient: SMSG_MOVE_TELEPORT (0x0B39)
            * counter: 45
            * Tranpsort Guid: Full: xxxx Type: MOTransport Low: xxx
            * Transport Position X: 0 Y: 0 Z: 0 O: 0
            * Position: X: 7.305609 Y: -0.095246 Z: 34.51022 O: 0
            */
            caster->TeleportTo(GetHitCreature()->GetWorldLocation(), TELE_TO_NOT_LEAVE_TRANSPORT);
            /*
            * HACK: This aura should be added by 20212 and 20213 but can't find any SMSG_SPELL_GO. Could't find their position.
            * ServerToClient: SMSG_AURA_UPDATE (0x0072)
            * [0] CasterGUID: Full: xxxxx Type: Unit Entry: 20212 Low: xxx
            * [0] Flags: None (0)
            * [0] Caster Level: 60
            * [0] Spell ID: 66656
            * [0] Charges: 0
            * [0] Effect Mask: 1
            * [0] Slot: 37
            * Guid: Full: xxxxx Type: Player2 Low: xxxxx
            */
            caster->AddAura(SPELL_PARACHUTE, caster);
        }

        void Register() OVERRIDE
        {
            OnEffectHitTarget += SpellEffectFn(spell_ioc_gunship_portal_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const OVERRIDE
    {
        return new spell_ioc_gunship_portal_SpellScript();
    }
};

class spell_ioc_parachute_ic : public SpellScriptLoader
{
public:
    spell_ioc_parachute_ic() : SpellScriptLoader("spell_ioc_parachute_ic") { }

    class spell_ioc_parachute_ic_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_ioc_parachute_ic_AuraScript);

        void HandleTriggerSpell(AuraEffect const* /*aurEff*/)
        {
            if (Player* target = GetTarget()->ToPlayer())
                if (target->m_movementInfo.fallTime > 2000 && !target->GetTransport())
                    target->CastSpell(target, SPELL_PARACHUTE_IC, true);
        }

        void Register() OVERRIDE
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_ioc_parachute_ic_AuraScript::HandleTriggerSpell, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const OVERRIDE
    {
        return new spell_ioc_parachute_ic_AuraScript();
    }
};

class StartLaunchEvent : public BasicEvent
{
public:
    StartLaunchEvent(float x, float y, float z, uint32 lowGuid) : _x(x), _y(y), _z(z), _lowGuid(lowGuid)
    {
    }

    bool Execute(uint64 /*time*/, uint32 /*diff*/)
    {
        Player* player = sObjectMgr->GetPlayerByLowGUID(_lowGuid);
        if (!player || !player->GetVehicle())
            return true;

        player->AddAura(SPELL_LAUNCH_NO_FALLING_DAMAGE, player); // prevents falling damage
        float speedZ = 10.0f;
        float dist = player->GetExactDist2d(_x, _y);

        player->ExitVehicle();
        player->GetMotionMaster()->MoveJump(_x, _y, _z, dist, speedZ);
        return true;
    }

private:
    float _x, _y, _z;
    uint32 _lowGuid;
};

class spell_ioc_launch : public SpellScriptLoader
{
public:
    spell_ioc_launch() : SpellScriptLoader("spell_ioc_launch") { }

    class spell_ioc_launch_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_ioc_launch_SpellScript);

        void Launch()
        {
            if (!GetCaster()->ToCreature() || !GetExplTargetDest())
                return;

            float x, y, z;
            x = GetExplTargetDest()->GetPositionX();
            y = GetExplTargetDest()->GetPositionY();
            z = GetExplTargetDest()->GetPositionZ();
            GetCaster()->ToCreature()->m_Events.AddEvent(new StartLaunchEvent(x, y, z, GetHitPlayer()->GetGUIDLow()), GetCaster()->ToCreature()->m_Events.CalculateTime(2500));
        }

        void Register() OVERRIDE
        {
            AfterHit += SpellHitFn(spell_ioc_launch_SpellScript::Launch);
        }
    };

    SpellScript* GetSpellScript() const OVERRIDE
    {
        return new spell_ioc_launch_SpellScript();
    }
};


void AddSC_isle_of_conquest()
{
    new npc_four_car_garage();
    new boss_overlord_agmar();
    new boss_halford_aterravermis();
    new npc_ioc_gunship_captain();
    new spell_ioc_gunship_portal();
    new spell_ioc_parachute_ic();
    new spell_ioc_launch();
}
