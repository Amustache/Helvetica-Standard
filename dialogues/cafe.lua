local Ero = require('libs.erogodic')

local script = Ero(function()
  name ""
  avatar ""
  background "placeholders/chamber_bg.png"
  next_scene ""

  name "HEROE"
  avatar ""
  msg "EH SALUT EN FAIT LOL"
end)
  :defineAttributes({
    'name',
    'avatar',
    'background',
    'next_scene',
  })

return script
