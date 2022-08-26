local pickers      = require "telescope.pickers"
local finders      = require "telescope.finders"
local conf         = require("telescope.config").values
local actions      = require "telescope.actions"
local action_state = require "telescope.actions.state"
local themes       = require "telescope.themes"
local builtin = require('telescope.builtin')
local utils = R('snock.utils')
local cycle = utils.cycle

-- TODO: allow multiselect in M.search_folder?
-- TODO: keep previous when going back? probably deleting it anyway, but might
--    feel better overall.

local plugin_dir = vim.env.HOME .. '/.local/share/nvim/site/pack/packer/start/'
local search_fns = {"find_files", "live_grep"}
local M = {}

M.common_mappings = function(map)
  map('i', '<esc>', actions.close)
  map('i', '<c-c>', actions.close)
  map('i', '<c-j>', actions.move_selection_next)
  map('i', '<c-k>', actions.move_selection_previous)
end

function M.search_dir(dir, opts, search_fn)--{{{
  local path = plugin_dir .. dir
  search_fn = search_fn or "find_files"

  builtin[search_fn]({
    search_dirs = { path },
    cwd = path,
    attach_mappings = function(prompt_bufnr, map)
      M.common_mappings(map)

      map('i', '<c-f>', function()
        actions.close(prompt_bufnr)
        M.search_dir(dir, opts, cycle(search_fns, search_fn))
      end)

      map('i', '<c-h>', function()
        actions.close(prompt_bufnr)
        utils.maybe_call(opts.on_back)
      end)

      return true
    end
  })
end--}}}

function M.search(dir, opts)
  opts = opts or {}
  pickers.new(themes.get_dropdown(), {
    prompt_title = "Choose Plugin",
    finder = finders.new_oneshot_job({ "ls" }, { cwd = plugin_dir }),
    prompt = "",
    default_text = dir,
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      M.common_mappings(map)
      -- local prompt = P(vim.api.nvim_buf_get_lines(prompt_bufnr, 0, -1, false))[1]
      -- TODO: dry up -- #quick

      map('i', '<c-l>', function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        M.search_dir(selection[1], vim.tbl_extend("keep", opts, {
          on_back = function()
            M.search(selection[1])
          end
        }))
      end)

      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        M.search_dir(selection[1], vim.tbl_extend("keep", opts, {
          on_back = function()
            M.search(selection[1])
          end
        }))
      end)

      return true
    end,
  }):find()
end

return M
