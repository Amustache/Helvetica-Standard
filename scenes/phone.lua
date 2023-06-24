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

hand = {
    pressed = false,
}

function scene:load()
    print("load:\t\t phone")

    -- Load dialogues for that scene
    local script = require('dialogues.phone')
    dialogues.init(script)

    dialogues.nextMessage()

    -- Specific graphics
    contact_png = love.graphics.newImage("img/phone_contact.png")
    contact_selector_png = love.graphics.newImage("img/phone_selector.png")
    contact_found_png = love.graphics.newImage("img/phone_ok.png")

    -- Specific SFX
    success = love.audio.newSource("sfx/success.wav", "static")
    failure = love.audio.newSource("sfx/failure.wav", "static")

    contact_selector = {
        x = SCALING * 89,
        y = SCALING * 78,
        w = SCALING * contact_selector_png:getWidth(),
        h = SCALING * contact_selector_png:getHeight(),
    }
end

local function is_a_in_b(a, b)
    local a_x1, a_y1, a_x2, a_y2 = a.x, a.y, a.x + a.w, a.y + a.h
    local b_x1, b_y1, b_x2, b_y2 = b.x, b.y, b.x + b.w, b.y + b.h
    if a_x1 > b_x1 and a_x2 < b_x2 and a_y1 > b_y1 and a_y2 < b_y2 then
        return true
    else
        return false
    end
end

local function draw_contacts(offset) -- top_visible is between 0 and #prenoms
    for i = 1, #contacts do
        local x = SCALING * 89 -- TODO, HARDCODED
        local y = SCALING * 36 + (i - 1) * (contact_png:getHeight() * SCALING) - offset -- TODO, HARDCODED

        love.graphics.draw(contact_png, x, y, 0, SCALING)
        love.graphics.print(contacts[i], 100 + x, 15 + y) -- TODO, HARDCODED

        for j = 1, #found do
            if contacts[i] == found[j] then
                love.graphics.draw(contact_found_png, x, y, 0, SCALING)
            end
        end

        local box = {
            x = 42 + x,
            y = 42 + y,
            w = SCALING * contact_png:getWidth() - 42 * 2,
            h = SCALING * contact_png:getHeight() - 42 * 2,
        }

        -- Debug
        love.graphics.setColor(0, 0, 1)
        love.graphics.rectangle("line", box.x, box.y, box.w, box.h)
        love.graphics.setColor(255, 255, 255)

        if is_a_in_b(box, contact_selector) then
            print(current_contact)
            current_contact = contacts[i]
        end
    end
end

function scene:draw()
    draw_contacts(offset)

    love.graphics.draw(contact_selector_png, contact_selector.x, contact_selector.y, 0, SCALING)

    love.graphics.draw(current_bg, 0, 0, 0, SCALING)

    if hand.pressed then
        -- love.graphics.draw(hand_png, hand.x, hand.y, 0, SCALING - 0.2) -- TODO HARDCODED
    else
        -- love.graphics.draw(hand_png, hand.x, hand.y, 0, SCALING)
    end

    -- Debug
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("line", contact_selector.x, contact_selector.y, contact_selector.w, contact_selector.h)
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
