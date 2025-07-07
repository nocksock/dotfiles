return function(values, value)
  local next_val_idx = ((require 'nsck.index_of' (values, value)) % #values) + 1
  return values[next_val_idx]
end
