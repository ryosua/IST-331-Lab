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

    local prevFrameTime, currentFrameTime --both nil
    local deltaFrameTime = 0
    local totalTime = 0

    local function enterFrame(e)
        local currentFrameTime = system.getTimer()

        --if this is still nil, then it is the first frame 
        --so no need to perform calculation 
        if prevFrameTime then 
            --calculate how many milliseconds since last frame 
            deltaFrameTime = currentFrameTime - prevFrameTime
         end 
        prevFrameTime = currentFrameTime 
        --this is the total time in milliseconds 
        totalTime = totalTime + deltaFrameTime 

        -- Set the time for the class.
        time = totalTime
    end

    -- Add the runtime listener that will keep track of time in ms.
    Runtime:addEventListener( "enterFrame", enterFrame )
    --timer.pause(clock)

    --[[
        Reads the time from the clock.
    ]]--
    instance.read = function()
        return time
    end

    instance.cancelTimer = function()
        Runtime:removeEventListener ("enterFrame", enterFrame)
        runtimeFunction = nil
    end

    return instance
end

return timerClass