# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managing configurations across multiple systems (NixOS and macOS) using GNU Stow for symlinking and Nix flakes for NixOS system configuration.

## System Setup Commands

### Stow-based Setup (Non-NixOS)
- `./setup-core` - Install core CLI configurations (zsh, git, nvim, tmux, vim, atuin, lazygit, jj, starship, zellij, rustic)
- `./setup-linux-desktop` - Install Linux desktop configurations (runs setup-core first, then adds nox-menu and linux-desktop)
- `./setup-macos` - Install macOS configurations (core, gui, macos)

### NixOS System Management
- `sudo nixos-rebuild switch --flake .#blade` - Rebuild system for the Razer Blade machine
- `sudo nixos-rebuild switch --flake .#nixos` - Rebuild system for the generic NixOS machine
- `nix flake update` - Update flake inputs (nixpkgs, home-manager, quickshell, noctalia)

## Architecture

### Configuration Management Strategy
The repository uses a dual approach:
1. **Stow for symlinking**: Individual configuration packages in subdirectories (e.g., `nvim/`, `zsh/`, `git/`) are symlinked via stow. Files prefixed with `dot-` are renamed to `.` during symlinking.
2. **Nix flakes for NixOS**: The `nixos/` directory contains declarative NixOS system configuration with Home Manager integration.

### Key Directory Structure
- `nvim/dot-config/nvim/` - Neovim configuration using baggage.nvim as plugin manager
- `linux-desktop/` - Niri window manager configuration, custom scripts, and runit services
- `nox-menu/` - Custom application launcher system built on fuzzel
- `zsh/` - Shell configuration with custom plugins in `dot-local/share/zsh/`
- `nixos/` - NixOS system and Home Manager configuration
  - `configuration.nix` - Base system configuration
  - `home/cli.nix` - CLI tool packages
  - `home/desktop.nix` - Desktop environment packages and PWA definitions
  - `machines/` - Machine-specific configurations

### Niri Window Manager
The primary window manager is Niri (Wayland scrollable tiling compositor). Configuration is in `linux-desktop/dot-config/niri/config.kdl`:
- Uses Super (Mod) key as primary modifier
- Extensive custom keybindings (e.g., Mod+Return for kitty, Mod+Space for fuzzel)
- Custom scripts for window management: `niri-focus-or-spawn`, `niri-split`, `niri-tiling`
- Services managed via runit in `linux-desktop/dot-local/services/`

### Custom Service Management
Services are managed using runit and started via `runsvdir ~/services/` (configured in niri startup):
- `wallpaper/` - Dynamic wallpaper based on color scheme (dark/light)
- `waybar/` - Status bar
- `cliphist/` - Clipboard history
- `color-scheme-watch/` - Monitors GNOME color scheme changes
- `now/` - Personal note-taking service

### nox-menu System
A custom fuzzel-based launcher system (`nox-menu/dot-local/bin/nox-menu`):
- Actions stored in `~/.local/share/nox-menu/`
- Hierarchical navigation: directories become submenus, executables are actions
- Special integration with Niri (Mod+X to launch, Mod+N for notes)

### Neovim Configuration
- Uses baggage.nvim as a minimal plugin manager (bootstrapped on first run)
- Configuration split across:
  - `init.lua` - Core settings and bootstrap
  - `plugin/*.lua` - Plugin configurations loaded automatically
  - `after/plugin/lsp/*.lua` - LSP configurations per language
  - `lsp/` - LSP server configurations
- Helper functions: `R` (reload module), `P` (print inspect), `TAP` (inspect and return)

### ZSH Configuration
- Custom plugins/utilities in `zsh/dot-local/share/zsh/`:
  - `git/` - Git utilities
  - `sbox/` - Sandbox environment management (SBOX_DIR for quick project access)
  - `tmux/` - tmux integration
  - `colors/` - Terminal color utilities
- Uses external plugins: zsh-syntax-highlighting, zsh-history-substring-search

### NixOS Flake Structure
The `flake.nix` defines two NixOS configurations:
- `blade` - Razer Blade laptop (uses `nixos/machines/razer-blade/`)
- `nixos` - Generic system (uses `nixos/hardware-configuration.nix`)

Both configurations:
- Use nixpkgs unstable channel
- Integrate Home Manager as NixOS module
- Include custom flake inputs (quickshell, noctalia shell)
- Have experimental features enabled (nix-command, flakes)

## Development Patterns

### Adding New Dotfiles
1. Create directory named after application (e.g., `myapp/`)
2. Place config files in appropriate subdirectories prefixed with `dot-` (e.g., `dot-config/myapp/config.yml`)
3. Add to appropriate setup script's stow command

### Modifying NixOS Configuration
1. Edit files in `nixos/` directory
2. Test changes: `sudo nixos-rebuild switch --flake .#<hostname>`
3. Changes to `home/*.nix` affect user packages, changes to `configuration.nix` affect system

### Custom Niri Keybindings
When adding keybindings in `linux-desktop/dot-config/niri/config.kdl`:
- Use `spawn-sh` for shell commands
- Use `spawn` for direct binary execution
- Add `hotkey-overlay-title` for documentation in the overlay (Mod+Shift+/)
- Test with `niri msg` commands before adding permanent bindings

### Creating Services
1. Create directory in `linux-desktop/dot-local/services/<service-name>/`
2. Add executable `run` script
3. Service auto-starts via runsvdir on niri startup
4. Control with `sv` commands (e.g., `sv status ~/services/<service-name>`)
