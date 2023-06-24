-- Scene
local scene = {}
local current_bg
local next_scene

-- Load dialogues for that scene
-- Can be multiple dialogues
local script = require('dialogues.intro')

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
    -- Erogodic script is over.
    if node == nil then
        return nil
    end

    -- Background
    if node.background then
        current_bg = love.graphics.newImage(node.background)  -- Not optimal...
    end

    -- Text
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

    if node.next_scene then
        next_scene = node.next_scene
    end
end

function scene:load()
    -- Background
    bg = {
        love.graphics.newImage("placeholders/placeholder1.png"),
        love.graphics.newImage("placeholders/placeholder2.png"),
        love.graphics.newImage("placeholders/placeholder3.png"),
    }

    nextMessage()
end

function scene:draw()
    love.graphics.draw(current_bg, 0, 0, 0, SCALING)
end

function scene:update(dt)
    if Talkies.isOpen() == false then
        self.setScene(next_scene)
    end
end

return scene
