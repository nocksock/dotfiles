vim.api.nvim_create_user_command('FixAll', function()
  if vim.lsp.buf.code_action then
    vim.lsp.buf.code_action({
      apply = true,
      filter = function(action)
        return action.command.command == "eslint.applyAllFixes"
      end
    })
  end
end, {})

