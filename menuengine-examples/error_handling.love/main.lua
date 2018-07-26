local menuengine = require "menuengine"


-- Mainmenu
local mainmenu

 -- ----------

function love.load()
    love.window.setMode(600,400)
    love.graphics.setFont(love.graphics.newFont(14))

    -- CHANGE ME to "true" -- CHANGE ME to "true" -- CHANGE ME to "true" -- CHANGE ME to "true" --
    menuengine.stop_on_nil_functions = false

    mainmenu = menuengine.new(10,100)
    mainmenu:addEntry("open \"main.lua\", set 'stop_on_nil_functions' to 'true' and see, what happens", i_am_a_nonexistent_function)
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
