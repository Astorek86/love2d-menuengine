local menuengine = require "menuengine"


-- Mainmenu
local mainmenu


-- Entries
local entry_one, entry_two, entry_four


-- Functions to hide Entries
local function hide_first_entry()
    entry_one.disabled = true
end

local function hide_second_entry()
    entry_two.disabled = true
end

local function hide_fourth_entry()
    entry_four.disabled = true
end

local function show_first_entry()
    entry_one.disabled = false
end

local function show_all_entries()
    mainmenu:setDisabled(false)
end

 -- ----------

function love.load()
    love.window.setMode(600,400)
    love.graphics.setFont(love.graphics.newFont(20))

    -- Init Mainmenu
    mainmenu = menuengine.new(200,100)
    
    mainmenu:setSndMove(love.audio.newSource("pick.wav", "static"))
    mainmenu:setSndSuccess(love.audio.newSource("accept.wav", "static"))
    
    entry_one = mainmenu:addEntry("Hide me", hide_first_entry)
    entry_two = mainmenu:addEntry("Hide me too", hide_second_entry)
    mainmenu:addEntry("Hide Entry below me", hide_fourth_entry)
    entry_four = mainmenu:addEntry("show first Entry if hidden", show_first_entry)
    mainmenu:addEntry("show all Entries if hidden", show_all_entries)
    
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
