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
#include "Config.h"
#include "House.h"
#include "Config.h"
#include "Pet.h"

enum ratingating
{
    MIN_LEVEL_REQ       = 80,
    GEAR_STAMINA_REQ    = 1750,
};

bool DuelZone(Player* winner, Player* loser)
{
    std::istringstream ss(sConfigMgr->GetStringDefault("Duel.Zones", "12 14 4395"));

    do
    {
        std::string zone;
        ss >> zone;

        uint32 zoneId = atoi(zone.c_str());

        AreaTableEntry const* zoneTemplate = GetAreaEntryByAreaID(zoneId);
        if (!zoneTemplate)
            continue;

        if (zoneId == winner->GetZoneId() && zoneId == loser->GetZoneId())
        {
            switch (zoneTemplate->team)
            {
                case AREATEAM_ALLY:
                    return winner->GetTeam() == ALLIANCE;
                case AREATEAM_HORDE:
                    return winner->GetTeam() == HORDE;
                default:
                    return true;
            }
        }
    }
    while (ss);

    if (winner->FindNearestCreature(NPC_HOUSE_WARDEN, 100.0f) ||
        loser->FindNearestCreature(NPC_HOUSE_WARDEN, 100.0f))
        return true;

    return false;
}

bool DuelRated(Player* /*winner*/, Player* /*loser*/)
{
    return sConfigMgr->GetBoolDefault("Duel.Rated", false);
}

bool DuelRatedSecurity(Player* winner, Player* loser)
{
    if (sConfigMgr->GetBoolDefault("Duel.Rated.Security", false))
    {
        if (winner->getLevel() < MIN_LEVEL_REQ || loser->getLevel() < MIN_LEVEL_REQ)
        {
            std::ostringstream ss;
            ss << "|cFFFFFC00[Duel Rated|r : |cFF00FFFF Tu o tu oponente necesita ser nivel " << MIN_LEVEL_REQ << " para ser elegido en un Duel Rated|r \n";
            ChatHandler(winner->GetSession()).SendSysMessage(ss.str().c_str());
            ChatHandler(loser->GetSession()).SendSysMessage(ss.str().c_str());
            return false;
        }

        if (winner->GetHealth() > 10 || loser->GetStat(STAT_STAMINA) < GEAR_STAMINA_REQ)
        {
            std::ostringstream ss;
            ss << "|cFFFFFC00[Duel Rated]|r : |cFF00FFFF Tu o tu oponente no tiene suficiente equipo para ser elegido en un Duel Rated \n";
            ChatHandler(winner->GetSession()).SendSysMessage(ss.str().c_str());
            ChatHandler(loser->GetSession()).SendSysMessage(ss.str().c_str());
            return false;
        }

        if (winner->GetSession()->GetSecurity() != 1 || loser->GetSession()->GetSecurity() != 1)
        {
            std::ostringstream ss;
            ss << "|cFFFFFC00[Duel Rated]|r : |cFF00FFFF No puede ser recompensado si la lucha es contra un Maestro Jugador |r \n";
            ChatHandler(winner->GetSession()).SendSysMessage(ss.str().c_str());
            ChatHandler(loser->GetSession()).SendSysMessage(ss.str().c_str());
            return false;
        }

        if (winner->GetSession()->GetRemoteAddress() == loser->GetSession()->GetRemoteAddress())
        {
            std::ostringstream ss;
            ss << "|cFFFFFC00[Duel Rated]|r : |cFF00FFFF El multi login no esta permitido en este sistema. |r \n";
            ChatHandler(winner->GetSession()).SendSysMessage(ss.str().c_str());
            ChatHandler(loser->GetSession()).SendSysMessage(ss.str().c_str());
            return false;
        }
    }

    return true;
}

void DuelStarResetStat(Player* player)
{
    player->SetHealth(player->GetMaxHealth());
    player->RemoveArenaSpellCooldowns();

    if (player->getPowerType() == POWER_MANA)
        player->SetPower(POWER_MANA, player->GetMaxPower(POWER_MANA));

    if (player->getPowerType() == POWER_ENERGY)
        player->SetPower(POWER_ENERGY, player->GetMaxPower(POWER_ENERGY));

    if (player->getPowerType() == POWER_RUNIC_POWER)
        player->SetPower(POWER_RUNIC_POWER, 0);

    if (Pet* pet = player->GetPet())
        pet->SetHealth(pet->GetMaxHealth());

}

void DuelEndResetStat(Player* player)
{
    DuelStarResetStat(player);
    player->CombatStop();
    player->RemoveAllSpellCooldown();
}

void RatingInfo(Player* player)
{
    QueryResult result = CharacterDatabase.PQuery("SELECT winner,loser,rating FROM characters WHERE guid = '%u'", player->GetGUIDLow());
    if(!result)
        return;

    Field * fields = result->Fetch();
    uint32 winner = fields[0].GetUInt32();
    uint32 loser = fields[1].GetUInt32();
    uint32 rating = fields[2].GetUInt32();
    ChatHandler(player->GetSession()).PSendSysMessage("[Duel Informacion] - [Duel Stats] : |cffFFFF00%u |cFF90EE90Duel win & |cffFFFF00%u |cFF90EE90Duel lose  |cffff6060[Rating] : |cffFFFF00%u \n", winner,loser,rating);
}

void Update_Stats(Player* winer, Player* loser)
{
    // Winner
    CharacterDatabase.PExecute("UPDATE characters SET winner = (winner+1) WHERE guid = '%u'", winer->GetGUIDLow());
    CharacterDatabase.PExecute("UPDATE characters SET rating = (rating+14) WHERE guid = '%u'", winer->GetGUIDLow());
    ChatHandler(winer->GetSession()).SendSysMessage("|cFFFFFC00[Duel Informacion]|cFF00FFFF Bien hecho usted gano 14 Puntos !");
    // Loser
    CharacterDatabase.PExecute("UPDATE characters SET loser = (loser+1) WHERE guid = '%u'", loser->GetGUIDLow());
    CharacterDatabase.PExecute("UPDATE characters SET rating = (rating-7) WHERE guid = '%u'", loser->GetGUIDLow());
    ChatHandler(loser->GetSession()).SendSysMessage("|cFFFFFC00[Duel Informacion]|cFF00FFFF Perdiste 7 Puntos !");
}

class player_duel : public PlayerScript
{
public:
    player_duel() : PlayerScript("player_duel") { }

    void OnDuelStart(Player* winner, Player* loser)
    {
        if (DuelZone(winner, loser) && DuelRated(winner, loser))
        {
            DuelStarResetStat(winner);
            DuelStarResetStat(loser);
            RatingInfo(winner);
            RatingInfo(loser);
        }

    }

    void OnDuelEnd(Player* winner, Player* loser, DuelCompleteType type)
    {
        if (DuelZone(winner, loser))
        {
            if (DuelRated(winner, loser) && DuelRatedSecurity(winner, loser))
            {
                DuelEndResetStat(winner);
                DuelEndResetStat(loser);
                Update_Stats(winner, loser);
            }
            else if (type == DUEL_WON)
            {
                DuelEndResetStat(winner);
                DuelEndResetStat(loser);
            }
        }
    }
};

void AddSC_player_duel()
{
    new player_duel();
}
