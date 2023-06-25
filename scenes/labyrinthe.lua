-- Scene
local scene = {}

function scene:load()
    print("load:\t\t room")
    
    -- Load dialogues for that scene
    local script = require('dialogues.labyrinthe')
    dialogues.init(script)

    dialogues.nextMessage()

    -- Specific graphics
    hidding_trees = {
        a = {visible=true, file=love.graphics.newImage("placeholders/hidding_tree_a.png")},
        b = {visible=true, file=love.graphics.newImage("placeholders/hidding_tree_b.png")},
        c = {visible=true, file=love.graphics.newImage("placeholders/hidding_tree_c.png")},
        d = {visible=true, file=love.graphics.newImage("placeholders/hidding_tree_d.png")},
        e = {visible=true, file=love.graphics.newImage("placeholders/hidding_tree_e.png")},
        f = {visible=true, file=love.graphics.newImage("placeholders/hidding_tree_f.png")},
        g = {visible=true, file=love.graphics.newImage("placeholders/hidding_tree_g.png")},
        h = {visible=true, file=love.graphics.newImage("placeholders/hidding_tree_h.png")},
        i = {visible=true, file=love.graphics.newImage("placeholders/hidding_tree_i.png")},
        j = {visible=true, file=love.graphics.newImage("placeholders/hidding_tree_j.png")},
        k = {visible=true, file=love.graphics.newImage("placeholders/hidding_tree_k.png")},
        l = {visible=true, file=love.graphics.newImage("placeholders/hidding_tree_l.png")},
        m = {visible=true, file=love.graphics.newImage("placeholders/hidding_tree_m.png")},
        n = {visible=true, file=love.graphics.newImage("placeholders/hidding_tree_n.png")},
    }

    poi = {
        love.graphics.newImage("placeholders/poi_1.png"),
        love.graphics.newImage("placeholders/poi_2.png"),
        love.graphics.newImage("placeholders/poi_3.png"),
        love.graphics.newImage("placeholders/poi_4.png"),
        love.graphics.newImage("placeholders/poi_5.png"),
        love.graphics.newImage("placeholders/poi_6.png"),
        love.graphics.newImage("placeholders/poi_7.png"),
        love.graphics.newImage("placeholders/poi_8.png"),
        love.graphics.newImage("placeholders/poi_0.png"),
    }

    -- Specific SFX

    local function reveal_hidden(l)
        for k, v in pairs(hidding_trees) do
            if l == k then
                v.visible = false
            end
        end
    end

    -- FSM
    local machine = require('libs.statemachine')
    maze_fsm = machine.create({
        initial = "start",
        events = { -- up, down, left, right
            {name = "up", from = "start", to = "1"},
            {name = "left", from = "1", to = "4"},
            {name = "up", from = "1", to = "2"},
            {name = "right", from = "1", to = "3"},
            {name = "down", from = "2", to = "1"},
            {name = "up", from = "3", to = "7"},
            {name = "down", from = "3", to = "1"},
            {name = "left", from = "4", to = "8"},
            {name = "up", from = "4", to = "5"},
            {name = "down", from = "4", to = "1"},
            {name = "up", from = "5", to = "6"},
            {name = "right", from = "5", to = "7"},
            {name = "down", from = "5", to = "4"},
            {name = "left", from = "6", to = "5"},
            {name = "left", from = "7", to = "5"},
            {name = "right", from = "7", to = "8"},
            {name = "down", from = "7", to = "3"},
            {name = "left", from = "8", to = "finish"},
        },
        callbacks = {
            -- callback = function(self, event, from, to) end,
            onstatechange = function(self, event, from, to) end,
            on1 = function(self, event, from, to)
                reveal_hidden({})
                Talkies.say("hehehe", "hohooho")
            end,
            on2 = function(self, event, from, to)
                reveal_hidden("a")
            end,
            on3 = function(self, event, from, to)
                reveal_hidden("d")
                if from == "1" then
                    reveal_hidden("b")
                end
                if from == "7" then
                    reveal_hidden("e")
                end
            end,
            on4 = function(self, event, from, to)
                reveal_hidden("h")
                if from == "1" then
                    reveal_hidden("c")
                end
                if from == "5" then
                    reveal_hidden("i")
                end
            end,
            on5 = function(self, event, from, to)
                reveal_hidden("j")
                if from == "4" then
                    reveal_hidden("i")
                end
                if from == "7" then
                    reveal_hidden("l")
                end
            end,
            on6 = function(self, event, from, to)
                reveal_hidden("k")
            end,
            on7 = function(self, event, from, to)
                reveal_hidden("f")
                if from == "3" then
                    reveal_hidden("e")
                end
                if from == "5" then
                    reveal_hidden("l")
                end
            end,
            on8 = function(self, event, from, to)
                reveal_hidden("n")
                if from == "4" then
                    reveal_hidden("m")
                end
                if from == "7" then
                    reveal_hidden("g")
                end
            end,
        }
    })
end

local timer = 0
function scene:update(dt)
    -- Unlock Talkies when text is available
    if Talkies.isOpen() then
        minigame_playing = ""
    else
        minigame_playing = "labyrinthe"
    end

    if minigame_playing == "labyrinthe" then
        if timer == 0 then
            if key_pressed then
                timer = 60
            end

            if key_pressed == "up" then
                maze_fsm:up()
            end
            
            if key_pressed == "down" then
                maze_fsm:down()
            end
            
            if key_pressed == "left" then
                maze_fsm:left()
            end
            
            if key_pressed == "right" then
                maze_fsm:right()
            end
        else
            timer = timer - 1
        end

        if maze_fsm.current == "finish" then
            minigame_playing = ""
            fsm:labyrinthe_win()
        end
    end
end

function scene:draw()
    love.graphics.draw(current_bg, 0, 0, 0, SCALING)
    
    for k, v in pairs(hidding_trees) do
        if v.visible then
            love.graphics.draw(v.file, 0, 0, 0, SCALING) 
        end
    end

    if maze_fsm.current == "start" then
        love.graphics.draw(poi[9], 0, 0, 0, SCALING)
    elseif maze_fsm.current == "finish" then
        --
    else
        love.graphics.draw(poi[tonumber(maze_fsm.current)], 0, 0, 0, SCALING)
    end
end

return scene
