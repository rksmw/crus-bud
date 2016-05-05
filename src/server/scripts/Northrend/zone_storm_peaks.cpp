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
#include "ScriptedGossip.h"
#include "ScriptedEscortAI.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "Vehicle.h"
#include "CombatAI.h"
#include "Player.h"
#include "WorldSession.h"
#include "GameObjectAI.h"

/////////////////////
///npc_injured_goblin
/////////////////////

enum InjuredGoblinMiner
{
    QUEST_BITTER_DEPARTURE     = 12832,
    SAY_QUEST_ACCEPT           = 0,
    SAY_END_WP_REACHED         = 1,
    GOSSIP_ID                  = 9859,
    GOSSIP_OPTION_ID           = 0
};

class npc_injured_goblin : public CreatureScript
{
public:
    npc_injured_goblin() : CreatureScript("npc_injured_goblin") { }

    struct npc_injured_goblinAI : public npc_escortAI
    {
        npc_injured_goblinAI(Creature* creature) : npc_escortAI(creature) { }

        void WaypointReached(uint32 waypointId) OVERRIDE
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 26:
                    Talk(SAY_END_WP_REACHED, player);
                    break;
                case 27:
                    player->GroupEventHappens(QUEST_BITTER_DEPARTURE, me);
                    break;
            }
        }

        void EnterCombat(Unit* /*who*/) OVERRIDE {}

        void Reset() OVERRIDE {}

        void JustDied(Unit* /*killer*/) OVERRIDE
        {
            Player* player = GetPlayerForEscort();
            if (HasEscortState(STATE_ESCORT_ESCORTING) && player)
                player->FailQuest(QUEST_BITTER_DEPARTURE);
        }

       void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            npc_escortAI::UpdateAI(uiDiff);
            if (!UpdateVictim())
                return;
            DoMeleeAttackIfReady();
        }

        void sGossipSelect(Player* player, uint32 sender, uint32 action) OVERRIDE
        {
            if (sender == GOSSIP_ID && action == GOSSIP_OPTION_ID)
            {
                player->CLOSE_GOSSIP_MENU();
                me->setFaction(113);
                npc_escortAI::Start(true, true, player->GetGUID());
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_injured_goblinAI(creature);
    }

    bool OnQuestAccept(Player* /*player*/, Creature* creature, Quest const* quest) OVERRIDE
    {
        if (quest->GetQuestId() == QUEST_BITTER_DEPARTURE)
            creature->AI()->Talk(SAY_QUEST_ACCEPT);

        return false;
    }
};

/*######
## npc_roxi_ramrocket
######*/

enum RoxiRamrocket
{
    SPELL_MECHANO_HOG               = 60866,
    SPELL_MEKGINEERS_CHOPPER        = 60867
};

class npc_roxi_ramrocket : public CreatureScript
{
public:
    npc_roxi_ramrocket() : CreatureScript("npc_roxi_ramrocket") { }

    bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
    {
        //Quest Menu
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        //Trainer Menu
        if ( creature->IsTrainer() )
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, GOSSIP_TEXT_TRAIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRAIN);

        //Vendor Menu
        if ( creature->IsVendor() )
            if (player->HasSpell(SPELL_MECHANO_HOG) || player->HasSpell(SPELL_MEKGINEERS_CHOPPER))
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) OVERRIDE
    {
        player->PlayerTalkClass->ClearMenus();
        switch (action)
        {
        case GOSSIP_ACTION_TRAIN:
            player->GetSession()->SendTrainerList(creature->GetGUID());
            break;
        case GOSSIP_ACTION_TRADE:
            player->GetSession()->SendListInventory(creature->GetGUID());
            break;
        }
        return true;
    }
};

/*######
## npc_brunnhildar_prisoner
######*/

enum BrunnhildarPrisoner {
    SPELL_ICE_PRISON           = 54894,
    SPELL_ICE_LANCE            = 55046,
    SPELL_FREE_PRISONER        = 55048,
    SPELL_RIDE_DRAKE           = 55074,
    SPELL_SHARD_IMPACT         = 55047
};

class npc_brunnhildar_prisoner : public CreatureScript
{
public:
    npc_brunnhildar_prisoner() : CreatureScript("npc_brunnhildar_prisoner") { }

