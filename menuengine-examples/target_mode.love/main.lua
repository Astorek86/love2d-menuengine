local menuengine = require "menuengine"
menuengine.stop_on_nil_functions = true

local text = "Nothing was selected."


-- Mainmenu
local mainmenu

-- Function to start after User selects something
local function mainmenu_finish(entrypoint)
    if entrypoint == 1 then
        text = "Start Game was selected!"
    elseif entrypoint == 2 then
        text = "Options was selected!"
    elseif entrypoint == 4 then  -- 4, not 3, because of "addSep()"
        text = "Quit Game was selected!"
    end
end

 -- ----------

function love.load()
    love.window.setMode(600,400)
    love.graphics.setFont(love.graphics.newFont(20))

    mainmenu = menuengine.new(200,100)
    mainmenu.target = mainmenu_finish  -- enable Target-Mode.
    mainmenu:addEntry("Start Game")
    mainmenu:addEntry("Options")
    mainmenu:addSep()
    mainmenu:addEntry("Quit Game")
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
