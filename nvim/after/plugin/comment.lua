require('comment').setup {}
require('todo-comments').setup {
  signs = false,
  highlight = { keyword = "" } -- using TreeSitter for highlights
}
