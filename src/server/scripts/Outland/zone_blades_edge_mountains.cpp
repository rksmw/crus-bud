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
SDName: Blades_Edge_Mountains
SD%Complete: 90
SDComment: Quest support: 10503, 10504, 10556, 10609, 10682, 10821, 10980. Ogri'la->Skettis Flight. (npc_daranelle needs bit more work before consider complete)
SDCategory: Blade's Edge Mountains
EndScriptData */

/* ContentData
npc_bladespire_ogre
npc_nether_drake
npc_daranelle
npc_overseer_nuaar
npc_saikkal_the_elder
go_legion_obelisk
go_thunderspike
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "Cell.h"
#include "CellImpl.h"

//Support for quest: You're Fired! (10821)
bool     obelisk_one, obelisk_two, obelisk_three, obelisk_four, obelisk_five;

#define LEGION_OBELISK_ONE           185193
#define LEGION_OBELISK_TWO           185195
#define LEGION_OBELISK_THREE         185196
#define LEGION_OBELISK_FOUR          185197
#define LEGION_OBELISK_FIVE          185198

/*######
## npc_bladespire_ogre
######*/

/// @todo add support for quest 10512 + Creature abilities
enum eBladespireogre
{
    SPELL_BLADESPIRE_SPEAR_THROW_01 = 35262,
    SPEEL_BLOODMAUL_INTOXICATION    = 35240,
    SPEEL_BLADESPIRE_CLEAVE         = 15496,
};

