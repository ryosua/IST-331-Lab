--[[
    A module to create a timer object that times events in ms.
]]--

local timer = {}

--[[
    Constructs a new timer.
]]--
function timer.new()
    local instance = {}

    local time = 0 -- time in ms

    --timer.performWithDelay( delay, listener [, iterations] )

    --[[
        Starts counting on the timer.
    ]]--
    instance.start = function()
        print "timer started"
    end

    return instance
end

return timer