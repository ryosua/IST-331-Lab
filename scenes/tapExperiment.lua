local composer = require "composer"

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- Modules
local UI = require "modules.UI"
local timerClass = require "modules.timerClass"


-- Initialize the pseudo random number generator with os time
math.randomseed( os.time() )

-- Pop off some random numbers for good measure (Not sure if this does anything, but Lua Doc. says to so...)
math.random(); math.random(); math.random()


-- Forward references
local experimentTimer
local progressDisplay


-- Experiment constants + variables
local NUMBER_OF_TRIALS = 20

local targetsHit = 0


--[[
    Returns a random point on the screen that a given object could be placed.
]]--
local function getRandomPoint(object)
    local point = {}

    point.x = math.random(0,W - object.contentWidth)
    point.y = math.random(0,H - object.contentHeight)

    return point
end

local function onTargetPress(e)
    -- Move the target to a random location
    local randomLocation = getRandomPoint(e.target)
    e.target.x = randomLocation.x
    e.target.y = randomLocation.y

    -- Increment the target count
    targetsHit = targetsHit + 1

    if targetsHit == NUMBER_OF_TRIALS then
        -- Stop and cancel the timer
        experimentTimer.stop()
        local time = experimentTimer.read()
        experimentTimer.cancelTimer()

        -- Change to the results scene.
        local options =
        {
            params = {
                targets = targetsHit,
                milliseconds = time,
            }
        }
        
        composer.gotoScene("scenes.tapResults", options)
    else
        -- Update progress text
        progressDisplay.text = ("Progress: " .. targetsHit .. "/" .. NUMBER_OF_TRIALS)
    end

    

    return true
end

-- -------------------------------------------------------------------------------


-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.

    experimentTimer = timerClass.new()

    local font = native.systemFont
    local fontSize = 20

    local instructionText = display.newText("Tap the target as fast as possible" , W * .05, 0, font, fontSize )
    instructionText.anchorX  = 0
    instructionText.anchorY = 0
    instructionText:setFillColor( 1, 1, 1 )

    progressDisplay = display.newText("Progress: 0/" .. NUMBER_OF_TRIALS, W * .60, H, font, fontSize )
    progressDisplay:setFillColor( 1, 1, 1 )

    -- Create the button that the user must tap.
    local tapButton = display.newImage( "images/concentric.png" )
    tapButton.anchorX = 0
    tapButton.anchorY = 0

    local randomLocation = getRandomPoint(tapButton)
    tapButton.x = randomLocation.x
    tapButton.y = randomLocation.y
    tapButton:addEventListener( "tap", onTargetPress )

    local backButton = UI.newBackToMenuButton()

    -- Add to scene group
    sceneGroup:insert( instructionText )
    sceneGroup:insert( progressDisplay )
    sceneGroup:insert( backButton )
    sceneGroup:insert( tapButton )

    -- Start timing the experiment.
    experimentTimer.start()
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene