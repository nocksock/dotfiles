return function(fn)
  return function(...)
    return not fn(...)
  end
end

