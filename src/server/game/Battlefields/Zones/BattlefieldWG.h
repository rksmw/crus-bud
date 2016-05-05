/*
 * Copyright (C) 2008-2010 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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

#ifndef BATTLEFIELD_WG_
#define BATTLEFIELD_WG_

#include "ObjectAccessor.h"
#include "SharedDefines.h"
#include "WorldPacket.h"
#include "World.h"
#include "Group.h"
#include "Battlefield.h"

#define BATTLEFIELD_WG_ZONEID   4197
#define BATTLEFIELD_WG_MAPID    571

const uint32 WG_FACTION[3] = {1733, 1735, 35};

enum WGMaxs
{
    WG_TEAM_MAX                 = 2,
    WG_TOWER_MAX                = 3,
    WG_WORKSHOP_MAX             = 4,
    WG_GRAVEYARD_MAX            = 7,
    WG_FORTRESS_WALL_MAX        = 25,
    WG_FORTRESS_TOWER_MAX       = 4,
    WG_FORTRESS_CANNONS_MAX     = 5,
    WG_FORTRESS_WORKSHOP_MAX    = 2,
    WG_FORTRESS_TELE_MAX        = 2,
    WG_CLOCK_MAX                = 2,
    WG_UI_MISC_MAX              = 2,
    WG_UI_SLIDER_MAX            = 3
};

enum WGPhaseMasks
{
    WG_PHASEMASK_ALL                        = 1,
    WG_PHASEMASK_INVISIBLE                  = 2,
    WG_PHASEMASK_HORDE_CONTROL_FACTORY      = 16,
    WG_PHASEMASK_ALLIANCE_CONTROL_FACTORY   = 32,
    WG_PHASEMASK_HORDE_CONTROL              = 64,
    WG_PHASEMASK_ALLIANCE_CONTROL           = 128
};

enum WGCreatures
{
    WG_NPC_TRIGGER                      = 23472,
    WG_NPC_ROBOTIC_ARMS                 = 27852,

    // Horde
    WG_NPC_VIERON_BLAZEFEATHER          = 31102,
    WG_NPC_STONE_GUARD_MUKAR            = 32296,
    WG_NPC_HOODOO_MASTER_FUJIN          = 31101,
    WG_NPC_COMMANDER_DARDOSH            = 31091,
    WG_NPC_TACTICAL_OFFICER_KILRATH     = 31151,
    WG_NPC_SIEGESMITH_STRONGHOOF        = 31106,
    WG_NPC_PRIMALIST_MULFORT            = 31053,
    WG_NPC_LIEUTENANT_MURP              = 31107,
    WG_NPC_GUARD_H                      = 30739,
    WG_NPC_GOBLIN_MECHANIC              = 30400,
    WG_NPC_SIEGE_ENGINE_H               = 32627,
    WG_NPC_SIEGE_TURRET_H               = 32629,
    WG_NPC_TAUNKA_SPIRIT_GUIDE          = 31841,

    // Alliance
    WG_NPC_BOWYER_RANDOLPH              = 31052,
    WG_NPC_KNIGHT_DAMERON               = 32294,
    WG_NPC_SORCERESS_KAYLANA            = 31051,
    WG_NPC_COMMANDER_ZANNETH            = 31036,
    WG_NPC_TACTICAL_OFFICER_AHBRAMIS    = 31153,
    WG_NPC_SIEGE_MASTER_STOUTHANDLE     = 31108,
    WG_NPC_ANCHORITE_TESSA              = 31054,
    WG_NPC_SENIOR_DEMOLITIONIST_LEGOSO  = 31109,
    WG_NPC_GUARD_A                      = 30740,
    WG_NPC_GNOMISH_ENGINEER             = 30499,
    WG_NPC_SIEGE_ENGINE_A               = 28312,
    WG_NPC_SIEGE_TURRET_A               = 28319,
    WG_NPC_DWARVEN_SPIRIT_GUIDE         = 31842,

    WG_NPC_CATAPULT                     = 27881,
    WG_NPC_DEMOLISHER                   = 28094,
    WG_NPC_CANNON                       = 28366,

    // Mobs
    WG_NPC_WATER_REVENANT               = 30877,
    WG_NPC_SHADOW_REVENANT              = 30872,
    WG_NPC_TEMPEST_REVENANT             = 30875,
    WG_NPC_FLAME_REVENANT               = 30873,
    WG_NPC_GLACIAL_SPIRIT               = 30846,
    WG_NPC_LIVING_LASHER                = 30845,
    WG_NPC_MATURE_LASHER                = 34300,
    WG_NPC_RAGING_FLAME                 = 30847,
    WG_NPC_WHISPERING_WIND              = 30848,
    WG_NPC_WANDERING_SHADOW             = 30842,
    WG_NPC_EARTHBOUND_REVENANT          = 30876,
    WG_NPC_CHILLED_EARTH_ELEMENTAL      = 30849
};

const uint32 WG_NPC_VEHICLES[4] = {WG_NPC_SIEGE_ENGINE_H, WG_NPC_SIEGE_ENGINE_A, WG_NPC_DEMOLISHER, WG_NPC_CATAPULT};

enum WGGameObjects
{
    WG_GO_BANNER_HORDE                  = 192488,
    WG_GO_BANNER_ALLIANCE               = 192501,
    WG_GO_TITAN_RELIC                   = 192829,
    WG_GO_DOOR_COLLISION                = 194162,
    WG_GO_DOOR_COLLISION2               = 194323,

    // Others
    WG_GO_ARCHAVONS_LOG         = 194356,
    WG_GO_FROST_LOTUS           = 190176,
    WG_GO_FROZEN_HERB           = 190173,
    WG_GO_ICETHORN              = 190172,
    WG_GO_LICHBLOOM             = 190171,
    WG_GO_RICH_SARONITE_DEPOSIT = 189981,
    WG_GO_SARONITE_DEPOSIT      = 189980,
    WG_GO_TITANIUM_VEIN         = 191133
};

const uint32 WG_GO_TOWER[WG_TOWER_MAX]                          = {190356, 190357, 190358};         // W, S, E
const uint32 WG_GO_WORKSHOP[WG_WORKSHOP_MAX]                    = {192030, 192031, 192032, 192033}; // NW, NE, SW, SE
const uint32 WG_GO_WORKSHOP_BANNER[WG_WORKSHOP_MAX]             = {190487, 190475, 194962, 194959}; // NW, NE, SW, SE
const uint32 WG_GO_FORTRESS_WALL[WG_FORTRESS_WALL_MAX]          = {190219, 190220, 190369, 190370, 190371, 190372, 190374, 190375, 190376, 191795, 191796, 191797, 191798, 191799, 191800, 191801, 191802, 191803, 191804, 191805, 191806, 191807, 191808, 191809, 191810};
const uint32 WG_GO_FORTRESS_TOWER[WG_FORTRESS_TOWER_MAX]        = {190221, 190378, 190373, 190377}; // NW, NE, SW, SE
const uint32 WG_GO_FORTRESS_WORKSHOP[WG_FORTRESS_WORKSHOP_MAX]  = {192028, 192029};                 // W, E
const uint32 WG_GO_FORTRESS_TELE[WG_FORTRESS_TELE_MAX]          = {190763, 192951};                 // PlayerTele, VehicleTele

const uint32 WG_GRAVEYARD[WG_GRAVEYARD_MAX] = {1330, 1329, 1334, 1333, 1331, 1332, 1328}; // NW, NE, SW, SE, H, A, N

const uint32 WG_WORLDSTATE_TOWER[WG_TOWER_MAX]                          = {3704, 3705, 3706};        // W, S, E
const uint32 WG_WORLDSTATE_WORKSHOP[WG_WORKSHOP_MAX]                    = {3700, 3701, 3702, 3703};  // NW, NE, SW, SE
const uint32 WG_WORLDSTATE_FORTRESS_WALL[WG_FORTRESS_WALL_MAX]          = {3749, 3750, 3753, 3758, 3754, 3757, 3755, 3763, 3756, 3764, 3772, 3765, 3771, 3762, 3766, 3770, 3751, 3752, 3767, 3768, 3769, 3759, 3760, 3761, 3773};
const uint32 WG_WORLDSTATE_FORTRESS_TOWER[WG_FORTRESS_TOWER_MAX]        = {3711, 3712, 3713, 3714};  // NW, NE, SW, SE
const uint32 WG_WORLDSTATE_FORTRESS_WORKSHOP[WG_FORTRESS_WORKSHOP_MAX]  = {3698, 3699};              // W, E

const uint32 WG_WORLDSTATE_UI_STATE[WG_UI_MISC_MAX]                     = {3710, 3801}; // bool InBattle, NotInBattle;
const uint32 WG_WORLDSTATE_UI_TIMER[WG_UI_MISC_MAX]                     = {3781, 4354}; // time_t InBattle, NotInBattle;
const uint32 WG_WORLDSTATE_UI_FACTION_CONTROL_STATE[WG_TEAM_MAX]        = {3803, 3802}; // bool AllianceControl, HordeControl;
const uint32 WG_WORLDSTATE_UI_VEHICLE_MAX[WG_TEAM_MAX]                  = {3681, 3491}; // uint8 MaxVehicles
const uint32 WG_WORLDSTATE_UI_VEHICLE_COUNT[WG_TEAM_MAX]                = {3680, 3490}; // uint8 VehicleCount
const uint32 WG_WORLDSTATE_UI_SLIDER[WG_UI_SLIDER_MAX]                  = {3501, 3502, 3508};

enum WGLangs
{
    WG_LANG_TO_BEGIN            = 12050,
    WG_LANG_TO_BEGUN            = 12051,
    WG_LANG_FORTRES             = 12052,
    WG_LANG_FIRSTRANK           = 12066,
    WG_LANG_SECONDRANK          = 12067,
    WG_LANG_ATTACK              = 12068,
    WG_LANG_TAKEN               = 12069,
    WG_LANG_LOST                = 12070,
    WG_LANG_DAMAGE              = 12071,
    WG_LANG_DESTROY             = 12072,
    WG_LANG_DEFENDED            = 12073
};

const uint16 WG_LANG_TEAM[WG_TEAM_MAX]                      = {12064, 12065};               // A, H
const uint16 WG_LANG_TOWER[WG_TOWER_MAX]                    = {12057, 12058, 12059};        // W, S, E
const uint16 WG_LANG_WORKSHOP[WG_WORKSHOP_MAX]              = {12053, 12054, 12055, 12056}; // NW, NE, SW, SE
const uint16 WG_LANG_FORTRESS_TOWER[WG_FORTRESS_TOWER_MAX]  = {12060, 12061, 12062, 12063}; // NW, NE, SW, SE

enum WGSpells
{
    // Ranks
    WG_SPELL_RECRUIT                               = 37795,
    WG_SPELL_CORPORAL                              = 33280,
    WG_SPELL_LIEUTENANT                            = 55629,

    // Tenacity
    WG_SPELL_TENACITY                              = 58549,
    WG_SPELL_TENACITY_VEHICLE                      = 59911,

    // Honor extra por Tenacity
    WG_SPELL_GREAT_HONOR                           = 58555, // Si el enemigo tiene Tenacity (5)
    WG_SPELL_GREATER_HONOR                         = 58556, // Si el enemigo tiene Tenacity (10)
    WG_SPELL_GREATEST_HONOR                        = 58557, // Si el enemigo tiene Tenacity (20)

    WG_SPELL_TOWER_CONTROL                         = 62064,

    WG_SPELL_SPIRITUAL_IMMUNITY                    = 58729,

    // Vehicle
    WG_SPELL_RIDE_VEHICLE                          = 60968,
    WG_SPELL_VEHICLE_TELEPORT                      = 49759,
    WG_SPELL_ALLIANCE_FLAG                         = 14268,
    WG_SPELL_HORDE_FLAG                            = 14267,

    // Reward Spells
    WG_SPELL_VICTORY_REWARD                        = 56902,
    WG_SPELL_DEFEAT_REWARD                         = 58494,
    WG_SPELL_DAMAGED_TOWER                         = 59135,
    WG_SPELL_DESTROYED_TOWER                       = 59136,
    WG_SPELL_DAMAGED_BUILDING                      = 59201,
    WG_SPELL_INTACT_BUILDING                       = 59203,

    WG_SPELL_TELEPORT_BRIDGE                       = 59096,
    WG_SPELL_TELEPORT_FORTRESS                     = 60035,

    WG_SPELL_TELEPORT_DALARAN                      = 53360,
    WG_SPELL_VICTORY_AURA                          = 60044,

    // Otros
    WG_SPELL_ESSENCE_OF_WINTERGRASP                = 58045,
    WG_SPELL_WINTERGRASP_RESTRICTED_FLIGHT_AREA    = 58730,
    WG_SPELL_WINTERGRASP_WATER                     = 36444,
    WG_SPELL_PARACHUTE                             = 61243,

    // Phase Shift Spells
    WG_SPELL_HORDE_CONTROLS_FACTORY_PHASE_SHIFT    = 56618,    // ADDS PHASE 16
    WG_SPELL_ALLIANCE_CONTROLS_FACTORY_PHASE_SHIFT = 56617,    // ADDS PHASE 32

    WG_SPELL_HORDE_CONTROL_PHASE_SHIFT             = 55773,    // ADDS PHASE 64
    WG_SPELL_ALLIANCE_CONTROL_PHASE_SHIFT          = 55774,    // ADDS PHASE 128

    // Forms
    WG_SPELL_SWIFT_FLIGHT_FORM                     = 40120,
    WG_SPELL_FLIGHT_FORM                           = 33943,
};

enum WGItems
{
    WG_ITEM_MARK_OF_HONOR                       = 43589
};

enum WGAchievemnts
{
    WG_ACHIEVEMENT_WINTERGRASP_VICTORY          = 1717, // Automatic
    WG_ACHIEVEMENT_WINTERGRASP_VETERAN          = 1718, // Automatic
    WG_ACHIEVEMENT_VEHICULAR_GNOMESLAUGHTER     = 1723, // Script
    WG_ACHIEVEMENT_LEANING_TOWER                = 1727, // Script
    WG_ACHIEVEMENT_DIDNT_STAND_A_CHANCE         = 1751, // Script
    WG_ACHIEVEMENT_WITHIN_OUR_GRASP             = 1755, // Script
    WG_ACHIEVEMENT_WINTERGRASP_RANGER           = 2199, // Automatic
    WG_ACHIEVEMENT_DESTRUCTION_DERBY_A          = 1737, // Script
    WG_ACHIEVEMENT_DESTRUCTION_DERBY_H          = 2476, // Script
    WG_ACHIEVEMENT_MASTER_OF_WINTERGRASP_A      = 1752, // Automatic
    WG_ACHIEVEMENT_MASTER_OF_WINTERGRASP_H      = 2776, // Automatic

    WG_ACHIEVEMENT_STONE_KEEPER_50              = 2085, // Automatic
    WG_ACHIEVEMENT_STONE_KEEPER_100             = 2086, // Automatic
    WG_ACHIEVEMENT_STONE_KEEPER_250             = 2087, // Automatic
    WG_ACHIEVEMENT_STONE_KEEPER_500             = 2088, // Automatic
    WG_ACHIEVEMENT_STONE_KEEPER_1000            = 2089  // Automatic
};

enum WGTexts
{
    WG_TEXT_GY_NE              = -1850501,
    WG_TEXT_GY_NW              = -1850502,
    WG_TEXT_GY_SE              = -1850504,
    WG_TEXT_GY_SW              = -1850503,
    WG_TEXT_GY_KEEP            = -1850500,
    WG_TEXT_GY_HORDE           = -1850505,
    WG_TEXT_GY_ALLIANCE        = -1850506
};

const uint32 WG_QUEST[WG_TEAM_MAX][6] =
{
    {13186, 13181, 13222, 13538, 13177, 13179},
    {13185, 13183, 13223, 13539, 13178, 13180}
};

enum WGWorkshop
{
    WG_WORKSHOP_NW = 0,
    WG_WORKSHOP_NE = 1,
    WG_WORKSHOP_SW = 2,
    WG_WORKSHOP_SE = 3
};

class BattlefieldWG;
class BfCapturePointWG;

class BfCapturePointWG : public BfCapturePoint
{
    friend class BattlefieldWG;

    public:
        BfCapturePointWG(Battlefield* bf, GameObject* capturePoint, TeamId team);

        void FillInitialWorldStates(WorldPacket & /*data*/) {}

        bool OnPlayerEnter(Player* player);

        void ChangeState();

        void UpdateState();
        void LinkGraveYard();

        void ClearWorkshopGUID();
        uint64 GetWorkshopGUID();

    private:
        BattlefieldWG* wg;

        WGWorkshop id;
        uint64 workshopGUID;
};

