local Ero = require('libs.erogodic')

local script = Ero(function()
  name ""
  avatar ""
  background "placeholders/labyrinthe.png"

  name ""
  msg "Pour te déplacer dans le labyrinthe, utilise les flèches de ton clavier."
  msg "Les directions sont indiquées autour de la position de ton personnage, avec des flèches vers les endroits où tu peux aller."
  msg "Au fur et à mesure, tu pourras découvrir les zones de la forêt. A toi de retrouver la cabane."
  msg "Pour entrer dans la forêt, appuie sur la flèche du haut."
end)
  :defineAttributes({
    'name',
    'avatar',
    'background',
  })

return script
