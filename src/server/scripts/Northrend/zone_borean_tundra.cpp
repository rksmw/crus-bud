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
SDName: Borean_Tundra
SD%Complete: 100
SDComment: Quest support: 11708. Taxi vendors.
SDCategory: Borean Tundra
EndScriptData */

/* ContentData
npc_iruk
npc_corastrasza
npc_jenny
npc_sinkhole_kill_credit
npc_khunok_the_behemoth
npc_nerubar_victim
npc_keristrasza
npc_nesingwary_trapper
npc_lurgglbr
npc_nexus_drake_hatchling
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptedEscortAI.h"
#include "ScriptedFollowerAI.h"
#include "Player.h"
#include "SpellInfo.h"
#include "WorldSession.h"

/*######
## npc_sinkhole_kill_credit
######*/

enum Sinkhole
{
    SPELL_SET_CART                = 46797,
    SPELL_EXPLODE_CART            = 46799,
    SPELL_SUMMON_CART             = 46798,
    SPELL_SUMMON_WORM             = 46800,
};

class npc_sinkhole_kill_credit : public CreatureScript
{
public:
    npc_sinkhole_kill_credit() : CreatureScript("npc_sinkhole_kill_credit") { }

    struct npc_sinkhole_kill_creditAI : public ScriptedAI
    {
        npc_sinkhole_kill_creditAI(Creature* creature) : ScriptedAI(creature){}

        uint32 phaseTimer;
        uint8  phase;
        uint64 casterGuid;

        void Reset() OVERRIDE
        {
            phaseTimer = 1000;
            phase = 0;
            casterGuid = 0;
        }

        void SpellHit(Unit* caster, const SpellInfo* spell) OVERRIDE
        {
            if (spell->Id != SPELL_SET_CART)
                return;

            Player* player = caster->ToPlayer();
            if (player && player->GetQuestStatus(11897) == QUEST_STATUS_INCOMPLETE)
            {
                phase = 1;
                casterGuid = caster->GetGUID();
            }
        }

        void EnterCombat(Unit* /*who*/) OVERRIDE {}

        void UpdateAI(uint32 diff) OVERRIDE
        {
            if (phaseTimer <= diff)
            {
                switch (phase)
                {
                    case 1:
                        DoCast(me, SPELL_EXPLODE_CART, true);
                        DoCast(me, SPELL_SUMMON_CART, true);
                        if (GameObject* cart = me->FindNearestGameObject(188160, 3))
                            cart->SetUInt32Value(GAMEOBJECT_FACTION, 14);
                        phaseTimer = 3000;
                        phase = 2;
                        break;
                    case 2:
                        if (GameObject* cart = me->FindNearestGameObject(188160, 3))
                            cart->UseDoorOrButton();
                        DoCast(me, SPELL_EXPLODE_CART, true);
                        phaseTimer = 3000;
                        phase = 3;
                        break;
                    case 3:
                        DoCast(me, SPELL_EXPLODE_CART, true);
                        phaseTimer = 2000;
                        phase = 5; // @fixme: phase 4 is missing...
                        break;
                    case 5:
                        DoCast(me, SPELL_SUMMON_WORM, true);
                        if (Unit* worm = me->FindNearestCreature(26250, 3))
                        {
                            worm->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                            worm->HandleEmoteCommand(EMOTE_ONESHOT_EMERGE);
                        }
                        phaseTimer = 1000;
                        phase = 6;
                        break;
                    case 6:
                        DoCast(me, SPELL_EXPLODE_CART, true);
                        if (Unit* worm = me->FindNearestCreature(26250, 3))
                        {
                            me->Kill(worm);
                            worm->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                        }
                        phaseTimer = 2000;
                        phase = 7;
                        break;
                    case 7:
                        DoCast(me, SPELL_EXPLODE_CART, true);
                        if (Player* caster = ObjectAccessor::GetPlayer(*me, casterGuid))
                            caster->KilledMonster(me->GetCreatureTemplate(), me->GetGUID());
                        phaseTimer = 5000;
                        phase = 8;
                        break;
                    case 8:
                        EnterEvadeMode();
                        break;
                }
            } else phaseTimer -= diff;

        }

    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_sinkhole_kill_creditAI(creature);
    }
};

/*######
## npc_khunok_the_behemoth
######*/

class npc_khunok_the_behemoth : public CreatureScript
{
public:
    npc_khunok_the_behemoth() : CreatureScript("npc_khunok_the_behemoth") { }

    struct npc_khunok_the_behemothAI : public ScriptedAI
    {
        npc_khunok_the_behemothAI(Creature* creature) : ScriptedAI(creature) {}

        void MoveInLineOfSight(Unit* who) OVERRIDE

        {
            ScriptedAI::MoveInLineOfSight(who);

            if (who->GetTypeId() != TYPEID_UNIT)
                return;

            if (who->GetEntry() == 25861 && me->IsWithinDistInMap(who, 10.0f))
            {
                if (Unit* owner = who->GetOwner())
                {
                    if (owner->GetTypeId() == TYPEID_PLAYER)
                    {
                        owner->CastSpell(owner, 46231, true);
                        who->ToCreature()->DespawnOrUnsummon();
                    }
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_khunok_the_behemothAI(creature);
    }
};

/*######
## npc_keristrasza
######*/

enum Keristrasza
{
    SPELL_TELEPORT_TO_SARAGOSA = 46772
};

#define GOSSIP_HELLO_KERI   "I am prepared to face Saragosa!"

class npc_keristrasza : public CreatureScript
{
public:
    npc_keristrasza() : CreatureScript("npc_keristrasza") { }

    bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(11957) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_KERI, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action) OVERRIDE
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_INFO_DEF + 1)
        {
            player->CLOSE_GOSSIP_MENU();
            player->CastSpell(player, SPELL_TELEPORT_TO_SARAGOSA, true);
        }

        return true;
    }
};

/*######
## npc_corastrasza
######*/

#define GOSSIP_ITEM_C_1 "I... I think so..."

enum Corastrasza
{
    SPELL_SUMMON_WYRMREST_SKYTALON               = 61240,
    SPELL_WYRMREST_SKYTALON_RIDE_PERIODIC        = 61244,

    QUEST_ACES_HIGH_DAILY                        = 13414,
    QUEST_ACES_HIGH                              = 13413
};

class npc_corastrasza : public CreatureScript
{
public:
    npc_corastrasza() : CreatureScript("npc_corastrasza") { }

    bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_ACES_HIGH) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(QUEST_ACES_HIGH_DAILY) == QUEST_STATUS_INCOMPLETE) //It's the same dragon for both quests.
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_C_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action) OVERRIDE
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_INFO_DEF+1)
        {
            player->CLOSE_GOSSIP_MENU();

            player->CastSpell(player, SPELL_SUMMON_WYRMREST_SKYTALON, true);
            player->CastSpell(player, SPELL_WYRMREST_SKYTALON_RIDE_PERIODIC, true);

        }

        return true;
    }
};

/*######
## npc_iruk
######*/

#define GOSSIP_ITEM_I  "<Search corpse for Issliruk's Totem.>"

enum Iruk
{
    QUEST_SPIRITS_WATCH_OVER_US             = 11961,
    SPELL_CREATURE_TOTEM_OF_ISSLIRUK        = 46816,
    GOSSIP_TEXT_I                           = 12585
};

class npc_iruk : public CreatureScript
{
public:
    npc_iruk() : CreatureScript("npc_iruk") { }

    bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
    {
        if (player->GetQuestStatus(QUEST_SPIRITS_WATCH_OVER_US) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_I, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->PlayerTalkClass->SendGossipMenu(GOSSIP_TEXT_I, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action) OVERRIDE
    {
        player->PlayerTalkClass->ClearMenus();
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                player->CastSpell(player, SPELL_CREATURE_TOTEM_OF_ISSLIRUK, true);
                player->CLOSE_GOSSIP_MENU();
                break;

        }
        return true;
    }
};

/*######
## npc_nerubar_victim
######*/

#define WARSONG_PEON        25270

const uint32 nerubarVictims[3] =
{
    45526, 45527, 45514
};

enum NerubarV
{
    SAY_SPAWNM0 = 0,
    SAY_SPAWNW0 = 0,
    SAY_SPAWNS0 = 0,
};

class npc_nerubar_victim : public CreatureScript
{
public:
    npc_nerubar_victim() : CreatureScript("npc_nerubar_victim") { }

    struct npc_nerubar_victimAI : public ScriptedAI
    {
        npc_nerubar_victimAI(Creature* creature) : ScriptedAI(creature) {}

        void Reset() OVERRIDE
        {
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
        }

        void EnterCombat(Unit* /*who*/) OVERRIDE {}
        void MoveInLineOfSight(Unit* /*who*/) OVERRIDE {}


