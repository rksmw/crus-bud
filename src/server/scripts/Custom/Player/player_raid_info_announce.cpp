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


#include "Config.h"
#include "Group.h"
#include "Guild.h"
#include "GuildMgr.h"
#include "ScriptMgr.h"
#include "Chat.h"
#include "GroupMgr.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Map.h"
#include "Player.h"
#include "MapManager.h"
#include "MapInstanced.h"
#include "InstanceSaveMgr.h"
#include "InstanceScript.h"

#define DATA_SEPARATOR ":"
#define PEOPLE_SEPARATOR " "

enum RaidInfoBossId
{
    TRIAL_OF_THE_CRUSADER_ICEHOWL_10N   = 34797,
    TRIAL_OF_THE_CRUSADER_ICEHOWL_25N   = 35447,
    TRIAL_OF_THE_CRUSADER_ICEHOWL_10H   = 35448,
    TRIAL_OF_THE_CRUSADER_ICEHOWL_25H   = 35449,
    TRIAL_OF_THE_CRUSADER_JARAXXUS_10N  = 34780,
    TRIAL_OF_THE_CRUSADER_JARAXXUS_25N  = 35216,
    TRIAL_OF_THE_CRUSADER_JARAXXUS_10H  = 35268,
    TRIAL_OF_THE_CRUSADER_JARAXXUS_25H  = 35269,
    TRIAL_OF_THE_CRUSADER_FJOLA_10N     = 34497,
    TRIAL_OF_THE_CRUSADER_FJOLA_25N     = 35350,
    TRIAL_OF_THE_CRUSADER_FJOLA_10H     = 35351,
    TRIAL_OF_THE_CRUSADER_FJOLA_25H     = 35352,
    TRIAL_OF_THE_CRUSADER_EYDIS_10N     = 34496,
    TRIAL_OF_THE_CRUSADER_EYDIS_25N     = 35347,
    TRIAL_OF_THE_CRUSADER_EYDIS_10H     = 35348,
    TRIAL_OF_THE_CRUSADER_EYDIS_25H     = 35349,
    TRIAL_OF_THE_CRUSADER_ANUBARAK_10N  = 34564,
    TRIAL_OF_THE_CRUSADER_ANUBARAK_25N  = 34566,
    TRIAL_OF_THE_CRUSADER_ANUBARAK_10H  = 35615,
    TRIAL_OF_THE_CRUSADER_ANUBARAK_25H  = 35616,
    ICC_MARROWGAR_10N                   = 36612,
    ICC_MARROWGAR_25N                   = 37957,
    ICC_MARROWGAR_10H                   = 37958,
    ICC_MARROWGAR_25H                   = 37959,
    ICC_DEATHWHISPER_10N                = 36855,
    ICC_DEATHWHISPER_25N                = 38106,
    ICC_DEATHWHISPER_10H                = 38296,
    ICC_DEATHWHISPER_25H                = 38297,
    ICC_GUNSHIP_SKYBREAKER_10N          = 37540,
    ICC_GUNSHIP_SKYBREAKER_25N          = 38128,
    ICC_GUNSHIP_SKYBREAKER_10H          = 38699,
    ICC_GUNSHIP_SKYBREAKER_25H          = 38700,
    ICC_GUNSHIP_ORGRIMS_HAMMER_10N      = 37215,
    ICC_GUNSHIP_ORGRIMS_HAMMER_25N      = 38129,
    ICC_GUNSHIP_ORGRIMS_HAMMER_10H      = 38701,
    ICC_GUNSHIP_ORGRIMS_HAMMER_25H      = 38702,
    ICC_SAURFANG_10N                    = 37813,
    ICC_SAURFANG_25N                    = 38402,
    ICC_SAURFANG_10H                    = 38582,
    ICC_SAURFANG_25H                    = 38583,
    ICC_FESTERGUT_10N                   = 36626,
    ICC_FESTERGUT_25N                   = 37504,
    ICC_FESTERGUT_10H                   = 37505,
    ICC_FESTERGUT_25H                   = 37506,
    ICC_ROTFACE_10N                     = 36627,
    ICC_ROTFACE_25N                     = 38390,
    ICC_ROTFACE_10H                     = 38549,
    ICC_ROTFACE_25H                     = 38550,
    ICC_PUTRICIDE_10N                   = 36678,
    ICC_PUTRICIDE_25N                   = 38431,
    ICC_PUTRICIDE_10H                   = 38585,
    ICC_PUTRICIDE_25H                   = 38586,
    ICC_VALANAR_10N                     = 37970,
    ICC_VALANAR_25N                     = 38401,
    ICC_VALANAR_10H                     = 38784,
    ICC_VALANAR_25H                     = 38785,
    ICC_KELESETH_10N                    = 37972,
    ICC_KELESETH_25N                    = 38399,
    ICC_KELESETH_10H                    = 38769,
    ICC_KELESETH_25H                    = 38770,
    ICC_TALDARAM_10N                    = 37973,
    ICC_TALDARAM_25N                    = 38400,
    ICC_TALDARAM_10H                    = 38771,
    ICC_TALDARAM_25H                    = 38772,
    ICC_LANATHEL_10N                    = 37955,
    ICC_LANATHEL_25N                    = 38434,
    ICC_LANATHEL_10H                    = 38435,
    ICC_LANATHEL_25H                    = 38436,
    ICC_VALITHRIA_10N                   = 36789,
    ICC_VALITHRIA_25N                   = 38174,
    ICC_SINDRAGOSA_10N                  = 36853,
    ICC_SINDRAGOSA_25N                  = 38265,
    ICC_SINDRAGOSA_10H                  = 38266,
    ICC_SINDRAGOSA_25H                  = 38267,
    ICC_LICHKING_10N                    = 36597,
    ICC_LICHKING_25N                    = 39166,
    ICC_LICHKING_10H                    = 39167,
    ICC_LICHKING_25H                    = 39168,
    NAXXRAMAS_MAEXXNA_10N               = 15952,
    NAXXRAMAS_MAEXXNA_25N               = 29278,
    NAXXRAMAS_LOATHEB_10N               = 16011,
    NAXXRAMAS_LOATHEB_25N               = 29718,
    NAXXRAMAS_HORSEMEN_THANE_10N        = 16064,
    NAXXRAMAS_HORSEMEN_THANE_25N        = 30603,
    NAXXRAMAS_HORSEMEN_BLAUMEUX_10N     = 16065,
    NAXXRAMAS_HORSEMEN_BLAUMEUX_25N     = 30601,
    NAXXRAMAS_HORSEMEN_RIVENDARE_10N    = 30549,
    NAXXRAMAS_HORSEMEN_RIVENDARE_25N    = 30600,
    NAXXRAMAS_HORSEMEN_ZELIEK_10N       = 16063,
    NAXXRAMAS_HORSEMEN_ZELIEK_25N       = 30602,
    NAXXRAMAS_THADDIUS_10N              = 15928,
    NAXXRAMAS_THADDIUS_25N              = 29448,
    NAXXRAMAS_KELTHUZAD_10N             = 15990,
    NAXXRAMAS_KELTHUZAD_25N             = 30061,
    ONYXIAS_LAIR_ONYXIA_10N             = 10184,
    ONYXIAS_LAIR_ONYXIA_25N             = 36538,
    EYE_OF_ETERNITY_MALYGOS             = 28859,
    ULDUAR_FREYA_10N                    = 32906,
    ULDUAR_FREYA_25N                    = 33360,
    ULDUAR_HODIR_10N                    = 32845,
    ULDUAR_HODIR_25N                    = 32846,
    ULDUAR_MIMIRON                      = 33350,
    ULDUAR_THORIM_10N                   = 32865,
    ULDUAR_THORIM_25N                   = 33147,
    ULDUAR_YOGGSARON_10N                = 33288,
    ULDUAR_YOGGSARON_25N                = 33955,
    ULDUAR_ALGALON_10N                  = 32871,
    ULDUAR_ALGALON_25N                  = 33070,
    VAULT_OF_ARCHAVON_ARCHAVON_10N      = 31125,
    VAULT_OF_ARCHAVON_ARCHAVON_25N      = 31722,
    VAULT_OF_ARCHAVON_EMALON_10N        = 33993,
    VAULT_OF_ARCHAVON_EMALON_25N        = 33994,
    VAULT_OF_ARCHAVON_KORALON_10N       = 35013,
    VAULT_OF_ARCHAVON_KORALON_25N       = 35360,
    VAULT_OF_ARCHAVON_TORAVON_10N       = 38433,
    VAULT_OF_ARCHAVON_TORAVON_25N       = 38462,
    OBSIDIAN_SANCTUM_SARTHARION_10N     = 28860,
    OBSIDIAN_SANCTUM_SARTHARION_25N     = 31311,
    RUBY_SANCTUM_HALION_10N             = 39863,
    RUBY_SANCTUM_HALION_25N             = 39864,
    RUBY_SANCTUM_HALION_10H             = 39944,
    RUBY_SANCTUM_HALION_25H             = 39945,
};

