local menuengine = {}
menuengine.VERSION = "0.9.9e Beta"


-- Defaults
menuengine.settings = {
    disabled = false,
    target = nil,  -- WARNING: Deprecrated
    args = nil,
    colorSelected = {.8,.4,.4},
    colorNormal = {1, 1, 1},
    symbolSelectedBegin = "[ ",
    symbolSelectedEnd = " ]",
    normalSelectedBegin = "  ",
    normalSelectedEnd = "",
    sndMove = nil,
    sndSuccess = nil,
    mouseDisabled = false,
}


-- Collect every menu
local menus = {}


-- Keyboard-Handling. Add your own Scancodes here if you want.
local KEY = {}
KEY.up = {scancodes={"up", "w", "kp8"}}
KEY.down = {scancodes={"down", "s", "kp2", "kp5"}}
KEY.accept = {scancodes={"return", "kpenter", "kp0", "space"}}


-- Give every KEY a "pressed"-value
local k,v
for k, v in pairs(KEY) do
    KEY[k].pressed = false
end


-- Mouse
menuengine.mouse_x = 0
menuengine.mouse_y = 0
menuengine.clicked = false


-- Error-Handling if nil-Function is there. WARNING: On future Releases, This Setting will be set to "true".
menuengine.stop_on_nil_functions = false



