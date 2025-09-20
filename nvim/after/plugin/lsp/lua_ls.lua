require'lspconfig'.lua_ls.setup{
    settings = {
        Lua = {
            workspace = {
                library = {
                    vim.fn.expand("$VIMRUNTIME/lua"),
                    vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                    "/home/code/plenary.nvim/lua",
                },
            },
            runtime = {
                version = "LuaJIT"
            }
        }
    }
}
