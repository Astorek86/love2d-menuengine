# love2d-menuengine for LÖVE 11.1
A Script to create a Menu in Love2D / LÖVE, navigate-able through mouse and keyboard.

For a quick view, scroll down to see the Examples. It is - in my opinion - really easy to use^^.

# API Reference


## Constructor
```Lua
menu = menuengine.new([x], [y], [font], [space])
```
Returns an **menu**-object (see below).

`x (0)`
X-Position. Optional but recommended.

`y (0)`
Y-Position. Optional but recommended.

`font (love.graphics.getFont())`
Font. If not Font is configured, it will use the current Default-Font. Optional.

`space (self.font:getHeight())`
Spaces between Entries. Usually, it should be autodetected by the Font you are using, but sometimes it might be better to set this explicitly. Optional.
___
## Add Entries
You can add Entries through the `menu`-Object:
```Lua
entry = menu:addEntry(text, [func], [font], [colorNormal], [colorSelected])
```
Returns an **entry**-object (see below).

`text`
Displayed Text. Required.

`func`
Function that will be called, if the User selects this Menupoint. If set to **nil**, nothing will happend (except you set the menu:__target__ to a function (see below, "Example 2")). Optional.

`font`
Selected Font-Object for this Entry. Optional.

`colorNormal ({1, 1, 1, nil})`
RGBA-Values. If Entry is not highlighted, it will stay in that Color. Optional.

`colorSelected ({.8, .4, .4})`
RGBA-Values. If Entry is highlighted, it will stay in that Color. Optional.
___
## Add empty Space
Just write
```Lua
menu:addSep()
```
Returns nothing, no Parameters.
___
## `Entry`-Objects
**entry**-Objects (created through __addEntry__ from a `menu`-Object) have only attributes, no methods.

`text`
text as String.

`x`, `y`
X and Y as Integer. Text-Position.

`font`
Font as Font-Object. Default-Font if not configured.

`func`
function as callable Function. **nil** if not configured.

`symbolSelectedBegin`, `symbolSelectedEnd`, `normalSelectedBegin`, `normalSelectedEnd`
Strings to add on Begin/End of the Text ("symbol..." if selected, "normal..." if not selected).

For Example, if "text" is "Menuentry", "symbolSelectedBegin" is = "[" and "symbolSelectedEnd" is "]", than it will show up as "[Menuentry]" if it's selected by the User.

`sndMove`, `sndSuccess`
Sounds that will be played if User selects this Entry.

`disabled`
if **true**, Entry won't show up and won't react by Selecting.
___
## Settings
There are three so-called __places__ where the Settings are stored.
___
### Place 1: Menu-Wide "menuengine.settings"
Every Default-Option is stored on the table "menuengine.settings".
___
### Place 2: `Menu`-Object
Every new Menu created by **menuengine.new** will adopt settings from the Menu-Wide "menuengine.settings".

Every `menu`-Object offers Methods and Attributes to change Settings of **every** entry that was created by it, but will not affect Settings in **menuengine.new**.
___
### Place 3: `Entry`-Object
Every new Entry created by **addEntry** will adopt settings from the "menu"-Object that's created by it. Every Entry offers Attributes, but will not affect Settings on the `menu`-Object (and of course it will not affect Settings on **menuengine.settings**).
___
## `Menu`-Methods (other than "addEntry" and "addSep")

Create a `menu`-Object by using **menuengine.new**. Be careful, these Methods are changing every Entry contains by the `menu`-Object. It also affects future `Entry`-Objects as well!
___
```Lua
menu:movePosition(newx, newy)
```
Moves and Orders every Entry, that contains this object.

`newx`, `newy`
Integer-Values, X- and Y-Coordinate on the upper left. Required.
___
```Lua
menu:setFont(font, space)
```
Changes Font and Space for every Entry, that contains this object.

`font`
Font-Object. Required.

`space (font:getWidth())`
Integer. Sets the Spaces between every Entry. Optional.

After using **setFont**, it may be required to call **movePosition** to rearrange Entries.
___
```Lua
menu:setDisabled(value)
```
Disables every Entry. Draw- and Update-States will have no effects, and Entries won't shown as long as they are disabled.

`value`
Boolean. Required.
___
```Lua
menu:setColorNormal(color)
```
Set the Color of every Entry, that contains this object. Does affect Entries if they are not selected.

`color`
Table of RGBA-Values. Required.
___
```Lua
menu:setColorSelected(color)
```
Set the Color of every Entry, that contains this object. Does affect Entries if they are selected.

`color`
Table of RGBA-Values. Required.
___
```Lua
menu:moveCursor(d)
```
Moves the Cursor in the given Direction.

`d`
Integer. Direction; "-1" means "up", "1" means "down".
___
```Lua
menu:setSndMove(sound)
```
Set the Sound of every Entry that will be played if the User moves through the Entries.

`sound`
Sound-Object. If **nil**, no sound will be played.
___
```Lua
menu:setSndSuccess(sound)
```
Set the Sound of every Entry that will be played if the User moves through the Entries.

`sound`
Sound-Object. If **nil**, no sound will be played.
___
## `Menu`-Attributes
There's only two Attributes.

`menu.target`
Defaults to **nil**. If set, it will called as a Function after the User selects an Entry (see below, "Example 2").

`menu.cursor`
Integer. Represent actual Cursor-Position.
==Be very careful of setting this Variable. It is useful for setting the Cursor in a Pre-defined Value (for example, "1" is always the first Entry), but it will not check on Errors. As say, be very careful with that Attribute!==
___
# Examples
___
## Example 1
```Lua
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
    mainmenu:draw()  -- required
end

function love.keypressed(key, scancode, isrepeat)
    menuengine.keypressed(scancode)  -- required
    
    if scancode == "escape" then
        love.event.quit()
    end
end

-- required to check Mouse-Input
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
```
___
### Example 2
Example with **target**-Usage.
```Lua
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
```
___
### Example 3
Example using **love.graphics.scale**. You need to scale Mouse-Coordinates before calling **menuengine.mousemoved**.
```Lua
require "menuengine"

function love.load()
    
    INTERNAL_RES = {}
    INTERNAL_RES.x = 256
    INTERNAL_RES.y = 144
    
    EXTERNAL_RES = {}
    EXTERNAL_RES.x = 640
    EXTERNAL_RES.y = 360
    
    love.window.setMode(EXTERNAL_RES.x, EXTERNAL_RES.y)
    love.graphics.setFont(love.graphics.newFont(12))
    
    mainmenu = menuengine.new(20,20)
    mainmenu:addEntry("Mouse works, as")
    mainmenu:addEntry("you can see, on")
    mainmenu:addEntry("scaled Screens too!")
end

function love.update(dt)
    mainmenu:update()
end

function love.draw()
    -- Scale Resolution
    love.graphics.scale(love.graphics.getWidth() / INTERNAL_RES.x, love.graphics.getHeight() / INTERNAL_RES.y)
    
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
    -- Scale Mouse Position
    x = x * (INTERNAL_RES.x / love.graphics.getWidth() )
    y = y * (INTERNAL_RES.y / love.graphics.getHeight() )
    menuengine.mousemoved(x, y)
end
```
___
### Known Issues
  * It's possible to show more than one Menu at the same time (that's a good thing), but unfortunately it is not possible to change Keyboard-Layout for each Menu, means that **every** active Menu will react if a defined Key is pressed. The only way to prevent this is to not implement "menuengine.keypressed" in "love.keypressed".
