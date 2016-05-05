/* Copyright (C) 2006 - 2013 ScriptDev2 <http://www.scriptdev2.com/>
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/* ScriptData
SDName: chess_event
SD%Complete: 80
SDComment: Chess AI could use some improvements.
SDCategory: Karazhan
EndScriptData */

//#include "ScriptPCH.h"
#include "InstanceScript.h"
#include "ScriptedCreature.h"
#include "SpellMgr.h"
#include "Unit.h"
#include "karazhan.h"

enum
{
    // texts
    EMOTE_LIFT_CURSE                = 0,
    EMOTE_CHEAT                     = 1,

    SOUND_ID_GAME_BEGIN             = 10338,
    SOUND_ID_LOSE_PAWN_PLAYER_1     = 10339,
    SOUND_ID_LOSE_PAWN_PLAYER_2     = 10340,
    SOUND_ID_LOSE_PAWN_PLAYER_3     = 10341,
    SOUND_ID_LOSE_PAWN_MEDIVH_1     = 10342,
    SOUND_ID_LOSE_PAWN_MEDIVH_2     = 10343,
    SOUND_ID_LOSE_PAWN_MEDIVH_3     = 10344,
    SOUND_ID_LOSE_ROOK_PLAYER       = 10345,
    SOUND_ID_LOSE_ROOK_MEDIVH       = 10346,
    SOUND_ID_LOSE_BISHOP_PLAYER     = 10347,
    SOUND_ID_LOSE_BISHOP_MEDIVH     = 10348,
    SOUND_ID_LOSE_KNIGHT_PLAYER     = 10349,
    SOUND_ID_LOSE_KNIGHT_MEDIVH     = 10350,
    SOUND_ID_LOSE_QUEEN_PLAYER      = 10351,
    SOUND_ID_LOSE_QUEEN_MEDIVH      = 10352,
    SOUND_ID_CHECK_PLAYER           = 10353,
    SOUND_ID_CHECK_MEDIVH           = 10354,
    SOUND_ID_WIN_PLAYER             = 10355,
    SOUND_ID_WIN_MEDIVH             = 10356,
    SOUND_ID_CHEAT_1                = 10357,
    SOUND_ID_CHEAT_2                = 10358,
    SOUND_ID_CHEAT_3                = 10359,

    // movement spells
    SPELL_MOVE_GENERIC              = 30012,                    // spell which sends the signal to move - handled in core
    SPELL_MOVE_1                    = 32312,                    // spell which selects AI move square (for short range pieces)
    SPELL_MOVE_2                    = 37388,                    // spell which selects AI move square (for long range pieces)
    // SPELL_MOVE_PAWN              = 37146,                    // individual move spells (used only by controlled npcs)
    // SPELL_MOVE_KNIGHT            = 37144,
    // SPELL_MOVE_QUEEN             = 37148,
    // SPELL_MOVE_ROCK              = 37151,
    // SPELL_MOVE_BISHOP            = 37152,
    // SPELL_MOVE_KING              = 37153,

    // additional movement spells
    SPELL_CHANGE_FACING             = 30284,                    // spell which sends the initial facing request - handled in core
    SPELL_FACE_SQUARE               = 30270,                    // change facing - finalize facing update

    SPELL_MOVE_TO_SQUARE            = 30253,                    // spell which sends the move response from the square to the piece
    SPELL_MOVE_COOLDOWN             = 30543,                    // add some cooldown to movement
    SPELL_MOVE_MARKER               = 32261,                    // white beam visual - used to mark the movement as complete
    SPELL_DISABLE_SQUARE            = 32745,                    // used by the White / Black triggers on the squares when a chess piece moves into place
    SPELL_IS_SQUARE_USED            = 39400,                    // cast when a chess piece moves to another square
    // SPELL_SQUARED_OCCUPIED       = 39399,                    // triggered by 39400; used to check if the square is occupied (if hits a target); Missing in 2.4.3

    // generic spells
    SPELL_IN_GAME                   = 30532,                    // teleport player near the entrance
    SPELL_CONTROL_PIECE             = 30019,                    // control a chess piece
    SPELL_RECENTLY_IN_GAME          = 30529,                    // debuff on player after chess piece uncharm

    SPELL_CHESS_AI_ATTACK_TIMER     = 32226,                    // melee action timer - triggers 32225
    SPELL_ACTION_MELEE              = 32225,                    // handle melee attacks
    SPELL_MELEE_DAMAGE              = 32247,                    // melee damage spell - used by all chess pieces
    // SPELL_AI_SNAPSHOT_TIMER      = 37440,                    // used to trigger spell 32260; purpose and usage unk
    // SPELL_DISABLE_SQUARE_SELF    = 32260,                    // used when a piece moves to another square
    // SPELL_AI_ACTION_TIMER        = 37504,                    // handle some kind of event check. Cast by npc 17459. Currently the way it works is unk
    // SPELL_DISABLE_SQUARE         = 30271,                    // not used
    // SPELL_FIND_ENEMY             = 32303,                    // not used
    // SPELL_MOVE_NEAR_UNIT         = 30417,                    // not used
    // SPELL_GET_EMPTY_SQUARE       = 30418,                    // not used
    // SPELL_FACE_NEARBY_ENEMY      = 37787,                    // not used
    // SPELL_POST_MOVE_FACING       = 38011,                    // not used

    // melee action spells
    SPELL_MELEE_FOOTMAN             = 32227,
    SPELL_MELEE_WATER_ELEM          = 37142,
    SPELL_MELEE_CHARGER             = 37143,
    SPELL_MELEE_CLERIC              = 37147,
    SPELL_MELEE_CONJURER            = 37149,
    SPELL_MELEE_KING_LLANE          = 37150,
    SPELL_MELEE_GRUNT               = 32228,
    SPELL_MELEE_DAEMON              = 37220,
    SPELL_MELEE_NECROLYTE           = 37337,
    SPELL_MELEE_WOLF                = 37339,
    SPELL_MELEE_WARLOCK             = 37345,
    SPELL_MELEE_WARCHIEF_BLACKHAND  = 37348,

    // cheat spells
    SPELL_HAND_OF_MEDIVH_HORDE      = 39338,                    // triggers 39339
    SPELL_HAND_OF_MEDIVH_ALLIANCE   = 39342,                    // triggers 39339
    SPELL_FURY_OF_MEDIVH_HORDE      = 39341,                    // triggers 39343
    SPELL_FURY_OF_MEDIVH_ALLIANCE   = 39344,                    // triggers 39345
    SPELL_FURY_OF_MEDIVH_AURA       = 39383,
    // SPELL_FULL_HEAL_HORDE        = 39334,                    // spells are not confirmed (probably removed after 2.4.3)
    // SPELL_FULL_HEAL_ALLIANCE     = 39335,

    // spells used by the chess npcs
    SPELL_HEROISM                   = 37471,                    // human king
    SPELL_SWEEP                     = 37474,
    SPELL_BLOODLUST                 = 37472,                    // orc king
    SPELL_CLEAVE                    = 37476,
    SPELL_HEROIC_BLOW               = 37406,                    // human pawn
    SPELL_SHIELD_BLOCK              = 37414,
    SPELL_VICIOUS_STRIKE            = 37413,                    // orc pawn
    SPELL_WEAPON_DEFLECTION         = 37416,
    SPELL_SMASH                     = 37453,                    // human knight
    SPELL_STOMP                     = 37498,
    SPELL_BITE                      = 37454,                    // orc knight
    SPELL_HOWL                      = 37502,
    SPELL_ELEMENTAL_BLAST           = 37462,                    // human queen
    SPELL_RAIN_OF_FIRE              = 37465,
    SPELL_FIREBALL                  = 37463,                    // orc queen
    // SPELL_POISON_CLOUD           = 37469,
    SPELL_POISON_CLOUD_ACTION       = 37775,                    // triggers 37469 - acts as a target selector spell for orc queen
    SPELL_HEALING                   = 37455,                    // human bishop
    SPELL_HOLY_LANCE                = 37459,
    // SPELL_SHADOW_MEND            = 37456,                    // orc bishop
    SPELL_SHADOW_MEND_ACTION        = 37824,                    // triggers 37456 - acts as a target selector spell for orc bishop
    SPELL_SHADOW_SPEAR              = 37461,
    SPELL_GEYSER                    = 37427,                    // human rook
    SPELL_WATER_SHIELD              = 37432,
    SPELL_HELLFIRE                  = 37428,                    // orc rook
    SPELL_FIRE_SHIELD               = 37434,

    // spells used to transform side trigger when npc dies
    SPELL_TRANSFORM_FOOTMAN         = 39350,
    SPELL_TRANSFORM_CHARGER         = 39352,
    SPELL_TRANSFORM_CLERIC          = 39353,
    SPELL_TRANSFORM_WATER_ELEM      = 39354,
    SPELL_TRANSFORM_CONJURER        = 39355,
    SPELL_TRANSFORM_KING_LLANE      = 39356,
    SPELL_TRANSFORM_GRUNT           = 39357,
    SPELL_TRANSFORM_WOLF            = 39358,
    SPELL_TRANSFORM_NECROLYTE       = 39359,
    SPELL_TRANSFORM_DAEMON          = 39360,
    SPELL_TRANSFORM_WARLOCK         = 39361,
    SPELL_TRANSFORM_BLACKHAND       = 39362,

