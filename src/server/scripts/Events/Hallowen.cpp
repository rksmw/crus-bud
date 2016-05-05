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

enum HalloweenData
{
    NPC_STINKY_BOMB_CREDIT              = 15415,

    GO_STINKY_BOMB_FLASK                = 180449,
    GO_STINKY_BOMB_CLOUD                = 180450,

    QUEST_CRASHING_WICKERMAN_FESTIVAL   = 1658,

    SPELL_PIRATE_COSTUME_MALE           = 24708,
    SPELL_PIRATE_COSTUME_FEMALE         = 24709,
    SPELL_NINJA_COSTUME_MALE            = 24711,
    SPELL_NINJA_COSTUME_FEMALE          = 24710,
    SPELL_LEPER_GNOME_COSTUME_MALE      = 24712,
    SPELL_LEPER_GNOME_COSTUME_FEMALE    = 24713,
    SPELL_GHOST_COSTUME_MALE            = 24735,
    SPELL_GHOST_COSTUME_FEMALE          = 24736,

    SPELL_HALLOWEEN_WAND_PIRATE         = 24717,
    SPELL_HALLOWEEN_WAND_NINJA          = 24718,
    SPELL_HALLOWEEN_WAND_LEPER_GNOME    = 24719,
    SPELL_HALLOWEEN_WAND_RANDOM         = 24720,
    SPELL_HALLOWEEN_WAND_SKELETON       = 24724,
    SPELL_HALLOWEEN_WAND_WISP           = 24733,
    SPELL_HALLOWEEN_WAND_GHOST          = 24737,
    SPELL_HALLOWEEN_WAND_BAT            = 24741,

    SPELL_GRIM_VISAGE                   = 24705,

    // Headless Horseman fire event
    NPC_HEADLESS_FIRE                   = 23537,
    NPC_FIRE_DUMMY                      = 23686,
    NPC_SHADE_HORSEMAN                  = 23543,
    GO_FIRE_EFFIGY                      = 186720,
    GO_LARGE_JACK_O_LANTERN             = 186887,

    SPELL_FIRE_CREATE_NODE              = 42118,
    SPELL_WATER_SPOUT_VISUAL            = 42348,
    SPELL_FIRE_VISUAL_BUFF              = 42074,
    SPELL_FIRE_SIZE_STACK               = 42091,
    SPELL_FIRE_STARTING_SIZE            = 42096,
    SPELL_QUESTS_CREDITS                = 42242,
    SPELL_CREATE_WATER_BUCKET           = 42349,

    SPELL_HORSEMAN_CONFLAGRATION_1      = 42380,
    SPELL_HORSEMAN_CONFLAGRATION_2      = 42869,
    SPELL_HORSEMAN_JACK_O_LANTERN       = 44185,
    SPELL_HORSEMAN_CLEAVE               = 15496,

    SAY_HORSEMAN_SPAWN                  = 1,
    SAY_HORSEMAN_FIRES_OUT              = 2,
    SAY_HORSEMAN_FIRES_FAIL             = 3,
    SAY_HORSEMAN_LAUGHS                 = 4,

    QUEST_LET_THE_FIRES_COME_A          = 12135,
    QUEST_LET_THE_FIRES_COME_H          = 12139,
    QUEST_STOP_FIRES_A                  = 11131,
    QUEST_STOP_FIRES_H                  = 11219,
};

#define FIRE_NODES_PER_AREA  13

const Position FireNodesGoldShire[FIRE_NODES_PER_AREA + 1] =
{
    {-9459.41f, 43.90f, 64.23f, 0.00f},
    {-9472.57f, 41.11f, 64.17f, 0.00f},
    {-9467.22f, 85.86f, 66.20f, 0.00f},
    {-9472.94f, 93.84f, 69.20f, 0.00f},
    {-9462.50f, 103.90f, 68.51f, 0.00f},
    {-9467.84f, 100.69f, 66.12f, 0.00f},
    {-9456.91f, 112.81f, 66.12f, 0.00f},
    {-9478.22f, 41.65f, 69.85f, 0.00f},
    {-9481.30f, 24.87f, 69.08f, 0.00f},
    {-9482.69f, 14.39f, 62.94f, 0.00f},
    {-9471.16f, -6.65f, 70.76f, 0.00f},
    {-9451.26f, 38.83f, 68.02f, 0.00f},
    {-9450.13f, 89.46f, 66.22f, 0.00f},
    {-9464.28f,68.1982f,56.2331f,0.0f},
};