bool    RaidInfoEnable                  = false;
bool    RaidInfoMode                    = false;
bool    RaidInfoLog                     = false;
bool    RaidInfoAnnounce                = false;

int32   RaidInfoNormalTextStandard      = 10100;
int32   RaidInfoHeroicTextStandard      = 10101;
int32   RaidInfoNormalTextSpecialToc    = 10102;
int32   RaidInfoHeroicTextSpecialToc    = 10103;
int32   RaidInfoNormalTextSpecialIcc    = 10104;
int32   RaidInfoHeroicTextSpecialIcc    = 10105;
int32   RaidInfoNormalTextGunshipIcc    = 10106;
int32   RaidInfoHeroicTextGunshipIcc    = 10107;
int32   RaidInfoNormalTextValithriaIcc  = 10108;
int32   RaidInfoHeroicTextValithriaIcc  = 10109;
int32   RaidInfoDifficulty              = 0;

class RaidInfo_WorldScript : public WorldScript
{
    public:
        RaidInfo_WorldScript() : WorldScript("RaidInfo_WorldScript") { }

    void OnConfigLoad(bool /*reload*/)
    {
        RaidInfoEnable      = sConfigMgr->GetBoolDefault("RaidInfo.Enable", false);

        if (!RaidInfoEnable)
            return;

        RaidInfoLog         = sConfigMgr->GetBoolDefault("RaidInfo.Log", false);
        RaidInfoAnnounce    = sConfigMgr->GetBoolDefault("RaidInfo.Announce", false);
        RaidInfoDifficulty  = sConfigMgr->GetIntDefault("RaidInfo.Difficulty", 0);
    }
};

