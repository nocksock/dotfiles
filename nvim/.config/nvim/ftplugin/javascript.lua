require "baggage"
    .from {
      'https://github.com/neovim/nvim-lspconfig',
      'https://github.com/marilari88/twoslash-queries.nvim',
      'https://github.com/pmizio/typescript-tools.nvim'
    }


-- command! -buffer DeleteLogLines :g/\v\^*console.log/normal dd<cr>
local lsp = require "lsp-utils"

vim.keymap.set("n", "<M-s>", ":Prettier<CR>:w<CR>", { buffer = true })

-- if lsp.has_root_file("astro.config.js") then
--   -- vim.cmd.LspStart("astro")
-- elseif lsp.has_root_file("deno.json", "deno.jsonc") then
  -- vim.cmd.LspStart("denols")
-- elseif lsp.has_root_file("tsconfig.json") then
-- else
  -- vim.cmd.LspStart("biome")
-- end

vim.cmd.LspStart("ts_ls")
