local Ero = require('erogodic')

local script = Ero(function()
  name ""
  avatar ""
  background "placeholders/placeholder1.png"
  next_scene ""

  msg "Thank you for rescuing my beloved tomboyish daughter!"
  background "placeholders/placeholder2.png"
  name "HERO"
  next_scene "room"
  msg "Farewell!"
end)
  :defineAttributes({
    'name',
    'avatar',
    'background',
    'next_scene',
  })

return script
