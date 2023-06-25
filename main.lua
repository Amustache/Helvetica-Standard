-- Debug
START_SCENE = "intro"

-- Load scenes and start with scene room
local SceneryInit = require("libs.scenery")
local scenery = SceneryInit(START_SCENE)

-- Transition parameters

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
        {name = "end_day_1", from = "phone_win", to = "end_day_1"},
        -- Day 2
        {name = "start_day_2", from = "end_day_1", to = "cafe"},
        {name = "travel_to_cabane", from = "cafe", to = "travel_cabane"},
        {name = "minigame_labyrinthe", from = "travel_cabane", to = "labyrinthe"},
        {name = "labyrinthe_win", from = "labyrinthe", to = "labyrinthe_win"},
        {name = "cabane_ext", from = "labyrinthe_win", to = "cabane_ext"},
        {name = "cabane_int", from = "cabane_ext", to = "cabane_int"},
        {name = "back_to_room", from = "cabane_int", to = "room_2"},
        {name = "end_day_2", from = "room_2", to = "end_day_2"},
    },
    callbacks = {
        -- callback = function(self, event, from, to) end,
        onstatechange = function(self, event, from, to)
            print("## Current state: " .. to)
            if transition == "" then
                scenery.setScene(to)
            end 
        end,
        onend_day = function(self, event, from, to)
            transition = to
        end
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
current_bg = nil  -- Table
current_bg_i = 1  -- Iteration
minigame_playing = ""
key_pressed = nil
transition = ""

-- Global load
function love.load()
    scenery:load()

    -- Transition
    timer = 0
    alpha = 0
    fadein  = 2
    display = 4
    fadeout = 6
    splashScreen = love.graphics.newImage("img/intro__1.png")
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
  
gdt = 0
function love.update(dt)
    gdt = gdt + dt

    scenery:update(dt)
    Talkies.update(dt)

    -- Transition
    if transition ~= "" then
        timer = timer + dt
        if 0 < timer and timer < fadein then
            alpha = timer / fadein
        end
        if fadein < timer and timer < display then
            alpha = 1
            scenery.setScene(transition)
        end
        if display < timer and timer < fadeout then
            alpha = 1 - ((timer - display) / (fadeout - display))
        end
        if timer > fadeout then
            transition = ""
            timer = 0
        end
    end

    if gdt > 1 then
        gdt = 0
        current_bg_i = current_bg_i + 1
        if current_bg_i > #current_bg then
            current_bg_i = 1
        end
    end
end

function love.draw()
    -- Background
    love.graphics.draw(current_bg[current_bg_i], 0, 0, 0, SCALING)

    scenery:draw()
    Talkies.draw()

    -- Transition
    if transition ~= "" then
        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.draw(splashScreen, 0, 0, 0, SCALING)
        love.graphics.setColor(1, 1, 1)
    end
end
