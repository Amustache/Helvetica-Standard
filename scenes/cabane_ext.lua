-- Scene
local scene = {}

function scene:load()
    print("load:\t\t cabane_ext")
    
    -- Load dialogues for that scene
    local script = require('dialogues.cabane_ext')
    dialogues.init(script)

    dialogues.nextMessage()
end

function scene:draw()
end

function scene:update(dt)
    if Talkies.isOpen() == false then
        fsm:cabane_int()
    end
end

return scene
