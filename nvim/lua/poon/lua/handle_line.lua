return function(config)
  local config = config or R "poon.lua.config"()

  return R('poon.lua.try_cmd')() 
    or R('poon.lua.try_paths')()
    or R('poon.lua.try_codeblock')()
end
