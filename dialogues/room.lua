local Ero = require('erogodic')

local script = Ero(function()
  name ""
  avatar ""
  background "placeholders/chamber_bg.png"
  next_scene ""

  name ""
  msg "Thank you for rescuing my beloved tomboyish daughter!"
  local baklava = option "Delicious Baklava"
  local hamster = option "Loyal Hamster"
  menu "Select your reward"
  if selection(baklava) then
    msg "A fine choice."
  elseif selection(hamster) then
    msg "Interested in the dark arts, are we?"
  end
  msg "Also, take this powerful weapon!"
  next_scene "phone"
  msg "Farewell!"
end)
  :defineAttributes({
    'name',
    'avatar',
    'background',
    'next_scene',
  })

return script
