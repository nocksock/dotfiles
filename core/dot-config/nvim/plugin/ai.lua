-- TODO: try out minuet with local llm
require 'baggage'.from {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/zbirenbaum/copilot.lua',
  -- 'https://github.com/milanglacier/minuet-ai.nvim'
}

vim.g.copilot_no_tab_map = true
require("copilot").setup({})

-- require("minuet").setup({
--   blink = {
--     enable_auto_complete = false,
--   },
--   cmp = {
--     enable_auto_complete = false,
--   },
--   virtualtext = {
--     auto_trigger_ft = {},
--     keymap = {
--       accept = "<c-cr>",
--       accept_line = "<c-;>",
--       next = "<c-g>",
--       dismiss = "<c-e>",
--     },
--   },
--
--   presets = {
--     ["local"] = {
--       n_completions = 1,
--       context_window = 8192,
--       provider = "openai_fim_compatible",
--       provider_options = {
--         openai_fim_compatible = {
--           api_key = 'TERM',
--           name = 'Ollama',
--           end_point = 'http://localhost:11434/v1/completions',
--           model = 'qwen2.5-coder:7b',
--           optional = {
--               max_tokens = 200,
--               top_p = 0.9,
--           },
--           template = {
--             prompt = function(context_before_cursor, context_after_cursor, _)
--               return "<|fim_prefix|>"
--               .. context_before_cursor
--               .. "<|fim_suffix|>"
--               .. context_after_cursor
--               .. "<|fim_middle|>"
--             end,
--             suffix = false,
--           },
--         },
--       },
--     },
--   },
-- })
