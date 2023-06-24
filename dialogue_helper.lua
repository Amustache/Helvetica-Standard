local dialogues = {}

function dialogues.init(script)
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
    return
  end

  -- Background
  if node.background then
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
      next_scene = node.next_scene
  else
    next_scene = nil
  end
end

function dialogues.nextMessage()
    nextMessage()
end

return dialogues
