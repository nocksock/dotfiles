-- When saving a shell script with shebang as first line, make it executable
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.sh",
    callback = function()
        local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
        -- only make executable if first line is a shebang
        if first_line and first_line:match("^#!") then
            local file_path = vim.api.nvim_buf_get_name(0)
            os.execute("chmod +x " .. file_path)
        end
    end,
})
