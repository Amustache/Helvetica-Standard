-- Load scenes and start with intro
local SceneryInit = require("scenery")
local scenery = SceneryInit("intro")

Talkies = require("talkies")
-- Default configuration for Talkies
Talkies.textSpeed = "fast"
Talkies.talkSound = love.audio.newSource("sfx/typeSound.wav", "static")
Talkies.optionSwitchSound = love.audio.newSource("sfx/optionSwitch.wav", "static")
Talkies.indicatorCharacter = ">"
Talkies.optionCharacter = "> "
Talkies.inlineOptions = true
Talkies.font = love.graphics.newFont("Pixel UniCode.ttf", 32)
Talkies.padding = 32
Talkies.thickness = 1
Talkies.rounding = 10
Talkies.titleColor = {1, 1, 1}
Talkies.titleBackgroundColor = nil
Talkies.titleBorderColor = nil
Talkies.messageColor = {1, 1, 1}
Talkies.messageBackgroundColor = {0, 0, 0, 0.8}
Talkies.messageBorderColor = nil
Talkies.typedNotTalked = false
Talkies.pitchValues = {0.7, 0.8, 1.0, 1.2, 1.3}
Talkies.height = 128

-- Pixel scaling
love.graphics.setDefaultFilter("nearest")
SCALING = 4

function love.load()
    scenery:load()
end

function love.keypressed(key)
    if key == "escape" then love.event.quit() end
    -- if key == "c" then Talkies.clearMessages() end
    -- if key == "m" then Talkies.say("Title", {"Message one", "two", "and three..."}, {onstart=function() end}) end
    if key == "space" or key == 'return' or key == 'e' or key == 'z' then Talkies.onAction() end
    if key == "up" then Talkies.prevOption() end
    if key == "down" then Talkies.nextOption() end
end
  
function love.update(dt)
    scenery:update(dt)
    Talkies.update(dt)
end

function love.draw()
    scenery:draw()
    Talkies.draw()
end
