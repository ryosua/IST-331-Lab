--[[
    A module to create a timer object that times events in ms.
]]--

local timerClass = {}

--[[
    Constructs a new timer.
]]--
function timerClass.new()
    local instance = {}

    local time = 0 -- time in ms

    local function onDelay()
        time = time + 1
    end

    -- Create the clock(timer) that will keep track of time in ms.
    local clock = timer.performWithDelay( 1, onDelay,  -1 )
    timer.pause(clock)

    --[[
        Starts counting on the timer.
    ]]--
    instance.start = function()
        timer.resume( clock )
    end

    --[[
        Stops the timer.
    ]]--
    instance.stop = function()
        timer.pause(clock)
    end

    --[[
        Reads the time from the clock.
    ]]--
    instance.read = function()
        return time
    end

    instance.cancelTimer = function()
        timer.cancel( clock )
    end

    return instance
end

return timerClass