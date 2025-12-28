-- TODO: try out minuet with local llm
require 'baggage'.from {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/zbirenbaum/copilot.lua',
  -- 'https://github.com/milanglacier/minuet-ai.nvim'
  -- 'https://github.com/NickvanDyke/opencode.nvim'
}


-- vim.g.opencode_opts = {
--     -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
-- }
--
-- -- Required for `opts.events.reload`.
-- vim.o.autoread = true
--
-- -- Recommended/example keymaps.
-- vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
-- vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
-- vim.keymap.set({ "n", "x" },    "ga", function() require("opencode").prompt("@this") end,                   { desc = "Add to opencode" })
-- vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })
-- vim.keymap.set("n",        "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "opencode half page up" })
-- vim.keymap.set("n",        "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "opencode half page down" })
-- -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
-- vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
-- vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })

vim.g.copilot_no_tab_map = true
require("copilot").setup({})

-- require('minuet').setup {
--     provider = 'openai_fim_compatible',
--     n_completions = 1, -- recommend for local model for resource saving
--     context_window = 512,
--     provider_options = {
--         openai_fim_compatible = {
--             api_key = 'TERM',
--             name = 'Ollama',
--             end_point = 'http://localhost:11434/v1/completions',
--             model = 'qwen2.5-coder:1.5b', -- specify the model you pulled
--             optional = {
--                 max_tokens = 56,
--                 top_p = 0.9,
--             },
--             template = {
--                 prompt = function(context_before_cursor, context_after_cursor, _)
--                     return '<|fim_prefix|>'
--                         .. context_before_cursor
--                         .. '<|fim_suffix|>'
--                         .. context_after_cursor
--                         .. '<|fim_middle|>'
--                 end,
--                 suffix = false,
--             },
--         },
--     },
-- }


