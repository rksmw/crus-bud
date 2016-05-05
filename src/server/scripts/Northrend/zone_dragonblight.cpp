/*
 * Copyright (C) 2008-2013 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

/* ScriptData
SDName: Dragonblight
SD%Complete: 100
SDComment:
SDCategory: Dragonblight
EndScriptData */

/* ContentData
npc_alexstrasza_wr_gate
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "ScriptedEscortAI.h"
#include "Vehicle.h"
#include "CombatAI.h"
#include "Player.h"

enum AlexstraszaWrGate
{
    // Quest
    QUEST_RETURN_TO_AG_A    = 12499,
    QUEST_RETURN_TO_AG_H    = 12500,

    // Movie
    MOVIE_ID_GATES          = 14
};

#define GOSSIP_ITEM_WHAT_HAPPENED   "Alexstrasza, can you show me what happened here?"

class npc_alexstrasza_wr_gate : public CreatureScript
{
public:
    npc_alexstrasza_wr_gate() : CreatureScript("npc_alexstrasza_wr_gate") { }

    bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestRewardStatus(QUEST_RETURN_TO_AG_A) || player->GetQuestRewardStatus(QUEST_RETURN_TO_AG_H))
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_WHAT_HAPPENED, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action) OVERRIDE
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_INFO_DEF+1)
        {
            player->CLOSE_GOSSIP_MENU();
            player->SendMovieStart(MOVIE_ID_GATES);
        }

        return true;
    }
};

/*######
## Quest Strengthen the Ancients (12096|12092)
######*/

enum StrengthenAncientsMisc
{
    SAY_WALKER_FRIENDLY         = 0,
    SAY_WALKER_ENEMY            = 1,
    SAY_LOTHALOR                = 0,

    SPELL_CREATE_ITEM_BARK      = 47550,
    SPELL_CONFUSED              = 47044,

    NPC_LOTHALOR                = 26321,

    FACTION_WALKER_ENEMY        = 14,
};

class spell_q12096_q12092_dummy : public SpellScriptLoader // Strengthen the Ancients: On Interact Dummy to Woodlands Walker
{
public:
    spell_q12096_q12092_dummy() : SpellScriptLoader("spell_q12096_q12092_dummy") { }

