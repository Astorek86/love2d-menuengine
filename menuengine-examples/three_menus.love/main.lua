require "menuengine"

function love.load()
    
    MODE = 0
    
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
end


function love.update(dt)
    if MODE == 0 then
        mainmenu:update()
    elseif MODE == 1 then
        menu_one:update()
    elseif MODE == 2 then
        menu_two:update()
    elseif MODE == 3 then
        menu_three:update()
    end
end


function love.draw()
    love.graphics.clear()
    if MODE == 0 then
        mainmenu:draw()
    elseif MODE == 1 then
        menu_one:draw()
    elseif MODE == 2 then
        menu_two:draw()
    elseif MODE == 3 then
        menu_three:draw()
    end
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


function menu_main()
    MODE = 0
end

function menu_one()
    MODE = 1
end

function menu_two()
    MODE = 2
end

function menu_three()
    MODE = 3
end
