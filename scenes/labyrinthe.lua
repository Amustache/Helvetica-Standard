-- Scene
local scene = {}

function scene:load()
    print("load:\t\t room")
    
    -- Load dialogues for that scene
    local script = require('dialogues.labyrinthe')
    dialogues.init(script)

    dialogues.nextMessage()

    -- Specific graphics
    hidding_trees = {  -- Sorted by visibility
        n = {visible=true, file=love.graphics.newImage("img/hidding_tree_n.png")},
        g = {visible=true, file=love.graphics.newImage("img/hidding_tree_g.png")},
        f = {visible=true, file=love.graphics.newImage("img/hidding_tree_f.png")},
        k = {visible=true, file=love.graphics.newImage("img/hidding_tree_k.png")},
        l = {visible=true, file=love.graphics.newImage("img/hidding_tree_l.png")},
        m = {visible=true, file=love.graphics.newImage("img/hidding_tree_m.png")},
        e = {visible=true, file=love.graphics.newImage("img/hidding_tree_e.png")},
        i = {visible=true, file=love.graphics.newImage("img/hidding_tree_i.png")},
        j = {visible=true, file=love.graphics.newImage("img/hidding_tree_j.png")},
        a = {visible=true, file=love.graphics.newImage("img/hidding_tree_a.png")},
        h = {visible=true, file=love.graphics.newImage("img/hidding_tree_h.png")},
        d = {visible=true, file=love.graphics.newImage("img/hidding_tree_d.png")},
        c = {visible=true, file=love.graphics.newImage("img/hidding_tree_c.png")},
        b = {visible=true, file=love.graphics.newImage("img/hidding_tree_b.png")},
    }

    poi = {
        love.graphics.newImage("img/poi_1.png"),
        love.graphics.newImage("img/poi_2.png"),
        love.graphics.newImage("img/poi_3.png"),
        love.graphics.newImage("img/poi_4.png"),
        love.graphics.newImage("img/poi_5.png"),
        love.graphics.newImage("img/poi_6.png"),
        love.graphics.newImage("img/poi_7.png"),
        love.graphics.newImage("img/poi_8.png"),
        love.graphics.newImage("img/poi_0.png"),
    }

    -- Specific SFX

    local function reveal_hidden(l)
        for k, v in pairs(hidding_trees) do
            if l == k then
                v.visible = false
            end
        end
    end

    -- Visited
    local visited = {}

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
            {name = "down", from = "6", to = "5"},
            {name = "left", from = "7", to = "5"},
            {name = "right", from = "7", to = "8"},
            {name = "down", from = "7", to = "3"},
            {name = "left", from = "8", to = "finish"},
        },
        callbacks = {
            -- callback = function(self, event, from, to) end,
            onstatechange = function(self, event, from, to) end,

            -- Entrance
            on1 = function(self, event, from, to)
                reveal_hidden({})
                if visited[to] == nil then
                    visited[to] = true
                else
                end
                if from == "3" then
                    reveal_hidden("b")
                end
                if from == "4" then
                    reveal_hidden("c")
                end
            end,

            -- Barn
            on2 = function(self, event, from, to)
                reveal_hidden("a")
                if visited[to] == nil then
                    Talkies.say("Leah", "Oh my!-- Todd's farm hasn't aged too well!")
                    Talkies.say("Adam", "Speaking of cows...-- Wasn't there a TAUREAU back then?")
                    Talkies.say("Leah", "Yeah, but he's probably dead by now, right?")
                    Talkies.say("", "moo")
                    Talkies.say("Megan", "... Let's get moving.")
                    visited[to] = true
                else
                    Talkies.say("", "mooo--oo--oo")
                end
            end,

            -- Big tree
            on3 = function(self, event, from, to)
                reveal_hidden("d")
                if visited[to] == nil then
                    Talkies.say("Leah", "We were always trying to climb this huge tree back in the days.")
                    Talkies.say("Megan", "C'mon, it's not that big.")
                    Talkies.say("Leah", "Yeah, now that you mention it...")
                    visited[to] = true
                else
                    Talkies.say("Adam", "It's still quite tall though.")
                end
                if from == "1" then
                    reveal_hidden("b")
                end
                if from == "7" then
                    reveal_hidden("e")
                end
            end,

            -- Lake
            on4 = function(self, event, from, to)
                reveal_hidden("h")
                if visited[to] == nil then
                    Talkies.say("Leah", "Hey Meg remember when your dad caught a tortoise in there?")
                    Talkies.say("Megan", "That thing was vicious.")
                    Talkies.say("Adam", "I avoided going to your house for like two weeks at least while you dad kept it in your basement.")
                    Talkies.say("Megan", "Really?!")
                    Talkies.say("Adam", "Hey, that thing was vicious.")
                    visited[to] = true
                else
                    Talkies.say("Megan", "Did I tell you my dad ultimately put the tortoise back in this lake. It's probably still here.")
                    Talkies.say("Adam", "Stop it.")
                end
                if from == "1" then
                    reveal_hidden("c")
                end
                if from == "5" then
                    reveal_hidden("i")
                end
            end,

            -- Small crossing
            on5 = function(self, event, from, to)
                reveal_hidden("j")
                if visited[to] == nil then
                    Talkies.say("Megan", "So, forward?")
                    Talkies.say("Leah", "Hell no! To the right!")
                    visited[to] = true
                else
                    Talkies.say("Adam", "Haven't we been here already a couple minutes ago?")
                end
                if from == "4" then
                    reveal_hidden("i")
                end
                if from == "7" then
                    reveal_hidden("l")
                end
            end,

            -- Big rock
            on6 = function(self, event, from, to)
                reveal_hidden("k")
                if visited[to] == nil then
                    Talkies.say("Leah", "I remember that thing to be HUGE.")
                    Talkies.say("Leah", "But it's just a mid-size rock.")
                    Talkies.say("Adam", "And look at all that MOSS!")
                    visited[to] = true
                else
                    Talkies.say("Adam", "Mossy.")
                end
            end,

            -- Big crossing
            on7 = function(self, event, from, to)
                reveal_hidden("f")
                if visited[to] == nil then
                    Talkies.say("Megan", "To the right?")
                    Talkies.say("Adam", "I would have said left.")
                    visited[to] = true
                else
                end
                if from == "3" then
                    reveal_hidden("e")
                end
                if from == "5" then
                    reveal_hidden("l")
                end
            end,

            -- Cabane
            on8 = function(self, event, from, to)
                reveal_hidden("n")
                if visited[to] == nil then
                    Talkies.say("Megan", "There, finally!")
                    Talkies.say("Leah", "Holy cow, it IS still standing!")
                    Talkies.say("Adam", "Come on, let's get in!")
                    visited[to] = true
                else
                end
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
