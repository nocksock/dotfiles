-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/nilsriedemann/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/nilsriedemann/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/nilsriedemann/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/nilsriedemann/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/nilsriedemann/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\fcomment\frequire\0" },
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["codi.vim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/codi.vim",
    url = "https://github.com/metakirby5/codi.vim"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/emmet-vim",
    url = "https://github.com/mattn/emmet-vim"
  },
  ["fidget.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vfidget\frequire\0" },
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["goto-preview"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/goto-preview",
    url = "https://github.com/rmagatti/goto-preview"
  },
  ["local-bloop.nvim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/local-bloop.nvim",
    url = "/Users/nilsriedemann/code/personal/bloop.nvim"
  },
  ["local-do.nvim"] = {
    config = { "\27LJ\2\nC\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\15use_winbar\2\nsetup\ado\frequire\0" },
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/local-do.nvim",
    url = "/Users/nilsriedemann/code/personal/do.nvim"
  },
  ["local-ghash.nvim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/local-ghash.nvim",
    url = "/Users/nilsriedemann/code/personal/ghash.nvim"
  },
  ["local-harpoon"] = {
    config = { "\27LJ\2\ni\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\20global_settings\1\0\0\1\0\1\21enter_on_sendcmd\2\nsetup\fharpoon\frequire\0" },
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/local-harpoon",
    url = "/Users/nilsriedemann/code/forks/harpoon"
  },
  ["local-nazgul-vim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/local-nazgul-vim",
    url = "/Users/nilsriedemann/code/personal/nazgul-vim"
  },
  ["local-t.nvim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\6t\frequire\0" },
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/local-t.nvim",
    url = "/Users/nilsriedemann/code/personal/t.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nZ\0\1\3\0\5\0\0146\1\0\0009\1\1\0019\1\2\0019\1\3\1B\1\1\2\15\0\1\0X\2\5€\18\1\0\0'\2\4\0&\1\2\1\14\0\1\0X\2\1€\18\1\0\0L\1\2\0\6+\17server_ready\bbuf\blsp\bvimÅ\5\1\0\t\0!\1E6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\a\0005\3\3\0005\4\4\0=\4\5\0034\4\0\0=\4\6\3=\3\b\0025\3\n\0004\4\3\0005\5\t\0>\5\1\4=\4\v\0035\4\r\0005\5\f\0>\5\1\4=\4\14\0034\4\3\0005\5\15\0>\5\1\4=\4\16\0035\4\17\0=\4\18\0034\4\3\0005\5\19\0003\6\20\0=\6\21\5>\5\1\4=\4\22\0034\4\0\0=\4\23\3=\3\24\0025\3\25\0004\4\0\0=\4\v\0034\4\0\0=\4\14\0034\4\3\0005\5\26\0>\5\1\4=\4\16\0034\4\0\0=\4\18\0034\4\0\0=\4\22\0034\4\0\0=\4\23\3=\3\27\0025\3\29\0004\4\3\0004\5\3\0006\6\0\0'\b\28\0B\6\2\0?\6\0\0>\5\1\4=\4\v\0034\4\3\0005\5\30\0>\5\1\4=\4\23\3=\3\31\0024\3\0\0=\3 \2B\0\2\1K\0\1\0\15extensions\ftabline\1\2\1\0\ttabs\tmode\3\0\1\0\0\"snock.plugins.harpoon-lualine\22inactive_sections\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\14lualine_y\bfmt\0\1\2\1\0\rfiletype\18icons_enabled\2\14lualine_x\1\2\0\0\rlocation\14lualine_c\1\2\1\0\rfilename\tpath\3\1\14lualine_b\1\4\0\0\0\tdiff\16diagnostics\1\2\0\0\vbranch\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\23disabled_filetypes\23section_separators\1\0\2\nright\5\tleft\5\1\0\3\25component_separators\5\ntheme\tauto\18icons_enabled\1\nsetup\flualine\frequire\3€€À™\4\0" },
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/lush.nvim",
    url = "https://github.com/rktjmp/lush.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["nnn.vim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/nnn.vim",
    url = "https://github.com/mcchrish/nnn.vim"
  },
  ["noice.nvim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\nnoice\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/opt/noice.nvim",
    url = "https://github.com/folke/noice.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nw\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\21disable_filetype\1\0\0\1\3\0\0\20TelescopePrompt\vfennel\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-go"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/nvim-dap-go",
    url = "https://github.com/leoluz/nvim-dap-go"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\18nvim-surround\frequire\0" },
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\nî\2\0\0\6\0\20\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\t\0005\4\b\0=\4\n\3=\3\v\0025\3\r\0005\4\f\0=\4\14\0035\4\16\0005\5\15\0=\5\17\4=\4\18\3=\3\19\2B\0\2\1K\0\1\0\factions\15expand_all\fexclude\1\0\0\1\3\0\0\t.git\17node_modules\15change_dir\1\0\0\1\0\1\venable\1\rrenderer\nicons\1\0\0\1\0\1\18git_placement\nafter\16diagnostics\1\0\1\venable\2\tview\1\0\3 preserve_window_proportions\2\25centralize_selection\2\tside\nright\1\0\2\17hijack_netrw\1\18hijack_cursor\2\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-context"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["refactoring.nvim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/refactoring.nvim",
    url = "https://github.com/theprimeagen/refactoring.nvim"
  },
  ["sqlite.lua"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/sqlite.lua",
    url = "https://github.com/kkharji/sqlite.lua"
  },
  ["symbols-outline.nvim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  ["telekasten.nvim"] = {
    config = { "\27LJ\2\nÌ\2\0\0\a\0\15\0\0286\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\0026\1\4\0'\3\5\0B\1\2\0029\1\6\0015\3\a\0=\0\b\3\18\4\0\0'\5\t\0'\6\n\0&\4\6\4=\4\v\3\18\4\0\0'\5\t\0'\6\n\0&\4\6\4=\4\f\3\18\4\0\0'\5\t\0'\6\r\0&\4\6\4=\4\14\3B\1\2\1K\0\1\0\14templates\14Templates\rweeklies\fdailies\fJournal\6/\thome\1\0\2\14extension\b.md\21subdirs_in_links\1\nsetup\15telekasten\frequire[/Users/nilsriedemann/Library/Mobile Documents/iCloud~md~obsidian/Documents/Development\vexpand\afn\bvim\0" },
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/telekasten.nvim",
    url = "https://github.com/renerocksai/telekasten.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\ng\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\14highlight\1\0\1\fkeyword\5\1\0\1\nsigns\1\nsetup\18todo-comments\frequire\0" },
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["twilight.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rtwilight\frequire\0" },
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/twilight.nvim",
    url = "https://github.com/folke/twilight.nvim"
  },
  ["typescript.nvim"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/typescript.nvim",
    url = "https://github.com/jose-elias-alvarez/typescript.nvim"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/vim-abolish",
    url = "https://github.com/tpope/vim-abolish"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/vim-eunuch",
    url = "https://github.com/tpope/vim-eunuch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-mundo"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/vim-mundo",
    url = "https://github.com/simnalamburt/vim-mundo"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-scriptease"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/vim-scriptease",
    url = "https://github.com/tpope/vim-scriptease"
  },
  ["vim-vinegar"] = {
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/vim-vinegar",
    url = "https://github.com/tpope/vim-vinegar"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n‰\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0005\4\4\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\vwindow\1\0\0\vmargin\1\5\0\0\3\4\3\4\3\4\3\6\1\0\2\vborder\vdouble\rposition\vcenter\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  },
  ["zen-mode.nvim"] = {
    config = { "\27LJ\2\nÌ\2\0\0\5\0\19\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\15\0025\3\16\0005\4\17\0=\4\r\3=\3\18\2B\0\2\1K\0\1\0\vwindow\1\0\4\vnumber\1\19relativenumber\1\tlist\1\15signcolumn\byes\1\0\2\rbackdrop\4\0€€ ÿ\3\nwidth\3x\fplugins\1\0\0\foptions\1\0\2\fenabled\2\fshowcmd\2\rgitsigns\1\0\1\fenabled\2\ttmux\1\0\1\fenabled\2\rtwilight\1\0\1\fenabled\2\nkitty\1\0\0\1\0\2\fenabled\2\tfont\a+4\nsetup\rzen-mode\frequire\0" },
    loaded = true,
    path = "/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/zen-mode.nvim",
    url = "https://github.com/folke/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: fidget.nvim
time([[Config for fidget.nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vfidget\frequire\0", "config", "fidget.nvim")
time([[Config for fidget.nvim]], false)
-- Config for: local-do.nvim
time([[Config for local-do.nvim]], true)
try_loadstring("\27LJ\2\nC\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\15use_winbar\2\nsetup\ado\frequire\0", "config", "local-do.nvim")
time([[Config for local-do.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\fcomment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\nw\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\21disable_filetype\1\0\0\1\3\0\0\20TelescopePrompt\vfennel\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\nZ\0\1\3\0\5\0\0146\1\0\0009\1\1\0019\1\2\0019\1\3\1B\1\1\2\15\0\1\0X\2\5€\18\1\0\0'\2\4\0&\1\2\1\14\0\1\0X\2\1€\18\1\0\0L\1\2\0\6+\17server_ready\bbuf\blsp\bvimÅ\5\1\0\t\0!\1E6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\a\0005\3\3\0005\4\4\0=\4\5\0034\4\0\0=\4\6\3=\3\b\0025\3\n\0004\4\3\0005\5\t\0>\5\1\4=\4\v\0035\4\r\0005\5\f\0>\5\1\4=\4\14\0034\4\3\0005\5\15\0>\5\1\4=\4\16\0035\4\17\0=\4\18\0034\4\3\0005\5\19\0003\6\20\0=\6\21\5>\5\1\4=\4\22\0034\4\0\0=\4\23\3=\3\24\0025\3\25\0004\4\0\0=\4\v\0034\4\0\0=\4\14\0034\4\3\0005\5\26\0>\5\1\4=\4\16\0034\4\0\0=\4\18\0034\4\0\0=\4\22\0034\4\0\0=\4\23\3=\3\27\0025\3\29\0004\4\3\0004\5\3\0006\6\0\0'\b\28\0B\6\2\0?\6\0\0>\5\1\4=\4\v\0034\4\3\0005\5\30\0>\5\1\4=\4\23\3=\3\31\0024\3\0\0=\3 \2B\0\2\1K\0\1\0\15extensions\ftabline\1\2\1\0\ttabs\tmode\3\0\1\0\0\"snock.plugins.harpoon-lualine\22inactive_sections\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\14lualine_y\bfmt\0\1\2\1\0\rfiletype\18icons_enabled\2\14lualine_x\1\2\0\0\rlocation\14lualine_c\1\2\1\0\rfilename\tpath\3\1\14lualine_b\1\4\0\0\0\tdiff\16diagnostics\1\2\0\0\vbranch\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\23disabled_filetypes\23section_separators\1\0\2\nright\5\tleft\5\1\0\3\25component_separators\5\ntheme\tauto\18icons_enabled\1\nsetup\flualine\frequire\3€€À™\4\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: local-t.nvim
time([[Config for local-t.nvim]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\6t\frequire\0", "config", "local-t.nvim")
time([[Config for local-t.nvim]], false)
-- Config for: twilight.nvim
time([[Config for twilight.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rtwilight\frequire\0", "config", "twilight.nvim")
time([[Config for twilight.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: telekasten.nvim
time([[Config for telekasten.nvim]], true)
try_loadstring("\27LJ\2\nÌ\2\0\0\a\0\15\0\0286\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\0026\1\4\0'\3\5\0B\1\2\0029\1\6\0015\3\a\0=\0\b\3\18\4\0\0'\5\t\0'\6\n\0&\4\6\4=\4\v\3\18\4\0\0'\5\t\0'\6\n\0&\4\6\4=\4\f\3\18\4\0\0'\5\t\0'\6\r\0&\4\6\4=\4\14\3B\1\2\1K\0\1\0\14templates\14Templates\rweeklies\fdailies\fJournal\6/\thome\1\0\2\14extension\b.md\21subdirs_in_links\1\nsetup\15telekasten\frequire[/Users/nilsriedemann/Library/Mobile Documents/iCloud~md~obsidian/Documents/Development\vexpand\afn\bvim\0", "config", "telekasten.nvim")
time([[Config for telekasten.nvim]], false)
-- Config for: zen-mode.nvim
time([[Config for zen-mode.nvim]], true)
try_loadstring("\27LJ\2\nÌ\2\0\0\5\0\19\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\15\0025\3\16\0005\4\17\0=\4\r\3=\3\18\2B\0\2\1K\0\1\0\vwindow\1\0\4\vnumber\1\19relativenumber\1\tlist\1\15signcolumn\byes\1\0\2\rbackdrop\4\0€€ ÿ\3\nwidth\3x\fplugins\1\0\0\foptions\1\0\2\fenabled\2\fshowcmd\2\rgitsigns\1\0\1\fenabled\2\ttmux\1\0\1\fenabled\2\rtwilight\1\0\1\fenabled\2\nkitty\1\0\0\1\0\2\fenabled\2\tfont\a+4\nsetup\rzen-mode\frequire\0", "config", "zen-mode.nvim")
time([[Config for zen-mode.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\nî\2\0\0\6\0\20\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\t\0005\4\b\0=\4\n\3=\3\v\0025\3\r\0005\4\f\0=\4\14\0035\4\16\0005\5\15\0=\5\17\4=\4\18\3=\3\19\2B\0\2\1K\0\1\0\factions\15expand_all\fexclude\1\0\0\1\3\0\0\t.git\17node_modules\15change_dir\1\0\0\1\0\1\venable\1\rrenderer\nicons\1\0\0\1\0\1\18git_placement\nafter\16diagnostics\1\0\1\venable\2\tview\1\0\3 preserve_window_proportions\2\25centralize_selection\2\tside\nright\1\0\2\17hijack_netrw\1\18hijack_cursor\2\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: local-harpoon
time([[Config for local-harpoon]], true)
try_loadstring("\27LJ\2\ni\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\20global_settings\1\0\0\1\0\1\21enter_on_sendcmd\2\nsetup\fharpoon\frequire\0", "config", "local-harpoon")
time([[Config for local-harpoon]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\ng\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\14highlight\1\0\1\fkeyword\5\1\0\1\nsigns\1\nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\18nvim-surround\frequire\0", "config", "nvim-surround")
time([[Config for nvim-surround]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n‰\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0005\4\4\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\vwindow\1\0\0\vmargin\1\5\0\0\3\4\3\4\3\4\3\6\1\0\2\vborder\vdouble\rposition\vcenter\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'noice.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
