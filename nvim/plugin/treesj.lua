require "baggage".from 'https://github.com/Wansmer/treesj'

vim.keymap.set({ "n" }, "m", function() require 'treesj'.toggle() end)

local attribute_toggle = function(node_type, parent_type)
  return {
    both = {
      enable = function(tsn)
        return tsn:parent():type() == parent_type
      end,
    },
    split = {
      format_tree = function(tsj)
        local str = tsj:child(node_type)
        local words = vim.split(str:text(), ' ')
        tsj:remove_child(node_type)
        for i, word in ipairs(words) do
          tsj:create_child({ text = word }, i + 1)
        end
      end,
    },
    join = {
      format_tree = function(tsj)
        local str = tsj:child(node_type)
        local node_text = str:text()
        tsj:remove_child(node_type)
        tsj:create_child({ text = node_text }, 2)
      end,
    }
  }
end

require 'treesj'.setup {
  use_default_keymaps = false,
  max_join_length = 200,
  cursor_behavior = 'start',
  notify = true,
  langs = {
    elixir = {
      ['quoted_attribute_value'] = attribute_toggle('attribute_value', 'attribute')
    },
    php   = {
      ['attribute_value'] = attribute_toggle('attribute_value', 'quoted_attribute_value')
    },
    heex   = {
      ['quoted_attribute_value'] = attribute_toggle('attribute_value', 'attribute')
    },
    tsx    = {
      ['string'] = attribute_toggle('string_fragment', 'jsx_attribute'),
      ['template_string'] = attribute_toggle('template_string', 'expression_statement')
    },
    astro  = {
      ['quoted_attribute_value'] = attribute_toggle('attribute_value', 'attribute')
    },
    html   = { ['string'] = attribute_toggle('string_fragment', 'attribute') },
  },
  ---@type boolean Use `dot` for repeat action
  dot_repeat = true,
  ---@type nil|function Callback for treesj error handler. func (err_text, level, ...other_text)
  on_error = nil,
}