    // generic npcs
    // NPC_SQUARE_OUTSIDE_B         = 17316,                    // used to check the interior of the board
    // NPC_SQUARE_OUTSIDE_W         = 17317,                    // not used in our script; keep for reference only
    NPC_FURY_MEDIVH_VISUAL          = 22521,                    // has aura 39383

    // gossip texts
    //GOSSIP_ITEM_ORC_GRUNT           = -3532006,
    //GOSSIP_ITEM_ORC_WOLF            = -3532007,
    //GOSSIP_ITEM_SUMMONED_DEAMON     = -3532008,
    //GOSSIP_ITEM_ORC_WARLOCK         = -3532009,
    //GOSSIP_ITEM_ORC_NECROLYTE       = -3532010,
    //GOSSIP_ITEM_WARCHIEF_BLACKHAND  = -3532011,
    //GOSSIP_ITEM_HUMAN_FOOTMAN       = -3532012,
    //GOSSIP_ITEM_HUMAN_CHARGER       = -3532013,
    //GOSSIP_ITEM_WATER_ELEMENTAL     = -3532014,
    //GOSSIP_ITEM_HUMAN_CONJURER      = -3532015,
    //GOSSIP_ITEM_HUMAN_CLERIC        = -3532016,
    //GOSSIP_ITEM_KING_LLANE          = -3532017,
    //GOSSIP_ITEM_RESET_BOARD         = -3532018,

    // gossip menu
    GOSSIP_MENU_ID_GRUNT            = 10425,
    GOSSIP_MENU_ID_WOLF             = 10439,
    GOSSIP_MENU_ID_WARLOCK          = 10440,
    GOSSIP_MENU_ID_NECROLYTE        = 10434,
    GOSSIP_MENU_ID_DEAMON           = 10426,
    GOSSIP_MENU_ID_BLACKHAND        = 10442,
    GOSSIP_MENU_ID_FOOTMAN          = 8952,
    GOSSIP_MENU_ID_CHARGER          = 10414,
    GOSSIP_MENU_ID_CONJURER         = 10417,
    GOSSIP_MENU_ID_CLERIC           = 10416,
    GOSSIP_MENU_ID_ELEMENTAL        = 10413,
    GOSSIP_MENU_ID_LLANE            = 10418,
    GOSSIP_MENU_ID_MEDIVH           = 10506,
    GOSSIP_MENU_ID_MEDIVH_BEATEN    = 10718,

    // misc
    TARGET_TYPE_RANDOM              = 1,
    TARGET_TYPE_FRIENDLY            = 2,
};

/*######
## npc_echo_of_medivh
######*/

class npc_echo_of_medivh : public CreatureScript
{
public:
    npc_echo_of_medivh() : CreatureScript("npc_echo_of_medivh") { }

    bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
    {
        InstanceScript* instance = creature->GetInstanceScript();
        if (!instance)
            return false;

        if (instance->GetData(TYPE_CHESS) != DONE && instance->GetData(TYPE_CHESS) != SPECIAL)
            player->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_MEDIVH, creature->GetGUID());
        else
        {
            if (instance->GetData(TYPE_CHESS) == SPECIAL)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Please reset the chess board, we would like to play again.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

            player->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_MEDIVH_BEATEN, creature->GetGUID());

            return true;
        }

        return false;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) OVERRIDE
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_INFO_DEF + 1)
        {
            // reset the board
            if (InstanceScript* instance = creature->GetInstanceScript())
                instance->SetData(TYPE_CHESS, DONE);

            player->CLOSE_GOSSIP_MENU();
        }

        return true;
    }

    struct npc_echo_of_medivhAI : public ScriptedAI
    {
        npc_echo_of_medivhAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
            uiTeamInInstance = 0;
            Reset();
        }

        InstanceScript* m_pInstance;

        uint32 m_uiCheatTimer;
        uint32 uiTeamInInstance;

        void Reset() OVERRIDE
        {
            m_uiCheatTimer = 90000;

            Map::PlayerList const &players = me->GetMap()->GetPlayers();
            if (!players.isEmpty())
            {
                if (Player* player = players.begin()->GetSource())
                    uiTeamInInstance = player->GetTeam();
            }
        }

        void MoveInLineOfSight(Unit* /*pWho*/) OVERRIDE { }
        void AttackStart(Unit* /*pWho*/) OVERRIDE { }

        void JustSummoned(Creature* pSummoned) OVERRIDE
        {
            if (pSummoned->GetEntry() == NPC_FURY_MEDIVH_VISUAL)
                pSummoned->CastSpell(pSummoned, SPELL_FURY_OF_MEDIVH_AURA, true);
        }

        void UpdateAI(uint32 uiDiff) OVERRIDE
        {
            if (!m_pInstance || m_pInstance->GetData(TYPE_CHESS) != IN_PROGRESS)
                return;

            if (m_uiCheatTimer <= uiDiff)
            {
                me->CastSpell(me, urand(0, 1) ? (uiTeamInInstance == ALLIANCE ? SPELL_HAND_OF_MEDIVH_HORDE : SPELL_HAND_OF_MEDIVH_ALLIANCE) : (uiTeamInInstance == ALLIANCE ? SPELL_FURY_OF_MEDIVH_ALLIANCE : SPELL_FURY_OF_MEDIVH_HORDE));

                switch (urand(0, 2))
                {
                    case 0: DoPlaySoundToSet(me, SOUND_ID_CHEAT_1); break;
                    case 1: DoPlaySoundToSet(me, SOUND_ID_CHEAT_2); break;
                    case 2: DoPlaySoundToSet(me, SOUND_ID_CHEAT_3); break;
                }

                Talk(EMOTE_CHEAT);
                m_uiCheatTimer = 90000;
            }
            else
                m_uiCheatTimer -= uiDiff;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_echo_of_medivhAI(creature);
    }
};

/*######
## npc_chess_piece_generic
######*/