    struct npc_brunnhildar_prisonerAI : public ScriptedAI
    {
        npc_brunnhildar_prisonerAI(Creature* creature) : ScriptedAI(creature) {}

        bool freed;

        void Reset() OVERRIDE
        {
            freed = false;
            me->CastSpell(me, SPELL_ICE_PRISON, true);
        }

        void JustRespawned() OVERRIDE
        {
            Reset();
        }

        void UpdateAI(uint32 /*diff*/) OVERRIDE
        {
            if (!freed)
                return;

            if (!me->GetVehicle())
                me->DespawnOrUnsummon();
        }

        void SpellHit(Unit* caster, const SpellInfo* spell) OVERRIDE
        {
            if (spell->Id != SPELL_ICE_LANCE)
                return;

            if (caster->GetVehicleKit()->GetAvailableSeatCount() != 0)
            {
                me->CastSpell(me, SPELL_FREE_PRISONER, true);
                me->CastSpell(caster, SPELL_RIDE_DRAKE, true);
                me->CastSpell(me, SPELL_SHARD_IMPACT, true);
                freed = true;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_brunnhildar_prisonerAI(creature);
    }
};

/*######
## npc_freed_protodrake
######*/

enum FreedProtoDrake
{
    NPC_DRAKE                           = 29709,

    AREA_VALLEY_OF_ANCIENT_WINTERS      = 4437,

    TEXT_EMOTE                          = 0,

    SPELL_KILL_CREDIT_PRISONER          = 55144,
    SPELL_SUMMON_LIBERATED              = 55073,
    SPELL_KILL_CREDIT_DRAKE             = 55143,

    EVENT_CHECK_AREA                    = 1,
    EVENT_REACHED_HOME                  = 2,
};

class npc_freed_protodrake : public CreatureScript
{
public:
    npc_freed_protodrake() : CreatureScript("npc_freed_protodrake") { }

    struct npc_freed_protodrakeAI : public VehicleAI
    {
        npc_freed_protodrakeAI(Creature* creature) : VehicleAI(creature) {}

        EventMap events;

        void Reset() OVERRIDE
        {
            events.ScheduleEvent(EVENT_CHECK_AREA, 5000);
        }

        void MovementInform(uint32 type, uint32 id) OVERRIDE
        {
            if (type != WAYPOINT_MOTION_TYPE)
                return;

            if (id == 15)
            // drake reached village
            events.ScheduleEvent(EVENT_REACHED_HOME, 2000);
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            events.Update(diff);

            switch (events.ExecuteEvent())
            {
                case EVENT_CHECK_AREA:
                    if (me->GetAreaId() == AREA_VALLEY_OF_ANCIENT_WINTERS)
                    {
                        if (Vehicle* vehicle = me->GetVehicleKit())
                            if (Unit* passenger = vehicle->GetPassenger(0))
                            {
                                Talk(TEXT_EMOTE, passenger);
                                me->GetMotionMaster()->MovePath(NPC_DRAKE, false);
                            }
                    }
                    else
                        events.ScheduleEvent(EVENT_CHECK_AREA, 5000);
                    break;
                case EVENT_REACHED_HOME:
                    Unit* player = me->GetVehicleKit()->GetPassenger(0);
                    if (player && player->GetTypeId() == TYPEID_PLAYER)
                    {
                        // for each prisoner on drake, give credit
                        for (uint8 i = 1; i < 4; ++i)
                            if (Unit* prisoner = me->GetVehicleKit()->GetPassenger(i))
                            {
                                if (prisoner->GetTypeId() != TYPEID_UNIT)
                                    return;
                                prisoner->CastSpell(player, SPELL_KILL_CREDIT_PRISONER, true);
                                prisoner->CastSpell(prisoner, SPELL_SUMMON_LIBERATED, true);
                                prisoner->ExitVehicle();
                            }
                        me->CastSpell(me, SPELL_KILL_CREDIT_DRAKE, true);
                        player->ExitVehicle();
                    }
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_freed_protodrakeAI(creature);
    }
};

class npc_icefang : public CreatureScript
{
public:
    npc_icefang() : CreatureScript("npc_icefang") { }

