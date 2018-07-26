local menuengine = require "menuengine"

-- colors
local BLUE = {0,0,1}
local LIGHT_BLUE = {0,0,.5}
local RED = {1,0,0}
local LIGHT_RED = {.5,0,0}
local GREEN = {0,1,0}
local LIGHT_GREEN = {0,.5,0}
local WHITE = {1,1,1}
local GRAY = {.5,.5,.5}

-- Mainmenu
local mainmenu

-- Entry for Mainmenu
local give_me_green

-- Function: Set Entry-color - Green
local function change_color()
    give_me_green.colorNormal = GREEN
    give_me_green.colorSelected = LIGHT_GREEN
end

-- Function: Set every Entry-Color - White
local function change_color_of_all()
    mainmenu:setColorNormal(WHITE)
    mainmenu:setColorSelected(GRAY)
end

 -- ----------

function love.load()

    love.window.setMode(600,400)
    love.graphics.setFont(love.graphics.newFont(20))

    mainmenu = menuengine.new(100,100)
    mainmenu:addEntry("I'm green", nil, nil, nil, GREEN, LIGHT_GREEN)
    mainmenu:addEntry("I'm blue", nil, nil, nil, BLUE, LIGHT_BLUE)
    mainmenu:addEntry("I'm red", nil, nil, nil, RED, LIGHT_RED)
    mainmenu:addEntry("I'm white, but marked blue", nil, nil, nil, WHITE, BLUE)
    mainmenu:addEntry("I'm just in default settings")
    give_me_green = mainmenu:addEntry("Click me, and I'm Green", change_color)
    mainmenu:addEntry("Click me, and everything will turn White", change_color_of_all)

end

function love.update(dt)
    mainmenu:update()
end

function love.draw()
    love.graphics.setColor(255,255,255)  -- Reset Color
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