bool isElegible(Creature* creature)
{
    switch (creature->GetCreatureTemplate()->Entry)
    {
        case TRIAL_OF_THE_CRUSADER_FJOLA_10N:
        case ICC_VALANAR_10N:
        case TRIAL_OF_THE_CRUSADER_ICEHOWL_10N:
        case TRIAL_OF_THE_CRUSADER_JARAXXUS_10N:
        case TRIAL_OF_THE_CRUSADER_ANUBARAK_10N:
        case ICC_MARROWGAR_10N:
        case ICC_DEATHWHISPER_10N:
        case ICC_GUNSHIP_SKYBREAKER_10N:
        case ICC_GUNSHIP_ORGRIMS_HAMMER_10N:
        case ICC_SAURFANG_10N:
        case ICC_FESTERGUT_10N:
        case ICC_ROTFACE_10N:
        case ICC_PUTRICIDE_10N:
        case ICC_LANATHEL_10N:
        case ICC_VALITHRIA_10N:
        case ICC_SINDRAGOSA_10N:
        case ICC_LICHKING_10N:
        case NAXXRAMAS_MAEXXNA_10N:
        case NAXXRAMAS_LOATHEB_10N:
        case NAXXRAMAS_HORSEMEN_THANE_10N:
        case NAXXRAMAS_HORSEMEN_BLAUMEUX_10N:
        case NAXXRAMAS_HORSEMEN_RIVENDARE_10N:
        case NAXXRAMAS_HORSEMEN_ZELIEK_10N:
        case NAXXRAMAS_THADDIUS_10N:
        case NAXXRAMAS_KELTHUZAD_10N:
        case ONYXIAS_LAIR_ONYXIA_10N:
        case ULDUAR_FREYA_10N:
        case ULDUAR_HODIR_10N:
        case ULDUAR_THORIM_10N:
        case ULDUAR_YOGGSARON_10N:
        case ULDUAR_ALGALON_10N:
        case VAULT_OF_ARCHAVON_ARCHAVON_10N:
        case VAULT_OF_ARCHAVON_EMALON_10N:
        case VAULT_OF_ARCHAVON_KORALON_10N:
        case VAULT_OF_ARCHAVON_TORAVON_10N:
        case OBSIDIAN_SANCTUM_SARTHARION_10N:
        case RUBY_SANCTUM_HALION_10N:
        case TRIAL_OF_THE_CRUSADER_FJOLA_25N:
        case ICC_VALANAR_25N:
        case TRIAL_OF_THE_CRUSADER_ICEHOWL_25N:
        case TRIAL_OF_THE_CRUSADER_JARAXXUS_25N:
        case TRIAL_OF_THE_CRUSADER_ANUBARAK_25N:
        case ICC_MARROWGAR_25N:
        case ICC_DEATHWHISPER_25N:
        case ICC_GUNSHIP_SKYBREAKER_25N:
        case ICC_GUNSHIP_ORGRIMS_HAMMER_25N:
        case ICC_SAURFANG_25N:
        case ICC_FESTERGUT_25N:
        case ICC_ROTFACE_25N:
        case ICC_PUTRICIDE_25N:
        case ICC_LANATHEL_25N:
        case ICC_VALITHRIA_25N:
        case ICC_SINDRAGOSA_25N:
        case ICC_LICHKING_25N:
        case NAXXRAMAS_MAEXXNA_25N:
        case NAXXRAMAS_LOATHEB_25N:
        case NAXXRAMAS_HORSEMEN_THANE_25N:
        case NAXXRAMAS_HORSEMEN_BLAUMEUX_25N:
        case NAXXRAMAS_HORSEMEN_RIVENDARE_25N:
        case NAXXRAMAS_HORSEMEN_ZELIEK_25N:
        case NAXXRAMAS_THADDIUS_25N:
        case NAXXRAMAS_KELTHUZAD_25N:
        case ONYXIAS_LAIR_ONYXIA_25N:
        case EYE_OF_ETERNITY_MALYGOS:
        case ULDUAR_FREYA_25N:
        case ULDUAR_HODIR_25N:
        case ULDUAR_MIMIRON:
        case ULDUAR_THORIM_25N:
        case ULDUAR_YOGGSARON_25N:
        case ULDUAR_ALGALON_25N:
        case VAULT_OF_ARCHAVON_ARCHAVON_25N:
        case VAULT_OF_ARCHAVON_EMALON_25N:
        case VAULT_OF_ARCHAVON_KORALON_25N:
        case VAULT_OF_ARCHAVON_TORAVON_25N:
        case OBSIDIAN_SANCTUM_SARTHARION_25N:
        case RUBY_SANCTUM_HALION_25N:
        case TRIAL_OF_THE_CRUSADER_FJOLA_10H:
        case ICC_VALANAR_10H:
        case TRIAL_OF_THE_CRUSADER_ICEHOWL_10H:
        case TRIAL_OF_THE_CRUSADER_JARAXXUS_10H:
        case TRIAL_OF_THE_CRUSADER_ANUBARAK_10H:
        case ICC_MARROWGAR_10H:
        case ICC_DEATHWHISPER_10H:
        case ICC_GUNSHIP_SKYBREAKER_10H:
        case ICC_GUNSHIP_ORGRIMS_HAMMER_10H:
        case ICC_SAURFANG_10H:
        case ICC_FESTERGUT_10H:
        case ICC_ROTFACE_10H:
        case ICC_PUTRICIDE_10H:
        case ICC_LANATHEL_10H:
        case ICC_SINDRAGOSA_10H:
        case ICC_LICHKING_10H:
        case RUBY_SANCTUM_HALION_10H:
        case TRIAL_OF_THE_CRUSADER_FJOLA_25H:
        case ICC_VALANAR_25H:
        case TRIAL_OF_THE_CRUSADER_ICEHOWL_25H:
        case TRIAL_OF_THE_CRUSADER_JARAXXUS_25H:
        case TRIAL_OF_THE_CRUSADER_ANUBARAK_25H:
        case ICC_MARROWGAR_25H:
        case ICC_DEATHWHISPER_25H:
        case ICC_GUNSHIP_SKYBREAKER_25H:
        case ICC_GUNSHIP_ORGRIMS_HAMMER_25H:
        case ICC_SAURFANG_25H:
        case ICC_FESTERGUT_25H:
        case ICC_ROTFACE_25H:
        case ICC_PUTRICIDE_25H:
        case ICC_LANATHEL_25H:
        case ICC_SINDRAGOSA_25H:
        case ICC_LICHKING_25H:
        case RUBY_SANCTUM_HALION_25H:
            return true;
            break;
        default:
            return false;
            break;
    }
}

