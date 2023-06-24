-- Load dialogues for that scene
-- Can be multiple dialogues
local script = require('dialogues.sample')

local displayMessageNode

local function nextMessage()
    local node = script:next()
    displayMessageNode(node)
end

local function selectOption(selection)
    local node = script:select(selection)
    displayMessageNode(node)
end

displayMessageNode = function(node)
    if node == nil then
        return -- Erogodic script is over.
    end

    local config = {}
    if node.options then
        config.options = {}
        for i, opt in ipairs(node.options) do
            local onSelect = function()
                selectOption(opt)
            end
            config.options[i] = {opt, onSelect}
        end
    else
        config.oncomplete = nextMessage
    end
    Talkies.say(node.name, node.msg, config)
end

-- State machine
local machine = require('statemachine')

local fsm = machine.create({
    initial = 'green',
    events = {{
        name = 'warn',
        from = 'green',
        to = 'yellow'
    }, {
        name = 'panic',
        from = 'yellow',
        to = 'red'
    }, {
        name = 'calm',
        from = 'red',
        to = 'yellow'
    }, {
        name = 'clear',
        from = 'yellow',
        to = 'green'
    }}
})

-- Scene
local scene = {}

function scene:load()
    -- Background
    bg = love.graphics.newImage("placeholders/chamber_bg.png")

    -- Characters
    main_char = love.graphics.newImage("placeholders/main_idle.png")
    mom_char = love.graphics.newImage("placeholders/mom_idle.png")

    -- Character avatars
    main_avatar = {
        idle = love.graphics.newImage("placeholders/avatar.png")
    }
    mom_char = {
        idle = love.graphics.newImage("placeholders/avatar.png")
    }

    -- Talkies.say( "Tutorial",
    -- {
    --   "Talkies is a simple to use messagebox library, it includes;",
    --   "Multiple choices,-- UTF8 text,-- Pauses,-- Onstart/OnMessage/Oncomplete functions,-- Complete customization,-- Variable typing speeds amongst other things."
    -- },
    -- {
    --     image=main_avatar.idle,
    --     typedNotTalked=false,
    --   })
    nextMessage()
end

function scene:draw()
    love.graphics.draw(bg, 0, 0, 0, SCALING)
end

function scene:update(dt)
end

return scene