class npc_bladespire_ogre : public CreatureScript
{
public:
    npc_bladespire_ogre() : CreatureScript("npc_bladespire_ogre") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_bladespire_ogreAI (creature);
    }

    struct npc_bladespire_ogreAI : public ScriptedAI
    {
        npc_bladespire_ogreAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 uiBladespire_Spear_Throw_01;
        uint32 uiBloodmaul_Intoxication;
        uint32 uiBladespire_Cleave;

        void Reset()
        {
            uiBladespire_Spear_Throw_01 = urand(5*IN_MILLISECONDS,15*IN_MILLISECONDS);
            uiBloodmaul_Intoxication = urand(8*IN_MILLISECONDS,15*IN_MILLISECONDS);
            uiBladespire_Cleave = urand(5*IN_MILLISECONDS,8*IN_MILLISECONDS);
        }

        void UpdateAI(uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (me->IsNonMeleeSpellCasted(false))
                return;

            if (uiBladespire_Spear_Throw_01 <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_BLADESPIRE_SPEAR_THROW_01);
                uiBladespire_Spear_Throw_01 = urand(5*IN_MILLISECONDS,15*IN_MILLISECONDS);
            }
            else
                uiBladespire_Spear_Throw_01 -= uiDiff;

            if (uiBloodmaul_Intoxication <= uiDiff)
            {
                DoCast(me,SPEEL_BLOODMAUL_INTOXICATION);
                uiBloodmaul_Intoxication = urand(26*IN_MILLISECONDS,35*IN_MILLISECONDS);
            }
            else
                uiBloodmaul_Intoxication -= uiDiff;

            if (uiBladespire_Cleave <= uiDiff)
            {
                DoCast(me->GetVictim(),SPEEL_BLADESPIRE_CLEAVE);
                uiBladespire_Cleave = urand(5*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiBladespire_Cleave -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_bladespire_shaman
######*/

/// @todo add support for quest 10512 + Creature abilities
enum eBladespireshaman
{
    SPELL_FIRE_NOVA_TOTEM           = 32062,
    SPELL_BLOODMAUL_INTOXICATION    = 35240,
    SPELL_LIGHTNING_BOLT            = 26098,
    SPELL_LIGHTNING_SHIELD          = 12550,
};

class npc_bladespire_shaman : public CreatureScript
{
public:
    npc_bladespire_shaman() : CreatureScript("npc_bladespire_shaman") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_bladespire_shamanAI (creature);
    }

    struct npc_bladespire_shamanAI : public ScriptedAI
    {
        npc_bladespire_shamanAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 uiFireNovaTotemTimer;
        uint32 uiBloodmaulIntoxicationTimer;
        uint32 uiLightningBoltTimer;
        uint32 uiLightningShieldTimer;

        void Reset()
        {
            uiFireNovaTotemTimer = urand(5*IN_MILLISECONDS,15*IN_MILLISECONDS);
            uiBloodmaulIntoxicationTimer = urand(8*IN_MILLISECONDS,15*IN_MILLISECONDS);
            uiLightningBoltTimer = urand(3*IN_MILLISECONDS,8*IN_MILLISECONDS);
            uiLightningShieldTimer = urand(3*IN_MILLISECONDS,8*IN_MILLISECONDS);
        }

        void UpdateAI(uint32 uiDiff)
        {
            if (!me->GetVictim())
            {
                if(!me->HasAura(SPELL_LIGHTNING_SHIELD))
                    DoCast(me,SPELL_LIGHTNING_SHIELD);
            }

            if (!UpdateVictim())
                return;

            if (me->IsNonMeleeSpellCasted(false))
                return;

            if (uiBloodmaulIntoxicationTimer <= uiDiff)
            {
                DoCast(me,SPELL_BLOODMAUL_INTOXICATION);
                uiBloodmaulIntoxicationTimer = urand(26*IN_MILLISECONDS,35*IN_MILLISECONDS);
            }
            else
                uiBloodmaulIntoxicationTimer -= uiDiff;

            if (uiLightningBoltTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_LIGHTNING_BOLT);
                uiLightningBoltTimer = urand(5*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiLightningBoltTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_bladespire_champion
######*/

enum eBladespirechampion
{
    SPELL_MIGHTY_CHARGE = 37777,
    SPELL_THUNDERCLAP = 8078,
    SPELL_BLOODMAUL = 35240,
};

class npc_bladespire_champion : public CreatureScript
{
public:
    npc_bladespire_champion() : CreatureScript("npc_bladespire_champion") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_bladespire_championAI (creature);
    }

    struct npc_bladespire_championAI : public ScriptedAI
    {
        npc_bladespire_championAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 uiMightyChargeTimer;
        uint32 uiBloodmaulTimer;
        uint32 uiThunderclapTimer;

        void Reset()
        {
            uiMightyChargeTimer = urand(5*IN_MILLISECONDS,15*IN_MILLISECONDS);
            uiBloodmaulTimer = urand(8*IN_MILLISECONDS,15*IN_MILLISECONDS);
            uiThunderclapTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
        }

        void UpdateAI(uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (me->IsNonMeleeSpellCasted(false))
                return;

            if (uiMightyChargeTimer <= uiDiff)
            {
                DoCast(SelectTarget(SELECT_TARGET_FARTHEST),SPELL_MIGHTY_CHARGE);
                uiMightyChargeTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiMightyChargeTimer -= uiDiff;

            if (uiBloodmaulTimer <= uiDiff)
            {
                DoCast(me,SPELL_BLOODMAUL);
                uiBloodmaulTimer = urand(26*IN_MILLISECONDS,35*IN_MILLISECONDS);
            }
            else
                uiBloodmaulTimer -= uiDiff;

            if (uiThunderclapTimer <= uiDiff)
            {
                DoCast(me,SPELL_THUNDERCLAP);
                uiThunderclapTimer = urand(6*IN_MILLISECONDS,10*IN_MILLISECONDS);
            }
            else
                uiThunderclapTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_bladespire_cock
######*/

enum eBladespirecook
{
    SPELL_ENDERIZE = 37596,
    SPELL_MEAT_SLAP = 37597,
    SPELL_BLOODMAUL_COCK = 35240,
};

class npc_bladespire_cook : public CreatureScript
{
public:
    npc_bladespire_cook() : CreatureScript("npc_bladespire_cook") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_bladespire_cookAI (creature);
    }

    struct npc_bladespire_cookAI : public ScriptedAI
    {
        npc_bladespire_cookAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 uiTenderizeTimer;
        uint32 uiBloodmaulCockTimer;
        uint32 uiMeatSlapTimer;

        void Reset()
        {
            uiTenderizeTimer = urand(3*IN_MILLISECONDS,14*IN_MILLISECONDS);
            uiBloodmaulCockTimer = urand(8*IN_MILLISECONDS,15*IN_MILLISECONDS);
            uiMeatSlapTimer = urand(4*IN_MILLISECONDS,9*IN_MILLISECONDS);
        }

        void UpdateAI(uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (me->IsNonMeleeSpellCasted(false))
                return;

            if (uiTenderizeTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_ENDERIZE);
                uiTenderizeTimer = urand(3*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiTenderizeTimer -= uiDiff;

            if (uiBloodmaulCockTimer <= uiDiff)
            {
                DoCast(me,SPELL_BLOODMAUL_COCK);
                uiBloodmaulCockTimer = urand(26*IN_MILLISECONDS,35*IN_MILLISECONDS);
            }
            else
                uiBloodmaulCockTimer -= uiDiff;

            if (uiMeatSlapTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_MEAT_SLAP);
                uiMeatSlapTimer = urand(4*IN_MILLISECONDS,9*IN_MILLISECONDS);
            }
            else
                uiMeatSlapTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_bladespire_raptor
######*/

enum eBladespireraptor
{
    SPELL_GUSHING_WOUND = 35321,
};

class npc_bladespire_raptor : public CreatureScript
{
public:
    npc_bladespire_raptor() : CreatureScript("npc_bladespire_raptor") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_bladespire_raptorAI (creature);
    }

    struct npc_bladespire_raptorAI : public ScriptedAI
    {
        npc_bladespire_raptorAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 uiGushingWoundTimer;

        void Reset()
        {
            uiGushingWoundTimer = urand(5*IN_MILLISECONDS,8*IN_MILLISECONDS);
        }

        void UpdateAI(uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (me->IsNonMeleeSpellCasted(false))
                return;

            if (uiGushingWoundTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_GUSHING_WOUND);
                uiGushingWoundTimer = urand(14*IN_MILLISECONDS,21*IN_MILLISECONDS);
            }
            else
                uiGushingWoundTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_stronglimb_seeproot
######*/

enum eStronglimbS
{
    SPELL_ENTANGLING_ROOTS = 11922,
    SPELL_STOMP = 12612,
};

class npc_stronglimb_seeproot : public CreatureScript
{
public:
    npc_stronglimb_seeproot() : CreatureScript("npc_stronglimb_seeproot") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_stronglimb_seeprootAI (creature);
    }

    struct npc_stronglimb_seeprootAI : public ScriptedAI
    {
        npc_stronglimb_seeprootAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 uiEntanglingRootsTimer;
        uint32 uiStompTimer;

        void Reset()
        {
            uiEntanglingRootsTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            uiStompTimer = urand(6*IN_MILLISECONDS,12*IN_MILLISECONDS);
        }

        void UpdateAI(uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (me->IsNonMeleeSpellCasted(false))
                return;

            if (uiEntanglingRootsTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_ENTANGLING_ROOTS);
                uiEntanglingRootsTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiEntanglingRootsTimer -= uiDiff;

            if (uiStompTimer <= uiDiff)
            {
                DoCast(me,SPELL_STOMP);
                uiStompTimer = urand(6*IN_MILLISECONDS,12*IN_MILLISECONDS);
            }
            else
                uiStompTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_bladewing_bloodletter
######*/

enum eBladewingB
{
    SPELL_BLOOD_LEECH = 37838,
    SPELL_POISON_SPIT = 37839,
};

class npc_bladewing_bloodletter : public CreatureScript
{
public:
    npc_bladewing_bloodletter() : CreatureScript("npc_bladewing_bloodletter") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_bladewing_bloodletterAI (creature);
    }

    struct npc_bladewing_bloodletterAI : public ScriptedAI
    {
        npc_bladewing_bloodletterAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 uiBloodLeechTimer;
        uint32 uiPoisonSpitTimer;

        void Reset()
        {
            uiBloodLeechTimer = urand(5*IN_MILLISECONDS,12*IN_MILLISECONDS);
            uiPoisonSpitTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
        }

        void UpdateAI(uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (me->IsNonMeleeSpellCasted(false))
                return;

            if (uiBloodLeechTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_BLOOD_LEECH);
                uiBloodLeechTimer = urand(7*IN_MILLISECONDS,12*IN_MILLISECONDS);
            }
            else
                uiBloodLeechTimer -= uiDiff;

            if (uiPoisonSpitTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_POISON_SPIT);
                uiPoisonSpitTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
            }
            else
                uiPoisonSpitTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_fey_drake
######*/

enum eFeyD
{
    SPELL_BLINK = 36718,
    SPELL_MANA_BURN_D = 11981,
};

class npc_fey_drake : public CreatureScript
{
public:
    npc_fey_drake() : CreatureScript("npc_fey_drake") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_fey_drakeAI (creature);
    }

    struct npc_fey_drakeAI : public ScriptedAI
    {
        npc_fey_drakeAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 uiBlinkTimer;
        uint32 uiManaBurnTimer;

        void Reset()
        {
            uiBlinkTimer = urand(8*IN_MILLISECONDS,14*IN_MILLISECONDS);
            uiManaBurnTimer = urand(4*IN_MILLISECONDS,6*IN_MILLISECONDS);
        }

        void UpdateAI(uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (me->IsNonMeleeSpellCasted(false))
                return;

            if (uiBlinkTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_BLINK);
                uiBlinkTimer = urand(8*IN_MILLISECONDS,14*IN_MILLISECONDS);
            }
            else
                uiBlinkTimer -= uiDiff;

            if (uiManaBurnTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_MANA_BURN_D);
                uiManaBurnTimer = urand(4*IN_MILLISECONDS,6*IN_MILLISECONDS);
            }
            else
                uiManaBurnTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_thunderlord_dire_wolf
######*/

enum eThunderlordD
{
    SPELL_THREATENING_GROWL = 5781,

    QUEST_PROTECTING_OUR_OWN = 10488,
    SPELL_GORDREKS_OINTMENT = 32578,
    NPC_DIRE_TIMBER_WOLF_TRIGGER = 21142,
};

class npc_thunderlord_dire_wolf : public CreatureScript
{
public:
    npc_thunderlord_dire_wolf() : CreatureScript("npc_thunderlord_dire_wolf") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_thunderlord_dire_wolfAI (creature);
    }

    struct npc_thunderlord_dire_wolfAI : public ScriptedAI
    {
        npc_thunderlord_dire_wolfAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 uiThreateningGrowlTimer;

        bool tengomierda;

        void Reset()
        {
            uiThreateningGrowlTimer = urand(8*IN_MILLISECONDS,14*IN_MILLISECONDS);
            tengomierda = false;
        }

       void SpellHit(Unit* caster, const SpellInfo* spell)
        {
            if (spell->Id == SPELL_GORDREKS_OINTMENT && caster->GetTypeId() == TYPEID_PLAYER && !tengomierda)
            {
                if (Player* player = caster->ToPlayer())
                {
                    if(player)
                        player->KilledMonsterCredit(NPC_DIRE_TIMBER_WOLF_TRIGGER, 0);
                }
            }
        }

        void UpdateAI(uint32 uiDiff)
        {
            if (me->HasAura(SPELL_GORDREKS_OINTMENT))
                tengomierda = true;
            else
                tengomierda = false;

            if (!UpdateVictim())
                return;

            if (me->IsNonMeleeSpellCasted(false))
                return;

            if (uiThreateningGrowlTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_THREATENING_GROWL);
                uiThreateningGrowlTimer = urand(18*IN_MILLISECONDS,22*IN_MILLISECONDS);
            }
            else
                uiThreateningGrowlTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };
};


/*######
## npc_vimgol_the_vile
######*/

enum eVimgolT
{
    SPELL_UNHOLY_GROWTH = 40545,
    SPELL_SHADOW_BOLT_WHIRL = 39631,
    SPELL_ASD = 39862,

    SAY_THEVILE = 1,
};

class npc_vimgol_the_vile : public CreatureScript
{
public:
    npc_vimgol_the_vile() : CreatureScript("npc_vimgol_the_vile") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_vimgol_the_vileAI (creature);
    }

    struct npc_vimgol_the_vileAI : public ScriptedAI
    {
        npc_vimgol_the_vileAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 uiUnholyGrowthTimer;
        uint32 uiShadowBoltWhirlTimer;

        void Reset()
        {
            uiUnholyGrowthTimer = urand(2*IN_MILLISECONDS,4*IN_MILLISECONDS);
            uiShadowBoltWhirlTimer = urand(5*IN_MILLISECONDS,8*IN_MILLISECONDS);
        }

        void DamageTaken(Unit* /*who*/, uint32& damage)
        {
            if (damage >= me->GetHealth())
            {
                me->CastSpell(me,SPELL_ASD);
            }
        }

        void UpdateAI(uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (me->IsNonMeleeSpellCasted(false))
                return;

            if (uiShadowBoltWhirlTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_SHADOW_BOLT_WHIRL);
                uiShadowBoltWhirlTimer = urand(5*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiShadowBoltWhirlTimer -= uiDiff;

            if (uiUnholyGrowthTimer <= uiDiff)
            {
                if(me->HealthBelowPct(35) && !me->HasAura(SPELL_UNHOLY_GROWTH))
                {
                    Talk(SAY_THEVILE);
                    DoCast(me,SPELL_UNHOLY_GROWTH);
                    uiUnholyGrowthTimer = 15000;
                }
            }
            else
                uiUnholyGrowthTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_summon_vimgol
######*/

enum eSummonV
{
    QUEST_GRIMOIRE_BUSINESS = 10998,
    SPELL_SUMMONED_DEMON = 7741,

    SAY_VIMGOL01 = 0,
};

class npc_summon_vimgol : public CreatureScript
{
public:
    npc_summon_vimgol() : CreatureScript("npc_summon_vimgol") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_summon_vimgolAI (creature);
    }

    struct npc_summon_vimgolAI : public ScriptedAI
    {
        npc_summon_vimgolAI(Creature* creature) : ScriptedAI(creature) {}

        bool check;
        uint32 uichecksummonTimer;
        uint32 uiksummonTimer;

        void Reset()
        {
            check = false;
            uichecksummonTimer = 3000;
        }

        void UpdateAI(uint32 uiDiff)
        {
            if (me->FindNearestCreature(22911,80.0f,true))
                return;

            if (uichecksummonTimer <= uiDiff)
            {
                if (Player * player = me->SelectNearestPlayer(1.0f))
                {
                    uichecksummonTimer = 5000;
                    if (player->GetQuestStatus(QUEST_GRIMOIRE_BUSINESS) == QUEST_STATUS_INCOMPLETE && !me->FindNearestCreature(22911,80.0f,true))
                        if (Creature* creature = me->SummonCreature(22911, 3279.67f, 4640.39f, 216.52f, 4.4f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 30000))
                        {
                            creature->CastSpell(me,SPELL_SUMMONED_DEMON);
                            creature->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                            creature->AI()->Talk(SAY_VIMGOL01);
                        }
                }
            }
            else
                uichecksummonTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_the_soulgrinder
######*/

enum eSoulgrinder
{
    QUEST_INTO_THE_SOULGRINDER = 11000,
    SPAWN_SUNDERED_GHOST = 22912,
    SPAWN_BOSS = 22910,
    SAY_COMBAT = 0,
};

class npc_the_soulgrinder : public CreatureScript
{
public:
    npc_the_soulgrinder() : CreatureScript("npc_the_soulgrinder") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_the_soulgrinderAI (creature);
    }

    struct npc_the_soulgrinderAI : public ScriptedAI
    {
        npc_the_soulgrinderAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 uiEventTimer;
        uint32 uiDespawnTimer;
        uint8 uiphase;

        Creature* channel1;
        Creature* channel2;
        Creature* channel3;
        Creature* bosspawn;

        void Reset()
        {
            uiDespawnTimer = 245000;
            uiEventTimer=4000;
            uiphase = 0;
            channel1 = NULL;
            channel2 = NULL;
            channel3 = NULL;
            bosspawn = NULL;
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
            me->SetReactState(REACT_PASSIVE);
        }

        void JustDied(Unit* /*killer*/)
        {
            uiphase = 30;
            uiEventTimer = 0;

            if (channel1)
                channel1->DespawnOrUnsummon();

            if (channel2)
                channel2->DespawnOrUnsummon();

            if (channel3)
                channel3->DespawnOrUnsummon();

            if (Creature* bossdespawn = me->FindNearestCreature(SPAWN_BOSS,100.0f,true))
                bossdespawn->DespawnOrUnsummon();
        }

        void UpdateAI(uint32 uiDiff)
        {
            if (uiDespawnTimer <= uiDiff)
            {
                me->DespawnOrUnsummon();
                uiDespawnTimer = 0;
            }
            else
                uiDespawnTimer -= uiDiff;

            if (uiEventTimer <= uiDiff)
            {
                switch (uiphase)
                {
                    case 0:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3543.55f,5576.23f,-2.722f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 1:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3540.94f,5605.16f,-3.216f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 2:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3519.43f,5585.97f,-3.124f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 3:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3553.86f,5571.41f,-1.579f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 4:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3554.72f,5598.11f,-4.33f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 5:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3515.92f,5604.19f,-2.637f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        if (Creature* search = me->FindNearestCreature(190002,120.0f,true))
                            me->CastSpell(search, 39920);

                        bosspawn = me->SummonCreature(SPAWN_BOSS, 3483.37f,5554.42f,7.518f, 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 250000);
                        if (bosspawn)
                        {
                            bosspawn->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
                            bosspawn->SetReactState(REACT_PASSIVE);
                        }

                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 6:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3523.35f,5576.95f,-2.203f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 7:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3525.21f,5613.44f,-4.336f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 8:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3525.21f,5613.44f,-4.336f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 9:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3513.83f,5599.04f,-1.161f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 10:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3547.23f,5609.01f,-3.708f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);

                        channel1 = me->SummonCreature(190006, me->GetPositionX(),me->GetPositionY(),me->GetPositionZ(),0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 150000);
                        if (!channel1)
                            return;

                        if (Creature* search = channel1->FindNearestCreature(190004,100.0f,true))
                            channel1->CastSpell(search,39920);

                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 11:
                       me->SummonCreature(SPAWN_SUNDERED_GHOST, 3543.55f,5576.23f,-2.722f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 12:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3540.94f,5605.16f,-3.216f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);

                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 13:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3519.43f,5585.97f,-3.124f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);

                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 14:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3553.86f,5571.41f,-1.579f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 15:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3554.72f,5598.11f,-4.33f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);

                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 16:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3547.23f,5609.01f,-3.708f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);

                        channel2 = me->SummonCreature(190006, me->GetPositionX(),me->GetPositionY(),me->GetPositionZ(),0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 150000);
                        if (!channel2)
                            return;

                        if (Creature* search = channel2->FindNearestCreature(190005,100.0f,true))
                            channel2->CastSpell(search,39920);

                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 17:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3523.35f,5576.95f,-2.203f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 18:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3525.21f,5613.44f,-4.336f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 19:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3525.21f,5613.44f,-4.336f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        uiEventTimer = 6000;
                        uiphase++;
                        break;

                    case 20:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3513.83f,5599.04f,-1.161f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        uiEventTimer = 6000;
                        uiphase++;
                        break;

                    case 21:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3547.23f,5609.01f,-3.708f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);

                        channel3 = me->SummonCreature(190006, me->GetPositionX(),me->GetPositionY(),me->GetPositionZ(),0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 150000);
                        if (!channel3)
                            return;

                        if (Creature* search = channel3->FindNearestCreature(190003,100.0f,true))
                            channel3->CastSpell(search,39920);

                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 22:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3523.35f,5576.95f,-2.203f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 23:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3525.21f,5613.44f,-4.336f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 24:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3525.21f,5613.44f,-4.336f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 25:
                        me->SummonCreature(SPAWN_SUNDERED_GHOST, 3513.83f,5599.04f,-1.161f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                        uiEventTimer = 6000;
                        uiphase++;
                        break;
                    case 26:
                        // Se ve bien estupido esto, pero lo dejare... en el peor de los casos crashea (LiMCrosS)
                        if (channel3)
                        {
                            channel3->CastStop(39920);
                            channel3->DespawnOrUnsummon(1);
                        }

                        if (channel2)
                        {
                            channel2->CastStop(39920);
                            channel2->DespawnOrUnsummon(1);
                        }

                        if (channel1)
                        {
                            channel1->CastStop(39920);
                            channel1->DespawnOrUnsummon(1);
                        }

                        me->CastStop(39920);

                        if (Creature* targetboss = me->FindNearestCreature(SPAWN_BOSS,120.0f,true))
                            me->CastSpell(targetboss,39920);

                        uiEventTimer = 4000;
                        uiphase++;
                        break;
                    case 27:
                        me->CastStop();
                        if (Creature* boss = me->FindNearestCreature(SPAWN_BOSS,120.0f,true))
                        {
                            boss->AI()->Talk(SAY_COMBAT);
                            boss->GetMotionMaster()->MovePoint(0, 3510.26f,5564.27f,1.055f);
                        }
                        uiEventTimer = 3500;
                        uiphase++;
                        break;
                    case 28:
                        if (Creature* boss = me->FindNearestCreature(SPAWN_BOSS,60.0f,true))
                            boss->GetMotionMaster()->MovePoint(0, 3530.66f,5582.31f,-1.800f);

                        uiEventTimer = 4000;
                        uiphase++;
                        break;
                    case 29:
                        if (Creature* boss = me->FindNearestCreature(SPAWN_BOSS,50.0f,true))
                        {
                            boss->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
                            boss->SetReactState(REACT_AGGRESSIVE);
                        }

                        uiEventTimer = 4000;
                        uiphase++;
                        break;
                        }
                }
                else
                    uiEventTimer -= uiDiff;
        }
    };
};

/*######
## npc_skulloc_soulgrinder
######*/

enum eSkullocS
{
   SPELL_BANISH = 39622,
   SPELL_CORRUPTION = 39621,
   SPELL_SUMMON_OGRE_GHOST = 39620,
   OBJECT_SKULLOCS_SOUL = 185577,
};

class npc_skulloc_soulgrinder : public CreatureScript
{
public:
    npc_skulloc_soulgrinder() : CreatureScript("npc_skulloc_soulgrinder") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_skulloc_soulgrinderAI (creature);
    }

    struct npc_skulloc_soulgrinderAI : public ScriptedAI
    {
        npc_skulloc_soulgrinderAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 uiBanishTimer;
        uint32 uiCorruptionTimer;
        uint32 uiSummonOgreGhostTimer;

        void Reset()
        {
            uiBanishTimer = urand(5*IN_MILLISECONDS,15*IN_MILLISECONDS);
            uiCorruptionTimer = urand(7*IN_MILLISECONDS,15*IN_MILLISECONDS);
            uiSummonOgreGhostTimer = urand(10*IN_MILLISECONDS,18*IN_MILLISECONDS);
        }

        void JustDied(Unit* /*killer*/)
        {
            if (Creature* despawn = me->FindNearestCreature(23019,80.0f,true))
            {
                if(despawn)
                    despawn->DespawnOrUnsummon();
            }

           me->SummonGameObject(OBJECT_SKULLOCS_SOUL, me->GetPositionX()+5,me->GetPositionY(), me->GetPositionZ(), 0, 0, 0, 0, 0, 1000);
        }

        void UpdateAI(uint32 uiDiff)
        {
            if(!me->GetVictim())
                return;

            if(uiBanishTimer <= uiDiff)
            {
                if(Unit *target = SelectTarget(SELECT_TARGET_RANDOM,0,50.0f,true))
                {
                    if(!target->HasAura(39622))
                    {
                        DoCast(target,SPELL_BANISH);
                        uiBanishTimer = urand(6*IN_MILLISECONDS,15*IN_MILLISECONDS);
                    }
                }
            }
            else
                uiBanishTimer -= uiDiff;

            if(uiCorruptionTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_CORRUPTION);
                uiCorruptionTimer = urand(7*IN_MILLISECONDS,15*IN_MILLISECONDS);
            }
            else
                uiCorruptionTimer -= uiDiff;

            if(uiSummonOgreGhostTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_SUMMON_OGRE_GHOST);
                uiSummonOgreGhostTimer = urand(10*IN_MILLISECONDS,18*IN_MILLISECONDS);
            }
            else
                uiSummonOgreGhostTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_sundered_spirit
######*/

class npc_sundered_spirit : public CreatureScript
{
public:
    npc_sundered_spirit() : CreatureScript("npc_sundered_spirit") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_sundered_spiritAI (creature);
    }

    struct npc_sundered_spiritAI : public ScriptedAI
    {
        npc_sundered_spiritAI(Creature* creature) : ScriptedAI(creature) {}

        void Reset()
        {
            DoCast(me,39916);
            DoCast(me,SPELL_SUMMONED_DEMON);
            me->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
        }

        void DamageTaken(Unit* who, uint32& damage)
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
        }

        void UpdateAI(uint32 uiDiff)
        {
            if (!me->GetVictim())
            {
                if (Creature* creature = me->FindNearestCreature(23019,80.0f,true))
                    me->AI()->AttackStart(creature);
                else
                    me->DespawnOrUnsummon();
            }

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_sundered_ghost
######*/

enum eSghost
{
    SPELL_SHADOW_BOLT = 20816,
};

class npc_sundered_ghost : public CreatureScript
{
public:
    npc_sundered_ghost() : CreatureScript("npc_sundered_ghost") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_sundered_ghostAI (creature);
    }

    struct npc_sundered_ghostAI : public ScriptedAI
    {
        npc_sundered_ghostAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 uiShadowboltTimer;

        void Reset()
        {
            DoCast(me,39916);
            uiShadowboltTimer = urand(4*IN_MILLISECONDS,6*IN_MILLISECONDS);
        }

        void UpdateAI(uint32 uiDiff)
        {
            if (!me->GetVictim())
            {
                if (!me->FindNearestCreature(22910,50.0f,true))
                    me->DespawnOrUnsummon();
            }

            if(!me->GetVictim())
                return;

            if(uiShadowboltTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_SHADOW_BOLT);
                uiShadowboltTimer = urand(4*IN_MILLISECONDS,6*IN_MILLISECONDS);
            }
            else
            uiShadowboltTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_nether_drake
######*/

enum eNetherdrake
{
    //Used by 20021, 21817, 21820, 21821, 21823 but not existing in database
    SAY_NIHIL_1                 = 0,
    SAY_NIHIL_2                 = 1,
    SAY_NIHIL_3                 = 2,
    SAY_NIHIL_4                 = 3,
    SAY_NIHIL_INTERRUPT         = 4,

    ENTRY_WHELP                 = 20021,
    ENTRY_PROTO                 = 21821,
    ENTRY_ADOLE                 = 21817,
    ENTRY_MATUR                 = 21820,
    ENTRY_NIHIL                 = 21823,

    SPELL_T_PHASE_MODULATOR     = 37573,

    SPELL_ARCANE_BLAST          = 38881,
    SPELL_MANA_BURN             = 38884,
    SPELL_INTANGIBLE_PRESENCE   = 36513
};

class npc_nether_drake : public CreatureScript
{
public:
    npc_nether_drake() : CreatureScript("npc_nether_drake") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_nether_drakeAI (creature);
    }

    struct npc_nether_drakeAI : public ScriptedAI
    {
        npc_nether_drakeAI(Creature* creature) : ScriptedAI(creature) {}

        bool IsNihil;
        uint32 NihilSpeech_Timer;
        uint32 NihilSpeech_Phase;

        uint32 ArcaneBlast_Timer;
        uint32 ManaBurn_Timer;
        uint32 IntangiblePresence_Timer;

        void Reset()
        {
            IsNihil = false;
            NihilSpeech_Timer = 3000;
            NihilSpeech_Phase = 0;

            ArcaneBlast_Timer = 7500;
            ManaBurn_Timer = 10000;
            IntangiblePresence_Timer = 15000;
        }

        void EnterCombat(Unit* /*who*/) {}

        void MoveInLineOfSight(Unit* who)
        {
            if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                return;

            ScriptedAI::MoveInLineOfSight(who);
        }

        //in case Creature was not summoned (not expected)
        void MovementInform(uint32 type, uint32 id)
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (id == 0)
            {
                me->setDeathState(JUST_DIED);
                me->RemoveCorpse();
                me->SetHealth(0);
            }
        }

        void SpellHit(Unit* caster, const SpellInfo* spell)
        {
            if (spell->Id == SPELL_T_PHASE_MODULATOR && caster->GetTypeId() == TYPEID_PLAYER)
            {
                const uint32 entry_list[4] = {ENTRY_PROTO, ENTRY_ADOLE, ENTRY_MATUR, ENTRY_NIHIL};
                int cid = rand()%(4-1);

                if (entry_list[cid] == me->GetEntry())
                    ++cid;

                //we are nihil, so say before transform
                if (me->GetEntry() == ENTRY_NIHIL)
                {
                    Talk(SAY_NIHIL_INTERRUPT);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    IsNihil = false;
                }

                if (me->UpdateEntry(entry_list[cid]))
                {
                    if (entry_list[cid] == ENTRY_NIHIL)
                    {
                        EnterEvadeMode();
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                        IsNihil = true;
                    }else
                        AttackStart(caster);
                }
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (IsNihil)
            {
                if (NihilSpeech_Timer <= diff)
                {
                    switch (NihilSpeech_Phase)
                    {
                        case 0:
                            Talk(SAY_NIHIL_1);
                            ++NihilSpeech_Phase;
                            break;
                        case 1:
                            Talk(SAY_NIHIL_2);
                            ++NihilSpeech_Phase;
                            break;
                        case 2:
                            Talk(SAY_NIHIL_3);
                            ++NihilSpeech_Phase;
                            break;
                        case 3:
                            Talk(SAY_NIHIL_4);
                            ++NihilSpeech_Phase;
                            break;
                        case 4:
                            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                            //take off to location above
                            me->GetMotionMaster()->MovePoint(0, me->GetPositionX()+50.0f, me->GetPositionY(), me->GetPositionZ()+50.0f);
                            ++NihilSpeech_Phase;
                            break;
                    }
                    NihilSpeech_Timer = 5000;
                } else NihilSpeech_Timer -=diff;

                //anything below here is not interesting for Nihil, so skip it
                return;
            }

            if (!UpdateVictim())
                return;

            if (IntangiblePresence_Timer <= diff)
            {
                DoCastVictim(SPELL_INTANGIBLE_PRESENCE);
                IntangiblePresence_Timer = 15000+rand()%15000;
            } else IntangiblePresence_Timer -= diff;

            if (ManaBurn_Timer <= diff)
            {
                Unit* target = me->GetVictim();
                if (target && target->getPowerType() == POWER_MANA)
                    DoCast(target, SPELL_MANA_BURN);
                ManaBurn_Timer = 8000+rand()%8000;
            } else ManaBurn_Timer -= diff;

            if (ArcaneBlast_Timer <= diff)
            {
                DoCastVictim(SPELL_ARCANE_BLAST);
                ArcaneBlast_Timer = 2500+rand()%5000;
            } else ArcaneBlast_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_daranelle
######*/

enum eDaranelle
{
    SAY_SPELL_INFLUENCE     = 0,
    SPELL_LASHHAN_CHANNEL   = 36904
};

class npc_daranelle : public CreatureScript
{
public:
    npc_daranelle() : CreatureScript("npc_daranelle") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_daranelleAI (creature);
    }

    struct npc_daranelleAI : public ScriptedAI
    {
        npc_daranelleAI(Creature* creature) : ScriptedAI(creature) {}

        void Reset() { }

        void EnterCombat(Unit* /*who*/) {}

        void MoveInLineOfSight(Unit* who)
        {
            if (who->GetTypeId() == TYPEID_PLAYER)
            {
                if (who->HasAura(SPELL_LASHHAN_CHANNEL) && me->IsWithinDistInMap(who, 10.0f))
                {
                    Talk(SAY_SPELL_INFLUENCE, who);
                    /// @todo Move the below to updateAI and run if this statement == true
                    DoCast(who, 37028, true);
                }
            }

            ScriptedAI::MoveInLineOfSight(who);
        }
    };
};

/*######
## npc_overseer_nuaar
######*/

#define GOSSIP_HELLO_ON "Overseer, I am here to negotiate on behalf of the Cenarion Expedition."

class npc_overseer_nuaar : public CreatureScript
{
public:
    npc_overseer_nuaar() : CreatureScript("npc_overseer_nuaar") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_INFO_DEF+1)
        {
            player->SEND_GOSSIP_MENU(10533, creature->GetGUID());
            player->AreaExploredOrEventHappens(10682);
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->GetQuestStatus(10682) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_ON, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->SEND_GOSSIP_MENU(10532, creature->GetGUID());

        return true;
    }
};

/*######
## npc_saikkal_the_elder
######*/

#define GOSSIP_HELLO_STE    "Yes... yes, it's me."
#define GOSSIP_SELECT_STE   "Yes elder. Tell me more of the book."

class npc_saikkal_the_elder : public CreatureScript
{
public:
    npc_saikkal_the_elder() : CreatureScript("npc_saikkal_the_elder") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SELECT_STE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
                player->SEND_GOSSIP_MENU(10795, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                player->TalkedToCreature(creature->GetEntry(), creature->GetGUID());
                player->SEND_GOSSIP_MENU(10796, creature->GetGUID());
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->GetQuestStatus(10980) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_STE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->SEND_GOSSIP_MENU(10794, creature->GetGUID());

        return true;
    }
};

/*######
## go_legion_obelisk
######*/

class go_legion_obelisk : public GameObjectScript
{
public:
    go_legion_obelisk() : GameObjectScript("go_legion_obelisk") { }

    bool OnGossipHello(Player* player, GameObject* go)
    {
        if (player->GetQuestStatus(10821) == QUEST_STATUS_INCOMPLETE)
        {
            switch (go->GetEntry())
            {
                case LEGION_OBELISK_ONE:
                      obelisk_one = true;
                     break;
                case LEGION_OBELISK_TWO:
                      obelisk_two = true;
                     break;
                case LEGION_OBELISK_THREE:
                      obelisk_three = true;
                     break;
                case LEGION_OBELISK_FOUR:
                      obelisk_four = true;
                     break;
                case LEGION_OBELISK_FIVE:
                      obelisk_five = true;
                     break;
            }

            if (obelisk_one == true && obelisk_two == true && obelisk_three == true && obelisk_four == true && obelisk_five == true)
            {
                go->SummonCreature(19963, 2943.40f, 4778.20f, 284.49f, 0.94f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000);
                //reset global var
                obelisk_one = false;
                obelisk_two = false;
                obelisk_three = false;
                obelisk_four = false;
                obelisk_five = false;
            }
        }

        return true;
    }
};

/*######
## npc_bloodmaul_brutebane
######*/

enum eBloodmaul
{
    NPC_OGRE_BRUTE                              = 19995,
    NPC_QUEST_CREDIT                            = 21241,
    GO_KEG                                      = 184315,
    QUEST_GETTING_THE_BLADESPIRE_TANKED         = 10512,
    QUEST_BLADESPIRE_KEGGER                     = 10545,
};

class npc_bloodmaul_brutebane : public CreatureScript
{
public:
    npc_bloodmaul_brutebane() : CreatureScript("npc_bloodmaul_brutebane") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_bloodmaul_brutebaneAI(creature);
    }

    struct npc_bloodmaul_brutebaneAI : public ScriptedAI
    {
        npc_bloodmaul_brutebaneAI(Creature* creature) : ScriptedAI(creature)
        {
           if (Creature* Ogre = me->FindNearestCreature(NPC_OGRE_BRUTE, 50, true))
           {
               Ogre->SetReactState(REACT_DEFENSIVE);
               Ogre->GetMotionMaster()->MovePoint(1, me->GetPositionX()-1, me->GetPositionY()+1, me->GetPositionZ());
           }
        }

        uint64 OgreGUID;

        void Reset()
        {
            OgreGUID = 0;
        }

        void UpdateAI(uint32 /*uiDiff*/) {}
    };
};

/*######
## npc_ogre_brute
######*/

class npc_ogre_brute : public CreatureScript
{
public:
    npc_ogre_brute() : CreatureScript("npc_ogre_brute") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_ogre_bruteAI(creature);
    }

    struct npc_ogre_bruteAI : public ScriptedAI
    {
        npc_ogre_bruteAI(Creature* creature) : ScriptedAI(creature) {}

        uint64 PlayerGUID;
        uint32 uiBladespireSpeartimer;
        uint32 uiBloodmaulIntTimer;
        uint32 uiBladespireClTimer;

        void Reset() OVERRIDE
        {
            PlayerGUID = 0;
            uiBladespireSpeartimer = urand(5*IN_MILLISECONDS,15*IN_MILLISECONDS);
            uiBloodmaulIntTimer = urand(8*IN_MILLISECONDS,15*IN_MILLISECONDS);
            uiBladespireClTimer = urand(5*IN_MILLISECONDS,8*IN_MILLISECONDS);
        }


        void MoveInLineOfSight(Unit* who) OVERRIDE
        {
            if (!who || (!who->IsAlive()))
                return;

            if (me->IsWithinDistInMap(who, 50.0f))
            {
                if (who->GetTypeId() == TYPEID_PLAYER)
                    if (who->ToPlayer()->GetQuestStatus(QUEST_GETTING_THE_BLADESPIRE_TANKED) == QUEST_STATUS_INCOMPLETE
                        || who->ToPlayer()->GetQuestStatus(QUEST_BLADESPIRE_KEGGER) == QUEST_STATUS_INCOMPLETE)
                        PlayerGUID = who->GetGUID();
            }
        }

        void MovementInform(uint32 /*type*/, uint32 id) OVERRIDE
        {
            if (id == 1)
            {
                if (GameObject* Keg = me->FindNearestGameObject(GO_KEG, 20))
                    Keg->Delete();

                me->HandleEmoteCommand(7);
                me->SetReactState(REACT_AGGRESSIVE);
                me->GetMotionMaster()->MoveTargetedHome();

                Player* player = ObjectAccessor::GetPlayer(*me, PlayerGUID);
                Creature* Credit = me->FindNearestCreature(NPC_QUEST_CREDIT, 50, true);
                if (player && Credit)
                    player->KilledMonster(Credit->GetCreatureTemplate(), Credit->GetGUID());
            }
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (!UpdateVictim())
                return;

            if (me->IsNonMeleeSpellCasted(false))
                return;

            if (uiBladespireClTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_BLADESPIRE_SPEAR_THROW_01);
                uiBladespireClTimer = urand(5*IN_MILLISECONDS,15*IN_MILLISECONDS);
            }
            else
                uiBladespireClTimer -= uiDiff;

            if (uiBloodmaulIntTimer <= uiDiff)
            {
                DoCast(me,SPEEL_BLOODMAUL_INTOXICATION);
                uiBloodmaulIntTimer = urand(26*IN_MILLISECONDS,35*IN_MILLISECONDS);
            }
            else
                uiBloodmaulIntTimer -= uiDiff;

            if (uiBladespireClTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPEEL_BLADESPIRE_CLEAVE);
                uiBladespireClTimer = urand(5*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiBladespireClTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## go_thunderspike
######*/

enum TheThunderspike
{
    NPC_GOR_GRIMGUT     = 21319,
    QUEST_THUNDERSPIKE  = 10526,
};

class go_thunderspike : public GameObjectScript
{
    public:
        go_thunderspike() : GameObjectScript("go_thunderspike") { }

        bool OnGossipHello(Player* player, GameObject* go) OVERRIDE
        {
            if (player->GetQuestStatus(QUEST_THUNDERSPIKE) == QUEST_STATUS_INCOMPLETE && !go->FindNearestCreature(NPC_GOR_GRIMGUT, 25.0f, true))
                if (Creature* gorGrimgut = go->SummonCreature(NPC_GOR_GRIMGUT, -2413.4f, 6914.48f, 25.01f, 3.67f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 300000))
                    gorGrimgut->AI()->AttackStart(player);

            return true;
        }
};

enum SimonGame
{
    NPC_SIMON_BUNNY                 = 22923,
    NPC_APEXIS_GUARDIAN             = 22275,

    GO_APEXIS_RELIC                 = 185890,
    GO_APEXIS_MONUMENT              = 185944,
    GO_AURA_BLUE                    = 185872,
    GO_AURA_GREEN                   = 185873,
    GO_AURA_RED                     = 185874,
    GO_AURA_YELLOW                  = 185875,

    GO_BLUE_CLUSTER_DISPLAY         = 7369,
    GO_GREEN_CLUSTER_DISPLAY        = 7371,
    GO_RED_CLUSTER_DISPLAY          = 7373,
    GO_YELLOW_CLUSTER_DISPLAY       = 7375,
    GO_BLUE_CLUSTER_DISPLAY_LARGE   = 7364,
    GO_GREEN_CLUSTER_DISPLAY_LARGE  = 7365,
    GO_RED_CLUSTER_DISPLAY_LARGE    = 7366,
    GO_YELLOW_CLUSTER_DISPLAY_LARGE = 7367,

    SPELL_PRE_GAME_BLUE             = 40176,
    SPELL_PRE_GAME_GREEN            = 40177,
    SPELL_PRE_GAME_RED              = 40178,
    SPELL_PRE_GAME_YELLOW           = 40179,
    SPELL_VISUAL_BLUE               = 40244,
    SPELL_VISUAL_GREEN              = 40245,
    SPELL_VISUAL_RED                = 40246,
    SPELL_VISUAL_YELLOW             = 40247,

    SOUND_BLUE                      = 11588,
    SOUND_GREEN                     = 11589,
    SOUND_RED                       = 11590,
    SOUND_YELLOW                    = 11591,
    SOUND_DISABLE_NODE              = 11758,

    SPELL_AUDIBLE_GAME_TICK         = 40391,
    SPELL_VISUAL_START_PLAYER_LEVEL = 40436,
    SPELL_VISUAL_START_AI_LEVEL     = 40387,

    SPELL_BAD_PRESS_TRIGGER         = 41241,
    SPELL_BAD_PRESS_DAMAGE          = 40065,
    SPELL_REWARD_BUFF_1             = 40310,
    SPELL_REWARD_BUFF_2             = 40311,
    SPELL_REWARD_BUFF_3             = 40312,
};

enum SimonEvents
{
    EVENT_SIMON_SETUP_PRE_GAME         = 1,
    EVENT_SIMON_PLAY_SEQUENCE          = 2,
    EVENT_SIMON_RESET_CLUSTERS         = 3,
    EVENT_SIMON_PERIODIC_PLAYER_CHECK  = 4,
    EVENT_SIMON_TOO_LONG_TIME          = 5,
    EVENT_SIMON_GAME_TICK              = 6,
    EVENT_SIMON_ROUND_FINISHED         = 7,

    ACTION_SIMON_CORRECT_FULL_SEQUENCE = 8,
    ACTION_SIMON_WRONG_SEQUENCE        = 9,
    ACTION_SIMON_ROUND_FINISHED        = 10,
};

enum SimonColors
{
    SIMON_BLUE          = 0,
    SIMON_RED           = 1,
    SIMON_GREEN         = 2,
    SIMON_YELLOW        = 3,
    SIMON_MAX_COLORS    = 4,
};

class npc_simon_bunny : public CreatureScript
{
    public:
        npc_simon_bunny() : CreatureScript("npc_simon_bunny") { }

        struct npc_simon_bunnyAI : public ScriptedAI
        {
            npc_simon_bunnyAI(Creature* creature) : ScriptedAI(creature) { }

            bool large;
            bool listening;
            uint8 gameLevel;
            uint8 fails;
            uint8 gameTicks;
            uint64 playerGUID;
            uint32 clusterIds[SIMON_MAX_COLORS];
            float zCoordCorrection;
            float searchDistance;
            EventMap _events;
            std::list<uint8> colorSequence, playableSequence, playerSequence;

            void UpdateAI(uint32 diff)
            {
                _events.Update(diff);

                switch (_events.ExecuteEvent())
                {
                    case EVENT_SIMON_PERIODIC_PLAYER_CHECK:
                        if (!CheckPlayer())
                            ResetNode();
                        else
                            _events.ScheduleEvent(EVENT_SIMON_PERIODIC_PLAYER_CHECK, 2000);
                        break;
                    case EVENT_SIMON_SETUP_PRE_GAME:
                        SetUpPreGame();
                        _events.CancelEvent(EVENT_SIMON_GAME_TICK);
                        _events.ScheduleEvent(EVENT_SIMON_PLAY_SEQUENCE, 1000);
                        break;
                    case EVENT_SIMON_PLAY_SEQUENCE:
                        if (!playableSequence.empty())
                        {
                            PlayNextColor();
                            _events.ScheduleEvent(EVENT_SIMON_PLAY_SEQUENCE, 1500);
                        }
                        else
                        {
                            listening = true;
                            DoCast(SPELL_VISUAL_START_PLAYER_LEVEL);
                            playerSequence.clear();
                            PrepareClusters();
                            gameTicks = 0;
                            _events.ScheduleEvent(EVENT_SIMON_GAME_TICK, 3000);
                        }
                        break;
                    case EVENT_SIMON_GAME_TICK:
                        DoCast(SPELL_AUDIBLE_GAME_TICK);

                        if (gameTicks > gameLevel)
                            _events.ScheduleEvent(EVENT_SIMON_TOO_LONG_TIME, 500);
                        else
                            _events.ScheduleEvent(EVENT_SIMON_GAME_TICK, 3000);
                        gameTicks++;
                        break;
                    case EVENT_SIMON_RESET_CLUSTERS:
                        PrepareClusters(true);
                        break;
                    case EVENT_SIMON_TOO_LONG_TIME:
                        DoAction(ACTION_SIMON_WRONG_SEQUENCE);
                        break;
                    case EVENT_SIMON_ROUND_FINISHED:
                        DoAction(ACTION_SIMON_ROUND_FINISHED);
                        break;
                }
            }

            void DoAction(int32 action)
            {
                switch (action)
                {
                    case ACTION_SIMON_ROUND_FINISHED:
                        listening = false;
                        DoCast(SPELL_VISUAL_START_AI_LEVEL);
                        GiveRewardForLevel(gameLevel);
                        _events.CancelEventGroup(0);
                        if (gameLevel == 10)
                            ResetNode();
                        else
                            _events.ScheduleEvent(EVENT_SIMON_SETUP_PRE_GAME, 1000);
                        break;
                    case ACTION_SIMON_CORRECT_FULL_SEQUENCE:
                        gameLevel++;
                        DoAction(ACTION_SIMON_ROUND_FINISHED);
                        break;
                    case ACTION_SIMON_WRONG_SEQUENCE:
                        GivePunishment();
                        DoAction(ACTION_SIMON_ROUND_FINISHED);
                        break;
                }
            }

            // Called by color clusters script (go_simon_cluster) and used for knowing the button pressed by player
            void SetData(uint32 type, uint32 /*data*/)
            {
                if (!listening)
                    return;

                uint8 pressedColor = SIMON_MAX_COLORS;

                if (type == clusterIds[SIMON_RED])
                    pressedColor = SIMON_RED;
                else if (type == clusterIds[SIMON_BLUE])
                    pressedColor = SIMON_BLUE;
                else if (type == clusterIds[SIMON_GREEN])
                    pressedColor = SIMON_GREEN;
                else if (type == clusterIds[SIMON_YELLOW])
                    pressedColor = SIMON_YELLOW;

                PlayColor(pressedColor);
                playerSequence.push_back(pressedColor);
                _events.ScheduleEvent(EVENT_SIMON_RESET_CLUSTERS, 500);
                CheckPlayerSequence();
            }

            // Used for getting involved player guid. Parameter id is used for defining if is a large(Monument) or small(Relic) node
            void SetGUID(uint64 guid, int32 id)
            {
                me->SetCanFly(true);

                large = (bool)id;
                playerGUID = guid;
                StartGame();
            }

            /*
            Resets all variables and also find the ids of the four closests color clusters, since every simon
            node have diferent ids for clusters this is absolutely NECESSARY.
            */
            void StartGame()
            {
                listening = false;
                gameLevel = 0;
                fails = 0;
                gameTicks = 0;
                zCoordCorrection = large ? 8.0f : 2.75f;
                searchDistance = large ? 13.0f : 5.0f;
                colorSequence.clear();
                playableSequence.clear();
                playerSequence.clear();
                me->SetObjectScale(large ? 2.0f : 1.0f);

                std::list<WorldObject*> ClusterList;
                Trinity::AllWorldObjectsInRange objects(me, searchDistance);
                Trinity::WorldObjectListSearcher<Trinity::AllWorldObjectsInRange> searcher(me, ClusterList, objects);
                me->VisitNearbyObject(searchDistance, searcher);

                for (std::list<WorldObject*>::const_iterator i = ClusterList.begin(); i != ClusterList.end(); ++i)
                {
                    if (GameObject* go = (*i)->ToGameObject())
                    {
                        // We are checking for displayid because all simon nodes have 4 clusters with different entries
                        if (large)
                        {
                            switch (go->GetGOInfo()->displayId)
                            {
                                case GO_BLUE_CLUSTER_DISPLAY_LARGE:
                                    clusterIds[SIMON_BLUE] = go->GetEntry();
                                    break;

                                case GO_RED_CLUSTER_DISPLAY_LARGE:
                                    clusterIds[SIMON_RED] = go->GetEntry();
                                    break;

                                case GO_GREEN_CLUSTER_DISPLAY_LARGE:
                                    clusterIds[SIMON_GREEN] = go->GetEntry();
                                    break;

                                case GO_YELLOW_CLUSTER_DISPLAY_LARGE:
                                    clusterIds[SIMON_YELLOW] = go->GetEntry();
                                    break;
                            }
                        }
                        else
                        {
                            switch (go->GetGOInfo()->displayId)
                            {
                                case GO_BLUE_CLUSTER_DISPLAY:
                                    clusterIds[SIMON_BLUE] = go->GetEntry();
                                    break;

                                case GO_RED_CLUSTER_DISPLAY:
                                    clusterIds[SIMON_RED] = go->GetEntry();
                                    break;

                                case GO_GREEN_CLUSTER_DISPLAY:
                                    clusterIds[SIMON_GREEN] = go->GetEntry();
                                    break;

                                case GO_YELLOW_CLUSTER_DISPLAY:
                                    clusterIds[SIMON_YELLOW] = go->GetEntry();
                                    break;
                            }
                        }
                    }
                }

                _events.Reset();
                _events.ScheduleEvent(EVENT_SIMON_ROUND_FINISHED, 1000);
                _events.ScheduleEvent(EVENT_SIMON_PERIODIC_PLAYER_CHECK, 2000);

                if (GameObject* relic = me->FindNearestGameObject(large ? GO_APEXIS_MONUMENT : GO_APEXIS_RELIC, searchDistance))
                    relic->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
            }

            // Called when despawning the bunny. Sets all the node GOs to their default states.
            void ResetNode()
            {
                DoPlaySoundToSet(me, SOUND_DISABLE_NODE);

                for (uint32 clusterId = SIMON_BLUE; clusterId < SIMON_MAX_COLORS; clusterId++)
                    if (GameObject* cluster = me->FindNearestGameObject(clusterIds[clusterId], searchDistance))
                        cluster->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);

                for (uint32 auraId = GO_AURA_BLUE; auraId <= GO_AURA_YELLOW; auraId++)
                    if (GameObject* auraGo = me->FindNearestGameObject(auraId, searchDistance))
                        auraGo->RemoveFromWorld();

                if (GameObject* relic = me->FindNearestGameObject(large ? GO_APEXIS_MONUMENT : GO_APEXIS_RELIC, searchDistance))
                    relic->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);

                me->DespawnOrUnsummon(1000);
            }

            /*
            Called on every button click of player. Adds the clicked color to the player created sequence and
            checks if it corresponds to the AI created sequence. If so, incremente gameLevel and start a new
            round, if not, give punishment and restart current level.
            */
            void CheckPlayerSequence()
            {
                bool correct = true;
                if (playerSequence.size() <= colorSequence.size())
                    for (std::list<uint8>::const_iterator i = playerSequence.begin(), j = colorSequence.begin(); i != playerSequence.end(); ++i, ++j)
                        if ((*i) != (*j))
                            correct = false;

                if (correct && (playerSequence.size() == colorSequence.size()))
                    DoAction(ACTION_SIMON_CORRECT_FULL_SEQUENCE);
                else if (!correct)
                    DoAction(ACTION_SIMON_WRONG_SEQUENCE);
            }

            /*
            Generates a random sequence of colors depending on the gameLevel. We also copy this sequence to
            the playableSequence wich will be used when playing the sequence to the player.
            */
            void GenerateColorSequence()
            {
                colorSequence.clear();
                for (uint8 i = 0; i <= gameLevel; i++)
                    colorSequence.push_back(RAND(SIMON_BLUE, SIMON_RED, SIMON_GREEN, SIMON_YELLOW));

                for (std::list<uint8>::const_iterator i = colorSequence.begin(); i != colorSequence.end(); ++i)
                    playableSequence.push_back(*i);
            }


            // Remove any existant glowing auras over clusters and set clusters ready for interating with them.
            void PrepareClusters(bool clustersOnly = false)
            {
                for (uint32 clusterId = SIMON_BLUE; clusterId < SIMON_MAX_COLORS; clusterId++)
                    if (GameObject* cluster = me->FindNearestGameObject(clusterIds[clusterId], searchDistance))
                        cluster->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);

                if (clustersOnly)
                    return;

                for (uint32 auraId = GO_AURA_BLUE; auraId <= GO_AURA_YELLOW; auraId++)
                    if (GameObject* auraGo = me->FindNearestGameObject(auraId, searchDistance))
                        auraGo->RemoveFromWorld();
            }

            /*
            Called when AI is playing the sequence for player. We cast the visual spell and then remove the
            casted color from the casting sequence.
            */
            void PlayNextColor()
            {
                PlayColor(*playableSequence.begin());
                playableSequence.erase(playableSequence.begin());
            }

            // Casts a spell and plays a sound depending on parameter color.
            void PlayColor(uint8 color)
            {
                switch (color)
                {
                    case SIMON_BLUE:
                        DoCast(SPELL_VISUAL_BLUE);
                        DoPlaySoundToSet(me, SOUND_BLUE);
                        break;
                    case SIMON_GREEN:
                        DoCast(SPELL_VISUAL_GREEN);
                        DoPlaySoundToSet(me, SOUND_GREEN);
                        break;
                    case SIMON_RED:
                        DoCast(SPELL_VISUAL_RED);
                        DoPlaySoundToSet(me, SOUND_RED);
                        break;
                    case SIMON_YELLOW:
                        DoCast(SPELL_VISUAL_YELLOW);
                        DoPlaySoundToSet(me, SOUND_YELLOW);
                        break;
                }
            }

            /*
            Creates the transparent glowing auras on every cluster of this node.
            After calling this function bunny is teleported to the center of the node.
            */
            void SetUpPreGame()
            {
                for (uint32 clusterId = SIMON_BLUE; clusterId < SIMON_MAX_COLORS; clusterId++)
                {
                    if (GameObject* cluster = me->FindNearestGameObject(clusterIds[clusterId], 2.0f*searchDistance))
                    {
                        cluster->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);

                        // break since we don't need glowing auras for large clusters
                        if (large)
                            break;

                        float x, y, z, o;
                        cluster->GetPosition(x, y, z, o);
                        me->NearTeleportTo(x, y, z, o);

                        uint32 preGameSpellId;
                        if (cluster->GetEntry() == clusterIds[SIMON_RED])
                            preGameSpellId = SPELL_PRE_GAME_RED;
                        else if (cluster->GetEntry() == clusterIds[SIMON_BLUE])
                            preGameSpellId = SPELL_PRE_GAME_BLUE;
                        else if (cluster->GetEntry() == clusterIds[SIMON_GREEN])
                            preGameSpellId = SPELL_PRE_GAME_GREEN;
                        else if (cluster->GetEntry() == clusterIds[SIMON_YELLOW])
                            preGameSpellId = SPELL_PRE_GAME_YELLOW;
                        else break;

                        me->CastSpell(cluster, preGameSpellId, true);
                    }
                }

                if (GameObject* relic = me->FindNearestGameObject(large ? GO_APEXIS_MONUMENT : GO_APEXIS_RELIC, searchDistance))
                {
                    float x, y, z, o;
                    relic->GetPosition(x, y, z, o);
                    me->NearTeleportTo(x, y, z + zCoordCorrection, o);
                }

                GenerateColorSequence();
            }

            // Handles the spell rewards. The spells also have the QuestCompleteEffect, so quests credits are working.
            void GiveRewardForLevel(uint8 level)
            {
                uint32 rewSpell = 0;
                switch (level)
                {
                    case 6:
                        if (large)
                            GivePunishment();
                        else
                            rewSpell = SPELL_REWARD_BUFF_1;
                        break;
                    case 8:
                        rewSpell = SPELL_REWARD_BUFF_2;
                        break;
                    case 10:
                        rewSpell = SPELL_REWARD_BUFF_3;
                        break;
                }

                if (rewSpell)
                    if (Player* player = ObjectAccessor::GetPlayer(*me, playerGUID))
                        DoCast(player, rewSpell, true);
            }

            /*
            Depending on the number of failed pushes for player the damage of the spell scales, so we first
            cast the spell on the target that hits for 50 and shows the visual and then forces the player
            to cast the damaging spell on it self with the modified basepoints.
            4 fails = death.
            On large nodes punishment and reward are the same, summoning the Apexis Guardian.
            */
            void GivePunishment()
            {
                if (large)
                {
                    if (Player* player = ObjectAccessor::GetPlayer(*me, playerGUID))
                        if (Creature* guardian = me->SummonCreature(NPC_APEXIS_GUARDIAN, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() - zCoordCorrection, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 20000))
                            guardian->AI()->AttackStart(player);

                    ResetNode();
                }
                else
                {
                    fails++;

                    if (Player* player = ObjectAccessor::GetPlayer(*me, playerGUID))
                        DoCast(player, SPELL_BAD_PRESS_TRIGGER, true);

                    if (fails >= 4)
                        ResetNode();
                }
            }

            void SpellHitTarget(Unit* target, const SpellInfo* spell)
            {
                // Cast SPELL_BAD_PRESS_DAMAGE with scaled basepoints when the visual hits the target.
                // Need Fix: When SPELL_BAD_PRESS_TRIGGER hits target it triggers spell SPELL_BAD_PRESS_DAMAGE by itself
                // so player gets damage equal to calculated damage  dbc basepoints for SPELL_BAD_PRESS_DAMAGE (~50)
                if (spell->Id == SPELL_BAD_PRESS_TRIGGER)
                {
                    int32 bp = (int32)((float)(fails)*0.33f*target->GetMaxHealth());
                    target->CastCustomSpell(target, SPELL_BAD_PRESS_DAMAGE, &bp, NULL, NULL, true);
                }
            }

            // Checks if player has already die or has get too far from the current node
            bool CheckPlayer()
            {
                if (Player* player = ObjectAccessor::GetPlayer(*me, playerGUID))
                {
                    if (player->isDead())
                        return false;
                    if (player->GetDistance2d(me) >= 2.0f*searchDistance)
                    {
                        GivePunishment();
                        return false;
                    }
                }
                else
                    return false;

                return true;
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_simon_bunnyAI(creature);
        }
};

class go_simon_cluster : public GameObjectScript
{
    public:
        go_simon_cluster() : GameObjectScript("go_simon_cluster") { }

        bool OnGossipHello(Player* player, GameObject* go)
        {
            if (Creature* bunny = go->FindNearestCreature(NPC_SIMON_BUNNY, 12.0f, true))
                bunny->AI()->SetData(go->GetEntry(), 0);

            player->CastSpell(player, go->GetGOInfo()->goober.spellId, true);
            go->AddUse();
            return true;
        }
};

enum ApexisRelic
{
    QUEST_CRYSTALS            = 11025,
    GOSSIP_TEXT_ID            = 10948,

    ITEM_APEXIS_SHARD         = 32569,
    SPELL_TAKE_REAGENTS_SOLO  = 41145,
    SPELL_TAKE_REAGENTS_GROUP = 41146,
};

class go_apexis_relic : public GameObjectScript
{
    public:
        go_apexis_relic() : GameObjectScript("go_apexis_relic") { }

        bool OnGossipHello(Player* player, GameObject* go)
        {
            player->PrepareGossipMenu(go, go->GetGOInfo()->questgiver.gossipID);
            player->SendPreparedGossip(go);
            return true;
        }

        bool OnGossipSelect(Player* player, GameObject* go, uint32 /*sender*/, uint32 /*action*/)
        {
            player->CLOSE_GOSSIP_MENU();

            bool large = (go->GetEntry() == GO_APEXIS_MONUMENT);
            if (player->HasItemCount(ITEM_APEXIS_SHARD, large ? 35 : 1))
            {
                player->CastSpell(player, large ? SPELL_TAKE_REAGENTS_GROUP : SPELL_TAKE_REAGENTS_SOLO, false);

                if (Creature* bunny = player->SummonCreature(NPC_SIMON_BUNNY, go->GetPositionX(), go->GetPositionY(), go->GetPositionZ()))
                    bunny->AI()->SetGUID(player->GetGUID(), large);
            }

            return true;
        }
};

void AddSC_blades_edge_mountains()
{
    new npc_bladespire_ogre();
    new npc_nether_drake();
    new npc_daranelle();
    new npc_overseer_nuaar();
    new npc_saikkal_the_elder();
    new go_legion_obelisk();
    new npc_bloodmaul_brutebane();
    new npc_ogre_brute();
    new go_thunderspike();
    new npc_simon_bunny();
    new go_simon_cluster();
    new go_apexis_relic();
    new npc_bladespire_raptor();
    new npc_bladespire_shaman();
    new npc_bladespire_champion();
    new npc_bladespire_cook();
    new npc_stronglimb_seeproot();
    new npc_bladewing_bloodletter();
    new npc_fey_drake();
    new npc_thunderlord_dire_wolf();
    new npc_summon_vimgol();
    new npc_vimgol_the_vile();
    new npc_the_soulgrinder();
    new npc_sundered_ghost();
    new npc_skulloc_soulgrinder();
    new npc_sundered_spirit();
}
