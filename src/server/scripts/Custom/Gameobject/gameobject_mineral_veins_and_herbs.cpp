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
#include "GameObjectAI.h"
#include "GameObject.h"
#include "LootMgr.h"

class gameobject_mineral_veins_and_herbs : public GameObjectScript
{
public:
    gameobject_mineral_veins_and_herbs() : GameObjectScript("gameobject_mineral_veins_and_herbs") {}

    void OnLootStateChanged(GameObject* go, uint32 state, Unit* /*unit*/) OVERRIDE
    {
        Loot* loot = &go->loot;

        if (state == GO_ACTIVATED && loot && !loot->isLooted() && loot->items.size() != loot->unlootedCount)
        {
            go->SetRespawnTime(go->GetRespawnDelay());
            go->SetLootState(GO_JUST_DEACTIVATED);
        }
    }
};

void AddSC_gameobject_mineral_veins_and_herbs()
{
    new gameobject_mineral_veins_and_herbs();
}
