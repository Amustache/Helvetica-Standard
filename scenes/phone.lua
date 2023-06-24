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
        pressed = false,
    }

    -- Contacts
    contacts = require('prenoms')
    goals = {"modestine", "tatienne"}
    found = {}
    current_contact = ""

    offset = {
        min = 0,
        max = SCALING * ((#contacts - 5) * contact_selector_png:getHeight()),
        cur = 0,
        step = SCALING * contact_selector_png:getHeight(),
        offset = 0,
    }
end

local timer = 60
function scene:update(dt)
    if Talkies.isOpen() == false and minigame_playing == "" then
        minigame_playing = "phone"
        print("minigame:\t " .. minigame_playing)
    end

    if minigame_playing == "phone" then
        if key_pressed == "up" and offset.offset == 0 and offset.cur > offset.min then
            offset.cur = offset.cur - offset.step
            offset.offset = -offset.step
        end

        if key_pressed == "down" and offset.offset == 0 and offset.cur < offset.max then
            offset.cur = offset.cur + offset.step
            offset.offset = offset.step
        end

        if offset.offset > 0 then
            offset.offset = offset.offset - 6
        end

        if offset.offset < 0 then
            offset.offset = offset.offset + 6
        end

        if key_pressed == "space" then
            contact_selector.pressed = true

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

        love.graphics.draw(contact_png, x, y, 0, SCALING)
        love.graphics.print(contacts[i], 100 + x, 15 + y) -- TODO, HARDCODED
    end
end

function scene:draw()
    draw_contacts()

    if contact_selector.pressed then
        love.graphics.draw(contact_selector_png, contact_selector.x + 2, contact_selector.y + 2, 0, SCALING - 0.2)
    else
        love.graphics.draw(contact_selector_png, contact_selector.x, contact_selector.y, 0, SCALING)
    end

    love.graphics.draw(current_bg, 0, 0, 0, SCALING)
end

return scene