        void JustDied(Unit* killer) OVERRIDE
        {
            Player* player = killer->ToPlayer();
            if (!player)
                return;

            if (player->GetQuestStatus(11611) == QUEST_STATUS_INCOMPLETE)
            {
                uint8 uiRand = urand(0, 99);
                if (uiRand < 25)
                {
                    player->CastSpell(me, 45532, true);
                    player->KilledMonsterCredit(WARSONG_PEON, 0);
                }
                else if (uiRand < 75)
                {
                    player->CastSpell(me, nerubarVictims[urand(0, 2)], true);

                    if(Creature *creature = me->FindNearestCreature(25420,0.5f,true))
                    {
                        if(creature)
                        {
                            creature->AI()->Talk(SAY_SPAWNM0);
                            creature->CastSpell(creature,45525);
                        }
                    }else
                        if(Creature *creature = me->FindNearestCreature(25414,0.5f,true))
                        {
                            if(creature)
                            {
                                creature->AI()->Talk(SAY_SPAWNW0);
                                creature->CastSpell(creature,45517);
                            }
                        }
                        else if(Creature *creature = me->FindNearestCreature(25421,0.5f,true))
                        {
                            if(creature)
                                creature->AI()->Talk(SAY_SPAWNS0);
                            }
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_nerubar_victimAI(creature);
    }
};

/*######
## npc_jenny
######*/

enum Jenny
{
    QUEST_LOADER_UP             = 11881,

    NPC_FEZZIX_GEARTWIST        = 25849,
    NPC_JENNY                   = 25969,

    SPELL_GIVE_JENNY_CREDIT     = 46358,
    SPELL_CRATES_CARRIED        = 46340,
    SPELL_DROP_CRATE            = 46342
};

class npc_jenny : public CreatureScript
{
public:
    npc_jenny() : CreatureScript("npc_jenny") { }

    struct npc_jennyAI : public ScriptedAI
    {
        npc_jennyAI(Creature* creature) : ScriptedAI(creature) {}

        bool setCrateNumber;

        void Reset() OVERRIDE
        {
            if (!setCrateNumber)
                setCrateNumber = true;

            me->SetSpeed(MOVE_RUN,1.0f,true);
            me->SetReactState(REACT_PASSIVE);

            switch (me->GetOwner()->ToPlayer()->GetTeamId())
            {
                case TEAM_ALLIANCE:
                    me->setFaction(FACTION_ESCORT_A_NEUTRAL_ACTIVE);
                    break;
                default:
                case TEAM_HORDE:
                    me->setFaction(FACTION_ESCORT_H_NEUTRAL_ACTIVE);
                    break;
            }
        }

        void DamageTaken(Unit* /*pDone_by*/, uint32& /*uiDamage*/) OVERRIDE
        {
            DoCast(me, SPELL_DROP_CRATE, true);
        }

        void UpdateAI(uint32 /*diff*/) OVERRIDE
        {
            if (setCrateNumber)
            {
                me->AddAura(SPELL_CRATES_CARRIED, me);
                setCrateNumber = false;
            }

            if (!setCrateNumber && !me->HasAura(SPELL_CRATES_CARRIED))
                me->DisappearAndDie();

            if (!UpdateVictim())
                return;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_jennyAI(creature);
    }
};

/*######
## npc_fezzix_geartwist
######*/

class npc_fezzix_geartwist : public CreatureScript
{
public:
    npc_fezzix_geartwist() : CreatureScript("npc_fezzix_geartwist") { }

    struct npc_fezzix_geartwistAI : public ScriptedAI
    {
        npc_fezzix_geartwistAI(Creature* creature) : ScriptedAI(creature) {}

        void MoveInLineOfSight(Unit* who) OVERRIDE

        {
            ScriptedAI::MoveInLineOfSight(who);

            if (who->GetEntry() != NPC_JENNY || !who->HasAura(SPELL_CRATES_CARRIED))
                return;

            Unit* owner = who->GetOwner();
            if (!owner || !me->IsWithinDistInMap(who, 10.0f))
                return;

            if (Player* player = owner->ToPlayer())
            {
                owner->CastSpell(owner, SPELL_GIVE_JENNY_CREDIT, true); // Maybe is not working.
                player->CompleteQuest(QUEST_LOADER_UP);
                who->ToCreature()->DisappearAndDie();
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_fezzix_geartwistAI(creature);
    }
};

/*######
## npc_nesingwary_trapper
######*/

enum NesingwaryTrapper
{
    GO_HIGH_QUALITY_FUR = 187983,

    GO_CARIBOU_TRAP_1   = 187982,
    GO_CARIBOU_TRAP_2   = 187995,
    GO_CARIBOU_TRAP_3   = 187996,
    GO_CARIBOU_TRAP_4   = 187997,
    GO_CARIBOU_TRAP_5   = 187998,
    GO_CARIBOU_TRAP_6   = 187999,
    GO_CARIBOU_TRAP_7   = 188000,
    GO_CARIBOU_TRAP_8   = 188001,
    GO_CARIBOU_TRAP_9   = 188002,
    GO_CARIBOU_TRAP_10  = 188003,
    GO_CARIBOU_TRAP_11  = 188004,
    GO_CARIBOU_TRAP_12  = 188005,
    GO_CARIBOU_TRAP_13  = 188006,
    GO_CARIBOU_TRAP_14  = 188007,
    GO_CARIBOU_TRAP_15  = 188008,

    SPELL_TRAPPED       = 46104,
};

#define CaribouTrapsNum 15
const uint32 CaribouTraps[CaribouTrapsNum] =
{
    GO_CARIBOU_TRAP_1, GO_CARIBOU_TRAP_2, GO_CARIBOU_TRAP_3, GO_CARIBOU_TRAP_4, GO_CARIBOU_TRAP_5,
    GO_CARIBOU_TRAP_6, GO_CARIBOU_TRAP_7, GO_CARIBOU_TRAP_8, GO_CARIBOU_TRAP_9, GO_CARIBOU_TRAP_10,
    GO_CARIBOU_TRAP_11, GO_CARIBOU_TRAP_12, GO_CARIBOU_TRAP_13, GO_CARIBOU_TRAP_14, GO_CARIBOU_TRAP_15,
};

class npc_nesingwary_trapper : public CreatureScript
{
public:
    npc_nesingwary_trapper() : CreatureScript("npc_nesingwary_trapper") { }

    struct npc_nesingwary_trapperAI : public ScriptedAI
    {
        npc_nesingwary_trapperAI(Creature* creature) : ScriptedAI(creature) { creature->SetVisible(false); }

        uint64 go_caribouGUID;
        uint8  phase;
        uint32 phaseTimer;

        void Reset() OVERRIDE
        {
            me->SetVisible(false);
            phaseTimer = 2500;
            phase = 1;
            go_caribouGUID = 0;
        }

        void EnterCombat(Unit* /*who*/) OVERRIDE {}
        void MoveInLineOfSight(Unit* /*who*/) OVERRIDE {}


        void JustDied(Unit* /*killer*/) OVERRIDE
        {
            if (GameObject* go_caribou = me->GetMap()->GetGameObject(go_caribouGUID))
                go_caribou->SetLootState(GO_JUST_DEACTIVATED);

            if (TempSummon* summon = me->ToTempSummon())
                if (summon->IsSummon())
                    if (Unit* temp = summon->GetSummoner())
                        if (Player* player = temp->ToPlayer())
                            player->KilledMonsterCredit(me->GetEntry(), 0);

            if (GameObject* go_caribou = me->GetMap()->GetGameObject(go_caribouGUID))
                go_caribou->SetGoState(GO_STATE_READY);
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            if (phaseTimer <= diff)
            {
                switch (phase)
                {
                    case 1:
                        me->SetVisible(true);
                        phaseTimer = 2000;
                        phase = 2;
                        break;
                    case 2:
                        if (GameObject* go_fur = me->FindNearestGameObject(GO_HIGH_QUALITY_FUR, 11.0f))
                            me->GetMotionMaster()->MovePoint(0, go_fur->GetPositionX(), go_fur->GetPositionY(), go_fur->GetPositionZ());
                        phaseTimer = 1500;
                        phase = 3;
                        break;
                    case 3:
                        //Talk(SAY_NESINGWARY_1);
                        phaseTimer = 2000;
                        phase = 4;
                        break;
                    case 4:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_LOOT);
                        phaseTimer = 1000;
                        phase = 5;
                        break;
                    case 5:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_NONE);
                        phaseTimer = 500;
                        phase = 6;
                        break;
                    case 6:
                        if (GameObject* go_fur = me->FindNearestGameObject(GO_HIGH_QUALITY_FUR, 11.0f))
                            go_fur->Delete();
                        phaseTimer = 500;
                        phase = 7;
                        break;
                    case 7:
                    {
                        GameObject* go_caribou = NULL;
                        for (uint8 i = 0; i < CaribouTrapsNum; ++i)
                        {
                            go_caribou = me->FindNearestGameObject(CaribouTraps[i], 5.0f);
                            if (go_caribou)
                            {
                                go_caribou->SetGoState(GO_STATE_ACTIVE);
                                go_caribouGUID = go_caribou->GetGUID();
                                break;
                            }
                        }
                        phase = 8;
                        phaseTimer = 1000;
                    }
                    break;
                    case 8:
                        DoCast(me, SPELL_TRAPPED, true);
                        phase = 0;
                        break;
                }
            } else phaseTimer -= diff;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_nesingwary_trapperAI(creature);
    }
};

/*######
## npc_lurgglbr
######*/

enum Lurgglbr
{
    QUEST_ESCAPE_WINTERFIN_CAVERNS      = 11570,

    GO_CAGE                             = 187369,

    FACTION_ESCORTEE_A                  = 774,
    FACTION_ESCORTEE_H                  = 775,

    SAY_START_1                         = 0,
    SAY_START_2                         = 1,
    SAY_END_1                           = 2,
    SAY_END_2                           = 3
};

class npc_lurgglbr : public CreatureScript
{
public:
    npc_lurgglbr() : CreatureScript("npc_lurgglbr") { }

    struct npc_lurgglbrAI : public npc_escortAI
    {
        npc_lurgglbrAI(Creature* creature) : npc_escortAI(creature){}

        uint32 IntroTimer;
        uint32 IntroPhase;

        void Reset() OVERRIDE
        {
            if (!HasEscortState(STATE_ESCORT_ESCORTING))
            {
                IntroTimer = 0;
                IntroPhase = 0;
            }
        }

        void WaypointReached(uint32 waypointId) OVERRIDE
        {
            switch (waypointId)
            {
                case 0:
                    IntroPhase = 1;
                    IntroTimer = 2000;
                    break;
                case 41:
                    IntroPhase = 4;
                    IntroTimer = 2000;
                    break;
            }
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            if (IntroPhase)
            {
                if (IntroTimer <= diff)
                {
                    switch (IntroPhase)
                    {
                        case 1:
                            Talk(SAY_START_1);
                            IntroPhase = 2;
                            IntroTimer = 7500;
                            break;
                        case 2:
                            Talk(SAY_END_1);
                            IntroPhase = 3;
                            IntroTimer = 7500;
                            break;
                        case 3:
                            me->SetReactState(REACT_AGGRESSIVE);
                            IntroPhase = 0;
                            IntroTimer = 0;
                            break;
                        case 4:
                            Talk(SAY_START_2);
                            IntroPhase = 5;
                            IntroTimer = 8000;
                            break;
                        case 5:
                            Talk(SAY_END_2);
                            IntroPhase = 6;
                            IntroTimer = 2500;
                            break;

                        case 6:
                            if (Player* player = GetPlayerForEscort())
                                player->AreaExploredOrEventHappens(QUEST_ESCAPE_WINTERFIN_CAVERNS);
                            IntroPhase = 7;
                            IntroTimer = 2500;
                            break;

                        case 7:
                            me->DespawnOrUnsummon();
                            IntroPhase = 0;
                            IntroTimer = 0;
                            break;
                    }
                } else IntroTimer -= diff;
            }
            npc_escortAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_lurgglbrAI(creature);
    }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) OVERRIDE
    {
        if (quest->GetQuestId() == QUEST_ESCAPE_WINTERFIN_CAVERNS)
        {
            if (GameObject* go = creature->FindNearestGameObject(GO_CAGE, 5.0f))
            {
                go->SetRespawnTime(0);
                go->SetGoType(GAMEOBJECT_TYPE_BUTTON);
                go->UseDoorOrButton(20);
            }

            if (npc_escortAI* pEscortAI = CAST_AI(npc_lurgglbr::npc_lurgglbrAI, creature->AI()))
                pEscortAI->Start(true, false, player->GetGUID());

            switch (player->GetTeam())
            {
                case ALLIANCE:
                    creature->setFaction(FACTION_ESCORTEE_A);
                    break;
                default:
                case HORDE:
                    creature->setFaction(FACTION_ESCORTEE_H);
                    break;
            }

            return true;
        }
        return false;
    }
};

/*######
## npc_nexus_drake_hatchling
######*/

enum NexusDrakeHatchling
{
    SPELL_DRAKE_HARPOON             = 46607,
    SPELL_RED_DRAGONBLOOD           = 46620,
    SPELL_DRAKE_HATCHLING_SUBDUED   = 46691,
    SPELL_SUBDUED                   = 46675,

    NPC_RAELORASZ                   = 26117,

    QUEST_DRAKE_HUNT                = 11919,
    QUEST_DRAKE_HUNT_D              = 11940
};

class npc_nexus_drake_hatchling : public CreatureScript
{
public:
    npc_nexus_drake_hatchling() : CreatureScript("npc_nexus_drake_hatchling") { }

    struct npc_nexus_drake_hatchlingAI : public FollowerAI //The spell who makes the npc follow the player is missing, also we can use FollowerAI!
    {
        npc_nexus_drake_hatchlingAI(Creature* creature) : FollowerAI(creature)
        {
            HarpoonerGUID = 0;
        }

        uint64 HarpoonerGUID;
        bool WithRedDragonBlood;

        void Reset() OVERRIDE
        {
           WithRedDragonBlood = false;
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);
        }

        void SpellHit(Unit* caster, const SpellInfo* spell) OVERRIDE
        {
            if (spell->Id == SPELL_DRAKE_HARPOON && caster->GetTypeId() == TYPEID_PLAYER)
            {
                HarpoonerGUID = caster->GetGUID();
                DoCast(me, SPELL_RED_DRAGONBLOOD, true);
            }
            WithRedDragonBlood = true;
        }

        void MoveInLineOfSight(Unit* who) OVERRIDE

        {
            FollowerAI::MoveInLineOfSight(who);

            if (!HarpoonerGUID)
                return;

            if (me->HasAura(SPELL_SUBDUED) && who->GetEntry() == NPC_RAELORASZ)
            {
                if (me->IsWithinDistInMap(who, INTERACTION_DISTANCE))
                {
                    if (Player* pHarpooner = ObjectAccessor::GetPlayer(*me, HarpoonerGUID))
                    {
                        pHarpooner->KilledMonsterCredit(26175, 0);
                        pHarpooner->RemoveAura(SPELL_DRAKE_HATCHLING_SUBDUED);
                        SetFollowComplete();
                        HarpoonerGUID = 0;
                        me->DisappearAndDie();
                    }
                }
            }
        }

        void UpdateAI(uint32 /*diff*/) OVERRIDE
        {
            if (WithRedDragonBlood && HarpoonerGUID && !me->HasAura(SPELL_RED_DRAGONBLOOD))
            {
                if (Player* pHarpooner = ObjectAccessor::GetPlayer(*me, HarpoonerGUID))
                {
                    EnterEvadeMode();
                    StartFollow(pHarpooner, 35, NULL);

                    DoCast(me, SPELL_SUBDUED, true);
                    pHarpooner->CastSpell(pHarpooner, SPELL_DRAKE_HATCHLING_SUBDUED, true);

                    me->AttackStop();
                    WithRedDragonBlood = false;
                }
            }

            if ((me->getFaction() == 35) && (!me->HasAura(SPELL_SUBDUED)))
            {
                HarpoonerGUID = 0;
                me->DisappearAndDie();
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_nexus_drake_hatchlingAI(creature);
    }
};

/*######
## npc_thassarian
######*/

enum Thassarian
{
    QUEST_LAST_RITES        = 12019,

    SPELL_TRANSFORM_VALANAR = 46753,
    SPELL_STUN              = 46957,
    SPELL_SHADOW_BOLT       = 15537,

    NPC_IMAGE_LICH_KING     = 26203,
    NPC_COUNSELOR_TALBOT    = 25301,
    NPC_PRINCE_VALANAR      = 28189,
    NPC_GENERAL_ARLOS       = 25250,
    NPC_LERYSSA             = 25251,

    SAY_THASSARIAN_1        = 0,
    SAY_THASSARIAN_2        = 1,
    SAY_THASSARIAN_3        = 2,
    SAY_THASSARIAN_4        = 3,
    SAY_THASSARIAN_5        = 4,
    SAY_THASSARIAN_6        = 5,
    SAY_THASSARIAN_7        = 6,

    SAY_TALBOT_1            = 0,
    SAY_TALBOT_2            = 1,
    SAY_TALBOT_3            = 2,
    SAY_TALBOT_4            = 3,

    SAY_LICH_1              = 0,
    SAY_LICH_2              = 1,
    SAY_LICH_3              = 2,

    SAY_ARLOS_1             = 0,
    SAY_ARLOS_2             = 1,

    SAY_LERYSSA_1           = 0,
    SAY_LERYSSA_2           = 1,
    SAY_LERYSSA_3           = 2,
    SAY_LERYSSA_4           = 3
};

#define GOSSIP_ITEM_T   "Let's do this, Thassarian. It's now or never."

class npc_thassarian : public CreatureScript
{
public:
    npc_thassarian() : CreatureScript("npc_thassarian") { }

    struct npc_thassarianAI : public npc_escortAI
    {
        npc_thassarianAI(Creature* creature) : npc_escortAI(creature) {}

        uint64 arthasGUID;
        uint64 talbotGUID;
        uint64 leryssaGUID;
        uint64 arlosGUID;

        bool arthasInPosition;
        bool arlosInPosition;
        bool leryssaInPosition;
        bool talbotInPosition;

        uint32 phase;
        uint32 phaseTimer;

        void Reset() OVERRIDE
        {
            me->RestoreFaction();
            me->RemoveStandFlags(UNIT_STAND_STATE_SIT);

            arthasGUID = 0;
            talbotGUID = 0;
            leryssaGUID = 0;
            arlosGUID = 0;

            arthasInPosition = false;
            arlosInPosition = false;
            leryssaInPosition = false;
            talbotInPosition = false;

            phase = 0;
            phaseTimer = 0;
        }

        void WaypointReached(uint32 waypointId) OVERRIDE
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 3:
                    SetEscortPaused(true);
                    if (Creature* arthas = me->SummonCreature(NPC_IMAGE_LICH_KING, 3730.313f, 3518.689f, 473.324f, 1.562f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 120000))
                    {
                        arthasGUID = arthas->GetGUID();
                        arthas->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                        arthas->SetReactState(REACT_PASSIVE);
                        arthas->SetWalk(true);
                        arthas->GetMotionMaster()->MovePoint(0, 3737.374756f, 3564.841309f, 477.433014f);
                    }
                    if (Creature* talbot = me->SummonCreature(NPC_COUNSELOR_TALBOT, 3747.23f, 3614.936f, 473.321f, 4.462012f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 120000))
                    {
                        talbotGUID = talbot->GetGUID();
                        talbot->SetWalk(true);
                        talbot->GetMotionMaster()->MovePoint(0, 3738.000977f, 3568.882080f, 477.433014f);
                    }
                    me->SetWalk(false);
                    break;
                case 4:
                    SetEscortPaused(true);
                    phase = 7;
                    break;
            }
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            npc_escortAI::UpdateAI(uiDiff);

            if (arthasInPosition && talbotInPosition)
            {
                phase = 1;
                arthasInPosition = false;
                talbotInPosition = false;
            }

            if (arlosInPosition && leryssaInPosition)
            {
                arlosInPosition   = false;
                leryssaInPosition = false;
                Talk(SAY_THASSARIAN_1);
                SetEscortPaused(false);
            }

            if (phaseTimer <= uiDiff)
            {
                Creature* talbot = me->GetCreature(*me, talbotGUID);
                Creature* arthas = me->GetCreature(*me, arthasGUID);
                switch (phase)
                {
                    case 1:
                        if (talbot)
                            talbot->SetStandState(UNIT_STAND_STATE_KNEEL);
                        phaseTimer = 3000;
                        ++phase;
                        break;

                    case 2:
                        if (talbot)
                        {
                            talbot->UpdateEntry(NPC_PRINCE_VALANAR, ALLIANCE);
                            talbot->setFaction(14);
                            talbot->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                            talbot->SetReactState(REACT_PASSIVE);
                        }
                        phaseTimer = 5000;
                        ++phase;
                        break;

                    case 3:
                        if (talbot)
                            talbot->AI()->Talk(SAY_TALBOT_1);
                        phaseTimer = 5000;
                        ++phase;
                        break;

                    case 4:
                        if (arthas)
                            arthas->AI()->Talk(SAY_LICH_1);
                        phaseTimer = 5000;
                        ++phase;
                        break;

                    case 5:
                        if (talbot)
                            talbot->AI()->Talk(SAY_TALBOT_2);
                        phaseTimer = 5000;
                        ++phase;
                        break;

                    case 6:
                        if (Creature* arlos = me->SummonCreature(NPC_GENERAL_ARLOS, 3745.527100f, 3615.655029f, 473.321533f, 4.447805f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 120000))
                        {
                            arlosGUID = arlos->GetGUID();
                            arlos->SetWalk(true);
                            arlos->GetMotionMaster()->MovePoint(0, 3735.570068f, 3572.419922f, 477.441010f);
                        }
                        if (Creature* leryssa = me->SummonCreature(NPC_LERYSSA, 3749.654541f, 3614.959717f, 473.323486f, 4.524959f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 120000))
                        {
                            leryssaGUID = leryssa->GetGUID();
                            leryssa->SetWalk(false);
                            leryssa->SetReactState(REACT_PASSIVE);
                            leryssa->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                            leryssa->GetMotionMaster()->MovePoint(0, 3741.969971f, 3571.439941f, 477.441010f);
                        }
                        phaseTimer = 2000;
                        phase = 0;
                        break;

                    case 7:
                        Talk(SAY_THASSARIAN_2);
                        phaseTimer = 5000;
                        ++phase;
                        break;

                    case 8:
                        if (arthas && talbot)
                        {
                            arthas->SetInFront(me); //The client doesen't update with the new orientation :l
                            talbot->SetStandState(UNIT_STAND_STATE_STAND);
                            arthas->AI()->Talk(SAY_LICH_2);
                        }
                        phaseTimer = 5000;
                        phase = 9;
                        break;

                   case 9:
                        Talk(SAY_THASSARIAN_3);
                        phaseTimer = 5000;
                        phase = 10;
                        break;

                   case 10:
                        if (talbot)
                            talbot->AI()->Talk(SAY_TALBOT_3);
                        phaseTimer = 5000;
                        phase = 11;
                        break;

                   case 11:
                        if (arthas)
                            arthas->AI()->Talk(SAY_LICH_3);
                        phaseTimer = 5000;
                        phase = 12;
                        break;

                    case 12:
                        if (talbot)
                            talbot->AI()->Talk(SAY_TALBOT_4);
                        phaseTimer = 2000;
                        phase = 13;
                        break;

                    case 13:
                        if (arthas)
                            arthas->RemoveFromWorld();
                        ++phase;
                        break;

                    case 14:
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                        if (talbot)
                        {
                            talbot->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                            talbot->SetReactState(REACT_AGGRESSIVE);
                            talbot->CastSpell(me, SPELL_SHADOW_BOLT, false);
                        }
                        phaseTimer = 1500;
                        ++phase;
                        break;

                    case 15:
                        me->SetReactState(REACT_AGGRESSIVE);
                        AttackStart(talbot);
                        phase = 0;
                        break;

                    case 16:
                        me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                        phaseTimer = 20000;
                        ++phase;
                        break;

                   case 17:
                        if (Creature* leryssa = me->GetCreature(*me, leryssaGUID))
                            leryssa->RemoveFromWorld();
                        if (Creature* arlos= me->GetCreature(*me, arlosGUID))
                            arlos->RemoveFromWorld();
                        if (talbot)
                            talbot->RemoveFromWorld();
                        me->RemoveStandFlags(UNIT_STAND_STATE_SIT);
                        SetEscortPaused(false);
                        phaseTimer = 0;
                        phase = 0;
                }
            } else phaseTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) OVERRIDE
        {
            if (Creature* talbot = me->GetCreature(*me, talbotGUID))
                talbot->RemoveFromWorld();

            if (Creature* leryssa = me->GetCreature(*me, leryssaGUID))
                leryssa->RemoveFromWorld();

            if (Creature* arlos = me->GetCreature(*me, arlosGUID))
                arlos->RemoveFromWorld();

            if (Creature* arthas = me->GetCreature(*me, arthasGUID))
                arthas->RemoveFromWorld();
        }
    };

    bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_LAST_RITES) == QUEST_STATUS_INCOMPLETE && creature->GetAreaId() == 4128)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_T, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) OVERRIDE
    {
        player->PlayerTalkClass->ClearMenus();
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                CAST_AI(npc_escortAI, (creature->AI()))->Start(true, false, player->GetGUID());
                CAST_AI(npc_escortAI, (creature->AI()))->SetMaxPlayerDistance(200.0f);
                break;
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_thassarianAI(creature);
    }
};

/*######
## npc_image_lich_king
######*/

class npc_image_lich_king : public CreatureScript
{
public:
    npc_image_lich_king() : CreatureScript("npc_image_lich_king") { }

    struct npc_image_lich_kingAI : public ScriptedAI
    {
        npc_image_lich_kingAI(Creature* creature) : ScriptedAI(creature) {}

        void Reset() OVERRIDE
        {
            me->RestoreFaction();
        }

        void MovementInform(uint32 uiType, uint32 /*uiId*/) OVERRIDE
        {
            if (uiType != POINT_MOTION_TYPE)
                return;

            if (me->IsSummon())
                if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                    CAST_AI(npc_thassarian::npc_thassarianAI, summoner->ToCreature()->AI())->arthasInPosition = true;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_image_lich_kingAI(creature);
    }
};

/*######
## npc_general_arlos
######*/

class npc_general_arlos : public CreatureScript
{
public:
    npc_general_arlos() : CreatureScript("npc_general_arlos") { }

    struct npc_general_arlosAI : public ScriptedAI
    {
        npc_general_arlosAI(Creature* creature) : ScriptedAI(creature) {}

        void MovementInform(uint32 uiType, uint32 /*uiId*/) OVERRIDE
        {
            if (uiType != POINT_MOTION_TYPE)
                return;

            me->AddUnitState(UNIT_STATE_STUNNED);
            me->CastSpell(me, SPELL_STUN, true);
            if (me->IsSummon())
                if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                    CAST_AI(npc_thassarian::npc_thassarianAI, summoner->ToCreature()->AI())->arlosInPosition = true;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_general_arlosAI(creature);
    }
};

/*######
## npc_counselor_talbot
######*/

enum CounselorTalbot
{
    SPELL_DEFLECTION    = 51009,
    SPELL_SOUL_BLAST    = 50992,
};

class npc_counselor_talbot : public CreatureScript
{
public:
    npc_counselor_talbot() : CreatureScript("npc_counselor_talbot") { }

    struct npc_counselor_talbotAI : public ScriptedAI
    {
        npc_counselor_talbotAI(Creature* creature) : ScriptedAI(creature)
        {
            creature->RestoreFaction();
        }

        uint64 leryssaGUID;
        uint64 arlosGUID;

        bool bCheck;

        uint32 shadowBoltTimer;
        uint32 deflectionTimer;
        uint32 soulBlastTimer;

        void Reset() OVERRIDE
        {
            leryssaGUID         = 0;
            arlosGUID           = 0;
            bCheck              = false;
            shadowBoltTimer   = urand(5000, 12000);
            deflectionTimer   = urand(20000, 25000);
            soulBlastTimer    = urand(12000, 18000);
        }
        void MovementInform(uint32 uiType, uint32 /*uiId*/) OVERRIDE
        {
            if (uiType != POINT_MOTION_TYPE)
                return;

            if (me->IsSummon())
                if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                    CAST_AI(npc_thassarian::npc_thassarianAI, summoner->ToCreature()->AI())->talbotInPosition = true;
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (bCheck)
            {
                if (Creature* leryssa = me->FindNearestCreature(NPC_LERYSSA, 50.0f, true))
                    leryssaGUID = leryssa->GetGUID();
                if (Creature* arlos = me->FindNearestCreature(NPC_GENERAL_ARLOS, 50.0f, true))
                    arlosGUID = arlos->GetGUID();
                bCheck = false;
            }

            if (!UpdateVictim())
                return;

            if (me->GetAreaId() == 4125)
            {
                if (shadowBoltTimer <= uiDiff)
                {
                    DoCastVictim(SPELL_SHADOW_BOLT);
                    shadowBoltTimer = urand(5000, 12000);
                } else shadowBoltTimer -= uiDiff;

                if (deflectionTimer <= uiDiff)
                {
                    DoCastVictim(SPELL_DEFLECTION);
                    deflectionTimer = urand(20000, 25000);
                } else deflectionTimer -= uiDiff;

                if (soulBlastTimer <= uiDiff)
                {
                    DoCastVictim(SPELL_SOUL_BLAST);
                    soulBlastTimer  = urand(12000, 18000);
                } else soulBlastTimer -= uiDiff;
            }

            DoMeleeAttackIfReady();
       }

       void JustDied(Unit* killer) OVERRIDE
       {
            if (!leryssaGUID || !arlosGUID)
                return;

            Creature* leryssa = Unit::GetCreature(*me, leryssaGUID);
            Creature* arlos = Unit::GetCreature(*me, arlosGUID);
            if (!leryssa || !arlos)
                return;

            arlos->AI()->Talk(SAY_ARLOS_1);
            arlos->AI()->Talk(SAY_ARLOS_2);
            leryssa->AI()->Talk(SAY_LERYSSA_1);
            arlos->Kill(arlos, false);
            leryssa->RemoveAura(SPELL_STUN);
            leryssa->ClearUnitState(UNIT_STATE_STUNNED);
            leryssa->SetWalk(false);
            leryssa->GetMotionMaster()->MovePoint(0, 3722.114502f, 3564.201660f, 477.441437f);

            if (Player* player = killer->ToPlayer())
                player->RewardPlayerAndGroupAtEvent(NPC_PRINCE_VALANAR, 0);
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_counselor_talbotAI(creature);
    }
};

/*######
## npc_leryssa
######*/

class npc_leryssa : public CreatureScript
{
public:
    npc_leryssa() : CreatureScript("npc_leryssa") { }

    struct npc_leryssaAI : public ScriptedAI
    {
        npc_leryssaAI(Creature* creature) : ScriptedAI(creature)
        {
            bDone = false;
            phase = 0;
            phaseTimer = 0;

            creature->RemoveStandFlags(UNIT_STAND_STATE_SIT);
        }

        bool bDone;

        uint32 phase;
        uint32 phaseTimer;

        void MovementInform(uint32 type, uint32 /*uiId*/) OVERRIDE
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (!bDone)
            {
                if (Creature* talbot = me->FindNearestCreature(NPC_PRINCE_VALANAR, 50.0f, true))
                    CAST_AI(npc_counselor_talbot::npc_counselor_talbotAI, talbot->GetAI())->bCheck = true;

                me->AddUnitState(UNIT_STATE_STUNNED);
                me->CastSpell(me, SPELL_STUN, true);

                if (me->IsSummon())
                    if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                        CAST_AI(npc_thassarian::npc_thassarianAI, summoner->GetAI())->leryssaInPosition = true;
                bDone = true;
            }
            else
            {
                me->SetStandState(UNIT_STAND_STATE_SIT);
                if (me->IsSummon())
                    if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                    summoner->SetStandState(UNIT_STAND_STATE_SIT);
                phaseTimer = 1500;
                phase = 1;
            }
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            ScriptedAI::UpdateAI(uiDiff);