    class spell_q12096_q12092_dummy_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q12096_q12092_dummy_SpellScript);

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            uint32 roll = rand() % 2;

            Creature* tree = GetHitCreature();
            Player* player = GetCaster()->ToPlayer();

            if (!tree || !player)
                return;

            tree->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);

            if (roll == 1) // friendly version
            {
                tree->CastSpell(player, SPELL_CREATE_ITEM_BARK);
                tree->AI()->Talk(SAY_WALKER_FRIENDLY, player);
                tree->DespawnOrUnsummon(1000);
            }
            else if (roll == 0) // enemy version
            {
                tree->AI()->Talk(SAY_WALKER_ENEMY, player);
                tree->setFaction(FACTION_WALKER_ENEMY);
                tree->Attack(player, true);
            }
        }

        void Register() OVERRIDE
        {
            OnEffectHitTarget += SpellEffectFn(spell_q12096_q12092_dummy_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const OVERRIDE
    {
        return new spell_q12096_q12092_dummy_SpellScript();
    }
};

class spell_q12096_q12092_bark : public SpellScriptLoader // Bark of the Walkers
{
public:
    spell_q12096_q12092_bark() : SpellScriptLoader("spell_q12096_q12092_bark") { }

    class spell_q12096_q12092_bark_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q12096_q12092_bark_SpellScript);

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            Creature* lothalor = GetHitCreature();
            if (!lothalor || lothalor->GetEntry() != NPC_LOTHALOR)
                return;

            lothalor->AI()->Talk(SAY_LOTHALOR);
            lothalor->RemoveAura(SPELL_CONFUSED);
            lothalor->DespawnOrUnsummon(4000);
        }

        void Register() OVERRIDE
        {
            OnEffectHitTarget += SpellEffectFn(spell_q12096_q12092_bark_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const OVERRIDE
    {
        return new spell_q12096_q12092_bark_SpellScript();
    }
};

/*######
## Quest: Defending Wyrmrest Temple ID: 12372
######*/

enum WyrmDefenderEnum
{
    // Quest data
    QUEST_DEFENDING_WYRMREST_TEMPLE          = 12372,
    GOSSIP_TEXTID_DEF1                       = 12899,

    // Gossip data
    GOSSIP_TEXTID_DEF2                       = 12900,

    // Spells data
    SPELL_CHARACTER_SCRIPT                   = 49213,
    SPELL_DEFENDER_ON_LOW_HEALTH_EMOTE       = 52421, // ID - 52421 Wyrmrest Defender: On Low Health Boss Emote to Controller - Random /self/
    SPELL_RENEW                              = 49263, // casted to heal drakes
    SPELL_WYRMREST_DEFENDER_MOUNT            = 49256,

    // Texts data
    WHISPER_MOUNTED                        = 0,
    BOSS_EMOTE_ON_LOW_HEALTH               = 2
};

#define GOSSIP_ITEM_1      "We need to get into the fight. Are you ready?"

class npc_wyrmrest_defender : public CreatureScript
{
    public:
        npc_wyrmrest_defender() : CreatureScript("npc_wyrmrest_defender") { }

        bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
        {
            if (player->GetQuestStatus(QUEST_DEFENDING_WYRMREST_TEMPLE) == QUEST_STATUS_INCOMPLETE)
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_DEF1, creature->GetGUID());
            }
            else
                player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

            return true;
        }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) OVERRIDE
        {
            player->PlayerTalkClass->ClearMenus();
            if (action == GOSSIP_ACTION_INFO_DEF+1)
            {
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_DEF2, creature->GetGUID());
                // Makes player cast trigger spell for 49207 on self
                player->CastSpell(player, SPELL_CHARACTER_SCRIPT, true);
                // The gossip should not auto close
            }

            return true;
        }

        struct npc_wyrmrest_defenderAI : public VehicleAI
        {
            npc_wyrmrest_defenderAI(Creature* creature) : VehicleAI(creature) { }

            bool hpWarningReady;
            bool renewRecoveryCanCheck;

            uint32 RenewRecoveryChecker;

            void Reset() OVERRIDE
            {
                hpWarningReady = true;
                renewRecoveryCanCheck = false;

                RenewRecoveryChecker = 0;
            }

            void UpdateAI(uint32 diff) OVERRIDE
            {
                // Check system for Health Warning should happen first time whenever get under 30%,
                // after it should be able to happen only after recovery of last renew is fully done (20 sec),
                // next one used won't interfere
                if (hpWarningReady && me->GetHealthPct() <= 30.0f)
                {
                    me->CastSpell(me, SPELL_DEFENDER_ON_LOW_HEALTH_EMOTE);
                    hpWarningReady = false;
                }

                if (renewRecoveryCanCheck)
                {
                    if (RenewRecoveryChecker <= diff)
                    {
                        renewRecoveryCanCheck = false;
                        hpWarningReady = true;
                    }
                    else RenewRecoveryChecker -= diff;
                }
            }

            void SpellHit(Unit* /*caster*/, SpellInfo const* spell) OVERRIDE
            {
                switch (spell->Id)
                {
                    case SPELL_WYRMREST_DEFENDER_MOUNT:
                        Talk(WHISPER_MOUNTED, me->GetCharmerOrOwner());
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PVP_ATTACKABLE);
                        break;
                    // Both below are for checking low hp warning
                    case SPELL_DEFENDER_ON_LOW_HEALTH_EMOTE:
                        Talk(BOSS_EMOTE_ON_LOW_HEALTH, me->GetCharmerOrOwner());
                        break;
                    case SPELL_RENEW:
                        if (!hpWarningReady && RenewRecoveryChecker <= 100)
                        {
                            RenewRecoveryChecker = 20000;
                        }
                        renewRecoveryCanCheck = true;
                        break;
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const OVERRIDE
        {
            return new npc_wyrmrest_defenderAI(creature);
        }
};

/*######
## Quest - Flight of the Wintergarde Defender
######*/

enum WintergardeFlight
{
    SPELL_RESCUE_VILLAGER     = 48363,
    SPELL_DROP_OFF_VILLAGER   = 48397,
    SPELL_COWER_FEAR          = 49774,
    SPELL_RIDE_VEHICLE        = 43671,

    SAY_FEAR                  = 0,
    SAY_IN_VEHICLE            = 1,
    SAY_RESCUED               = 2
};

class npc_helpless_wintergarde_villager : public CreatureScript
{
public:
   npc_helpless_wintergarde_villager() : CreatureScript("npc_helpless_wintergarde_villager") { }

   struct npc_helpless_wintergarde_villagerAI : public ScriptedAI
   {
       npc_helpless_wintergarde_villagerAI(Creature* creature) : ScriptedAI(creature) {}

       bool liberado;
       uint16 tiempohablar;

       void Miedo()
       {
           me->SetReactState(REACT_PASSIVE);
           me->CastSpell(me,SPELL_COWER_FEAR,true);
           liberado = false;
           tiempohablar = urand(10000,15000);
       }

       void InitializeAI()  OVERRIDE
       {
           Miedo();
       }

       void JustRespawned()  OVERRIDE
       {
           Miedo();
       }

       void DamageTaken (Unit* attacker, uint32& /*damage*/) OVERRIDE
       {
           if (!liberado)
               me->GetMotionMaster()->MoveFleeing(attacker);
       }

       void SpellHit(Unit* caster, const SpellInfo* spell) OVERRIDE
       {
           if (spell->Id != SPELL_RESCUE_VILLAGER)
               return;

           if (caster->GetVehicleKit()->GetAvailableSeatCount() != 0)
           {
               liberado = true;
               me->RemoveAura(SPELL_COWER_FEAR);
               me->GetMotionMaster()->Clear(false);
               me->CastSpell(caster,SPELL_RIDE_VEHICLE,true);
           }
       }

       void UpdateAI(uint32 diff) OVERRIDE
       {
           if (tiempohablar <= diff)
           {
               tiempohablar = urand(20000,25000);
               if (!liberado)
               {
                   if (urand(0,2) == 2)
                      Talk(SAY_FEAR);
               }
               else
                   Talk(SAY_IN_VEHICLE);
           }
           else
               tiempohablar -= diff;
       }
   };

   CreatureAI* GetAI(Creature* creature) const OVERRIDE
   {
       return new npc_helpless_wintergarde_villagerAI(creature);
   }
};


class npc_wintergarde_gryphon : public CreatureScript
{
public:
   npc_wintergarde_gryphon() : CreatureScript("npc_wintergarde_gryphon") { }

   struct npc_wintergarde_gryphonAI : public VehicleAI
   {
       npc_wintergarde_gryphonAI(Creature* creature) : VehicleAI(creature) {}

       void SpellHit(Unit* caster, const SpellInfo* spell) OVERRIDE
       {
           if (spell->Id != SPELL_DROP_OFF_VILLAGER)
               return;

           if (Unit* villager = me->GetVehicleKit()->GetPassenger(1))
           {
               if (villager->GetTypeId() != TYPEID_UNIT)
                   return;
               villager->ExitVehicle();
               villager->ToCreature()->AI()->Talk(SAY_RESCUED);
               villager->ToCreature()->DespawnOrUnsummon(5000);
           }
       }

       void PassengerBoarded(Unit* /*player*/, int8 seatId, bool apply) OVERRIDE
       {
           if (!apply && seatId == 0)
               if (Unit* villager = me->GetVehicleKit()->GetPassenger(1))
               {
                   if (villager->GetTypeId() != TYPEID_UNIT)
                       return;
                       villager->ExitVehicle();
                       villager->ToCreature()->DespawnOrUnsummon();
               }
       }

   };

   CreatureAI* GetAI(Creature* creature) const OVERRIDE
   {
       return new npc_wintergarde_gryphonAI(creature);
   }
};

/*######
## npc_injured_7th_legion_soldier
######*/

enum ChainGunAndYou
{
    NPC_INJURED_SOLDIER_WAYPOINT_1        = 27792,
    NPC_INJURED_SOLDIER_WAYPOINT_2        = 27793,
    NPC_INJURED_SOLDIER_WAYPOINT_3        = 27794,

    GO_BARRIER                            = 189996
};

class npc_injured_7th_legion_soldier : public CreatureScript
{
public:
    npc_injured_7th_legion_soldier() : CreatureScript("npc_injured_7th_legion_soldier") { }

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_injured_7th_legion_soldierAI(creature);
    }

    struct npc_injured_7th_legion_soldierAI : public npc_escortAI
    {
        npc_injured_7th_legion_soldierAI(Creature* creature) : npc_escortAI(creature)
        {
            me->SetReactState(REACT_PASSIVE);
            me->setRegeneratingHealth(false);
        }

        uint64 PlayerGUID;

        void InitWaypoint()
        {
            if (Creature* bunny1 = me->FindNearestCreature(NPC_INJURED_SOLDIER_WAYPOINT_1, 40.0f, true))
                AddWaypoint(1,bunny1->GetPositionX(),bunny1->GetPositionY(),bunny1->GetPositionZ());
            if (Creature* bunny2 = me->FindNearestCreature(NPC_INJURED_SOLDIER_WAYPOINT_2, 40.0f, true))
                AddWaypoint(2,bunny2->GetPositionX(),bunny2->GetPositionY(),bunny2->GetPositionZ());
            if (Creature* bunny3 = me->FindNearestCreature(NPC_INJURED_SOLDIER_WAYPOINT_3, 40.0f, true))
                AddWaypoint(3,bunny3->GetPositionX(),bunny3->GetPositionY(),bunny3->GetPositionZ());

            if (me->FindNearestGameObject(GO_BARRIER, 70.0f))
            {
                switch(urand(1,2))
                {
                    case 1:
                        AddWaypoint(4,3651.316f,-1210.174f,98.092438f);
                        AddWaypoint(5,3654.763f,-1203.456f,102.33562f);
                        AddWaypoint(6,3665.864f,-1200.71f,102.33583f);
                        break;
                    case 2:
                        AddWaypoint(4,3670.008f,-1219.708f,98.09168f);
                        AddWaypoint(5,3673.1066f,-1212.644f,102.33586f);
                        AddWaypoint(6,3665.864f,-1200.71f,102.33583f);
                        break;
                }
            }
            else
            {
                switch(urand(1,2))
                {
                    case 1:
                        AddWaypoint(4,3691.583f,-1174.098f,98.09111f);
                        AddWaypoint(5,3687.929f,-1181.177f,102.33601f);
                        AddWaypoint(6,3676.721f,-1180.595f,102.33583f);
                        break;
                    case 2:
                        AddWaypoint(4,3673.407f,-1164.766f,98.09163f);
                        AddWaypoint(5,3669.739f,-1172.348f,102.33589f);
                        AddWaypoint(6,3676.721f,-1180.595f,102.33583f);
                        break;
                }
            }
        }

        void IsSummonedBy(Unit* who) OVERRIDE
        {
            InitWaypoint();
            Start(false, true, 0);
            PlayerGUID = who->GetGUID();
            SetDespawnAtFar(false);
            SetDespawnAtEnd(false);
        }

        void WaypointReached(uint32 waypointId) OVERRIDE
        {
            if (waypointId == 6)
            {
                Talk(0);
                me->DespawnOrUnsummon(5000);
                if (Player* summoner = Unit::GetPlayer(*me,PlayerGUID))
                {
                    me->SetFacingToObject(summoner);
                    summoner->KilledMonsterCredit(me->GetEntry(),0);
                }
            }
        }
    };

};

