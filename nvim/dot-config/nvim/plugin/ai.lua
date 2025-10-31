-- TODO: try out minuet with local llm
require 'baggage'.from {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/zbirenbaum/copilot.lua',
  'https://github.com/milanglacier/minuet-ai.nvim'
}




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


