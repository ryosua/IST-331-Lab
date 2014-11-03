local composer = require "composer"

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- Modules
local UI = require "modules.UI"
local timerClass = require "modules.timerClass"

-- Experiment constants + variables
local words = {"the", "quick", "brown", "fox", "jumps", "over", "the", "lazy", "dog"}
local wordIndex = 1
local startTime
local endTime

-- Forward references
local experimentTimer
local textField
local wordToType

--[[
    Returns the keystrokes in a table containing words. Adds in one keystroke per word for hitting the
    enter button.
]]--
local function keystokesIn(list)
    -- Count the "return" keys one for each word. 
    local count = table.getn(list)

    -- For each word in the table.
    for i = 1, table.getn(list) do
        -- Add the letters to the count.
        count = count + string.len(words[i])
    end

    return count
end

local function textListener(e)
    if ( e.phase == "began" ) then

        -- user begins editing text field
        print( e.text )

    elseif ( e.phase == "ended" or e.phase == "submitted" ) then

        -- text field loses focus
        -- do something with defaultField's text
        print( "Submitted text: " .. e.target.text )

        -- If the word is correct (ignoring case).
        if string.lower(e.target.text) == string.lower(words[wordIndex]) then
            -- If there are more words.
            if (wordIndex + 1) <= table.getn(words) then
                -- Advance to the next word.
                wordIndex = wordIndex + 1
                wordToType.text = words[wordIndex]
                -- Clear the text field
                e.target.text = ""
            -- If the experiment is complete
            else 
                -- Get the end time and cancel the timer
                endTime = experimentTimer.read()
                experimentTimer.cancelTimer()

                -- Change to the results scene.
                local options =
                {
                    params = {
                        letters = keystokesIn(words),
                        milliseconds = endTime - startTime,
                    }
                }
                
                composer.gotoScene("scenes.keystrokeResults", options)
            end
        -- The word is incorrect.
        else
            -- Change the text red to indicate a mistake.
            wordToTypes:setFillColor( 1, 0, 0 )
        end

    elseif ( e.phase == "editing" ) then

        print( e.newCharacters )
        print( e.oldText )
        print( e.startPosition )
        print( e.text )

    end
end

-- -------------------------------------------------------------------------------


-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.

    local backButton = UI.newBackToMenuButton()

    local font = native.systemFont
    local fontSize = 18

    local instructionText = display.newText("Type the words as fast as possible" , W * .05, 0, font, fontSize )
    instructionText.anchorX  = 0
    instructionText.anchorY = 0
    instructionText:setFillColor( 1, 1, 1 )

    -- Display the next word to type.
    wordToType = display.newText(words[wordIndex] , W * .5, H * .2, font, fontSize * 3)

    -- Create text field
    textField = native.newTextField( W * .5, H * .3, 180, 30 )

    textField:addEventListener( "userInput", textListener )

    -- The textfield immediately gets focus.
    native.setKeyboardFocus( textField )

    -- Add to scene group
    sceneGroup:insert( backButton )
    sceneGroup:insert( instructionText )
    sceneGroup:insert( wordToType )

    -- Set the time that the experiment was started.
    experimentTimer = timerClass.new()
    startTime = experimentTimer.read()
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

    -- Remove the native text field.
    textField:removeSelf()

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