const Position FireNodesRazorHill[FIRE_NODES_PER_AREA+1] =
{
    {372.70f, -4714.64f, 23.11f, 0.00f},
    {343.11f, -4708.87f, 29.19f, 0.00f},
    {332.06f, -4703.21f, 24.52f, 0.00f},
    {317.20f, -4694.22f, 16.78f, 0.00f},
    {326.30f, -4693.24f, 34.59f, 0.00f},
    {281.18f, -4705.37f, 22.38f, 0.00f},
    {293.32f, -4773.45f, 25.03f, 0.00f},
    {280.17f, -4831.90f, 22.25f, 0.00f},
    {319.04f, -4770.23f, 31.47f, 0.00f},
    {362.50f, -4676.11f, 28.63f, 0.00f},
    {348.71f, -4805.08f, 32.23f, 0.00f},
    {342.88f, -4837.07f, 26.29f, 0.00f},
    {361.80f, -4769.27f, 18.49f, 0.00f},
    {317.837f,-4734.06f,9.76272f,0.0f},
};

enum HalloweenFireEvents
{
    EVENT_FIRE_NONE,
    EVENT_FIRE_HIT_BY_BUCKET,
    EVENT_FIRE_VISUAL_WATER,
    EVENT_FIRE_GROW_FIRE,
    EVENT_HORSEMAN_CONFLAGRATION,
    EVENT_HORSEMAN_CLEAVE,
    EVENT_HORSEMAN_LAUGHS,
    EVENT_FIRE_FINISH,
    EVENT_FIRE_FAIL,
};

class spell_halloween_wand : public SpellScriptLoader
{
public:
    spell_halloween_wand() : SpellScriptLoader("spell_halloween_wand") {}

