local menuengine = require "menuengine"


local text = "Nothing was selected."


-- Mainmenu
local mainmenu

-- Function to start after User selects something
local function mainmenu_finish(entrypoint)
    if entrypoint == 1 then
        text = "Start Game was selected!"
    elseif entrypoint == 2 then
        text = "Options was selected!"
    elseif entrypoint == 3 then
        text = "Quit Game was selected!"
    end
end

 -- ----------

function love.load()
    love.window.setMode(600,400)
    love.graphics.setFont(love.graphics.newFont(20))

    mainmenu = menuengine.new(200,100)
    mainmenu:addEntry("Start Game", mainmenu_finish, 1)  -- call "mainmenu_finish", args = "1"
    mainmenu:addEntry("Options", mainmenu_finish, 2)  -- call "mainmenu_finish", args = "2"
    mainmenu:addSep()
    mainmenu:addEntry("Quit Game", mainmenu_finish, 3)  -- call "mainmenu_finish", args = "3"
end


function love.update(dt)
    mainmenu:update()
end


function love.draw()
    love.graphics.clear()
    love.graphics.print(text)
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
