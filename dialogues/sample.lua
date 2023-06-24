local Ero = require('libs.erogodic')

local script = Ero(function()
  name ""
  msg "[SAMPLE] Thank you for rescuing my beloved tomboyish daughter!"
  local baklava = option "Delicious Baklava"
  local hamster = option "Loyal Hamster"
  local pieceofthatass = option "A Piece of That Ass."
  menu "Select your reward"
  if selection(baklava) then
    giveItem("Baklava")
  elseif selection(hamster) then
    giveItem("Hamster")
  elseif selection(pieceofthatass) then
    giveItem("Piece of That Ass")
  end
  msg "Also, take this powerful weapon!"
  giveItem("Slightly-Rusted Dwarfbane +3")
  msg "Farewell!"
end)
  :defineAttributes({
    'name',
    'avatar',
    'background',
  })
  :addMacro('giveItem', function(item)
    local lastName = get('name')
    name ""
    msg("You got the " .. item .. "!")
    name(lastName)
  end)

return script
