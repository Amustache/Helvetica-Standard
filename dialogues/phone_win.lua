local Ero = require('libs.erogodic')

local script = Ero(function()
  name ""
  avatar ""
  background "img/phone_win.png"

  name "HEROE"
  avatar ""
  msg "There they are!"
  msg "Alright, here goes nothing!"
end)
  :defineAttributes({
    'name',
    'avatar',
    'background',
  })

return script
