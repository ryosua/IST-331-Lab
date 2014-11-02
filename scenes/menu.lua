local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- Modules
local widget = require "widget"
local UI = require "modules.UI"



-- -------------------------------------------------------------------------------


-- "scene:create()"
function scene:create( event )

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.

    local sceneGroup = self.view

    -- Button Options
    local tapExperimentButtonOptions = UI.newDefaultButtonOptions()
    tapExperimentButtonOptions.label = "Tap Experiment"

    local keystrokeExperimentButtonOptions = UI.newDefaultButtonOptions()
    keystrokeExperimentButtonOptions.label = "Keystroke Experiment"
    keystrokeExperimentButtonOptions.top = tapExperimentButtonOptions.top + 50

    -- Create buttons.
    local tapExperimentButton = widget.newButton( tapExperimentButtonOptions )
    tapExperimentButton.scene = "scenes.tapExperiment"

    local keystrokeExperimentButton = widget.newButton( keystrokeExperimentButtonOptions )
    keystrokeExperimentButton.scene = "scenes.keystrokeExperiment"
    
    -- Add to scene group
    sceneGroup:insert( tapExperimentButton )
    sceneGroup:insert( keystrokeExperimentButton )
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