local dialogues = {}

function dialogues.init(script)
    print("dialogue:\t\t new script!")
    dialogues.script = script
end

local displayMessageNode

local function nextMessage()
    local node = dialogues.script:next()
    displayMessageNode(node)
end

local function selectOption(selection)
    local node = dialogues.script:select(selection)
    displayMessageNode(node)
end

displayMessageNode = function(node)
    -- Erogodic script is over.
    if node == nil then
        print("dialogue:\t\t end of conversation!")
        return
    end

    -- Background
    if node.background and current_bg_name ~= node.background then
        print("dialogue:\t\t new background: " .. node.background)
        current_bg_name = node.background

        local bg_name, bg_max = current_bg_name:match("(.-)__(.-)$")
        if bg_name ~= nil then
            print("\t\tmultiple backgrounds!")
            local bg_ext
            bg_max, bg_ext = bg_max:match("(.-)%.(.-)$")
            bg_ext = "." .. bg_ext
            bg_max = tonumber(bg_max)

            current_bg = {}
            for i = 1, bg_max do
                table.insert(current_bg, love.graphics.newImage(bg_name .. "__" .. i .. bg_ext))
            end
        else
            current_bg = {love.graphics.newImage(node.background)} -- Not optimal...
        end
        current_bg_i = 1
    end

    local config = {}
    if node.options then
        config.options = {}
        for i, opt in ipairs(node.options) do
            local onSelect = function()
                selectOption(opt)
            end
            config.options[i] = {opt, onSelect}
        end
    else
        config.oncomplete = nextMessage
    end
    Talkies.say(node.name, node.msg, config)

    -- Next scene
    if node.next_scene and node.next_scene ~= '' then
        print("dialogue:\t\t next scene: " .. node.next_scene)
        scene_next = node.next_scene
    end
end

function dialogues.nextMessage()
    nextMessage()
end

return dialogues
