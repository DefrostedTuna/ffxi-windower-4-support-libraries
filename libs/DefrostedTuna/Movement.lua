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

local Movement = {
    ---
    -- The counter used to defer the polling time for movements.
    --
    -- @param number
    ---
    counter = 0,

    ---
    -- The original position of the character.
    --
    -- @param table<string, float>
    ---
    position = {
        x = 0,
        y = 0,
        z = 0,
    },

    ---
    -- The movement status of the player character.
    --
    -- @param boolean
    ---
    moving = false
}
Movement.__index = Movement

---
-- Create a new Movement instance.
--
-- Note: The instance created is a singleton.
--
-- @return table<string, mixed>
---
function Movement:new()
    if (self._instance) then
        return self._instance
    end

    local instance = setmetatable({}, self)
    self._instance = instance

    -- Use the prerender event to watch for player movement.
    windower.register_event("prerender", function ()
        self:handlePrerender()
    end)

    return instance
end

---
-- The counter used to defer the polling time for movements.
--
-- @return number
---
function Movement:getCounter()
    return self.counter
end

---
-- Set the counter used to defer the polling time for movements.
--
-- @param  number  value
--
-- @return void
---
function Movement:setCounter(value)
    self.counter = value
end

---
-- The position (x, y, z) of the player character.
--
-- @return table<string, float>
---
function Movement:getPosition()
    return self.position
end

---
-- Set the position (x, y, z) of the player character.
--
-- @param  float  x
-- @param  float  y
-- @param  float  z
--
-- @return void
---
function Movement:setPosition(x, y, z)
    self.position = {
        ['x'] = x,
        ['y'] = y,
        ['z'] = z,
    }
end

---
-- The movement state of the player character.
--
-- @return boolean
---
function Movement:getMoving()
    return self.moving
end

---
-- Set the movement state of the player character.
--
-- @param  boolean  value
--
-- @return void
---
function Movement:setMoving(value)
    self.moving = value
end

---
-- Handle setting the movement status of the player character on prerender events.
--
-- @return void
---
function Movement:handlePrerender()
    local player = windower.ffxi.get_player()
    local count = self:getCounter() + 1
    local moving = self:getMoving()

    self:setCounter(count)

    -- Delay the execution if the player is not available.
    if not (player) then
        return
    end

    if (count > 15) then
        local target = windower.ffxi.get_mob_by_index(player.index)
        local position = self:getPosition()

        if (target) and (target.x) and (position.x) then
            local moved = math.sqrt(
                (target.x - position.x)^2 +
                (target.y - position.y)^2 +
                (target.z - position.z)^2
            ) > 0.1
        
            if (moved) and not (moving) then
                self:setMoving(true)
            elseif not (moved) and (moving) then
                self:setMoving(false)
            end
        end

        -- Reset position.
        if (target) and (target.x) then
            self:setPosition(target.x, target.y, target.z)
        end

        self:setCounter(0)
    end
end

return Movement