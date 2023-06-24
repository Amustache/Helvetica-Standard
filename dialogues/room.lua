local Ero = require('libs.erogodic')

local script = Ero(function()
  name ""
  avatar ""
  background "img/bedroom_1.png"
  next_scene ""

  name "Mom"
  msg "Ben alors va voir tes potes lol"
  name "HEROE"
  next_scene "phone"
  msg "oe ok"
end)
  :defineAttributes({
    'name',
    'avatar',
    'background',
    'next_scene',
  })

return script
