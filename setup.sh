#!/bin/bash

ln -s .vim ~/.vim
ln -s .vimrc ~/.vimrc
ln -s .tmux.conf ~/.tmux.conf
ln -s .zsh ~/.zsh
ln -s .zshrc ~/.zshrc

git submodule init;
git submodule update;

mkdir ~/.vim/tmp;
mkdir ~/.vim/tmp/undo;
mkdir ~/.vim/tmp/swap;
mkdir ~/.vim/tmp/backup;
