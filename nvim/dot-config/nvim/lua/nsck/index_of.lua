return function(tbl, value)
  for idx, tval in ipairs(tbl) do
    if value == tval then
      return idx
    end
  end
end