struct npc_chess_piece_genericAI : public ScriptedAI
{
    npc_chess_piece_genericAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = pCreature->GetInstanceScript();
        uiTeamInInstance = 0;
        m_uiSetSquareTimer = 3000;
        Reset();
    }

    InstanceScript* m_pInstance;

    uint64 m_currentSquareGuid;

    uint32 m_uiMoveTimer;
    uint32 m_uiMoveCommandTimer;
    uint32 m_uiSpellCommandTimer;
    uint32 m_uiSetSquareTimer;
    uint32 uiTeamInInstance;

    bool m_bIsPrimarySpell;
    float m_fCurrentOrientation;

    void Reset() OVERRIDE
    {
        m_uiMoveTimer = 0;
        m_uiMoveCommandTimer = 1000;
        m_uiSpellCommandTimer = me->HasAura(SPELL_CONTROL_PIECE) ? 0 : 1000;
        m_bIsPrimarySpell = true;

        // cancel move timer for player faction npcs or for friendly games
        if (m_pInstance)
        {
            Map::PlayerList const &players = me->GetMap()->GetPlayers();
            if (!players.isEmpty())
            {
                if (Player* player = players.begin()->GetSource())
                    uiTeamInInstance = player->GetTeam();
            }

            if ((uiTeamInInstance == ALLIANCE && me->getFaction() == FACTION_CHESS_ALLIANCE) || (uiTeamInInstance == HORDE && me->getFaction() == FACTION_CHESS_HORDE) || m_pInstance->GetData(TYPE_CHESS) == DONE)
                m_uiMoveCommandTimer = 0;
        }
    }

    // no default attacking or evading
    void MoveInLineOfSight(Unit* /*pWho*/) OVERRIDE { }
    void AttackStart(Unit* /*pWho*/) OVERRIDE { }
    void EnterEvadeMode() OVERRIDE { }

    void JustDied(Unit* /*pKiller*/) OVERRIDE
    {
        if (Map* map = me->GetMap())
        {
            if (Creature* pSquare = map->GetCreature(m_currentSquareGuid))
                pSquare->RemoveAllAuras();
        }

        // ToDo: remove corpse after 10 sec
    }

    void SetGUID(uint64 guid, int32 type) OVERRIDE
    {
        switch (type)
        {
            case 1:
            {
                // clear the current square
                if (Map* map = me->GetMap())
                {
                    if (Creature* pSquare = map->GetCreature(m_currentSquareGuid))
                        pSquare->RemoveAllAuras();
                }

                m_currentSquareGuid = guid;
                m_uiMoveTimer = 2000;
                return;
            }
            default:
                break;
        }

        // reset the variables
        Reset();
        m_currentSquareGuid = guid;

        // ToDo: enable this when the scope of the spell is clear
        //if (Creature* pStalker = m_pInstance->GetSingleCreatureFromStorage(NPC_WAITING_ROOM_STALKER))
        //    pStalker->CastSpell(pStalker, SPELL_AI_ACTION_TIMER, true);

        //me->CastSpell(me, SPELL_AI_SNAPSHOT_TIMER, CAST_TRIGGERED);
        me->CastSpell(me, SPELL_CHESS_AI_ATTACK_TIMER, TRIGGERED_CAST_DIRECTLY);

        if (Map* map = me->GetMap())
        {
            if (Creature* invoker = map->GetCreature(guid))
            {
                invoker->CastSpell(invoker, SPELL_DISABLE_SQUARE, true);
                invoker->CastSpell(invoker, SPELL_IS_SQUARE_USED, true);
            }
        }
    }

    void MovementInform(uint32 uiMotionType, uint32 uiPointId) OVERRIDE
    {
        if (uiMotionType != POINT_MOTION_TYPE || !uiPointId)
            return;

        // update facing
        if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 5.0f))
            me->CastSpell(pTarget, SPELL_CHANGE_FACING);
        else
            me->SetFacingTo(m_fCurrentOrientation);
    }

    void SpellHit(Unit* pCaster, const SpellInfo* pSpell) OVERRIDE
    {
        // do a soft reset when the piece is controlled
        if (pCaster->GetTypeId() == TYPEID_PLAYER && pSpell->Id == SPELL_CONTROL_PIECE)
            Reset();
    }

    void SpellHitTarget(Unit* target, const SpellInfo* pSpell) OVERRIDE
    {
        if (pSpell->Id == SPELL_MOVE_GENERIC)
            SetGUID(target->GetGUID(), 1);
    }

    // Function which returns a random target by type and range
    Unit* GetTargetByType(uint8 uiType, float fRange, float fArc = M_PI)
    {
        if (!m_pInstance)
            return NULL;

        Map* map = me->GetMap();
        if (!map)
            return NULL;

        uint32 uiTeam = me->getFaction() == FACTION_CHESS_ALLIANCE ? FACTION_CHESS_HORDE : FACTION_CHESS_ALLIANCE;

        // get friendly list for this type
        if (uiType == TARGET_TYPE_FRIENDLY)
            uiTeam = me->getFaction();

        // Get the list of enemies
        std::vector<Creature*> vTargets;
        //vTargets.reserve(lTempList.size());
        //GetChessPiecesByFaction(lTempList, me->getFaction() == FACTION_CHESS_ALLIANCE ? FACTION_CHESS_ALLIANCE : FACTION_CHESS_HORDE);

        CellCoord pair(Trinity::ComputeCellCoord(me->GetPositionX(), me->GetPositionY()));
        Cell cell(pair);
        cell.SetNoCreate();

        std::list<Creature*> creatureList;

        Trinity::AnyUnitInObjectRangeCheck go_check(me, fRange ? fRange : 66.0f);
        Trinity::CreatureListSearcher<Trinity::AnyUnitInObjectRangeCheck> go_search(me, creatureList, go_check);
        TypeContainerVisitor<Trinity::CreatureListSearcher<Trinity::AnyUnitInObjectRangeCheck>, GridTypeMapContainer> go_visit(go_search);

        // Get Creatures
        cell.Visit(pair, go_visit, *(map), *me, fRange ? fRange : 66.0f);

        if (!creatureList.empty())
        {
            for (std::list<Creature*>::iterator itr = creatureList.begin(); itr != creatureList.end(); ++itr)
            {
                Creature* pTemp = *itr;
                if (!pTemp && !pTemp->IsAlive() && pTemp->IsTrigger())
                    continue;

                if (uiTeam == FACTION_CHESS_ALLIANCE)
                {
                    switch (pTemp->GetEntry())
                    {
                        case NPC_HUMAN_CHARGER:
                        case NPC_HUMAN_CLERIC:
                        case NPC_HUMAN_CONJURER:
                        case NPC_HUMAN_FOOTMAN:
                        case NPC_CONJURED_WATER_ELEMENTAL:
                        case NPC_KING_LLANE:
                        {
                            // check for specified range targets and angle; Note: to be checked if the angle is right
                            if (fRange && !me->isInFrontInMap(pTemp, fRange, fArc))
                                continue;

                            // skip friendly targets which are at full HP
                            if (uiType == TARGET_TYPE_FRIENDLY && pTemp->GetHealth() == pTemp->GetMaxHealth())
                                continue;

                            vTargets.push_back(pTemp);
                            break;
                        }
                        default:
                            break;
                    }
                }
                else
                {
                    switch (pTemp->GetEntry())
                    {
                        case NPC_ORC_GRUNT:
                        case NPC_ORC_NECROLYTE:
                        case NPC_ORC_WARLOCK:
                        case NPC_ORC_WOLF:
                        case NPC_SUMMONED_DAEMON:
                        case NPC_WARCHIEF_BLACKHAND:
                        {
                            // check for specified range targets and angle; Note: to be checked if the angle is right
                            if (fRange && !me->isInFrontInMap(pTemp, fRange, fArc))
                                continue;

                            // skip friendly targets which are at full HP
                            if (uiType == TARGET_TYPE_FRIENDLY && pTemp->GetHealth() == pTemp->GetMaxHealth())
                                continue;

                            vTargets.push_back(pTemp);
                            break;
                        }
                        default:
                            break;
                    }
                }
            }
        }

        if (vTargets.empty())
            return NULL;

        return vTargets[urand(0, vTargets.size() - 1)];
    }

    // Function to get a square as close as possible to the enemy
    Unit* GetMovementSquare()
    {
        if (!m_pInstance)
            return NULL;

        Map* map = me->GetMap();
        if (!map)
            return NULL;

        // define distance based on the spell radius
        // this will replace the targeting system of spells SPELL_MOVE_1 and SPELL_MOVE_2
        float fRadius = 10.0f;

        // some pieces have special distance
        switch (me->GetEntry())
        {
            case NPC_HUMAN_CONJURER:
            case NPC_ORC_WARLOCK:
            case NPC_HUMAN_CHARGER:
            case NPC_ORC_WOLF:
                fRadius = 15.0f;
                break;
            default:
                break;
        }

        // get all available squares for movement
        std::list<Creature*> lSquaresList;
        GetCreatureListWithEntryInGrid(lSquaresList, me, NPC_SQUARE_BLACK, fRadius);
        GetCreatureListWithEntryInGrid(lSquaresList, me, NPC_SQUARE_WHITE, fRadius);

        if (lSquaresList.empty())
            return NULL;

        //GetChessPiecesByFaction(lEnemies, me->getFaction() == FACTION_CHESS_ALLIANCE ? FACTION_CHESS_HORDE : FACTION_CHESS_ALLIANCE);

        CellCoord pair(Trinity::ComputeCellCoord(me->GetPositionX(), me->GetPositionY()));
        Cell cell(pair);
        cell.SetNoCreate();

        std::list<Creature*> creatureList;

        Trinity::AnyUnitInObjectRangeCheck go_check(me, 66.0f);
        Trinity::CreatureListSearcher<Trinity::AnyUnitInObjectRangeCheck> go_search(me, creatureList, go_check);
        TypeContainerVisitor<Trinity::CreatureListSearcher<Trinity::AnyUnitInObjectRangeCheck>, GridTypeMapContainer> go_visit(go_search);

        // Get Creatures
        cell.Visit(pair, go_visit, *(map), *me, 66.0f);

        std::list<Creature*> lEnemies;

        if (!creatureList.empty())
        {
            uint32 faction = me->getFaction() == FACTION_CHESS_ALLIANCE ? FACTION_CHESS_HORDE : FACTION_CHESS_ALLIANCE;

            for (std::list<Creature*>::iterator itr = creatureList.begin(); itr != creatureList.end(); ++itr)
            {
                Creature* pTemp = *itr;
                if (!pTemp && !pTemp->IsAlive())
                    continue;

                if (faction == FACTION_CHESS_ALLIANCE)
                {
                    switch (pTemp->GetEntry())
                    {
                        case NPC_HUMAN_CHARGER:
                        case NPC_HUMAN_CLERIC:
                        case NPC_HUMAN_CONJURER:
                        case NPC_HUMAN_FOOTMAN:
                        case NPC_CONJURED_WATER_ELEMENTAL:
                        case NPC_KING_LLANE:
                            lEnemies.push_back(pTemp);
                            break;
                        default:
                            break;
                    }
                }
                else
                {
                    switch (pTemp->GetEntry())
                    {
                        case NPC_ORC_GRUNT:
                        case NPC_ORC_NECROLYTE:
                        case NPC_ORC_WARLOCK:
                        case NPC_ORC_WOLF:
                        case NPC_SUMMONED_DAEMON:
                        case NPC_WARCHIEF_BLACKHAND:
                            lEnemies.push_back(pTemp);
                            break;
                        default:
                            break;
                    }
                }
            }
        }

        if (lEnemies.empty())
            return NULL;

        // Sort the enemies by distance and the squares compared to the distance to the closest enemy
        lEnemies.sort(Trinity::ObjectDistanceOrderPred(me));
        lSquaresList.sort(Trinity::ObjectDistanceOrderPred(lEnemies.front()));

        Creature* temp = lSquaresList.front();
        if (temp && temp->HasAura(39400))
            lSquaresList.remove(temp);

        return lSquaresList.front();
    }

    virtual uint32 DoCastPrimarySpell() { return 5000; }
    virtual uint32 DoCastSecondarySpell() { return 5000; }

    void UpdateAI(uint32 uiDiff) OVERRIDE
    {
        if (!m_pInstance || m_pInstance->GetData(TYPE_CHESS) != IN_PROGRESS)
            return;

        // issue move command
        if (m_uiMoveCommandTimer)
        {
            if (m_uiMoveCommandTimer <= uiDiff)
            {
                // just update facing if some enemy is near
                if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 5.0f))
                    me->CastSpell(pTarget, SPELL_CHANGE_FACING);
                else
                {
                    // the npc doesn't have a 100% chance to move; also there should be some GCD check in core for this part
                    if (roll_chance_i(5))
                    {
                        // Note: in a normal case the target would be chosen using the spells above
                        // However, because the core doesn't support special targeting, we'll provide explicit target
                        //uint32 uiMoveSpell = SPELL_MOVE_1;
                        //switch (m_creature->GetEntry())
                        //{
                        //    case NPC_HUMAN_CONJURER:
                        //    case NPC_ORC_WARLOCK:
                        //    case NPC_HUMAN_CHARGER:
                        //    case NPC_ORC_WOLF:
                        //        uiMoveSpell = SPELL_MOVE_2;
                        //        break;
                        //}
                        //me->CastSpell(me, uiMoveSpell, CAST_TRIGGERED);

                        // workaround which provides specific move target
                        if (Unit* pTarget = GetMovementSquare())
                            me->CastSpell(pTarget, SPELL_MOVE_GENERIC, TRIGGERED_CAST_DIRECTLY);

                        m_fCurrentOrientation = me->GetOrientation();
                    }
                }

                m_uiMoveCommandTimer = 5000;
            }
            else
                m_uiMoveCommandTimer -= uiDiff;
        }

        if (m_uiSetSquareTimer)
        {
            if (m_uiSetSquareTimer <= uiDiff)
            {
                Creature* creature = me->FindNearestCreature(NPC_SQUARE_BLACK, 2.0f);
                if (!creature)
                    creature = me->FindNearestCreature(NPC_SQUARE_WHITE, 2.0f);

                if (creature)
                {
                    creature->CastSpell(creature, SPELL_DISABLE_SQUARE, true);
                    creature->CastSpell(creature, SPELL_IS_SQUARE_USED, true);
                    m_currentSquareGuid = creature->GetGUID();
                }

                m_uiSetSquareTimer = 0;
            }
            else
                m_uiSetSquareTimer -= uiDiff;
        }

        // issue spell command
        if (m_uiSpellCommandTimer)
        {
            if (m_uiSpellCommandTimer <= uiDiff)
            {
                // alternate the spells and also reset the timer
                m_uiSpellCommandTimer = m_bIsPrimarySpell ? DoCastPrimarySpell() : DoCastSecondarySpell();
                m_bIsPrimarySpell = !m_bIsPrimarySpell;
            }
            else
                m_uiSpellCommandTimer -= uiDiff;
        }

        // finish move timer
        if (m_uiMoveTimer)
        {
            if (m_uiMoveTimer <= uiDiff)
            {
                if (Map* map = me->GetMap())
                {
                    if (Creature* pSquare = map->GetCreature(m_currentSquareGuid))
                    {
                        me->CastSpell(pSquare, SPELL_MOVE_MARKER, TRIGGERED_CAST_DIRECTLY);
                        me->GetMotionMaster()->MovePoint(1, pSquare->GetPositionX(), pSquare->GetPositionY(), pSquare->GetPositionZ());
                    }
                }
                m_uiMoveTimer = 0;
            }
            else
                m_uiMoveTimer -= uiDiff;
        }

        if (!me->SelectNearestTarget(50.0f) || !me->GetVictim())
            return;
    }
};