/*######
## npc_rabid_grizzly
######*/

enum RadidGrizz
{
    SPELL_DEMORALIZING_ROAR = 50256,
    SPELL_RABIES = 51951,
    SPELL_LIQUID_FIRE_OF_ELUNE = 46770,
};

class npc_rabid_grizzly : public CreatureScript
{
public:
    npc_rabid_grizzly() : CreatureScript("npc_rabid_grizzly") { }

    struct npc_rabid_grizzlyAI : public ScriptedAI
    {
        npc_rabid_grizzlyAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiDemoralizingRoarTimer;
        uint32 uiRabiesTimer;

        void Reset() OVERRIDE
        {
            uiRabiesTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
            uiDemoralizingRoarTimer = urand(7*IN_MILLISECONDS,12*IN_MILLISECONDS);
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);
        }

        void SpellHit(Unit* caster, const SpellInfo* spell)
        {
            if (spell->Id != SPELL_LIQUID_FIRE_OF_ELUNE)
                return;

            Player* player = caster->ToPlayer();
            if (player && player->GetQuestStatus(12166) == QUEST_STATUS_INCOMPLETE)
            {
                me->DespawnOrUnsummon(5);
                caster->ToPlayer()->KilledMonsterCredit(27112,0);
            }
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uiRabiesTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_RABIES);
                uiRabiesTimer = urand(31*IN_MILLISECONDS,39*IN_MILLISECONDS);
            }
            else
                uiRabiesTimer -= uiDiff;

            if (uiDemoralizingRoarTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_DEMORALIZING_ROAR);
                uiDemoralizingRoarTimer = urand(11*IN_MILLISECONDS,15*IN_MILLISECONDS);
            }
            else
                uiDemoralizingRoarTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_rabid_grizzlyAI(creature);
    }
};

