require "menuengine"

function love.load()
    love.window.setMode(600,400)
    love.graphics.setFont(love.graphics.newFont(20))

    mainmenu = menuengine.new(200,100)
    entry_one = mainmenu:addEntry("Hide me", hide_first_entry)
    mainmenu:addEntry("Hide me too", hide_first_entry)
    mainmenu:addEntry("show first Entry if hidden", show_first_entry)
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

function hide_first_entry()
    entry_one.disabled = true
end

function show_first_entry()
    entry_one.disabled = false
end

function show_all_entries()
    mainmenu:setDisabled(false)
end