class BattlefieldWG : public Battlefield
{
    friend class BfCapturePointWG;

    public:
        bool SetupBattlefield();

        void LoadGrids();

        void FillInitialWorldStates(WorldPacket & data);
        void OnSendUpdateWorldState(uint32 field, uint32 value);

        void OnCreatureCreate(Creature* creature);
        void OnCreatureRemove(Creature* creature);
        void OnGameObjectCreate(GameObject* go);

        void OnPlayerJoinBattle(Player* player);
        void OnPlayerEnterZone(Player* player);
        void OnPlayerLeaveBattle(Player* player);
        void OnPlayerLeaveZone(Player* player);

        void InstallPlayer(Player* player);
        void UninstallPlayer(Player* player, bool dismount = false);

        void OnSetBattlefieldState(BattlefieldStates state);

        void OnUpdate(uint32 diff);

        void PrepareZoneForBattle();
        void UpdateCannons();
        void UpdateMobs();
        void UpdateTeleports();
        void UpdateTitanRelic();
        void UpdateFortressGraveyard();

        void RewardPlayers(bool captured);

        void OnPlayerKill(Player* killer, Unit* victim);
        void PromotePlayerArea(Player* killer);
        void PromotePlayer(Player* killer);

        void EventPlayerDamagedGO(Player* player, GameObject* go, uint32 eventType);
        void EventPlayerUsedGO(Player* player, GameObject* go);

