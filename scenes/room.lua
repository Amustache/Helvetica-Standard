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
    love.graphics.draw(current_bg, 0, 0, 0, SCALING)
end

function scene:update(dt)
    if Talkies.isOpen() == false and scene_next then
        self.setScene(scene_next)
    end
end

return scene