/*######
## npc_king_llane
######*/

class npc_king_llane : public CreatureScript
{
public:
    npc_king_llane() : CreatureScript("npc_king_llane") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature) OVERRIDE
    {
        if (pPlayer->HasAura(SPELL_RECENTLY_IN_GAME) || pCreature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* pInstance = pCreature->GetInstanceScript())
        {
            if (pInstance->GetData(TYPE_CHESS) != DONE && pPlayer->GetTeam() == ALLIANCE)
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Control King Llane", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        pPlayer->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_LLANE, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 sender, uint32 uiAction) OVERRIDE
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF + 1)
        {
            // start event when used on the king
            if (InstanceScript* pInstance = pCreature->GetInstanceScript())
            {
                if (!pCreature->GetCharmInfo())
                {
                    pCreature->InitCharmInfo();
                    if (CharmInfo* charmInfo = pCreature->GetCharmInfo())
                        charmInfo->InitPossessCreateSpells();
                }

                // teleport at the entrance and control the chess piece
                pPlayer->CastSpell(pPlayer, SPELL_IN_GAME, true);
                pPlayer->CastSpell(pCreature, SPELL_CONTROL_PIECE, true);

                if (pInstance->GetData(TYPE_CHESS) == NOT_STARTED)
                    pInstance->SetData(TYPE_CHESS, IN_PROGRESS);
                else if (pInstance->GetData(TYPE_CHESS) == DONE)
                    pInstance->SetData(TYPE_CHESS, SPECIAL);
            }

            pPlayer->CLOSE_GOSSIP_MENU();
        }

        return true;
    }

    struct npc_king_llaneAI : public npc_chess_piece_genericAI
    {
        npc_king_llaneAI(Creature* pCreature) : npc_chess_piece_genericAI(pCreature)
        {
            m_bIsAttacked = false;
            Reset();
        }

        bool m_bIsAttacked;

        void DamageTaken(Unit* pDoneBy, uint32& uiDamage) OVERRIDE
        {
            if (!uiDamage || !m_bIsAttacked || !m_pInstance || pDoneBy->GetTypeId() != TYPEID_UNIT)
                return;

            if (Creature* pMedivh = me->FindNearestCreature(NPC_ECHO_MEDIVH, 128.0f))
            {
                if (uiTeamInInstance == ALLIANCE)
                    DoPlaySoundToSet(pMedivh, SOUND_ID_CHECK_PLAYER);
                else
                    DoPlaySoundToSet(pMedivh, SOUND_ID_CHECK_MEDIVH);
            }

            m_bIsAttacked = true;
        }

        void JustDied(Unit* pKiller) OVERRIDE
        {
            npc_chess_piece_genericAI::JustDied(pKiller);

            if (!m_pInstance)
                return;

            Creature* pMedivh = me->FindNearestCreature(NPC_ECHO_MEDIVH, 128.0f);
            if (!pMedivh)
                return;

            if (m_pInstance->GetData(TYPE_CHESS) == SPECIAL)
                m_pInstance->SetData(TYPE_CHESS, DONE);
            else
            {
                if (uiTeamInInstance == HORDE)
                {
                    DoPlaySoundToSet(pMedivh, SOUND_ID_WIN_PLAYER);
                    pMedivh->AI()->Talk(EMOTE_LIFT_CURSE);

                    m_pInstance->SetData(TYPE_CHESS, DONE);
                }
                else
                {
                    DoPlaySoundToSet(pMedivh, SOUND_ID_WIN_MEDIVH);
                    m_pInstance->SetData(TYPE_CHESS, FAIL);
                }
            }

            ChessEvent chess;
            chess.DoMoveChessPieceToSides(SPELL_TRANSFORM_KING_LLANE, FACTION_CHESS_ALLIANCE, true, me);
        }

        uint32 DoCastPrimarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 20.0f))
            {
                me->CastSpell(pTarget, SPELL_HEROISM);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_HEROISM))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 10.0f))
            {
                me->CastSpell(pTarget, SPELL_SWEEP);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_SWEEP))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_king_llaneAI(creature);
    }
};

/*######
## npc_warchief_blackhand
######*/