    struct npc_icefangAI : public npc_escortAI
    {
        npc_icefangAI(Creature* creature) : npc_escortAI(creature) {}

        void AttackStart(Unit* /*who*/) OVERRIDE {}
        void EnterCombat(Unit* /*who*/) OVERRIDE {}
        void EnterEvadeMode() OVERRIDE {}

        void PassengerBoarded(Unit* who, int8 /*seatId*/, bool apply) OVERRIDE
        {
            if (who->GetTypeId() == TYPEID_PLAYER)
            {
                if (apply)
                    Start(false, true, who->GetGUID());
            }
        }

        void WaypointReached(uint32 /*waypointId*/) OVERRIDE
        {
        }

        void JustDied(Unit* /*killer*/) OVERRIDE
        {
        }

        void OnCharmed(bool /*apply*/) OVERRIDE
        {
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            npc_escortAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_icefangAI(creature);
    }
};

/*######
## Quest 12886: The Drakkensryd
## npc_gretta_the_arbiter
## npc_hyldsmeet_drakerider
## npc_hyldsmeet_protodrake
######*/
 
enum TheDrakkensryd
{
    NPC_DRAKKENSRYD_KC        = 29800,
    SPELL_MORTAL_STRIKE       = 32736,
    QUEST_THE_DRAKKENSRYD     = 12886,
    NPC_HYLDSMEET_PROTO_DRAKE = 29625,
    SPELL_HYLDNIR_HARPOON     = 54933,
    DATA_DESPAWN_EMPTY        = 1
};

class npc_hyldsmeet_protodrake : public CreatureScript
{
    enum NPCs
    {
        NPC_HYLDSMEET_DRAKERIDER = 29694
    };

public:
    npc_hyldsmeet_protodrake() : CreatureScript("npc_hyldsmeet_protodrake") { }

    class npc_hyldsmeet_protodrakeAI : public CreatureAI
    {
    public:
        npc_hyldsmeet_protodrakeAI(Creature* creature) : CreatureAI(creature), _accessoryRespawnTimer(0), _vehicleKit(creature->GetVehicleKit()) {}

        void PassengerBoarded(Unit* who, int8 /*seat*/, bool apply) OVERRIDE
        {
            if (apply)
                return;

            if (who->GetEntry() == NPC_HYLDSMEET_DRAKERIDER)
                _accessoryRespawnTimer = 5 * MINUTE * IN_MILLISECONDS;
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            //! We need to manually reinstall accessories because the vehicle itself is friendly to players,
            //! so EnterEvadeMode is never triggered. The accessory on the other hand is hostile and killable.
            if (_accessoryRespawnTimer && _accessoryRespawnTimer <= diff && _vehicleKit)
            {
                _vehicleKit->InstallAllAccessories(true);
                _accessoryRespawnTimer = 0;
            }
            else
                _accessoryRespawnTimer -= diff;

            if (despawnEmpty)
            {
                if (_vehicleKit->HasEmptySeat(0))
                {
                    me->DespawnOrUnsummon();
                }
            }
        }

        void SetData(uint32 id, uint32 /*data*/)
        {
            if (id == DATA_DESPAWN_EMPTY)
                despawnEmpty = true;
        }

        void Reset()
        {
            despawnEmpty = false;
        }

    private:
        uint32 _accessoryRespawnTimer;
        Vehicle* _vehicleKit;
        bool despawnEmpty;
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_hyldsmeet_protodrakeAI(creature);
    }
};

Position POSITION_TEMPLE_OF_STORMS = { 7541.9f, -592.9f, 1876.4f, 1.18f };

class npc_gretta_the_arbiter : public CreatureScript
{
public:
    npc_gretta_the_arbiter() : CreatureScript("npc_gretta_the_arbiter") { }

    bool OnQuestAccept(Player* player, Creature* /*creature*/, Quest const* quest)
    {
        if (quest->GetQuestId() == QUEST_THE_DRAKKENSRYD)
        {
            if (Creature* drake = player->SummonCreature(NPC_HYLDSMEET_PROTO_DRAKE, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ()))
            {
                drake->SetPhaseMask(3, true);
                if (Vehicle* vehicle = drake->GetVehicleKit())
                {
                    vehicle->RemoveAllPassengers();
                }

                player->CastSpell(drake, SPELL_HYLDNIR_HARPOON);
                drake->GetMotionMaster()->MovePoint(1, POSITION_TEMPLE_OF_STORMS);
                drake->GetAI()->SetData(DATA_DESPAWN_EMPTY, 1);
            }
        }
        return true;
    }
};

class npc_hyldsmeet_drakerider : public CreatureScript
{
public:
    npc_hyldsmeet_drakerider() : CreatureScript("npc_hyldsmeet_drakerider") { }

