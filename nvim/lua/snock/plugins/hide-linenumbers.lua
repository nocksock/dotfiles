---iterate over all relevant windows
---@param cb function(window: number)
local function map_win(cb)
  for _, value in ipairs(vim.api.nvim_list_wins()) do
    if vim.fn.win_gettype() == "" then
      cb(value)
    end
  end
end

---@return boolean
local function numbers_visible()
  for _, value in ipairs(vim.api.nvim_list_wins()) do
    if vim.fn.win_gettype() == "" then
      return vim.api.nvim_win_get_option(value, "rnu")
    end
  end

  error("no windows found", 1)
end

local function show()
  map_win(function(value)
    vim.api.nvim_win_set_option(value, "rnu", true)
    vim.api.nvim_win_set_option(value, "nu", true)
  end)
end

local function hide()
  map_win(function(value)
    vim.api.nvim_win_set_option(value, "rnu", false)
    vim.api.nvim_win_set_option(value, "nu", false)
  end)
end

vim.api.nvim_create_user_command("NumShow", show, {})
vim.api.nvim_create_user_command("NumHide", hide, {})

vim.api.nvim_create_user_command("Num", function()
  if numbers_visible() then
    hide()
  else
    show()
  end
end, {})
