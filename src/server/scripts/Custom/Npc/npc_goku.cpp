
/*ScriptData
SDName: Goku*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Player.h"


enum Textos
{
    //Modificado Por mi, intento de NPC GOKU :D
    SAY_AGGRO                                   = 0, // "De quien es ese Ki tan poderoso..."
    SAY_RANDOM                                  = 1, // "Todos sabemos que una pelea de hombre a hombre no se termina hasta que uno de los dos renuncie por completo",
    // "Eres una basura!,
    // "Yo soy un Saiayin criado en la tierra.",
    // "Es... es un Ki tremendo.",
    // "Juro que... te exterminaré!",
    // "Que lento eres",
    // "Tu nunca me podrás ganar..."
    SAY_BERSERK                                 = 2, // "Eres un ser increíble, diste lo mejor de ti y por esto te admiro. Adios $N!"
    SAY_PHASE                                   = 3, // "¡Seres del universo, denme un poco de su energía!"
    SAY_DANCE                                   = 4, // "Fuuuuuuu.... sion! HA!"
    SAY_SALUTE                                  = 5, // "Hola, soy Goku!"
    SAY_EVADE                                   = 6, // "No tiene caso derrotarte si tienes miedo... Es mejor que vivas con ese trauma, para siempre!"
    SAY_DEATH                                   = 7, // "Nunca me había enfrentado a un sujeto tan poderoso."
    SAY_KAMEHAME                                = 8  // "Kame... Hame... HA!!!",
};

enum Spells
{
    SPELL_ONE                                   = 38538, //Combate Melee
    SPELL_ONE_ALT                               = 64536, //Energy Wave
    SPELL_TWO                                   = 59483, //Energy Barrage
    SPELL_THREE                                 = 59520, //Kamehameha
    SPELL_FOUR									= 62826, //Genkidama
    SPELL_FIVE									= 55912, //Energy Unleash
    // SPELL_FRENZY                             = 23537, //
    SPELL_BERSERK                               = 26662, //SSJ (Enrage)
    //Posibles  62826 = Energy Orb - 55912 = Blast of Air - 59520 = Water Blast - 65799 = Arcane Barrage - 59483 = Arcane Barrage Volley -
    //	38538 = Arcane Blast (Melee) - 64536 = Hand Pulse - 34186 = Hasten - 26662 = Enrage
};

enum Factions
{
    FACTION_WORGEN                              = 24
};

enum Events
{
    EVENT_SAY_TIMER = 1,
    EVENT_SPELL_1,
    EVENT_SPELL_2,
    EVENT_SPELL_3,
    EVENT_BERSAKER,
    EVENT_PHASE,
};

#define GOSSIP_ITEM     "Estoy buscando una pelea"

class Goku : public CreatureScript
{
public:
    Goku() : CreatureScript("Goku") { }

    struct GokuAI : public ScriptedAI
    {
        GokuAI(Creature* creature) : ScriptedAI(creature), summons(me) { }

        EventMap events;
        SummonList summons;

        void Reset() OVERRIDE
        {
            events.Reset();
            summons.DespawnAll();
            me->RestoreFaction();
        }

        void EnterCombat(Unit* who) OVERRIDE
        {
            Talk(SAY_AGGRO, who);
        }

        void JustDied(Unit* /*killer*/) OVERRIDE
        {
            Talk(SAY_DEATH);
        }

        void EnterEvadeMode() OVERRIDE
        {
            Talk(SAY_EVADE);
        }

        void ReceiveEmote(Player* /*player*/, uint32 uiTextEmote) OVERRIDE
        {
            me->HandleEmoteCommand(uiTextEmote);

            switch (uiTextEmote)
            {
            case TEXT_EMOTE_DANCE:
                Talk(SAY_DANCE);
                break;
            case TEXT_EMOTE_SALUTE:
                Talk(SAY_SALUTE);
                break;
            }
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_SAY_TIMER:
                    if (!me->GetVictim())
                    {
                        //Random switch between 5 outcomes
                        Talk(SAY_RANDOM);
                        events.ScheduleEvent(EVENT_SAY_TIMER, 25*IN_MILLISECONDS);
                        break;
                    }
                case  EVENT_SPELL_1:
                    if (rand()%50 > 10)
                        DoCastVictim(SPELL_ONE_ALT);
                    else if (me->IsWithinDist(me->GetVictim(), 25.0f))
                        DoCastVictim(SPELL_ONE);
                    events.ScheduleEvent(EVENT_SPELL_1, 4*IN_MILLISECONDS);
                    break;
                case EVENT_SPELL_2:
                    DoCast(SPELL_TWO);
                    DoCast(SPELL_TWO);
                    DoCast(SPELL_TWO);
                    events.ScheduleEvent(EVENT_SPELL_2, 20*IN_MILLISECONDS);
                    break;
                case EVENT_SPELL_3:
                    DoCast(SPELL_FOUR);
                    events.ScheduleEvent(EVENT_SPELL_3, 18*IN_MILLISECONDS);
                    break;
                case EVENT_BERSAKER:
                    DoCastVictim(SPELL_THREE);
                    DoCastVictim(SPELL_THREE);
                    DoCastVictim(SPELL_THREE);
                    DoCastVictim(SPELL_THREE);
                    DoCastVictim(SPELL_THREE);
                    Talk(SAY_KAMEHAME);
                    events.ScheduleEvent(EVENT_BERSAKER, 15*IN_MILLISECONDS);
                    break;
                }
                DoMeleeAttackIfReady();
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new GokuAI(creature);
    }

    bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
    {
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        player->SEND_GOSSIP_MENU(907, creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) OVERRIDE
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_INFO_DEF+1)
        {
            player->CLOSE_GOSSIP_MENU();
            creature->setFaction(FACTION_WORGEN);
            creature->AI()->AttackStart(player);
        }

        return true;
    }
};
// IMPORTANTE!
// En algún lugar debería ir la llamada de cuando muere, (void justdied) para utilizar el mensaje. Además tengo la duda de, donde va el HP, el Swing time, el daño básico, el armor, y las inmunidades.
// SPELL_ONE_ALT quiero que lo use cuando el objetivo esté a más de 8 yardas, cada 4 segundos.
// La idea es que el npc tenga el modelo del pelo con Pinchos de humano, con ropa naranja (voy a ver si pillo) y cuando entre en enrage cambie de modelo a lo mismo pero con pelo amarillo, y en una de
// esas le aparezca un aura hermosa :D...
// Mmmm... qué más falta?
// Ah el daño, la armor, el attack speed y la vida... eso lo vemos juntos ok :D?

void AddSC_npc_goku()
{
    new Goku();
}
