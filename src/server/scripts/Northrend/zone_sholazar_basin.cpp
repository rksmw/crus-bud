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

/* ScriptData
SDName: Sholazar_Basin
SD%Complete: 100
SDComment: Quest support: 12570, 12573, 12621, 12726
SDCategory: Sholazar_Basin
EndScriptData */

/* ContentData
npc_injured_rainspeaker_oracle
npc_vekjik
avatar_of_freya
npc_haiphoon (Quest: "Song of Wind and Water")
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptedFollowerAI.h"
#include "ScriptedEscortAI.h"
#include "SpellScript.h"
#include "SpellAuras.h"
#include "Vehicle.h"
#include "CombatAI.h"
#include "Player.h"
#include "ReputationMgr.h"

#define FACTION_FRENZYHEART                     1104
#define FACTION_ORCLES                          1105

/*######
## npc_vekjik
######*/

#define GOSSIP_VEKJIK_ITEM1 "Shaman Vekjik, I have spoken with the big-tongues and they desire peace. I have brought this offering on their behalf."
#define GOSSIP_VEKJIK_ITEM2 "No no... I had no intentions of betraying your people. I was only defending myself. it was all a misunderstanding."

enum Vekjik
{
    GOSSIP_TEXTID_VEKJIK1       = 13137,
    GOSSIP_TEXTID_VEKJIK2       = 13138,

    SAY_TEXTID_VEKJIK1          = 0,

    SPELL_FREANZYHEARTS_FURY    = 51469,

    QUEST_MAKING_PEACE          = 12573
};

class npc_vekjik : public CreatureScript
{
public:
    npc_vekjik() : CreatureScript("npc_vekjik") { }

    bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_MAKING_PEACE) == QUEST_STATUS_INCOMPLETE)
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_VEKJIK_ITEM1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_VEKJIK1, creature->GetGUID());
            return true;
        }

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) OVERRIDE
    {
        player->PlayerTalkClass->ClearMenus();
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_VEKJIK_ITEM2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_VEKJIK2, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                player->CLOSE_GOSSIP_MENU();
                creature->AI()->Talk(SAY_TEXTID_VEKJIK1, player);
                player->AreaExploredOrEventHappens(QUEST_MAKING_PEACE);
                creature->CastSpell(player, SPELL_FREANZYHEARTS_FURY, false);
                break;
        }

        return true;
    }
};

/*######
## avatar_of_freya
######*/

#define GOSSIP_ITEM_AOF1 "I want to stop the Scourge as much as you do. How can I help?"
#define GOSSIP_ITEM_AOF2 "You can trust me. I am no friend of the Lich King."
#define GOSSIP_ITEM_AOF3 "I will not fail."

enum Freya
{
    QUEST_FREYA_PACT         = 12621,

    SPELL_FREYA_CONVERSATION = 52045,

    GOSSIP_TEXTID_AVATAR1    = 13303,
    GOSSIP_TEXTID_AVATAR2    = 13304,
    GOSSIP_TEXTID_AVATAR3    = 13305
};

class npc_avatar_of_freya : public CreatureScript
{
public:
    npc_avatar_of_freya() : CreatureScript("npc_avatar_of_freya") { }

    bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_FREYA_PACT) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_AOF1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->PlayerTalkClass->SendGossipMenu(GOSSIP_TEXTID_AVATAR1, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) OVERRIDE
    {
        player->PlayerTalkClass->ClearMenus();
        switch (action)
        {
        case GOSSIP_ACTION_INFO_DEF+1:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_AOF2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            player->PlayerTalkClass->SendGossipMenu(GOSSIP_TEXTID_AVATAR2, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_AOF3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
            player->PlayerTalkClass->SendGossipMenu(GOSSIP_TEXTID_AVATAR3, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+3:
            player->CastSpell(player, SPELL_FREYA_CONVERSATION, true);
            player->CompleteQuest(QUEST_FREYA_PACT);
            player->CLOSE_GOSSIP_MENU();
            break;
        }
        return true;
    }
};

/*######
## npc_bushwhacker
######*/

class npc_bushwhacker : public CreatureScript
{
public:
    npc_bushwhacker() : CreatureScript("npc_bushwhacker") { }

    struct npc_bushwhackerAI : public ScriptedAI
    {
        npc_bushwhackerAI(Creature* creature) : ScriptedAI(creature) { }

        void InitializeAI() OVERRIDE
        {
            if (me->isDead())
                return;

            if (TempSummon* summ = me->ToTempSummon())
                if (Unit* summoner = summ->GetSummoner())
                    me->GetMotionMaster()->MovePoint(0, summoner->GetPositionX(), summoner->GetPositionY(), summoner->GetPositionZ());

            Reset();
        }

        void UpdateAI(uint32 /*diff*/) OVERRIDE
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_bushwhackerAI(creature);
    }
};

/*######
## npc_engineer_helice
######*/

enum EngineerHelice
{
    // Spells
    SPELL_EXPLODE_CRYSTAL       = 62487,
    SPELL_FLAMES                = 64561,

    // Yells
    SAY_WP_1                    = 0,
    SAY_WP_2                    = 1,
    SAY_WP_3                    = 2,
    SAY_WP_4                    = 3,
    SAY_WP_5                    = 4,
    SAY_WP_6                    = 5,
    SAY_WP_7                    = 6,

    // Quests
    QUEST_DISASTER              = 12688
};

class npc_engineer_helice : public CreatureScript
{
public:
    npc_engineer_helice() : CreatureScript("npc_engineer_helice") { }

    struct npc_engineer_heliceAI : public npc_escortAI
    {
        npc_engineer_heliceAI(Creature* creature) : npc_escortAI(creature) { }

        uint32 m_uiChatTimer;

        void WaypointReached(uint32 waypointId) OVERRIDE
        {
            Player* player = GetPlayerForEscort();

            switch (waypointId)
            {
                case 0:
                    Talk(SAY_WP_2);
                    break;
                case 1:
                    Talk(SAY_WP_3);
                    me->CastSpell(5918.33f, 5372.91f, -98.770f, SPELL_EXPLODE_CRYSTAL, true);
                    me->SummonGameObject(184743, 5918.33f, 5372.91f, -98.770f, 0, 0, 0, 0, 0, TEMPSUMMON_MANUAL_DESPAWN);     //approx 3 to 4 seconds
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                    break;
                case 2:
                    Talk(SAY_WP_4);
                    break;
                case 7:
                    Talk(SAY_WP_5);
                    break;
                case 8:
                    me->CastSpell(5887.37f, 5379.39f, -91.289f, SPELL_EXPLODE_CRYSTAL, true);
                    me->SummonGameObject(184743, 5887.37f, 5379.39f, -91.289f, 0, 0, 0, 0, 0, TEMPSUMMON_MANUAL_DESPAWN);      //approx 3 to 4 seconds
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                    break;
                case 9:
                    Talk(SAY_WP_6);
                    break;
                case 13:
                    if (player)
                    {
                        player->GroupEventHappens(QUEST_DISASTER, me);
                        Talk(SAY_WP_7);
                    }
                    break;
            }
        }

        void Reset() OVERRIDE
        {
            m_uiChatTimer = 4 * IN_MILLISECONDS;
        }

        void JustDied(Unit* /*killer*/) OVERRIDE
        {
            if (HasEscortState(STATE_ESCORT_ESCORTING))
            {
                if (Player* player = GetPlayerForEscort())
                    player->FailQuest(QUEST_DISASTER);
            }
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            npc_escortAI::UpdateAI(diff);

            if (HasEscortState(STATE_ESCORT_ESCORTING))
            {
                if (m_uiChatTimer <= diff)
                {
                    m_uiChatTimer = 12 * IN_MILLISECONDS;
                }
                else
                    m_uiChatTimer -= diff;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_engineer_heliceAI(creature);
    }

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest) OVERRIDE
    {
        if (quest->GetQuestId() == QUEST_DISASTER)
        {
            if (npc_engineer_heliceAI* pEscortAI = CAST_AI(npc_engineer_helice::npc_engineer_heliceAI, creature->AI()))
            {
                creature->GetMotionMaster()->MoveJumpTo(0, 0.4f, 0.4f);
                creature->setFaction(113);

                pEscortAI->Start(false, false, player->GetGUID());
                creature->AI()->Talk(SAY_WP_1);
            }
        }
        return true;
    }
};

/*#####
## npc_jungle_punch_target
#####*/

#define SAY_OFFER     "Care to try Grimbooze Thunderbrew's new jungle punch?"

enum JunglePunch
{
    SPELL_OFFER                         = 51962,
    QUEST_TASTE_TEST                    = 12645,

    SAY_HEMET_HADRIUS_TAMARA_1          = 0,
    SAY_HEMET_HADRIUS_TAMARA_2          = 1,
    SAY_HEMET_HADRIUS_TAMARA_3          = 2,

    SAY_HEMET_4                         = 3, // unused
    SAY_HEMET_5                         = 4  // unused
};

enum NesingwaryChildrensWeek
{
    SPELL_ORPHAN_OUT                    = 58818,

    QUEST_THE_MIGHTY_HEMET_NESINGWARY   = 13957,

    ORPHAN_WOLVAR                       = 33532,

    TEXT_NESINGWARY_1                   = 5,

    TEXT_WOLVAR_ORPHAN_6                = 6,
    TEXT_WOLVAR_ORPHAN_7                = 7,
    TEXT_WOLVAR_ORPHAN_8                = 8,
    TEXT_WOLVAR_ORPHAN_9                = 9
};

class npc_jungle_punch_target : public CreatureScript
{
public:
    npc_jungle_punch_target() : CreatureScript("npc_jungle_punch_target") { }

    struct npc_jungle_punch_targetAI : public ScriptedAI
    {
        npc_jungle_punch_targetAI(Creature* creature) : ScriptedAI(creature) {}

        void Reset() OVERRIDE
        {
            sayTimer    = 3500;
            sayStep     = 0;
            timer       = 0;
            phase       = 0;
            playerGUID  = 0;
            orphanGUID  = 0;
        }

        void MoveInLineOfSight(Unit* who) OVERRIDE
        {
            if (!phase && who && who->GetDistance2d(me) < 10.0f)
                if (Player* player = who->ToPlayer())
                    if (player->GetQuestStatus(QUEST_THE_MIGHTY_HEMET_NESINGWARY) == QUEST_STATUS_INCOMPLETE)
                    {
                        playerGUID = player->GetGUID();
                        if (Aura* orphanOut = player->GetAura(SPELL_ORPHAN_OUT))
                            if (orphanOut->GetCaster() && orphanOut->GetCaster()->GetEntry() == ORPHAN_WOLVAR)
                            {
                                orphanGUID = orphanOut->GetCaster()->GetGUID();
                                phase = 1;
                            }
                    }
        }

        void proceedCwEvent(const uint32 diff)
        {
            if (timer <= diff)
            {
                Player* player = ObjectAccessor::GetPlayer(*me, playerGUID);
                Creature* orphan = ObjectAccessor::GetCreature(*me, orphanGUID);

                if (!orphan || !player)
                {
                    Reset();
                    return;
                }

                switch (phase)
                {
                    case 1:
                        orphan->GetMotionMaster()->MovePoint(0, me->GetPositionX() + cos(me->GetOrientation()) * 5, me->GetPositionY() + sin(me->GetOrientation()) * 5, me->GetPositionZ());
                        orphan->AI()->Talk(TEXT_WOLVAR_ORPHAN_6);
                        timer = 5 * IN_MILLISECONDS;
                        break;
                    case 2:
                        orphan->SetFacingToObject(me);
                        orphan->AI()->Talk(TEXT_WOLVAR_ORPHAN_7);
                        timer = 5 * IN_MILLISECONDS;
                        break;
                    case 3:
                        Talk(TEXT_NESINGWARY_1);
                        timer = 5 * IN_MILLISECONDS;
                        break;
                    case 4:
                        orphan->AI()->Talk(TEXT_WOLVAR_ORPHAN_8);
                        timer = 5 * IN_MILLISECONDS;
                        break;
                    case 5:
                        orphan->AI()->Talk(TEXT_WOLVAR_ORPHAN_9);
                        timer = 5 * IN_MILLISECONDS;
                        break;
                    case 6:
                        orphan->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
                        player->GroupEventHappens(QUEST_THE_MIGHTY_HEMET_NESINGWARY, me);
                        Reset();
                        return;
                }
                ++phase;
            }
            else
                timer -= diff;
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            if (phase)
                proceedCwEvent(diff);

            if (!sayStep)
                return;

            if (sayTimer < diff)
            {
                Talk(SAY_HEMET_HADRIUS_TAMARA_1 + sayStep - 1);
                sayTimer = 3 * IN_MILLISECONDS;
                sayStep++;

                if (sayStep > 3) // end
                    sayStep = 0;
            }
            else
                sayTimer -= diff;
        }

        void SpellHit(Unit* caster, SpellInfo const* spellInfo) OVERRIDE
        {
            if (spellInfo->Id != SPELL_OFFER)
                return;

            Player* player = caster->ToPlayer();
            if (!player)
                return;

            Quest const* quest = sObjectMgr->GetQuestTemplate(QUEST_TASTE_TEST);
            if (!quest)
                return;

            QuestStatusMap::const_iterator itr = player->getQuestStatusMap().find(QUEST_TASTE_TEST);
            if (itr->second.Status != QUEST_STATUS_INCOMPLETE)
                return;

            for (uint8 i = 0; i < 3; ++i)
            {
                if (uint32(quest->RequiredNpcOrGo[i]) != me->GetEntry())
                    continue;

                if (itr->second.CreatureOrGOCount[i] != 0)
                    continue;

                player->KilledMonsterCredit(me->GetEntry(), 0);
                player->Say(SAY_OFFER, LANG_UNIVERSAL);
                sayStep = 1;
                break;
            }
        }

        private:
            uint16 sayTimer;
            uint8 sayStep;
            uint32 timer;
            int8 phase;
            uint64 playerGUID;
            uint64 orphanGUID;
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_jungle_punch_targetAI(creature);
    }
};

/*######
## npc_adventurous_dwarf
######*/

#define GOSSIP_OPTION_ORANGE    "Can you spare an orange?"
#define GOSSIP_OPTION_BANANAS   "Have a spare bunch of bananas?"
#define GOSSIP_OPTION_PAPAYA    "I could really use a papaya."

enum AdventurousDwarf
{
    QUEST_SOME_MAKE_LEMONADE    = 12634,

    ITEM_BANANAS                = 38653,
    ITEM_PAPAYA                 = 38655,
    ITEM_ORANGE                 = 38656,

    SPELL_ADD_ORANGE            = 52073,
    SPELL_ADD_BANANAS           = 52074,
    SPELL_ADD_PAPAYA            = 52076,

    GOSSIP_MENU_DWARF           = 13307,

    SAY_DWARF_OUCH              = 0,
    SAY_DWARF_HELP              = 1
};

class npc_adventurous_dwarf : public CreatureScript
{
public:
    npc_adventurous_dwarf() : CreatureScript("npc_adventurous_dwarf") { }

    struct npc_adventurous_dwarfAI : public ScriptedAI
    {
        npc_adventurous_dwarfAI(Creature* creature) : ScriptedAI(creature)
        {
            Talk(SAY_DWARF_OUCH);
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_adventurous_dwarfAI(creature);
    }

    bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
    {
        if (player->GetQuestStatus(QUEST_SOME_MAKE_LEMONADE) != QUEST_STATUS_INCOMPLETE)
            return false;

        if (player->GetItemCount(ITEM_ORANGE) < 1)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_OPTION_ORANGE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        if (player->GetItemCount(ITEM_BANANAS) < 2)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_OPTION_BANANAS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

        if (player->GetItemCount(ITEM_PAPAYA) < 1)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_OPTION_PAPAYA, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);

        player->PlayerTalkClass->SendGossipMenu(GOSSIP_MENU_DWARF, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) OVERRIDE
    {
        player->PlayerTalkClass->ClearMenus();
        uint32 spellId = 0;

        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                spellId = SPELL_ADD_ORANGE;
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                spellId = SPELL_ADD_BANANAS;
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                spellId = SPELL_ADD_PAPAYA;
                break;
        }

        if (spellId)
            player->CastSpell(player, spellId, true);

        creature->AI()->Talk(SAY_DWARF_HELP);
        creature->DespawnOrUnsummon();
        return true;
    }
};

/*######
## Quest The Lifewarden's Wrath
######*/

enum MiscLifewarden
{
    NPC_PRESENCE                = 28563, // Freya's Presence
    NPC_SABOTEUR                = 28538, // Cultist Saboteur
    NPC_SERVANT                 = 28320, // Servant of Freya

    WHISPER_ACTIVATE            = 0,

    SPELL_FREYA_DUMMY           = 51318,
    SPELL_LIFEFORCE             = 51395,
    SPELL_FREYA_DUMMY_TRIGGER   = 51335,
    SPELL_LASHER_EMERGE         = 48195,
    SPELL_WILD_GROWTH           = 52948,
};

class spell_q12620_the_lifewarden_wrath : public SpellScriptLoader
{
public:
    spell_q12620_the_lifewarden_wrath() : SpellScriptLoader("spell_q12620_the_lifewarden_wrath") { }

    class spell_q12620_the_lifewarden_wrath_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q12620_the_lifewarden_wrath_SpellScript);

        void HandleSendEvent(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);

            if (Unit* caster = GetCaster())
            {
                if (Creature* presence = caster->FindNearestCreature(NPC_PRESENCE, 50.0f))
                {
                    presence->AI()->Talk(WHISPER_ACTIVATE, caster);
                    presence->CastSpell(presence, SPELL_FREYA_DUMMY, true); // will target plants
                    // Freya Dummy could be scripted with the following code

                    // Revive plants
                    std::list<Creature*> servants;
                    GetCaster()->GetCreatureListWithEntryInGrid(servants, NPC_SERVANT, 200.0f);
                    for (std::list<Creature*>::iterator itr = servants.begin(); itr != servants.end(); ++itr)
                    {
                        // Couldn't find a spell that does this
                        if ((*itr)->isDead())
                            (*itr)->Respawn(true);

                        (*itr)->CastSpell(*itr, SPELL_FREYA_DUMMY_TRIGGER, true);
                        (*itr)->CastSpell(*itr, SPELL_LASHER_EMERGE, false);
                        (*itr)->CastSpell(*itr, SPELL_WILD_GROWTH, false);

                        if (Unit* target = (*itr)->SelectNearestTarget(150.0f))
                            (*itr)->AI()->AttackStart(target);
                    }

                    // Kill nearby enemies
                    std::list<Creature*> saboteurs;
                    caster->GetCreatureListWithEntryInGrid(saboteurs, NPC_SABOTEUR, 200.0f);
                    for (std::list<Creature*>::iterator itr = saboteurs.begin(); itr != saboteurs.end(); ++itr)
                        if ((*itr)->IsAlive())
                            // Lifeforce has a cast duration, it should be cast at all saboteurs one by one
                            presence->CastSpell((*itr), SPELL_LIFEFORCE, false);
                }
            }
        }

        void Register() OVERRIDE
        {
            OnEffectHit += SpellEffectFn(spell_q12620_the_lifewarden_wrath_SpellScript::HandleSendEvent, EFFECT_0, SPELL_EFFECT_SEND_EVENT);
        }
    };

    SpellScript* GetSpellScript() const OVERRIDE
    {
        return new spell_q12620_the_lifewarden_wrath_SpellScript();
    }
};

