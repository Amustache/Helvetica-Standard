local Ero = require('libs.erogodic')

local script = Ero(function()
  name ""
  avatar ""
  background "img/chapter.png"
  next_scene ""

  msg ""
end)
  :defineAttributes({
    'name',
    'avatar',
    'background',
    'next_scene',
  })

return script
