local menuengine = require "menuengine"

-- Mainmenu
local mainmenu


function love.load()
    love.window.setMode(600,400)
    love.graphics.setFont(love.graphics.newFont(20))

    mainmenu = menuengine.new(200,100)

    local i
    for i=20,10,-1 do
        mainmenu:addEntry("Font-Size: "..i, nil, nil, love.graphics.newFont(i))
    end
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