/*######
## npc_blighted_elk
######*/

enum BlightedElk
{
    SPELL_PLAGUE_BLIGHT = 43506,
};

class npc_blighted_elk : public CreatureScript
{
public:
    npc_blighted_elk() : CreatureScript("npc_blighted_elk") { }

    struct npc_blighted_elkAI : public ScriptedAI
    {
        npc_blighted_elkAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiPlagueBlightTimer;

        void Reset() OVERRIDE
        {
            uiPlagueBlightTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);
        }

        void SpellHit(Unit* caster, const SpellInfo* spell)
        {
            if (spell->Id != SPELL_LIQUID_FIRE_OF_ELUNE)
                return;

            Player* player = caster->ToPlayer();
            if (player && player->GetQuestStatus(12166) == QUEST_STATUS_INCOMPLETE)
            {
                me->DespawnOrUnsummon(5);
                caster->ToPlayer()->KilledMonsterCredit(27111,0);
            }
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uiPlagueBlightTimer <= uiDiff)
            {
                DoCast(me,SPELL_PLAGUE_BLIGHT);
                uiPlagueBlightTimer = urand(31*IN_MILLISECONDS,34*IN_MILLISECONDS);
            }
            else
                uiPlagueBlightTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_blighted_elkAI(creature);
    }
};

/*######
## npc_anubar_slayer
######*/

enum AnubarS
{
    SPELL_VENOMOUS_BITE = 32739,
};

class npc_anubar_slayer : public CreatureScript
{
public:
    npc_anubar_slayer() : CreatureScript("npc_anubar_slayer") { }

    struct npc_anubar_slayerAI : public ScriptedAI
    {
        npc_anubar_slayerAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiAnubarSlayerTimer;

        void Reset() OVERRIDE
        {
            uiAnubarSlayerTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uiAnubarSlayerTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_VENOMOUS_BITE);
                uiAnubarSlayerTimer = urand(8*IN_MILLISECONDS,14*IN_MILLISECONDS);
            }
            else
                uiAnubarSlayerTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_anubar_slayerAI(creature);
    }
};

/*######
## npc_goramosh
######*/

enum Goramosh
{
    SPELL_CONE_OF_COLD = 20828,
    SPELL_FROSTBOLT = 9672,
};

class npc_goramosh : public CreatureScript
{
public:
    npc_goramosh() : CreatureScript("npc_goramosh") { }

    struct npc_goramoshAI : public ScriptedAI
    {
        npc_goramoshAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiConeOfColdTimer;
        uint32 uiFrostBoltTimer;
        uint32 uiHomeTimer;

        void Reset() OVERRIDE
        {
            uiHomeTimer = 2*IN_MILLISECONDS;
            uiFrostBoltTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
            uiConeOfColdTimer = urand(6*IN_MILLISECONDS,10*IN_MILLISECONDS);
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
            {
                Talk(0);
                AttackStart(who);
            }
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (uiHomeTimer <= uiDiff)
            {
                if (!me->GetVictim())
                {
                    if (Creature *target = me->FindNearestCreature(190009,100.0f,true))
                    {
                        if (!target)
                            return;

                        DoCast(target,47334);
                    }
                    uiHomeTimer = 2000;
                }
            }
            else
                uiHomeTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uiFrostBoltTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_FROSTBOLT);
                uiFrostBoltTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
            }
            else
                uiFrostBoltTimer -= uiDiff;

