local Ero = require('libs.erogodic')

local script = Ero(function()
  name ""
  avatar ""
  background ""

  -- 1
  background "img/intro_1.png"
  msg " Lorem ipsum dolor sit amet, consectetur adipiscing elit."

  -- 2
  background "img/intro_2.png"
  msg "Aenean nec fringilla sapien, quis elementum mauris."

  -- 3
  background "img/intro_3.png"
  msg "Etiam bibendum turpis leo, suscipit finibus massa pellentesque eget.."
end)
  :defineAttributes({
    'name',
    'avatar',
    'background',
    'next_scene',
  })

return script
