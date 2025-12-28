--- Show relative date hints inline for datestamps
--- Detects dates in YYYY-MM-DD format and shows virtual text like "2 days ago"

local ns_id = vim.api.nvim_create_namespace('relative_dates')

-- Configuration
local config = {
  enabled = true,
  -- Pattern for matching dates (extensible)
  patterns = {
    { pattern = '(%d%d%d%d)-(%d%d)-(%d%d)', format = 'ymd' }, -- YYYY-MM-DD
  },
  -- Update interval in milliseconds
  update_interval = 60000, -- 1 minute
  -- Highlight group for virtual text
  hl_group = 'Comment',
}

--- Parse a date string and return timestamp
--- @param year number
--- @param month number
--- @param day number
--- @return number|nil timestamp in seconds
local function parse_date(year, month, day)
  local ok, time = pcall(os.time, {
    year = tonumber(year),
    month = tonumber(month),
    day = tonumber(day),
    hour = 0,
    min = 0,
    sec = 0,
  })
  if ok then
    return time
  end
  return nil
end

--- Format a time difference as relative text
--- @param date_time number timestamp of the date
--- @param now number current timestamp
--- @return string relative time description
local function format_relative(date_time, now)
  -- Check if it's the same calendar day
  local now_date = os.date('*t', now)
  local date_date = os.date('*t', date_time)

  if now_date.year == date_date.year and
     now_date.month == date_date.month and
     now_date.day == date_date.day then
    return 'today'
  end

  local diff = date_time - now
  local abs_diff = math.abs(diff)
  local is_future = diff > 0

  local days = math.floor(abs_diff / 86400)

  local text
  if days > 365 then
    local years = math.floor(days / 365)
    text = years == 1 and '1 year' or years .. ' years'
  elseif days > 30 then
    local months = math.floor(days / 30)
    text = months == 1 and '1 month' or months .. ' months'
  else
    text = days == 1 and '1 day' or days .. ' days'
  end

  if is_future then
    return 'in ' .. text
  else
    return text .. ' ago'
  end
end

--- Update relative date hints for a buffer
--- @param bufnr number buffer number
local function update_buffer(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  -- Clear existing virtual text
  vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

  if not config.enabled then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local now = os.time()

  for lnum, line in ipairs(lines) do
    for _, pattern_def in ipairs(config.patterns) do
      local start_col = 1
      while true do
        local s, e, year, month, day = string.find(line, pattern_def.pattern, start_col)
        if not s then break end

        local date_time = parse_date(year, month, day)
        if date_time then
          local relative_text = format_relative(date_time, now)

          vim.api.nvim_buf_set_extmark(bufnr, ns_id, lnum - 1, e, {
            virt_text = { { ' (' .. relative_text .. ')', config.hl_group } },
            virt_text_pos = 'eol',
          })
        end

        start_col = e + 1
        if start_col > #line then break end
      end
    end
  end
end

--- Set up autocommands for updating relative dates
local function setup_autocmds()
  local group = vim.api.nvim_create_augroup('RelativeDates', { clear = true })

  -- Update on buffer enter and text change
  vim.api.nvim_create_autocmd({ 'BufEnter', 'TextChanged', 'TextChangedI' }, {
    group = group,
    callback = function(args)
      update_buffer(args.buf)
    end,
  })

  -- Periodic updates for all visible buffers
  local timer = vim.uv.new_timer()
  timer:start(config.update_interval, config.update_interval, vim.schedule_wrap(function()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(bufnr) then
        update_buffer(bufnr)
      end
    end
  end))
end

--- Toggle relative date hints
local function toggle()
  config.enabled = not config.enabled
  if config.enabled then
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(bufnr) then
        update_buffer(bufnr)
      end
    end
    print('Relative dates enabled')
  else
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
      end
    end
    print('Relative dates disabled')
  end
end

-- Commands
vim.api.nvim_create_user_command('RelativeDatesToggle', toggle, {
  desc = 'Toggle relative date hints',
})

vim.api.nvim_create_user_command('RelativeDatesRefresh', function()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) then
      update_buffer(bufnr)
    end
  end
end, {
  desc = 'Refresh all relative date hints',
})

-- Initialize
setup_autocmds()

-- Export for extensibility
return {
  config = config,
  update_buffer = update_buffer,
  toggle = toggle,
}
