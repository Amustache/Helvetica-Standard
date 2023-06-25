-- Scene
local scene = {}

function scene:load()
    print("load:\t\t travel_cabane")
    
    -- Load dialogues for that scene
    local script = require('dialogues.travel_cabane')
    dialogues.init(script)

    dialogues.nextMessage()
end

function scene:draw()
    love.graphics.draw(current_bg, 0, 0, 0, SCALING)
end

function scene:update(dt)
    if Talkies.isOpen() == false then
        fsm:minigame_labyrinthe()
    end
end

return scene
