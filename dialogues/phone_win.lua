local Ero = require('libs.erogodic')

local script = Ero(function()
  name ""
  avatar ""
  background "img/phone_win.png"

  name "HEROE"
  avatar ""
  msg "trob1 ptdr"
end)
  :defineAttributes({
    'name',
    'avatar',
    'background',
  })

return script
