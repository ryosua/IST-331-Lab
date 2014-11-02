display.setStatusBar( display.HiddenStatusBar )

-- Composer - Corona library for scene management
local composer = require "composer"

-- Global constants
W = display.contentWidth  -- the width of the screen
H = display.contentHeight -- the height of the screen

local function main()
    -- Set composer to recycle on scene change, 
    -- or create a new scene everytime that scene is launched vs simpily hiding the display group.
    composer.recycleOnSceneChange = true

    composer.gotoScene("scenes.menu")

    return
end

main()