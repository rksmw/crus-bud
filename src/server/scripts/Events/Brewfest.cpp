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
#include "ScriptedEscortAI.h"
#include "ScriptedFollowerAI.h"
#include "Spell.h"
#include "SpellScript.h"
#include "Vehicle.h"
#include "Group.h"
#include "ScriptMgr.h"
#include "GameEventMgr.h"

/*######
## Brewfest
######*/

enum Brewfest
{
   SPELL_APPLE_TRAP             = 43450,
   SPELL_RACING_RAM             = 42146,
   SPELL_RAM_FATIGUE            = 43052,
   SPELL_CREATE_KEG             = 42414,
   SPELL_HAS_KEG                = 44066,
   SPELL_THROW_KEG              = 43660,
   SPELL_THROW_KEG_PLAYER       = 43662,
   SPELL_WORKING_FOR_THE_MAN    = 43534,
   SPELL_RELAY_RACE_DEBUFF      = 44689,
   SPELL_RENTAL_RACING_RAM      = 43883,
   SPELL_CREATE_TICKETS         = 44501,

   QUEST_THERE_AND_BACK_AGAIN_A = 11122,
   QUEST_THERE_AND_BACK_AGAIN_H = 11412,
   QUEST_BARK_FOR_THE_1         = 11293,
   QUEST_BARK_FOR_THE_2         = 11294,
   QUEST_BARK_FOR_THE_3         = 11407,
   QUEST_BARK_FOR_THE_4         = 11408,

   ITEM_PORTABLE_BREWFEST_KEG   = 33797,

   NPC_DELIVERY_CREDIT          = 24337,
   NPC_FLYNN_FIREBREW           = 24364,
   NPC_BOK_DROPCERTAIN          = 24527,
   NPC_RAM_MASTER_RAY           = 24497,
   NPC_NEILL_RAMSTEIN           = 23558,

   ACHIEV_BREW_OF_THE_MONTH     = 2796,
};

class npc_apple_trap_bunny : public CreatureScript
{
   public:
       npc_apple_trap_bunny() : CreatureScript("npc_apple_trap_bunny") { }

       struct npc_apple_trap_bunnyAI : public ScriptedAI
       {
           npc_apple_trap_bunnyAI(Creature* creature) : ScriptedAI(creature) { }

           void MoveInLineOfSight(Unit* who) OVERRIDE
           {
               if (who && who->ToPlayer() && who->HasAura(SPELL_RACING_RAM) && !who->HasAura(SPELL_APPLE_TRAP) && me->GetDistance(who) < 9.0f)
               {
                   who->RemoveAurasDueToSpell(SPELL_RAM_FATIGUE);
                   who->CastSpell(who, SPELL_APPLE_TRAP, true);
               }
           }
       };

       CreatureAI* GetAI(Creature* creature) const OVERRIDE
       {
           return new npc_apple_trap_bunnyAI(creature);
       }
};

class npc_keg_delivery : public CreatureScript
{
   public:
       npc_keg_delivery() : CreatureScript("npc_keg_delivery") { }

       bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
       {
           if (creature->IsQuestGiver())
               player->PrepareQuestMenu(creature->GetGUID());

           if ((player->GetQuestRewardStatus(QUEST_THERE_AND_BACK_AGAIN_A) ||
               player->GetQuestRewardStatus(QUEST_THERE_AND_BACK_AGAIN_H)) && !player->HasAura(SPELL_RELAY_RACE_DEBUFF))
               player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Gibt es noch mehr zu tun?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

           player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
           return true;
       }

       bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) OVERRIDE
       {
           player->PlayerTalkClass->ClearMenus();

           if (action == GOSSIP_ACTION_INFO_DEF + 1)
           {
               player->CastSpell(player, SPELL_RENTAL_RACING_RAM, true);
               player->CastSpell(player, SPELL_WORKING_FOR_THE_MAN, true);
               creature->AddAura(SPELL_RELAY_RACE_DEBUFF, player);
               player->CLOSE_GOSSIP_MENU();
           }

           return true;
       }

       struct npc_keg_deliveryAI : public ScriptedAI
       {
           npc_keg_deliveryAI(Creature* creature) : ScriptedAI(creature) { }

           void MoveInLineOfSight(Unit* who) OVERRIDE
           {
               if (who && who->ToPlayer() && who->HasAura(SPELL_RACING_RAM) && me->GetDistance(who) < 15.0f &&
                  (who->ToPlayer()->GetQuestStatus(QUEST_THERE_AND_BACK_AGAIN_A) == QUEST_STATUS_INCOMPLETE ||
                   who->ToPlayer()->GetQuestStatus(QUEST_THERE_AND_BACK_AGAIN_H) == QUEST_STATUS_INCOMPLETE ||
                   who->HasAura(SPELL_WORKING_FOR_THE_MAN)))
               {
                   switch (me->GetEntry())
                   {
                       case NPC_FLYNN_FIREBREW:
                       case NPC_BOK_DROPCERTAIN:
                           if (!who->HasAura(SPELL_HAS_KEG))
                           {
                               me->CastSpell(who, SPELL_CREATE_KEG, true);
                               me->CastSpell(who, SPELL_THROW_KEG, true); // visual
                           }
                           break;
                       case NPC_RAM_MASTER_RAY:
                       case NPC_NEILL_RAMSTEIN:
                           if (who->HasAura(SPELL_HAS_KEG))
                           {
                               who->CastSpell(me, SPELL_THROW_KEG_PLAYER, true);
                               who->ToPlayer()->DestroyItemCount(ITEM_PORTABLE_BREWFEST_KEG, 1, true);

                               // rewards
                               if (!who->HasAura(SPELL_WORKING_FOR_THE_MAN))
                                   who->ToPlayer()->KilledMonsterCredit(NPC_DELIVERY_CREDIT, 0);
                               else
                               {
                                   // give 2 tickets
                                   who->CastSpell(who, SPELL_CREATE_TICKETS, true);

                                   // plus 30s ram duration
                                   if (Aura* aura = who->GetAura(SPELL_RENTAL_RACING_RAM))
                                       aura->SetDuration(aura->GetDuration() + 30*IN_MILLISECONDS);
                               }
                           }
                           break;
                   }
               }
           }
       };

       CreatureAI* GetAI(Creature* creature) const OVERRIDE
       {
           return new npc_keg_deliveryAI(creature);
       }
};