class npc_warchief_blackhand : public CreatureScript
{
public:
    npc_warchief_blackhand() : CreatureScript("npc_warchief_blackhand") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature) OVERRIDE
    {
        if (pPlayer->HasAura(SPELL_RECENTLY_IN_GAME) || pCreature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* pInstance = pCreature->GetInstanceScript())
        {
            if (pInstance->GetData(TYPE_CHESS) != DONE && pPlayer->GetTeam() == HORDE)
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Control Warchief Blackhand", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        pPlayer->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_BLACKHAND, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 sender, uint32 uiAction) OVERRIDE
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF + 1)
        {
            // start event when used on the king
            if (InstanceScript* pInstance = pCreature->GetInstanceScript())
            {
                if (!pCreature->GetCharmInfo())
                {
                    pCreature->InitCharmInfo();
                    if (CharmInfo* charmInfo = pCreature->GetCharmInfo())
                        charmInfo->InitPossessCreateSpells();
                }

                // teleport at the entrance and control the chess piece
                pPlayer->CastSpell(pPlayer, SPELL_IN_GAME, true);
                pPlayer->CastSpell(pCreature, SPELL_CONTROL_PIECE, true);

                if (pInstance->GetData(TYPE_CHESS) == NOT_STARTED)
                    pInstance->SetData(TYPE_CHESS, IN_PROGRESS);
                else if (pInstance->GetData(TYPE_CHESS) == DONE)
                    pInstance->SetData(TYPE_CHESS, SPECIAL);
            }

            pPlayer->CLOSE_GOSSIP_MENU();
        }

        return true;
    }

    struct npc_warchief_blackhandAI : public npc_chess_piece_genericAI
    {
        npc_warchief_blackhandAI(Creature* pCreature) : npc_chess_piece_genericAI(pCreature)
        {
            m_bIsAttacked = false;
            Reset();
        }

        bool m_bIsAttacked;

        void DamageTaken(Unit* pDoneBy, uint32& uiDamage) OVERRIDE
        {
            if (!uiDamage || !m_bIsAttacked || !m_pInstance || pDoneBy->GetTypeId() != TYPEID_UNIT)
                return;

            if (Creature* pMedivh = me->FindNearestCreature(NPC_ECHO_MEDIVH, 128.0f))
            {
                if (uiTeamInInstance == HORDE)
                    DoPlaySoundToSet(pMedivh, SOUND_ID_CHECK_PLAYER);
                else
                    DoPlaySoundToSet(pMedivh, SOUND_ID_CHECK_MEDIVH);
            }

            m_bIsAttacked = true;
        }

        void JustDied(Unit* pKiller) OVERRIDE
        {
            npc_chess_piece_genericAI::JustDied(pKiller);

            if (!m_pInstance)
                return;

            Creature* pMedivh = me->FindNearestCreature(NPC_ECHO_MEDIVH, 128.0f);
            if (!pMedivh)
                return;

            if (m_pInstance->GetData(TYPE_CHESS) == SPECIAL)
                m_pInstance->SetData(TYPE_CHESS, DONE);
            else
            {
                if (uiTeamInInstance == ALLIANCE)
                {
                    DoPlaySoundToSet(pMedivh, SOUND_ID_WIN_PLAYER);
                    pMedivh->AI()->Talk(EMOTE_LIFT_CURSE); //DoScriptText(EMOTE_LIFT_CURSE, pMedivh);

                    m_pInstance->SetData(TYPE_CHESS, DONE);
                }
                else
                {
                    DoPlaySoundToSet(pMedivh, SOUND_ID_WIN_MEDIVH);
                    m_pInstance->SetData(TYPE_CHESS, FAIL);
                }
            }

            ChessEvent chess;
            chess.DoMoveChessPieceToSides(SPELL_TRANSFORM_BLACKHAND, FACTION_CHESS_HORDE, true, me);
        }

        uint32 DoCastPrimarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 20.0f))
            {
                me->CastSpell(me, SPELL_BLOODLUST);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_BLOODLUST))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 10.0f))
            {
                me->CastSpell(me, SPELL_CLEAVE);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_CLEAVE))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_warchief_blackhandAI(creature);
    }
};

/*######
## npc_human_conjurer
######*/

class npc_human_conjurer : public CreatureScript
{
public:
    npc_human_conjurer() : CreatureScript("npc_human_conjurer") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature) OVERRIDE
    {
        if (pPlayer->HasAura(SPELL_RECENTLY_IN_GAME) || pCreature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* pInstance = pCreature->GetInstanceScript())
        {
            if ((pInstance->GetData(TYPE_CHESS) == IN_PROGRESS && pPlayer->GetTeam() == ALLIANCE) || pInstance->GetData(TYPE_CHESS) == SPECIAL)
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Control Human Conjurer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        pPlayer->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_CONJURER, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 sender, uint32 uiAction) OVERRIDE
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF + 1)
        {
            // start event when used on the king
            if (InstanceScript* pInstance = pCreature->GetInstanceScript())
            {
                if (!pCreature->GetCharmInfo())
                {
                    pCreature->InitCharmInfo();
                    if (CharmInfo* charmInfo = pCreature->GetCharmInfo())
                        charmInfo->InitPossessCreateSpells();
                }

                // teleport at the entrance and control the chess piece
                pPlayer->CastSpell(pPlayer, SPELL_IN_GAME, true);
                pPlayer->CastSpell(pCreature, SPELL_CONTROL_PIECE, true);

                if (pInstance->GetData(TYPE_CHESS) == NOT_STARTED)
                    pInstance->SetData(TYPE_CHESS, IN_PROGRESS);
                else if (pInstance->GetData(TYPE_CHESS) == DONE)
                    pInstance->SetData(TYPE_CHESS, SPECIAL);
            }

            pPlayer->CLOSE_GOSSIP_MENU();
        }

        return true;
    }

    struct npc_human_conjurerAI : public npc_chess_piece_genericAI
    {
        npc_human_conjurerAI(Creature* pCreature) : npc_chess_piece_genericAI(pCreature) { Reset(); }

        void JustDied(Unit* pKiller) OVERRIDE
        {
            npc_chess_piece_genericAI::JustDied(pKiller);

            if (!m_pInstance)
                return;

            Creature* pMedivh = me->FindNearestCreature(NPC_ECHO_MEDIVH, 128.0f);
            if (!pMedivh)
                return;

            if (uiTeamInInstance == ALLIANCE)
                DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_QUEEN_PLAYER);
            else
                DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_QUEEN_MEDIVH);

            ChessEvent chess;
            chess.DoMoveChessPieceToSides(SPELL_TRANSFORM_CONJURER, FACTION_CHESS_ALLIANCE, false, me);
        }

        uint32 DoCastPrimarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 20.0f))
            {
                me->CastSpell(pTarget, SPELL_ELEMENTAL_BLAST);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_ELEMENTAL_BLAST))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 25.0f))
            {
                me->CastSpell(pTarget, SPELL_RAIN_OF_FIRE);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_RAIN_OF_FIRE))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_human_conjurerAI(creature);
    }
};

/*######
## npc_orc_warlock
######*/

class npc_orc_warlock : public CreatureScript
{
public:
    npc_orc_warlock() : CreatureScript("npc_orc_warlock") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature) OVERRIDE
    {
        if (pPlayer->HasAura(SPELL_RECENTLY_IN_GAME) || pCreature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* pInstance = pCreature->GetInstanceScript())
        {
            if ((pInstance->GetData(TYPE_CHESS) == IN_PROGRESS && pPlayer->GetTeam() == HORDE) || pInstance->GetData(TYPE_CHESS) == SPECIAL)
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Control Orc Warlock", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        pPlayer->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_WARLOCK, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 sender, uint32 uiAction) OVERRIDE
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF + 1)
        {
            // start event when used on the king
            if (InstanceScript* pInstance = pCreature->GetInstanceScript())
            {
                if (!pCreature->GetCharmInfo())
                {
                    pCreature->InitCharmInfo();
                    if (CharmInfo* charmInfo = pCreature->GetCharmInfo())
                        charmInfo->InitPossessCreateSpells();
                }

                // teleport at the entrance and control the chess piece
                pPlayer->CastSpell(pPlayer, SPELL_IN_GAME, true);
                pPlayer->CastSpell(pCreature, SPELL_CONTROL_PIECE, true);

                if (pInstance->GetData(TYPE_CHESS) == NOT_STARTED)
                    pInstance->SetData(TYPE_CHESS, IN_PROGRESS);
                else if (pInstance->GetData(TYPE_CHESS) == DONE)
                    pInstance->SetData(TYPE_CHESS, SPECIAL);
            }

            pPlayer->CLOSE_GOSSIP_MENU();
        }

        return true;
    }

    struct npc_orc_warlockAI : public npc_chess_piece_genericAI
    {
        npc_orc_warlockAI(Creature* pCreature) : npc_chess_piece_genericAI(pCreature) { Reset(); }

        void JustDied(Unit* pKiller) OVERRIDE
        {
            npc_chess_piece_genericAI::JustDied(pKiller);

            if (!m_pInstance)
                return;

            Creature* pMedivh = me->FindNearestCreature(NPC_ECHO_MEDIVH, 128.0f);
            if (!pMedivh)
                return;

            if (uiTeamInInstance == HORDE)
                DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_QUEEN_PLAYER);
            else
                DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_QUEEN_MEDIVH);

            ChessEvent chess;
            chess.DoMoveChessPieceToSides(SPELL_TRANSFORM_WARLOCK, FACTION_CHESS_HORDE, false, me);
        }

        uint32 DoCastPrimarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 20.0f))
            {
                me->CastSpell(pTarget, SPELL_FIREBALL);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_FIREBALL))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 25.0f))
            {
                me->CastSpell(pTarget, SPELL_POISON_CLOUD_ACTION);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_POISON_CLOUD_ACTION))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_orc_warlockAI(creature);
    }
};

/*######
## npc_human_footman
######*/

