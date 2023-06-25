-- Scene
local scene = {}

function scene:load()
    print("load:\t\t labyrinthe_win")
    
    -- Load dialogues for that scene
    local script = require('dialogues.labyrinthe_win')
    dialogues.init(script)

    dialogues.nextMessage()
end

function scene:draw()
    love.graphics.draw(current_bg, 0, 0, 0, SCALING)
end

function scene:update(dt)
    if Talkies.isOpen() == false then
        fsm:cabane_ext()
    end
end

return scene
