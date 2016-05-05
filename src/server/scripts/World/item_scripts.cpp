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
SDName: Item_Scripts
SD%Complete: 100
SDComment: Items for a range of different items. See content below (in script)
SDCategory: Items
EndScriptData */

/* ContentData
item_nether_wraith_beacon(i31742)   Summons creatures for quest Becoming a Spellfire Tailor (q10832)
item_flying_machine(i34060, i34061)  Engineering crafted flying machines
item_gor_dreks_ointment(i30175)     Protecting Our Own(q10488)
item_only_for_flight                Items which should only useable while flying
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "Player.h"

/*#####
# item_only_for_flight
#####*/

enum OnlyForFlight
{
    SPELL_ARCANE_CHARGES    = 45072
};

class item_only_for_flight : public ItemScript
{
public:
    item_only_for_flight() : ItemScript("item_only_for_flight") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/) OVERRIDE
    {
        uint32 itemId = item->GetEntry();
        bool disabled = false;

        //for special scripts
        switch (itemId)
        {
           case 24538:
                if (player->GetAreaId() != 3628)
                    disabled = true;
                    break;
           case 34489:
                if (player->GetZoneId() != 4080)
                    disabled = true;
                    break;
           case 34475:
                if (const SpellInfo* spellInfo = sSpellMgr->GetSpellInfo(SPELL_ARCANE_CHARGES))
                    Spell::SendCastResult(player, spellInfo, 1, SPELL_FAILED_NOT_ON_GROUND);
                    break;
        }

        // allow use in flight only
        if (player->IsInFlight() && !disabled)
            return false;

        // error
        player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, item, NULL);
        return true;
    }
};

/*#####
# item_nether_wraith_beacon
#####*/

class item_nether_wraith_beacon : public ItemScript
{
public:
    item_nether_wraith_beacon() : ItemScript("item_nether_wraith_beacon") { }

    bool OnUse(Player* player, Item* /*item*/, SpellCastTargets const& /*targets*/) OVERRIDE
    {
        if (player->GetQuestStatus(10832) == QUEST_STATUS_INCOMPLETE)
        {
            if (Creature* nether = player->SummonCreature(22408, player->GetPositionX(), player->GetPositionY()+20, player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 180000))
                nether->AI()->AttackStart(player);

            if (Creature* nether = player->SummonCreature(22408, player->GetPositionX(), player->GetPositionY()-20, player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 180000))
                nether->AI()->AttackStart(player);
        }
        return false;
    }
};

/*#####
# item_gor_dreks_ointment
#####*/

class item_gor_dreks_ointment : public ItemScript
{
public:
    item_gor_dreks_ointment() : ItemScript("item_gor_dreks_ointment") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& targets) OVERRIDE
    {
        if (targets.GetUnitTarget() && targets.GetUnitTarget()->GetTypeId() == TYPEID_UNIT &&
            targets.GetUnitTarget()->GetEntry() == 20748 && !targets.GetUnitTarget()->HasAura(32578))
        {
            return false;
        }

        player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, item, NULL);
        return true;
    }
};

/*#####
# item_incendiary_explosives
#####*/

class item_incendiary_explosives : public ItemScript
{
public:
    item_incendiary_explosives() : ItemScript("item_incendiary_explosives") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const & /*targets*/) OVERRIDE
    {
        if (player->FindNearestCreature(26248, 15) || player->FindNearestCreature(26249, 15))
            return false;
        else
        {
            player->SendEquipError(EQUIP_ERR_OUT_OF_RANGE, item, NULL);
            return true;
        }
    }
};

/*#####
# item_mysterious_egg
#####*/

class item_mysterious_egg : public ItemScript
{
public:
    item_mysterious_egg() : ItemScript("item_mysterious_egg") { }

