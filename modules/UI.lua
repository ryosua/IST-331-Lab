--[[
    A module contaiuning UI elements.
]]--

local UI = {}

-- Modules
local composer = require "composer"
local widget = require "widget"

--[[
    Returns a table with application specfic default options for a button widget.
]]--
function UI.newDefaultButtonOptions()

    --[[
        Changes the scene.
    ]]--
    local function changeScene( event )

        if event.phase == "ended" then
            composer.gotoScene(event.target.scene)
        end

    end

    -- Default button options
    local options = {}

    options.left = W/5
    options.top = H/5
    options.id = " buttonID"
    options.label = "Default"
    options.onEvent = changeScene

    return options
end

--[[
    Creates a menu with the text "Back" that changes scene to the menu.
]]--
function UI.newBackToMenuButton()
    -- Opitons
    local backButtonOptions = UI.newDefaultButtonOptions()
    backButtonOptions.label = "Back"
    backButtonOptions.left = 0 - W * .1
    backButtonOptions.top = H * .95

    -- Button
    local backButton = widget.newButton( backButtonOptions )
    backButton.scene = "scenes.menu"

    return backButton
end

return UI