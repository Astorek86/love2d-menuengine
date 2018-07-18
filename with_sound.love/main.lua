require "menuengine"

function love.load()
    
    love.window.setMode(600,400)
    love.graphics.setFont(love.graphics.newFont(20))
    
    mainmenu = menuengine.new(200,100)
    description = mainmenu:addEntry("Disable Move-Sound", change_sound)
    
    sound_success = love.audio.newSource("accept.wav", "static")
    sound_move = love.audio.newSource("pick.wav", "static")
    
    -- A few Dummy-Entries just for Demonstration
    for i=1,5 do
        mainmenu:addEntry("Nothing")
    end
    
    other_soundentry = mainmenu:addEntry("I have another Move-Sound")
    for i=1,5 do  -- more Dummy-Entries
        mainmenu:addEntry("Nothing")
    end
    
    -- set Success-Sound for every Entry...
    mainmenu:setSndSuccess(sound_success)
    -- ... but change it for this special Entry
    other_soundentry.sndMove = sound_success
    
    sndMove = sound_move
    change_sound()
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

function change_sound()
    sound = not sound
    if sound then
        description.text = "Disable Move-Sound"  -- Change Entry-Text
        mainmenu:setSndMove(sndMove)  -- set Move-Sound for every Entry
        other_soundentry.sndMove = sound_success
    else
        description.text = "Enable Move-Sound"  -- Change Entry-Text
        -- disable Move-Sound for every Entry
        mainmenu:setSndMove(nil)
    end
end