    bool OnExpire(Player* player, ItemTemplate const* /*pItemProto*/) OVERRIDE
    {
        ItemPosCountVec dest;
        uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, 39883, 1); // Cracked Egg
        if (msg == EQUIP_ERR_OK)
            player->StoreNewItem(dest, 39883, true, Item::GenerateItemRandomPropertyId(39883));

        return true;
    }
};

/*#####
# item_disgusting_jar
#####*/

class item_disgusting_jar : public ItemScript
{
public:
    item_disgusting_jar() : ItemScript("item_disgusting_jar") {}

    bool OnExpire(Player* player, ItemTemplate const* /*pItemProto*/) OVERRIDE
    {
        ItemPosCountVec dest;
        uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, 44718, 1); // Ripe Disgusting Jar
        if (msg == EQUIP_ERR_OK)
            player->StoreNewItem(dest, 44718, true, Item::GenerateItemRandomPropertyId(44718));

        return true;
    }
};

/*#####
# item_pile_fake_furs
#####*/

enum PileFakeFur
{
    GO_CARIBOU_TRAP_1                                      = 187982,
    GO_CARIBOU_TRAP_2                                      = 187995,
    GO_CARIBOU_TRAP_3                                      = 187996,
    GO_CARIBOU_TRAP_4                                      = 187997,
    GO_CARIBOU_TRAP_5                                      = 187998,
    GO_CARIBOU_TRAP_6                                      = 187999,
    GO_CARIBOU_TRAP_7                                      = 188000,
    GO_CARIBOU_TRAP_8                                      = 188001,
    GO_CARIBOU_TRAP_9                                      = 188002,
    GO_CARIBOU_TRAP_10                                     = 188003,
    GO_CARIBOU_TRAP_11                                     = 188004,
    GO_CARIBOU_TRAP_12                                     = 188005,
    GO_CARIBOU_TRAP_13                                     = 188006,
    GO_CARIBOU_TRAP_14                                     = 188007,
    GO_CARIBOU_TRAP_15                                     = 188008,
    GO_HIGH_QUALITY_FUR                                    = 187983,
    NPC_NESINGWARY_TRAPPER                                 = 25835
};

#define CaribouTrapsNum 15
const uint32 CaribouTraps[CaribouTrapsNum] =
{
    GO_CARIBOU_TRAP_1, GO_CARIBOU_TRAP_2, GO_CARIBOU_TRAP_3, GO_CARIBOU_TRAP_4, GO_CARIBOU_TRAP_5,
    GO_CARIBOU_TRAP_6, GO_CARIBOU_TRAP_7, GO_CARIBOU_TRAP_8, GO_CARIBOU_TRAP_9, GO_CARIBOU_TRAP_10,
    GO_CARIBOU_TRAP_11, GO_CARIBOU_TRAP_12, GO_CARIBOU_TRAP_13, GO_CARIBOU_TRAP_14, GO_CARIBOU_TRAP_15,
};

class item_pile_fake_furs : public ItemScript
{
public:
    item_pile_fake_furs() : ItemScript("item_pile_fake_furs") { }

    bool OnUse(Player* player, Item* /*item*/, SpellCastTargets const & /*targets*/) OVERRIDE
    {
        GameObject* go = NULL;
        for (uint8 i = 0; i < CaribouTrapsNum; ++i)
        {
            go = player->FindNearestGameObject(CaribouTraps[i], 5.0f);
            if (go)
                break;
        }

        if (!go)
            return false;

        if (go->FindNearestCreature(NPC_NESINGWARY_TRAPPER, 10.0f, true) || go->FindNearestCreature(NPC_NESINGWARY_TRAPPER, 10.0f, false) || go->FindNearestGameObject(GO_HIGH_QUALITY_FUR, 2.0f))
            return true;

        float x, y, z;
        go->GetClosePoint(x, y, z, go->GetObjectSize() / 3, 7.0f);
        go->SummonGameObject(GO_HIGH_QUALITY_FUR, go->GetPositionX(), go->GetPositionY(), go->GetPositionZ(), 0, 0, 0, 0, 0, 1000);
        if (TempSummon* summon = player->SummonCreature(NPC_NESINGWARY_TRAPPER, x, y, z, go->GetOrientation(), TEMPSUMMON_DEAD_DESPAWN, 1000))
        {
            summon->SetVisible(false);
            summon->SetReactState(REACT_PASSIVE);
            summon->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
        }
        return false;
    }
};