    class spell_halloween_wand_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_halloween_wand_SpellScript);

        bool Validate(SpellInfo const* /*spellEntry*/) OVERRIDE
        {
            if (!sSpellMgr->GetSpellInfo(SPELL_PIRATE_COSTUME_MALE))
                return false;
            if (!sSpellMgr->GetSpellInfo(SPELL_PIRATE_COSTUME_FEMALE))
                return false;
            if (!sSpellMgr->GetSpellInfo(SPELL_NINJA_COSTUME_MALE))
                return false;
            if (!sSpellMgr->GetSpellInfo(SPELL_NINJA_COSTUME_FEMALE))
                return false;
            if (!sSpellMgr->GetSpellInfo(SPELL_LEPER_GNOME_COSTUME_MALE))
                return false;
            if (!sSpellMgr->GetSpellInfo(SPELL_LEPER_GNOME_COSTUME_FEMALE))
                return false;
            if (!sSpellMgr->GetSpellInfo(SPELL_GHOST_COSTUME_MALE))
                return false;
            if (!sSpellMgr->GetSpellInfo(SPELL_GHOST_COSTUME_FEMALE))
                return false;
            if (!sSpellMgr->GetSpellInfo(SPELL_HALLOWEEN_WAND_PIRATE))
                return false;
            if (!sSpellMgr->GetSpellInfo(SPELL_HALLOWEEN_WAND_NINJA))
                return false;
            if (!sSpellMgr->GetSpellInfo(SPELL_HALLOWEEN_WAND_LEPER_GNOME))
                return false;
            if (!sSpellMgr->GetSpellInfo(SPELL_HALLOWEEN_WAND_RANDOM))
                return false;
            if (!sSpellMgr->GetSpellInfo(SPELL_HALLOWEEN_WAND_SKELETON))
                return false;
            if (!sSpellMgr->GetSpellInfo(SPELL_HALLOWEEN_WAND_WISP))
                return false;
            if (!sSpellMgr->GetSpellInfo(SPELL_HALLOWEEN_WAND_GHOST))
                return false;
            if (!sSpellMgr->GetSpellInfo(SPELL_HALLOWEEN_WAND_BAT))
                return false;
            return true;
        }

        void HandleScriptEffect()
        {
            Unit* caster = GetCaster();
            Unit* target = GetHitPlayer();

            if (!caster || !target)
                return;

            uint32 spellId = 0;
            uint8 gender = target->getGender();

            switch (GetSpellInfo()->Id)
            {
                case SPELL_HALLOWEEN_WAND_LEPER_GNOME:
                    spellId = gender ? SPELL_LEPER_GNOME_COSTUME_FEMALE : SPELL_LEPER_GNOME_COSTUME_MALE;
                    break;
                case SPELL_HALLOWEEN_WAND_PIRATE:
                    spellId = gender ? SPELL_PIRATE_COSTUME_FEMALE : SPELL_PIRATE_COSTUME_MALE;
                    break;
                case SPELL_HALLOWEEN_WAND_GHOST:
                    spellId = gender ? SPELL_GHOST_COSTUME_FEMALE : SPELL_GHOST_COSTUME_MALE;
                    break;
                case SPELL_HALLOWEEN_WAND_NINJA:
                    spellId = gender ? SPELL_NINJA_COSTUME_FEMALE : SPELL_NINJA_COSTUME_MALE;
                    break;
                case SPELL_HALLOWEEN_WAND_RANDOM:
                    spellId = RAND(SPELL_HALLOWEEN_WAND_PIRATE, SPELL_HALLOWEEN_WAND_NINJA, SPELL_HALLOWEEN_WAND_LEPER_GNOME, SPELL_HALLOWEEN_WAND_SKELETON, SPELL_HALLOWEEN_WAND_WISP, SPELL_HALLOWEEN_WAND_GHOST, SPELL_HALLOWEEN_WAND_BAT);
                    break;
            }
            caster->CastSpell(target, spellId, true);
        }

        void Register() OVERRIDE
        {
            AfterHit += SpellHitFn(spell_halloween_wand_SpellScript::HandleScriptEffect);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_halloween_wand_SpellScript();
    }
};

class spell_toss_stinky_bomb : public SpellScriptLoader
{
public:
    spell_toss_stinky_bomb() : SpellScriptLoader("spell_toss_stinky_bomb") {}

    class spell_toss_stinky_bomb_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_toss_stinky_bomb_SpellScript);

        void HandleScriptEffect(SpellEffIndex effIndex)
        {
            Unit* caster = GetCaster();

            if (caster && caster->GetTypeId() == TYPEID_PLAYER)
                caster->ToPlayer()->KilledMonsterCredit(NPC_STINKY_BOMB_CREDIT, 0);
        }

        void Register() OVERRIDE
        {
            OnEffectHit += SpellEffectFn(spell_toss_stinky_bomb_SpellScript::HandleScriptEffect, EFFECT_2, SPELL_EFFECT_SEND_EVENT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_toss_stinky_bomb_SpellScript();
    }
};

class spell_clean_stinky_bomb : public SpellScriptLoader
{
public:
    spell_clean_stinky_bomb() : SpellScriptLoader("spell_clean_stinky_bomb") {}

