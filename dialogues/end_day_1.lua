local Ero = require('libs.erogodic')

local script = Ero(function()
    name ""
    background "img/chapter.png"
    local continuer = option "Start next day"
    menu "End of the day.--"
    if selection(new_game) then
    end
end):defineAttributes({'name', 'avatar', 'background'})

return script
