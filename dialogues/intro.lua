local Ero = require('libs.erogodic')

local script = Ero(function()
  name ""
  avatar ""
  background ""
  next_scene ""

  -- 1
  background "img/intro_1.png"
  msg " Lorem ipsum dolor sit amet, consectetur adipiscing elit."
  msg "Ut porta fermentum lectus, eu dictum enim ultrices semper."
  msg "Ut in scelerisque lorem."

  -- 2
  background "img/intro_2.png"
  msg "Aenean nec fringilla sapien, quis elementum mauris."
  msg "Suspendisse varius tortor et leo dignissim fringilla."
  msg "In vitae nibh tortor."
  msg "Vestibulum eu arcu vitae justo volutpat aliquam ut non diam."
  msg "Nam venenatis, risus non tempus viverra, dolor ex congue ante, vel finibus sapien metus non diam."

  -- 3
  background "img/intro_3.png"
  msg "Mauris sagittis nunc augue, in euismod augue elementum sit amet."
  msg "Pellentesque rhoncus risus nec dui rutrum euismod."
  msg "Sed tincidunt quis diam vel elementum."
  next_scene "room"
  msg "Etiam bibendum turpis leo, suscipit finibus massa pellentesque eget.."
end)
  :defineAttributes({
    'name',
    'avatar',
    'background',
    'next_scene',
  })

return script
