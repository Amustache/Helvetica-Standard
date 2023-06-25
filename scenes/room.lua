-- Scene
local scene = {}

function scene:load()
    print("load:\t\t room")
    
    -- Load dialogues for that scene
    local script = require('dialogues.room')
    dialogues.init(script)

    dialogues.nextMessage()
end

function scene:draw()
end

function scene:update(dt)
    if Talkies.isOpen() == false then
        fsm:minigame_phone()
    end
end

return scene
