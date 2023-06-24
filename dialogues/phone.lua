local Ero = require('erogodic')

local script = Ero(function()
  name ""
  avatar "placeholders/avatar.png"
  background ""
  next_scene ""

  name "HEROE"
  avatar ""
  msg "Je vais voir dans mes contacts si j'ai toujours leur numéro."
  msg "Si c'est le cas, je vais créer un groupe avec tout le monde - ce sera plus simple !"

  name ""
  avatar ""
  msg "Utilise les flèches HAUT et BAS de ton clavier pour scroller dans tes contacts."
  msg "Plus longtemps tu restes appuyé.e, plus tu scrolleras loin."
  msg "Une fois le contact trouvé, utilise la touche ESPACE pour le sélectionner."
  msg "Quand tu as terminé, scroll tout en bas pour créer le groupe, et parler à tes ami.e.s."
end)
  :defineAttributes({
    'name',
    'avatar',
    'background',
    'next_scene',
  })

return script
