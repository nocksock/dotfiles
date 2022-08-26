local U = {}

function U.task(path, cmd)--{{{
  return function()
    hs.task.new(path, nil, function(_, ...)
      print("stream", hs.inspect(table.pack(...)))
      return true
    end, cmd):start()
  end
end--}}}

function U.modalLauncher(modal)--{{{
  return function(name)
    return function()
      local app = hs.application.find(name)

      if not app or app:isHidden() then
        hs.application.launchOrFocus(name)
      elseif app:isFrontmost() then
        app:hide()
      else
        app:activate()
      end

      modal:exit()
    end
  end
end--}}}

return U
