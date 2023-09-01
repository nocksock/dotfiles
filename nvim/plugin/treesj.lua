local treesj = require "baggage".from 'https://github.com/Wansmer/treesj'

vim.api.nvim_create_autocmd({ 'UIEnter' }, {
  callback = function()
    treesj.load().setup {
      use_default_keymaps = false,
      max_join_length = 200,
      cursor_behavior = 'start',
      notify = true,
      langs = {
        tsx = {
              ['string'] = {
            both = {
              enable = function(tsn)
                return tsn:parent():type() == 'jsx_attribute'
              end,
            },
            split = {
              format_tree = function(tsj)
                local str = tsj:child('string_fragment')
                local words = vim.split(str:text(), ' ')
                tsj:remove_child('string_fragment')
                for i, word in ipairs(words) do
                  tsj:create_child({ text = word }, i + 1)
                end
              end,
            },
            join = {
              format_tree = function(tsj)
                local str = tsj:child('string_fragment')
                local node_text = str:text()
                tsj:remove_child('string_fragment')
                tsj:create_child({ text = node_text }, 2)
              end,
            }
          }
        }
      },
      ---@type boolean Use `dot` for repeat action
      dot_repeat = true,
      ---@type nil|function Callback for treesj error handler. func (err_text, level, ...other_text)
      on_error = nil,
    }
  end
})