            if (phaseTimer <= uiDiff)
            {
                switch (phase)
                {
                    case 1:
                        if (me->IsSummon())
                            if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                                if (Creature* thassarian = summoner->ToCreature())
                                    thassarian->AI()->Talk(SAY_THASSARIAN_4);
                        phaseTimer = 5000;
                        ++phase;
                        break;
                    case 2:
                        Talk(SAY_LERYSSA_2);
                        phaseTimer = 5000;
                        ++phase;
                        break;
                    case 3:
                        if (me->IsSummon())
                            if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                                if (Creature* thassarian = summoner->ToCreature())
                                    thassarian->AI()->Talk(SAY_THASSARIAN_5);
                        phaseTimer = 5000;
                        ++phase;
                        break;
                    case 4:
                        Talk(SAY_LERYSSA_3);
                        phaseTimer = 5000;
                        ++phase;
                        break;
                    case 5:
                        if (me->IsSummon())
                            if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                                if (Creature* thassarian = summoner->ToCreature())
                                    thassarian->AI()->Talk(SAY_THASSARIAN_6);
                        phaseTimer = 5000;
                        ++phase;
                        break;

                    case 6:
                        Talk(SAY_LERYSSA_4);
                        phaseTimer = 5000;
                        ++phase;
                        break;
                    case 7:
                        if (me->IsSummon())
                            if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                                if (Creature* thassarian = summoner->ToCreature())
                                {
                                    thassarian->AI()->Talk(SAY_THASSARIAN_7);
                                    CAST_AI(npc_thassarian::npc_thassarianAI, thassarian->GetAI())->phase = 16;
                                }
                        phaseTimer = 5000;
                        phase = 0;
                        break;
                }
            } else phaseTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_leryssaAI(creature);
    }
};

/*######
## npc_beryl_sorcerer
######*/

enum BerylSorcerer
{
    NPC_CAPTURED_BERLY_SORCERER         = 25474,
    NPC_LIBRARIAN_DONATHAN              = 25262,

    SPELL_ARCANE_CHAINS                 = 45611,
    SPELL_COSMETIC_CHAINS               = 54324,
    SPELL_COSMETIC_ENSLAVE_CHAINS_SELF  = 45631,

    SPELL_BLINK = 50648,
    SPELL_FROSTBOLT = 9672,
};

class npc_beryl_sorcerer : public CreatureScript
{
public:
    npc_beryl_sorcerer() : CreatureScript("npc_beryl_sorcerer") { }

    struct npc_beryl_sorcererAI : public FollowerAI
    {
        npc_beryl_sorcererAI(Creature* creature) : FollowerAI(creature) {}

        bool bEnslaved;
        uint32 uiBlinkTimer;
        uint32 uiFrostboltTimer;

        void Reset() OVERRIDE
        {
            me->SetReactState(REACT_AGGRESSIVE);
            bEnslaved = false;
            uiBlinkTimer = urand(8*IN_MILLISECONDS,15*IN_MILLISECONDS);
            uiFrostboltTimer = urand(2*IN_MILLISECONDS,6*IN_MILLISECONDS);
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);
        }

        void SpellHit(Unit* pCaster, const SpellInfo* pSpell) OVERRIDE
        {
            if (pSpell->Id == SPELL_ARCANE_CHAINS && pCaster->GetTypeId() == TYPEID_PLAYER && !HealthAbovePct(50) && !bEnslaved)
            {
                EnterEvadeMode(); //We make sure that the npc is not attacking the player!
                me->SetReactState(REACT_PASSIVE);
                StartFollow(pCaster->ToPlayer(), 0, NULL);
                me->UpdateEntry(NPC_CAPTURED_BERLY_SORCERER, TEAM_NEUTRAL);
                DoCast(me, SPELL_COSMETIC_ENSLAVE_CHAINS_SELF, true);

                if (Player* player = pCaster->ToPlayer())
                    player->KilledMonsterCredit(NPC_CAPTURED_BERLY_SORCERER, 0);

                bEnslaved = true;
            }
        }

        void MoveInLineOfSight(Unit* who) OVERRIDE

        {
            FollowerAI::MoveInLineOfSight(who);

            if (who->GetEntry() == NPC_LIBRARIAN_DONATHAN && me->IsWithinDistInMap(who, INTERACTION_DISTANCE))
            {
                SetFollowComplete();
                me->DisappearAndDie();
            }
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uiFrostboltTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_FROSTBOLT);
                uiFrostboltTimer = urand(2*IN_MILLISECONDS,6*IN_MILLISECONDS);
            }
            else
                uiFrostboltTimer -= uiDiff;

            if (uiBlinkTimer <= uiDiff)
            {
                DoCast(me,SPELL_BLINK);
                uiBlinkTimer = urand(8*IN_MILLISECONDS,15*IN_MILLISECONDS);
            }
            else
                uiBlinkTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_beryl_sorcererAI(creature);
    }
};

/*######
## npc_imprisoned_beryl_sorcerer
######*/
enum ImprisionedBerylSorcerer
{
    SPELL_NEURAL_NEEDLE             = 45634,

    NPC_IMPRISONED_BERYL_SORCERER   = 25478,

    SAY_IMPRISIONED_BERYL_1         = 0,
    SAY_IMPRISIONED_BERYL_2         = 1,
    SAY_IMPRISIONED_BERYL_3         = 2,
    SAY_IMPRISIONED_BERYL_4         = 3,
    SAY_IMPRISIONED_BERYL_5         = 4,
    SAY_IMPRISIONED_BERYL_6         = 5,
    SAY_IMPRISIONED_BERYL_7         = 6
};

class npc_imprisoned_beryl_sorcerer : public CreatureScript
{
public:
    npc_imprisoned_beryl_sorcerer() : CreatureScript("npc_imprisoned_beryl_sorcerer") { }

    struct npc_imprisoned_beryl_sorcererAI : public ScriptedAI
    {
        npc_imprisoned_beryl_sorcererAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 rebuff;

        void Reset() OVERRIDE
        {
            if (me->GetReactState() != REACT_PASSIVE)
                me->SetReactState(REACT_PASSIVE);

            rebuff = 0;
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            UpdateVictim();

            if (rebuff <= diff)
            {
                if (!me->HasAura(SPELL_COSMETIC_ENSLAVE_CHAINS_SELF))
                {
                    DoCast(me, SPELL_COSMETIC_ENSLAVE_CHAINS_SELF);
                }
                rebuff = 180000;
            }
            else
                rebuff -= diff;

            DoMeleeAttackIfReady();
        }

        void EnterCombat(Unit* /*who*/) OVERRIDE
        {
        }

        void SpellHit(Unit* unit, const SpellInfo* spell) OVERRIDE
        {
            if (spell->Id == SPELL_NEURAL_NEEDLE && unit->GetTypeId() == TYPEID_PLAYER)
            {
                if (Player* player = unit->ToPlayer())
                {
                    GotStinged(player->GetGUID());
                }
            }
        }

        void GotStinged(uint64 casterGUID)
        {
            if (Player* caster = ObjectAccessor::GetPlayer(*me, casterGUID))
            {
                uint32 step = caster->GetAuraCount(SPELL_NEURAL_NEEDLE) + 1;
                switch (step)
                {
                    case 1:
                        Talk(SAY_IMPRISIONED_BERYL_1);
                        break;
                    case 2:
                        Talk(SAY_IMPRISIONED_BERYL_2, caster);
                        break;
                    case 3:
                        Talk(SAY_IMPRISIONED_BERYL_3);
                        break;
                    case 4:
                        Talk(SAY_IMPRISIONED_BERYL_4);
                        break;
                    case 5:
                        Talk(SAY_IMPRISIONED_BERYL_5);
                        break;
                    case 6:
                        Talk(SAY_IMPRISIONED_BERYL_6, caster);
                        break;
                    case 7:
                        Talk(SAY_IMPRISIONED_BERYL_7);
                        caster->KilledMonsterCredit(NPC_IMPRISONED_BERYL_SORCERER, 0);
                        break;
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_imprisoned_beryl_sorcererAI(creature);
    }
};

/*######
## npc_mootoo_the_younger
######*/
enum MootooTheYounger
{
    SAY_1                       = 0,
    SAY_2                       = 1,
    SAY_3                       = 2,
    SAY_4                       = 3,
    SAY_5                       = 4,

    NPC_MOOTOO_THE_YOUNGER      = 25504,
    QUEST_ESCAPING_THE_MIST     = 11664
};

class npc_mootoo_the_younger : public CreatureScript
{
public:
    npc_mootoo_the_younger() : CreatureScript("npc_mootoo_the_younger") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) OVERRIDE
    {
        if (quest->GetQuestId() == QUEST_ESCAPING_THE_MIST)
        {
            switch (player->GetTeam())
            {
            case ALLIANCE:
                creature->setFaction(FACTION_ESCORTEE_A);
                break;
            case HORDE:
                creature->setFaction(FACTION_ESCORTEE_H);
                break;
            }
            creature->SetStandState(UNIT_STAND_STATE_STAND);
            creature->AI()->Talk(SAY_1);
            CAST_AI(npc_escortAI, (creature->AI()))->Start(true, false, player->GetGUID());
        }
        return true;
    }

    struct npc_mootoo_the_youngerAI : public npc_escortAI
    {
        npc_mootoo_the_youngerAI(Creature* creature) : npc_escortAI(creature) {}

        void Reset() OVERRIDE
        {
            SetDespawnAtFar(false);
        }

        void JustDied(Unit* /*killer*/) OVERRIDE
        {
            if (Player* player=GetPlayerForEscort())
                player->FailQuest(QUEST_ESCAPING_THE_MIST);
        }

        void WaypointReached(uint32 waypointId) OVERRIDE
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 10:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                    Talk(SAY_2);
                    break;
                case 12:
                    Talk(SAY_3);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LOOT);
                    break;
                case 16:
                    Talk(SAY_4);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                    break;
                case 20:
                    me->SetPhaseMask(1, true);
                    Talk(SAY_5);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                    player->GroupEventHappens(QUEST_ESCAPING_THE_MIST, me);
                    SetRun(true);
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_mootoo_the_youngerAI(creature);
    }
};

/*######
## npc_bonker_togglevolt
######*/

enum BonkerTogglevolt
{
    NPC_BONKER_TOGGLEVOLT   = 25589,
    QUEST_GET_ME_OUTA_HERE  = 11673,

    SAY_BONKER_1            = 0,
    SAY_BONKER_2            = 1
};

class npc_bonker_togglevolt : public CreatureScript
{
public:
    npc_bonker_togglevolt() : CreatureScript("npc_bonker_togglevolt") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) OVERRIDE
    {
        if (quest->GetQuestId() == QUEST_GET_ME_OUTA_HERE)
        {
            creature->SetStandState(UNIT_STAND_STATE_STAND);
            creature->AI()->Talk(SAY_BONKER_2, player);
            CAST_AI(npc_escortAI, (creature->AI()))->Start(true, true, player->GetGUID());
        }
        return true;
    }

    struct npc_bonker_togglevoltAI : public npc_escortAI
    {
        npc_bonker_togglevoltAI(Creature* creature) : npc_escortAI(creature) {}
        uint32 Bonker_agro;

        void Reset() OVERRIDE
        {
            Bonker_agro=0;
            SetDespawnAtFar(false);
        }

        void JustDied(Unit* /*killer*/) OVERRIDE
        {
            if (Player* player = GetPlayerForEscort())
                player->FailQuest(QUEST_GET_ME_OUTA_HERE);
        }

        void UpdateEscortAI(const uint32 /*diff*/) OVERRIDE
        {
            if (GetAttack() && UpdateVictim())
            {
                if (Bonker_agro == 0)
                {
                    Talk(SAY_BONKER_1);
                    Bonker_agro++;
                }
                DoMeleeAttackIfReady();
            }
            else Bonker_agro=0;
        }

        void WaypointReached(uint32 waypointId) OVERRIDE
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 29:
                    player->GroupEventHappens(QUEST_GET_ME_OUTA_HERE, me);
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_bonker_togglevoltAI(creature);
    }
};

/*######
## Help Those That Cannot Help Themselves, Quest 11876
######*/

enum HelpThemselves
{
    QUEST_CANNOT_HELP_THEMSELVES                  =  11876,
    GO_MAMMOTH_TRAP_1                             = 188022,
    GO_MAMMOTH_TRAP_2                             = 188024,
    GO_MAMMOTH_TRAP_3                             = 188025,
    GO_MAMMOTH_TRAP_4                             = 188026,
    GO_MAMMOTH_TRAP_5                             = 188027,
    GO_MAMMOTH_TRAP_6                             = 188028,
    GO_MAMMOTH_TRAP_7                             = 188029,
    GO_MAMMOTH_TRAP_8                             = 188030,
    GO_MAMMOTH_TRAP_9                             = 188031,
    GO_MAMMOTH_TRAP_10                            = 188032,
    GO_MAMMOTH_TRAP_11                            = 188033,
    GO_MAMMOTH_TRAP_12                            = 188034,
    GO_MAMMOTH_TRAP_13                            = 188035,
    GO_MAMMOTH_TRAP_14                            = 188036,
    GO_MAMMOTH_TRAP_15                            = 188037,
    GO_MAMMOTH_TRAP_16                            = 188038,
    GO_MAMMOTH_TRAP_17                            = 188039,
    GO_MAMMOTH_TRAP_18                            = 188040,
    GO_MAMMOTH_TRAP_19                            = 188041,
    GO_MAMMOTH_TRAP_20                            = 188042,
    GO_MAMMOTH_TRAP_21                            = 188043,
    GO_MAMMOTH_TRAP_22                            = 188044,
};

#define MammothTrapsNum 22
const uint32 MammothTraps[MammothTrapsNum] =
{
    GO_MAMMOTH_TRAP_1, GO_MAMMOTH_TRAP_2, GO_MAMMOTH_TRAP_3, GO_MAMMOTH_TRAP_4, GO_MAMMOTH_TRAP_5,
    GO_MAMMOTH_TRAP_6, GO_MAMMOTH_TRAP_7, GO_MAMMOTH_TRAP_8, GO_MAMMOTH_TRAP_9, GO_MAMMOTH_TRAP_10,
    GO_MAMMOTH_TRAP_11, GO_MAMMOTH_TRAP_12, GO_MAMMOTH_TRAP_13, GO_MAMMOTH_TRAP_14, GO_MAMMOTH_TRAP_15,
    GO_MAMMOTH_TRAP_16, GO_MAMMOTH_TRAP_17, GO_MAMMOTH_TRAP_18, GO_MAMMOTH_TRAP_19, GO_MAMMOTH_TRAP_20,
    GO_MAMMOTH_TRAP_21, GO_MAMMOTH_TRAP_22
};

class npc_trapped_mammoth_calf : public CreatureScript
{
public:
    npc_trapped_mammoth_calf() : CreatureScript("npc_trapped_mammoth_calf") { }

    struct npc_trapped_mammoth_calfAI : public ScriptedAI
    {
        npc_trapped_mammoth_calfAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 uiTimer;
        bool bStarted;

        void Reset() OVERRIDE
        {
            uiTimer = 1500;
            bStarted = false;

            GameObject* pTrap = NULL;
            for (uint8 i = 0; i < MammothTrapsNum; ++i)
            {
                pTrap = me->FindNearestGameObject(MammothTraps[i], 11.0f);
                if (pTrap)
                {
                    pTrap->SetGoState(GO_STATE_ACTIVE);
                    return;
                }
            }
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            if (bStarted)
            {
                if (uiTimer <= diff)
                {
                    Position pos;
                    me->GetRandomNearPosition(pos, 10.0f);
                    me->GetMotionMaster()->MovePoint(0, pos);
                    bStarted = false;
                }
                else uiTimer -= diff;
            }
        }

        void DoAction(int32 param) OVERRIDE
        {
            if (param == 1)
                bStarted = true;
        }