/*#####
# item_petrov_cluster_bombs
#####*/

enum PetrovClusterBombs
{
    SPELL_PETROV_BOMB           = 42406,
    AREA_ID_SHATTERED_STRAITS   = 4064,
    ZONE_ID_HOWLING             = 495
};

class item_petrov_cluster_bombs : public ItemScript
{
public:
    item_petrov_cluster_bombs() : ItemScript("item_petrov_cluster_bombs") { }

    bool OnUse(Player* player, Item* item, const SpellCastTargets & /*targets*/) OVERRIDE
    {
        if (player->GetZoneId() != ZONE_ID_HOWLING)
            return false;

        if (!player->GetTransport() || player->GetAreaId() != AREA_ID_SHATTERED_STRAITS)
        {
            player->SendEquipError(EQUIP_ERR_NONE, item, NULL);

            if (const SpellInfo* spellInfo = sSpellMgr->GetSpellInfo(SPELL_PETROV_BOMB))
                Spell::SendCastResult(player, spellInfo, 1, SPELL_FAILED_NOT_HERE);

            return true;
        }

        return false;
    }
};

/*######
# item_dehta_trap_smasher
# For quest 11876, Help Those That Cannot Help Themselves
######*/
enum HelpThemselves
{
    QUEST_CANNOT_HELP_THEMSELVES                  =  11876,
    NPC_TRAPPED_MAMMOTH_CALF                      =  25850,
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

class item_dehta_trap_smasher : public ItemScript
{
public:
    item_dehta_trap_smasher() : ItemScript("item_dehta_trap_smasher") { }

    bool OnUse(Player* player, Item* /*item*/, const SpellCastTargets & /*targets*/) OVERRIDE
    {
        if (player->GetQuestStatus(QUEST_CANNOT_HELP_THEMSELVES) != QUEST_STATUS_INCOMPLETE)
            return false;

        Creature* pMammoth = player->FindNearestCreature(NPC_TRAPPED_MAMMOTH_CALF, 5.0f);
        if (!pMammoth)
            return false;

        GameObject* pTrap = NULL;
        for (uint8 i = 0; i < MammothTrapsNum; ++i)
        {
            pTrap = player->FindNearestGameObject(MammothTraps[i], 11.0f);
            if (pTrap)
            {
                pMammoth->AI()->DoAction(1);
                pTrap->SetGoState(GO_STATE_READY);
                player->KilledMonsterCredit(NPC_TRAPPED_MAMMOTH_CALF, 0);
                return true;
            }
        }
        return false;
    }
};

enum TheEmissary
{
    QUEST_THE_EMISSARY      =   11626,
    NPC_LEVIROTH            =   26452,
    SPELL_IMPALE_LEVIROTH   =   47170,
};

class item_trident_of_nazjan : public ItemScript
{
public:
    item_trident_of_nazjan() : ItemScript("item_Trident_of_Nazjan") { }

    bool OnUse(Player* player, Item* item, const SpellCastTargets & /*targets*/) OVERRIDE
    {
        if (player->GetQuestStatus(QUEST_THE_EMISSARY) == QUEST_STATUS_INCOMPLETE)
        {
            if (Creature* pLeviroth = player->FindNearestCreature(NPC_LEVIROTH, 10.0f,true))
            {
                uint32 dmg = 0;
                if (pLeviroth)
                {
                    pLeviroth->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_1);
                    dmg = pLeviroth->GetHealth() * 0.92;
                    //player->CastSpell(pLeviroth, SPELL_IMPALE_LEVIROTH, true);
                    player->DealDamage(pLeviroth, dmg);
                    pLeviroth->AI()->AttackStart(player);
                    return false;
                }
            } else
                player->SendEquipError(EQUIP_ERR_OUT_OF_RANGE, item, NULL);
        } else
            player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, item, NULL);
        return true;
    }
};