class npc_bark_bunny : public CreatureScript
{
   public:
       npc_bark_bunny() : CreatureScript("npc_bark_bunny") { }

       struct npc_bark_bunnyAI : public ScriptedAI
       {
           npc_bark_bunnyAI(Creature* creature) : ScriptedAI(creature) { }

           void MoveInLineOfSight(Unit* who) OVERRIDE
           {
               if (who && who->ToPlayer() && who->HasAura(SPELL_RACING_RAM) && me->GetDistance(who) < 20.0f &&
                  (who->ToPlayer()->GetQuestStatus(QUEST_BARK_FOR_THE_1) == QUEST_STATUS_INCOMPLETE ||
                   who->ToPlayer()->GetQuestStatus(QUEST_BARK_FOR_THE_2) == QUEST_STATUS_INCOMPLETE ||
                   who->ToPlayer()->GetQuestStatus(QUEST_BARK_FOR_THE_3) == QUEST_STATUS_INCOMPLETE ||
                   who->ToPlayer()->GetQuestStatus(QUEST_BARK_FOR_THE_4) == QUEST_STATUS_INCOMPLETE))
               {
                   who->ToPlayer()->KilledMonsterCredit(me->GetEntry(), 0);
               }
           }
       };

       CreatureAI* GetAI(Creature* creature) const OVERRIDE
       {
           return new npc_bark_bunnyAI(creature);
       }
};

class npc_brew_vendor : public CreatureScript
{
   public:
       npc_brew_vendor() : CreatureScript("npc_brew_vendor") { }

       bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
       {
           if (player->HasAchieved(ACHIEV_BREW_OF_THE_MONTH))
               player->GetSession()->SendListInventory(creature->GetGUID());
           else
               player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

           return true;
       }
};

/*#################
## Dark Iron Event - Brewfest.
####################*/

enum DarkIronAttack
{
    GO_FESTIVE_KEG              = 186183, // .. 186187
    GO_MOLE_MACHINE_WRECKAGE_A  = 189989,
    GO_MOLE_MACHINE_WRECKAGE_H  = 189990,

    NPC_DARK_IRON_GUZZLER       = 23709,
    NPC_DARK_IRON_HERALD        = 24536,

    SPELL_BREWFEST_STUN         = 42435,
    SPELL_MOLE_MACHINE_SPAWN    = 43563,
    SPELL_KEG_MARKER            = 42761,

    SAY_RANDOM                  = 0,
};

class npc_dark_iron_herald : public CreatureScript
{
public:
    npc_dark_iron_herald() : CreatureScript("npc_dark_iron_herald") { }

    struct npc_dark_iron_heraldAI : public ScriptedAI
    {
        npc_dark_iron_heraldAI(Creature* creature) : ScriptedAI(creature), _summons(me)
        {
            me->setActive(true);
            if (me->isDead())
                me->Respawn();
        }

        void Reset() OVERRIDE
        {
            _eventTimer = 5 * MINUTE*IN_MILLISECONDS;
            _spawnTimer = 15 * IN_MILLISECONDS;
            _talkTimer  = (urand(1000, 120000));
        }

        void ResetKegs()
        {
            for (uint32 i = GO_FESTIVE_KEG; i < GO_FESTIVE_KEG + 5; ++i)
            {
                GameObject* keg = me->FindNearestGameObject(i, 100.0f);
                if (keg && keg->GetGoState() == GO_STATE_ACTIVE)
                    keg->SetGoState(GO_STATE_READY);
            }
        }

        GameObject* GetKeg() const
        {
            std::list<GameObject*> tempList;

            // get all valid near kegs
            for (uint32 i = GO_FESTIVE_KEG; i < GO_FESTIVE_KEG + 5; ++i)
            {
                GameObject* keg = me->FindNearestGameObject(i, 100.0f);
                if (keg && keg->GetGoState() != GO_STATE_ACTIVE)
                    tempList.push_back(keg);

            }

            // select a random one
            if (!tempList.empty())
            {
                std::list<GameObject*>::iterator itr = tempList.begin();
                std::advance(itr, urand(0, tempList.size() - 1));
                if (GameObject* keg = *itr)
                    return keg;
            }

            return NULL;
        }

