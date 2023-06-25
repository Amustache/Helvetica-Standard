local Ero = require('libs.erogodic')

local script = Ero(function()
    name ""
    avatar ""
    background ""

    -- 1
    background "placeholders/intro__3.png"
    local new_game = option "Start a new day"
    local quit_game = option "Quit"
    menu "Helvetica Standard"
    if selection(new_game) then
    elseif selection(quit_game) then
        love.event.quit()
    end
end):defineAttributes({'name', 'avatar', 'background', 'next_scene'})

return script