    class spell_clean_stinky_bomb_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_clean_stinky_bomb_SpellScript);

        SpellCastResult CheckIfNearBomb()
        {
            Unit* caster = GetCaster();

            if(GameObject* stinky = GetClosestGameObjectWithEntry(caster, GO_STINKY_BOMB_CLOUD, 15.0f))
                return SPELL_CAST_OK;
            else
                return SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;
        }

        void HandleCleanBombEffect(SpellEffIndex effIndex)
        {
            Unit* caster = GetCaster();

            if (GameObject* stinky = GetClosestGameObjectWithEntry(caster, GO_STINKY_BOMB_CLOUD, 15.0f))
                stinky->RemoveFromWorld();
        }

        void Register() OVERRIDE
        {
            OnCheckCast += SpellCheckCastFn(spell_clean_stinky_bomb_SpellScript::CheckIfNearBomb);
            OnEffectHit += SpellEffectFn(spell_clean_stinky_bomb_SpellScript::HandleCleanBombEffect, EFFECT_1, SPELL_EFFECT_ACTIVATE_OBJECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_clean_stinky_bomb_SpellScript();
    }
};

class at_wickerman_festival : public AreaTriggerScript
{
public:
    at_wickerman_festival() : AreaTriggerScript("at_wickerman_festival") {}

    bool OnTrigger(Player* player, AreaTriggerEntry const* /*trigger*/)
    {
        player->GroupEventHappens(QUEST_CRASHING_WICKERMAN_FESTIVAL, player);
        return true;
    }
};

#define GOSSIP_WICKERMAN_EMBER "Usar las cenizas como pintura de guerra para la cara" //"Smear the ash on my face like war paint!"

class go_wickerman_ember : public GameObjectScript
{
public:
    go_wickerman_ember() : GameObjectScript("go_wickerman_ember") { }

    bool OnGossipHello(Player* player, GameObject* go) OVERRIDE
    {
        if (!player->HasAura(SPELL_GRIM_VISAGE))
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_WICKERMAN_EMBER, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        player->SEND_GOSSIP_MENU(player->GetGossipTextId(go), go->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, GameObject* go, uint32 /*sender*/, uint32 action) OVERRIDE
    {
        if (action == GOSSIP_ACTION_INFO_DEF)
            go->CastSpell(player, SPELL_GRIM_VISAGE);

        player->PlayerTalkClass->ClearMenus();
        player->CLOSE_GOSSIP_MENU();
        return true;
    }
};

class item_water_bucket : public ItemScript
{
public:
    item_water_bucket() : ItemScript("item_water_bucket") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& targets) OVERRIDE
    {
        if (Creature* dummy = player->SummonCreature(NPC_FIRE_DUMMY, targets.GetDstPos()->GetPositionX(), targets.GetDstPos()->GetPositionY(), targets.GetDstPos()->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 500))
        {
            std::list<Creature*> firesList;
            Trinity::AllCreaturesOfEntryInRange checker(dummy, NPC_HEADLESS_FIRE, 3.0f);
            Trinity::CreatureListSearcher<Trinity::AllCreaturesOfEntryInRange> searcher(dummy, firesList, checker);
            player->VisitNearbyObject(3.0f, searcher);

            if (firesList.empty())
            {
                Creature* fire = dummy->FindNearestCreature(NPC_HEADLESS_FIRE, 3.0f, true);
                if (fire && fire->IsAlive())
                    fire->AI()->SetGUID(player->GetGUID(), EVENT_FIRE_HIT_BY_BUCKET);
                else if (Player* friendPlr = dummy->SelectNearestPlayer(3.0f))
                {
                    if (friendPlr->IsFriendlyTo(player) && friendPlr->IsAlive())
                        player->CastSpell(friendPlr, SPELL_CREATE_WATER_BUCKET, true);
                }
                else
                    return false;
            }

            for (std::list<Creature*>::const_iterator i = firesList.begin(); i != firesList.end(); ++i)
                if ((*i) && (*i)->IsAlive())
                    (*i)->AI()->SetGUID(player->GetGUID(), EVENT_FIRE_HIT_BY_BUCKET);
        }
        return false;
    }
};


class npc_halloween_fire : public CreatureScript
{
public:
    npc_halloween_fire() : CreatureScript("npc_halloween_fire") { }

    struct npc_halloween_fireAI : public ScriptedAI
    {
        npc_halloween_fireAI(Creature* c) : ScriptedAI(c) {}

