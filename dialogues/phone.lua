local Ero = require('libs.erogodic')

local script = Ero(function()
  name ""
  avatar ""
  background "img/phone_bg.png"
  next_scene "phone_win"

  name "Megan"
  msg "I should still have their number in my phone."
  msg "Let's see..."

  name ""
  msg "Use the UP and DOWN keys to scroll in your contacts list."
  msg "The longer you hold the key, the further you'll scroll."
  msg "Select a contact with the SPACE bar."
  msg "When both contacts are selected, scroll at the very bottom of the page to confirm."
end)
  :defineAttributes({
    'name',
    'avatar',
    'background',
    'next_scene',
  })

return script