    struct npc_hyldsmeet_drakeriderAI : public ScriptedAI
    {
        npc_hyldsmeet_drakeriderAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 MortalStrikeTimer;

        void Reset()
        {
            MortalStrikeTimer = urand(2000, 5000);
        }

        void JustDied(Unit* who)
        {
            if (Player* player = who->ToPlayer())
            {
                player->KilledMonsterCredit(NPC_DRAKKENSRYD_KC, 0);
            }
        }

        void UpdateAI(uint32 diff)
        {
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

            if (!UpdateVictim())
                return;

            if (Unit* victim = me->GetVictim())
            {
                if (victim->GetDistance(me) > 10.0f)
                {
                    EnterEvadeMode();
                    return;
                }

                if (MortalStrikeTimer <= diff)
                {
                    DoCast(victim, SPELL_MORTAL_STRIKE, true);
                    MortalStrikeTimer = urand(5000, 9000);
                }
                else
                {
                    MortalStrikeTimer -= diff;
                }

                DoMeleeAttackIfReady();
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_hyldsmeet_drakeriderAI(creature);
    }
};


/*######
## Quest - Sniffing Out the Perpetrator
######*/

enum Perpetrator
{
    SAY_START                      = 0,
    SAY_END                        = 1,
    SPELL_KILLCREDIT_FROSTHOUND    = 55036,
    SPELL_KILLCREDIT_FROSTBITE     = 55477
};

const Position FrosthoundWaypoints[39] =
{
    {7162.149902f, -766.020691f, 892.152588f, 0.0f},
    {7171.987793f, -777.422607f, 898.684998f, 0.0f},
    {7187.317871f, -785.940125f, 907.408020f, 0.0f},
    {7202.274902f, -793.185791f, 916.158569f, 0.0f},
    {7214.814453f, -803.966309f, 921.101501f, 0.0f},
    {7226.921875f, -820.227051f, 925.068726f, 0.0f},
    {7237.213867f, -834.708984f, 926.683655f, 0.0f},
    {7245.674805f, -849.032532f, 925.765503f, 0.0f},
    {7252.709961f, -869.197510f, 924.081238f, 0.0f},
    {7262.165527f, -896.300903f, 925.874329f, 0.0f},
    {7272.839844f, -932.440613f, 922.000610f, 0.0f},
    {7282.525391f, -965.366394f, 918.780701f, 0.0f},
    {7297.675781f, -1000.726929f, 914.107666f, 0.0f},
    {7305.930664f, -1019.994202f, 915.038086f, 0.0f},
    {7316.960449f, -1045.737793f, 913.928284f, 0.0f},
    {7333.487793f, -1080.166260f, 908.669739f, 0.0f},
    {7347.913086f, -1104.555054f, 907.208130f, 0.0f},
    {7346.240723f, -1117.536621f, 909.776978f, 0.0f},
    {7343.162598f, -1140.314697f, 913.794861f, 0.0f},
    {7340.896484f, -1157.085693f, 914.113586f, 0.0f},
    {7338.208008f, -1176.980835f, 915.259644f, 0.0f},
    {7335.015625f, -1197.340942f, 915.237610f, 0.0f},
    {7326.039062f, -1233.333740f, 907.966553f, 0.0f},
    {7312.116211f, -1256.161743f, 906.266235f, 0.0f},
    {7292.583496f, -1284.516479f, 907.185425f, 0.0f},
    {7277.421875f, -1306.525757f, 910.303101f, 0.0f},
    {7267.621582f, -1320.752808f, 912.568604f, 0.0f},
    {7251.995605f, -1343.436646f, 912.406494f, 0.0f},
    {7241.188477f, -1371.170654f, 914.588013f, 0.0f},
    {7219.236816f, -1409.443237f, 912.093567f, 0.0f},
    {7220.445801f, -1433.805664f, 913.447083f, 0.0f},
    {7232.791504f, -1459.494629f, 912.791809f, 0.0f},
    {7259.550293f, -1473.547119f, 915.815063f, 0.0f},
    {7276.904785f, -1486.366577f, 920.097473f, 0.0f},
    {7283.638672f, -1502.776123f, 920.624634f, 0.0f},
    {7290.375488f, -1519.192627f, 923.513916f, 0.0f},
    {7296.846680f, -1534.961548f, 929.333191f, 0.0f},
    {7303.275879f, -1558.437500f, 938.969482f, 0.0f},
    {7307.739258f, -1577.170166f, 942.870605f, 0.0f}
};

const Position FrostbiteWaypoints[15] =
{
    {7715.676270f, -1130.942261f, 921.740417f, 0.0f},
    {7699.728516f, -1148.528687f, 925.867981f, 0.0f},
    {7645.460449f, -1182.291382f, 923.241516f, 0.0f},
    {7608.987793f, -1224.556885f, 929.866333f, 0.0f},
    {7599.126953f, -1244.165039f, 927.658142f, 0.0f},
    {7589.936035f, -1253.751465f, 925.930969f, 0.0f},
    {7559.081543f, -1288.209961f, 924.642151f, 0.0f},
    {7496.391113f, -1368.657593f, 932.213013f, 0.0f},
    {7467.530762f, -1389.297485f, 929.215820f, 0.0f},
    {7392.699219f, -1455.463013f, 927.157166f, 0.0f},
    {7362.146973f, -1495.893188f, 929.525818f, 0.0f},
    {7320.009766f, -1538.392700f, 932.739868f, 0.0f},
    {7308.441406f, -1556.686401f, 938.762207f, 0.0f},
    {7303.769043f, -1566.709839f, 940.989075f, 0.0f},
    {7307.342285f, -1581.483398f, 943.425293f, 0.0f}
};


class npc_frosthound : public CreatureScript
{
public:
    npc_frosthound() : CreatureScript("npc_frosthound") { }

