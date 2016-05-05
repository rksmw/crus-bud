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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"

enum Cerdoball
{
    // Spells
    SPELL_CHARGED_HANDS     = 34226,
    SPELL_FIERY_HANDS       = 34223,

    // Creatures
    NPC_CERDOBALL_REF       = 100007,

    // Texts
    SAY_GOAL_RED            = 0,
    SAY_GOAL_BLUE           = 1,
    SAY_FAULT_RED           = 2,
    SAY_FAULT_BLUE          = 3
};

class npc_cerdoball_ball : public CreatureScript
{
public:
    npc_cerdoball_ball() : CreatureScript("npc_cerdoball_ball") { }

    struct npc_cerdoball_ballAI : public ScriptedAI
    {
        npc_cerdoball_ballAI(Creature* creature) : ScriptedAI(creature) {}

        bool gol;

        void Reset()
        {
           gol = false;
        }

        void ScoreGoal(bool RedTeam, bool byFault)
        {
            gol = true;
            me->Kill(me);
            if (Creature* referee = me->FindNearestCreature(NPC_CERDOBALL_REF, 200.0f))
            {
                if (!byFault)
                    referee->AI()->Talk(RedTeam ? SAY_GOAL_RED : SAY_GOAL_BLUE);
                else
                    referee->AI()->Talk(RedTeam ? SAY_FAULT_RED : SAY_FAULT_BLUE);
            }
        }

        void DamageTaken(Unit* who, uint32& damage) OVERRIDE
        {
            if (me->GetHealth() <= damage)
            {
                if (who->HasAura(SPELL_FIERY_HANDS))
                    ScoreGoal(false, true);

                else if (who->HasAura(SPELL_CHARGED_HANDS))
                    ScoreGoal(true, true);
            }
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            if (!gol)
            {
                if (me->GetPositionY() >= -4350.35f && me->GetPositionY() <= -4335.35f)
                {
                    if (me->GetPositionX() <= -4734.49f)
                        ScoreGoal(true, false);

                    else if (me->GetPositionX() >= -4664.49f)
                        ScoreGoal(false, false);
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_cerdoball_ballAI(creature);
    }
};

void AddSC_events_pvp_cerdoball()
{
    new npc_cerdoball_ball();
}
