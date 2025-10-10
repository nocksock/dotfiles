#!/usr/bin/env zsh

if [[ -z $1 ]]; then
  echo "needs foldername"
  exit 1
fi;

rm -rf "$HOME/.config/$1"
mv "$1" _tmp
mkdir -p "$1/.config"
mv _tmp "$1/.config/$1"
stow $1
