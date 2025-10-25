vim9script

export def Init()
  packadd minpac

  call minpac#init()

  # manage minpac itself
  call minpac#add('https://github.com/k-takata/minpac', {'type': 'opt'})

  # Additional plugins here.
  call minpac#add('https://github.com/vim-jp/syntax-vim-ex')
  call minpac#add('https://github.com/tyru/open-browser.vim')
  call minpac#add('https://github.com/junegunn/fzf')
  call minpac#add('https://github.com/junegunn/fzf.vim')
  call minpac#add('https://github.com/tpope/vim-vinegar')

  # lsp
  call minpac#add('https://github.com/prabirshrestha/vim-lsp')
  call minpac#add('https://github.com/mattn/vim-lsp-settings')

  # autocomplete
  call minpac#add('https://github.com/mattn/emmet-vim')

  # versioning
  call minpac#add('https://github.com/tpope/vim-fugitive')
  call minpac#add('https://github.com/simnalamburt/vim-mundo')

  # vim convenience
  call minpac#add('https://github.com/tpope/vim-repeat')
  call minpac#add('https://github.com/tpope/vim-surround')
  call minpac#add('https://github.com/tpope/vim-scriptease')
  call minpac#add('https://github.com/tpope/vim-eunuch')
  call minpac#add('https://github.com/tpope/vim-sleuth')
  call minpac#add('https://github.com/christoomey/vim-tmux-navigator')

  # code convenience
  call minpac#add('https://github.com/junegunn/vim-easy-align')
  call minpac#add('https://github.com/tpope/vim-commentary')

  # ui
  call minpac#add('https://github.com/airblade/vim-gitgutter')
  call minpac#add('https://github.com/chriskempson/base16-vim')
enddef
