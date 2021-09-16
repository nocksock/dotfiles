#!/bin/bash

DOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "creating symlinks"

ln -s $DOT_DIR/.vim ~/.vim
ln -s $DOT_DIR/.vimrc ~/.vimrc
ln -s $DOT_DIR/.tmux.conf ~/.tmux.conf
ln -s $DOT_DIR/.zsh ~/.zsh
ln -s $DOT_DIR/.zshrc ~/.zshrc

git submodule init;
git submodule update;

if [ -d "~/.vim/tmp" ]; then
	echo "tmp folder already existings";
	exit 1;
else
	mkdir ~/.vim/tmp;
	mkdir ~/.vim/tmp/undo;
	mkdir ~/.vim/tmp/swap;
	mkdir ~/.vim/tmp/backup;
fi

echo "done";
