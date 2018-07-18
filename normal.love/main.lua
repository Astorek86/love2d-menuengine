require "menuengine"

function love.load()
    text = "Nothing was selected."
    
    love.window.setMode(600,400)
    love.graphics.setFont(love.graphics.newFont(20))
    
    mainmenu = menuengine.new(200,100)
    mainmenu:addEntry("Start Game", start_game)
    mainmenu:addEntry("Options", options)
    mainmenu:addSep()
    mainmenu:addEntry("Quit Game", quit_game)
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
function start_game()
    text = "Start Game was selected!"
end

-- Options
function options()
    text = "Options was selected!"
end


-- Quit Game
function quit_game()
    text = "Quit Game was selected!"
end
