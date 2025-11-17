vim.api.nvim_create_user_command('Fmove', function()
    require('fzf-lua').files({
        cwd = vim.fn.getcwd(),
        cmd = 'fd -td --hidden --exclude .git --exclude node_modules',
        actions = {
            ['default'] = function(selected)
                if #selected == 0 then return end
                vim.cmd('Move ' .. selected[1])
            end
        }
    })
end, {})
