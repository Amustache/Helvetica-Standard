-- Scene
local scene = {}

-- Load dialogues for that scene
dialogues = require('dialogue_helper')
script = require('dialogues.intro')
dialogues.init(script)

function scene:load()
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
