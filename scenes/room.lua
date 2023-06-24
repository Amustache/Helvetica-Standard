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
    if Talkies.isOpen() == false and next_scene then
        self.setScene(next_scene)
    end
end

return scene
