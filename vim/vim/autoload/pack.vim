vim9script

export def Init()
  packadd minpac

  call minpac#init()

  # manage minpac itself
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  # Additional plugins here.
  call minpac#add('vim-jp/syntax-vim-ex')
  call minpac#add('tyru/open-browser.vim')
  call minpac#add('junegunn/fzf')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('tpope/vim-vinegar')

  # lsp
  call minpac#add('prabirshrestha/vim-lsp')
  call minpac#add('mattn/vim-lsp-settings')

  # autocomplete
  call minpac#add('mattn/emmet-vim')
  call minpac#add('github/copilot.vim')
  call minpac#add('SirVer/ultisnips')

  # versioning
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('simnalamburt/vim-mundo')

  # vim convenience
  call minpac#add('tpope/vim-repeat')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-scriptease')
  call minpac#add('tpope/vim-eunuch')
  call minpac#add('christoomey/vim-tmux-navigator')

  # code convenience
  call minpac#add('junegunn/vim-easy-align')
  call minpac#add('tpope/vim-commentary')

  # ui
  call minpac#add('airblade/vim-gitgutter')
enddef
