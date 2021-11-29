# Dotfiles

These are *some* of my dotfiles, personal configuration… things. ʕ •ᴥ•ʔ 

At the moment this is practically boiled down to zsh, vim and tmux. Which is all
I need to be productive on the command line.

After years of VS Code usage and a short excursion with doom-emacs, I'm sort of
re-igniting my interest in vim. I write a lot of JavaScript, TypeScript in
combination with react. And this config relies heavily on plugins to get some of
the VS Code goodness, back into vim.

## Requirements

- Vim
- Tmux
- Oh-My-ZSH

## Installation

I usually have my dotfiles repo in `~/dotiles`.

```bash
git clone https://github.com/nocksock/dotfiles.git
cd dotfiles
sh setup.sh
```

The setup script will create all the required symlinks and also temporary
directories that my vim config needs.

### Vim Setup

To install the vim plugins, run this in your terminal.

```bash
vim +PluginInstall
```

## nvim

I occasionaly start `nvim`, and there seem to be no issues. I know only little
about `nvim`, and intend to check it out at some point. Right now this is more
about vim.

