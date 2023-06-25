-- Scene
local scene = {}

function scene:load()
    print("load:\t\t room_2")
    
    -- Load dialogues for that scene
    local script = require('dialogues.room_2')
    dialogues.init(script)

    dialogues.nextMessage()
end

function scene:draw()
    love.graphics.draw(current_bg, 0, 0, 0, SCALING)
end

function scene:update(dt)
    if Talkies.isOpen() == false then
        fsm:end_day_2()
    end
end

return scene
