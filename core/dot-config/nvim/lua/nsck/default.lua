return function(val, default)
  if val == "" or val == nil then
    return default
  end

  return val
end
