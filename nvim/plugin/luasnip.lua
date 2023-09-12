require "baggage" 
  .from 'https://github.com/L3MON4D3/LuaSnip'

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    local luasnip = require('luasnip')

    vim.api.nvim_create_user_command("SnippetEdit",
      function() require('luasnip.loaders.from_lua').edit_snippet_files() end, {})
    vim.api.nvim_create_user_command("SnippetReload",
      function() require('luasnip.loaders.from_lua').lazy_load() end, {})

    vim.keymap.set({ 'i', 's' }, '<c-l>', function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { silent = true })

    vim.keymap.set({ 'i', 's' }, '<c-j>', function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end, { silent = true })

    vim.keymap.set({ 'i', 's' }, '<c-h>', function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { silent = true })

    luasnip.config.set_config({
      history = true,
      enable_autosnippets = true,
      updateevents = 'TextChanged,TextChangedI',
      region_check_events = "InsertEnter",
      delete_check_events = "TextChanged,InsertLeave",
    })

    require('luasnip.loaders.from_lua').lazy_load({}) -- load filetype based snippets from snippet folder
  end
})