class npc_human_footman : public CreatureScript
{
public:
    npc_human_footman() : CreatureScript("npc_human_footman") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature) OVERRIDE
    {
        if (pPlayer->HasAura(SPELL_RECENTLY_IN_GAME) || pCreature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* pInstance = pCreature->GetInstanceScript())
        {
            if ((pInstance->GetData(TYPE_CHESS) == IN_PROGRESS && pPlayer->GetTeam() == ALLIANCE) || pInstance->GetData(TYPE_CHESS) == SPECIAL)
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Control Human Footman", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        pPlayer->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_FOOTMAN, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 sender, uint32 uiAction) OVERRIDE
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF + 1)
        {
            // start event when used on the king
            if (InstanceScript* pInstance = pCreature->GetInstanceScript())
            {
                if (!pCreature->GetCharmInfo())
                {
                    pCreature->InitCharmInfo();
                    if (CharmInfo* charmInfo = pCreature->GetCharmInfo())
                        charmInfo->InitPossessCreateSpells();
                }

                // teleport at the entrance and control the chess piece
                pPlayer->CastSpell(pPlayer, SPELL_IN_GAME, true);
                pPlayer->CastSpell(pCreature, SPELL_CONTROL_PIECE, true);

                if (pInstance->GetData(TYPE_CHESS) == NOT_STARTED)
                    pInstance->SetData(TYPE_CHESS, IN_PROGRESS);
                else if (pInstance->GetData(TYPE_CHESS) == DONE)
                    pInstance->SetData(TYPE_CHESS, SPECIAL);
            }

            pPlayer->CLOSE_GOSSIP_MENU();
        }

        return true;
    }

    struct npc_human_footmanAI : public npc_chess_piece_genericAI
    {
        npc_human_footmanAI(Creature* pCreature) : npc_chess_piece_genericAI(pCreature) { Reset(); }

        void JustDied(Unit* pKiller) OVERRIDE
        {
            npc_chess_piece_genericAI::JustDied(pKiller);

            if (!m_pInstance)
                return;

            Creature* pMedivh = me->FindNearestCreature(NPC_ECHO_MEDIVH, 128.0f);
            if (!pMedivh)
                return;

            if (uiTeamInInstance == ALLIANCE)
            {
                switch (urand(0, 2))
                {
                    case 0: DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_PAWN_PLAYER_1); break;
                    case 1: DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_PAWN_PLAYER_2); break;
                    case 2: DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_PAWN_PLAYER_3); break;
                }
            }
            else
            {
                switch (urand(0, 2))
                {
                    case 0: DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_PAWN_MEDIVH_1); break;
                    case 1: DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_PAWN_MEDIVH_2); break;
                    case 2: DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_PAWN_MEDIVH_3); break;
                }
            }

            ChessEvent chess;
            chess.DoMoveChessPieceToSides(SPELL_TRANSFORM_FOOTMAN, FACTION_CHESS_ALLIANCE, false, me);
        }

        uint32 DoCastPrimarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 8.0f, M_PI / 12))
            {
                me->CastSpell(me, SPELL_HEROIC_BLOW);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_HEROIC_BLOW))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 8.0f))
            {
                me->CastSpell(me, SPELL_SHIELD_BLOCK);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_SHIELD_BLOCK))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const OVERRIDE
    {
        return new npc_human_footmanAI(pCreature);
    }
};

/*######
## npc_orc_grunt
######*/

class npc_orc_grunt : public CreatureScript
{
public:
    npc_orc_grunt() : CreatureScript("npc_orc_grunt") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature) OVERRIDE
    {
        if (pPlayer->HasAura(SPELL_RECENTLY_IN_GAME) || pCreature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* pInstance = pCreature->GetInstanceScript())
        {
            if ((pInstance->GetData(TYPE_CHESS) == IN_PROGRESS && pPlayer->GetTeam() == HORDE) || pInstance->GetData(TYPE_CHESS) == SPECIAL)
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Control Orc Grunt", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        pPlayer->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_GRUNT, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 sender, uint32 uiAction) OVERRIDE
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF + 1)
        {
            // start event when used on the king
            if (InstanceScript* pInstance = pCreature->GetInstanceScript())
            {
                if (!pCreature->GetCharmInfo())
                {
                    pCreature->InitCharmInfo();
                    if (CharmInfo* charmInfo = pCreature->GetCharmInfo())
                        charmInfo->InitPossessCreateSpells();
                }

                // teleport at the entrance and control the chess piece
                pPlayer->CastSpell(pPlayer, SPELL_IN_GAME, true);
                pPlayer->CastSpell(pCreature, SPELL_CONTROL_PIECE, true);

                if (pInstance->GetData(TYPE_CHESS) == NOT_STARTED)
                    pInstance->SetData(TYPE_CHESS, IN_PROGRESS);
                else if (pInstance->GetData(TYPE_CHESS) == DONE)
                    pInstance->SetData(TYPE_CHESS, SPECIAL);
            }

            pPlayer->CLOSE_GOSSIP_MENU();
        }

        return true;
    }

    struct npc_orc_gruntAI : public npc_chess_piece_genericAI
    {
        npc_orc_gruntAI(Creature* pCreature) : npc_chess_piece_genericAI(pCreature) { Reset(); }

        void JustDied(Unit* pKiller) OVERRIDE
        {
            npc_chess_piece_genericAI::JustDied(pKiller);

            if (!m_pInstance)
                return;

            Creature* pMedivh = me->FindNearestCreature(NPC_ECHO_MEDIVH, 128.0f);
            if (!pMedivh)
                return;

            if (uiTeamInInstance == HORDE)
            {
                switch (urand(0, 2))
                {
                    case 0: DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_PAWN_PLAYER_1); break;
                    case 1: DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_PAWN_PLAYER_2); break;
                    case 2: DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_PAWN_PLAYER_3); break;
                }
            }
            else
            {
                switch (urand(0, 2))
                {
                    case 0: DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_PAWN_MEDIVH_1); break;
                    case 1: DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_PAWN_MEDIVH_2); break;
                    case 2: DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_PAWN_MEDIVH_3); break;
                }
            }

            ChessEvent chess;
            chess.DoMoveChessPieceToSides(SPELL_TRANSFORM_GRUNT, FACTION_CHESS_HORDE, false, me);
        }

        uint32 DoCastPrimarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 8.0f, M_PI / 12))
            {
                me->CastSpell(me, SPELL_VICIOUS_STRIKE);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_VICIOUS_STRIKE))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 8.0f))
            {
                me->CastSpell(me, SPELL_WEAPON_DEFLECTION);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_WEAPON_DEFLECTION))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const OVERRIDE
    {
        return new npc_orc_gruntAI(pCreature);
    }
};

/*######
## npc_water_elemental
######*/

class npc_conjured_water_elemental : public CreatureScript
{
public:
    npc_conjured_water_elemental() : CreatureScript("npc_conjured_water_elemental") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature) OVERRIDE
    {
        if (pPlayer->HasAura(SPELL_RECENTLY_IN_GAME) || pCreature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* pInstance = pCreature->GetInstanceScript())
        {
            if ((pInstance->GetData(TYPE_CHESS) == IN_PROGRESS && pPlayer->GetTeam() == ALLIANCE) || pInstance->GetData(TYPE_CHESS) == SPECIAL)
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Control Conjured Water Elemental", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        pPlayer->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_ELEMENTAL, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 sender, uint32 uiAction) OVERRIDE
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF + 1)
        {
            // start event when used on the king
            if (InstanceScript* pInstance = pCreature->GetInstanceScript())
            {
                if (!pCreature->GetCharmInfo())
                {
                    pCreature->InitCharmInfo();
                    if (CharmInfo* charmInfo = pCreature->GetCharmInfo())
                        charmInfo->InitPossessCreateSpells();
                }

                // teleport at the entrance and control the chess piece
                pPlayer->CastSpell(pPlayer, SPELL_IN_GAME, true);
                pPlayer->CastSpell(pCreature, SPELL_CONTROL_PIECE, true);

                if (pInstance->GetData(TYPE_CHESS) == NOT_STARTED)
                    pInstance->SetData(TYPE_CHESS, IN_PROGRESS);
                else if (pInstance->GetData(TYPE_CHESS) == DONE)
                    pInstance->SetData(TYPE_CHESS, SPECIAL);
            }

            pPlayer->CLOSE_GOSSIP_MENU();
        }

        return true;
    }

    struct npc_conjured_water_elementalAI : public npc_chess_piece_genericAI
    {
        npc_conjured_water_elementalAI(Creature* pCreature) : npc_chess_piece_genericAI(pCreature) { Reset(); }

        void JustDied(Unit* pKiller) OVERRIDE
        {
            npc_chess_piece_genericAI::JustDied(pKiller);

            if (!m_pInstance)
                return;

            Creature* pMedivh = me->FindNearestCreature(NPC_ECHO_MEDIVH, 128.0f);
            if (!pMedivh)
                return;

            if (uiTeamInInstance == ALLIANCE)
                DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_ROOK_PLAYER);
            else
                DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_ROOK_MEDIVH);

            ChessEvent chess;
            chess.DoMoveChessPieceToSides(SPELL_TRANSFORM_WATER_ELEM, FACTION_CHESS_ALLIANCE, false, me);
        }

        uint32 DoCastPrimarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 9.0f))
            {
                me->CastSpell(me, SPELL_GEYSER);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_GEYSER))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 9.0f))
            {
                me->CastSpell(me, SPELL_WATER_SHIELD);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_WATER_SHIELD))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const OVERRIDE
    {
        return new npc_conjured_water_elementalAI(pCreature);
    }
};

/*######
## npc_summoned_daemon
######*/

