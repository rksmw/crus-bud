/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
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

#include "Player.h"
#include "Item.h"

SpectatorAddonMsg::SpectatorAddonMsg()
{
    for (uint8 i = 0; i < SPECTATOR_PREFIX_COUNT; ++i)
        prefixFlags[i] = false;

    player    = "";
    target    = 0;
    isAlive   = false;
    pClass    = CLASS_WARRIOR;
    maxHP     = 0;
    maxPower  = 0;
    currHP    = 0;
    currPower = 0;
    powerType = POWER_MANA;
    spellId   = 0;
    castTime  = 0;
    team      = ALLIANCE;
    petCurrHP = 0;
    petType   = 0;
}

bool SpectatorAddonMsg::CanSandAura(uint32 auraID)
{
    const SpellInfo *spell = sSpellMgr->GetSpellInfo(auraID);

    if (!spell)
        return false;

    if (spell->SpellIconID == 1)
        return false;

    return true;
}

void SpectatorAddonMsg::CreateAura(uint32 _caster, uint32 _spellId, bool _isDebuff, uint8 _type, int32 _duration, int32 _expire, uint16 _stack, bool _isRemove)
{
    if (!CanSandAura(_spellId))
        return;

    aCaster     = _caster;
    aSpellId    = _spellId;
    aIsDebuff   = _isDebuff;
    aType       = _type;
    aDuration   = _duration;
    aExpire     = _expire;
    aStack      = _stack;
    aRemove     = _isRemove;
    EnableFlag(SPECTATOR_PREFIX_AURA);
}

void SpectatorAddonMsg::RemoveAura(uint32 _caster, uint32 _spellId, bool _isDebuff, uint8 _type, int32 _duration, int32 _expire, uint16 _stack, bool _isRemove)
{
    if (!CanSandAura(_spellId))
        return;

    aCaster     = _caster;
    aSpellId    = _spellId;
    aIsDebuff   = _isDebuff;
    aType       = _type;
    aDuration   = _duration;
    aExpire     = _expire;
    aStack      = _stack;
    aRemove     = _isRemove;
    EnableFlag(SPECTATOR_PREFIX_RESET);
}

std::string SpectatorAddonMsg::GetMsgData()
{
    if (isFilledIn(SPECTATOR_PREFIX_OUTDATED))
        return "ARENASPEC	OUTDATED";

    std::string addonData = "";

    if (!isFilledIn(SPECTATOR_PREFIX_PLAYER_GUID))
    {
        TC_LOG_DEBUG(LOG_FILTER_BATTLEGROUND, "SPECTATOR ADDON: player is not filled in.");
        return addonData;
    }

    std::string msg = "";
    for (uint8 i = 0; i < SPECTATOR_PREFIX_COUNT; ++i)
    {
        if (isFilledIn(i))
        {
            switch (i)
            {
                case SPECTATOR_PREFIX_PLAYER_GUID:
                {
                    char buffer[30];
                    sprintf(buffer, "0x0000000000%06X;", guid);
                    msg += buffer;
                    break;
                }
                case SPECTATOR_PREFIX_NAME:
                {
                    char buffer[30];
                    sprintf(buffer, "NME=%s;", player.c_str());
                    msg += buffer;
                    break;
                }
                case SPECTATOR_PREFIX_TARGET:
                {
                    char buffer[30];
                    sprintf(buffer, "TRG=0x0000000000%06X;", target ? target : 0);
                    msg += buffer;
                    break;
                }
                case SPECTATOR_PREFIX_TEAM:
                {
                    char buffer[20];
                    sprintf(buffer, "TEM=%i;", (uint16)team);
                    msg += buffer;
                    break;
                }
                case SPECTATOR_PREFIX_STATUS:
                {
                    char buffer[20];
                    sprintf(buffer, "STA=%d;", isAlive);
                    msg += buffer;
                    break;
                }
                case SPECTATOR_PREFIX_CLASS:
                {
                    char buffer[20];
                    sprintf(buffer, "CLA=%i;", (int)pClass);
                    msg += buffer;
                    break;
                }
                case SPECTATOR_PREFIX_MAXHP:
                {
                    char buffer[30];
                    sprintf(buffer, "MHP=%i;", maxHP);
                    msg += buffer;
                    break;
                }
                case SPECTATOR_PREFIX_CURHP:
                {
                    char buffer[30];
                    sprintf(buffer, "CHP=%i;", currHP);
                    msg += buffer;
                    break;
                }
                case SPECTATOR_PREFIX_MAXPOWER:
                {
                    char buffer[30];
                    sprintf(buffer, "MPW=%i;", maxPower);
                    msg += buffer;
                    break;
                }
                case SPECTATOR_PREFIX_CURPOWER:
                {
                    char buffer[30];
                    sprintf(buffer, "CPW=%i;", currPower);
                    msg += buffer;
                    break;
                }
                case SPECTATOR_PREFIX_POWERTYPE:
                {
                    char buffer[20];
                    sprintf(buffer, "PWT=%i;", (uint8)powerType);
                    msg += buffer;
                    break;
                }
                case SPECTATOR_PREFIX_SPELL:
                {
                    char buffer[80];
                    sprintf(buffer, "SPE=%i,%i;", spellId, castTime);
                    msg += buffer;
                    break;
                }
                case SPECTATOR_PREFIX_CANCEL_SPELL:
                {
                    char buffer[30];
                    sprintf(buffer, "SCA=%i;", spellId);
                    msg += buffer;
                    break;
                }
                case SPECTATOR_PREFIX_AURA:
                {
                    char buffer[300];
                    sprintf(buffer, "AUR=%i,%i,%i,%i,%i,%i,%i,0x0000000000%06X;", aRemove, aStack, aExpire, aDuration, aSpellId, aType, aIsDebuff, aCaster ? aCaster : 0);
                    msg += buffer;
                    break;
                }
                case SPECTATOR_PREFIX_AURA_REMOVE:
                {
                    char buffer[300];
                    sprintf(buffer, "AUR=%i,%i,%i,%i,%i,%i,%i,0x0000000000%06X;", aRemove, aStack, aExpire, aDuration, aSpellId, aType, aIsDebuff, aCaster ? aCaster : 0);
                    msg += buffer;
                    break;
                }
                case SPECTATOR_PREFIX_RESET: // not implemented yet
                {
                    char buffer[80];
                    sprintf(buffer, "RES=%i;", aurastack);
                    msg += buffer;
                    break;
                }
                case SPECTATOR_PREFIX_PETHP:
                {
                    char buffer[12];
                    sprintf(buffer, "PHP=%i;", petCurrHP);
                    msg += buffer;
                    break;
                }
                case SPECTATOR_PREFIX_PETTYPE:
                {
                    char buffer[7];
                    sprintf(buffer, "PET=%i;", petType);
                    msg += buffer;
                    break;
                }
                case SPECTATOR_PREFIX_COOLDOWN:
                {
                    char buffer[30];
                    sprintf(buffer, "CD=%i,%i;", spellId, castTime);
                    msg += buffer;
                    break;
                }
            }
        }
    }

    if (msg != "")
        addonData = "ARENASPEC	" + msg;

    return addonData;
}

bool SpectatorAddonMsg::SendPacket(uint32 receiver)
{
    std::string addonData = GetMsgData();
    if (addonData == "")
        return false;

    Player* rPlayer = ObjectAccessor::FindPlayer(receiver);
    if (!rPlayer)
        return false;

    WorldPacket data(SMSG_MESSAGECHAT, 200);
    data << uint8(CHAT_MSG_WHISPER);
    data << uint32(LANG_ADDON);
    data << uint64(0);
    data << uint32(LANG_ADDON);                               //language 2.1.0 ?
    data << uint64(0);
    data << uint32(addonData.length() + 1);
    data << addonData;
    data << uint8(CHAT_TAG_NONE);
    rPlayer->GetSession()->SendPacket(&data);

    return true;
}

bool SpectatorAddonMsg::SendPacket(SpectatorAddonMsg msg, uint32 receiver)
{
    std::string addonData = msg.GetMsgData();
    if (addonData == "")
        return false;

    Player* rPlayer = ObjectAccessor::FindPlayer(receiver);
    if (!rPlayer)
        return false;

    WorldPacket data(SMSG_MESSAGECHAT, 200);
    data << uint8(CHAT_MSG_WHISPER);
    data << uint32(LANG_ADDON);
    data << uint64(0);
    data << uint32(LANG_ADDON);                               //language 2.1.0 ?
    data << uint64(0);
    data << uint32(addonData.length() + 1);
    data << addonData;
    data << uint8(CHAT_TAG_NONE);
    rPlayer->GetSession()->SendPacket(&data);

    return true;
}
