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
Name: guild_commandscript
%Complete: 100
Comment: All guild related commands
Category: commandscripts
EndScriptData */

#include "Chat.h"
#include "Language.h"
#include "Guild.h"
#include "GuildMgr.h"
#include "ObjectAccessor.h"
#include "ScriptMgr.h"


class guild_commandscript : public CommandScript
{
public:
    guild_commandscript() : CommandScript("guild_commandscript") { }

    ChatCommand* GetCommands() const
    {
        static ChatCommand guildLevelingSetCommandTable[] =
        {
            { "level",      RBAC_PERM_COMMAND_GUILD_LEVELING_SET_LEVEL, true, &HandleGuildLevelingSetLevelCommand,          "", NULL },
            { "xp",         RBAC_PERM_COMMAND_GUILD_LEVELING_SET_XP,    true, &HandleGuildLevelingSetXpCommand,             "", NULL },
            { NULL,         0,                                          false, NULL,                                        "", NULL }
        };
        static ChatCommand guildLevelingCommandTable[] =
        {
            { "info",       RBAC_PERM_COMMAND_GUILD_LEVELING_INFO,      false, &HandleGuildLevelingInfoCommand,             "", NULL },
            { "bonus",      RBAC_PERM_COMMAND_GUILD_LEVELING_BONUS,     false, &HandleGuildLevelingBonusCommand,            "", NULL },
            { "set",        RBAC_PERM_COMMAND_GUILD_LEVELING_SET,       true,  NULL,                "", guildLevelingSetCommandTable },
            { NULL,         0,                                          false, NULL,                                        "", NULL }
        };
        static ChatCommand guildCommandTable[] =
        {
            { "create",     RBAC_PERM_COMMAND_GUILD_CREATE,             true,  &HandleGuildCreateCommand,                   "", NULL },
            { "delete",     RBAC_PERM_COMMAND_GUILD_DELETE,             true,  &HandleGuildDeleteCommand,                   "", NULL },
            { "invite",     RBAC_PERM_COMMAND_GUILD_INVITE,             true,  &HandleGuildInviteCommand,                   "", NULL },
            { "uninvite",   RBAC_PERM_COMMAND_GUILD_UNINVITE,           true,  &HandleGuildUninviteCommand,                 "", NULL },
            { "rank",       RBAC_PERM_COMMAND_GUILD_RANK,               true,  &HandleGuildRankCommand,                     "", NULL },
            { "rename",     RBAC_PERM_COMMAND_GUILD_RENAME,             true,  &HandleGuildRenameCommand,                   "", NULL },
            { "leveling",   RBAC_PERM_COMMAND_GUILD_LEVELING,           true,  NULL,                   "", guildLevelingCommandTable },
            { NULL,         0,                                          false, NULL,                                        "", NULL }
        };
        static ChatCommand commandTable[] =
        {
            { "guild", RBAC_PERM_COMMAND_GUILD,  true, NULL, "", guildCommandTable },
            { NULL,    0,                       false, NULL, "", NULL }
        };
        return commandTable;
    }

    /** \brief GM command level 3 - Create a guild.
     *
     * This command allows a GM (level 3) to create a guild.
     *
     * The "args" parameter contains the name of the guild leader
     * and then the name of the guild.
     *
     */
    static bool HandleGuildCreateCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        // if not guild name only (in "") then player name
        Player* target;
        if (!handler->extractPlayerTarget(*args != '"' ? (char*)args : NULL, &target))
            return false;

        char* tailStr = *args != '"' ? strtok(NULL, "") : (char*)args;
        if (!tailStr)
            return false;

        char* guildStr = handler->extractQuotedArg(tailStr);
        if (!guildStr)
            return false;

        std::string guildName = guildStr;

        if (target->GetGuildId())
        {
            handler->SendSysMessage(LANG_PLAYER_IN_GUILD);
            return true;
        }

        Guild* guild = new Guild;
        if (!guild->Create(target, guildName))
        {
            delete guild;
            handler->SendSysMessage(LANG_GUILD_NOT_CREATED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        sGuildMgr->AddGuild(guild);

        return true;
    }

    static bool HandleGuildDeleteCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* guildStr = handler->extractQuotedArg((char*)args);
        if (!guildStr)
            return false;

        std::string guildName = guildStr;

        Guild* targetGuild = sGuildMgr->GetGuildByName(guildName);
        if (!targetGuild)
            return false;

        targetGuild->Disband();
        delete targetGuild;

        return true;
    }

