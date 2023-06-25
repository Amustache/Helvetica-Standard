-- Scene
local scene = {}

function scene:load()
    print("load:\t\t end_day_2")
    
    -- Load dialogues for that scene
    local script = require('dialogues.end_day_2')
    dialogues.init(script)

    dialogues.nextMessage()
end

function scene:draw()
end

function scene:update(dt)
    if Talkies.isOpen() == false then
    end
end

return scene
