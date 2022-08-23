--[[
Copyright © 2022, DefrostedTuna
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
        notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
        notice, this list of conditions and the following disclaimer in the
        documentation and/or other materials provided with the distribution.
    * Neither the name of Windower 4 Support Libraries nor the
        names of its contributors may be used to endorse or promote products
        derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL DEFROSTEDTUNA BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

local helpers = {}

---
-- Determine if a given table has a specific key.
--
-- @param  table<mixed>  tbl  The table to be used as a reference.
-- @param  mixed         val  The value being looked up on the table.
--
-- @return boolean
---
function helpers.table_key_exists(tbl, val)
    for key, _ in pairs(tbl) do
        if key == val then
            return true
        end
    end

    return false
end

---
-- Determine if a given table has a specific value.
--
-- @param  table<mixed>  tbl  The table to be used as a reference.
-- @param  mixed         val  The value being looked up on the table.
--
-- @return boolean
---
function helpers.in_table(tbl, val)
    for _, value in pairs(tbl) do
        if value == val then
            return true
        end
    end

    return false
end

---
-- Capitalize the first letter in a given string.
--
-- @param  string  str  The string to be captialized.
--
-- @return string
---
function helpers.ucfirst(str)
    if (type(str) ~= 'string') then
        return ''
    end
    
    return str:sub(1, 1):upper() .. str:sub(2)
end

---
-- Determine if the player is currently 'busy'.
--
-- @return boolean
---
function helpers.player_is_busy()
    local player = windower.ffxi.get_player()
    -- Not sure where to find all of these.
    -- This is what I was able to put together from various sources.
    local statuses = {
        Idle = 0,
        Engaged = 1,
        Resting = 33,
        Event = 4,
    }

    return not (player.status == statuses.Idle or player.status == statuses.Engaged)
end

---
-- Determine if the player is currently sneaking.
--
-- @return boolean
---
function helpers.player_is_sneaking()
    local player = windower.ffxi.get_player()
    local statuses = {
        sneak = 71,
        invisible = 69,
    }

    return helpers.in_table(player.buffs, statuses.sneak) or helpers.in_table(player.buffs, statuses.invisible)
end

return helpers