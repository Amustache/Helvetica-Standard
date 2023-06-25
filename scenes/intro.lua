-- Scene
local scene = {}

function scene:load()
    print("load:\t\t intro")

    -- Load dialogues for that scene
    local script = require('dialogues.intro')
    dialogues.init(script)
    
    dialogues.nextMessage()
end

function scene:draw()
    -- love.graphics.draw(current_bg, 0, 0, 0, SCALING)
end

function scene:update(dt)
    if Talkies.isOpen() == false then
        fsm:intro()
    end
end

return scene
