-- Scene
local scene = {}

-- Magic numbers
screen_x = 89
screen_y = 36

function scene:load()
    print("load:\t\t phone")

    -- Load dialogues for that scene
    local script = require('dialogues.phone')
    dialogues.init(script)

    dialogues.nextMessage()

    -- Specific graphics
    contact_png = love.graphics.newImage("img/phone_contact.png")
    contact_padding_png = love.graphics.newImage("img/phone_no_contact.png")
    contact_create_group = love.graphics.newImage("img/phone_create_group.png")
    contact_disabled_group = love.graphics.newImage("img/phone_disabled_create_group.png")
    contact_selector_png = love.graphics.newImage("img/phone_selector.png")
    contact_found_png = love.graphics.newImage("img/phone_ok.png")

    -- Specific SFX
    success = love.audio.newSource("sfx/success.wav", "static")
    failure = love.audio.newSource("sfx/failure.wav", "static")

    contact_selector = {
        x = SCALING * screen_x,
        y = SCALING * (screen_y + 2 * contact_selector_png:getHeight()),
        w = SCALING * contact_selector_png:getWidth(),
        h = SCALING * contact_selector_png:getHeight(),
        pressed = false
    }

    -- Contacts
    contacts = require('prenoms')
    goals = {"Adam", "Leah"}
    found = {}

    offset = {
        min = 0,
        max = SCALING * ((#contacts - 7) * contact_selector_png:getHeight()),
        cur = 0,
        step = SCALING * contact_selector_png:getHeight(),
        offset = 0
    }
end

function scene:update(dt)
    -- Starts minigame once dialogue is done
    if Talkies.isOpen() == false and minigame_playing == "" then
        minigame_playing = "phone"
        print("minigame:\t " .. minigame_playing)
    end

    if minigame_playing == "phone" then
        -- Move selector
        if key_pressed == "up" and offset.offset == 0 and offset.cur > offset.min then
            offset.cur = offset.cur - offset.step
            offset.offset = -offset.step
        end

        if key_pressed == "down" and offset.offset == 0 and offset.cur < offset.max then
            offset.cur = offset.cur + offset.step
            offset.offset = offset.step
        end

        -- Scroll animation
        if offset.offset > 0 then
            offset.offset = offset.offset - 6
        end

        if offset.offset < 0 then
            offset.offset = offset.offset + 6
        end

        -- Select a thing
        if key_pressed == "space" then
            contact_selector.pressed = true
            local found_one = false
            local current_contact = contacts[1 + 2 + offset.cur / offset.step] -- Table starts at 1, and there's a 2-contacts offset
            -- print(current_contact)

            for i = 1, #goals do
                if current_contact == goals[i] then
                    table.remove(goals, i)
                    table.insert(found, current_contact)
                    found_one = true
                end
            end

            if found_one or #goals == 0 then
                if not success:isPlaying() then
                    love.audio.play(success)
                end
            else
                if not failure:isPlaying() then
                    love.audio.play(failure)
                end
            end

            if current_contact == "GROUP" and #goals == 0 then
                minigame_playing = ""
                fsm:phone_win()
            end
        end

        if not key_pressed then
            contact_selector.pressed = false
        end
    end
end

local function draw_contacts()
    for i, contact in ipairs(contacts) do
        local x = SCALING * screen_x -- TODO, HARDCODED
        local y = SCALING * screen_y + (i - 1) * (contact_png:getHeight() * SCALING) - offset.cur + offset.offset -- TODO, HARDCODED

        if contact == '' then
            love.graphics.draw(contact_padding_png, x, y, 0, SCALING)
        elseif contact == 'GROUP' then
            if #goals == 0 then
                love.graphics.draw(contact_create_group, x, y, 0, SCALING)
            else
                love.graphics.draw(contact_disabled_group, x, y, 0, SCALING)

            end
            love.graphics.print("Créer le groupe", 100 + x, 15 + y) -- TODO, HARDCODED
        else
            love.graphics.draw(contact_png, x, y, 0, SCALING)
            love.graphics.print(contacts[i], 100 + x, 15 + y) -- TODO, HARDCODED
        end

        for j = 1, #found do
            if contacts[i] == found[j] then
                love.graphics.draw(contact_found_png, x, y, 0, SCALING)
            end
        end
    end
end

function scene:draw()
    draw_contacts()

    if contact_selector.pressed then
        love.graphics.draw(contact_selector_png, contact_selector.x + 2, contact_selector.y + 2, 0, SCALING - 0.2)
    else
        love.graphics.draw(contact_selector_png, contact_selector.x, contact_selector.y, 0, SCALING)
    end

    love.graphics.draw(current_bg[1], 0, 0, 0, SCALING)  -- tkt
end

return scene