class npc_summoned_daemon : public CreatureScript
{
public:
    npc_summoned_daemon() : CreatureScript("npc_summoned_daemon") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature) OVERRIDE
    {
        if (pPlayer->HasAura(SPELL_RECENTLY_IN_GAME) || pCreature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* pInstance = pCreature->GetInstanceScript())
        {
            if ((pInstance->GetData(TYPE_CHESS) == IN_PROGRESS && pPlayer->GetTeam() == HORDE) || pInstance->GetData(TYPE_CHESS) == SPECIAL)
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Control Summoned Daemon", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        pPlayer->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_DEAMON, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 sender, uint32 uiAction) OVERRIDE
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF + 1)
        {
            // start event when used on the king
            if (InstanceScript* pInstance = pCreature->GetInstanceScript())
            {
                if (!pCreature->GetCharmInfo())
                {
                    pCreature->InitCharmInfo();
                    if (CharmInfo* charmInfo = pCreature->GetCharmInfo())
                        charmInfo->InitPossessCreateSpells();
                }

                // teleport at the entrance and control the chess piece
                pPlayer->CastSpell(pPlayer, SPELL_IN_GAME, true);
                pPlayer->CastSpell(pCreature, SPELL_CONTROL_PIECE, true);

                if (pInstance->GetData(TYPE_CHESS) == NOT_STARTED)
                    pInstance->SetData(TYPE_CHESS, IN_PROGRESS);
                else if (pInstance->GetData(TYPE_CHESS) == DONE)
                    pInstance->SetData(TYPE_CHESS, SPECIAL);
            }

            pPlayer->CLOSE_GOSSIP_MENU();
        }

        return true;
    }

    struct npc_summoned_daemonAI : public npc_chess_piece_genericAI
    {
        npc_summoned_daemonAI(Creature* pCreature) : npc_chess_piece_genericAI(pCreature) { Reset(); }

        void JustDied(Unit* pKiller) OVERRIDE
        {
            npc_chess_piece_genericAI::JustDied(pKiller);

            if (!m_pInstance)
                return;

            Creature* pMedivh = me->FindNearestCreature(NPC_ECHO_MEDIVH, 128.0f);
            if (!pMedivh)
                return;

            if (uiTeamInInstance == HORDE)
                DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_ROOK_PLAYER);
            else
                DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_ROOK_MEDIVH);

            ChessEvent chess;
            chess.DoMoveChessPieceToSides(SPELL_TRANSFORM_DAEMON, FACTION_CHESS_HORDE, false, me);
        }

        uint32 DoCastPrimarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 9.0f))
            {
                me->CastSpell(me, SPELL_HELLFIRE);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_HELLFIRE))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 9.0f))
            {
                me->CastSpell(me, SPELL_FIRE_SHIELD);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_FIRE_SHIELD))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const OVERRIDE
    {
        return new npc_summoned_daemonAI(pCreature);
    }
};

/*######
## npc_human_charger
######*/

class npc_human_charger : public CreatureScript
{
public:
    npc_human_charger() : CreatureScript("npc_human_charger") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature) OVERRIDE
    {
        if (pPlayer->HasAura(SPELL_RECENTLY_IN_GAME) || pCreature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* pInstance = pCreature->GetInstanceScript())
        {
            if ((pInstance->GetData(TYPE_CHESS) == IN_PROGRESS && pPlayer->GetTeam() == ALLIANCE) || pInstance->GetData(TYPE_CHESS) == SPECIAL)
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Control Human Charger", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        pPlayer->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_CHARGER, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 sender, uint32 uiAction) OVERRIDE
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF + 1)
        {
            // start event when used on the king
            if (InstanceScript* pInstance = pCreature->GetInstanceScript())
            {
                if (!pCreature->GetCharmInfo())
                {
                    pCreature->InitCharmInfo();
                    if (CharmInfo* charmInfo = pCreature->GetCharmInfo())
                        charmInfo->InitPossessCreateSpells();
                }

                // teleport at the entrance and control the chess piece
                pPlayer->CastSpell(pPlayer, SPELL_IN_GAME, true);
                pPlayer->CastSpell(pCreature, SPELL_CONTROL_PIECE, true);

                if (pInstance->GetData(TYPE_CHESS) == NOT_STARTED)
                    pInstance->SetData(TYPE_CHESS, IN_PROGRESS);
                else if (pInstance->GetData(TYPE_CHESS) == DONE)
                    pInstance->SetData(TYPE_CHESS, SPECIAL);
            }

            pPlayer->CLOSE_GOSSIP_MENU();
        }

        return true;
    }

    struct npc_human_chargerAI : public npc_chess_piece_genericAI
    {
        npc_human_chargerAI(Creature* pCreature) : npc_chess_piece_genericAI(pCreature) { Reset(); }

        void JustDied(Unit* pKiller) OVERRIDE
        {
            npc_chess_piece_genericAI::JustDied(pKiller);

            if (!m_pInstance)
                return;

            Creature* pMedivh = me->FindNearestCreature(NPC_ECHO_MEDIVH, 128.0f);
            if (!pMedivh)
                return;

            if (uiTeamInInstance == ALLIANCE)
                DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_KNIGHT_PLAYER);
            else
                DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_KNIGHT_MEDIVH);

            ChessEvent chess;
            chess.DoMoveChessPieceToSides(SPELL_TRANSFORM_CHARGER, FACTION_CHESS_ALLIANCE, false, me);
        }

        uint32 DoCastPrimarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 8.0f, M_PI / 12))
            {
                me->CastSpell(me, SPELL_SMASH);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_SMASH))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 10.0f, M_PI / 12))
            {
                me->CastSpell(me, SPELL_STOMP);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_STOMP))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const OVERRIDE
    {
        return new npc_human_chargerAI(pCreature);
    }
};

/*######
## npc_orc_wolf
######*/

class npc_orc_wolf : public CreatureScript
{
public:
    npc_orc_wolf() : CreatureScript("npc_orc_wolf") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature) OVERRIDE
    {
        if (pPlayer->HasAura(SPELL_RECENTLY_IN_GAME) || pCreature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* pInstance = pCreature->GetInstanceScript())
        {
            if ((pInstance->GetData(TYPE_CHESS) == IN_PROGRESS && pPlayer->GetTeam() == HORDE) || pInstance->GetData(TYPE_CHESS) == SPECIAL)
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Control Orc Wolf", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        pPlayer->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_WOLF, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 sender, uint32 uiAction) OVERRIDE
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF + 1)
        {
            // start event when used on the king
            if (InstanceScript* pInstance = pCreature->GetInstanceScript())
            {
                if (!pCreature->GetCharmInfo())
                {
                    pCreature->InitCharmInfo();
                    if (CharmInfo* charmInfo = pCreature->GetCharmInfo())
                        charmInfo->InitPossessCreateSpells();
                }

                // teleport at the entrance and control the chess piece
                pPlayer->CastSpell(pPlayer, SPELL_IN_GAME, true);
                pPlayer->CastSpell(pCreature, SPELL_CONTROL_PIECE, true);

                if (pInstance->GetData(TYPE_CHESS) == NOT_STARTED)
                    pInstance->SetData(TYPE_CHESS, IN_PROGRESS);
                else if (pInstance->GetData(TYPE_CHESS) == DONE)
                    pInstance->SetData(TYPE_CHESS, SPECIAL);
            }

            pPlayer->CLOSE_GOSSIP_MENU();
        }

        return true;
    }

    struct npc_orc_wolfAI : public npc_chess_piece_genericAI
    {
        npc_orc_wolfAI(Creature* pCreature) : npc_chess_piece_genericAI(pCreature) { Reset(); }

        void JustDied(Unit* pKiller) OVERRIDE
        {
            npc_chess_piece_genericAI::JustDied(pKiller);

            if (!m_pInstance)
                return;

            Creature* pMedivh = me->FindNearestCreature(NPC_ECHO_MEDIVH, 128.0f);
            if (!pMedivh)
                return;

            if (uiTeamInInstance == HORDE)
                DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_KNIGHT_PLAYER);
            else
                DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_KNIGHT_MEDIVH);

            ChessEvent chess;
            chess.DoMoveChessPieceToSides(SPELL_TRANSFORM_WOLF, FACTION_CHESS_HORDE, false, me);
        }

        uint32 DoCastPrimarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 8.0f, M_PI / 12))
            {
                me->CastSpell(me, SPELL_BITE);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_BITE))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 10.0f, M_PI / 12))
            {
                me->CastSpell(me, SPELL_HOWL);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_HOWL))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const OVERRIDE
    {
        return new npc_orc_wolfAI(pCreature);
    }
};

/*######
## npc_human_cleric
######*/

