require "menuengine"

function love.load()
    love.window.setMode(600,400)
    love.graphics.setFont(love.graphics.newFont(20))
    
    mainmenu = menuengine.new(200,100)
    leftmove_entry = mainmenu:addEntry("Click = Move me to left", move_left)
    rightmove_entry = mainmenu:addEntry("Click = Move me to right", move_right)
    mainmenu:addEntry("-- Restore Layout --", restore)
    downmove_entry = mainmenu:addEntry("Click = Move me to down", move_down)
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

function move_left()
    leftmove_entry.x = leftmove_entry.x - 10
end

function move_right()
    rightmove_entry.x = rightmove_entry.x + 10
end

function move_down()
    downmove_entry.y = downmove_entry.y + 10
end

function restore()
    mainmenu:movePosition(200,100)
end
