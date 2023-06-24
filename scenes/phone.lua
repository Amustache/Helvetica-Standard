-- Scene
local scene = {}

-- Contacts
local contacts = require('prenoms')
local max_contacts = #contacts
local visible_contacts = 8 -- TODO, HARDCODED
local goals = {"mirabelle", "pons"}
local found = {}
local current_contact = ""

local offset = 0
local scroll_speed = 10

function scene:load()
    print("load:\t\t phone")

    -- Load dialogues for that scene
    local script = require('dialogues.phone')
    dialogues.init(script)

    dialogues.nextMessage()

    -- Specific graphics
    hand_png = love.graphics.newImage("placeholders/hand.png")
    contact_png = love.graphics.newImage("placeholders/contact.png")
    contact_found_png = love.graphics.newImage("placeholders/contact_found.png")

    -- Specific SFX
    success = love.audio.newSource("sfx/success.wav", "static")
    failure = love.audio.newSource("sfx/failure.wav", "static")

    -- Things
    hand = {
        x = 0,
        y_low = 50,
        y_up = 350,
        y_mid = (50 + 350) / 2,
        y = (50 + 350) / 2,
        pressed = false,
        finger_x = 150,
        finger_y = 110,
        finger_size = 16
    }

    box_target = {
        x1 = SCALING * (hand.finger_x - contact_found_png:getWidth() / 2),
        y1 = SCALING * (hand.finger_y - contact_found_png:getHeight() / 2),
        x2 = SCALING * (hand.finger_x + contact_found_png:getWidth() / 2),
        y2 = SCALING * (hand.finger_y + contact_found_png:getHeight() / 2)
    }
end

local function is_a_in_b(a_x1, a_y1, a_x2, a_y2, b_x1, b_y1, b_x2, b_y2)
    if a_x1 > b_x1 and a_x2 < b_x2 and a_y1 > b_y1 and a_y2 < b_y2 then
        return true
    else
        return false
    end
end

local function draw_contacts(offset) -- top_visible is between 0 and #prenoms
    for i = 1, #contacts do
        local x = 464 -- TODO, HARDCODED
        local y = 224 + (i - 1) * (contact_png:getHeight() * SCALING) - offset -- TODO, HARDCODED

        love.graphics.draw(contact_png, x, y, 0, SCALING)
        love.graphics.print(contacts[i], 21 + x, 10 + y) -- TODO, HARDCODED

        for j = 1, #found do
            if contacts[i] == found[j] then
                love.graphics.draw(contact_found_png, x, y, 0, SCALING)
            end
        end

        local x1 = 10 + x
        local y1 = 10 + y
        local x2 = x + SCALING * contact_png:getWidth() - 10
        local y2 = y + SCALING * contact_png:getHeight() - 10

        -- Debug
        love.graphics.setColor(0, 0, 1)
        love.graphics.rectangle("line", x1, y1, x2 - x1, y2 - y1)
        love.graphics.setColor(255, 255, 255)

        if is_a_in_b(x1, y1, x2, y2, box_target.x1, box_target.y1, box_target.x2, box_target.y2) then
            current_contact = contacts[i]
        end
    end
end

function scene:draw()
    draw_contacts(offset)

    love.graphics.draw(current_bg, 0, 0, 0, SCALING)

    if hand.pressed then
        love.graphics.draw(hand_png, hand.x, hand.y, 0, SCALING - 0.2) -- TODO HARDCODED
    else
        love.graphics.draw(hand_png, hand.x, hand.y, 0, SCALING)
    end

    -- Debug
    -- Finger
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("line", SCALING * hand.finger_x, SCALING * hand.finger_y, hand.finger_size)
    love.graphics.rectangle("line", box_target.x1, box_target.y1, box_target.x2 - box_target.x1,
        box_target.y2 - box_target.y1)
    love.graphics.setColor(255, 255, 255)

end

-- local function sign(number)
--     if number > 0 then
--         return 1
--     end

--     if number < 0 then
--         return -1
--     end

--     if number == 0 then
--         return 0
--     end
-- end

function scene:update(dt)
    if not Talkies.isOpen() and minigame_playing == "" then
        minigame_playing = "phone"
        print("minigame:\t " .. minigame_playing)
    end

    if minigame_playing == "phone" then
        -- local curr = math.abs(hand.y_mid - hand.y)
        -- local factor = 1 + math.sqrt(math.pow(2, 2) - math.pow(curr - 2, 2))

        -- print("y: " .. hand.y .. ", factor: " .. factor .. ", curr: " .. curr)

        if key_pressed == "up" then
            offset = math.max(0, offset - scroll_speed)
            -- hand.y = math.max(hand.y - (-factor), hand.y_low)
        end

        if key_pressed == "down" then
            offset = math.min(55 * max_contacts, offset + scroll_speed) -- TODO, HARDCODED
            -- hand.y = math.min(hand.y + (-factor), hand.y_up)
        end

        if key_pressed == "space" then
            hand.pressed = true
            local found_one = false

            for i = 1, #goals do
                if current_contact == goals[i] then
                    table.remove(goals, i)
                    table.insert(found, current_contact)
                    found_one = true
                end
            end

            if found_one then
                if not success:isPlaying() then
                    love.audio.play(success)
                end
            else
                if not failure:isPlaying() then
                    love.audio.play(failure)
                end
            end

            -- print(is_a_in_b())
        end

        if not key_pressed then
            hand.pressed = false
            --     if hand.y < hand.y_mid then
            --         hand.y = hand.y + factor
            --     elseif hand.y > hand.y_mid then
            --         hand.y = hand.y - factor
            --     end
        end
    end
end

return scene