            if (uiConeOfColdTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_CONE_OF_COLD);
                uiConeOfColdTimer = urand(6*IN_MILLISECONDS,10*IN_MILLISECONDS);
            }
            else
                uiConeOfColdTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_goramoshAI(creature);
    }
};

/*######
## npc_wind_trader_mufah
######*/

enum WiindTraderM
{
    SPELL_TYPHOON = 51817,
    NPCGUID = 2000042,
};

class npc_wind_trader_mufah : public CreatureScript
{
public:
    npc_wind_trader_mufah() : CreatureScript("npc_wind_trader_mufah") { }

    struct npc_wind_trader_mufahAI : public ScriptedAI
    {
        npc_wind_trader_mufahAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiTyphoonTimer;
        uint32 uiEventTimer;
        uint32 uiHomeTimer;
        uint8 phase;

        void Reset() OVERRIDE
        {
            uiHomeTimer = 5000;
            uiTyphoonTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
            uiEventTimer = urand(300*IN_MILLISECONDS,480*IN_MILLISECONDS);
            phase = 1;
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
            {
                Talk(0);
                AttackStart(who);
            }
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (uiEventTimer <= uiDiff)
            {
                if (!me->GetVictim())
                {
                    switch(phase)
                    {
                    case 1:
                        Talk(0);
                        uiEventTimer = 7000;
                        phase++;
                        break;
                    case 2:
                        if (Creature *creature = me->FindNearestCreature(26280,15.0f,true))
                        {
                            if (!creature)
                                return;

                            if (GUID_LOPART(creature->GetGUID()) == NPCGUID)
                                creature->AI()->Talk(0);

                            uiEventTimer = urand(300*IN_MILLISECONDS,480*IN_MILLISECONDS);
                            phase = 1;
                        }
                        break;
                    }
                }
            }
            else
                uiEventTimer -= uiDiff;

            if (uiHomeTimer <= uiDiff)
            {
                if (!me->GetVictim())
                {
                    if (me->GetDistance2d(me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY()) > 3.0f)
                        me->GetMotionMaster()->MovePoint(0,me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY(), me->GetHomePosition().GetPositionZ());

                    uiHomeTimer = 5000;
                }
            }
            else
                uiHomeTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uiTyphoonTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_TYPHOON);
                uiTyphoonTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiTyphoonTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_wind_trader_mufahAI(creature);
    }
};

/*######
## npc_surge_needle_sorcerer
######*/

enum SurgeNeedleS
{
    SPELL_ARCANE_BLAST = 51797,
};

class npc_surge_needle_sorcerer : public CreatureScript
{
public:
    npc_surge_needle_sorcerer() : CreatureScript("npc_surge_needle_sorcerer") { }

    struct npc_surge_needle_sorcererAI : public ScriptedAI
    {
        npc_surge_needle_sorcererAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiArcaneBlastTimer;
        uint32 uiHomeTimer;

        void Reset() OVERRIDE
        {
            uiHomeTimer = 2*IN_MILLISECONDS;
            uiArcaneBlastTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (uiHomeTimer <= uiDiff)
            {
                if (!me->GetVictim())
                {
                        if (Creature *target = me->FindNearestCreature(190009,100.0f,true))
                        {
                            if (!target)
                                return;

                            switch(GUID_LOPART(me->GetGUID()))
                            {
                            case 109569:
                            case 109578:
                            case 109572:
                            case 109558:
                            case 109561:
                            case 109565:
                            case 109563:
                            case 109559:
                            case 109560:
                            case 109571:
                                DoCast(target,47334);
                                break;
                            }
                        }
                        uiHomeTimer = 2000;
                }
            }
            else
                uiHomeTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uiArcaneBlastTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_ARCANE_BLAST);
                uiArcaneBlastTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiArcaneBlastTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_surge_needle_sorcererAI(creature);
    }
};

/*######
## npc_magister_keldonus
######*/

enum MagisterK
{
    NPC_ENTERCOMBAT = 26832,
    SPELL_FURY_OF_THE_BLUE = 51808,
    SPELL_MIGHT_OF_MALYGOS = 51800,
    SPELL_POWER_FLUX = 51806,
    SPELL_POWER_SIPHON = 51804,
};

class npc_magister_keldonus : public CreatureScript
{
public:
    npc_magister_keldonus() : CreatureScript("npc_magister_keldonus") { }

    struct npc_magister_keldonusAI : public ScriptedAI
    {
        npc_magister_keldonusAI(Creature* creature) : ScriptedAI(creature)
        {
            SpellEntry *spell;
            spell = (SpellEntry*)sSpellStore.LookupEntry(SPELL_FURY_OF_THE_BLUE);
            if (spell)
                spell->InterruptFlags = 0;
        }

        uint32 uiFuryBlueTimer;
        uint32 uiMightMalygosTimer;
        uint32 uiPowerFluxTimer;
        uint32 uiPowerSiphonTimer;
        uint32 uiHomeTimer;
        uint8 phase;

        bool casted;

