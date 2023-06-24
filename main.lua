-- Debug
START_SCENE = "labyrinthe"

-- Load scenes and start with scene room
local SceneryInit = require("libs.scenery")
local scenery = SceneryInit(START_SCENE)

-- Finite state machine for ease of use
local machine = require('libs.statemachine')

fsm = machine.create({
    initial = START_SCENE,
    events = {
        -- Introduction
        {name = "intro", from = "intro", to = "room"},
        -- Day 1
        {name = "minigame_phone", from = "room", to = "phone"},
        {name = "phone_win", from = "phone", to = "phone_win"},
        {name = "end_day", from = "phone_win", to = "chapitre"},
        -- Day 2
        {name = "enter_cafe", from = "chapitre", to = "cafe"},
        {name = "travel_to_cabane", from = "cafe", to = "travel_cabane"},
        {name = "minigame_labyrinthe", from = "travel_cabane", to = "labyrinthe"},
        {name = "labyrinthe_win", from = "labyrinthe", to = "labyrinthe_win"},
        {name = "cabane_ext", from = "labyrinthe_win", to = "cabane_ext"},
        {name = "cabane_int", from = "cabane_ext", to = "cabane_int"},
        {name = "back_to_room", from = "cabane_int", to = "room"},
        {name = "end_day", from = "room", to = "chapitre"},
    },
    callbacks = {
        -- callback = function(self, event, from, to) end,
        onstatechange = function(self, event, from, to) scenery.setScene(to) end,
    },
})

-- Dialogues
dialogues = require('libs.dialogue_helper')
Talkies = require("libs.talkies")
require("conf_talkies")

-- Pixel scaling
love.graphics.setDefaultFilter("nearest")
SCALING = 4

-- Globals...
current_bg_name = ""
current_bg = nil
minigame_playing = ""
key_pressed = nil

-- Global load
function love.load()
    scenery:load()
end

-- Global keypressed
function love.keypressed(key)
    key_pressed = key  -- Ew

    if key == "escape" then love.event.quit() end

    if minigame_playing == "" then  -- Dialogue
        if key == "space" or key == 'return' or key == 'e' or key == 'z' then Talkies.onAction() end
        if key == "up" then Talkies.prevOption() end
        if key == "down" then Talkies.nextOption() end
    end
end

-- Global keyreleased
function love.keyreleased(key)
    key_pressed = nil  -- Ew
 end
  
function love.update(dt)
    scenery:update(dt)
    Talkies.update(dt)
end

function love.draw()
    scenery:draw()
    Talkies.draw()
end
