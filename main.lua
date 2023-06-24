-- Globals...
current_bg_name = ""
current_bg = nil
next_scene = nil
dialogues = require('libs.dialogue_helper')
minigame_playing = ""

-- Load scenes and start with intro
local SceneryInit = require("libs.scenery")
local scenery = SceneryInit("phone")

Talkies = require("libs.talkies")
-- Default configuration for Talkies
Talkies.textSpeed = "fast"
Talkies.talkSound = love.audio.newSource("sfx/typeSound.wav", "static")
Talkies.optionSwitchSound = love.audio.newSource("sfx/optionSwitch.wav", "static")
Talkies.indicatorCharacter = ">"
Talkies.optionCharacter = "> "
Talkies.inlineOptions = true
Talkies.font = love.graphics.newFont("fonts/Pixel UniCode.ttf", 32)
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

function minigame_keys_phone(key)
    print("hiii")
    if minigame_playing then
        if key == "space" then print("space") end
        if key == "up" then print("up") end
        if key == "down" then print("down") end
    end
end

function love.keypressed(key)
    if key == "escape" then love.event.quit() end

    if minigame_playing == "" then  -- Dialogue
        -- if key == "c" then Talkies.clearMessages() end
        -- if key == "m" then Talkies.say("Title", {"Message one", "two", "and three..."}, {onstart=function() end}) end
        if key == "space" or key == 'return' or key == 'e' or key == 'z' then Talkies.onAction() end
        if key == "up" then Talkies.prevOption() end
        if key == "down" then Talkies.nextOption() end
    else  -- Minigame
        minigame_keys_phone(key)
    end
end
  
function love.update(dt)
    scenery:update(dt)
    Talkies.update(dt)
end

function love.draw()
    scenery:draw()
    Talkies.draw()
end