class RaidInfo_AllCreatureScript : public AllCreatureScript
{
    public:
        RaidInfo_AllCreatureScript() : AllCreatureScript("RaidInfo_AllCreatureScript") { }

    void AllCreatureJustDied(Creature* creature)
    {
        if (!RaidInfoEnable)
            return;

        uint32 entry = creature->GetEntry();
        if (!entry)
            return;

        if (!isElegible(creature))
            return;

        Player* recipient = creature->GetLootRecipient();
        if (!recipient)
            return;

        Map* map = creature->GetMap();
        if (!map)
            return;

        InstanceMap* iMap = map->ToInstanceMap();
        if (!map->Instanceable() || !iMap)
            return;

        InstanceScript* instance = ((InstanceMap*)iMap)->GetInstanceScript();
        if (!instance)
            return;

        uint8 spawnMode = 0;
        uint32 guildId = 0;
        bool IsGuildKill = true;
        uint32 playerCount = 0;
        std::string killTeam("");
        std::string guildName("None");
        std::string leaderName("Indefinite");
        uint32 raidId = 0;
        uint32 completedEncounters = 0;
        uint32 totalEncounters = 0;
        std::string bossName("Indefinite");
        std::string mapName("Indefinite");
        uint32 mapMaxPlayers = 0;

        spawnMode = map->GetSpawnMode();
        mapMaxPlayers = iMap ? iMap->GetMaxPlayers() : 40;
        bossName = creature->GetNameForLocaleIdx(sObjectMgr->GetDBCLocaleIndex());
        mapName = creature->GetMap()->GetMapName();
        completedEncounters = instance->GetCompletedEncountersReadable();
        totalEncounters = instance->GetTotalEncountersReadable();

        if (Group* groupInstance = recipient->GetGroup())
        {
            leaderName = groupInstance->GetLeaderName();
            for (GroupReference* itr = groupInstance->GetFirstMember(); itr != NULL; itr = itr->next())
            {
                Player* groupMember = itr->GetSource();
                if (!groupMember)
                    continue;

                if (!groupMember->IsInWorld())
                    continue;

                if (iMap->GetId() != groupMember->GetMapId())
                    continue;

                raidId = groupMember->GetInstanceId();
                uint32 playerGuildId = 0;
                playerGuildId = groupMember->GetGuildId();
                std::string playerGuildName("None");
                if (playerGuildId != 0)
                    playerGuildName = sGuildMgr->GetGuildById(playerGuildId)->GetName();

                playerCount++;
                if (RaidInfoLog)
                {
                    std::ostringstream PeopleData;
                    PeopleData << groupMember->GetGUIDLow() << DATA_SEPARATOR;
                    PeopleData << groupMember->GetName() << DATA_SEPARATOR;
                    PeopleData << playerGuildId << DATA_SEPARATOR;
                    PeopleData << playerGuildName << DATA_SEPARATOR;
                    killTeam += PeopleData.str();
                }

                if (IsGuildKill)
                {
                    if (guildId == 0)
                        guildId = playerGuildId;

                    IsGuildKill = guildId != 0 && playerGuildId == guildId;
                }
            }
        }
        else
        {
            playerCount = 1;
            guildId = recipient->GetGuildId();
            raidId = recipient->GetInstanceId();
            leaderName = recipient->GetName();
            if (guildId != 0)
                guildName = sGuildMgr->GetGuildById(guildId)->GetName();

            IsGuildKill = guildId != 0;
            if (RaidInfoLog)
            {
                std::ostringstream PeopleData;
                PeopleData << recipient->GetGUIDLow() << DATA_SEPARATOR;
                PeopleData << recipient->GetName() << DATA_SEPARATOR;
                PeopleData << guildId << DATA_SEPARATOR;
                PeopleData << guildName << DATA_SEPARATOR;
                killTeam += PeopleData.str();
            }
        }

        if (guildId == 0 && IsGuildKill)
            IsGuildKill = false;

        if (!IsGuildKill)
            guildId = 0;

        if (RaidInfoAnnounce && IsGuildKill && playerCount > 1)
        {
            int32 TextIdStandard = RaidInfoNormalTextStandard;
            int32 TextIdSpecialToc = RaidInfoNormalTextSpecialToc;
            int32 TextIdSpecialIcc = RaidInfoNormalTextSpecialIcc;
            int32 TextIdGunshipIcc = RaidInfoNormalTextGunshipIcc;
            int32 TextIdValithriaIcc = RaidInfoNormalTextValithriaIcc;
            if (spawnMode == RAID_DIFFICULTY_25MAN_HEROIC || spawnMode == RAID_DIFFICULTY_10MAN_HEROIC)
            {
                TextIdStandard = RaidInfoHeroicTextStandard;
                TextIdSpecialToc = RaidInfoHeroicTextSpecialToc;
                TextIdSpecialIcc = RaidInfoHeroicTextSpecialIcc;
                TextIdGunshipIcc = RaidInfoHeroicTextGunshipIcc;
                TextIdValithriaIcc = RaidInfoHeroicTextValithriaIcc;
            }

            if (guildId != 0)
                guildName = sGuildMgr->GetGuildById(guildId)->GetName();

            switch (creature->GetCreatureTemplate()->Entry)
            {
                case TRIAL_OF_THE_CRUSADER_FJOLA_10N:
                    if (RaidInfoDifficulty <= 0)
                        sWorld->SendWorldText(TextIdSpecialToc, mapName.c_str(), mapMaxPlayers, guildName.c_str(), playerCount, mapMaxPlayers, completedEncounters, totalEncounters, raidId);
                    break;
                case ICC_VALANAR_10N:
                    if (RaidInfoDifficulty <= 0)
                        sWorld->SendWorldText(TextIdSpecialIcc, mapName.c_str(), mapMaxPlayers, guildName.c_str(), playerCount, mapMaxPlayers, completedEncounters, totalEncounters, raidId);
                    break;
                case ICC_GUNSHIP_SKYBREAKER_10N:
                case ICC_GUNSHIP_ORGRIMS_HAMMER_10N:
                    if (RaidInfoDifficulty <= 0)
                        sWorld->SendWorldText(TextIdGunshipIcc, mapName.c_str(), mapMaxPlayers, guildName.c_str(), playerCount, mapMaxPlayers, completedEncounters, totalEncounters, raidId);
                    break;
                case TRIAL_OF_THE_CRUSADER_ICEHOWL_10N:
                case TRIAL_OF_THE_CRUSADER_JARAXXUS_10N:
                case TRIAL_OF_THE_CRUSADER_ANUBARAK_10N:
                case ICC_MARROWGAR_10N:
                case ICC_DEATHWHISPER_10N:
                case ICC_SAURFANG_10N:
                case ICC_FESTERGUT_10N:
                case ICC_ROTFACE_10N:
                case ICC_PUTRICIDE_10N:
                case ICC_LANATHEL_10N:
                case ICC_SINDRAGOSA_10N:
                case ICC_LICHKING_10N:
                case NAXXRAMAS_MAEXXNA_10N:
                case NAXXRAMAS_LOATHEB_10N:
                case NAXXRAMAS_HORSEMEN_THANE_10N:
                case NAXXRAMAS_HORSEMEN_BLAUMEUX_10N:
                case NAXXRAMAS_HORSEMEN_RIVENDARE_10N:
                case NAXXRAMAS_HORSEMEN_ZELIEK_10N:
                case NAXXRAMAS_THADDIUS_10N:
                case NAXXRAMAS_KELTHUZAD_10N:
                case ONYXIAS_LAIR_ONYXIA_10N:
                case ULDUAR_FREYA_10N:
                case ULDUAR_HODIR_10N:
                case ULDUAR_THORIM_10N:
                case ULDUAR_YOGGSARON_10N:
                case ULDUAR_ALGALON_10N:
                case VAULT_OF_ARCHAVON_ARCHAVON_10N:
                case VAULT_OF_ARCHAVON_EMALON_10N:
                case VAULT_OF_ARCHAVON_KORALON_10N:
                case VAULT_OF_ARCHAVON_TORAVON_10N:
                case OBSIDIAN_SANCTUM_SARTHARION_10N:
                case RUBY_SANCTUM_HALION_10N:
                    if (RaidInfoDifficulty <= 0)
                        sWorld->SendWorldText(TextIdStandard, mapName.c_str(), mapMaxPlayers, bossName.c_str(), guildName.c_str(), playerCount, mapMaxPlayers, completedEncounters, totalEncounters, raidId);
                    break;
                case TRIAL_OF_THE_CRUSADER_FJOLA_25N:
                    if (RaidInfoDifficulty <= 1)
                        sWorld->SendWorldText(TextIdSpecialToc, mapName.c_str(), mapMaxPlayers, guildName.c_str(), playerCount, mapMaxPlayers, completedEncounters, totalEncounters, raidId);
                    break;
                case ICC_VALANAR_25N:
                    if (RaidInfoDifficulty <= 1)
                        sWorld->SendWorldText(TextIdSpecialIcc, mapName.c_str(), mapMaxPlayers, guildName.c_str(), playerCount, mapMaxPlayers, completedEncounters, totalEncounters, raidId);
                    break;
                case ICC_GUNSHIP_SKYBREAKER_25N:
                case ICC_GUNSHIP_ORGRIMS_HAMMER_25N:
                    if (RaidInfoDifficulty <= 1)
                        sWorld->SendWorldText(TextIdGunshipIcc, mapName.c_str(), mapMaxPlayers, guildName.c_str(), playerCount, mapMaxPlayers, completedEncounters, totalEncounters, raidId);
                    break;
                case TRIAL_OF_THE_CRUSADER_ICEHOWL_25N:
                case TRIAL_OF_THE_CRUSADER_JARAXXUS_25N:
                case TRIAL_OF_THE_CRUSADER_ANUBARAK_25N:
                case ICC_MARROWGAR_25N:
                case ICC_DEATHWHISPER_25N:
                case ICC_SAURFANG_25N:
                case ICC_FESTERGUT_25N:
                case ICC_ROTFACE_25N:
                case ICC_PUTRICIDE_25N:
                case ICC_LANATHEL_25N:
                case ICC_SINDRAGOSA_25N:
                case ICC_LICHKING_25N:
                case NAXXRAMAS_MAEXXNA_25N:
                case NAXXRAMAS_LOATHEB_25N:
                case NAXXRAMAS_HORSEMEN_THANE_25N:
                case NAXXRAMAS_HORSEMEN_BLAUMEUX_25N:
                case NAXXRAMAS_HORSEMEN_RIVENDARE_25N:
                case NAXXRAMAS_HORSEMEN_ZELIEK_25N:
                case NAXXRAMAS_THADDIUS_25N:
                case NAXXRAMAS_KELTHUZAD_25N:
                case ONYXIAS_LAIR_ONYXIA_25N:
                case EYE_OF_ETERNITY_MALYGOS:
                case ULDUAR_FREYA_25N:
                case ULDUAR_HODIR_25N:
                case ULDUAR_MIMIRON:
                case ULDUAR_THORIM_25N:
                case ULDUAR_YOGGSARON_25N:
                case ULDUAR_ALGALON_25N:
                case VAULT_OF_ARCHAVON_ARCHAVON_25N:
                case VAULT_OF_ARCHAVON_EMALON_25N:
                case VAULT_OF_ARCHAVON_KORALON_25N:
                case VAULT_OF_ARCHAVON_TORAVON_25N:
                case OBSIDIAN_SANCTUM_SARTHARION_25N:
                case RUBY_SANCTUM_HALION_25N:
                    if (RaidInfoDifficulty <= 1)
                        sWorld->SendWorldText(TextIdStandard, mapName.c_str(), mapMaxPlayers, bossName.c_str(), guildName.c_str(), playerCount, mapMaxPlayers, completedEncounters, totalEncounters, raidId);
                    break;
                case TRIAL_OF_THE_CRUSADER_FJOLA_10H:
                    if (RaidInfoDifficulty <= 2)
                        sWorld->SendWorldText(TextIdSpecialToc, mapName.c_str(), mapMaxPlayers, guildName.c_str(), playerCount, mapMaxPlayers, completedEncounters, totalEncounters, raidId);
                    break;
                case ICC_VALANAR_10H:
                    if (RaidInfoDifficulty <= 2)
                        sWorld->SendWorldText(TextIdSpecialIcc, mapName.c_str(), mapMaxPlayers, guildName.c_str(), playerCount, mapMaxPlayers, completedEncounters, totalEncounters, raidId);
                    break;
                case ICC_GUNSHIP_SKYBREAKER_10H:
                case ICC_GUNSHIP_ORGRIMS_HAMMER_10H:
                    if (RaidInfoDifficulty <= 2)
                        sWorld->SendWorldText(TextIdGunshipIcc, mapName.c_str(), mapMaxPlayers, guildName.c_str(), playerCount, mapMaxPlayers, completedEncounters, totalEncounters, raidId);
                    break;
                case ICC_VALITHRIA_10N:
                    if (RaidInfoDifficulty <= 2)
                        sWorld->SendWorldText(TextIdValithriaIcc, mapName.c_str(), mapMaxPlayers, bossName.c_str(), guildName.c_str(), playerCount, mapMaxPlayers, completedEncounters, totalEncounters, raidId);
                    break;
                case TRIAL_OF_THE_CRUSADER_ICEHOWL_10H:
                case TRIAL_OF_THE_CRUSADER_JARAXXUS_10H:
                case TRIAL_OF_THE_CRUSADER_ANUBARAK_10H:
                case ICC_MARROWGAR_10H:
                case ICC_DEATHWHISPER_10H:
                case ICC_SAURFANG_10H:
                case ICC_FESTERGUT_10H:
                case ICC_ROTFACE_10H:
                case ICC_PUTRICIDE_10H:
                case ICC_LANATHEL_10H:
                case ICC_SINDRAGOSA_10H:
                case ICC_LICHKING_10H:
                case RUBY_SANCTUM_HALION_10H:
                    if (RaidInfoDifficulty <= 2)
                        sWorld->SendWorldText(TextIdStandard, mapName.c_str(), mapMaxPlayers, bossName.c_str(), guildName.c_str(), playerCount, mapMaxPlayers, completedEncounters, totalEncounters, raidId);
                    break;
                case TRIAL_OF_THE_CRUSADER_FJOLA_25H:
                    if (RaidInfoDifficulty <= 3)
                        sWorld->SendWorldText(TextIdSpecialToc, mapName.c_str(), mapMaxPlayers, guildName.c_str(), playerCount, mapMaxPlayers, completedEncounters, totalEncounters, raidId);
                    break;
                case ICC_VALANAR_25H:
                    if (RaidInfoDifficulty <= 3)
                        sWorld->SendWorldText(TextIdSpecialIcc, mapName.c_str(), mapMaxPlayers, guildName.c_str(), playerCount, mapMaxPlayers, completedEncounters, totalEncounters, raidId);
                    break;
                case ICC_GUNSHIP_SKYBREAKER_25H:
                case ICC_GUNSHIP_ORGRIMS_HAMMER_25H:
                    if (RaidInfoDifficulty <= 3)
                        sWorld->SendWorldText(TextIdGunshipIcc, mapName.c_str(), mapMaxPlayers, guildName.c_str(), playerCount, mapMaxPlayers, completedEncounters, totalEncounters, raidId);
                    break;
                case ICC_VALITHRIA_25N:
                    if (RaidInfoDifficulty <= 3)
                        sWorld->SendWorldText(TextIdValithriaIcc, mapName.c_str(), mapMaxPlayers, bossName.c_str(), guildName.c_str(), playerCount, mapMaxPlayers, completedEncounters, totalEncounters, raidId);
                    break;
                case TRIAL_OF_THE_CRUSADER_ICEHOWL_25H:
                case TRIAL_OF_THE_CRUSADER_JARAXXUS_25H:
                case TRIAL_OF_THE_CRUSADER_ANUBARAK_25H:
                case ICC_MARROWGAR_25H:
                case ICC_DEATHWHISPER_25H:
                case ICC_SAURFANG_25H:
                case ICC_FESTERGUT_25H:
                case ICC_ROTFACE_25H:
                case ICC_PUTRICIDE_25H:
                case ICC_LANATHEL_25H:
                case ICC_SINDRAGOSA_25H:
                case ICC_LICHKING_25H:
                case RUBY_SANCTUM_HALION_25H:
                    if (RaidInfoDifficulty <= 3)
                        sWorld->SendWorldText(TextIdStandard, mapName.c_str(), mapMaxPlayers, bossName.c_str(), guildName.c_str(), playerCount, mapMaxPlayers, completedEncounters, totalEncounters, raidId);
                    break;
                default:
                    break;
            }
        }

        if (!RaidInfoLog)
            return;

        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_RAIDINFO);
        stmt->setUInt32(0, guildId);
        stmt->setString(1, guildName.c_str());
        stmt->setUInt32(2, entry);
        stmt->setUInt32(3, playerCount);
        stmt->setString(4, leaderName.c_str());
        stmt->setUInt32(5, raidId);
        stmt->setString(6, killTeam.c_str());
        stmt->setUInt32(7, spawnMode);
        stmt->setUInt32(8, map->GetId());
        stmt->setString(9, bossName.c_str());
        stmt->setString(10, mapName.c_str());
        stmt->setUInt32(11, mapMaxPlayers);
        stmt->setUInt32(12, completedEncounters);
        stmt->setUInt32(13, totalEncounters);

        CharacterDatabase.Execute(stmt);
    }
};

void AddSC_player_raid_info_announce()
{
    new RaidInfo_AllCreatureScript();
    new RaidInfo_WorldScript();
}