        void MovementInform(uint32 uiType, uint32 /*uiId*/) OVERRIDE
        {
            if (uiType != POINT_MOTION_TYPE)
                return;

            me->DisappearAndDie();

            GameObject* pTrap = NULL;
            for (uint8 i = 0; i < MammothTrapsNum; ++i)
            {
                pTrap = me->FindNearestGameObject(MammothTraps[i], 11.0f);
                if (pTrap)
                {
                    pTrap->SetLootState(GO_JUST_DEACTIVATED);
                    return;
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_trapped_mammoth_calfAI(creature);
    }
};

/*######
## Quest 11653: Hah... You're Not So Big Now!
######*/

enum NotSoBig
{
    QUEST_YOU_RE_NOT_SO_BIG_NOW                   = 11653,
    SPELL_AURA_NOTSOBIG_1                         = 45672,
    SPELL_AURA_NOTSOBIG_2                         = 45673,
    SPELL_AURA_NOTSOBIG_3                         = 45677,
    SPELL_AURA_NOTSOBIG_4                         = 45681
};

class npc_magmoth_crusher : public CreatureScript
{
public:
    npc_magmoth_crusher() : CreatureScript("npc_magmoth_crusher") { }

    struct npc_magmoth_crusherAI : public ScriptedAI
    {
        npc_magmoth_crusherAI(Creature* creature) : ScriptedAI(creature) {}

        void JustDied(Unit* killer) OVERRIDE
        {
            Player* player = killer->ToPlayer();
            if (!player)
                return;

            if (player->GetQuestStatus(QUEST_YOU_RE_NOT_SO_BIG_NOW) == QUEST_STATUS_INCOMPLETE &&
                (me->HasAura(SPELL_AURA_NOTSOBIG_1) || me->HasAura(SPELL_AURA_NOTSOBIG_2) ||
                me->HasAura(SPELL_AURA_NOTSOBIG_3) || me->HasAura(SPELL_AURA_NOTSOBIG_4)))
            {
                Quest const* qInfo = sObjectMgr->GetQuestTemplate(QUEST_YOU_RE_NOT_SO_BIG_NOW);
                if (qInfo)
                    player->KilledMonsterCredit(qInfo->RequiredNpcOrGo[0], 0);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_magmoth_crusherAI(creature);
    }
};

/*######
## Quest 11608: Bury Those Cockroaches!
######*/

enum BuryThoseCockroaches
{
    // Quest
    QUEST_BURY_THOSE_COCKROACHES            = 11608,

    // Spells
    SPELL_SEAFORIUM_DEPTH_CHARGE_EXPLOSION  = 45502

};

class npc_seaforium_depth_charge : public CreatureScript
{
public:
    npc_seaforium_depth_charge() : CreatureScript("npc_seaforium_depth_charge") { }

    struct npc_seaforium_depth_chargeAI : public ScriptedAI
    {
        npc_seaforium_depth_chargeAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 uiExplosionTimer;

        void Reset() OVERRIDE
        {
            uiExplosionTimer = urand(5000, 10000);
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            if (uiExplosionTimer < diff)
            {
                DoCast(SPELL_SEAFORIUM_DEPTH_CHARGE_EXPLOSION);
                for (uint8 i = 0; i < 4; ++i)
                {
                    if (Creature* cCredit = me->FindNearestCreature(25402 + i, 10.0f))//25402-25405 credit markers
                    {
                        if (Unit* uOwner = me->GetOwner())
                        {
                            Player* owner = uOwner->ToPlayer();
                            if (owner && owner->GetQuestStatus(QUEST_BURY_THOSE_COCKROACHES) == QUEST_STATUS_INCOMPLETE)
                                owner->KilledMonsterCredit(cCredit->GetEntry(), cCredit->GetGUID());
                        }
                    }
                }
                me->Kill(me);
                return;
            } else uiExplosionTimer -= diff;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_seaforium_depth_chargeAI(creature);
    }
};

/*######
## Help Those That Cannot Help Themselves, Quest 11876
######*/

enum Valiancekeepcannons
{
    GO_VALIANCE_KEEP_CANNON_1                     = 187560,
    GO_VALIANCE_KEEP_CANNON_2                     = 188692
};

class npc_valiance_keep_cannoneer : public CreatureScript
{
public:
    npc_valiance_keep_cannoneer() : CreatureScript("npc_valiance_keep_cannoneer") { }

    struct npc_valiance_keep_cannoneerAI : public ScriptedAI
    {
        npc_valiance_keep_cannoneerAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 uiTimer;

        void Reset() OVERRIDE
        {
            uiTimer = urand(13000, 18000);
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            if (uiTimer <= diff)
            {
                me->HandleEmoteCommand(EMOTE_ONESHOT_KNEEL);
                GameObject* pCannon = me->FindNearestGameObject(GO_VALIANCE_KEEP_CANNON_1, 10);
                if (!pCannon)
                    pCannon = me->FindNearestGameObject(GO_VALIANCE_KEEP_CANNON_2, 10);
                if (pCannon)
                    pCannon->Use(me);
                uiTimer = urand(13000, 18000);
            }
            else uiTimer -= diff;

            if (!UpdateVictim())
                return;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_valiance_keep_cannoneerAI(creature);
    }
};

/*******************************************************
 * npc_warmage_coldarra
 *******************************************************/

enum Spells
{
    SPELL_TRANSITUS_SHIELD_BEAM = 48310
};

enum NPCs
{
    NPC_TRANSITUS_SHIELD_DUMMY   = 27306,
    NPC_WARMAGE_HOLLISTER        = 27906,
    NPC_WARMAGE_CALANDRA         = 27173,
    NPC_WARMAGE_WATKINS          = 27904
};

class npc_warmage_coldarra : public CreatureScript
{
public:
    npc_warmage_coldarra() : CreatureScript("npc_warmage_coldarra") { }

    struct npc_warmage_coldarraAI : public ScriptedAI
    {
        npc_warmage_coldarraAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 m_uiTimer;                 //Timer until recast

        void Reset() OVERRIDE
        {
            m_uiTimer = 0;
        }

        void EnterCombat(Unit* /*who*/) OVERRIDE {}

        void AttackStart(Unit* /*who*/) OVERRIDE {}

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (m_uiTimer <= uiDiff)
            {
                std::list<Creature*> orbList;
                GetCreatureListWithEntryInGrid(orbList, me, NPC_TRANSITUS_SHIELD_DUMMY, 32.0f);

                switch (me->GetEntry())
                {
                    case NPC_WARMAGE_HOLLISTER:
                    {
                        if (!orbList.empty())
                        {
                            for (std::list<Creature*>::const_iterator itr = orbList.begin(); itr != orbList.end(); ++itr)
                            {
                                if (Creature* pOrb = *itr)
                                    if (pOrb->GetPositionY() > 6680)
                                        DoCast(pOrb, SPELL_TRANSITUS_SHIELD_BEAM);
                            }
                        }
                        m_uiTimer = urand(90000, 120000);
                    }
                        break;
                    case NPC_WARMAGE_CALANDRA:
                    {
                        if (!orbList.empty())
                        {
                            for (std::list<Creature*>::const_iterator itr = orbList.begin(); itr != orbList.end(); ++itr)
                            {
                                if (Creature* pOrb = *itr)
                                    if ((pOrb->GetPositionY() < 6680) && (pOrb->GetPositionY() > 6630))
                                        DoCast(pOrb, SPELL_TRANSITUS_SHIELD_BEAM);
                            }
                        }
                        m_uiTimer = urand(90000, 120000);
                    }
                        break;
                    case NPC_WARMAGE_WATKINS:
                    {
                        if (!orbList.empty())
                        {
                            for (std::list<Creature*>::const_iterator itr = orbList.begin(); itr != orbList.end(); ++itr)
                            {
                                if (Creature* pOrb = *itr)
                                    if (pOrb->GetPositionY() < 6630)
                                        DoCast(pOrb, SPELL_TRANSITUS_SHIELD_BEAM);
                            }
                        }
                        m_uiTimer = urand(90000, 120000);
                    }
                        break;
                }
            }
            else m_uiTimer -= uiDiff;

            ScriptedAI::UpdateAI(uiDiff);

            if (!UpdateVictim())
                return;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_warmage_coldarraAI(creature);
    }
};

/*######
## npc_hidden_cultist
######*/

enum HiddenCultist
{
    SPELL_SHROUD_OF_THE_DEATH_CULTIST           = 46077, //not working
    SPELL_RIGHTEOUS_VISION                      = 46078, //player aura

    QUEST_THE_HUNT_IS_ON                        = 11794,

    GOSSIP_TEXT_SALTY_JOHN_THORPE               = 12529,
    GOSSIP_TEXT_GUARD_MITCHELSS                 = 12530,
    GOSSIP_TEXT_TOM_HEGGER                      = 12528,

    NPC_TOM_HEGGER                              = 25827,
    NPC_SALTY_JOHN_THORPE                       = 25248,
    NPC_GUARD_MITCHELLS                         = 25828,

    SAY_HIDDEN_CULTIST_1                        = 0,
    SAY_HIDDEN_CULTIST_2                        = 1,
    SAY_HIDDEN_CULTIST_3                        = 2,
    SAY_HIDDEN_CULTIST_4                        = 3
};

const char* GOSSIP_ITEM_TOM_HEGGER = "What do you know about the Cult of the Damned?";
const char* GOSSIP_ITEM_GUARD_MITCHELLS = "How long have you worked for the Cult of the Damned?";
const char* GOSSIP_ITEM_SALTY_JOHN_THORPE = "I have a reason to believe you're involved in the cultist activity";

class npc_hidden_cultist : public CreatureScript
{
public:
    npc_hidden_cultist() : CreatureScript("npc_hidden_cultist") { }

    struct npc_hidden_cultistAI : public ScriptedAI
    {
        npc_hidden_cultistAI(Creature* creature) : ScriptedAI(creature)
        {
           uiEmoteState = creature->GetUInt32Value(UNIT_NPC_EMOTESTATE);
           uiNpcFlags = creature->GetUInt32Value(UNIT_NPC_FLAGS);
        }

        uint32 uiEmoteState;
        uint32 uiNpcFlags;

        uint32 uiEventTimer;
        uint8 uiEventPhase;

        uint64 uiPlayerGUID;

        void Reset() OVERRIDE
        {
            if (uiEmoteState)
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, uiEmoteState);

            if (uiNpcFlags)
                me->SetUInt32Value(UNIT_NPC_FLAGS, uiNpcFlags);

            uiEventTimer = 0;
            uiEventPhase = 0;

            uiPlayerGUID = 0;

            DoCast(SPELL_SHROUD_OF_THE_DEATH_CULTIST);

            me->RestoreFaction();
        }

        void DoAction(int32 /*iParam*/) OVERRIDE
        {
            me->StopMoving();
            me->SetUInt32Value(UNIT_NPC_FLAGS, 0);
            if (Player* player = ObjectAccessor::GetPlayer(*me, uiPlayerGUID))
                me->SetFacingToObject(player);
            uiEventTimer = 3000;
            uiEventPhase = 1;
        }

        void SetGUID(uint64 uiGuid, int32 /*iId*/) OVERRIDE
        {
            uiPlayerGUID = uiGuid;
        }

        void AttackPlayer()
        {
            me->setFaction(14);
            if (Player* player = ObjectAccessor::GetPlayer(*me, uiPlayerGUID))
                me->AI()->AttackStart(player);
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (uiEventTimer && uiEventTimer <= uiDiff)
            {
                switch (uiEventPhase)
                {
                    case 1:
                        switch (me->GetEntry())
                        {
                            case NPC_SALTY_JOHN_THORPE:
                                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
                                Talk(SAY_HIDDEN_CULTIST_1);
                                uiEventTimer = 5000;
                                uiEventPhase = 2;
                                break;
                            case NPC_GUARD_MITCHELLS:
                                Talk(SAY_HIDDEN_CULTIST_2);
                                uiEventTimer = 5000;
                                uiEventPhase = 2;
                                break;
                            case NPC_TOM_HEGGER:
                                Talk(SAY_HIDDEN_CULTIST_3);
                                uiEventTimer = 5000;
                                uiEventPhase = 2;
                                break;
                        }
                        break;
                    case 2:
                        switch (me->GetEntry())
                        {
                            case NPC_SALTY_JOHN_THORPE:
                                Talk(SAY_HIDDEN_CULTIST_4);
                                if (Player* player = ObjectAccessor::GetPlayer(*me, uiPlayerGUID))
                                    me->SetFacingToObject(player);
                                uiEventTimer = 3000;
                                uiEventPhase = 3;
                                break;
                            case NPC_GUARD_MITCHELLS:
                            case NPC_TOM_HEGGER:
                                AttackPlayer();
                                uiEventPhase = 0;
                                break;
                        }
                        break;
                    case 3:
                        if (me->GetEntry() == NPC_SALTY_JOHN_THORPE)
                        {
                            AttackPlayer();
                            uiEventPhase = 0;
                        }
                        break;
                }
            }else uiEventTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_hidden_cultistAI(creature);
    }

    bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
    {
        uint32 uiGossipText = 0;
        const char* charGossipItem;

        switch (creature->GetEntry())
        {
            case NPC_TOM_HEGGER:
                uiGossipText = GOSSIP_TEXT_TOM_HEGGER;
                charGossipItem = GOSSIP_ITEM_TOM_HEGGER;
                break;
            case NPC_SALTY_JOHN_THORPE:
                uiGossipText = GOSSIP_TEXT_SALTY_JOHN_THORPE;
                charGossipItem = GOSSIP_ITEM_SALTY_JOHN_THORPE;
                break;
            case NPC_GUARD_MITCHELLS:
                uiGossipText = GOSSIP_TEXT_GUARD_MITCHELSS;
                charGossipItem = GOSSIP_ITEM_GUARD_MITCHELLS;
                break;
            default:
                charGossipItem = "";
                return false;
        }

        if (player->HasAura(SPELL_RIGHTEOUS_VISION) && player->GetQuestStatus(QUEST_THE_HUNT_IS_ON) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, charGossipItem, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        if (creature->IsVendor())
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

        player->SEND_GOSSIP_MENU(uiGossipText, creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) OVERRIDE
    {
        player->PlayerTalkClass->ClearMenus();

        if (action == GOSSIP_ACTION_INFO_DEF+1)
        {
            player->CLOSE_GOSSIP_MENU();
            creature->AI()->SetGUID(player->GetGUID());
            creature->AI()->DoAction(1);
        }

        if (action == GOSSIP_ACTION_TRADE)
            player->GetSession()->SendListInventory(creature->GetGUID());

        return true;
    }

};

/*######
## npc_warsong_hold_mage
######*/

enum WarsongHM
{
    SPELL_FIREBALL = 14034,
    SPELL_TELEPORT = 41232,

    SAYMAGE0 = 0,
    SAYMAGE1,
};

class npc_warsong_hold_mage : public CreatureScript
{
public:
    npc_warsong_hold_mage() : CreatureScript("npc_warsong_hold_mage") { }

    struct npc_warsong_hold_mageAI : public FollowerAI
    {
        npc_warsong_hold_mageAI(Creature* creature) : FollowerAI(creature){}

        uint32 uiFireBallTimer;
        uint32 uiDespawnMageTimer;
        uint32 uiSpawnTimer;
        bool ok;

        void Reset() OVERRIDE
        {
            ok = false;
            uiDespawnMageTimer = 62*IN_MILLISECONDS;
            uiFireBallTimer = urand(2*IN_MILLISECONDS,4*IN_MILLISECONDS);
            uiSpawnTimer = 1500;
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (uiDespawnMageTimer <= uiDiff)
            {
                if(!ok)
                {
                    Talk(SAYMAGE1);
                    me->HandleEmoteCommand(EMOTE_STATE_TALK);
                    ok=true;
                    me->DespawnOrUnsummon(5000);
                }else
                    DoCast(me,SPELL_TELEPORT);

                uiDespawnMageTimer = 4*IN_MILLISECONDS;
            }
            else
                uiDespawnMageTimer -= uiDiff;

            if (me->IsNonMeleeSpellCasted(false))
                return;

            if (uiFireBallTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_FIREBALL);
                uiFireBallTimer = urand(3*IN_MILLISECONDS,5*IN_MILLISECONDS);
            }
            else
                uiFireBallTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_warsong_hold_mageAI(creature);
    }
};

/*######
## npc_warsong_hold_warrior
######*/

enum WarsongHW
{
    SPELL_CLEAVE = 15284,

    SAYWARRIOR1 = 0,
    SAYWARRIOR2,
};

class npc_warsong_hold_warrior : public CreatureScript
{
public:
    npc_warsong_hold_warrior() : CreatureScript("npc_warsong_hold_warrior") { }

    struct npc_warsong_hold_warriorAI : public ScriptedAI
    {
        npc_warsong_hold_warriorAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiCleaveTimer;
        uint32 uiSpawnTimer;

        void Reset() OVERRIDE
        {
            uiCleaveTimer = urand(2*IN_MILLISECONDS,4*IN_MILLISECONDS);
            uiSpawnTimer = 62*IN_MILLISECONDS;
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (uiSpawnTimer <= uiDiff)
            {
                me->SetReactState(REACT_DEFENSIVE);
                Talk(SAYWARRIOR2);
                me->HandleEmoteCommand(EMOTE_STATE_TALK);
                me->GetMotionMaster()->MovePoint(0,me->GetPositionX()+10,me->GetPositionY(),me->GetPositionZ());
                me->DespawnOrUnsummon(5000);
                uiSpawnTimer = 62*IN_MILLISECONDS;
            }
            else
                uiSpawnTimer -= uiDiff;

            if (me->IsNonMeleeSpellCasted(false))
                return;

            if (uiCleaveTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_CLEAVE);
                uiCleaveTimer = urand(4*IN_MILLISECONDS,6*IN_MILLISECONDS);
            }
            else
                uiCleaveTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_warsong_hold_warriorAI(creature);
    }
};

/*######
## npc_warsong_hold_shaman
######*/

enum WarsongHS
{
    SPELL_FROST_SHOCK = 15499,
    SPELL_GHOST_WOLF = 45528,

    SAYSHAMAN1 = 0,
    SAYSHAMAN2,
};

class npc_warsong_hold_shaman : public CreatureScript
{
public:
    npc_warsong_hold_shaman() : CreatureScript("npc_warsong_hold_shaman") { }

    struct npc_warsong_hold_shamanAI : public ScriptedAI
    {
        npc_warsong_hold_shamanAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiFrostShockTimer;
        uint32 uiDespawnTimer;
        uint32 uiGhostWolfTimer;

        void Reset() OVERRIDE
        {
            uiFrostShockTimer = urand(2*IN_MILLISECONDS,4*IN_MILLISECONDS);
            uiDespawnTimer = 62*IN_MILLISECONDS;
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (uiDespawnTimer <= uiDiff)
            {
                me->SetReactState(REACT_DEFENSIVE);
                Talk(SAYSHAMAN2);
                me->HandleEmoteCommand(EMOTE_STATE_TALK);
                DoCast(me,SPELL_GHOST_WOLF);
                me->GetMotionMaster()->MovePoint(0,me->GetPositionX()+10,me->GetPositionY(),me->GetPositionZ());
                me->DespawnOrUnsummon(5000);
                uiDespawnTimer = 62*IN_MILLISECONDS;
            }
            else
                uiDespawnTimer -= uiDiff;

            if (me->IsNonMeleeSpellCasted(false))
                return;

            if (uiFrostShockTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_FROST_SHOCK);
                uiFrostShockTimer = urand(3*IN_MILLISECONDS,5*IN_MILLISECONDS);
            }
            else
                uiFrostShockTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_warsong_hold_shamanAI(creature);
    }
};

/*######
## npc_warsong_hold_peon
######*/

enum WarsongHP
{
    SAYPEON1 = 0,
};

class npc_warsong_hold_peon : public CreatureScript
{
public:
    npc_warsong_hold_peon() : CreatureScript("npc_warsong_hold_peon") { }

    struct npc_warsong_hold_peonAI : public ScriptedAI
    {
        npc_warsong_hold_peonAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiPeonDespawnTimer;

        void Reset() OVERRIDE
        {
            uiPeonDespawnTimer = 1*IN_MILLISECONDS;
            me->DespawnOrUnsummon(5000);
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if(!me->GetVictim()){
            if (uiPeonDespawnTimer <= uiDiff)
            {
                Talk(SAYPEON1);
                me->HandleEmoteCommand(RAND(EMOTE_STATE_TALK,EMOTE_ONESHOT_EXCLAMATION,EMOTE_STATE_COWER));
                me->DespawnOrUnsummon(5000);
                uiPeonDespawnTimer = 7*IN_MILLISECONDS;
            }
            else
                uiPeonDespawnTimer -= uiDiff;
            }

            if (!UpdateVictim())
                return;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_warsong_hold_peonAI(creature);
    }
};

/*######
## npc_warsong_unliving_swine
######*/

enum WarsongUnliving
{
    SPELL_SWINE_FLU = 50303,
};

class npc_warsong_unliving_swine : public CreatureScript
{
public:
    npc_warsong_unliving_swine() : CreatureScript("npc_warsong_unliving_swine") { }

    struct npc_warsong_unliving_swineAI : public ScriptedAI
    {
        npc_warsong_unliving_swineAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiSwineFluTimer;

        void Reset() OVERRIDE
        {
            uiSwineFluTimer = urand(5*IN_MILLISECONDS,12*IN_MILLISECONDS);
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

            if (me->IsNonMeleeSpellCasted(false))
                return;

            if (uiSwineFluTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_SWINE_FLU);
                uiSwineFluTimer = urand(31*IN_MILLISECONDS,35*IN_MILLISECONDS);
            }
            else
                uiSwineFluTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_warsong_unliving_swineAI(creature);
    }
};

/*######
## npc_warsong_enkilah_necrolord
######*/

enum WarsongEnkilahN
{
    SPELL_BONE_ARMOR = 50324,
    SPELL_SHARPENED_BONE = 50323,
};

class npc_warsong_enkilah_necrolord : public CreatureScript
{
public:
    npc_warsong_enkilah_necrolord() : CreatureScript("npc_warsong_enkilah_necrolord") { }

    struct npc_warsong_enkilah_necrolordAI : public ScriptedAI
    {
        npc_warsong_enkilah_necrolordAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiBoneArmorTimer;
        uint32 uiSharpenedBoneTimer;

        void Reset() OVERRIDE
        {
            uiBoneArmorTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            uiSharpenedBoneTimer = urand(6*IN_MILLISECONDS,8*IN_MILLISECONDS);
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

            if (me->IsNonMeleeSpellCasted(false))
                return;

            if (uiBoneArmorTimer <= uiDiff)
            {
                DoCast(me,SPELL_BONE_ARMOR);
                uiBoneArmorTimer = urand(25*IN_MILLISECONDS,35*IN_MILLISECONDS);
            }
            else
                uiBoneArmorTimer -= uiDiff;

            if (uiSharpenedBoneTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_SHARPENED_BONE);
                uiSharpenedBoneTimer = urand(6*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiSharpenedBoneTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_warsong_enkilah_necrolordAI(creature);
    }
};

/*######
## npc_torps_farm_dummy
######*/

enum TorpsFarm
{
    QUEST_THE_WARSONG_FARMS = 11686,
    NPC_TORPS_FARM_CREDIT = 25671,
};

class npc_torps_farm_dummy : public CreatureScript
{
public:
    npc_torps_farm_dummy() : CreatureScript("npc_torps_farm_dummy") { }

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_torps_farm_dummyAI (creature);
    }

    struct npc_torps_farm_dummyAI : public ScriptedAI
    {
        npc_torps_farm_dummyAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 uiCheckTorpsTimer;

        void Reset() OVERRIDE
        {
            uiCheckTorpsTimer = 2000;
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (uiCheckTorpsTimer <= uiDiff)
            {
                if (Player * player = me->SelectNearestPlayer(5.0f))
                {
                    uiCheckTorpsTimer = 2000;
                    if(player && player->GetQuestStatus(QUEST_THE_WARSONG_FARMS) == QUEST_STATUS_INCOMPLETE)
                    {
                        player->KilledMonsterCredit(NPC_TORPS_FARM_CREDIT,0);

                    }
                }
            }else
                uiCheckTorpsTimer -= uiDiff;
        }
    };
};

/*######
## npc_nerubar_skitterer
######*/

enum NerubarSkitterer
{
    SPELL_PIERCING_BLOW = 49749,
};

class npc_nerubar_skitterer : public CreatureScript
{
public:
    npc_nerubar_skitterer() : CreatureScript("npc_nerubar_skitterer") { }

    struct npc_nerubar_skittererAI : public ScriptedAI
    {
        npc_nerubar_skittererAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiPiercingBlowTimer;

        void Reset() OVERRIDE
        {
            uiPiercingBlowTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (me->IsNonMeleeSpellCasted(false))
                return;

            if (uiPiercingBlowTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_PIERCING_BLOW);
                uiPiercingBlowTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiPiercingBlowTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_nerubar_skittererAI(creature);
    }
};

/*######
## npc_nerubar_web_lord
######*/

enum NerubarWebLord
{
    SPELL_BLINDING_SWARM = 50284,
};

class npc_nerubar_web_lord : public CreatureScript
{
public:
    npc_nerubar_web_lord() : CreatureScript("npc_nerubar_web_lord") { }

    struct npc_nerubar_web_lordAI : public ScriptedAI
    {
        npc_nerubar_web_lordAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiPiercingBlowTimer;

        void Reset() OVERRIDE
        {
            uiPiercingBlowTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (me->IsNonMeleeSpellCasted(false))
                return;

            if (uiPiercingBlowTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_BLINDING_SWARM);
                uiPiercingBlowTimer = urand(6*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiPiercingBlowTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_nerubar_web_lordAI(creature);
    }
};

/*######
## npc_nerubar_corpse_harvester
######*/

enum NerubarCorpseh
{
    SPELL_VENOM_SPIT = 45577,
};

class npc_nerubar_corpse_harvester : public CreatureScript
{
public:
    npc_nerubar_corpse_harvester() : CreatureScript("npc_nerubar_corpse_harvester") { }

    struct npc_nerubar_corpse_harvesterAI : public ScriptedAI
    {
        npc_nerubar_corpse_harvesterAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiVenomSpitTimer;

        void Reset() OVERRIDE
        {
            uiVenomSpitTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (me->IsNonMeleeSpellCasted(false))
                return;

            if (uiVenomSpitTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_VENOM_SPIT);
                uiVenomSpitTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiVenomSpitTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_nerubar_corpse_harvesterAI(creature);
    }
};

/*######
## npc_kvaldir_mist_lord
######*/

enum KvaldirMist
{
    SPELL_WAVE_CRASH = 49922,
};

class npc_kvaldir_mist_lord : public CreatureScript
{
public:
    npc_kvaldir_mist_lord() : CreatureScript("npc_kvaldir_mist_lord") { }

    struct npc_kvaldir_mist_lordAI : public ScriptedAI
    {
        npc_kvaldir_mist_lordAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiWaveCrashTimer;

        void Reset() OVERRIDE
        {
            uiWaveCrashTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (uiWaveCrashTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_WAVE_CRASH);
                uiWaveCrashTimer = urand(3*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiWaveCrashTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_kvaldir_mist_lordAI(creature);
    }
};

/*######
## npc_kvaldir_mistweaver
######*/

enum KvaldirMistweaver
{
    SPELL_CALL_OF_THE_MIST = 45658,
    SPELL_MIST_OF_STRANGULATION = 49816,
};

class npc_kvaldir_mistweaver : public CreatureScript
{
public:
    npc_kvaldir_mistweaver() : CreatureScript("npc_kvaldir_mistweaver") { }

    struct npc_kvaldir_mistweaverAI : public ScriptedAI
    {
        npc_kvaldir_mistweaverAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiCallMistTimer;
        uint32 uiMistStrangulationTimer;

        void Reset() OVERRIDE
        {
            uiCallMistTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
            uiMistStrangulationTimer = urand(6*IN_MILLISECONDS,10*IN_MILLISECONDS);
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (!me->GetVictim())
            {
                if(!me->HasAura(SPELL_CALL_OF_THE_MIST))
                    DoCast(me,SPELL_CALL_OF_THE_MIST);
            }

            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uiMistStrangulationTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_MIST_OF_STRANGULATION);
                uiMistStrangulationTimer = urand(8*IN_MILLISECONDS,12*IN_MILLISECONDS);
            }
            else
                uiMistStrangulationTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_kvaldir_mistweaverAI(creature);
    }
};

/*######
## npc_warden_nork_bloodfrenzy
######*/

enum WardenNorkB
{

};

class npc_warden_nork_bloodfrenzy : public CreatureScript
{
public:
    npc_warden_nork_bloodfrenzy() : CreatureScript("npc_warden_nork_bloodfrenzy") { }

    struct npc_warden_nork_bloodfrenzyAI : public ScriptedAI
    {
        npc_warden_nork_bloodfrenzyAI(Creature* creature) : ScriptedAI(creature){}

    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_warden_nork_bloodfrenzyAI(creature);
    }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
    {
        if (quest->GetQuestId() == 11711)
        {
            if (player->GetQuestStatus(11711) == QUEST_STATUS_INCOMPLETE)
                player->CastSpell(player,45963);

            if (creature = player->FindNearestCreature(25761,5.0f,true))
            {
                if(creature)
                {
                    creature->CastSpell(creature,45957);
                }
            }
            return true;
        }
        return false;
    }
};

/*######
## npc_valiance_keep_officer
######*/

enum ValianceKeepOfficer
{
};

class npc_valiance_keep_officer : public CreatureScript
{
public:
    npc_valiance_keep_officer() : CreatureScript("npc_valiance_keep_officer") { }

    struct npc_valiance_keep_officerAI : public ScriptedAI
    {
        npc_valiance_keep_officerAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiHablarTimer;

        void Reset() OVERRIDE
        {
            uiHablarTimer = 6000;
        }

        void UpdateAI(uint32 uiDiff)
        {
            if (!me->GetVictim())
            {
                if(uiHablarTimer <= uiDiff)
                {
                    if(Player *player = me->SelectNearestPlayer(15.0f))
                        Talk(0,player);

                    me->HandleEmoteCommand(EMOTE_STATE_TALK);
                    if(Creature *busco = me->FindNearestCreature(25761,15.0f,true))
                        if(busco)
                        {
                            busco->DespawnOrUnsummon(8000);
                            me->DespawnOrUnsummon(8000);
                        }
                    uiHablarTimer = 15000;
                }
                else
                    uiHablarTimer -= uiDiff;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_valiance_keep_officerAI(creature);
    }
};

/*######
## npc_bloodspore_harvester
######*/

enum BloodsporeH
{
    SPELL_BLOODSPORE_HAZE = 50380,
    SPELL_BLOODSPORE_MALAISE = 45987,
};

class npc_bloodspore_harvester : public CreatureScript
{
public:
    npc_bloodspore_harvester() : CreatureScript("npc_bloodspore_harvester") { }

    struct npc_bloodspore_harvesterAI : public ScriptedAI
    {
        npc_bloodspore_harvesterAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiBloodsporeHazeTimer;
        uint32 uiBloodsporeMalaiseTimer;

        void Reset() OVERRIDE
        {
            uiBloodsporeHazeTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            uiBloodsporeMalaiseTimer = urand(6*IN_MILLISECONDS,10*IN_MILLISECONDS);
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

            if (uiBloodsporeHazeTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_BLOODSPORE_HAZE);
                uiBloodsporeHazeTimer = urand(7*IN_MILLISECONDS,12*IN_MILLISECONDS);
            }
            else
                uiBloodsporeHazeTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_bloodspore_harvesterAI(creature);
    }
};

/*######
## npc_bloodspore_roaster
######*/

enum BloodsporeRoaster
{
    SPELL_ROAST = 50402,
};

class npc_bloodspore_roaster : public CreatureScript
{
public:
    npc_bloodspore_roaster() : CreatureScript("npc_bloodspore_roaster") { }

    struct npc_bloodspore_roasterAI : public ScriptedAI
    {
        npc_bloodspore_roasterAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiRoastTimer;

        void Reset() OVERRIDE
        {
            uiRoastTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (uiRoastTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_ROAST);
                uiRoastTimer = urand(5*IN_MILLISECONDS,9*IN_MILLISECONDS);
            }
            else
                uiRoastTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_bloodspore_roasterAI(creature);
    }
};

/*######
## npc_bloodspore_moth
######*/

enum BloodsporeMoth
{
    SPELL_POLLEN = 45610,
    SPELL_WING_BUFFET = 32914,
};

class npc_bloodspore_moth : public CreatureScript
{
public:
    npc_bloodspore_moth() : CreatureScript("npc_bloodspore_moth") { }

    struct npc_bloodspore_mothAI : public ScriptedAI
    {
        npc_bloodspore_mothAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiPollenTimer;
        uint32 uiWingBuffetTimer;

        void Reset() OVERRIDE
        {
            uiPollenTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
            uiWingBuffetTimer = urand(7*IN_MILLISECONDS,10*IN_MILLISECONDS);
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

            if (uiPollenTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_POLLEN);
                uiPollenTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
            }
            else
                uiPollenTimer -= uiDiff;

            if (uiWingBuffetTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_WING_BUFFET);
                uiWingBuffetTimer = urand(8*IN_MILLISECONDS,10*IN_MILLISECONDS);
            }
            else
                uiWingBuffetTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_bloodspore_mothAI(creature);
    }
};

/*######
## npc_beryl_mage_hunter
######*/

enum BerylMageH
{
    SPELL_FROST_CUT = 50655,
};

class npc_beryl_mage_hunter : public CreatureScript
{
public:
    npc_beryl_mage_hunter() : CreatureScript("npc_beryl_mage_hunter") { }

    struct npc_beryl_mage_hunterAI : public ScriptedAI
    {
        npc_beryl_mage_hunterAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiFrostCutTimer;

        void Reset() OVERRIDE
        {
            uiFrostCutTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
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

            if (uiFrostCutTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_FROST_CUT);
                uiFrostCutTimer = urand(5*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiFrostCutTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_beryl_mage_hunterAI(creature);
    }
};

/*######
## npc_steam_rager
######*/

enum SteamR
{
    SPELL_STEAM_BLAST   = 50375,
    TARGET_TOTEM_QUEST  = 25987,
};

class npc_steam_rager : public CreatureScript
{
public:
    npc_steam_rager() : CreatureScript("npc_steam_rager") { }

    struct npc_steam_ragerAI : public ScriptedAI
    {
        npc_steam_ragerAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiSteamBlastTimer;

        void Reset()
        {
            uiSteamBlastTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);
        }

        void JustDied(Unit* killer)
        {
            if (Creature *totem = me->FindNearestCreature(TARGET_TOTEM_QUEST,10.0f,true))
                if (killer)
                {
                    if (Player* player = killer->ToPlayer())
                        player->KilledMonsterCredit(TARGET_TOTEM_QUEST,0);
                    else
                    {
                        if (Unit* owner = killer->GetOwner())
                            if (Player* player = owner->ToPlayer())
                                player->KilledMonsterCredit(TARGET_TOTEM_QUEST,0);
                    }

                }

            me->DespawnOrUnsummon(3000);
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uiSteamBlastTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_STEAM_BLAST);
                uiSteamBlastTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiSteamBlastTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_steam_ragerAI(creature);
    }
};

/*######
## npc_dorain_frosthoof
######*/

class npc_dorain_frosthoof : public CreatureScript
{
public:
    npc_dorain_frosthoof() : CreatureScript("npc_dorain_frosthoof") { }

    struct npc_dorain_frosthoofAI : public ScriptedAI
    {
        npc_dorain_frosthoofAI(Creature* creature) : ScriptedAI(creature){}

        bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
        {
        if (quest->GetQuestId() == 11893)
        {
            if(player->HasAura(46424))
                player->RemoveAllAuras();

            return true;
        }
        return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_dorain_frosthoofAI(creature);
    }
};

/*######
## npc_gorloc_gibberer
######*/

enum GorlocG
{
    SPELL_DEEP_DREDGE = 50520,
    SPELL_WHIRLWIND = 15576,
};

class npc_gorloc_gibberer : public CreatureScript
{
public:
    npc_gorloc_gibberer() : CreatureScript("npc_gorloc_gibberer") { }

    struct npc_gorloc_gibbererAI : public ScriptedAI
    {
        npc_gorloc_gibbererAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiDeepDredgeTimer;
        uint32 uiWhirlwindTimer;

        void Reset() OVERRIDE
        {
            uiDeepDredgeTimer = urand(2*IN_MILLISECONDS,6*IN_MILLISECONDS);
            uiWhirlwindTimer = urand(5*IN_MILLISECONDS,10*IN_MILLISECONDS);
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

            if (uiDeepDredgeTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_DEEP_DREDGE);
                uiDeepDredgeTimer = urand(2*IN_MILLISECONDS,6*IN_MILLISECONDS);
            }
            else
                uiDeepDredgeTimer -= uiDiff;

            if (uiWhirlwindTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_WHIRLWIND);
                uiWhirlwindTimer = urand(5*IN_MILLISECONDS,10*IN_MILLISECONDS);
            }
            else
                uiWhirlwindTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_gorloc_gibbererAI(creature);
    }
};

/*######
## npc_gorloc_steam_belcher
######*/

enum GorlocSB
{
    SPELL_BELCH_BLAST = 50538,
};

class npc_gorloc_steam_belcher : public CreatureScript
{
public:
    npc_gorloc_steam_belcher() : CreatureScript("npc_gorloc_steam_belcher") { }

    struct npc_gorloc_steam_belcherAI : public ScriptedAI
    {
        npc_gorloc_steam_belcherAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiBelchBlastTimer;

        void Reset() OVERRIDE
        {
            uiBelchBlastTimer = urand(2*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (uiBelchBlastTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_BELCH_BLAST);
                uiBelchBlastTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiBelchBlastTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_gorloc_steam_belcherAI(creature);
    }
};

/*######
## npc_gorloc_waddler
######*/

enum GorlocW
{
    SPELL_GORLOC_STOMP = 50522,
};

class npc_gorloc_waddler : public CreatureScript
{
public:
    npc_gorloc_waddler() : CreatureScript("npc_gorloc_waddler") { }

    struct npc_gorloc_waddlerAI : public ScriptedAI
    {
        npc_gorloc_waddlerAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiGorlocStompTimer;

        void Reset() OVERRIDE
        {
            uiGorlocStompTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (uiGorlocStompTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_GORLOC_STOMP);
                uiGorlocStompTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiGorlocStompTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_gorloc_waddlerAI(creature);
    }
};

/*######
## npc_chieftain_gurgleboggle
######*/

enum ChieftainG
{
    SPELL_FLIP_ATTACK = 50533,
};

class npc_chieftain_gurgleboggle : public CreatureScript
{
public:
    npc_chieftain_gurgleboggle() : CreatureScript("npc_chieftain_gurgleboggle") { }

    struct npc_chieftain_gurgleboggleAI : public ScriptedAI
    {
        npc_chieftain_gurgleboggleAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiFlipAttackTimer;

        void Reset() OVERRIDE
        {
            uiFlipAttackTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (uiFlipAttackTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_FLIP_ATTACK);
                uiFlipAttackTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiFlipAttackTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_chieftain_gurgleboggleAI(creature);
    }
};

/*######
## npc_nerubar_tunneler
######*/

enum NerubarT
{
    SPELL_ROCK_SHIELD = 50364,
};

class npc_nerubar_tunneler : public CreatureScript
{
public:
    npc_nerubar_tunneler() : CreatureScript("npc_nerubar_tunneler") { }

    struct npc_nerubar_tunnelerAI : public ScriptedAI
    {
        npc_nerubar_tunnelerAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiRockShieldTimer;

        void Reset() OVERRIDE
        {
            uiRockShieldTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (uiRockShieldTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_ROCK_SHIELD);
                uiRockShieldTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiRockShieldTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_nerubar_tunnelerAI(creature);
    }
};

/*######
## npc_nerubar_warrior
######*/

enum NerubarW
{
    SPELL_RUSH = 50347,
};

class npc_nerubar_warrior : public CreatureScript
{
public:
    npc_nerubar_warrior() : CreatureScript("npc_nerubar_warrior") { }

    struct npc_nerubar_warriorAI : public ScriptedAI
    {
        npc_nerubar_warriorAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiRushTimer;

        void Reset() OVERRIDE
        {
            uiRushTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (uiRushTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_RUSH);
                uiRushTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiRushTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_nerubar_warriorAI(creature);
    }
};

/*######
## npc_ziggurat_defender
######*/

enum ZigguratD
{
    SPELL_THRASH_KICK = 50306,
};

class npc_ziggurat_defender : public CreatureScript
{
public:
    npc_ziggurat_defender() : CreatureScript("npc_ziggurat_defender") { }

    struct npc_ziggurat_defenderAI : public ScriptedAI
    {
        npc_ziggurat_defenderAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiThrashKickTimer;

        void Reset() OVERRIDE
        {
            uiThrashKickTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (uiThrashKickTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_THRASH_KICK);
                uiThrashKickTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiThrashKickTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_ziggurat_defenderAI(creature);
    }
};

/*######
## npc_tundra_crawler
######*/

enum TundraCraw
{
    SPELL_CORROSIVE_POISON = 50293,
};

class npc_tundra_crawler : public CreatureScript
{
public:
    npc_tundra_crawler() : CreatureScript("npc_tundra_crawler") { }

    struct npc_tundra_crawlerAI : public ScriptedAI
    {
        npc_tundra_crawlerAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiCorrosivePoisonTimer;

        void Reset() OVERRIDE
        {
            uiCorrosivePoisonTimer = urand(2*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (uiCorrosivePoisonTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_CORROSIVE_POISON);
                uiCorrosivePoisonTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiCorrosivePoisonTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_tundra_crawlerAI(creature);
    }
};

/*######
## npc_enkilah_abomination
######*/

enum EnkkilahA
{
    SPELL_CLEAVE_AB = 40504,
    SPELL_SCOURGE_HOOK = 50335,
};

class npc_enkilah_abomination : public CreatureScript
{
public:
    npc_enkilah_abomination() : CreatureScript("npc_enkilah_abomination") { }

    struct npc_enkilah_abominationAI : public ScriptedAI
    {
        npc_enkilah_abominationAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiCleaveATimer;
        uint32 uiScourgeHookTimer;

        void Reset() OVERRIDE
        {
            uiCleaveATimer = urand(5*IN_MILLISECONDS,8*IN_MILLISECONDS);
            uiScourgeHookTimer = urand(2*IN_MILLISECONDS,5*IN_MILLISECONDS);
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

            if (uiCleaveATimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_CLEAVE_AB);
                uiCleaveATimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiCleaveATimer -= uiDiff;

            if (uiScourgeHookTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_SCOURGE_HOOK);
                uiScourgeHookTimer = urand(6*IN_MILLISECONDS,10*IN_MILLISECONDS);
            }
            else
                uiScourgeHookTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_enkilah_abominationAI(creature);
    }
};

/*######
## npc_enkilah_gargoyle
######*/

enum EnkkilahG
{
    SPELL_GARGOYLE_STRIKE = 16564,
};

class npc_enkilah_gargoyle : public CreatureScript
{
public:
    npc_enkilah_gargoyle() : CreatureScript("npc_enkilah_gargoyle") { }

    struct npc_enkilah_gargoyleAI : public ScriptedAI
    {
        npc_enkilah_gargoyleAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiGargoyleStrikeATimer;

        void Reset() OVERRIDE
        {
            uiGargoyleStrikeATimer = urand(2*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (uiGargoyleStrikeATimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_GARGOYLE_STRIKE);
                uiGargoyleStrikeATimer = urand(3*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiGargoyleStrikeATimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_enkilah_gargoyleAI(creature);
    }
};

/*######
## npc_crypt_fiend_b
######*/

enum CryptFb
{
    SPELL_CRYPT_SCARABS = 31600,
};

class npc_crypt_fiend_b : public CreatureScript
{
public:
    npc_crypt_fiend_b() : CreatureScript("npc_crypt_fiend_b") { }

    struct npc_crypt_fiend_bAI : public ScriptedAI
    {
        npc_crypt_fiend_bAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiCryptTimer;

        void Reset() OVERRIDE
        {
            uiCryptTimer = urand(2*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (uiCryptTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_CRYPT_SCARABS);
                uiCryptTimer = urand(3*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiCryptTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_crypt_fiend_bAI(creature);
    }
};

/*######
## npc_blood_globe
######*/

class npc_blood_globe : public CreatureScript
{
public:
    npc_blood_globe() : CreatureScript("npc_blood_globe") { }

    struct npc_blood_globeAI : public ScriptedAI
    {
        npc_blood_globeAI(Creature* creature) : ScriptedAI(creature){}

        void Reset() OVERRIDE
        {
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
            me->SetReactState(REACT_PASSIVE);
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_blood_globeAI(creature);
    }
};

/*######
## npc_killcredit_templeA
######*/

class npc_killcredit_templeA : public CreatureScript
{
public:
    npc_killcredit_templeA() : CreatureScript("npc_killcredit_templeA") { }

    struct npc_killcredit_templeAAI : public ScriptedAI
    {
        npc_killcredit_templeAAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiCheckPlayerTimer;

        void Reset() OVERRIDE
        {
            uiCheckPlayerTimer = 2*IN_MILLISECONDS;
        }

        void UpdateAI(uint32 uiDiff)
        {
            if(uiCheckPlayerTimer <= uiDiff)
            {
                if (Player * player = me->SelectNearestPlayer(10.0f))
                {
                    if(!player)
                        return;

                    if(player->HasAura(45614) && player->GetQuestStatus(11633) == QUEST_STATUS_INCOMPLETE)
                        player->KilledMonsterCredit(25471,0);
                }
                uiCheckPlayerTimer = 2*IN_MILLISECONDS;
            }
            else
                uiCheckPlayerTimer -= uiDiff;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_killcredit_templeAAI(creature);
    }
};

/*######
## npc_killcredit_templeB
######*/

class npc_killcredit_templeB : public CreatureScript
{
public:
    npc_killcredit_templeB() : CreatureScript("npc_killcredit_templeB") { }

    struct npc_killcredit_templeBAI : public ScriptedAI
    {
        npc_killcredit_templeBAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiCheckPlayerTimer;

        void Reset() OVERRIDE
        {
            uiCheckPlayerTimer = 2*IN_MILLISECONDS;
        }

        void UpdateAI(uint32 uiDiff)
        {
            if(uiCheckPlayerTimer <= uiDiff)
            {
                if (Player * player = me->SelectNearestPlayer(10.0f))
                {
                    if(!player)
                        return;

                    if(player->HasAura(45614) && player->GetQuestStatus(11633) == QUEST_STATUS_INCOMPLETE)
                        player->KilledMonsterCredit(25472,0);
                }
                uiCheckPlayerTimer = 2*IN_MILLISECONDS;
            }
            else
                uiCheckPlayerTimer -= uiDiff;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_killcredit_templeBAI(creature);
    }
};

/*######
## npc_killcredit_templeC
######*/

class npc_killcredit_templeC : public CreatureScript
{
public:
    npc_killcredit_templeC() : CreatureScript("npc_killcredit_templeC") { }

    struct npc_killcredit_templeCAI : public ScriptedAI
    {
        npc_killcredit_templeCAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiCheckPlayerTimer;

        void Reset() OVERRIDE
        {
            uiCheckPlayerTimer = 2*IN_MILLISECONDS;
        }

        void UpdateAI(uint32 uiDiff)
        {
            if(uiCheckPlayerTimer <= uiDiff)
            {
                if (Player * player = me->SelectNearestPlayer(10.0f))
                {
                    if(!player)
                        return;

                    if(player->HasAura(45614) && player->GetQuestStatus(11633) == QUEST_STATUS_INCOMPLETE)
                        player->KilledMonsterCredit(25473,0);
                }
                uiCheckPlayerTimer = 2*IN_MILLISECONDS;
            }
            else
                uiCheckPlayerTimer -= uiDiff;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_killcredit_templeCAI(creature);
    }
};

/*######
## npc_naxxanar_segundo_piso
######*/

class npc_naxxanar_segundo_piso : public CreatureScript
{
public:
    npc_naxxanar_segundo_piso() : CreatureScript("npc_naxxanar_segundo_piso") { }

    struct npc_naxxanar_segundo_pisoAI : public ScriptedAI
    {
        npc_naxxanar_segundo_pisoAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiCheckPlayerTimer;

        void Reset() OVERRIDE
        {
            uiCheckPlayerTimer = 2*IN_MILLISECONDS;
        }

        void UpdateAI(uint32 uiDiff)
        {

            if(uiCheckPlayerTimer <= uiDiff)
            {
                if (Player * player = me->SelectNearestPlayer(2.0f))
                {
                    if(!player)
                        return;

                        player->TeleportTo(571, 3733.68f, 3563.25f, 290.812f, 3.665192f);
                }
                uiCheckPlayerTimer = 2*IN_MILLISECONDS;
            }
            else
                uiCheckPlayerTimer -= uiDiff;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_naxxanar_segundo_pisoAI(creature);
    }
};

/*######
## npc_darkfallen_deathblade
######*/

enum DarkfallenD
{
    SPELL_DEATH_COIL = 50668,
    SPELL_ICY_TOUCH = 50349,
};

class npc_darkfallen_deathblade : public CreatureScript
{
public:
    npc_darkfallen_deathblade() : CreatureScript("npc_darkfallen_deathblade") { }

    struct npc_darkfallen_deathbladeAI : public ScriptedAI
    {
        npc_darkfallen_deathbladeAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiDeathCoilTimer;
        uint32 uiIcyTouchTimer;

        void Reset() OVERRIDE
        {
            uiDeathCoilTimer = urand(2*IN_MILLISECONDS,5*IN_MILLISECONDS);
            uiIcyTouchTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
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

            if (uiDeathCoilTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_DEATH_COIL);
                uiDeathCoilTimer = urand(3*IN_MILLISECONDS,7*IN_MILLISECONDS);
            }
            else
                uiDeathCoilTimer -= uiDiff;

            if (uiIcyTouchTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_ICY_TOUCH);
                uiIcyTouchTimer = urand(6*IN_MILLISECONDS,10*IN_MILLISECONDS);
            }
            else
                uiIcyTouchTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_darkfallen_deathbladeAI(creature);
    }
};

/*######
## npc_mother_tauranook
######*/

enum MotherTauranook
{
    QUEST_ACROSS_TRANSBOREA = 11930,
    SPELL_CALL_EVACUEE = 46667,
};

#define TEXTO1 "I regret to inform you that the evacuee I was charged with escorting is no more. Would you please allow me to escort another evacuee? I won't fail you again!"
#define TEXTO2 "Siento informarte de que el evacuado que me encargaste escoltar ha fallecido. ¿Podrías permítirme escoltar a otro evacuado, por favor? ¡No volveré a fallarte!"

class npc_mother_tauranook : public CreatureScript
{
public:
    npc_mother_tauranook() : CreatureScript("npc_mother_tauranook") { }

    struct npc_mother_tauranookAI : public ScriptedAI
    {
        npc_mother_tauranookAI(Creature* creature) : ScriptedAI(creature){}

    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_mother_tauranookAI(creature);
    }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
    {
        if (quest->GetQuestId() == QUEST_ACROSS_TRANSBOREA)
        {
            player->CastSpell(player,SPELL_CALL_EVACUEE);

            return true;
        }
        return false;
    }

    bool OnGossipHello(Player* player, Creature* creature)
        {
            if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

            if(player->GetQuestStatus(QUEST_ACROSS_TRANSBOREA) == QUEST_STATUS_INCOMPLETE)
            {
                if(!player->HasAura(46657))
                {
                    const char* localizedEntry;
                    switch (player->GetSession()->GetSessionDbcLocale())
                    {
                        case LOCALE_enUS: localizedEntry = TEXTO1; break;
                        case LOCALE_esMX: localizedEntry = TEXTO2; break;
                        default: localizedEntry = TEXTO1;break;
                    }
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, localizedEntry, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                }
            }
            player->TalkedToCreature(creature->GetEntry(), creature->GetGUID());
            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
            return true;
        }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();

        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                if(!player->HasAura(46657))
                    player->CastSpell(player,SPELL_CALL_EVACUEE);

                player->CLOSE_GOSSIP_MENU();
                break;
        }
        return true;
    }
};

/*######
## npc_taunkale_evacuee
######*/

enum TaunkaleE
{
};

class npc_taunkale_evacuee : public CreatureScript
{
public:
    npc_taunkale_evacuee() : CreatureScript("npc_taunkale_evacuee") { }

    struct npc_taunkale_evacueeAI : public ScriptedAI
    {
        npc_taunkale_evacueeAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiHablarTimer;
        uint32 uiLlorarTimer;
        uint32 uiCryTimer;
        uint32 uiSpawmMaloTimer;
        uint32 uiCheckQuestTimer;
        uint32 uiPhaseDosTimer;
        uint8 phase2;
        uint8 phase;
        bool check;
        bool llorar;
        bool final;

        void Reset() OVERRIDE
        {
            final = false;
            llorar = false;
            check = false;
            uiSpawmMaloTimer = urand(28*IN_MILLISECONDS,60*IN_MILLISECONDS);
            uiCheckQuestTimer = 2*IN_MILLISECONDS;
            phase = 1;
            uiCryTimer = urand(25*IN_MILLISECONDS,39*IN_MILLISECONDS);
            uiHablarTimer = urand(22*IN_MILLISECONDS,45*IN_MILLISECONDS);
            uiLlorarTimer = urand(30*IN_MILLISECONDS,48*IN_MILLISECONDS);
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);

            Talk(9);
        }

        void JustDied(Unit* /*killer*/)
        {
            if(Player *player = me->SelectNearestPlayer(5.0f))
            {
                if(!player)
                    return;

                if(player->FindNearestCreature(26167,6.0f,false))
                    player->RemoveAura(46657);
            }
        }

        void UpdateAI(uint32 uiDiff)
        {
            if(!me->GetVictim()){
            if (uiCheckQuestTimer <= uiDiff)
            {
                uiCheckQuestTimer = 2*IN_MILLISECONDS;
                if(me->FindNearestGameObject(190179,10.0f) && !check)
                {

                    if(Player *player = me->SelectNearestPlayer(5.0f))
                    {
                        if(!player)
                            return;

                        if(player->GetQuestStatus(11930) == QUEST_STATUS_INCOMPLETE)
                            player->AreaExploredOrEventHappens(11930);

                        uiPhaseDosTimer = 2*IN_MILLISECONDS;

                        phase2=1;
                        check = true;
                    }
                }
                else
                return;
            }
            else
                uiCheckQuestTimer -= uiDiff;

            if (uiPhaseDosTimer <= uiDiff)
            {
                    switch(phase2)
                    {
                    case 1:
                        final = true;
                        Talk(4);
                        me->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                        uiPhaseDosTimer = 2*IN_MILLISECONDS;
                        phase2++;
                        break;
                    case 2:
                        Talk(5);
                        me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                        uiPhaseDosTimer = 5*IN_MILLISECONDS;
                        phase2++;
                        break;
                    case 3:
                        Talk(6);
                        me->SetStandState(UNIT_STAND_STATE_KNEEL);
                        uiPhaseDosTimer = 6*IN_MILLISECONDS;
                        phase2++;
                        break;
                    case 4:
                        Talk(7);
                        me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                        uiPhaseDosTimer = 6*IN_MILLISECONDS;
                        phase2++;
                        break;
                    case 5:
                        Talk(8);
                        me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                        uiPhaseDosTimer = 6*IN_MILLISECONDS;
                        phase2++;
                        break;
                    case 6:
                        me->SetStandState(UNIT_STAND_STATE_STAND);
                        me->GetMotionMaster()->MovePoint(0,3559.55f,3018.44f,25.61f);
                        me->DespawnOrUnsummon(5*IN_MILLISECONDS);
                        phase2++;
                        break;
                    }
            }
            else
                uiPhaseDosTimer -= uiDiff;

            if (final)
                return;

            if (uiLlorarTimer <= uiDiff)
            {
                    switch(phase)
                    {
                    case 1:
                        llorar = true;
                        Talk(1);
                        me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
                        uiLlorarTimer = 3*IN_MILLISECONDS;
                        phase++;
                        break;
                    case 2:
                        me->SetStandState(UNIT_STAND_STATE_KNEEL);
                        me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                        Talk(2);
                        uiLlorarTimer = 5*IN_MILLISECONDS;
                        phase++;
                        break;
                    case 3:
                        me->SetStandState(UNIT_STAND_STATE_STAND);
                        uiLlorarTimer = urand(13*IN_MILLISECONDS,20*IN_MILLISECONDS);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
                        phase=1;
                        llorar = false;
                        break;
                    }
            }
            else
                uiLlorarTimer -= uiDiff;

            if(llorar)
                return;

            if (uiSpawmMaloTimer <= uiDiff)
            {
                me->CastSpell(me,46670);
                if(Creature *creature = me->FindNearestCreature(26165,5.0f,true))
                    if(creature)
                    {
                        creature->AI()->Talk(0);
                        creature->AI()->AttackStart(me);
                    }

                uiSpawmMaloTimer = urand(28000,40000);
            }
            else
                uiSpawmMaloTimer -= uiDiff;

            if (uiHablarTimer <= uiDiff)
            {
                Talk(0);
                me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                uiHablarTimer = urand(18*IN_MILLISECONDS,35*IN_MILLISECONDS);
            }
            else
                uiHablarTimer -= uiDiff;

            if (uiCryTimer <= uiDiff)
            {
                Talk(3);
                me->HandleEmoteCommand(EMOTE_ONESHOT_CRY);
                uiCryTimer = urand(25*IN_MILLISECONDS,35*IN_MILLISECONDS);
            }
            else
                uiCryTimer -= uiDiff;
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_taunkale_evacueeAI(creature);
    }
};

/*######
## npc_northsea_mercenary
######*/

enum NorthseaM
{
    SPELL_CRAZED = 5915,
};

class npc_northsea_mercenary : public CreatureScript
{
public:
    npc_northsea_mercenary() : CreatureScript("npc_northsea_mercenary") { }

    struct npc_northsea_mercenaryAI : public ScriptedAI
    {
        npc_northsea_mercenaryAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiCrazedTimer;

        void Reset() OVERRIDE
        {
            uiCrazedTimer = urand(8*IN_MILLISECONDS,15*IN_MILLISECONDS);
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

            if (uiCrazedTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_CRAZED);
                uiCrazedTimer = urand(59*IN_MILLISECONDS,65*IN_MILLISECONDS);
            }
            else
                uiCrazedTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_northsea_mercenaryAI(creature);
    }
};

/*######
## npc_karen_the_culler
######*/

enum KarenThec
{
    SPELL_CLEAVE_K = 42724,
    SPELL_WHIRLWIND_K = 48281,
    SPELL_INTERCEPT = 27577,
};

class npc_karen_the_culler : public CreatureScript
{
public:
    npc_karen_the_culler() : CreatureScript("npc_karen_the_culler") { }

    struct npc_karen_the_cullerAI : public ScriptedAI
    {
        npc_karen_the_cullerAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiCleaveTimer;
        uint32 uiWhirlwindTimer;
        uint32 uiInterceptTimer;

        void Reset() OVERRIDE
        {
            uiCleaveTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
            uiWhirlwindTimer = urand(6*IN_MILLISECONDS,12*IN_MILLISECONDS);
            uiInterceptTimer = urand(8*IN_MILLISECONDS,15*IN_MILLISECONDS);
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

            if (uiCleaveTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_CLEAVE_K);
                uiCleaveTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
            }
            else
                uiCleaveTimer -= uiDiff;

            if (uiWhirlwindTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_WHIRLWIND_K);
                uiWhirlwindTimer = urand(6*IN_MILLISECONDS,12*IN_MILLISECONDS);
            }
            else
                uiWhirlwindTimer -= uiDiff;

            if (uiInterceptTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_INTERCEPT);
                uiInterceptTimer = urand(8*IN_MILLISECONDS,15*IN_MILLISECONDS);
            }
            else
                uiInterceptTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_karen_the_cullerAI(creature);
    }
};

/*######
## npc_clam_master_k
######*/

enum ClamMK
{
    SPELL_HOOKED_NET = 49711,
    SPELL_THROW_SPEAR = 54431,
};

class npc_clam_master_k : public CreatureScript
{
public:
    npc_clam_master_k() : CreatureScript("npc_clam_master_k") { }

    struct npc_clam_master_kAI : public ScriptedAI
    {
        npc_clam_master_kAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiHookedNetTimer;
        uint32 uiThrowSpearTimer;

        void Reset() OVERRIDE
        {
            uiHookedNetTimer = urand(5*IN_MILLISECONDS,10*IN_MILLISECONDS);
            uiThrowSpearTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (uiHookedNetTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_HOOKED_NET);
                uiHookedNetTimer = urand(5*IN_MILLISECONDS,10*IN_MILLISECONDS);
            }
            else
                uiHookedNetTimer -= uiDiff;

            if (uiThrowSpearTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_THROW_SPEAR);
                uiThrowSpearTimer = urand(5*IN_MILLISECONDS,10*IN_MILLISECONDS);
            }
            else
                uiThrowSpearTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_clam_master_kAI(creature);
    }
};

/*######
## npc_heigarr_the_horrible
######*/

enum HeigarrT
{
    SPELL_CLEAVE_H = 40504,
    SPELL_CONCUSSION_BLOW = 32588,
};

class npc_heigarr_the_horrible : public CreatureScript
{
public:
    npc_heigarr_the_horrible() : CreatureScript("npc_heigarr_the_horrible") { }

    struct npc_heigarr_the_horribleAI : public ScriptedAI
    {
        npc_heigarr_the_horribleAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiCleaveHTimer;
        uint32 uiConcussionBlowTimer;

        void Reset() OVERRIDE
        {
            uiConcussionBlowTimer = urand(5*IN_MILLISECONDS,10*IN_MILLISECONDS);
            uiCleaveHTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (uiCleaveHTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_HOOKED_NET);
                uiCleaveHTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
            }
            else
                uiCleaveHTimer -= uiDiff;

            if (uiConcussionBlowTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_THROW_SPEAR);
                uiConcussionBlowTimer = urand(5*IN_MILLISECONDS,10*IN_MILLISECONDS);
            }
            else
                uiConcussionBlowTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_heigarr_the_horribleAI(creature);
    }
};

/*######
## npc_kaskala_defender
######*/

enum KaskalaD
{
    SPELL_THROW = 38556,
    NPC_TARGET_NPC = 25760,
};

class npc_kaskala_defender : public CreatureScript
{
public:
    npc_kaskala_defender() : CreatureScript("npc_kaskala_defender") { }

    struct npc_kaskala_defenderAI : public ScriptedAI
    {
        npc_kaskala_defenderAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiThrowTimer;
        uint32 uiFightTimer;

        void Reset() OVERRIDE
        {
            uiThrowTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            uiFightTimer = 2*IN_MILLISECONDS;
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (uiFightTimer <= uiDiff)
            {
                if (!me->IsInCombat() && (me->GetDistance2d(me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY()) <= 1.0f))
                    if (Creature* enemy = me->FindNearestCreature(NPC_TARGET_NPC,1.0f, true))
                    {
                        me->AI()->AttackStart(enemy);
                        uiFightTimer = 2*IN_MILLISECONDS;
                    }
            }
            else
                uiFightTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uiThrowTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_THROW);
                uiThrowTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiThrowTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_kaskala_defenderAI(creature);
    }
};

/*######
## npc_ghostly_sage
######*/

enum GhostyleS
{
    SPELL_MOONFIRE = 15798,
    SPELL_WRATH = 9739,
};

class npc_ghostly_sage : public CreatureScript
{
public:
    npc_ghostly_sage() : CreatureScript("npc_ghostly_sage") { }

    struct npc_ghostly_sageAI : public ScriptedAI
    {
        npc_ghostly_sageAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiMoonFireTimer;
        uint32 uiWrathTimer;

        void Reset() OVERRIDE
        {
            uiMoonFireTimer = urand(5*IN_MILLISECONDS,10*IN_MILLISECONDS);
            uiWrathTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (uiWrathTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_MOONFIRE);
                uiWrathTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
            }
            else
                uiWrathTimer -= uiDiff;

            if (uiMoonFireTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_WRATH);
                uiMoonFireTimer = urand(5*IN_MILLISECONDS,10*IN_MILLISECONDS);
            }
            else
                uiMoonFireTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_ghostly_sageAI(creature);
    }
};

/*######
## npc_scalder
######*/

enum Scalder
{
    SPELL_SCALDING_BLAST = 50257,
    SPELL_WATER_BOLT = 32011,
};

class npc_scalder : public CreatureScript
{
public:
    npc_scalder() : CreatureScript("npc_scalder") { }

    struct npc_scalderAI : public ScriptedAI
    {
        npc_scalderAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiScaldingBlastTimer;
        uint32 uiWaterBoltTimer;

        void Reset() OVERRIDE
        {
            uiScaldingBlastTimer = urand(5*IN_MILLISECONDS,10*IN_MILLISECONDS);
            uiWaterBoltTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (uiScaldingBlastTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_SCALDING_BLAST);
                uiScaldingBlastTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
            }
            else
                uiScaldingBlastTimer -= uiDiff;

            if (uiWaterBoltTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_WATER_BOLT);
                uiWaterBoltTimer = urand(5*IN_MILLISECONDS,10*IN_MILLISECONDS);
            }
            else
                uiWaterBoltTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_scalderAI(creature);
    }
};

/*######
## npc_claximus
######*/

enum Claxim
{
    SPELL_ARCANE_BARREGE = 50273,
    SPELL_STABILIZED_MAGIC = 50275,
    SPELL_KING_SPARE_SUIT = 45278,
};

class npc_claximus : public CreatureScript
{
public:
    npc_claximus() : CreatureScript("npc_claximus") { }

    struct npc_claximusAI : public ScriptedAI
    {
        npc_claximusAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiArcaneBarregeTimer;
        uint32 uiStabilizedMagicTimer;
        uint32 uiVisionQuestTimer;

        bool check;

        Player* player;

        void Reset() OVERRIDE
        {
            player = NULL;
            check = false;
            uiVisionQuestTimer = 2*IN_MILLISECONDS;
            uiStabilizedMagicTimer = urand(5*IN_MILLISECONDS,10*IN_MILLISECONDS);
            uiArcaneBarregeTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
        }

        void EnterCombat(Unit* who)
        {
            if (who->HasAura(SPELL_KING_SPARE_SUIT))
                Talk(1,who);

            if (me->IsValidAttackTarget(who))
                AttackStart(who);
        }

        void UpdateAI(uint32 uiDiff)
        {
            if (uiVisionQuestTimer <= uiDiff)
            {
                if(!check)
                {
                    if(player = me->SelectNearestPlayer(50.0f))
                    {
                        if (!player)
                            return;

                        if (player->HasAura(SPELL_KING_SPARE_SUIT))
                            Talk(0,player);

                        check = true;
                        uiVisionQuestTimer = 2*IN_MILLISECONDS;
                    }
                }
            }
            else
                uiVisionQuestTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uiArcaneBarregeTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_SCALDING_BLAST);
                uiArcaneBarregeTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
            }
            else
                uiArcaneBarregeTimer -= uiDiff;

            if (uiStabilizedMagicTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_WATER_BOLT);
                uiStabilizedMagicTimer = urand(60*IN_MILLISECONDS,70*IN_MILLISECONDS);
            }
            else
                uiStabilizedMagicTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_claximusAI(creature);
    }
};

/*######
## npc_archmage_evanor
######*/

class npc_archmage_evanor : public CreatureScript
{
public:
    npc_archmage_evanor() : CreatureScript("npc_archmage_evanor") { }

    struct npc_archmage_evanorAI : public ScriptedAI
    {
        npc_archmage_evanorAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiChatTimer;
        uint8 uiphase;

        void Reset() OVERRIDE
        {
            uiphase = 1;
            uiChatTimer = 5*IN_MILLISECONDS;
        }

        void UpdateAI(uint32 uiDiff)
        {
            if (uiChatTimer <= uiDiff)
            {
                switch(uiphase)
                {
                case 1:
                    Talk(1);
                    me->CastSpell(me,SPELL_TELEPORT);
                    uiphase++;
                    uiChatTimer = 4*IN_MILLISECONDS;
                    break;
                case 2:
                    if (Player* player = me->SelectNearestPlayer(6.0f))
                    {
                        if(player)
                            player->TeleportTo(571,3647.56f,5892.50f,174.48f,0.63149f);

                        me->DespawnOrUnsummon();
                    }
                    uiphase++;
                    uiChatTimer = 7*IN_MILLISECONDS;
                    break;
                }
            }
            else
                uiChatTimer -= uiDiff;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_archmage_evanorAI(creature);
    }
};

/*######
## npc_skadir_raider
######*/

enum SkadirRaider
{
    SPELL_FREEZING_TRAP = 43415,
};

class npc_skadir_raider : public CreatureScript
{
public:
    npc_skadir_raider() : CreatureScript("npc_skadir_raider") { }

    struct npc_skadir_raiderAI : public ScriptedAI
    {
        npc_skadir_raiderAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiFreezingTrapTimer;

        void Reset() OVERRIDE
        {
            uiFreezingTrapTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);

            Talk(0, who);
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uiFreezingTrapTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_FREEZING_TRAP);
                uiFreezingTrapTimer = urand(6*IN_MILLISECONDS,12*IN_MILLISECONDS);
            }
            else
                uiFreezingTrapTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_skadir_raiderAI(creature);
    }
};

/*######
## npc_gamel_the_cruel
######*/

enum GamelTheC
{
    SPELL_MORTAL_STRIKE = 19643,
};

class npc_gamel_the_cruel : public CreatureScript
{
public:
    npc_gamel_the_cruel() : CreatureScript("npc_gamel_the_cruel") { }

    struct npc_gamel_the_cruelAI : public ScriptedAI
    {
        npc_gamel_the_cruelAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiMortalStrikeTimer;

        void Reset() OVERRIDE
        {
            uiMortalStrikeTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
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

            if (uiMortalStrikeTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_MORTAL_STRIKE);
                uiMortalStrikeTimer = urand(5*IN_MILLISECONDS,10*IN_MILLISECONDS);
            }
            else
                uiMortalStrikeTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_gamel_the_cruelAI(creature);
    }
};

/*######
## npc_ragnar_drakkarlund
######*/

enum RagnarDrakk
{
    SPELL_WHIRLWIND_R = 41056,
};

class npc_ragnar_drakkarlund : public CreatureScript
{
public:
    npc_ragnar_drakkarlund() : CreatureScript("npc_ragnar_drakkarlund") { }

    struct npc_ragnar_drakkarlundAI : public ScriptedAI
    {
        npc_ragnar_drakkarlundAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiWhirlwindTimer;

        void Reset() OVERRIDE
        {
            uiWhirlwindTimer = urand(2*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (uiWhirlwindTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_WHIRLWIND_R);
                uiWhirlwindTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiWhirlwindTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_ragnar_drakkarlundAI(creature);
    }
};

/*######
## npc_skadir_mariner
######*/

enum SkadirMariner
{
    SPELL_DEMORALIZING_SHOUT = 13730,
    SPELL_UPPERCUT = 10966,
};

class npc_skadir_mariner : public CreatureScript
{
public:
    npc_skadir_mariner() : CreatureScript("npc_skadir_mariner") { }

    struct npc_skadir_marinerAI : public ScriptedAI
    {
        npc_skadir_marinerAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiDemoralizingShoutTimer;
        uint32 uiUppercutTimer;

        void Reset() OVERRIDE
        {
            uiDemoralizingShoutTimer = urand(6*IN_MILLISECONDS,10*IN_MILLISECONDS);
            uiUppercutTimer = urand(2*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (uiDemoralizingShoutTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_DEMORALIZING_SHOUT);
                uiDemoralizingShoutTimer = urand(8*IN_MILLISECONDS,12*IN_MILLISECONDS);
            }
            else
                uiDemoralizingShoutTimer -= uiDiff;

            if (uiUppercutTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_UPPERCUT);
                uiUppercutTimer = urand(2*IN_MILLISECONDS,6*IN_MILLISECONDS);
            }
            else
                uiUppercutTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_skadir_marinerAI(creature);
    }
};

/*######
## npc_skadir_runecaster
######*/

enum SkadirRunecaster
{
    SPELL_LIGHTNING_BOLT = 9532,
    SPELL_RUNE_OF_RETRIBUTION = 49871,
};

class npc_skadir_runecaster : public CreatureScript
{
public:
    npc_skadir_runecaster() : CreatureScript("npc_skadir_runecaster") { }

    struct npc_skadir_runecasterAI : public ScriptedAI
    {
        npc_skadir_runecasterAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiLightningBoltTimer;
        uint32 uiRuneOFRetributionTimer;

        void Reset() OVERRIDE
        {
            uiRuneOFRetributionTimer = urand(6*IN_MILLISECONDS,10*IN_MILLISECONDS);
            uiLightningBoltTimer = urand(2*IN_MILLISECONDS,6*IN_MILLISECONDS);
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

            if (uiRuneOFRetributionTimer <= uiDiff)
            {
                DoCast(me,SPELL_RUNE_OF_RETRIBUTION);
                uiRuneOFRetributionTimer = urand(8*IN_MILLISECONDS,12*IN_MILLISECONDS);
            }
            else
                uiRuneOFRetributionTimer -= uiDiff;

            if (uiLightningBoltTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_LIGHTNING_BOLT);
                uiLightningBoltTimer = urand(2*IN_MILLISECONDS,6*IN_MILLISECONDS);
            }
            else
                uiLightningBoltTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_skadir_runecasterAI(creature);
    }
};

/*######
## npc_leviroth
######*/

enum Leviroth
{
    SPELL_MORTAL_STRIKE_L = 19643,
    QUEST_THE_EMISSARY = 11626,
};

class npc_leviroth : public CreatureScript
{
public:
    npc_leviroth() : CreatureScript("npc_leviroth") { }

    struct npc_levirothAI : public ScriptedAI
    {
        npc_levirothAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiMortalStrikeLTimer;

        void Reset() OVERRIDE
        {
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_1);
            me->SetReactState(REACT_PASSIVE);
            uiMortalStrikeLTimer = urand(3*IN_MILLISECONDS,8*IN_MILLISECONDS);
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

            if (uiMortalStrikeLTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_MORTAL_STRIKE_L);
                uiMortalStrikeLTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiMortalStrikeLTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_levirothAI(creature);
    }
};

/*######
## npc_mobu
######*/

class npc_mobu : public CreatureScript
{
public:
    npc_mobu() : CreatureScript("npc_mobu") { }

    struct npc_mobuAI : public ScriptedAI
    {
        npc_mobuAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiTalkTimer;

        void Reset() OVERRIDE
        {
            uiTalkTimer = urand(60*IN_MILLISECONDS,90*IN_MILLISECONDS);
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (uiTalkTimer <= uiDiff)
            {
                me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                Talk(0);
                uiTalkTimer = urand(60*IN_MILLISECONDS,90*IN_MILLISECONDS);
            }
            else
                uiTalkTimer -= uiDiff;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_mobuAI(creature);
    }
};

/*######
## npc_enraged_tempest
######*/

enum EnragedT
{
    SPELL_ENRAGE_E = 50420,
    SPELL_ZEPHYR = 50215,
};

class npc_enraged_tempest : public CreatureScript
{
public:
    npc_enraged_tempest() : CreatureScript("npc_enraged_tempest") { }

    struct npc_enraged_tempestAI : public ScriptedAI
    {
        npc_enraged_tempestAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiEnrageETimer;
        uint32 uiZephyrTimer;

        void Reset() OVERRIDE
        {
            uiEnrageETimer = urand(60*IN_MILLISECONDS,90*IN_MILLISECONDS);
            uiZephyrTimer = urand(60*IN_MILLISECONDS,90*IN_MILLISECONDS);
        }

        void JustDied(Unit* killer)
        {
            DoCast(killer,SPELL_ZEPHYR);
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

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_enraged_tempestAI(creature);
    }
};

/*######
## npc_boiling_spirit
######*/

enum BoilingSpirit
{
    SPELL_SCALDING_STEAM = 50206,
};

class npc_boiling_spirit : public CreatureScript
{
public:
    npc_boiling_spirit() : CreatureScript("npc_boiling_spirit") { }

    struct npc_boiling_spiritAI : public ScriptedAI
    {
        npc_boiling_spiritAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiBoilingSpiritTimer;

        void Reset() OVERRIDE
        {
            uiBoilingSpiritTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
        }

        void EnterCombat(Unit* who)
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

            if (uiBoilingSpiritTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_SCALDING_STEAM);
                uiBoilingSpiritTimer = urand(7*IN_MILLISECONDS,12*IN_MILLISECONDS);
            }
            else
                uiBoilingSpiritTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_boiling_spiritAI(creature);
    }
};

/*######
## npc_raging_boiler
######*/

enum RagingB
{
    SPELL_BOILING_BLOOD = 50207,
};

class npc_raging_boiler : public CreatureScript
{
public:
    npc_raging_boiler() : CreatureScript("npc_raging_boiler") { }

    struct npc_raging_boilerAI : public ScriptedAI
    {
        npc_raging_boilerAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiBoilingBloodTimer;

        void Reset() OVERRIDE
        {
            uiBoilingBloodTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
        }

        void EnterCombat(Unit* who)
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

            if (uiBoilingBloodTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_BOILING_BLOOD);
                uiBoilingBloodTimer = urand(7*IN_MILLISECONDS,12*IN_MILLISECONDS);
            }
            else
                uiBoilingBloodTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_raging_boilerAI(creature);
    }
};

/*######
## npc_churn
######*/

class npc_churn : public CreatureScript
{
public:
    npc_churn() : CreatureScript("npc_churn") { }

    struct npc_churnAI : public ScriptedAI
    {
        npc_churnAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiBoilingSpiritTimer;
        uint32 uiEventTimer;
        uint8 phase;

        void Reset() OVERRIDE
        {
            uiEventTimer = 7000;
            phase = 0;
            me->setFaction(1983);
            uiBoilingSpiritTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
        }

        void EnterCombat(Unit* who)
        {
            Talk(0);
            if (me->IsValidAttackTarget(who))
                AttackStart(who);
        }

        void DamageTaken(Unit* who, uint32& damage)
        {
            if (damage > me->GetHealth())
            {
                    if (Player* player = who->GetCharmerOrOwnerPlayerOrPlayerItself())
                    {
                        if (player->GetQuestStatus(11627) == QUEST_STATUS_INCOMPLETE)
                        {
                            Talk(1);
                            damage = 0;
                            me->DeleteThreatList();
                            me->RemoveAllAuras();
                            me->CastStop();
                            me->CombatStop(true);
                            me->setFaction(35);
                            me->SetReactState(REACT_PASSIVE);
                            player->KilledMonsterCredit(25418,0);
                            phase = 1;
                        }
                }
            }
        }

        void UpdateAI(uint32 uiDiff)
        {
            if (uiEventTimer <= uiDiff)
            {
                switch(phase)
                {
                case 1:
                    Talk(2);
                    phase++;
                    uiEventTimer = 7000;
                    break;
                case 2:
                    Talk(3);
                    phase++;
                    uiEventTimer = 7000;
                    break;
                case 3:
                    Talk(4);
                    phase++;
                    uiEventTimer = 7000;
                    break;
                case 4:
                    me->DespawnOrUnsummon(0);
                    break;
                }
            }
            else
                uiEventTimer -= uiDiff;
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uiBoilingSpiritTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_SCALDING_STEAM);
                uiBoilingSpiritTimer = urand(7*IN_MILLISECONDS,12*IN_MILLISECONDS);
            }
            else
                uiBoilingSpiritTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_churnAI(creature);
    }
};

/*######
## npc_simmer
######*/

class npc_simmer : public CreatureScript
{
public:
    npc_simmer() : CreatureScript("npc_simmer") { }

    struct npc_simmerAI : public ScriptedAI
    {
        npc_simmerAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiEventTimer;
        uint8 phase;

        void Reset() OVERRIDE
        {
            uiEventTimer = 7000;
            phase = 0;
            me->setFaction(1984);
        }

        void EnterCombat(Unit* who)
        {
            Talk(0);
            if (me->IsValidAttackTarget(who))
                AttackStart(who);
        }

        void DamageTaken(Unit* who, uint32& damage)
        {
            if (damage > me->GetHealth())
                {
                    if (Player* player = who->GetCharmerOrOwnerPlayerOrPlayerItself())
                    {
                        if (player->GetQuestStatus(11627) == QUEST_STATUS_INCOMPLETE)
                        {
                            Talk(1);
                            damage = 0;
                            me->SetReactState(REACT_PASSIVE);
                            me->setFaction(35);
                            me->DeleteThreatList();
                            me->RemoveAllAuras();
                            me->CastStop();
                            me->CombatStop(true);
                            player->KilledMonsterCredit(25416,0);
                            phase = 1;
                        }
                    }
                }

        }

        void UpdateAI(uint32 uiDiff)
        {
            if (uiEventTimer <= uiDiff)
            {
                switch(phase)
                {
                case 1:
                    Talk(2);
                    phase++;
                    uiEventTimer = 7000;
                    break;
                case 2:
                    Talk(3);
                    phase++;
                    uiEventTimer = 7000;
                    break;
                case 3:
                    Talk(4);
                    phase++;
                    uiEventTimer = 7000;
                    break;
                case 4:
                    me->DespawnOrUnsummon(0);
                    break;
                }
            }
            else
                uiEventTimer -= uiDiff;
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_simmerAI(creature);
    }
};

/*######
## npc_kaganishu
######*/

enum kaganishu
{
    SPELL_BLAST_WAVE = 15744,
    SPELL_FIREBALL_K = 19816,
};

class npc_kaganishu : public CreatureScript
{
public:
    npc_kaganishu() : CreatureScript("npc_kaganishu") { }

    struct npc_kaganishuAI : public ScriptedAI
    {
        npc_kaganishuAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiBlastWaveTimer;
        uint32 uiFireBallKTimer;

        void Reset() OVERRIDE
        {
            uiBlastWaveTimer = urand(7*IN_MILLISECONDS,10*IN_MILLISECONDS);
            uiFireBallKTimer = urand(2*IN_MILLISECONDS,5*IN_MILLISECONDS);
        }

        void EnterCombat(Unit* who)
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

            if (uiBlastWaveTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_FIREBALL_K);
                uiBlastWaveTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
            }
            else
                uiBlastWaveTimer -= uiDiff;

            if (uiBlastWaveTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_BLAST_WAVE);
                uiBlastWaveTimer = urand(7*IN_MILLISECONDS,11*IN_MILLISECONDS);
            }
            else
                uiBlastWaveTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_kaganishuAI(creature);
    }
};

/*#####
### npc_longrunner_proudhoof
#####*/

enum LongrunnerP
{
    SPELL_FORCEFUL_CLEAVE = 15284,
    QUEST_WE_STRIKE = 11592,
};

const uint32 Ambush[2] =
{
    25351, 25350
};

class npc_longrunner_proudhoof : public CreatureScript
{
public:
    npc_longrunner_proudhoof() : CreatureScript("npc_longrunner_proudhoof") { }

    struct npc_longrunner_proudhoofAI : public npc_escortAI
    {
        npc_longrunner_proudhoofAI(Creature* creature) : npc_escortAI(creature) {}

        uint32 uiDemoralizingShoutTimer;
        uint32 uiForcfulCleaveTimer;

       void Despawn()
       {
           std::list<Creature*> despawncreature;
           me->GetCreatureListWithEntryInGrid(despawncreature, 25338, 20.0f);
           if (!despawncreature.empty())
           {
               for (std::list<Creature*>::iterator itr = despawncreature.begin(); itr != despawncreature.end(); itr++)
               {
                   (*itr)->DespawnOrUnsummon(0);
               }
           }
       }

       void EnterCombat(Unit* who)
        {
            if (HasEscortState(STATE_ESCORT_ESCORTING))
            {
            }
        }

        void WaypointReached(uint32 waypointId)
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 1:
                    Talk(0, player);
                    me->HandleEmoteCommand(EMOTE_STATE_TALK);
                    break;
                case 2:
                    Talk(1);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                    break;
                case 10:
                    Talk(2);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                    me->SummonCreature(Ambush[urand(0, 1)], 3995.85f,5795.46f,74.0049f, 4.188f, TEMPSUMMON_DEAD_DESPAWN, 10000);
                    me->SummonCreature(Ambush[urand(0, 1)], 3986.02f,5795.18f,73.74f,5.048f, TEMPSUMMON_DEAD_DESPAWN, 10000);
                    me->SummonCreature(Ambush[urand(0, 1)], 3979.30f,5791.50f,73.596f,5.417f, TEMPSUMMON_DEAD_DESPAWN, 10000);
                    me->SummonCreature(Ambush[urand(0, 1)], 3985.41f,5779.77f,73.328f,1.4392f, TEMPSUMMON_DEAD_DESPAWN, 10000);
                    me->SummonCreature(Ambush[urand(0, 1)], 3992.84f,5780.50f,72.771f,2.0754f, TEMPSUMMON_DEAD_DESPAWN, 10000);
                    me->SummonCreature(Ambush[urand(0, 1)], 3998.70f,5785.02f,72.920f,2.5859f, TEMPSUMMON_DEAD_DESPAWN, 10000);
                    break;
                case 11:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                    Talk(3);
                    break;
                case 17:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                    Talk(4);
                    break;
                case 18:
                    if (Creature *creature = me->SummonCreature(25359, 3878.37f,5719.22f,66.303f,0.9609f, TEMPSUMMON_DEAD_DESPAWN, 10000))
                    {
                        if (creature)
                            me->AI()->AttackStart(creature);
                    }
                    break;
                case 19:
                    player->AreaExploredOrEventHappens(QUEST_WE_STRIKE);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                    Talk(5);
                    break;
                case 20:
                    Despawn();
                    me->DespawnOrUnsummon(5);
                    break;
            }
        }

        void Reset()
        {
            me->SetSpeed(MOVE_RUN,0.9f,true);
        }

        void JustDied(Unit* /*killer*/)
        {
            Player* player = GetPlayerForEscort();
            if (player && HasEscortState(STATE_ESCORT_ESCORTING))
            {
                if (player->GetQuestStatus(QUEST_WE_STRIKE))
                    player->FailQuest(QUEST_WE_STRIKE);

                me->DespawnOrUnsummon(8000);
                Despawn();
            }
        }

        void UpdateAI(uint32 uiDiff)
        {
            npc_escortAI::UpdateAI(uiDiff);

            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uiDemoralizingShoutTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_DEMORALIZING_SHOUT);
                uiDemoralizingShoutTimer = urand(8*IN_MILLISECONDS,12*IN_MILLISECONDS);
            }
            else
                uiDemoralizingShoutTimer -= uiDiff;

            if (uiForcfulCleaveTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_FORCEFUL_CLEAVE);
                uiForcfulCleaveTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            }
            else
                uiForcfulCleaveTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
    {
        if (quest->GetQuestId() == QUEST_WE_STRIKE)
        {
            CAST_AI(npc_escortAI, (creature->AI()))->Start(true, true, player->GetGUID(),0,true);
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_longrunner_proudhoofAI(creature);
    }
};

/*######
## npc_steeljaw
######*/

enum Steeljaw
{
    SPELL_CLEAVE_S = 15284,
    SPELL_PIERCING_HOWL = 38256,
    SPELL_STEEL_JAW = 50204,
    SPELL_WHIRLWIND_S = 41056,
};

class npc_steeljaw : public CreatureScript
{
public:
    npc_steeljaw() : CreatureScript("npc_steeljaw") { }

    struct npc_steeljawAI : public ScriptedAI
    {
        npc_steeljawAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiCleaveSTimer;
        uint32 uiPiercingHowlTimer;
        uint32 uiSteelJawTimer;
        uint32 uiWhirlWindSTimer;

        void Reset() OVERRIDE
        {
            uiPiercingHowlTimer = urand(7*IN_MILLISECONDS,13*IN_MILLISECONDS);
            uiCleaveSTimer = urand(2*IN_MILLISECONDS,5*IN_MILLISECONDS);
            uiSteelJawTimer = urand(10*IN_MILLISECONDS,15*IN_MILLISECONDS);
            uiWhirlWindSTimer = urand(6*IN_MILLISECONDS,12*IN_MILLISECONDS);
        }

        void EnterCombat(Unit* who)
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(0);
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uiCleaveSTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_CLEAVE_S);
                uiCleaveSTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
            }
            else
                uiCleaveSTimer -= uiDiff;

            if (uiPiercingHowlTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_PIERCING_HOWL);
                uiPiercingHowlTimer = urand(7*IN_MILLISECONDS,13*IN_MILLISECONDS);
            }
            else
                uiPiercingHowlTimer -= uiDiff;

            if (uiWhirlWindSTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_WHIRLWIND_S);
                uiWhirlWindSTimer = urand(6*IN_MILLISECONDS,12*IN_MILLISECONDS);
            }
            else
                uiWhirlWindSTimer -= uiDiff;

            if (uiSteelJawTimer <= uiDiff)
            {
                DoCast(me,SPELL_STEEL_JAW);
                uiSteelJawTimer = urand(10*IN_MILLISECONDS,15*IN_MILLISECONDS);
            }
            else
                uiSteelJawTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_steeljawAI(creature);
    }
};

/*######
## npc_warsong_caravan_guard
######*/

enum WarsongCaravan
{
    SPELL_STRIKE = 11976,
};

class npc_warsong_caravan_guard : public CreatureScript
{
public:
    npc_warsong_caravan_guard() : CreatureScript("npc_warsong_caravan_guard") { }

    struct npc_warsong_caravan_guardAI : public ScriptedAI
    {
        npc_warsong_caravan_guardAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiStrikeTimer;

        void Reset() OVERRIDE
        {
            uiStrikeTimer = urand(4*IN_MILLISECONDS,8*IN_MILLISECONDS);
            me->SetSpeed(MOVE_RUN,0.9f,true);
        }

        void EnterCombat(Unit* who)
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

            if (uiStrikeTimer <= uiDiff)
            {
                DoCast(me->GetVictim(),SPELL_STRIKE);
                uiStrikeTimer = urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS);
            }
            else
                uiStrikeTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_warsong_caravan_guardAI(creature);
    }
};

/*######
## npc_kaw_the_mammoth_destroyer
######*/

enum KawMammoth
{
};

class npc_kaw_the_mammoth_destroyer : public CreatureScript
{
public:
    npc_kaw_the_mammoth_destroyer() : CreatureScript("npc_kaw_the_mammoth_destroyer") { }

    struct npc_kaw_the_mammoth_destroyerAI : public ScriptedAI
    {
        npc_kaw_the_mammoth_destroyerAI(Creature* creature) : ScriptedAI(creature){}

        Player *player;
        uint32 uiGoTimer;
        uint32 uiCheckPlayerTimer;
        uint32 uiCheckSpawnTimer;
        uint8 phase;
        bool checked;

        void Reset() OVERRIDE
        {
            if (me->GetDistance2d(me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY()) > 3.0f)
                me->GetMotionMaster()->MovePoint(0,me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY(), me->GetHomePosition().GetPositionZ());

            player = NULL;
            checked = false;
            uiCheckSpawnTimer = 2*IN_MILLISECONDS;
            uiCheckPlayerTimer = 2*IN_MILLISECONDS;
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_1);
            me->SetReactState(REACT_PASSIVE);
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);
        }

        void Despawn()
        {
            me->DespawnOrUnsummon(1);

            if (Creature *creature = me->FindNearestCreature(25881, 100.0f))
            {
                if(creature)
                    creature->DespawnOrUnsummon(1);
            }
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (uiCheckPlayerTimer <= uiDiff)
            {
                if(!checked)
                {
                    if(player = me->SelectNearestPlayer(20.0f))
                    {
                        if(!player)
                        {
                            Despawn();
                            me->DespawnOrUnsummon(1);
                            return;
                        }

                        if (player->GetQuestStatus(11879) == QUEST_STATUS_INCOMPLETE)
                        {
                            phase = 1;
                            uiGoTimer = 2000;
                            checked = true;
                            uiCheckPlayerTimer = 2*IN_MILLISECONDS;
                        }
                        uiCheckPlayerTimer = 2*IN_MILLISECONDS;
                    }
                }
            }
            else
                uiCheckPlayerTimer -= uiDiff;

           if(uiGoTimer <= uiDiff)
           {
               switch(phase)
               {
               case 1:
                   Talk(0);
                   uiGoTimer = 4000;
                   phase++;
                   break;
               case 2:
                   me->GetMotionMaster()->MovePoint(0,3972.63f,5478.22f,35.62f);
                   uiGoTimer = 3000;
                   phase++;
                   break;
               case 3:
                   me->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                   if (Creature* creature = me->FindNearestCreature(25881, 20.0f,false))
                       if (creature)
                           creature->Respawn(true);
                   uiGoTimer = 3000;
                   phase++;
                   break;
               case 4:
                   me->GetMotionMaster()->MovePoint(0,3955.96f,5478.46f,35.619f);
                   phase++;
                   uiGoTimer = 3000;
                   break;
               case 5:
                   me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_1);
                   me->SetReactState(REACT_AGGRESSIVE);
                   me->AI()->AttackStart(player);
                   if (Creature *creature = me->FindNearestCreature(25881, 20.0f,true))
                       if(creature)
                       {
                           creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_1);
                           creature->SetReactState(REACT_AGGRESSIVE);
                           creature->AI()->AttackStart(player);
                       }
                   phase++;
                   uiGoTimer = 500*IN_MILLISECONDS;
                   break;
               }
           }
           else uiGoTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_kaw_the_mammoth_destroyerAI(creature);
    }
};

/*######
## npc_moria
######*/

enum NpcMoria
{
    EVENT_CHECK_SPAWN,
    EVENT_FRESH_TIMER,
};

class npc_moria : public CreatureScript
{
public:
    npc_moria() : CreatureScript("npc_moria") { }

    struct npc_moriaAI : public ScriptedAI
    {
        npc_moriaAI(Creature* creature) : ScriptedAI(creature){}

        void Reset()
        {
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_1);
            me->SetReactState(REACT_PASSIVE);
            _events.Reset();
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);
            _events.ScheduleEvent(EVENT_CHECK_SPAWN, 2*IN_MILLISECONDS);
            _events.ScheduleEvent(EVENT_FRESH_TIMER, 2*IN_MILLISECONDS);
        }

        void UpdateAI(uint32 diff)
        {
            _events.Update(diff);

            switch (_events.ExecuteEvent())
            {
                case EVENT_CHECK_SPAWN:
                    if (!me->GetVictim())
                        if (me->GetDistance2d(me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY()) > 3.0f)
                        {
                            me->GetMotionMaster()->MovePoint(0,me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY(), me->GetHomePosition().GetPositionZ());
                            _events.ScheduleEvent(EVENT_CHECK_SPAWN, 6 * IN_MILLISECONDS);
                        }
                        break;
                case EVENT_FRESH_TIMER:
                    if (!me->GetVictim())
                    {
                        if (me->GetDistance2d(me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY()) > 3.0f)
                            me->DespawnOrUnsummon(1);

                        _events.ScheduleEvent(EVENT_FRESH_TIMER, 2 * IN_MILLISECONDS);
                    }
                    if (Creature *creature = me->FindNearestCreature(25802, 100.0f,false))
                        if(creature)
                        {
                            creature->Respawn(true);

                            if (creature->GetDistance2d(creature->GetHomePosition().GetPositionX(), creature->GetHomePosition().GetPositionY()) > 3.0f)
                                creature->GetMotionMaster()->MovePoint(0,creature->GetHomePosition().GetPositionX(), creature->GetHomePosition().GetPositionY(), creature->GetHomePosition().GetPositionZ());
                        }
                        _events.ScheduleEvent(EVENT_FRESH_TIMER, 2 * IN_MILLISECONDS);
                        break;
                default:
                    break;
            }

            if (!UpdateVictim())
                return;
            DoMeleeAttackIfReady();
        }
    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_moriaAI(creature);
    }
};

/*######
## npc_harvest_collector
######*/

enum HarvestC
{
    SPELL_CLAW_SLASH            = 54185,
    SPELL_CONVERTING_HARVEST    = 47166,
    QUEST_REPURPOSED_TECHNOLOGY = 12035,
    // events
    EVENT_HARVEST_COLLECTOR_TIMER,
};

class npc_harvest_collector : public CreatureScript
{
public:
    npc_harvest_collector() : CreatureScript("npc_harvest_collector") { }

    struct npc_harvest_collectorAI : public ScriptedAI
    {
        npc_harvest_collectorAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiHarvestCollectorTimer;

        void Reset() OVERRIDE
        {
            _events.Reset();
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);

            _events.ScheduleEvent(EVENT_HARVEST_COLLECTOR_TIMER, urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS));
        }

        void SpellHit(Unit* caster, const SpellInfo* spell)
        {
            if (spell->Id != SPELL_CONVERTING_HARVEST)
                return;

            Player* player = caster->ToPlayer();
            if (player && player->GetQuestStatus(QUEST_REPURPOSED_TECHNOLOGY) == QUEST_STATUS_INCOMPLETE)
            {
                me->DespawnOrUnsummon(1);
            }
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            _events.Update(diff);

            switch (_events.ExecuteEvent())
            {
                case EVENT_HARVEST_COLLECTOR_TIMER:
                    DoCast(me->GetVictim(),SPELL_CLAW_SLASH);
                    _events.ScheduleEvent(EVENT_HARVEST_COLLECTOR_TIMER, urand(3*IN_MILLISECONDS,8*IN_MILLISECONDS));
                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }
    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_harvest_collectorAI(creature);
    }
};

/*######
## npc_scourged_footman
######*/

enum ScourgedFoo
{
    SPELL_BLADE_FLURRY      = 33735,
    SPELL_MORTAL_STRIKE_F   = 32736,
    // EVENTS
    EVENT_BLADEFLURRY,
    EVENT_MORTALSTRIKE
};

class npc_scourged_footman : public CreatureScript
{
public:
    npc_scourged_footman() : CreatureScript("npc_scourged_footman") { }

    struct npc_scourged_footmanAI : public ScriptedAI
    {
        npc_scourged_footmanAI(Creature* creature) : ScriptedAI(creature){}

        void Reset() OVERRIDE
        {
            _events.Reset();
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);
            _events.ScheduleEvent(EVENT_BLADEFLURRY, urand(3 * IN_MILLISECONDS,6 * IN_MILLISECONDS));
            _events.ScheduleEvent(EVENT_MORTALSTRIKE, urand(6 * IN_MILLISECONDS,10 * IN_MILLISECONDS));
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            _events.Update(diff);

            switch (_events.ExecuteEvent())
            {
                case EVENT_MORTALSTRIKE:
                    DoCast(me->GetVictim(),SPELL_MORTAL_STRIKE_F);
                    _events.ScheduleEvent(EVENT_BLADEFLURRY, urand(3 * IN_MILLISECONDS,8 * IN_MILLISECONDS));
                    break;
                case EVENT_BLADEFLURRY:
                    DoCast(me,SPELL_BLADE_FLURRY);
                    _events.ScheduleEvent(EVENT_BLADEFLURRY, urand(7*IN_MILLISECONDS,10*IN_MILLISECONDS));
                    break;
                default:
                    break;
            }
            DoMeleeAttackIfReady();
        }
    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_scourged_footmanAI(creature);
    }
};

/*######
## npc_converted_harvest_collector
######*/

class npc_converted_harvest_collector : public CreatureScript
{
public:
    npc_converted_harvest_collector() : CreatureScript("npc_converted_harvest_collector") { }

    struct npc_converted_harvest_collectorAI : public ScriptedAI
    {
        npc_converted_harvest_collectorAI(Creature* creature) : ScriptedAI(creature){}

        uint32 uiEventTimer;
        uint32 uiDespawnTimer;
        uint8 phase;
        Creature *creature;

        void Reset() OVERRIDE
        {
            creature = NULL;
            uiEventTimer = 2*IN_MILLISECONDS;
            uiDespawnTimer = 20*IN_MILLISECONDS;
            phase = 1;
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (uiDespawnTimer <= uiDiff)
            {
                if (!me->GetVictim())
                {
                    me->DespawnOrUnsummon(2);
                }
            }
            else
                uiDespawnTimer -= uiDiff;

            if (uiEventTimer <= uiDiff)
            {
                switch(phase)
                {
                case 1:
                    if(creature = me->SummonCreature(26658, me->GetPositionX()+5,me->GetPositionY(),me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000))
                        if(creature)
                        {
                            me->AI()->AttackStart(creature);
                            me->AddThreat(creature,0.0f);
                        }
                    uiEventTimer = 2000;
                    phase++;
                    break;
                }
            }
            else
                uiEventTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_converted_harvest_collectorAI(creature);
    }
};

/*######
## npc_rocknar
######*/

enum RockN
{
    SPELL_HARDEN_SKIN       = 22693,
    SPELL_ICE_SPIKE         = 50094,
    // events
    EVENT_HARDEN_SKIN_TIMER,
    EVENT_ICE_SPIKE_TIMER,
};

class npc_rocknar : public CreatureScript
{
public:
    npc_rocknar() : CreatureScript("npc_rocknar") { }

    struct npc_rocknarAI : public ScriptedAI
    {
        npc_rocknarAI(Creature* creature) : ScriptedAI(creature){}


        void Reset() OVERRIDE
        {
            _events.Reset();
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            if (me->IsValidAttackTarget(who))
                AttackStart(who);
            _events.RescheduleEvent(EVENT_HARDEN_SKIN_TIMER,urand(3*IN_MILLISECONDS,6*IN_MILLISECONDS));
            _events.RescheduleEvent(EVENT_ICE_SPIKE_TIMER, urand(7*IN_MILLISECONDS,12*IN_MILLISECONDS));
            Talk(0);
        }

        void JustDied(Unit* killer) OVERRIDE
        {
            Talk(1);
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            _events.Update(diff);

            switch (_events.ExecuteEvent())
            {
                case EVENT_ICE_SPIKE_TIMER:
                    DoCast(me->GetVictim(),SPELL_ICE_SPIKE);
                    _events.RescheduleEvent(EVENT_HARDEN_SKIN_TIMER, urand(5*IN_MILLISECONDS,9*IN_MILLISECONDS));
                    break;
                case EVENT_HARDEN_SKIN_TIMER:
                    DoCast(me,SPELL_HARDEN_SKIN);
                    _events.RescheduleEvent(EVENT_HARDEN_SKIN_TIMER, urand(12*IN_MILLISECONDS,18*IN_MILLISECONDS));
                    break;
                default:
                    break;
            }
            DoMeleeAttackIfReady();
        }
    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_rocknarAI(creature);
    }
};

void AddSC_borean_tundra()
{
    new npc_sinkhole_kill_credit();
    new npc_khunok_the_behemoth();
    new npc_keristrasza();
    new npc_corastrasza();
    new npc_iruk();
    new npc_nerubar_victim();
    new npc_jenny();
    new npc_fezzix_geartwist();
    new npc_nesingwary_trapper();
    new npc_lurgglbr();
    new npc_nexus_drake_hatchling();
    new npc_thassarian();
    new npc_image_lich_king();
    new npc_counselor_talbot();
    new npc_leryssa();
    new npc_general_arlos();
    new npc_beryl_sorcerer();
    new npc_imprisoned_beryl_sorcerer();
    new npc_mootoo_the_younger();
    new npc_bonker_togglevolt();
    new npc_trapped_mammoth_calf();
    new npc_magmoth_crusher();
    new npc_seaforium_depth_charge();
    new npc_valiance_keep_cannoneer();
    new npc_warmage_coldarra();
    new npc_hidden_cultist();
    new npc_warsong_hold_mage();
    new npc_warsong_hold_warrior();
    new npc_warsong_hold_shaman();
    new npc_warsong_hold_peon();
    new npc_warsong_unliving_swine();
    new npc_warsong_enkilah_necrolord();
    new npc_torps_farm_dummy();
    new npc_nerubar_skitterer();
    new npc_nerubar_web_lord();
    new npc_nerubar_corpse_harvester();
    new npc_kvaldir_mist_lord();
    new npc_kvaldir_mistweaver();
    new npc_warden_nork_bloodfrenzy();
    new npc_valiance_keep_officer();
    new npc_bloodspore_harvester();
    new npc_bloodspore_roaster();
    new npc_bloodspore_moth();
    new npc_beryl_mage_hunter();
    new npc_steam_rager();
    new npc_dorain_frosthoof();
    new npc_gorloc_gibberer();
    new npc_gorloc_steam_belcher();
    new npc_gorloc_waddler();
    new npc_chieftain_gurgleboggle();
    new npc_nerubar_tunneler();
    new npc_nerubar_warrior();
    new npc_ziggurat_defender();
    new npc_tundra_crawler();
    new npc_enkilah_abomination();
    new npc_enkilah_gargoyle();
    new npc_crypt_fiend_b();
    new npc_blood_globe();
    new npc_killcredit_templeA();
    new npc_killcredit_templeB();
    new npc_killcredit_templeC();
    new npc_naxxanar_segundo_piso();
    new npc_darkfallen_deathblade();
    new npc_mother_tauranook();
    new npc_taunkale_evacuee();
    new npc_northsea_mercenary();
    new npc_karen_the_culler();
    new npc_clam_master_k();
    new npc_heigarr_the_horrible();
    new npc_kaskala_defender();
    new npc_ghostly_sage();
    new npc_claximus();
    new npc_scalder();
    new npc_archmage_evanor();
    new npc_skadir_raider();
    new npc_gamel_the_cruel();
    new npc_ragnar_drakkarlund();
    new npc_skadir_mariner();
    new npc_skadir_runecaster();
    new npc_leviroth();
    new npc_mobu();
    new npc_boiling_spirit();
    new npc_enraged_tempest();
    new npc_churn();
    new npc_simmer();
    new npc_raging_boiler();
    new npc_kaganishu();
    new npc_longrunner_proudhoof();
    new npc_steeljaw();
    new npc_warsong_caravan_guard();
    new npc_kaw_the_mammoth_destroyer();
    new npc_moria();
    new npc_harvest_collector();
    new npc_scourged_footman();
    new npc_converted_harvest_collector();
    new npc_rocknar();
}
