vim.api.nvim_create_augroup("UserTelescope", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.cmd([[
      packadd! telescope-fzf-native.nvim
      packadd! telescope-ui-select.nvim
      packadd! telescope.nvim
    ]])

    local telescope = require('telescope')
    telescope.load_extension('fzf')
    telescope.load_extension("ui-select")
    telescope.setup({
      defaults = {
        mappings = {
          n = {
                ['<Down>'] = "cycle_history_next",
                ['<Up>'] = "cycle_history_prev",
          }
        },
        layout_strategy = 'vertical',
      },
      pickers = {
        buffers = {
          sort_lastused = true,
          path_display = { "smart" },
          mappings = {
            n = {
                  ["dd"] = "delete_buffer"
            }
          }
        }
      },
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
        },
      },
    })
  end
})
