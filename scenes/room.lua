local machine = require('statemachine')

local scene = {}

local fsm = machine.create({
    initial = 'green',
    events = {
      { name = 'warn',  from = 'green',  to = 'yellow' },
      { name = 'panic', from = 'yellow', to = 'red'    },
      { name = 'calm',  from = 'red',    to = 'yellow' },
      { name = 'clear', from = 'yellow', to = 'green'  }
  }})

function scene:load()
    bg = love.graphics.newImage("placeholders/chamber_bg.png")

    Talkies.say( "Tutorial",
    {
      "Talkies is a simple to use messagebox library, it includes;",
      "Multiple choices,-- UTF8 text,-- Pauses,-- Onstart/OnMessage/Oncomplete functions,-- Complete customization,-- Variable typing speeds amongst other things."
    },
    {
        image=avatar,
        typedNotTalked=false,
      })
end

function scene:draw()
    love.graphics.draw(bg, 0, 0)
end

function scene:update(dt)
end

return scene
