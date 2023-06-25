-- Scene
local scene = {}

function scene:load()
    print("load:\t\t cabane_int")
    
    -- Load dialogues for that scene
    local script = require('dialogues.cabane_int')
    dialogues.init(script)

    dialogues.nextMessage()
end

function scene:draw()
    love.graphics.draw(current_bg, 0, 0, 0, SCALING)
end

function scene:update(dt)
    if Talkies.isOpen() == false then
        fsm:back_to_room()
    end
end

return scene