        void Reset() OVERRIDE
        {
            uiPowerFluxTimer = urand(6*IN_MILLISECONDS,8*IN_MILLISECONDS);
            uiMightMalygosTimer = urand(5*IN_MILLISECONDS,8*IN_MILLISECONDS);
            uiPowerSiphonTimer = urand(10*IN_MILLISECONDS,16*IN_MILLISECONDS);
            uiFuryBlueTimer = urand(13*IN_MILLISECONDS,16*IN_MILLISECONDS);
            uiHomeTimer = urand(150*IN_MILLISECONDS,220*IN_MILLISECONDS);
            phase = 1;
            casted = false;
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (Creature *pTemp = me->FindNearestCreature(NPC_ENTERCOMBAT,20.0f,true))
            {
                if (!pTemp)
                    return;

                pTemp->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                pTemp->AI()->Talk(0, who);
            }

            if (me->IsValidAttackTarget(who))
                AttackStart(who);
        }

        void JustDied(Unit* /*killer*/) OVERRIDE
        {
            if (Creature *pTemp = me->FindNearestCreature(NPC_ENTERCOMBAT,20.0f,true))
            {
                if (!pTemp)
                    return;

                pTemp->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                pTemp->AI()->Talk(1);
            }
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (uiHomeTimer <= uiDiff)
            {
                if (!me->GetVictim())
                {
                        if (Creature *target = me->FindNearestCreature(NPC_ENTERCOMBAT,10.0f,true))
                        {
                            if (!target)
                                return;

                            switch(phase)
                            {
                            case 1:
                                me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                                Talk(1);
                                uiHomeTimer = 8000;
                                phase++;
                                break;
                            case 2:
                                me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                                Talk(2);
                                uiHomeTimer = 9000;
                                phase++;
                                break;
                            case 3:
                                target->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                                target->AI()->Talk(2);
                                uiHomeTimer = 7000;
                                phase++;
                                break;
                            case 4:
                                me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                                Talk(3);
                                uiHomeTimer = urand(120*IN_MILLISECONDS,200*IN_MILLISECONDS);
                                phase = 1;
                                break;
                            }
                        }
                }
            }
            else
                uiHomeTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uiPowerFluxTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_POWER_FLUX);
                uiPowerFluxTimer = urand(10*IN_MILLISECONDS,14*IN_MILLISECONDS);
            }
            else
                uiPowerFluxTimer -= uiDiff;

            if (uiFuryBlueTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_FURY_OF_THE_BLUE);
                uiFuryBlueTimer = urand(14*IN_MILLISECONDS,18*IN_MILLISECONDS);
            }
            else
                uiFuryBlueTimer -= uiDiff;

            if (me->HealthBelowPct(70) && !casted)
            {
                casted = true;
                DoCast(me,SPELL_MIGHT_OF_MALYGOS);
                Talk(0);
            }

            if (uiPowerSiphonTimer <= uiDiff)
            {
                if (casted)
                {
                    DoCast(me->GetVictim(),SPELL_POWER_SIPHON);
                    uiPowerSiphonTimer = urand(20*IN_MILLISECONDS,24*IN_MILLISECONDS);
                }
            }
            else
                uiPowerSiphonTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_magister_keldonusAI(creature);
    }
};

/*######
## npc_grand_magus_telestra
######*/

class npc_grand_magus_telestra : public CreatureScript
{
public:
    npc_grand_magus_telestra() : CreatureScript("npc_grand_magus_telestra") { }

    struct npc_grand_magus_telestraAI : public ScriptedAI
    {
        npc_grand_magus_telestraAI(Creature* creature) : ScriptedAI(creature){}

        void Reset() OVERRIDE
        {
            me->SetCanFly(true);
            me->AddUnitMovementFlag(MOVEMENTFLAG_DISABLE_GRAVITY);
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_grand_magus_telestraAI(creature);
    }
};

/*######
## npc_focus_wizard
######*/

enum FocusWizzard
{
    SPELL_ARCANE_FOCUS = 51777,
    SPELL_FROSTFIRE_BOLT = 51779,
    SPELL_LIGHTNING_BOLT = 49418,
};

class npc_focus_wizard : public CreatureScript
{
public:
    npc_focus_wizard() : CreatureScript("npc_focus_wizard") { }

    struct npc_focus_wizardAI : public ScriptedAI
    {
        npc_focus_wizardAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiFrostFireBoltTimer;
        uint32 LightningBoltTimer;
        uint32 uiHomeTimer;

        void Reset() OVERRIDE
        {
            switch(GUID_LOPART(me->GetGUID()))
            {
            case 113954:
            case 113945:
            case 113955:
            case 113953:
            case 113944:
            case 113943:
                me->setFaction(35);
                me->SetReactState(REACT_PASSIVE);
                break;
            }

            uiFrostFireBoltTimer = urand(3*IN_MILLISECONDS,8*IN_MILLISECONDS);
            LightningBoltTimer = urand(10*IN_MILLISECONDS,15*IN_MILLISECONDS);
            uiHomeTimer = 2*IN_MILLISECONDS;
        }

