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
#include "Chat.h"
#include "Language.h"
#include "Guild.h"
#include "Player.h"

class custom_item_guild_vault_mobile : public ItemScript
{
public:
    custom_item_guild_vault_mobile() : ItemScript("custom_item_guild_vault_mobile"){}

    bool OnUse(Player * player, Item * /*item*/, SpellCastTargets const& /*targets*/)
    {

        GameObject* GuildVault = player->FindNearestGameObject(187329, 30.f);
        if (GuildVault && GuildVault->IsEventVisibleFor(player))
            player->GetSession()->SendNotification("There is already a Guild Vault Mobile invoked!");
        else
        {
            GuildVault = player->SummonGameObject(187329, player->GetPositionX() + 1, player->GetPositionY() + 1, player->GetPositionZ(), 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, MINUTE * IN_MILLISECONDS);
            GuildVault->SetEventVisibleFor(player, true);
            GuildVault->EnableCollision(false);
            return false;
        }
        return false;
    }
};

void AddSC_item_custom_guild_leveling_system()
{
    new custom_item_guild_vault_mobile();
}