        bool fireEffigy;
        bool off;
        EventMap events;
        uint64 _playerGUID;

        void Reset() OVERRIDE
        {
            off = false;
            fireEffigy = false;
            _playerGUID = 0;
            events.Reset();
            if (me->FindNearestGameObject(GO_FIRE_EFFIGY, 0.5f))
                fireEffigy = true;
            me->CastSpell(me, SPELL_FIRE_STARTING_SIZE, true);
            events.ScheduleEvent(EVENT_FIRE_GROW_FIRE, 1000);
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            events.Update(diff);

            switch(events.ExecuteEvent())
            {
                case EVENT_FIRE_VISUAL_WATER:
                    me->CastSpell(me, SPELL_WATER_SPOUT_VISUAL, true);
                    if (fireEffigy)
                    {
                        if (GameObject* effigy = me->FindNearestGameObject(GO_FIRE_EFFIGY, 0.5f))
                        {
                            effigy->SetGoState(GO_STATE_READY);
                            if (Player* player = me->GetPlayer(*me, _playerGUID))
                                player->KilledMonsterCredit(me->GetEntry(),0);
                            events.ScheduleEvent(EVENT_FIRE_GROW_FIRE, 22000);
                        }
                    }
                    else
                    {
                        if (Aura* fireSize = me->GetAura(SPELL_FIRE_SIZE_STACK))
                        {
                            if (fireSize->GetStackAmount() < 10)
                            {
                                me->RemoveAura(fireSize);
                                me->RemoveAurasDueToSpell(SPELL_FIRE_VISUAL_BUFF);
                                me->DespawnOrUnsummon(1000);
                            } else
                                fireSize->ModStackAmount(-10);
                        }
                    }
                    break;
                case EVENT_FIRE_GROW_FIRE:
                    if (fireEffigy)
                    {
                        if (GameObject* effigy = me->FindNearestGameObject(GO_FIRE_EFFIGY, 0.5f))
                            effigy->SetGoState(GO_STATE_ACTIVE);
                    }
                    else
                    {
                        if (off) break;

                        if (Aura* fireSize = me->GetAura(SPELL_FIRE_SIZE_STACK))
                            if(fireSize->GetStackAmount() == 255) break;

                        if (!me->HasAura(SPELL_FIRE_STARTING_SIZE))
                            me->CastSpell(me, SPELL_FIRE_STARTING_SIZE, true);
                        if (!me->HasAura(SPELL_FIRE_VISUAL_BUFF))
                            me->CastSpell(me, SPELL_FIRE_VISUAL_BUFF, true);
                        me->CastSpell(me, SPELL_FIRE_SIZE_STACK, true);
                        events.ScheduleEvent(EVENT_FIRE_GROW_FIRE, urand(1000,2500));
                    }
                    break;
            }
        }