enum CapturedFrog
{
    QUEST_THE_PERFECT_SPIES      = 25444,
    NPC_VANIRAS_SENTRY_TOTEM     = 40187
};

class item_captured_frog : public ItemScript
{
public:
    item_captured_frog() : ItemScript("item_captured_frog") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/) OVERRIDE
    {
        if (player->GetQuestStatus(QUEST_THE_PERFECT_SPIES) == QUEST_STATUS_INCOMPLETE)
        {
            if (player->FindNearestCreature(NPC_VANIRAS_SENTRY_TOTEM, 10.0f))
                return false;
            else
                player->SendEquipError(EQUIP_ERR_OUT_OF_RANGE, item, NULL);
        }
        else
            player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, item, NULL);
        return true;
    }
};

enum IntoTheSoulgrinder
{
    QUEST_INTO_THE_SOULGRINDER      = 11000,
    NPC_THE_SOULGRINDER_DUMMY       = 23019,
    SPELL_SOULGRINDER_RITUAL_VISUAL = 39918,

};

class item_vimgols_grimoire : public ItemScript
{
public:
    item_vimgols_grimoire() : ItemScript("item_vimgols_grimoire") { }

    bool OnUse(Player* player, Item* item, const SpellCastTargets & /*targets*/)
    {
        if (player->GetQuestStatus(QUEST_INTO_THE_SOULGRINDER) == QUEST_STATUS_INCOMPLETE && !player->FindNearestCreature(NPC_THE_SOULGRINDER_DUMMY,30.0f,true))
        {
            if (Creature* pSoulgrinder = player->SummonCreature(NPC_THE_SOULGRINDER_DUMMY, 3534.99f,5590.61f,0.1824f, 0, TEMPSUMMON_MANUAL_DESPAWN, 120000))
            {
                if (pSoulgrinder)
                    pSoulgrinder->CastSpell(pSoulgrinder,SPELL_SOULGRINDER_RITUAL_VISUAL);

                return false;
            } else
                player->SendEquipError(EQUIP_ERR_OUT_OF_RANGE, item, NULL);
        } else
            player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, item, NULL);
        return true;
    }
};

/*#####
# item_warsong_flare_gun
#####*/

enum CowardDel
{
    NPC_VALIANCE_KEEP_OFFICER = 25759,
};

class item_warsong_flare_gun : public ItemScript
{
public:
    item_warsong_flare_gun() : ItemScript("item_warsong_flare_gun") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const & /*targets*/)
    {
        if (player->GetAreaId()== 3537 && player->FindNearestCreature(25761,10.0f,true) && !player->FindNearestCreature(NPC_VALIANCE_KEEP_OFFICER,40.0f,true))
        {
            if(Creature *creature = player->SummonCreature(NPC_VALIANCE_KEEP_OFFICER, 2914.80f,5361.12f,61.4f, 0.7141f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 600000))
            {
                if(creature)
                {
                    creature->GetMotionMaster()->MovePoint(0,player->GetPositionX()-2,player->GetPositionY()+1,player->GetPositionZ());

                    player->AreaExploredOrEventHappens(11711);
                }
            }
            return false;
        }
        else
        {
            player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, item, NULL);
            return true;
        }
    }
};

/*#####
# item_highmesas_cleansing

#####*/

enum HighmesasC
{
    OBJECT_DEN_OF_DYING = 187879,
    QUEST_STOP_THE_PLAGUE = 11677,
    QUEST_KILLCREDIT_CAULDRON = 25654,
};

