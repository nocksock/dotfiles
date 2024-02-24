vim.keymap.set('n', '<leader>ti', function()
  local previous = vim.diagnostic.config()
  vim.diagnostic.config({ virtual_text = not previous.virtual_text })
end)


-- local insert_file_path = function(opts)
--   local R = require
--   opts = opts or {}
--   local conf = R("telescope.config").values
--
--   R 'telescope.pickers'.new({}, {
--     prompt_title = "Insert File Path",
--     finder = R 'telescope.finders'.new_oneshot_job({ "rg", "--files", "--color", "never" }, opts),
--     previewer = conf.file_previewer(opts),
--     sorter = conf.file_sorter(opts),
--     entry_maker = R "telescope.make_entry".gen_from_file(opts),
--     attach_mappings = function(prompt_bufnr --[[, map ]])
--       local actions = R "telescope.actions"
--
--       actions.select_default:replace(function()
--         local action_state = R "telescope.actions.state"
--         actions.close(prompt_bufnr)
--         local selection = action_state.get_selected_entry()
--         vim.api.nvim_put({ selection[1] }, "", false, true)
--       end)
--
--       return true
--     end,
--   }):find()
-- end
--
--
-- vim.keymap.set('i', '<c-x><c-f>', insert_file_path)
-- vim.keymap.set('n', '<leader>xf', insert_file_path)
-- -- TODO: prefill the search with string before the cursor

