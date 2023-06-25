local Ero = require('libs.erogodic')

local script = Ero(function()
    name ""
    avatar ""
    background "img/labyrinthe.png"

    name "Leah"
    msg "The famous forest !"
    name "Megan"
    msg "It's smaller than what I remembered..."
    name "Leah"
    msg "Anyhow. Let's go to the right."
    name "Adam"
    msg "Uh, absolutely not? We need to go left."
    name "Megan"
    msg "Wait, wasn't it straight?"

    name ""
    msg "Use the UP, DOWN, LEFT and RIGHT keys to move."
    msg "Available directions are shown with little arrows next to the characters."
    msg "To start, press UP."
end):defineAttributes({'name', 'avatar', 'background'})

return script
