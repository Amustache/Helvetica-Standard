-- Scene
local scene = {}

function scene:load()
    print("load:\t\t phone_win")
    
    -- Load dialogues for that scene
    local script = require('dialogues.phone_win')
    dialogues.init(script)

    dialogues.nextMessage()
end

function scene:draw()
end

function scene:update(dt)
    if Talkies.isOpen() == false then
        fsm:end_day_1()
    end
end

return scene