        void OnDestroyedFortressTower(uint8 towerId);
        void OnDestroyedTower(uint8 towerId);

        void OnSetBattleTime(bool value);
        void OnSetTimer(uint32 timer);
        void OnSetDefenderTeam(TeamId team);

        void AddVehicle(Creature* vehicle);
        void RemoveVehicle(Creature* vehicle);
        void UpdateMaxVehicle(TeamId team, bool end = false);
        uint8 GetVehicleCount(TeamId team, bool max) { return max ? maxVehicles[team] : vehicles[team].size(); }
        void UpdateTenacity();

        void OnSetVisible(Creature* creature, bool visible);

    private:
        uint64 titanRelicGUID;
        uint64 mainDoorGUID;
        uint64 doorCollisionGUID;

        GuidTimerMap vehicleQueue;
        GuidSet mobs;
        GuidSet vehicles[WG_TEAM_MAX];
        GuidSet cannons[WG_TOWER_MAX];
        GuidSet fortressCannons[WG_FORTRESS_CANNONS_MAX];

        GuidSet fortressTeleports[WG_FORTRESS_TELE_MAX];

        GameObjectBuildingMap towers;
        GameObjectBuildingMap workshops;

        GameObjectBuildingMap fortressWalls;
        GameObjectBuildingMap fortressTowers;
        GameObjectBuildingMap fortressWorkshops;

        uint32 maxVehicles[BF_TEAMS_COUNT];

        AreaPOISet areaPOIs;

        std::stringstream guidsGameObjects;
        std::stringstream guidsCreatures;
};

#endif