        void SetGUID(uint64 guid, int32 id) OVERRIDE
        {
            if (off) return;

            if (id == EVENT_FIRE_HIT_BY_BUCKET)
            {
                _playerGUID = guid;
                if (fireEffigy)
                {
                    if (GameObject* effigy = me->FindNearestGameObject(GO_FIRE_EFFIGY, 0.5f))
                        if (effigy->GetGoState() == GO_STATE_ACTIVE)
                            events.ScheduleEvent(EVENT_FIRE_VISUAL_WATER, 1000);
                }
                else
                {
                    if (Creature* horseman = me->GetCreature(*me, me->GetCreatorGUID()))
                        horseman->AI()->SetGUID(_playerGUID, EVENT_FIRE_HIT_BY_BUCKET);
                    events.ScheduleEvent(EVENT_FIRE_VISUAL_WATER, 1000);
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const  OVERRIDE
    {
        return new npc_halloween_fireAI(creature);
    }
};

class npc_shade_horseman : public CreatureScript
{
public:
    npc_shade_horseman() : CreatureScript("npc_shade_horseman") { }

    struct npc_shade_horsemanAI : public ScriptedAI
    {
        npc_shade_horsemanAI(Creature* c) : ScriptedAI(c), fires(c) {}

        SummonList fires;
        EventMap events;
        bool moving;
        bool pointReached;
        bool allFiresSet;
        bool firesOut;
        uint32 wpCount;
        std::list<uint64> _playerList;

        void Reset() OVERRIDE
        {
            moving = true;
            pointReached = true;
            allFiresSet = false;
            firesOut = false;
            wpCount = 0;
            _playerList.clear();
            events.Reset();

            me->SetHealth(4440);
            me->Mount(25159);
            me->SetReactState(REACT_PASSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_DISABLE_MOVE);
            me->AddUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT | MOVEMENTFLAG_DISABLE_GRAVITY);

            events.ScheduleEvent(EVENT_HORSEMAN_LAUGHS, urand(5000, 10000));
            events.ScheduleEvent(EVENT_HORSEMAN_CONFLAGRATION, urand(7000, 14000));
            events.ScheduleEvent(EVENT_FIRE_FAIL, 600000);
        }

        void JustSummoned(Creature* summon) OVERRIDE
        {
            if (!summon)
                return;

            summon->SetCreatorGUID(me->GetGUID());
            fires.Summon(summon);
        }

        void SummonedCreatureDespawn(Creature* summon) OVERRIDE
        {
            if (!summon)
                return;

            fires.Despawn(summon);
        }

        void JustDied(Unit* killer) OVERRIDE
        {
            if (killer && killer->GetAreaId() == me->GetAreaId())
                killer->SummonGameObject(GO_LARGE_JACK_O_LANTERN, me->GetPositionX(), me->GetPositionY(), killer->GetPositionZ()+1.0f, me->GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 180000);
        }

        void MovementInform(uint32 type, uint32 id) OVERRIDE
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (moving && id < FIRE_NODES_PER_AREA)
            {
                if (id == 0 && !allFiresSet)
                {
                    sLog->outError(LOG_FILTER_TSCR,"HEADLESS HORSEMAN BUG TRACKING Area %u.", me->GetAreaId());
                    Talk(SAY_HORSEMAN_SPAWN);
                }

                if (!allFiresSet)
                {
                    const Position pos = GetPositionsForArea()[wpCount];
                    if (pos.IsPositionValid())
                        me->CastSpell(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), SPELL_FIRE_CREATE_NODE, true);
                }

                if (id+1 == FIRE_NODES_PER_AREA)
                {
                    allFiresSet = true;
                    wpCount = 0;
                }
                else
                    ++wpCount;

                pointReached = true;
            }
            else
                if (id == FIRE_NODES_PER_AREA && firesOut)
                {
                    me->ExitVehicle(); //Unmount();
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_DISABLE_MOVE);
                    me->RemoveUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT | MOVEMENTFLAG_DISABLE_GRAVITY);
                    events.ScheduleEvent(EVENT_HORSEMAN_CLEAVE, urand(5000, 10000));
                }
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            events.Update(diff);

