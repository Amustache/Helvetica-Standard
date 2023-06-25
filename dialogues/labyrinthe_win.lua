local Ero = require('libs.erogodic')

local script = Ero(function()
  name ""
  avatar ""
  background "placeholders/threehouse.png"

  name "Megan"
  avatar ""
  msg "EH SALUT EN FAIT LOL"

  name "Anna"
  avatar ""
  msg "EH SALUT EN FAIT LOL"

  name "Adam"
  avatar ""
  msg "EH SALUT EN FAIT LOL"
end)
  :defineAttributes({
    'name',
    'avatar',
    'background',
  })

return script
