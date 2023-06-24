local Ero = require('libs.erogodic')

local script = Ero(function()
  name ""
  avatar ""
  background "placeholders/chamber_bg.png"

  name "HEROE"
  avatar ""
  msg "EH SALUT EN FAIT LOL"
end)
  :defineAttributes({
    'name',
    'avatar',
    'background',
  })

return script