        void JustSummoned(Creature* summon) OVERRIDE
        {
            _summons.Summon(summon);
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            if (_eventTimer <= diff)
            {
                float x, y, z;
                me->GetPosition(x, y, z);
                uint32 area = me->GetAreaId();
                me->SummonGameObject((area == 1) ? GO_MOLE_MACHINE_WRECKAGE_A : GO_MOLE_MACHINE_WRECKAGE_H, x, y, z, 0, 0, 0, 0, 0, 90);

                _summons.DespawnAll();
                ResetKegs();
                me->DisappearAndDie();
                return;
            }
            else
                _eventTimer -= diff;

            if (_talkTimer <= diff)
            {
                me->AI()->Talk(SAY_RANDOM);
                _talkTimer = (urand(44000, 120000));
            }
            else _talkTimer -= diff;

            if (_spawnTimer <= diff)
            {
                Position spawn;
                me->GetRandomNearPosition(spawn, 20.0f);

                if (Creature* guzzler = me->SummonCreature(NPC_DARK_IRON_GUZZLER, spawn))
                {
                    guzzler->SetReactState(REACT_PASSIVE);
                    guzzler->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                    guzzler->CastSpell(guzzler, SPELL_MOLE_MACHINE_SPAWN, true);
                    guzzler->SetVisible(false);

                    if (GameObject* keg = GetKeg())
                    {
                        Position pos;
                        keg->GetNearPosition(pos, 3.0f, keg->GetAngle(me->GetPositionX(), me->GetPositionZ()) - float(M_PI*rand_norm()));
                        guzzler->GetMotionMaster()->MovePoint(1, pos);
                        guzzler->AI()->SetGUID(keg->GetGUID());
                    }
                    else
                    {
                        _summons.DespawnAll();
                        ResetKegs();
                        me->DisappearAndDie();
                    }
                }
                _spawnTimer = urand(1, 4)*IN_MILLISECONDS;
            }
            else
                _spawnTimer -= diff;
        }

    private:
        SummonList _summons;
        uint32 _eventTimer;
        uint32 _spawnTimer;
        uint32 _talkTimer;
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_dark_iron_heraldAI(creature);
    }
};

class npc_dark_iron_guzzler : public CreatureScript
{
public:
    npc_dark_iron_guzzler() : CreatureScript("npc_dark_iron_guzzler") { }

    struct npc_dark_iron_guzzlerAI : public ScriptedAI
    {
        npc_dark_iron_guzzlerAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() OVERRIDE
        {
            _kegGUID        = 0;
            _waitTimer      = 2 * IN_MILLISECONDS;
            _destroyTimer   = 20 * IN_MILLISECONDS;
            _kegReached     = false;
            _waiting        = true;
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_1);
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) OVERRIDE
        {
            if (spell->Id == SPELL_BREWFEST_STUN)
            {
                me->GetMotionMaster()->Clear();
                me->Kill(me);
                me->DespawnOrUnsummon(10 * IN_MILLISECONDS);
                _kegReached = false;
            }
        }

        void SetGUID(uint64 guid, int32 /*id*/ = 0) OVERRIDE
        {
            _kegGUID = guid;
        }

        void MovementInform(uint32 type, uint32 id) OVERRIDE
        {
            if (type != POINT_MOTION_TYPE)
            return;

            if (GameObject* keg = ObjectAccessor::GetGameObject(*me, _kegGUID))
            {
                _kegReached = true;
                me->SetFacingToObject(keg);
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_ATTACK2H_LOOSE);
            }
            else
                me->DespawnOrUnsummon();
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            if (_waiting)
            {
                if (_waitTimer <= diff)
                {
                    _waiting = false;
                    me->SetVisible(true);
                }
                else
                    _waitTimer -= diff;
            }

            if (_kegReached)
            {
                GameObject* keg = ObjectAccessor::GetGameObject(*me, _kegGUID);
                if (!keg || (keg && keg->GetGoState() == GO_STATE_ACTIVE))
                {
                    me->DespawnOrUnsummon();
                    _kegReached = false;
                    return;
                }

                if (_destroyTimer <= diff)
                {
                    keg->SetGoState(GO_STATE_ACTIVE);
                    me->DespawnOrUnsummon();
                    _kegReached = false;
                }
                else
                    _destroyTimer -= diff;
            }
        }

    private:
        uint64 _kegGUID;
        uint32 _destroyTimer;
        uint32 _waitTimer;
        bool _kegReached;
        bool _waiting;
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_dark_iron_guzzlerAI(creature);
    }
};


void AddSC_Brewfest()
{
    new npc_apple_trap_bunny();
    new npc_keg_delivery();
    new npc_bark_bunny();
    new npc_brew_vendor();
    new npc_dark_iron_guzzler();
    new npc_dark_iron_herald();
}
