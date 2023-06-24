local Ero = require('erogodic')

local script = Ero(function()
  name "Shopkeeper"
  msg "Thank you for rescuing my beloved tomboyish daughter!"
  local baklava = option "Delicious Baklava"
  local hamster = option "Loyal Hamster"
  menu "Select your reward"
  if selection(baklava) then
    giveItem("Baklava")
  elseif selection(hamster) then
    giveItem("Hamster")
  end
  msg "Also, take this powerful weapon!"
  giveItem("Slightly-Rusted Dwarfbane +3")
  msg "Farewell!"
end)
  :defineAttributes({
    'name',
  })
  :addMacro('giveItem', function(item)
    local lastName = get('name')
    name ""
    msg("You got the " .. item .. "!")
    name(lastName)
  end)

return script