class item_highmesas_cleansing : public ItemScript
{
public:
    item_highmesas_cleansing() : ItemScript("item_highmesas_cleansing") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const & /*targets*/)
    {
        if (player->FindNearestGameObject(OBJECT_DEN_OF_DYING,5.0f) && player->GetQuestStatus(QUEST_STOP_THE_PLAGUE) == QUEST_STATUS_INCOMPLETE)
        {
           player->KilledMonsterCredit(QUEST_KILLCREDIT_CAULDRON,0);
           return false;
        }
        else
        {
            player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, item, NULL);
            return true;
        }
    }
};

/*#####
# item_ragefists_torch
#####*/

enum RageFistsTorch
{
    QUEST_KILLCREDIT = 25342,
    QUEST_TARGET1 = 25343,
    QUEST_TARGET2 = 25342,
    GAMEOBJECT_FIRE_SMALL = 182211,
};

class item_ragefists_torch : public ItemScript
{
public:
    item_ragefists_torch() : ItemScript("item_ragefists_torch") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& targets)
    {
        if (!player->FindNearestGameObject(GAMEOBJECT_FIRE_SMALL,3.0f))
        {
            if (Creature *creature = player->FindNearestCreature(QUEST_TARGET1,1.0f,true))
            {
                if(creature)
                {
                    if(!creature->FindNearestGameObject(GAMEOBJECT_FIRE_SMALL,1.0f))
                    {
                        creature->SummonGameObject(GAMEOBJECT_FIRE_SMALL,creature->GetPositionX(), creature->GetPositionY(), creature->GetPositionZ(), 0, 0, 0, 0, 0, 10);
                        creature->DespawnOrUnsummon(8000);
                        player->KilledMonsterCredit(QUEST_KILLCREDIT,0);
                    }
                    else
                    {
                        return true;
                    }
                }
                return false;
            }
            else{
                if (Creature *creature = player->FindNearestCreature(QUEST_TARGET2,1.0f,true))
                {
                    if(creature)
                    {
                        if(!creature->FindNearestGameObject(GAMEOBJECT_FIRE_SMALL,1.0f))
                        {
                            creature->SummonGameObject(GAMEOBJECT_FIRE_SMALL,creature->GetPositionX(), creature->GetPositionY(), creature->GetPositionZ(), 0, 0, 0, 0, 0, 10);
                            creature->DespawnOrUnsummon(10000);
                            player->KilledMonsterCredit(QUEST_KILLCREDIT,0);
                        }
                        else
                        {
                            return true;
                        }
                    }
                    return false;
                }
            }
        }

        player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, item, NULL);
        return true;
    }
};

/*#####
# item_the_kings_empty_conch
#####*/

enum KingsEmpty
{
    QUEST_lEARNING_TO_COMUNICATE = 11571,
};

class item_the_kings_empty_conch : public ItemScript
{
public:
    item_the_kings_empty_conch() : ItemScript("item_the_kings_empty_conch") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& targets)
    {
        if (player->GetQuestStatus(QUEST_lEARNING_TO_COMUNICATE) == QUEST_STATUS_INCOMPLETE)
        {
            if (player->FindNearestCreature(25226,5.0f,false))
            {
                return false;
            }
        }

        player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, item, NULL);
        return true;
    }
};

/*#####
# item_tuskarr_torch
#####*/

enum TuskarrT
{
    QUEST_BURN_IN_EFFIGY = 11656,
    NPC_1ST_KVALDIR_VESSEL = 25510,
    NPC_2ST_KVALDIR_VESSEL = 25511,
    NPC_3ST_KVALDIR_VESSEL = 25512,
    NPC_4ST_KVALDIR_VESSEL = 25513,
};

