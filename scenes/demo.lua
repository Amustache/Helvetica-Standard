local game = {}

function game:load()
    print("Scenery is awesome")
end

function game:draw()
    love.graphics.print("Scenery makes life easier", 200, 300)
end

function game:update(dt)
    print("You agree, don't you?")
end

return game