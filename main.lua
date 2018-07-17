require "menuengine"

function love.load()
    text = "Nothing was selected."

    love.window.setMode(600,400)
    love.graphics.setFont(love.graphics.newFont(20))

    mainmenu = menuengine.new(200,100)
    mainmenu:addEntry("Start Game")
    mainmenu:addEntry("Options")
    mainmenu:addSep()
    mainmenu:addEntry("Quit Game")
    mainmenu.target = mainmenu_finish  -- enable Target-Mode.
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


-- Start Game
function mainmenu_finish(entrypoint)
    if entrypoint == 1 then
        text = "Start Game was selected!"
    elseif entrypoint == 2 then
        text = "Options was selected!"
    elseif entrypoint == 4 then  -- 4, not 3, because of "addSep()"
        text = "Quit Game was selected!"
    end
end
