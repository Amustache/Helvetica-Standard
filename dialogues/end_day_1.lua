local Ero = require('libs.erogodic')

local script = Ero(function()
    name ""
    background "img/chapter.png"
    local continuer = option "Start a new day"
    local quit_game = option "Quit"
    menu "End of the day.--"
    if selection(new_game) then
    elseif selection(quit_game) then
        love.event.quit()
    end
end):defineAttributes({'name', 'avatar', 'background'})

return script