    struct npc_frosthoundAI : public VehicleAI
    {
        npc_frosthoundAI(Creature* creature) : VehicleAI(creature) {}

        bool wpReached;
        uint16 countWP;

        void MovementInform(uint32 type, uint32 id) OVERRIDE
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (id < 38)
            {
                ++countWP;
                wpReached = true;
            }
            else
            {
                if(Unit* player = me->GetVehicleKit()->GetPassenger(0))
                {
                    me->CastSpell(me, SPELL_KILLCREDIT_FROSTHOUND, true);
                    Talk(SAY_END, player);
                    player->ExitVehicle();
                }
            }
        }

        void PassengerBoarded(Unit* player, int8 /*seatId*/, bool apply) OVERRIDE
        {
            if (apply)
            {
                countWP = 0;
                wpReached = true;
                Talk(SAY_START, player);
            }
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            if (wpReached)
            {
                wpReached = false;
                me->GetMotionMaster()->MovePoint(countWP, FrosthoundWaypoints[countWP]);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_frosthoundAI(creature);
    }
};

class npc_frostbite : public CreatureScript
{
public:
    npc_frostbite() : CreatureScript("npc_frostbite") { }

    struct npc_frostbiteAI : public VehicleAI
    {
        npc_frostbiteAI(Creature* creature) : VehicleAI(creature) {}

        bool wpReached;
        uint16 countWP;

        void MovementInform(uint32 type, uint32 id) OVERRIDE
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (id < 14)
            {
                ++countWP;
                wpReached = true;
            }
            else
            {
                if(Unit* player = me->GetVehicleKit()->GetPassenger(0))
                {
                    me->CastSpell(me, SPELL_KILLCREDIT_FROSTBITE, true);
                    player->ExitVehicle();
                }
            }
        }