            if (!firesOut)
            {
                const Position pos = GetPositionsForArea()[wpCount];

                if (!pos.IsPositionValid())
                    return;

                if (pointReached)
                {
                    pointReached = false;
                    me->GetMotionMaster()->MovePoint(wpCount, pos.GetPositionX(), pos.GetPositionY(), GetZForArea());
                }

                if (allFiresSet && fires.size() <= (uint32)(FIRE_NODES_PER_AREA*0.3f) && wpCount != FIRE_NODES_PER_AREA+1)
                {
                    Talk(SAY_HORSEMAN_FIRES_OUT);
                    wpCount = FIRE_NODES_PER_AREA;
                    me->GetMotionMaster()->MoveIdle();
                    me->GetMotionMaster()->MovePoint(FIRE_NODES_PER_AREA, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ());
                    fires.DespawnAll();
                    firesOut = true;
                    // Credit quest to players
                    if (!_playerList.empty())
                        for (std::list<uint64>::const_iterator i = _playerList.begin();i != _playerList.end(); ++i)
                            if (Player* player = me->GetPlayer(*me, *i))
                                player->CastSpell(player, SPELL_QUESTS_CREDITS, true);
                    return;
                }

                switch(events.ExecuteEvent())
                {
                    case EVENT_FIRE_FAIL:
                        fires.DespawnAll();
                        Talk(SAY_HORSEMAN_FIRES_FAIL);
                        wpCount = FIRE_NODES_PER_AREA+1;
                        me->GetMotionMaster()->MovePoint(wpCount, pos.GetPositionX(), pos.GetPositionY(), GetZForArea());
                        if (!_playerList.empty())
                        {
                            for (std::list<uint64>::const_iterator i = _playerList.begin();i != _playerList.end(); ++i)
                            {
                                Player* player = me->GetPlayer(*me, *i);
                                if (player)
                                {
                                    uint32 questId = player->GetTeam() == ALLIANCE ? QUEST_LET_THE_FIRES_COME_A : QUEST_LET_THE_FIRES_COME_H;
                                    if (player->GetQuestStatus(questId) == QUEST_STATUS_INCOMPLETE)
                                        player->FailQuest(questId);
                                }
                            }
                        }
                        me->DespawnOrUnsummon(10000);
                        break;
                    case EVENT_HORSEMAN_CONFLAGRATION:
                        if (!_playerList.empty())
                        {
                            for (std::list<uint64>::const_iterator i = _playerList.begin();i != _playerList.end(); ++i)
                            {
                                Player* player = me->GetPlayer(*me, *i);
                                if (player && player->GetDistance(me) <= 30.0f)
                                {
                                    me->CastSpell(player, RAND(SPELL_HORSEMAN_CONFLAGRATION_1, SPELL_HORSEMAN_CONFLAGRATION_2, SPELL_HORSEMAN_JACK_O_LANTERN), true);
                                    break;
                                }
                            }
                        }
                        events.ScheduleEvent(EVENT_HORSEMAN_CONFLAGRATION, urand(5000, 10000));
                        break;
                    case EVENT_HORSEMAN_LAUGHS:
                        Talk(SAY_HORSEMAN_LAUGHS);
                        events.ScheduleEvent(EVENT_HORSEMAN_LAUGHS, urand(10000, 25000));
                        break;
                }
            }
            else
            {
                switch(events.ExecuteEvent())
                {
                    case EVENT_HORSEMAN_CLEAVE:
                        if (Unit* victim = me->GetVictim())
                            me->CastSpell(victim, SPELL_HORSEMAN_CLEAVE, true);
                        events.ScheduleEvent(EVENT_HORSEMAN_CLEAVE, urand(5000, 10000));
                        return;
                    case EVENT_HORSEMAN_CONFLAGRATION:
                        if (!_playerList.empty())
                        {
                            for (std::list<uint64>::const_iterator i = _playerList.begin();i != _playerList.end(); ++i)
                            {
                                Player* player = me->GetPlayer(*me, *i);
                                if (player && player->GetAreaId() == me->GetAreaId() && player->GetDistance(me) <= 30.0f)
                                {
                                    me->CastSpell(player, RAND(SPELL_HORSEMAN_CONFLAGRATION_1, SPELL_HORSEMAN_CONFLAGRATION_2, SPELL_HORSEMAN_JACK_O_LANTERN), true);
                                    break;
                                }
                            }
                        }
                        events.ScheduleEvent(EVENT_HORSEMAN_CONFLAGRATION, urand(5000, 10000));
                        break;
                }
                DoMeleeAttackIfReady();
            }
        }

        const Position* GetPositionsForArea()
        {
            switch (me->GetAreaId())
            {
                case 87: //GoldShire
                    return FireNodesGoldShire;
                case 362: // Razor Hill
                case 2337:
                case 14:
                    return FireNodesRazorHill;
            }
            return NULL;
        }