class npc_human_cleric : public CreatureScript
{
public:
    npc_human_cleric() : CreatureScript("npc_human_cleric") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature) OVERRIDE
    {
        if (pPlayer->HasAura(SPELL_RECENTLY_IN_GAME) || pCreature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* pInstance = pCreature->GetInstanceScript())
        {
            if ((pInstance->GetData(TYPE_CHESS) == IN_PROGRESS && pPlayer->GetTeam() == ALLIANCE) || pInstance->GetData(TYPE_CHESS) == SPECIAL)
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Control Human Cleric", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        pPlayer->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_CLERIC, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 sender, uint32 uiAction) OVERRIDE
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF + 1)
        {
            // start event when used on the king
            if (InstanceScript* pInstance = pCreature->GetInstanceScript())
            {
                if (!pCreature->GetCharmInfo())
                {
                    pCreature->InitCharmInfo();
                    if (CharmInfo* charmInfo = pCreature->GetCharmInfo())
                        charmInfo->InitPossessCreateSpells();
                }

                // teleport at the entrance and control the chess piece
                pPlayer->CastSpell(pPlayer, SPELL_IN_GAME, true);
                pPlayer->CastSpell(pCreature, SPELL_CONTROL_PIECE, true);

                if (pInstance->GetData(TYPE_CHESS) == NOT_STARTED)
                    pInstance->SetData(TYPE_CHESS, IN_PROGRESS);
                else if (pInstance->GetData(TYPE_CHESS) == DONE)
                    pInstance->SetData(TYPE_CHESS, SPECIAL);
            }

            pPlayer->CLOSE_GOSSIP_MENU();
        }

        return true;
    }

    struct npc_human_clericAI : public npc_chess_piece_genericAI
    {
        npc_human_clericAI(Creature* pCreature) : npc_chess_piece_genericAI(pCreature) { Reset(); }

        void JustDied(Unit* pKiller) OVERRIDE
        {
            npc_chess_piece_genericAI::JustDied(pKiller);

            if (!m_pInstance)
                return;

            Creature* pMedivh = me->FindNearestCreature(NPC_ECHO_MEDIVH, 128.0f);
            if (!pMedivh)
                return;

            if (uiTeamInInstance == ALLIANCE)
                DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_BISHOP_PLAYER);
            else
                DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_BISHOP_MEDIVH);

            ChessEvent chess;
            chess.DoMoveChessPieceToSides(SPELL_TRANSFORM_CLERIC, FACTION_CHESS_ALLIANCE, false, me);
        }

        uint32 DoCastPrimarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_FRIENDLY, 25.0f))
            {
                me->CastSpell(pTarget, SPELL_HEALING);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_HEALING))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 18.0f, M_PI / 12))
            {
                me->CastSpell(me, SPELL_HOLY_LANCE);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_HOLY_LANCE))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const OVERRIDE
    {
        return new npc_human_clericAI(pCreature);
    }
};

/*######
## npc_orc_necrolyte
######*/

class npc_orc_necrolyte : public CreatureScript
{
public:
    npc_orc_necrolyte() : CreatureScript("npc_orc_necrolyte") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature) OVERRIDE
    {
        if (pPlayer->HasAura(SPELL_RECENTLY_IN_GAME) || pCreature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* pInstance = pCreature->GetInstanceScript())
        {
            if ((pInstance->GetData(TYPE_CHESS) == IN_PROGRESS && pPlayer->GetTeam() == HORDE) || pInstance->GetData(TYPE_CHESS) == SPECIAL)
                pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Control Orc Necrolyte", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        pPlayer->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_NECROLYTE, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 sender, uint32 uiAction) OVERRIDE
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF + 1)
        {
            // start event when used on the king
            if (InstanceScript* pInstance = pCreature->GetInstanceScript())
            {
                if (!pCreature->GetCharmInfo())
                {
                    pCreature->InitCharmInfo();
                    if (CharmInfo* charmInfo = pCreature->GetCharmInfo())
                        charmInfo->InitPossessCreateSpells();
                }

                // teleport at the entrance and control the chess piece
                pPlayer->CastSpell(pPlayer, SPELL_IN_GAME, true);
                pPlayer->CastSpell(pCreature, SPELL_CONTROL_PIECE, true);

                if (pInstance->GetData(TYPE_CHESS) == NOT_STARTED)
                    pInstance->SetData(TYPE_CHESS, IN_PROGRESS);
                else if (pInstance->GetData(TYPE_CHESS) == DONE)
                    pInstance->SetData(TYPE_CHESS, SPECIAL);
            }

            pPlayer->CLOSE_GOSSIP_MENU();
        }

        return true;
    }

    struct npc_orc_necrolyteAI : public npc_chess_piece_genericAI
    {
        npc_orc_necrolyteAI(Creature* pCreature) : npc_chess_piece_genericAI(pCreature) { Reset(); }

        void JustDied(Unit* pKiller) OVERRIDE
        {
            npc_chess_piece_genericAI::JustDied(pKiller);

            if (!m_pInstance)
                return;

            Creature* pMedivh = me->FindNearestCreature(NPC_ECHO_MEDIVH, 128.0f);
            if (!pMedivh)
                return;

            if (uiTeamInInstance == HORDE)
                DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_BISHOP_PLAYER);
            else
                DoPlaySoundToSet(pMedivh, SOUND_ID_LOSE_BISHOP_MEDIVH);

            ChessEvent chess;
            chess.DoMoveChessPieceToSides(SPELL_TRANSFORM_NECROLYTE, FACTION_CHESS_HORDE, false, me);
        }

        uint32 DoCastPrimarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_FRIENDLY, 25.0f))
            {
                me->CastSpell(pTarget, SPELL_SHADOW_MEND_ACTION);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_SHADOW_MEND_ACTION))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() OVERRIDE
        {
            if (Unit* pTarget = GetTargetByType(TARGET_TYPE_RANDOM, 18.0f, M_PI / 12))
            {
                me->CastSpell(me, SPELL_SHADOW_SPEAR);

                // reset timer based on spell values
                if (const SpellInfo* pSpell = sSpellMgr->GetSpellInfo(SPELL_SHADOW_SPEAR))
                    return pSpell->RecoveryTime ? pSpell->RecoveryTime : pSpell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const OVERRIDE
    {
        return new npc_orc_necrolyteAI(pCreature);
    }
};

class spell_chess_event_generic : public SpellScriptLoader
{
    public:
        spell_chess_event_generic() : SpellScriptLoader("spell_chess_event_generic") { }

        class spell_chess_event_generic_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_chess_event_generic_SpellScript);

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);

                if (!GetSpellInfo())
                    return;

                Unit* caster = GetCaster();
                Unit* target = GetHitUnit();

                if (!caster && !target)
                    return;

                switch (GetSpellInfo()->Id)
                {
                    case SPELL_MOVE_TO_SQUARE: // movement perform spell
                    {
                        if (caster->GetTypeId() == TYPEID_UNIT)
                        {
                            caster->CastSpell(caster, SPELL_DISABLE_SQUARE, true);
                            caster->CastSpell(caster, SPELL_IS_SQUARE_USED, true);

                            target->CastSpell(target, SPELL_MOVE_COOLDOWN, true);
                        }
                        break;
                    }
                    case SPELL_ACTION_MELEE: // generic melee tick
                    {
                        uint32 uiMeleeSpell = 0;
                        switch (target->GetEntry())
                        {
                            case NPC_KING_LLANE:                uiMeleeSpell = SPELL_MELEE_KING_LLANE;          break;
                            case NPC_HUMAN_CHARGER:             uiMeleeSpell = SPELL_MELEE_CHARGER;             break;
                            case NPC_HUMAN_CLERIC:              uiMeleeSpell = SPELL_MELEE_CLERIC;              break;
                            case NPC_HUMAN_CONJURER:            uiMeleeSpell = SPELL_MELEE_CONJURER;            break;
                            case NPC_HUMAN_FOOTMAN:             uiMeleeSpell = SPELL_MELEE_FOOTMAN;             break;
                            case NPC_CONJURED_WATER_ELEMENTAL:  uiMeleeSpell = SPELL_MELEE_WATER_ELEM;          break;
                            case NPC_WARCHIEF_BLACKHAND:        uiMeleeSpell = SPELL_MELEE_WARCHIEF_BLACKHAND;  break;
                            case NPC_ORC_GRUNT:                 uiMeleeSpell = SPELL_MELEE_GRUNT;               break;
                            case NPC_ORC_NECROLYTE:             uiMeleeSpell = SPELL_MELEE_NECROLYTE;           break;
                            case NPC_ORC_WARLOCK:               uiMeleeSpell = SPELL_MELEE_WARLOCK;             break;
                            case NPC_ORC_WOLF:                  uiMeleeSpell = SPELL_MELEE_WOLF;                break;
                            case NPC_SUMMONED_DAEMON:           uiMeleeSpell = SPELL_MELEE_DAEMON;              break;
                        }
                        target->CastSpell(target, uiMeleeSpell, true);
                        break;
                    }
                    case SPELL_FACE_SQUARE: // square facing
                    {
                        if (caster->GetTypeId() == TYPEID_UNIT)
                            target->SetFacingToObject(caster);
                        break;
                    }
                    default:
                        break;
                }
            }

            void Register() OVERRIDE
            {
                OnEffectHitTarget += SpellEffectFn(spell_chess_event_generic_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const OVERRIDE
        {
            return new spell_chess_event_generic_SpellScript();
        }
};

void AddSC_chess_event()
{
    new npc_echo_of_medivh();
    new npc_king_llane();
    new npc_warchief_blackhand();
    new npc_human_conjurer();
    new npc_orc_warlock();
    new npc_human_footman();
    new npc_orc_grunt();
    new npc_conjured_water_elemental();
    new npc_summoned_daemon();
    new npc_human_charger();
    new npc_orc_wolf();
    new npc_human_cleric();
    new npc_orc_necrolyte();
    new spell_chess_event_generic();
}