-- Constructor
function menuengine.new(x, y, font, space)
    local self = {}

    -- These four Variables should probably NOT be edited from the "outside".
    self.entries = {}
    self.cursor = 1
    self.x = x or 0
    self.y = y or 0

    -- Setting up Defaults. TODO: There must be a better way to do this...
    self.disabled = menuengine.settings.disabled
    self.target = menuengine.settings.target  -- WARNING: Deprecated
    self.colorSelected = menuengine.settings.colorSelected
    self.colorNormal = menuengine.settings.colorNormal
    self.symbolSelectedBegin = menuengine.settings.symbolSelectedBegin
    self.symbolSelectedEnd = menuengine.settings.symbolSelectedEnd
    self.normalSelectedBegin = menuengine.settings.normalSelectedBegin
    self.normalSelectedEnd = menuengine.settings.normalSelectedEnd
    self.sndMove = menuengine.settings.sndMove
    self.sndSuccess = menuengine.settings.sndSuccess
    self.mouseDisabled = menuengine.settings.mouseDisabled
    self.args = menuengine.settings.args

    -- Add Entry
    function self:addEntry(text, func, args, font, colorNormal, colorSelected)
        if menuengine.stop_on_nil_functions and func == nil and self.target == nil then  -- WARNING: "target" Deprecrated
            error("menuengine: nil is not a function")
        else
            self.entries[#self.entries+1] = {}
            self.entries[#self.entries].text = text
            self.entries[#self.entries].x = x
            self.entries[#self.entries].y = y + (#self.entries-1) * self.space
            self.entries[#self.entries].font = font or self.font
            self.entries[#self.entries].func = func or function()end
            self.entries[#self.entries].args = args or self.args
            self.entries[#self.entries].colorNormal = colorNormal or self.colorNormal
            self.entries[#self.entries].colorSelected = colorSelected or self.colorSelected

            -- Other Options
            self.entries[#self.entries].symbolSelectedBegin = self.symbolSelectedBegin
            self.entries[#self.entries].symbolSelectedEnd = self.symbolSelectedEnd
            self.entries[#self.entries].normalSelectedBegin = self.normalSelectedBegin
            self.entries[#self.entries].normalSelectedEnd = self.normalSelectedEnd
            self.entries[#self.entries].sndMove = self.sndMove
            self.entries[#self.entries].sndSuccess = self.sndSuccess
            self.entries[#self.entries].disabled = self.disabled

            return self.entries[#self.entries]
        end
    end

    -- Move Position
    function self:movePosition(newx, newy)
        self.x = newx
        self.y = newy

        local i
        for i=1,#self.entries do
            self.entries[i].x = newx
            self.entries[i].y = newy + (i-1) * self.space
        end
    end

    -- Set Space for all Entries
    function self:setSpace(space)
        self.space = space or self.font:getHeight()
    end

    -- Change Font of every existing Entry
    function self:setFont(font, space)
        font = font or love.graphics.getFont()
        local i
        for i=1,#self.entries do
            self.entries[i].font = font
        end
        self.font = font
        self:setSpace(space)
    end

    -- love.draw
    function self:draw()
        -- save old font & color
        local oldFont, r,g,b,a
        oldFont = love.graphics.getFont()
        r,g,b,a = love.graphics.getColor()

        local i
        for i=1,#self.entries do
            if not self.entries[i].disabled then
                love.graphics.setFont(self.entries[i].font)
                if self.cursor == i and #self.entries[i].text > 0 then
                    love.graphics.setColor(self.entries[i].colorSelected)
                    love.graphics.print(self.entries[i].symbolSelectedBegin..self.entries[i].text..self.entries[i].symbolSelectedEnd,self.entries[i].x,self.entries[i].y)
                else
                    love.graphics.setColor(self.entries[i].colorNormal)
                    love.graphics.print(self.entries[i].normalSelectedBegin..self.entries[i].text..self.entries[i].normalSelectedEnd,self.entries[i].x,self.entries[i].y)
                end
            end
        end
        -- revert old font & color
        love.graphics.setFont(oldFont)
        love.graphics.setColor(r,g,b,a)
    end

    -- Add Separator
    function self:addSep()
        return self:addEntry("", function()end)
    end
    
    -- Set Default args
    function self:setArgs(args)
        local i
        for i=1,#self.entries do
            self.entries[i].args = args
        end
    end

    -- Disable this Menu; "draw" and "update" will have no effects.
    function self:setDisabled(value)
        local i
        for i=1,#self.entries do
            self.entries[i].disabled = value
        end
        self.disabled = value
    end

    -- Enable Mouse
    function self:mouseEnable()
        self.mouseDisabled = false
    end

    -- Disable Mouse
    function self:mouseDisable()
        self.mouseDisabled = true
    end

    function self:setColorNormal(color)
        local i
        for i=1,#self.entries do
            self.entries[i].colorNormal = color
        end
        self.colorNormal = color
    end

    function self:setColorSelected(color)
        local i
        for i=1,#self.entries do
            self.entries[i].colorSelected = color
        end
        self.colorSelected = color
    end

    -- Moves the Cursor
    function self:moveCursor(d)
        self.cursor = self.cursor + d
        if self.cursor < 1 then
            self.cursor = #self.entries
        elseif self.cursor > #self.entries then
            self.cursor = 1
        end
        if #self.entries[self.cursor].text == 0 or self.entries[self.cursor].disabled then
            self:moveCursor(d)
        elseif self.entries[self.cursor].sndMove ~= nil then
            self.entries[self.cursor].sndMove:stop()
            self.entries[self.cursor].sndMove:play()
        end
    end

    -- love.update
    function self:update()
        if not self.disabled then
            if KEY.up.pressed then
                KEY.up.pressed = false
                self:moveCursor(-1)
            end
            if KEY.down.pressed then
                KEY.down.pressed = false
                self:moveCursor(1)
            end
            if KEY.accept.pressed then
                KEY.accept.pressed = false
                self:_finish()
            end

            if not self.mouseDisabled then

                for i=1,#self.entries do
                    -- React on Cursor-Position, which needs to collect the Length of every Text-Elements like "normalSelectedBegin", "normalSelectedEnd" etc... TODO: Better readable, please?^^
                    if not self.entries[i].disabled and menuengine.mouse_y > self.entries[i].y and menuengine.mouse_y < self.entries[i].y + self.space and #self.entries[i].text > 0 and
                      menuengine.mouse_x > self.entries[i].x and menuengine.mouse_x < self.entries[i].x + self.entries[i].font:getWidth(self.entries[i].text..self.normalSelectedBegin..self.normalSelectedEnd..self.symbolSelectedEnd) then
                        if self.cursor ~= i then
                            self.cursor = i
                            if not self.entries[i].disabled and self.entries[i].sndMove ~= nil then
                                self.entries[i].sndMove:stop()
                                self.entries[i].sndMove:play()
                            end
                        end
                        if not self.entries[i].disabled and love.mouse.isDown(1) and not menuengine.clicked then
                            self:_finish()
                            menuengine.clicked = true
                        -- prevents Clicking every Frame
                        elseif not love.mouse.isDown(1) then
                            menuengine.clicked = false
                        end
                    end
                end
            end

        end

    end

    -- This function should probably NOT be called from the "outside".
    function self:_finish()
        if not self.entries[self.cursor].disabled then
            self.entries[self.cursor].func(self.entries[self.cursor].args)
            if self.entries[self.cursor].sndSuccess ~= nil then
                self.entries[self.cursor].sndSuccess:stop()
                self.entries[self.cursor].sndSuccess:play()
            end
              -- WARNING: Deprecrated
            if self.target ~= nil then
                self.target(self.cursor, self.entries[self.cursor].args)
            end
        end
    end

    function self:setSndMove(snd)
        local i
        for i=1,#self.entries do
            self.entries[i].sndMove = snd
        end
        self.sndMove = snd
    end

    function self:setSndSuccess(snd)
        local i
        for i=1,#self.entries do
            self.entries[i].sndSuccess = snd
        end
        self.sndSuccess = snd
    end

    self:setFont(font, space)
    table.insert(menus, self)
    return self

end


-- Need to check Inputs
function menuengine.keypressed(scancode)
    local k, _, i
    for k, _ in pairs(KEY) do
        for i=1,#KEY[k].scancodes do
            if scancode == KEY[k].scancodes[i] then
                KEY[k].pressed = true
            end
        end
    end
end


-- Need to check Mouse-Inputs
function menuengine.mousemoved(x, y)
    menuengine.mouse_x = x
    menuengine.mouse_y = y
end


-- Draw every Menu
function menuengine.draw()
    local i
    for i=1,#menus do
        menus[i]:draw()
    end
end

-- Updates every Menu
function menuengine.update()
    local i
    for i=1,#menus do
        menus[i]:update()
    end
end


-- Disable EVERY Menu
function menuengine.disable()
    local i
    for i=1,#menus do
        menus[i]:setDisabled(true)
    end
end


-- Enable EVERY Menu
function menuengine.enable()
    local i
    for i=1,#menus do
        menus[i]:setDisabled(false)
    end
end

-- TODO: Everything after that is not documented yet, I don't know if they are necessary. Maybe they will be removed...


-- Set Font for EVERY Menu
function menuengine.setFont(font, space)
    local i
    for i=1,#menus do
        menus[i]:setFont(font, space)
    end
end


-- Set Space for EVERY Menu
function menuengine.setSpace(space)
    local i
    for i=1,#menus do
        menus[i]:setSpace(space)
    end
end


-- Add Entry on EVERY Menu (why should anyone use this?)
function menuengine.addEntry(entry, func)
    local i
    for i=1,#menus do
        menus[i]:addEntry(entry, func)
    end
end


-- Enable Mouse for EVERY Menu
function menuengine.mouseEnable()
    local i
    for i=1,#menus do
        menus[i]:mouseEnable()
    end
end


-- Disable Mouse for EVERY Menu
function menuengine.mouseDisable()
    local i
    for i=1,#menus do
        menus[i]:mouseDisable()
    end
end

return menuengine
