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

#define CHANCE  0.99

static const uint32 ItemEnchants[] = {3789, 3854, 3273, 3225, 3870, 1899, 2674, 2675, 2671, 2672, 3365, 2673, 2343, 425, 3855, 1894, 1103, 1898, 3345, 1743, 3093, 1900, 3846, 1606, 283, 1, 3265, 2, 3, 3266, 1903, 13, 26, 7, 803, 1896, 2666, 25};
static const uint32 ItemEnchants_size = sizeof(ItemEnchants)/sizeof(*ItemEnchants);
typedef UNORDERED_MAP<uint32, uint32> EnchantStoreType;
typedef UNORDERED_MAP<uint32, EnchantStoreType> ItemStoreType;
static ItemStoreType ItemStore;

uint32 GetItemEnchantVisual(Player* player, Item* item)
{
    if (!player || !item)
        return 0;

    uint32 itemGuid = item->GetGUIDLow();
    EnchantStoreType* EnchantStore = NULL;
    ItemStoreType::iterator it = ItemStore.find(player->GetGUIDLow());
    if (it != ItemStore.end())
        EnchantStore = &it->second;
    bool hasVisual = (EnchantStore && EnchantStore->find(itemGuid) != EnchantStore->end());
    uint32 enchant = item->GetEnchantmentId(PERM_ENCHANTMENT_SLOT);

    if (enchant)
    {
        if (hasVisual)
        {
            PreparedStatement* stmt;
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_ENCHANT_VISUAL);
            stmt->setUInt32(0, itemGuid);
            CharacterDatabase.Execute(stmt);

            EnchantStore->erase(itemGuid);
        }
        return enchant;
    }
    if (hasVisual)
        return (*EnchantStore)[itemGuid];
    return 0;
}

void SetRandomEnchantVisual(Player* player, Item* item)
{
    if (!player || !item)
        return;
    const ItemTemplate* temp = item->GetTemplate();
    if (temp->Class != ITEM_CLASS_WEAPON)
        return;
    if (temp->SubClass == ITEM_SUBCLASS_WEAPON_BOW ||
        temp->SubClass == ITEM_SUBCLASS_WEAPON_GUN ||
        temp->SubClass == ITEM_SUBCLASS_WEAPON_obsolete ||
        temp->SubClass == ITEM_SUBCLASS_WEAPON_FIST ||
        temp->SubClass == ITEM_SUBCLASS_WEAPON_THROWN ||
        temp->SubClass == ITEM_SUBCLASS_WEAPON_SPEAR ||
        temp->SubClass == ITEM_SUBCLASS_WEAPON_CROSSBOW ||
        temp->SubClass == ITEM_SUBCLASS_WEAPON_WAND ||
        temp->SubClass == ITEM_SUBCLASS_WEAPON_FISHING_POLE)
        return;
    if (rand_norm() >= CHANCE)
        return;

    uint32 enchant = ItemEnchants[urand(0, ItemEnchants_size)];
    uint32 itemGuid = item->GetGUIDLow();

    PreparedStatement* stmt;
    stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_ITEM_ENCHANT_VISUAL);
    stmt->setUInt32(0, itemGuid);
    stmt->setUInt32(1, enchant);
    CharacterDatabase.Execute(stmt);

    ItemStore[player->GetGUIDLow()][itemGuid] = enchant;
    player->SetVisibleItemSlot(EQUIPMENT_SLOT_MAINHAND, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND));
    player->SetVisibleItemSlot(EQUIPMENT_SLOT_OFFHAND, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND));
}

class item_enchant_visual : public PlayerScript
{
public:
    item_enchant_visual() : PlayerScript("item_enchant_visual")
    {
        PreparedStatement* stmt;
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_ENCHANT_VISUAL_NOT_EXIST);
        CharacterDatabase.Execute(stmt);
    }

    void OnLogin(Player* player)
    {
        PreparedStatement* stmt;

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ITEM_ENCHANT_VISUAL);
        stmt->setUInt32(0, player->GetGUIDLow());
        PreparedQueryResult result = CharacterDatabase.Query(stmt);
        if (result)
        {
            uint32 pguid = player->GetGUIDLow();
            do
            {
                uint32 itemGuid = result->Fetch()[0].GetUInt32();
                uint32 display = result->Fetch()[1].GetUInt32();
                ItemStore[pguid][itemGuid] = display;
            }
            while (result->NextRow());

            player->SetVisibleItemSlot(EQUIPMENT_SLOT_MAINHAND, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND));
            player->SetVisibleItemSlot(EQUIPMENT_SLOT_OFFHAND, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND));
        }
    }

    void OnLogout(Player* player)
    {
        ItemStore.erase(player->GetGUIDLow());
    }
};

void AddSC_item_enchant_visual()
{
    new item_enchant_visual;
}

#undef CHANCE
