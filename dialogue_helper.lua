local dialogues = {}

function dialogues.init(script)
  print("new script!")
    dialogues.script = script
end

local displayMessageNode

local function nextMessage()
  local node = dialogues.script:next()
  displayMessageNode(node)
end

local function selectOption(selection)
  local node = dialogues.script:select(selection)
  displayMessageNode(node)
end

displayMessageNode = function(node)
-- Erogodic script is over.
  if node == nil then
    print("end of conversation!")
    return
  end

  -- Background
  if node.background then
    print("new background: " .. node.background)
      current_bg = love.graphics.newImage(node.background)  -- Not optimal...
  end

  local config = {}
  if node.options then
    config.options = {}
    for i, opt in ipairs(node.options) do
      local onSelect = function()
        selectOption(opt)
      end
      config.options[i] = {opt, onSelect}
    end
  else
    config.oncomplete = nextMessage
  end
  Talkies.say(node.name, node.msg, config)

  -- Next scene
  if node.next_scene and node.next_scene ~= '' then
    print("next scene: " .. node.next_scene)
      next_scene = node.next_scene
  end
end

function dialogues.nextMessage()
    nextMessage()
end

return dialogues
