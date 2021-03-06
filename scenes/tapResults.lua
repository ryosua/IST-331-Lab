local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- Modules
local UI = require "modules.UI"

-- -------------------------------------------------------------------------------


-- "scene:create()"
function scene:create( event )

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.

    local sceneGroup = self.view

    local font = native.systemFont
    local fontSize = 20

    local resultsText = display.newText("Results" , W * .5, 0, font, fontSize )
    resultsText.anchorX  = 5
    resultsText.anchorY = 0
    resultsText:setFillColor( 1, 1, 1 )

    local timeInMS = event.params.milliseconds/event.params.targets
    local timerInSeconds = timeInMS / 1000

    local timeInMSText = display.newText("Time Per Tap(ms): " .. timeInMS, W * .1, H * .1, font, fontSize * .8 )
    timeInMSText.anchorX  = 0
    timeInMSText.anchorY = 0
    timeInMSText:setFillColor( 1, 1, 1 )

    local timeInSecondsTxt = display.newText("Time Per Tap(s): " .. timerInSeconds, W * .1, timeInMSText.y + 20, font, fontSize * .8 )
    timeInSecondsTxt.anchorX  = 0
    timeInSecondsTxt.anchorY = 0
    timeInSecondsTxt:setFillColor( 1, 1, 1 )

    local backButton = UI.newBackToMenuButton()
    
    -- Add to scene group
    sceneGroup:insert(resultsText)
    sceneGroup:insert(timeInMSText)
    sceneGroup:insert(timeInSecondsTxt)
    sceneGroup:insert(backButton)
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