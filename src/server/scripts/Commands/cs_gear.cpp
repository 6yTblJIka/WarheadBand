/*
 * This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

// This is an open source non-commercial project. Dear PVS-Studio, please check it.
// PVS-Studio Static Code Analyzer for C, C++ and C#: http://www.viva64.com

#include "Chat.h"
#include "DatabaseEnv.h"
#include "GameConfig.h"
#include "Player.h"
#include "ScriptObject.h"

using namespace Warhead::ChatCommands;

class gear_commandscript : public CommandScript
{
public:
    gear_commandscript() : CommandScript("gear_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable gearCommandTable =
        {
            { "repair",  HandleGearRepairCommand, SEC_GAMEMASTER, Console::No },
            { "stats",   HandleGearStatsCommand,  SEC_PLAYER,     Console::No }
        };

        static ChatCommandTable commandTable =
        {
            { "gear", gearCommandTable }
        };

        return commandTable;
    }

    static bool HandleGearRepairCommand(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        if (!target)
        {
            target = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!target || !target->IsConnected())
        {
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target->GetConnectedPlayer()))
        {
            return false;
        }

        // Repair items
        target->GetConnectedPlayer()->DurabilityRepairAll(false, 0, false);

        std::string nameLink = handler->playerLink(target->GetName());

        handler->PSendSysMessage(LANG_YOU_REPAIR_ITEMS, nameLink);

        if (handler->needReportToTarget(target->GetConnectedPlayer()))
        {
            ChatHandler(target->GetConnectedPlayer()->GetSession()).PSendSysMessage(LANG_YOUR_ITEMS_REPAIRED, nameLink);
        }

        return true;
    }

    static bool HandleGearStatsCommand(ChatHandler* handler)
    {
        Player* player = handler->getSelectedPlayerOrSelf();

        if (!player)
        {
            return false;
        }

        handler->PSendSysMessage("Character: {}", player->GetPlayerName());
        handler->PSendSysMessage("Current equipment average item level: |cff00ffff{}|r", (int16)player->GetAverageItemLevel());

        if (CONF_GET_INT("PlayerSave.Stats.MinLevel"))
        {
            CharacterDatabasePreparedStatement stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_STATS);
            stmt->SetData(0, player->GetGUID().GetCounter());
            PreparedQueryResult result = CharacterDatabase.Query(stmt);

            if (result)
            {
                auto fields = result->Fetch();
                uint32 MaxHealth = fields[0].Get<uint32>();
                uint32 Strength = fields[1].Get<uint32>();
                uint32 Agility = fields[2].Get<uint32>();
                uint32 Stamina = fields[3].Get<uint32>();
                uint32 Intellect = fields[4].Get<uint32>();
                uint32 Spirit = fields[5].Get<uint32>();
                uint32 Armor = fields[6].Get<uint32>();
                uint32 AttackPower = fields[7].Get<uint32>();
                uint32 SpellPower = fields[8].Get<uint32>();
                uint32 Resilience = fields[9].Get<uint32>();

                handler->PSendSysMessage("Health: |cff00ffff{}|r - Stamina: |cff00ffff{}|r", MaxHealth, Stamina);
                handler->PSendSysMessage("Strength: |cff00ffff{}|r - Agility: |cff00ffff{}|r", Strength, Agility);
                handler->PSendSysMessage("Intellect: |cff00ffff{}|r - Spirit: |cff00ffff{}|r", Intellect, Spirit);
                handler->PSendSysMessage("AttackPower: |cff00ffff{}|r - SpellPower: |cff00ffff{}|r", AttackPower, SpellPower);
                handler->PSendSysMessage("Armor: |cff00ffff{}|r - Resilience: |cff00ffff{}|r", Armor, Resilience);
            }
        }

        return true;
    }
};

void AddSC_gear_commandscript()
{
    new gear_commandscript();
}