class item_tuskarr_torch : public ItemScript
{
public:
    item_tuskarr_torch() : ItemScript("item_tuskarr_torch") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& targets)
    {
        if (player->GetQuestStatus(QUEST_BURN_IN_EFFIGY) == QUEST_STATUS_INCOMPLETE)
        {
            if (player->FindNearestCreature(NPC_1ST_KVALDIR_VESSEL,1.0f,true))
            {
                player->KilledMonsterCredit(NPC_1ST_KVALDIR_VESSEL, 0);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3054.43f,6764.43f,2.25891f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3062.19f,6776.2f,2.88087f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3045.6f,6756.22f,4.43362f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3043.63f,6743.53f,18.8663f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3042.03f,6739.13f,17.968f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3046.91f,6749.06f,6.30662f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3045.48f,6749.37f,6.46482f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3044.56f,6751.83f,5.69119f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3050.74f,6766.17f,2.36542f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3052.96f,6771.04f,2.21343f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3060.69f,6769.44f,1.15602f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3056.33f,6760.0f ,2.945f  , 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3053.3f,6751.43f,4.87761f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3061.72f,6782.78f,7.21662f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3059.88f,6780.69f,6.03033f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3046.51f,6751.45f,15.0045f, 0, 0, 0, 0, 0, 10);
                return false;
            }

            if (player->FindNearestCreature(NPC_2ST_KVALDIR_VESSEL,1.0f,true))
            {
                player->KilledMonsterCredit(NPC_2ST_KVALDIR_VESSEL, 0);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3021.96f,6787.26f,6.97397f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3060.78f,6813.16f,16.3233f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3057.78f,6811.45f,12.716f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3057.77f,6808.8f,12.8558f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3059.22f,6810.84f,15.3795f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3050.81f,6808.88f,6.21858f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3047.84f,6808.31f,5.20948f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3045.68f,6801.28f,2.36755f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3043.99f,6797.89f,1.3718f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3040.43f,6800.61f,2.243f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3039.55f,6802.36f,3.07241f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3037.12f,6789.12f,4.05906f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3033.76f,6787.49f,4.32182f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,3026.64f,6785.29f,5.80295f, 0, 0, 0, 0, 0, 10);
                return false;
            }

            if (player->FindNearestCreature(NPC_3ST_KVALDIR_VESSEL,1.0f,true))
            {
                player->KilledMonsterCredit(NPC_3ST_KVALDIR_VESSEL, 0);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2874.68f,6860.42f,0.674603f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2869.62f,6871.46f,2.22156f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2866.81f,6875.85f,1.67934f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2860.27f,6883.48f,2.52338f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2851.98f,6888.13f,4.51682f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2850.88f,6877.33f,2.35494f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2852.85f,6879.08f,0.455089f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2858.29f,6877.3f,0.462151f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2857.2f,6871.86f,1.72042f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2854.53f,6865.65f,13.5244f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2857.16f,6864.25f,25.0978f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2863.99f,6863.56f,25.2978f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2865.52f,6862.97f,21.7943f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2865.76f,6862.29f,14.0165f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2879.69f,6851.01f,11.6985f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2874.75f,6852.05f,14.7213f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2872.3f,6859.26f,15.6834f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2869.92f,6860.48f,12.715f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2868.76f,6860.13f,5.89847f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2870.34f,6875.68f,13.085f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2870.81f,6865.21f,9.95044f, 0, 0, 0, 0, 0, 10);
                return false;
            }

            if (player->FindNearestCreature(NPC_4ST_KVALDIR_VESSEL,1.0f,true))
            {
                player->KilledMonsterCredit(NPC_4ST_KVALDIR_VESSEL, 0);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2509.97f,6874.81f,4.27638f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2510.34f,6872.04f,3.57937f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2511.29f,6867.68f,2.53068f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2517.81f,6862.7f,1.85619f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2521.88f,6850.99f,5.07605f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2517.52f,6848.28f,4.6076f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2510.34f,6855.07f,12.5777f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2513.12f,6853.13f,12.9929f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2511.21f,6854.56f,23.2538f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2518.18f,6849.66f,23.1443f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2519.85f,6849.08f,17.8222f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2524.24f,6849.54f,18.1178f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2523.74f,6849.84f,14.3817f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2526.67f,6836.25f,16.0156f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2524.22f,6832.49f,12.4278f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2522.55f,6836.98f,13.4617f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2522.84f,6844.09f,14.7267f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2525.45f,6842.22f,12.9115f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2524.76f,6838.77f,6.1295f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2525.65f,6842.73f,5.67113f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2525.94f,6845.64f,0.513989f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2510.57f,6886.28f,12.6422f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2510.35f,6889.05f,14.8695f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2509.62f,6893.07f,15.4345f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2513.22f,6885.87f,8.16809f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2515.17f,6882.34f,12.0215f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2520.57f,6872.94f,3.77654f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2524.23f,6866.72f,3.18732f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2524.07f,6864.68f,3.28098f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2524.97f,6860.05f,3.6229f, 0, 0, 0, 0, 0, 10);
                player->SummonGameObject(GAMEOBJECT_FIRE_SMALL,2525.64f,6859.25f,0.693405f, 0, 0, 0, 0, 0, 10);
                return false;
            }
        }

        player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, item, NULL);
        return true;
    }
};

