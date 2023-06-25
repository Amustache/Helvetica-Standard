-- Scene
local scene = {}

function scene:load()
    print("load:\t\t intro")
    current_bg = {
        love.graphics.newImage("img/bedroom_1__1.png"),
        love.graphics.newImage("img/bedroom_1__2.png"),
        love.graphics.newImage("img/bedroom_1__3.png"),
        love.graphics.newImage("img/bedroom_1__4.png"),
    }
    menu = love.graphics.newImage("placeholders/menu.png")
end

function scene:draw()
    love.graphics.draw(menu, 0, 0, 0, SCALING)
end

function scene:update(dt)
    if key_pressed == "space" then
        fsm:intro()
    end
end

return scene
