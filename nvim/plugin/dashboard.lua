local db = require('dashboard')

-- todo: rewrite without dashboard
local home = os.getenv('HOME')
local db = require('dashboard')

db.preview_command = 'cat | lolcat -F 0.03 -S 70'
db.confirm_key = '<cr>'
db.preview_file_path = home .. '/personal/dotfiles/logo.txt'
db.preview_file_height = 24
db.preview_file_width = 48
db.hide_statusline = false
db.hide_false = false
db.custom_center = {
  {
    icon = '  ',
    desc = 'Search Files                     ',
    shortcut = 'SPC s f',
    action = 'Telescope find_files'
  } --correct if you don't icon filed
}