/*######
## Quest Kick, What Kick? (12589)
######*/

enum KickWhatKick
{
    NPC_LUCKY_WILHELM       = 28054,
    NPC_APPLE               = 28053,
    NPC_DROSTAN             = 28328,
    NPC_CRUNCHY             = 28346,
    NPC_THICKBIRD           = 28093,

    SPELL_HIT_APPLE         = 51331,
    SPELL_MISS_APPLE        = 51332,
    SPELL_MISS_BIRD_APPLE   = 51366,
    SPELL_APPLE_FALL        = 51371,
    SPELL_BIRD_FALL         = 51369,

    EVENT_MISS              = 0,
    EVENT_HIT               = 1,
    EVENT_MISS_BIRD         = 2,

    SAY_WILHELM_MISS        = 0,
    SAY_WILHELM_HIT         = 1,
    SAY_DROSTAN_REPLY_MISS  = 0,
};

class spell_q12589_shoot_rjr : public SpellScriptLoader
{
public:
    spell_q12589_shoot_rjr() : SpellScriptLoader("spell_q12589_shoot_rjr") { }

    class spell_q12589_shoot_rjr_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q12589_shoot_rjr_SpellScript);

        SpellCastResult CheckCast()
        {
            if (Unit* target = GetExplTargetUnit())
                if (target->GetEntry() == NPC_LUCKY_WILHELM)
                    return SPELL_CAST_OK;

            SetCustomCastResultMessage(SPELL_CUSTOM_ERROR_MUST_TARGET_WILHELM);
            return SPELL_FAILED_CUSTOM_ERROR;
        }

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            uint32 roll = urand(1, 100);

            uint8 ev;
            if (roll <= 50)
                ev = EVENT_MISS;
            else if (roll <= 83)
                ev = EVENT_HIT;
            else
                ev = EVENT_MISS_BIRD;

            Unit* shooter = GetCaster();
            Creature* wilhelm = GetHitUnit()->ToCreature();
            Creature* apple = shooter->FindNearestCreature(NPC_APPLE, 30);
            Creature* drostan = shooter->FindNearestCreature(NPC_DROSTAN, 30);

            if (!wilhelm || !apple || !drostan)
                return;

            switch (ev)
            {
                case EVENT_MISS_BIRD:
                {
                    Creature* crunchy = shooter->FindNearestCreature(NPC_CRUNCHY, 30);
                    Creature* bird = shooter->FindNearestCreature(NPC_THICKBIRD, 30);

                    if (!bird || !crunchy)
                        ; // fall to EVENT_MISS
                    else
                    {
                        shooter->CastSpell(bird, SPELL_MISS_BIRD_APPLE);
                        bird->CastSpell(bird, SPELL_BIRD_FALL);
                        wilhelm->AI()->Talk(SAY_WILHELM_MISS);
                        drostan->AI()->Talk(SAY_DROSTAN_REPLY_MISS);

                        bird->Kill(bird);
                        crunchy->GetMotionMaster()->MovePoint(0, bird->GetPositionX(), bird->GetPositionY(),
                            bird->GetMap()->GetWaterOrGroundLevel(bird->GetPositionX(), bird->GetPositionY(), bird->GetPositionZ()));
                        /// @todo Make crunchy perform emote eat when he reaches the bird

                        break;
                    }
                }
                case EVENT_MISS:
                {
                    shooter->CastSpell(wilhelm, SPELL_MISS_APPLE);
                    wilhelm->AI()->Talk(SAY_WILHELM_MISS);
                    drostan->AI()->Talk(SAY_DROSTAN_REPLY_MISS);
                    break;
                }
                case EVENT_HIT:
                {
                    shooter->CastSpell(apple, SPELL_HIT_APPLE);
                    apple->CastSpell(apple, SPELL_APPLE_FALL);
                    wilhelm->AI()->Talk(SAY_WILHELM_HIT);
                    if (Player* player = shooter->ToPlayer())
                        player->KilledMonsterCredit(NPC_APPLE, 0);
                    apple->DespawnOrUnsummon();

                    break;
                }
            }
        }

        void Register() OVERRIDE
        {
            OnCheckCast += SpellCheckCastFn(spell_q12589_shoot_rjr_SpellScript::CheckCast);
            OnEffectHitTarget += SpellEffectFn(spell_q12589_shoot_rjr_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const OVERRIDE
    {
        return new spell_q12589_shoot_rjr_SpellScript();
    }
};

/*######
## Quest: Song of Wind and Water ID: 12726
######*/
/*This quest precisly needs core script since battle vehicles are not well integrated with SAI,
may be easily converted to SAI when they get.*/
enum SongOfWindAndWater
{
    // Spells
    SPELL_DEVOUR_WIND   = 52862,
    SPELL_DEVOUR_WATER  = 52864,
    // NPCs
    NPC_HAIPHOON_WATER  = 28999,
    NPC_HAIPHOON_AIR    = 28985
};

class npc_haiphoon : public CreatureScript
{
public:
    npc_haiphoon() : CreatureScript("npc_haiphoon") { }

    struct npc_haiphoonAI : public VehicleAI
    {
        npc_haiphoonAI(Creature* creature) : VehicleAI(creature) { }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) OVERRIDE
        {
            if (target == me)
                return;

            if (spell->Id == SPELL_DEVOUR_WIND && me->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                me->UpdateEntry(NPC_HAIPHOON_AIR);
            }
            else if (spell->Id == SPELL_DEVOUR_WATER && me->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                me->UpdateEntry(NPC_HAIPHOON_WATER);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_haiphoonAI(creature);
    }
};

/*######
## Quest: Reconnaissance Flight (12671)
######*/
enum ReconnaissanceFlight
{
    NPC_PLANE       = 28710, // Vic's Flying Machine
    NPC_PILOT       = 28646,

    VIC_SAY_0       = 0,
    VIC_SAY_1       = 1,
    VIC_SAY_2       = 2,
    VIC_SAY_3       = 3,
    VIC_SAY_4       = 4,
    VIC_SAY_5       = 5,
    VIC_SAY_6       = 6,
    PLANE_EMOTE     = 0,

    AURA_ENGINE     = 52255, // Engine on Fire

    SPELL_LAND      = 52226, // Land Flying Machine
    SPELL_CREDIT    = 53328 // Land Flying Machine Credit
};

class npc_vics_flying_machine : public CreatureScript
{
public:
    npc_vics_flying_machine() : CreatureScript("npc_vics_flying_machine") { }

    struct npc_vics_flying_machineAI : public VehicleAI
    {
        npc_vics_flying_machineAI(Creature* creature) : VehicleAI(creature) {}

        void PassengerBoarded(Unit* passenger, int8 /*seatId*/, bool apply) OVERRIDE
        {
            if (apply && passenger->GetTypeId() == TYPEID_PLAYER)
            {
                /// @workaround - Because accessory gets unmounted when using vehicle_template_accessory.
                /// When vehicle spawns accessory is mounted to seat 0,but when player mounts
                /// he uses the same seat (instead of mounting to seat 1) kicking the accessory out.
                passenger->ChangeSeat(1, false);
                me->GetVehicleKit()->InstallAccessory(NPC_PILOT, 0, true, TEMPSUMMON_DEAD_DESPAWN, 0);
                me->GetMotionMaster()->MovePath(NPC_PLANE, false);
            }
        }

        void MovementInform(uint32 type, uint32 id) OVERRIDE
        {
            if (type != WAYPOINT_MOTION_TYPE)
                return;

            if (Creature* pilot = GetClosestCreatureWithEntry(me, NPC_PILOT, 10))
                switch (id)
                {
                    case 5:
                        pilot->AI()->Talk(VIC_SAY_0);
                        break;
                    case 11:
                        pilot->AI()->Talk(VIC_SAY_1);
                        break;
                    case 12:
                        pilot->AI()->Talk(VIC_SAY_2);
                        break;
                    case 14:
                        pilot->AI()->Talk(VIC_SAY_3);
                        break;
                    case 15:
                        pilot->AI()->Talk(VIC_SAY_4);
                        break;
                    case 17:
                        pilot->AI()->Talk(VIC_SAY_5);
                        break;
                    case 21:
                        pilot->AI()->Talk(VIC_SAY_6);
                        break;
                    case 25:
                        me->AI()->Talk(PLANE_EMOTE);
                        me->AI()->DoCast(AURA_ENGINE);
                        me->SetFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FORCE_MOVEMENT);
                        break;
                }
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) OVERRIDE
        {
            if (spell->Id == SPELL_LAND)
            {
                Unit* passenger = me->GetVehicleKit()->GetPassenger(1); // player should be on seat 1
                if (passenger && passenger->GetTypeId() == TYPEID_PLAYER)
                {
                    passenger->CastSpell(passenger, SPELL_CREDIT, true);
                    passenger->ExitVehicle();
                }
            }
        }

        void UpdateAI(uint32 /*diff*/) OVERRIDE {}
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_vics_flying_machineAI(creature);
    }
};

/*######
 ## npc_oracle_say
 ######*/

enum OracleSay
{
    ITEM_JALOOTS_FAVORITE_CRYSTAL           = 38623,
    ITEM_LAFOOS_BUG_BAG                     = 38622,
    ITEM_MOODLES_STRESS_BALL                = 38624,

    QUEST_APPEASING_THE_GREAT_RAIN_STONE    = 12704, // Npc - Alle
    QUEST_GODS_LIKE_SHINEY_THINGS           = 12572, // Npc - Lafoo
    QUEST_MAKE_THE_BAD_SNAKE_GO_AWAY        = 12571, // Npc - Lafoo
    //QUEST_FORTUNATE_MISUNDERSTANDINGS     = 12570,    Npc - 
    //QUEST_MAKING_PEACE                    = 12573, // Npc - Lafoo
    QUEST_BACK_SO_SOON                      = 12574, // Npc - Jaloo
    QUEST_FORCED_HAND                       = 12576, // Npc - Jaloo
    QUEST_THE_LOST_MISTWHISPER_TRESURE      = 12575, // Npc - Jaloo
    QUEST_THE_ANGRY_GORLOC                  = 12578, // Npc - Moodle
    QUEST_A_HEROS_BURDEN                    = 12581, // Npc - Moodle
};

#define GOSSIP_LAFOO_ITEM       "I need to find Lafoo, do you have his bug bag?"
#define GOSSIP_JALOOT_ITEM      "I need to find Jaloot, do you have his favorite crystal?"
#define GOSSIP_MOODLE_ITEM      "I need to find Moodle, do you have his stressball?"

class npc_oracle_say : public CreatureScript
{
public:
    npc_oracle_say() : CreatureScript("npc_oracle_say") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 action) OVERRIDE
    {
        ItemPosCountVec dest;
        uint32 ItemStore;

        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                ItemStore = ITEM_LAFOOS_BUG_BAG;
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                ItemStore = ITEM_JALOOTS_FAVORITE_CRYSTAL;
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                ItemStore = ITEM_MOODLES_STRESS_BALL;
                break;
        }

        if (ItemStore > 0)
        {
            uint8 canStoreNewItem = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, ItemStore, 1);
            if (canStoreNewItem == EQUIP_ERR_OK) 
            {
                Item *newItem = NULL;
                newItem = player->StoreNewItem(dest, ItemStore, 1, true);
                player->SendNewItem(newItem, 1, true, false);
            }
            player->CLOSE_GOSSIP_MENU();
        }
        return true;
    }
    
    bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_APPEASING_THE_GREAT_RAIN_STONE) == QUEST_STATUS_INCOMPLETE)
        {
            player->ADD_GOSSIP_ITEM_EXTENDED(0, GOSSIP_LAFOO_ITEM, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1, "", 0, false);
            player->ADD_GOSSIP_ITEM_EXTENDED(0, GOSSIP_JALOOT_ITEM, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2, "", 0, false);
            player->ADD_GOSSIP_ITEM_EXTENDED(0, GOSSIP_MOODLE_ITEM, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3, "", 0, false);

            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature),creature->GetGUID());
            return true;
        }

        if (player->GetQuestStatus(QUEST_MAKE_THE_BAD_SNAKE_GO_AWAY) == QUEST_STATUS_INCOMPLETE
            || (player->GetQuestStatus(QUEST_GODS_LIKE_SHINEY_THINGS) == QUEST_STATUS_INCOMPLETE
            || player->GetQuestStatus(QUEST_GODS_LIKE_SHINEY_THINGS) == QUEST_STATUS_NONE)
            || player->GetQuestStatus(QUEST_MAKING_PEACE) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM_EXTENDED(0, GOSSIP_LAFOO_ITEM, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1, "", 0, false);
   
        if (player->GetQuestStatus(QUEST_BACK_SO_SOON) == QUEST_STATUS_INCOMPLETE
            || player->GetQuestStatus(QUEST_FORCED_HAND) == QUEST_STATUS_INCOMPLETE
            || player->GetQuestStatus(QUEST_THE_LOST_MISTWHISPER_TRESURE) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM_EXTENDED(0, GOSSIP_JALOOT_ITEM, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2, "", 0, false);

        if (player->GetQuestStatus(QUEST_THE_ANGRY_GORLOC) == QUEST_STATUS_INCOMPLETE
            || (player->GetQuestStatus(QUEST_THE_ANGRY_GORLOC) == QUEST_STATUS_COMPLETE
            && player->GetQuestStatus(QUEST_A_HEROS_BURDEN) == QUEST_STATUS_NONE))
            player->ADD_GOSSIP_ITEM_EXTENDED(0, GOSSIP_MOODLE_ITEM, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3, "", 0, false);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature),creature->GetGUID());
        return true;
    }
};