        void PassengerBoarded(Unit* player, int8 /*seatId*/, bool apply) OVERRIDE
        {
            if (apply)
            {
                countWP = 0;
                wpReached = true;
                Talk(SAY_START, player);
            }
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            if (wpReached)
            {
                wpReached = false;
                me->GetMotionMaster()->MovePoint(countWP, FrostbiteWaypoints[countWP]);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_frostbiteAI(creature);
    }
};

enum SeethingRevenant
{
    NPC_SNORRI                    = 30124,
    SPELL_SEETHING_FLAME          = 56620,
    SPELL_SEETHING_KILL_CREDIT    = 56754
};

class npc_seething_revenant : public CreatureScript
{
public:
    npc_seething_revenant() : CreatureScript("npc_seething_revenant") {}

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_seething_revenantAI (creature);
    }

    struct npc_seething_revenantAI : public ScriptedAI
    {
        npc_seething_revenantAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 uiFlame_timer;

        void Reset() OVERRIDE
        {
            uiFlame_timer = urand(3000,6000);
        }

        void JustDied(Unit* killer) OVERRIDE
        {
            if (killer->GetEntry() == NPC_SNORRI)
                if (Player* player = killer->GetOwner()->ToPlayer())
                    player->CastSpell(player,SPELL_SEETHING_KILL_CREDIT,true);
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (!me->GetVictim())
                return;

            if (uiFlame_timer <= uiDiff)
            {
                me->CastSpell(me,SPELL_SEETHING_FLAME);
                uiFlame_timer = urand(5000,9000);
            }
            else uiFlame_timer -= uiDiff;
        }

    };

};


/*#####
# npc_brann_bronzebeard_keystone for Quest 13285 "Forging the Keystone"
#####*/

enum BrannBronzebeard
{
    NPC_BRANN_BRONZEBEARD = 31810,
    NPC_A_DISTANT_VOICE   = 31814,
    OBJECT_TOL_SIGNAL_1   = 193590,
    OBJECT_TOL_SIGNAL_2   = 193591,
    OBJECT_TOL_SIGNAL_3   = 193592,
    OBJECT_TOL_SIGNAL_4   = 193593,
    OBJECT_TOL_SIGNAL_5   = 193594,
    SPELL_RESURRECTION    = 58854,
    SAY_BRANN_1           = 0,
    SAY_BRANN_2           = 1,
    SAY_BRANN_3           = 2,
    SAY_VOICE_1           = 0,
    SAY_VOICE_2           = 1,
    SAY_VOICE_3           = 2,
    SAY_VOICE_4           = 3,
    SAY_VOICE_5           = 4,

    EVENT_SCRIPT_1        = 1,
    EVENT_SCRIPT_2        = 2,
    EVENT_SCRIPT_3        = 3,
    EVENT_SCRIPT_4        = 4,
    EVENT_SCRIPT_5        = 5,
    EVENT_SCRIPT_6        = 6,
    EVENT_SCRIPT_7        = 7,
    EVENT_SCRIPT_8        = 8,
    EVENT_SCRIPT_9        = 9,
    EVENT_SCRIPT_10       = 10,
    EVENT_SCRIPT_11       = 11,
    EVENT_SCRIPT_12       = 12,
    EVENT_SCRIPT_13       = 13
};

class npc_brann_bronzebeard_keystone : public CreatureScript
{
public:
    npc_brann_bronzebeard_keystone() : CreatureScript("npc_brann_bronzebeard_keystone") { }

    struct npc_brann_bronzebeard_keystoneAI : public ScriptedAI
    {
        npc_brann_bronzebeard_keystoneAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() OVERRIDE
        {
            memset(&objectGUID, 0, sizeof(objectGUID));
            playerGUID = 0;
            voiceGUID  = 0;
            objectCounter = 0;
        }

