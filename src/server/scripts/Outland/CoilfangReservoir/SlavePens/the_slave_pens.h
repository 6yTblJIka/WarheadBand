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

#ifndef SLAVE_PENS_H
#define SLAVE_PENS_H

#include "CreatureAIImpl.h"

uint32 const EncounterCount               = 3;

#define SPScriptName "instance_the_slave_pens"
#define DataHeader "SP"

enum SPDataTypes
{
    DATA_MENNU_THE_BETRAYER               = 0,
    DATA_ROKMAR_THE_CRACKLER              = 1,
    DATA_QUAGMIRRAN                       = 2,
    DATA_AHUNE                            = 3,
    MAX_ENCOUNTER                         = 4,
    DATA_AHUNE_BUNNY                      = 5,
    DATA_FROZEN_CORE                      = 6,
    DATA_FLAMECALLER_000                  = 7,
    DATA_FLAMECALLER_001                  = 8,
    DATA_FLAMECALLER_002                  = 9,
    DATA_BONFIRE_BUNNY_000                = 10,
    DATA_BONFIRE_BUNNY_001                = 11,
    DATA_BONFIRE_BUNNY_002                = 12,
    DATA_BEAM_BUNNY_000                   = 13,
    DATA_BEAM_BUNNY_001                   = 14,
    DATA_BEAM_BUNNY_002                   = 15,
    DATA_LUMA_SKYMOTHER                   = 16
};

enum SPCreaturesIds
{
    NPC_AHUNE                            = 25740,
    NPC_FROZEN_CORE                      = 25865,
    NPC_AHUNE_SUMMON_LOC_BUNNY           = 25745,
    NPC_TOTEM                            = 25961,
    NPC_TOTEM_BUNNY_1                    = 25971,
    NPC_TOTEM_BUNNY_2                    = 25972,
    NPC_TOTEM_BUNNY_3                    = 25973,
    NPC_LUMA_SKYMOTHER                   = 25697,
    NPC_AHUNE_LOC_BUNNY                  = 25745,
    NPC_EARTHEN_RING_FLAMECALLER         = 25754,
    NPC_SHAMAN_BONFIRE_BUNNY_000         = 25971,
    NPC_SHAMAN_BONFIRE_BUNNY_001         = 25972,
    NPC_SHAMAN_BONFIRE_BUNNY_002         = 25973,
    NPC_SHAMAN_BEAM_BUNNY_000            = 25964,
    NPC_SHAMAN_BEAM_BUNNY_001            = 25965,
    NPC_SHAMAN_BEAM_BUNNY_002            = 25966,
    NPC_WHISP_DEST_BUNNY                 = 26120,
    NPC_WHISP_SOURCE_BUNNY               = 26121,
    NPC_MENNU_THE_BETRAYER               = 17941,
    NPC_ROKMAR_THE_CRACKLER              = 17991,
    NPC_QUAGMIRRAN                       = 17942
};

enum SPGameObjectIds
{
    GO_ICE_SPEAR                         = 188077,
    GO_ICE_STONE                         = 187882
};

template <class AI, class T>
inline AI* GetTheSlavePensAI(T* obj)
{
    return GetInstanceAI<AI>(obj, SPScriptName);
}

#define RegisterTheSlavePensCreatureAI(ai_name) RegisterCreatureAIWithFactory (ai_name, GetTheSlavePensAI)

#endif // SLAVE_PENS_H