/*######
## npc_switch_oracle_frenzyheart
######*/

enum QuestSwitch
{
    QUEST_FRENZYHEART_CHAMPION  = 12582,
    QUEST_HAND_OF_THE_ORACLES   = 12689
};

class npc_switch_oracle_frenzyheart : public CreatureScript
{
public:
    npc_switch_oracle_frenzyheart() : CreatureScript("npc_switch_oracle_frenzyheart") { }

    bool OnQuestReward(Player* player, Creature* creature, const Quest *_Quest, uint32 /*slot*/) OVERRIDE
    {
        switch(_Quest->GetQuestId())
        {
            case QUEST_FRENZYHEART_CHAMPION:
                player->GetReputationMgr().SetReputation(sFactionStore.LookupEntry(FACTION_FRENZYHEART),9000);
                //player->GetReputationMgr().SetReputation(sFactionStore.LookupEntry(FACTION_ORCLES),-4200);
                break;
            case QUEST_HAND_OF_THE_ORACLES:
                player->GetReputationMgr().SetReputation(sFactionStore.LookupEntry(FACTION_ORCLES),9000);
                //player->GetReputationMgr().SetReputation(sFactionStore.LookupEntry(FACTION_FRENZYHEART),-4200);
                break;
        }
        return true;
    }
};