    void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (uiHomeTimer <= uiDiff)
            {
                if (!me->GetVictim())
                {
                        if (Creature *target = me->FindNearestCreature(23837,40.0f,true))
                        {
                            if (!target)
                                return;

                            switch(GUID_LOPART(me->GetGUID()))
                            {
                            case 114017:
                            case 114016:
                            case 114019:
                            case 114018:
                            case 114032:
                            case 114031:
                            case 114013:
                            case 114012:
                            case 114064:
                            case 114055:
                            case 114054:
                            case 114074:
                            case 114057:
                            case 114058:
                            case 114059:
                            case 114056:
                            case 114052:
                            case 203361:
                            case 203362:
                            case 114051:
                            case 114060:
                            case 114062:
                            case 114063:
                            case 114061:
                                if (!me->IsInCombat() && (me->GetDistance2d(me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY()) <= 1.0f))
                                    DoCast(target,47334);
                                break;
                            }
                        }
                        uiHomeTimer = 2000;
                }
            }
            else
                uiHomeTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uiFrostFireBoltTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_FROSTFIRE_BOLT);
                uiFrostFireBoltTimer = urand(3*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiFrostFireBoltTimer -= uiDiff;

            if (LightningBoltTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_LIGHTNING_BOLT);
                LightningBoltTimer = urand(6*IN_MILLISECONDS,10*IN_MILLISECONDS);
            }
            else
                LightningBoltTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_focus_wizardAI(creature);
    }
};

/*######
## npc_dragonblight_mage_hunter
######*/

class npc_dragonblight_mage_hunter : public CreatureScript
{
public:
    npc_dragonblight_mage_hunter() : CreatureScript("npc_dragonblight_mage_hunter") { }

    struct npc_dragonblight_mage_hunterAI : public ScriptedAI
    {
        npc_dragonblight_mage_hunterAI(Creature* creature) : ScriptedAI(creature){}

        void Reset() OVERRIDE
        {
            switch(GUID_LOPART(me->GetGUID()))
            {
            case 111731:
            case 111738:
            case 111737:
            case 111732:
            case 111736:
            case 111744:
            case 111733:
                me->setFaction(35);
                me->SetReactState(REACT_PASSIVE);
                break;
            }
        }

    void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_dragonblight_mage_hunterAI(creature);
    }
};

/*######
## npc_ruby_guardian
######*/

enum RubyGuardian
{
    SPELL_CLEAVE = 40504,
    NPC_FRIGID_NECRO = 27539,
    NPC_FRIGID_GHOUL = 27534,
};

class npc_ruby_guardian : public CreatureScript
{
public:
    npc_ruby_guardian() : CreatureScript("npc_ruby_guardian") { }

    struct npc_ruby_guardianAI : public ScriptedAI
    {
        npc_ruby_guardianAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiCleaveTimer;
        uint32 tSeek;

        void Reset() OVERRIDE
        {
            uiCleaveTimer = 4*IN_MILLISECONDS;
            tSeek = 2*IN_MILLISECONDS;
        }

        void DamageTaken(Unit* who, uint32& damage) OVERRIDE
        {
            if (who->GetTypeId() == TYPEID_PLAYER)
            {
                me->getThreatManager().resetAllAggro();
                who->AddThreat(me, 1.0f);
                me->AddThreat(who, 1.0f);
                me->AI()->AttackStart(who);
            }
            else if (who->IsPet())
            {
                me->getThreatManager().resetAllAggro();
                me->AddThreat(who, 1.0f);
                me->AI()->AttackStart(who);
            }
            if (who->GetEntry() == NPC_FRIGID_NECRO || who->GetEntry() == NPC_FRIGID_GHOUL)
            {
                me->AddThreat(who, 1.0f);
                me->AI()->AttackStart(who);
            }
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (tSeek <= uiDiff)
            {
                if ((me->IsAlive()) && (!me->IsInCombat() && (me->GetDistance2d(me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY()) <= 1.0f)))
                    if (Creature* enemy = me->FindNearestCreature(27539,2.0f, true))
                    {
                        me->AI()->AttackStart(enemy);
                        tSeek = urand(1000,2000);
                    }
            }
            else
                tSeek -= uiDiff;

            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uiCleaveTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_CLEAVE);
                uiCleaveTimer = urand(5*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiCleaveTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_ruby_guardianAI(creature);
    }
};

/*######
## npc_ruby_keeper
######*/

enum RubyKeeper
{
    SPELL_PLANTING_RUBY_ACORN = 49349,
};

class npc_ruby_keeper : public CreatureScript
{
public:
    npc_ruby_keeper() : CreatureScript("npc_ruby_keeper") { }

    struct npc_ruby_keeperAI : public ScriptedAI
    {
        npc_ruby_keeperAI(Creature* creature) : ScriptedAI(creature){}

        bool cast;
        uint32 uiCastTimer;

        void Reset() OVERRIDE
        {
            cast = false;
            uiCastTimer = 2000;
        }

