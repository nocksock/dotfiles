#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Installing dotfiles with stow...${NC}"

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    echo -e "${RED}Error: stow is not installed${NC}"
    echo "Please install stow first:"
    echo "  Ubuntu/Debian: sudo apt install stow"
    echo "  macOS: brew install stow"
    echo "  Arch: sudo pacman -S stow"
    exit 1
fi

# Install zsh plugins first
echo -e "${YELLOW}Installing zsh plugins...${NC}"
cd zsh/plugins
rm -rf zsh-*
git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting
git clone --quiet https://github.com/zsh-users/zsh-history-substring-search
git clone --quiet https://github.com/zsh-users/zsh-completions
git clone --quiet https://github.com/agkozak/zsh-z
cd ../..

# List of all dotfile packages
packages=(
    "alacritty"
    "atuin"
    "doom"
    "git"
    "ghostty"
    "hammerspoon"
    "helix"
    "herbstluftwm"
    "kitty"
    "mutt"
    "nvim"
    "polybar"
    "rofi"
    "sketchybar"
    "skhd"
    "starship"
    "tmux"
    "vim"
    "yabai"
    "zellij"
    "zsh"
)

# Stow each package
for package in "${packages[@]}"; do
    if [[ -d "$package" ]]; then
        echo -e "${YELLOW}Stowing $package...${NC}"
        stow -v "$package"
    else
        echo -e "${YELLOW}Skipping $package (directory not found)${NC}"
    fi
done

echo -e "${GREEN}Dotfiles installed successfully!${NC}"
echo -e "${YELLOW}Note: You may need to restart your shell or source your rc files${NC}"