/*#####
## npc_emergency_torch
# item_
#####*/

enum EmergencyTorch
{
    NPC_SOUTH_CRASH = 25846,
    NPC_EAST_CRASH = 25847,
    NPC_NORTHWEST_CRASH = 25845,
    GO_BOREAN_TUNDRA_FIRE_LARGE = 187675,
};

class npc_emergency_torch : public ItemScript
{
public:
    npc_emergency_torch() : ItemScript("npc_emergency_torch") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& targets)
    {
        if (player->GetQuestStatus(11796) == QUEST_STATUS_INCOMPLETE)
        {
        if (Creature *creature = player->FindNearestCreature(NPC_SOUTH_CRASH,1.0f,true))
        {
            if(creature)
            {
                player->KilledMonsterCredit(NPC_SOUTH_CRASH,0);
                creature->SummonGameObject(GO_BOREAN_TUNDRA_FIRE_LARGE,creature->GetPositionX(), creature->GetPositionY(), creature->GetPositionZ(), 0, 0, 0, 0, 0, 8);
            }
            return false;
        }
        if (Creature *creature = player->FindNearestCreature(NPC_EAST_CRASH,1.0f,true))
        {
                if(creature)
                {
                    creature->SummonGameObject(GO_BOREAN_TUNDRA_FIRE_LARGE,creature->GetPositionX(), creature->GetPositionY(), creature->GetPositionZ(), 0, 0, 0, 0, 0, 8);
                    player->KilledMonsterCredit(NPC_EAST_CRASH,0);
                }
                return false;
        }
        if (Creature *creature = player->FindNearestCreature(NPC_NORTHWEST_CRASH,1.0f,true))
            {
                if(creature)
                {
                    creature->SummonGameObject(GO_BOREAN_TUNDRA_FIRE_LARGE,creature->GetPositionX(), creature->GetPositionY(), creature->GetPositionZ(), 0, 0, 0, 0, 0, 8);
                    player->KilledMonsterCredit(NPC_NORTHWEST_CRASH,0);
                }
                return false;
            }
        }

        player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, item, NULL);
        return true;
    }
};

void AddSC_item_scripts()
{
    new item_only_for_flight();
    new item_nether_wraith_beacon();
    new item_gor_dreks_ointment();
    new item_incendiary_explosives();
    new item_mysterious_egg();
    new item_disgusting_jar();
    new item_pile_fake_furs();
    new item_petrov_cluster_bombs();
    new item_dehta_trap_smasher();
    new item_trident_of_nazjan();
    new item_captured_frog();
    new item_vimgols_grimoire();
    new item_warsong_flare_gun();
    new item_highmesas_cleansing();
    new item_ragefists_torch();
    new item_the_kings_empty_conch();
    new item_tuskarr_torch();
    new npc_emergency_torch();
}