    static bool HandleGuildInviteCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        // if not guild name only (in "") then player name
        uint64 targetGuid;
        if (!handler->extractPlayerTarget(*args != '"' ? (char*)args : NULL, NULL, &targetGuid))
            return false;

        char* tailStr = *args != '"' ? strtok(NULL, "") : (char*)args;
        if (!tailStr)
            return false;

        char* guildStr = handler->extractQuotedArg(tailStr);
        if (!guildStr)
            return false;

        std::string guildName = guildStr;
        Guild* targetGuild = sGuildMgr->GetGuildByName(guildName);
        if (!targetGuild)
            return false;

        // player's guild membership checked in AddMember before add
        return targetGuild->AddMember(targetGuid);
    }

    static bool HandleGuildUninviteCommand(ChatHandler* handler, char const* args)
    {
        Player* target;
        uint64 targetGuid;
        if (!handler->extractPlayerTarget((char*)args, &target, &targetGuid))
            return false;

        uint32 guildId = target ? target->GetGuildId() : Player::GetGuildIdFromDB(targetGuid);
        if (!guildId)
            return false;

        Guild* targetGuild = sGuildMgr->GetGuildById(guildId);
        if (!targetGuild)
            return false;

        targetGuild->DeleteMember(targetGuid, false, true, true);
        return true;
    }

    static bool HandleGuildRankCommand(ChatHandler* handler, char const* args)
    {
        char* nameStr;
        char* rankStr;
        handler->extractOptFirstArg((char*)args, &nameStr, &rankStr);
        if (!rankStr)
            return false;

        Player* target;
        uint64 targetGuid;
        std::string target_name;
        if (!handler->extractPlayerTarget(nameStr, &target, &targetGuid, &target_name))
            return false;

        uint32 guildId = target ? target->GetGuildId() : Player::GetGuildIdFromDB(targetGuid);
        if (!guildId)
            return false;

        Guild* targetGuild = sGuildMgr->GetGuildById(guildId);
        if (!targetGuild)
            return false;

        uint8 newRank = uint8(atoi(rankStr));
        return targetGuild->ChangeMemberRank(targetGuid, newRank);
    }

    static bool HandleGuildRenameCommand(ChatHandler* handler, char const* _args)
    {
        if (!*_args)
            return false;

        char *args = (char *)_args;

        char const* oldGuildStr = handler->extractQuotedArg(args);
        if (!oldGuildStr)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        char const* newGuildStr = handler->extractQuotedArg(strtok(NULL, ""));
        if (!newGuildStr)
        {
            handler->SendSysMessage(LANG_INSERT_GUILD_NAME);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Guild* guild = sGuildMgr->GetGuildByName(oldGuildStr);
        if (!guild)
        {
            handler->PSendSysMessage(LANG_COMMAND_COULDNOTFIND, oldGuildStr);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (sGuildMgr->GetGuildByName(newGuildStr))
        {
            handler->PSendSysMessage(LANG_GUILD_RENAME_ALREADY_EXISTS, newGuildStr);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!guild->SetName(newGuildStr))
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage(LANG_GUILD_RENAME_DONE, oldGuildStr, newGuildStr);
        return true;
    }

    static bool HandleGuildLevelingInfoCommand(ChatHandler* handler, char const* /*args*/)
    {
        handler->SetSentErrorMessage(true);

        Guild* guild = handler->GetSession()->GetPlayer()->GetGuild();
        if (guild)
        {
            handler->PSendSysMessage(LANG_GUILD_LEVELING_UPPER_BAR);
            handler->PSendSysMessage(LANG_GUILD_LEVELING_INFO_LEVEL, guild->GetLevelGuildLevelingSystem());

            if (guild->GetLevelGuildLevelingSystem() >= GUILD_LEVELING_MAX_LEVEL)
                handler->PSendSysMessage(LANG_GUILD_LEVELING_INFO_XP_INFO, 0, 0);
            else
                handler->PSendSysMessage(LANG_GUILD_LEVELING_INFO_XP_INFO, guild->GetCurrentXP(), guild->GetXpForNextLevel());

            switch (urand(0, 2))
            {
                case 0:
                    handler->PSendSysMessage("Tip: Gana experiencia realizando misiones que no sean repetibles o diarias.");
                    break;
                case 1:
                    handler->PSendSysMessage("Tip: Gana experiencia eliminando a cualquier criatura.");
                    break;
                case 2:
                    handler->PSendSysMessage("Tip: Gana experiencia derrotando a los grandes jefes de las mazmorras de Northrend.");
                    break;
            }

            handler->PSendSysMessage(LANG_GUILD_LEVELING_LOWER_BAR);

            return true;
        }
        else
        {
            handler->PSendSysMessage("Tu no estas en ninguna hermandad (Guild)");
            return false;
        }
    }

    static bool HandleGuildLevelingBonusCommand(ChatHandler* handler, char const* /*args*/)
    {
        handler->SetSentErrorMessage(true);

        Guild* guild = handler->GetSession()->GetPlayer()->GetGuild();
        if (guild)
        {
            handler->PSendSysMessage(LANG_GUILD_LEVELING_UPPER_BAR);
            handler->PSendSysMessage("|Cff00ff00│ Bonus Activos:|r");

            if (guild->GetLevelGuildLevelingSystem() > 0)
            {
                if (guild->HasLevelBonusGuildLeveling(GUILD_LEVELING_BONUS_GOLD_GUILD_BANK_RANK_1))
                {
                    handler->PSendSysMessage("├─ Gold Bonus GuildBank (Rank 1)");
                    handler->PSendSysMessage("│ '5%% Bonus gold for the guild bank'");
                }
                if (guild->HasLevelBonusGuildLeveling(GUILD_LEVELING_BONUS_XP_RANK_1))
                {
                    handler->PSendSysMessage("├─ Amount Experience (Rank 1)");
                    handler->PSendSysMessage("│ '+5%% XP at the end of quest or kill monsters'");
                }
                if (guild->HasLevelBonusGuildLeveling(GUILD_LEVELING_BONUS_FASTER_SPIRIT))
                {
                    handler->PSendSysMessage("├─ Faster Spirit");
                    handler->PSendSysMessage("│ 'Double movement speed as spirit'");
                }
                if (guild->HasLevelBonusGuildLeveling(GUILD_LEVELING_BONUS_LOW_COST_REPAIR_RANK_1))
                {
                    handler->PSendSysMessage("├─ Low Cost Repair (Rank 1)");
                    handler->PSendSysMessage("│ '-25%% Repair costs'");
                }
                if (guild->HasLevelBonusGuildLeveling(GUILD_LEVELING_BONUS_GOLD_GUILD_BANK_RANK_2))
                {
                    handler->PSendSysMessage("├─ Gold Bonus GuildBank (Rank 2)");
                    handler->PSendSysMessage("│ '10%% Bonus gold for the guild bank'");
                }
                if (guild->HasLevelBonusGuildLeveling(GUILD_LEVELING_BONUS_MOUNT_SPEED_RANK_1))
                {
                    handler->PSendSysMessage("├─ Mount Speed (Rank 1)");
                    handler->PSendSysMessage("│ '+5%% Increased mount speed (Except Battlegrounds & Arenas)'");
                }
                if (guild->HasLevelBonusGuildLeveling(GUILD_LEVELING_BONUS_AMOUNT_REPUTATION_RANK_1))
                {
                    handler->PSendSysMessage("├─ Amount Reputation  (Rank 1)");
                    handler->PSendSysMessage("│ '+5%% Reputation gain'");
                }
                if (guild->HasLevelBonusGuildLeveling(GUILD_LEVELING_BONUS_XP_RANK_2))
                {
                    handler->PSendSysMessage("├─ Amount Experience (Rank 2)");
                    handler->PSendSysMessage("│ '+10%% XP at the end of quest or kill monsters'");
                }
                if (guild->HasLevelBonusGuildLeveling(GUILD_LEVELING_BONUS_LOW_COST_REPAIR_RANK_2))
                {
                    handler->PSendSysMessage("├─ Low Cost Repair (Rank 2)");
                    handler->PSendSysMessage("│ '-50%% Repair costs'");
                }
                if (guild->HasLevelBonusGuildLeveling(GUILD_LEVELING_BONUS_MOUNT_SPEED_RANK_2))
                {
                    handler->PSendSysMessage("├─ Mount Speed (Rank 2)");
                    handler->PSendSysMessage("│ '+10%% Increased mount speed (Except Battlegrounds & Arenas)'");
                }
                if (guild->HasLevelBonusGuildLeveling(GUILD_LEVELING_BONUS_AMOUNT_REPUTATION_RANK_2))
                {
                    handler->PSendSysMessage("├─ Amount Reputation  (Rank 2)");
                    handler->PSendSysMessage("│ '+10%% Reputation gain'");
                }
                if (guild->HasLevelBonusGuildLeveling(GUILD_LEVELING_BONUS_AMOUNT_HONOR_RANK_1))
                {
                    handler->PSendSysMessage("├─ Amount Honor (Rank 1)");
                    handler->PSendSysMessage("│ '+5%% Honor'");
                }
                if (guild->HasLevelBonusGuildLeveling(GUILD_LEVELING_BONUS_AMOUNT_HONOR_RANK_2))
                {
                    handler->PSendSysMessage("├─ Amount Honor (Rank 2)");
                    handler->PSendSysMessage("│ '+10%% Honor'");
                }
                if (guild->HasLevelBonusGuildLeveling(GUILD_LEVELING_BONUS_VAULT_MOBILE))
                {
                    handler->PSendSysMessage("├─ Guild Vault Mobile");
                    handler->PSendSysMessage("│ 'Use your guild vault anywhere'");
                }
                if (guild->HasLevelBonusGuildLeveling(GUILD_LEVELING_BONUS_LOW_COST_TRANSMO_RANK_1))
                {
                    handler->PSendSysMessage("├─ Low Cost Transmogrification (Rank 1)");
                    handler->PSendSysMessage("│ '-10%% on transmogrifications cost'");
                }
                if (guild->HasLevelBonusGuildLeveling(GUILD_LEVELING_BONUS_LOW_COST_TRANSMO_RANK_2))
                {
                    handler->PSendSysMessage("├─ Low Cost Transmogrification (Rank 2)");
                    handler->PSendSysMessage("│ '-20%% on transmogrifications cost'");
                }
                if (guild->HasLevelBonusGuildLeveling(GUILD_LEVELING_BONUS_LOW_COST_TRANSMO_RANK_3))
                {
                    handler->PSendSysMessage("├─ Low Cost Transmogrification (Rank 3)");
                    handler->PSendSysMessage("│ '-50%% on transmogrifications cost'");
                }
            }
            else
                handler->PSendSysMessage("- Ninguno");

            handler->PSendSysMessage(LANG_GUILD_LEVELING_LOWER_BAR);
            return true;
        }
        else
        {
            handler->PSendSysMessage("Tu no estas en ninguna hermandad (Guild)");
            return false;
        }
    }

    static bool HandleGuildLevelingSetLevelCommand(ChatHandler* handler, char const* args)
    {
        if (!args)
            return false;

        char* levelStr = strtok((char*)args, " ");
        if (!levelStr || !isNumeric(levelStr))
            return false;

        char* guildNameStr = handler->extractQuotedArg(strtok(NULL, ""));
        if (!guildNameStr)
            return false;

        uint8 newLevel = atoi(levelStr);
        Guild* guild = sGuildMgr->GetGuildByName(guildNameStr);

        handler->SetSentErrorMessage(true);

        if (guild)
        {
            if (newLevel > GUILD_LEVELING_MAX_LEVEL)
            {
                handler->PSendSysMessage("Tu hermandad (Guild) esta en el maximo nivel");
                return false;
            }
            else
                guild->SetLevelGuildLeveling(newLevel, true);
        }
        else
        {
            handler->PSendSysMessage("No se ha encontrado ninguna hermandad (Guild) llamada [%s].", guildNameStr);
            return false;
        }

        return true;
    }

    static bool HandleGuildLevelingSetXpCommand(ChatHandler* handler, char const* args)
    {
        if (!args)
            return false;

        char* xpStr = strtok((char*)args, " ");
        if (!xpStr || !isNumeric(xpStr))
            return false;

        char* guildNameStr = handler->extractQuotedArg(strtok(NULL, ""));
        if (!guildNameStr)
            return false;

        uint32 value = atoi(xpStr);

        Guild* guild = sGuildMgr->GetGuildByName(guildNameStr);

        handler->SetSentErrorMessage(true);

        if (guild)
            guild->GuildLevelingGiveXp(value);
        else
        {
            handler->PSendSysMessage("No se ha encontrado ninguna hermandad (Guild) llamada [%s].", guildNameStr);
            return false;
        }

        return true;
    }
};

void AddSC_guild_commandscript()
{
    new guild_commandscript();
}
