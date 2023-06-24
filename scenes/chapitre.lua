-- Scene
local scene = {}

function scene:load()
    print("load:\t\t chapitre transition")
end

function scene:draw()
    love.graphics.clear()
    love.graphics.print("FIN DE LA JOURNÉE", 0, 0) -- TODO, HARDCODED
end

function scene:update(dt)
    if not Talkies.isOpen() and minigame_playing == "" then
        minigame_playing = "chapter"
        print("chapter:\t " .. "chapter")
    end

    if minigame_playing == "chapter" then
        if key_pressed == "space" then
            fsm:enter_cafe()
        end
    end
end

return scene
