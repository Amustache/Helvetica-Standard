local Ero = require('libs.erogodic')

local script = Ero(function()
  name ""
  avatar ""
  background "img/phone_win.png"
  next_scene "cafe"

  name "HEROE"
  avatar ""
  msg "trob1 ptdr"
end)
  :defineAttributes({
    'name',
    'avatar',
    'background',
    'next_scene',
  })

return script
