require "lspconfig".eslint.setup {}

vim.api.nvim_create_user_command('FixAll', function()
  if vim.lsp.buf.code_action then
    vim.lsp.buf.code_action({
      apply = true,
      filter = function(action)
        return action.command.command == "eslint.applyAllFixes"
      end
    })

  else
    print "code action not found: eslint.applyAllFixes"
  end
end, {})

