local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local themes       = require "telescope.themes"

-- todo: use escape to go to previous search
-- todo: allow multiselect?

local plugin_dir = '/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/'

local search = function(search_fn, opts)
  opts = opts or {}
  pickers.new(themes.get_dropdown(), {
    prompt_title = "Choose Plugin",
    finder = finders.new_oneshot_job({ "ls" }, { cwd = plugin_dir }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        require('telescope.builtin')[vim.F.if_nil(search_fn, "find_files")]({
          search_dirs = { plugin_dir .. selection[1] },
          cwd = plugin_dir .. selection[1]
        })
      end)
      return true
    end,
  }):find()
end

return {
  files = function() search("find_files") end,
  grep = function() search("live_grep") end
}