        void sGossipSelect(Player* player, uint32 /*sender*/, uint32 /*action*/) OVERRIDE
        {
            player->CLOSE_GOSSIP_MENU();
            playerGUID = player->GetGUID();
            events.ScheduleEvent(EVENT_SCRIPT_1, 100);
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_SCRIPT_1:
                        Talk(SAY_BRANN_1);
                        me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
                        if (Creature* voice = me->SummonCreature(NPC_A_DISTANT_VOICE, 7863.43f, -1396.585f, 1538.076f, 2.949606f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 49000))
                            voiceGUID = voice->GetGUID();
                        events.ScheduleEvent(EVENT_SCRIPT_2, 4000);
                        break;
                    case EVENT_SCRIPT_2:
                        me->SetWalk(true);
                        me->GetMotionMaster()->MovePoint(0, 7861.488f, -1396.376f, 1534.059f, false);
                        events.ScheduleEvent(EVENT_SCRIPT_3, 6000);
                        break;
                    case EVENT_SCRIPT_3:
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_WORK_MINING);
                        events.ScheduleEvent(EVENT_SCRIPT_4, 6000);
                        break;
                    case EVENT_SCRIPT_4:
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                        if (Creature* voice = ObjectAccessor::GetCreature(*me, voiceGUID))
                        {
                            voice->AI()->DoCast(voice, SPELL_RESURRECTION);
                            voice->AI()->Talk(SAY_VOICE_1);
                        }
                        if (GameObject* go = me->SummonGameObject(OBJECT_TOL_SIGNAL_1, 7860.273f, -1383.622f, 1538.302f, -1.658062f, 0, 0,  -0.737277f, 0.6755905f, 0))
                            objectGUID[objectCounter++] = go->GetGUID();
                        events.ScheduleEvent(EVENT_SCRIPT_5, 6000);
                        break;
                    case EVENT_SCRIPT_5:
                        if (Creature* voice = ObjectAccessor::GetCreature(*me, voiceGUID))
                            voice->AI()->Talk(SAY_VOICE_2);
                        if (GameObject* go = me->SummonGameObject(OBJECT_TOL_SIGNAL_2, 7875.67f, -1387.266f, 1538.323f, -2.373644f, 0, 0,  -0.9271832f, 0.3746083f, 0))
                            objectGUID[objectCounter++] = go->GetGUID();
                        events.ScheduleEvent(EVENT_SCRIPT_6, 6000);
                        break;
                    case EVENT_SCRIPT_6:
                        if (Creature* voice = ObjectAccessor::GetCreature(*me, voiceGUID))
                            voice->AI()->Talk(SAY_VOICE_3);
                        if (GameObject* go = me->SummonGameObject(OBJECT_TOL_SIGNAL_3, 7879.212f, -1401.175f, 1538.279f, 2.967041f, 0, 0,  0.9961939f, 0.08716504f, 0))
                            objectGUID[objectCounter++] = go->GetGUID();
                        events.ScheduleEvent(EVENT_SCRIPT_7, 6000);
                        break;
                    case EVENT_SCRIPT_7:
                        if (Creature* voice = ObjectAccessor::GetCreature(*me, voiceGUID))
                            voice->AI()->Talk(SAY_VOICE_4);
                        if (GameObject* go = me->SummonGameObject(OBJECT_TOL_SIGNAL_4, 7868.944f, -1411.18f, 1538.213f, 2.111848f, 0, 0,  0.8703556f, 0.4924237f, 0))
                            objectGUID[objectCounter++] = go->GetGUID();
                        events.ScheduleEvent(EVENT_SCRIPT_8, 6000);
                        break;
                    case EVENT_SCRIPT_8:
                        if (Creature* voice = ObjectAccessor::GetCreature(*me, voiceGUID))
                            voice->AI()->Talk(SAY_VOICE_5);
                        if (GameObject* go = me->SummonGameObject(OBJECT_TOL_SIGNAL_5, 7855.11f, -1406.839f, 1538.42f, 1.151916f, 0, 0,  0.5446386f, 0.8386708f, 0))
                            objectGUID[objectCounter] = go->GetGUID();
                        events.ScheduleEvent(EVENT_SCRIPT_9, 6000);
                        break;
                    case EVENT_SCRIPT_9:
                        if (Creature* voice = ObjectAccessor::GetCreature(*me, voiceGUID))
                            voice->AI()->DoCast(voice, SPELL_RESURRECTION);
                        events.ScheduleEvent(EVENT_SCRIPT_10, 6000);
                        break;
                    case EVENT_SCRIPT_10:
                        Talk(SAY_BRANN_2);
                        if (Player* player = ObjectAccessor::GetPlayer(*me, playerGUID))
                            player->KilledMonsterCredit(me->GetEntry());
                        events.ScheduleEvent(EVENT_SCRIPT_11, 6000);
                        break;
                    case EVENT_SCRIPT_11:
                        me->SetOrientation(2.932153f);
                        me->SendMovementFlagUpdate(true);
                        Talk(SAY_BRANN_3);
                        for (uint8 i = 0; i < 5; ++i)
                        {
                            if (GameObject* go = ObjectAccessor::GetGameObject(*me, objectGUID[i]))
                                go->Delete();
                        }
                        events.ScheduleEvent(EVENT_SCRIPT_12, 6000);
                        break;
                    case EVENT_SCRIPT_12:
                        me->GetMotionMaster()->Clear();
                        me->SetWalk(false);
                        me->GetMotionMaster()->MovePoint(0, 7799.908f, -1413.561f, 1534.829f, false);
                        events.ScheduleEvent(EVENT_SCRIPT_13, 10000);
                        break;
                    case EVENT_SCRIPT_13:
                        me->DisappearAndDie();
                        break;
                }
            }
        }