        void SpellHit(Unit* caster, const SpellInfo* spell) OVERRIDE
        {
            if (spell->Id != SPELL_PLANTING_RUBY_ACORN || me->HasAura(49364))
                return;

            Player* player = caster->ToPlayer();

            if (!player)
                return;

            if (player && player->GetQuestStatus(12417) == QUEST_STATUS_INCOMPLETE)
            {
                player->KilledMonsterCredit(27530,0);
                cast = true;
            }
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (cast)
            {
                if(uiCastTimer <= uiDiff)
                {
                    DoCast(me,49364);
                    me->DespawnOrUnsummon(10000);
                    cast = false;
                }
                else
                    uiCastTimer -= uiDiff;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_ruby_keeperAI(creature);
    }
};

/*######
## npc_dummy_quest_12028
######*/

enum DummyQuest12028
{
    SPELL_SPIRITUAL_INSIGHT = 47189,
    QUEST_SPIRITUAL_INSIGHT = 12028,
};

class npc_dummy_quest_12028 : public CreatureScript
{
public:
    npc_dummy_quest_12028() : CreatureScript("npc_dummy_quest_12028") { }

    struct npc_dummy_quest_12028AI : public ScriptedAI
    {
        npc_dummy_quest_12028AI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiCheckTimer;

        void Reset() OVERRIDE
        {
            uiCheckTimer = 2*IN_MILLISECONDS;
        }

        void UpdateAI(uint32 uiDiff)  OVERRIDE
        {
            if (uiCheckTimer <= uiDiff)
            {
                if (Player * player = me->SelectNearestPlayer(35.0f))
                {
                    if (player->GetQuestStatus(QUEST_SPIRITUAL_INSIGHT) == QUEST_STATUS_INCOMPLETE)
                    {
                        if (player->HasAura(SPELL_SPIRITUAL_INSIGHT))
                        {
                            switch(GUID_LOPART(me->GetGUID()))
                            {
                                case 10003955:
                                    if (me->GetOwner())
                                        me->GetOwner()->RemoveAurasDueToSpell(SPELL_SPIRITUAL_INSIGHT);
                                    break;
                                case 10003953:
                                    Talk(6, player);
                                    break;
                                case 10003952:
                                    Talk(5, player);
                                    break;
                                case 10003951:
                                    Talk(4, player);
                                    break;
                                case 10003950:
                                    Talk(3, player);
                                    break;
                                case 10003949:
                                    Talk(2, player);
                                    break;
                                case 10003948:
                                    Talk(1, player);
                                    break;
                                case 10003947:
                                    Talk(0, player);
                                    break;
                            }
                            uiCheckTimer = 2*IN_MILLISECONDS;
                        }
                    }
                }
            }
            else
                uiCheckTimer -= uiDiff;
        }

    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_dummy_quest_12028AI(creature);
    }
};

/*######
## npc_alliance_steam_tank
######*/

enum SteamTank
{
    SPELL_DROP_OFF_GNOME          = 49109,
    SPELL_DROP_OFF_SOLDIER        = 49081,

    NPC_7H_LEGION_SIEGE_ENGINEER  = 27163,

    SAY_DROP_OFF                  = 0
};

class npc_alliance_steam_tank : public CreatureScript
{
public:
    npc_alliance_steam_tank() : CreatureScript("npc_alliance_steam_tank") { }

    struct npc_alliance_steam_tankAI : public VehicleAI
    {
        npc_alliance_steam_tankAI(Creature* creature) : VehicleAI(creature) {}

        void SpellHit(Unit* caster, const SpellInfo* spell) OVERRIDE
        {
            if (spell->Id != SPELL_DROP_OFF_GNOME && spell->Id != SPELL_DROP_OFF_SOLDIER)
                return;

            else if (spell->Id == SPELL_DROP_OFF_GNOME)
            {
                if (Unit* player = me->GetVehicleKit()->GetPassenger(0))
                    player->SummonCreature(NPC_7H_LEGION_SIEGE_ENGINEER, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ() - 3.5f, player->GetOrientation(), TEMPSUMMON_MANUAL_DESPAWN);
            }
            else if (spell->Id == SPELL_DROP_OFF_SOLDIER)
                for (uint8 i = 2; i < 4; ++i)
                    if (Unit* soldier = me->GetVehicleKit()->GetPassenger(i))
                    {
                        if (soldier->GetTypeId() != TYPEID_UNIT)
                            return;
                        soldier->ExitVehicle();
                        soldier->SetSheath(SHEATH_STATE_MELEE);
                        soldier->ToCreature()->AI()->Talk(SAY_DROP_OFF);
                        soldier->GetMotionMaster()->MovePoint(0, 3696.852f, -1204.281f, 111.6813f);
                        soldier->ToCreature()->DespawnOrUnsummon(10000);
                    }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_alliance_steam_tankAI(creature);
    }
};

void AddSC_dragonblight()
{
    new npc_alexstrasza_wr_gate();
    new spell_q12096_q12092_dummy();
    new spell_q12096_q12092_bark();
    new npc_wyrmrest_defender();
    new npc_helpless_wintergarde_villager();
    new npc_wintergarde_gryphon();
    new npc_injured_7th_legion_soldier();
    new npc_rabid_grizzly();
    new npc_blighted_elk();
    new npc_anubar_slayer();
    new npc_goramosh();
    new npc_wind_trader_mufah();
    new npc_surge_needle_sorcerer();
    new npc_magister_keldonus();
    new npc_grand_magus_telestra();
    new npc_focus_wizard();
    new npc_dragonblight_mage_hunter();
    new npc_ruby_guardian();
    new npc_ruby_keeper();
    new npc_dummy_quest_12028();
    new npc_alliance_steam_tank();
}
