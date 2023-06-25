-- Scene
local scene = {}

function scene:load()
    print("load:\t\t end_day_1")
    
    -- Load dialogues for that scene
    local script = require('dialogues.end_day_1')
    dialogues.init(script)

    dialogues.nextMessage()
end

function scene:draw()
    love.graphics.draw(current_bg, 0, 0, 0, SCALING)
end

function scene:update(dt)
    if Talkies.isOpen() == false then
        fsm:start_day_2()
    end
end

return scene
