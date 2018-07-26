local menuengine = require "menuengine"

-- Menus
local mainmenu, menu_one, menu_two, menu_three


-- Functions to change Mode
local function menu_main()
    menuengine.disable()  -- Disable every Menu...
    mainmenu:setDisabled(false)  -- ...but enable Mainmenu.
    mainmenu.cursor = 1  -- reset Selection to the first Entry
end

local function menu_one()
    menuengine.disable()  -- Disable every Menu...
    menu_one:setDisabled(false)  -- ...but enable Firstmenu.
    menu_one.cursor = 1  -- reset Selection to the first Entry
end

local function menu_two()
    menuengine.disable()  -- Disable every Menu...
    menu_two:setDisabled(false)  -- ...but enable Secondmenu.
    MODE = 2
    menu_two.cursor = 1  -- reset Selection to the first Entry
end

local function menu_three()
    menuengine.disable()  -- Disable every Menu...
    menu_three:setDisabled(false)  -- ...but enable Thirdmenu.
    menu_three.cursor = 1  -- reset Selection to the first Entry
end

 -- ----------

function love.load()
    love.window.setMode(600,400)
    love.graphics.setFont(love.graphics.newFont(20))

    -- Set Menu-Wide Settings; every Entry will affected by this.
    menuengine.settings.sndMove = love.audio.newSource("pick.wav", "static")
    menuengine.settings.sndSuccess = love.audio.newSource("accept.wav", "static")

    mainmenu = menuengine.new(200,100)
    mainmenu:addEntry("Sub-Menu One", menu_one)
    mainmenu:addEntry("Sub-Menu Two", menu_two)
    mainmenu:addEntry("Sub-Menu Three", menu_three)

    menu_one = menuengine.new(200,100)
    menu_one:addEntry("Entry One of Sub-Menu One")
    menu_one:addEntry("Entry Two of Sub-Menu One")
    menu_one:addEntry("Entry Three of Sub-Menu One")
    menu_one:addEntry("<-- Go back to Mainmenu (1)", menu_main)

    menu_two = menuengine.new(200,100)
    menu_two:addEntry("Entry One of Sub-Menu Two")
    menu_two:addEntry("Entry Two of Sub-Menu Two")
    menu_two:addEntry("Entry Three of Sub-Menu Two")
    menu_two:addEntry("<-- Go back to Mainmenu (2)", menu_main)

    menu_three = menuengine.new(200,100)
    menu_three:addEntry("Entry One of Sub-Menu Three")
    menu_three:addEntry("Entry Two of Sub-Menu Three")
    menu_three:addEntry("Entry Three of Sub-Menu Three")
    menu_three:addEntry("<-- Go back to Mainmenu (3)", menu_main)
    
    -- Disable Every Menu, then activate Mainmenu
    menuengine.disable()
    mainmenu:setDisabled(false)
end


function love.update(dt)
    menuengine.update()
end


function love.draw()
    love.graphics.clear()
    menuengine.draw()
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