    private:
        EventMap events;
        uint64 playerGUID;
        uint64 objectGUID[5];
        uint64 voiceGUID;
        uint8 objectCounter;
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_brann_bronzebeard_keystoneAI(creature);
    }
};

/*#####
# Quest 13010 Krolmir, Hammer of Storms
#####*/

enum KrolmirQuest
{
    SPELL_JOKKUM_SUMMON             = 56541,
    SPELL_SUMMON_VERANUS_AND_THORIM = 56649,
};

class spell_jokkum_scriptcast : public SpellScriptLoader
{
    public: spell_jokkum_scriptcast() : SpellScriptLoader("spell_jokkum_scriptcast") { }

        class spell_jokkum_scriptcast_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_jokkum_scriptcast_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/) override
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_JOKKUM_SUMMON))
                    return false;
                return true;
            }

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* target = GetTarget())
                    target->CastSpell(target, SPELL_JOKKUM_SUMMON, true);
            }

            void Register() override
            {
                OnEffectApply += AuraEffectApplyFn(spell_jokkum_scriptcast_AuraScript::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const override
        {
            return new spell_jokkum_scriptcast_AuraScript();
        }
};

class spell_veranus_summon : public SpellScriptLoader
{
    public: spell_veranus_summon() : SpellScriptLoader("spell_veranus_summon") { }

        class spell_veranus_summon_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_veranus_summon_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/) override
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SUMMON_VERANUS_AND_THORIM))
                    return false;
                return true;
            }

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* target = GetTarget())
                    target->CastSpell(target, SPELL_SUMMON_VERANUS_AND_THORIM, true);
            }

            void Register() override
            {
                OnEffectApply += AuraEffectApplyFn(spell_veranus_summon_AuraScript::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const override
        {
            return new spell_veranus_summon_AuraScript();
        }
};

enum CloseRift
{
    SPELL_DESPAWN_RIFT          = 61665
};

class spell_close_rift : public SpellScriptLoader
{
    public:
        spell_close_rift() : SpellScriptLoader("spell_close_rift") { }

        class spell_close_rift_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_close_rift_AuraScript);

        public:
            spell_close_rift_AuraScript()
            {
                _counter = 0;
            }

        private:
            bool Validate(SpellInfo const* /*spell*/) override
            {
                return sSpellMgr->GetSpellInfo(SPELL_DESPAWN_RIFT) != nullptr;
            }

            void HandlePeriodic(AuraEffect const* /* aurEff */)
            {
                if (++_counter == 5)
                    GetTarget()->CastSpell((Unit*)NULL, SPELL_DESPAWN_RIFT, true);
            }

            void Register() override
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_close_rift_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }

        private:
            uint8 _counter;

        };

        AuraScript* GetAuraScript() const override
        {
            return new spell_close_rift_AuraScript();
        }
};

void AddSC_storm_peaks()
{
    new npc_injured_goblin();
    new npc_roxi_ramrocket();
    new npc_brunnhildar_prisoner();
    new npc_freed_protodrake();
    new npc_icefang();
    new npc_hyldsmeet_protodrake();
    new npc_hyldsmeet_drakerider();
    new npc_gretta_the_arbiter();
    new npc_frosthound();
    new npc_frostbite();
    new npc_seething_revenant();
    new npc_brann_bronzebeard_keystone();
    new spell_jokkum_scriptcast();
    new spell_veranus_summon();
    new spell_close_rift();
}
