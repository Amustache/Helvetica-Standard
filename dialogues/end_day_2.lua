local Ero = require('libs.erogodic')

local script = Ero(function()
    name ""
    background "img/chapter.png"
    local continuer = option "Thank you for playing!"
    menu "End of the day.--"
    if selection(new_game) then
        love.event.quit()
    end
end):defineAttributes({'name', 'avatar', 'background'})

return script
