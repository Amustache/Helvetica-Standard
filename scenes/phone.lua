-- Scene
local scene = {}

local hand = {
    x = 0,
    y_low = 50,
    y_up = 350,
    y_mid = (50 + 350) / 2,
    y = (50 + 350) / 2,
}

function scene:load()
    print("load:\t\t phone")

    -- Load dialogues for that scene
    local script = require('dialogues.phone')
    dialogues.init(script)
    
    dialogues.nextMessage()

    -- Specifics graphics
    phone_png = love.graphics.newImage("placeholders/phone.png")
    hand_png = love.graphics.newImage("placeholders/hand.png")
end

function scene:draw()
    love.graphics.draw(current_bg, 0, 0, 0, SCALING)
    
    love.graphics.draw(phone_png, 0, 0, 0, SCALING)
    love.graphics.draw(hand_png, hand.x, hand.y, 0, SCALING)
end

function scene:update(dt)
    if not Talkies.isOpen() and minigame_playing == "" then
        minigame_playing = "phone"
        print("minigame:\t " .. minigame_playing)
    end

    if minigame_playing == "phone" then
        print(key_pressed)
    end
end

return scene
