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
    love.graphics.draw(current_bg, 0, 0, 0, SCALING)
end

function scene:update(dt)
    if Talkies.isOpen() == false then
        fsm:end_day()
    end
end

return scene
