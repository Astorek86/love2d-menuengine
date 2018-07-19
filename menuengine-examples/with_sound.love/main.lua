local menuengine = require "menuengine"


-- Mainmenu
local mainmenu

-- Entries
local description_entry, othersound_entry

-- Soundfiles
local sound_success, sound_move

-- Is Sound On?
local isSoundOn = false

-- Function to switch Sound On and Off
local function switch_sound()
    isSoundOn = not isSoundOn
    if isSoundOn then
        description_entry.text = "Disable Move-Sound"  -- Change Entry-Text
        mainmenu:setSndMove(sound_move)  -- set Move-Sound for every Entry
        othersound_entry.sndMove = sound_success -- set Move-Sound for that one special Entry
    else
        description_entry.text = "Enable Move-Sound"  -- Change Entry-Text
        mainmenu:setSndMove(nil)  -- disable Move-Sound for every Entry
    end
    return isSoundOn
end



function love.load()
    -- Set Window
    love.window.setMode(600,400)
    love.graphics.setFont(love.graphics.newFont(20))
    -- Set Sounds
    sound_success = love.audio.newSource("accept.wav", "static")
    sound_move = love.audio.newSource("pick.wav", "static")

    -- Set Mainmenu and first Entry
    mainmenu = menuengine.new(200,100)
    description_entry = mainmenu:addEntry("Enable Move-Sound", switch_sound)  -- Switch Sound every time this Entry is Selected.

    -- Add a few Dummy-Entries just for Demonstration
    for i=1,5 do
        mainmenu:addEntry("Nothing")
    end

    -- New Entry
    othersound_entry = mainmenu:addEntry("I have another Move-Sound")

    -- Some more Dummy-Entries...
    for i=1,5 do
        mainmenu:addEntry("Nothing")
    end

    -- set Success-Sound for every Entry
    mainmenu:setSndSuccess(sound_success)
end


function love.update(dt)
    mainmenu:update()
end


function love.draw()
    love.graphics.clear()
    mainmenu:draw()
end


function love.keypressed(key, scancode, isrepeat)
    menuengine.keypressed(scancode)

    if scancode == "escape" then
        love.event.quit()
    end
end


function love.mousemoved(x, y, dx, dy, istouch)
    menuengine.mousemoved(x, y)
end
