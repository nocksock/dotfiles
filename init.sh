#!/bin/bash

ln -s dotfiles/dotvim/vim ~/.vim
ln -s dotfiles/dotvim/vimrc ~/.vimrc

ln -s dotfiles/dottmux/tmux.conf ~/.tmux.conf
ln -s dotfiles/dotzsh/zsh ~/.zsh
ln -s dotfiles/dotzsh/zshrc ~/.zshrc
ln -s dotfiles/oh-my-zsh ~/.oh-my-zsh

git submodule init;
git submodule update;
cd dotvim;
git submodule init;
git submodule update;

mkdir ~/.vim/tmp;
mkdir ~/.vim/tmp/undo;
mkdir ~/.vim/tmp/swap;
mkdir ~/.vim/tmp/backup;