/*######
## Quest: Still At It ID: 12664
######*/

enum McManus
{
    SAY_START      = 0,
    SAY_ORANGE     = 1,
    SAY_PAPAYA     = 2,
    SAY_BANANA     = 3,
    SAY_VALVE      = 4,
    SAY_FIRE       = 5,
    SAY_CORRECT    = 6,
    SAY_FAIL       = 7,
    SAY_COMPLETE   = 8,

    NPC_WANTS_ORANGE     = 28535,
    NPC_WANTS_PAPAYA     = 28536,
    NPC_WANTS_BANANA     = 28537,
    NPC_STEAMING_VALVE   = 28539,
    NPC_WANTS_FIRE       = 28540,

    GO_THUNDERBREW_JUNGLE_PUNCH = 190643
};

class npc_tipsy_mcmanus : public CreatureScript
{
public:
    npc_tipsy_mcmanus() : CreatureScript("npc_tipsy_mcmanus") {}

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 /*uiAction*/)
    {
        player->CLOSE_GOSSIP_MENU();
        creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
        CAST_AI(npc_tipsy_mcmanusAI, (creature->AI()))->StartDestilation();
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_tipsy_mcmanusAI (creature);
    }

    struct npc_tipsy_mcmanusAI : public ScriptedAI
    {
        npc_tipsy_mcmanusAI(Creature* creature) : ScriptedAI(creature) {}

        bool InProgress;
        bool PreAsk;
        uint32 uiTimer;
        uint16 uiStep;

        void Reset()
        {
            InProgress = false;
            PreAsk = false;
            uiTimer = 0;
            uiStep = 0;
            me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
        }

        void StartDestilation()
        {
            Talk(SAY_START);
            uiTimer = 5000;
            uiStep = 1;
            PreAsk = true;
            InProgress = true;
        }

        void SetData(uint32 type, uint32 data)
        {
            if (type == 1 && data == 1)
            {
                if (uiStep < 10)
                {
                    Talk(SAY_CORRECT);
                    ++uiStep;
                    uiTimer = 5000;
                    PreAsk = true;
                }
                else
                {
                    me->SummonGameObject(GO_THUNDERBREW_JUNGLE_PUNCH, 5547.13525f, 5767.09961f, -78.025856f, 2.25147343f, 0.0f, 0.0f, 0.0f, 0.0f, 30);
                    Talk(SAY_COMPLETE);
                    InProgress = false;
                    PreAsk = false;
                    uiStep = 0;
                    uiTimer = 0;
                    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                }
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (InProgress)
                if (uiTimer <= diff)
                {
                    if (PreAsk)
                    {
                        switch (urand (1,5))
                        {
                            case 1:
                                Talk(SAY_ORANGE);
                                me->SummonCreature(NPC_WANTS_ORANGE, 5549.62354f, 5769.51367f, -73.42824f, 2.75762f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 10000);
                                break;
                            case 2:
                                Talk(SAY_PAPAYA);
                                me->SummonCreature(NPC_WANTS_PAPAYA, 5549.62354f, 5769.51367f, -73.42824f, 2.75762f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 10000);
                                break;
                            case 3:
                                Talk(SAY_BANANA);
                                me->SummonCreature(NPC_WANTS_BANANA, 5549.62354f, 5769.51367f, -73.42824f, 2.75762f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 10000);
                                break;
                            case 4:
                                Talk(SAY_VALVE);
                                me->SummonCreature(NPC_STEAMING_VALVE, 5548.1f, 5767.4f, -76.2673f, -2.1293f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 10000);
                                break;
                            case 5:
                                Talk(SAY_FIRE);
                                me->SummonCreature(NPC_WANTS_FIRE, 5552.58f, 5765.66f, -78.0212f, -3.00195f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 10000);
                                break;
                        }

                        uiTimer = 10000;
                        PreAsk = false;
                    }
                    else
                    {
                        Talk(SAY_FAIL);
                        InProgress = false;
                        uiTimer = 0;
                        uiStep = 0;
                        me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                    }
                }
                else uiTimer -= diff;
        }
    };

};


void AddSC_sholazar_basin()
{
    new npc_vekjik();
    new npc_avatar_of_freya();
    new npc_bushwhacker();
    new npc_engineer_helice();
    new npc_adventurous_dwarf();
    new npc_jungle_punch_target();
    new spell_q12620_the_lifewarden_wrath();
    new spell_q12589_shoot_rjr();
    new npc_haiphoon();
    new npc_vics_flying_machine();
    new npc_oracle_say();
    new npc_switch_oracle_frenzyheart();
    new npc_tipsy_mcmanus();
}