        float GetZForArea()
        {
            switch (me->GetAreaId())
            {
                case 87: //GoldShire
                    return 77.6f;
                case 362: // Razor Hill
                case 2337:
                case 14:
                    return 40.0f;
            }
            return 0.0f;
        }

        void SetGUID(uint64 guid, int32 id)
        {
            if (id == EVENT_FIRE_HIT_BY_BUCKET)
            {
                _playerList.push_back(guid);
                _playerList.unique();
            }

        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_shade_horsemanAI(creature);
    }
};

class npc_halloween_orphan_matron : public CreatureScript
{
public:
    npc_halloween_orphan_matron() : CreatureScript("npc_halloween_orphan_matron") { }

    uint64 _headlessHoresemanGUID;

    bool OnGossipHello(Player* player, Creature* me) OVERRIDE
    {
        player->PrepareQuestMenu(me->GetGUID());

        if (me->GetCreature(*me, _headlessHoresemanGUID))
        {
            QuestMenu &qm = player->PlayerTalkClass->GetQuestMenu();
            QuestMenu qm2;

            uint32 quest1 = player->GetTeam() == ALLIANCE ? QUEST_LET_THE_FIRES_COME_A : QUEST_LET_THE_FIRES_COME_H;
            uint32 quest2 = player->GetTeam() == ALLIANCE ? QUEST_STOP_FIRES_A : QUEST_STOP_FIRES_H;

            // Copy current quest menu ignoring some quests
            for (uint32 i = 0; i<qm.GetMenuItemCount(); ++i)
            {
                if (qm.GetItem(i).QuestId == quest1 || qm.GetItem(i).QuestId == quest2)
                    continue;

                qm2.AddMenuItem(qm.GetItem(i).QuestId, qm.GetItem(i).QuestIcon);
            }

            if (player->GetQuestStatus(quest1) == QUEST_STATUS_NONE)
            {
                if (player->GetQuestStatus(quest2) == QUEST_STATUS_NONE)
                    qm2.AddMenuItem(quest2, 2);
                else if (player->GetQuestStatus(quest2) != QUEST_STATUS_REWARDED)
                    qm2.AddMenuItem(quest2, 4);
            }
            else
                if (player->GetQuestStatus(quest1) != QUEST_STATUS_REWARDED)
                    qm2.AddMenuItem(quest1, 4);

            qm.ClearMenu();

            for (uint32 i = 0; i<qm2.GetMenuItemCount(); ++i)
                qm.AddMenuItem(qm2.GetItem(i).QuestId, qm2.GetItem(i).QuestIcon);
        }

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(me), me->GetGUID());
        return true;
    }

    bool OnQuestAccept(Player* player, Creature* me, Quest const* quest) OVERRIDE
    {
        if (!(me->GetAreaId() == 87 || me->GetAreaId() == 362))
            return true;

        if (quest->GetQuestId() == QUEST_STOP_FIRES_A || quest->GetQuestId() == QUEST_STOP_FIRES_H)
        {
            Creature* horseman = me->GetCreature(*me, _headlessHoresemanGUID);

            if (!horseman)
            {
                sLog->outError(LOG_FILTER_TSCR,"HEADLESS HORSEMAN BUG TRACKING. SUMMON: GUID Player: (" UI64FMTD "). Area %u.", player->GetGUID(), player->GetAreaId());
                if (Creature* horseman = me->SummonCreature(NPC_SHADE_HORSEMAN, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 20.0f, 0, TEMPSUMMON_DEAD_DESPAWN, 180000))
                    _headlessHoresemanGUID = horseman->GetGUID();
            }
        }
        return true;
    }
};


void AddSC_Hallowen()
{
    new spell_toss_stinky_bomb();
    new spell_clean_stinky_bomb();
    new at_wickerman_festival();
    new spell_halloween_wand();
    new go_wickerman_ember();
    new item_water_bucket();
    new npc_halloween_fire();
    new npc_shade_horseman();
    new npc_halloween_orphan_matron();
}
