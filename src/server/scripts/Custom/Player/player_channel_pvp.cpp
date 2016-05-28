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

#include "ChannelMgr.h"
#include "WorldSession.h"
#include "Player.h"
#include "ObjectMgr.h"

class player_on_login_channel_pvp : public PlayerScript
{
public:

	player_on_login_channel_pvp() : PlayerScript("player_on_login_channel_pvp") {}

	void OnLogin(Player* player)
	{
		if (ChannelMgr* cMgr = ChannelMgr::forTeam(player->GetTeam()))
		{
			cMgr->setTeam(player->GetTeam());

			if (Channel* channel = cMgr->GetJoinChannel("pvp", 0))
			{
				channel->JoinChannel(player->GetSession()->GetPlayer(), "");
				channel->Invite(player->GetSession()->GetPlayer(), player->GetSession()->GetPlayer()->GetName());
				channel->LeaveChannel(player->GetSession()->GetPlayer(), true);
			}
		}
	}

	void OnLogin(Player* player, bool firstLogin)
	{
		if (IsEventActive(sWorld->getIntConfig(CONFIG_RATE_XP_WEEKEND_EVID)))
			ChatHandler(player->GetSession()).PSendSysMessage("Double XP is going on now!");
	}
};

void AddSC_player_on_login_channel_pvp()
{
	new player_on_login_channel_pvp();
}
