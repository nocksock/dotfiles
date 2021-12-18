# Dotfiles

These are *some* of my dotfiles, personal configuration… things. ʕ •ᴥ•ʔ

At the moment this is practically boiled down to zsh, vim and tmux. Which is all
I need to be productive on the command line.

After years of VS Code usage and a short excursion with doom-emacs, I'm sort of
re-igniting my interest in vim. I write a lot of JavaScript, TypeScript in
combination with react. And this config relies heavily on plugins to get some of
the VS Code goodness, back into vim most of them provided by COC.

## Essential Requirements

- Vim
  - + node
  - + fzf
  - + rg
- Tmux
- Oh-My-ZSH

## Installation

My dotfiles are usually at `~/dotiles`.

```bash
git clone https://github.com/nocksock/dotfiles.git
cd dotfiles
./install
```

The setup script will create all the required symlinks and also temporary
directories that my vim config needs.

### Vim Setup

To install the vim plugins, run this in your terminal.

```bash
vim +PluginInstall
```

## about `nvim`

I occasionaly start `nvim`, and there seem to be no issues. I know only little
about `nvim`, and intend to check it out at some point. Right now I don't see
a reason to switch to nvim.

