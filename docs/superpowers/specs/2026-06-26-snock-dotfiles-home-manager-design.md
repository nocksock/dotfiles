# Deploy nr's dotfiles to `snock` via home-manager

**Date:** 2026-06-26
**Status:** Approved (design)

## Problem

The `snock` server user is currently set up with stow on each new server. We want
the "proper Nix way": consume this dotfiles flake as an input and have
home-manager deploy the same shell/editor setup automatically on rebuild — no
manual stow.

The consuming flake (`~/projects/studio/infra/flake.nix`) **already** imports
`dotfiles.nixosModules.user-snock` for hosts `ada` and `edk`, pinning this repo
(`github:nocksock/dotfiles/nixos`) with `nixpkgs.follows` → **nixos-26.05**.
So the consumer side is done; all work is in **this** repo, enriching what
`user-snock` deploys.

Today `nixos/modules/users/snock.nix`'s home-manager block installs packages and
a few `programs.*` integrations but deploys **none of the actual dotfile
contents** (zshrc, nvim, tmux, starship, etc.).

## Goal

`snock` on a NixOS server gets the same CLI setup as `nr`'s desktop:
1. The core dotfile **contents** (the `setup-core` set), and
2. A package set aligned with `cli.nix`,

delivered declaratively through home-manager, updated by bumping the flake input
and running `nixos-rebuild switch`.

## Key finding: the `$DOTDIR` coupling

`zsh/dot-zshenv` loads shell plugins with:

```sh
ZSH_PLUGIN_PATH="$DOTDIR/zsh/dot-local/share/zsh"   # DOTDIR="$HOME/dotfiles"
for plugin in "$ZSH_PLUGIN_PATH"/*; do ... source ... done
```

So the shell config assumes the repo is checked out at `~/dotfiles`. A plain
`~/.zshrc`/`~/.zshenv` symlink alone would start a shell but load **zero**
plugins (`sbox`, `tmux`, `git`, `note`, `colors`, and the two vendored external
plugins `zsh-syntax-highlighting` / `zsh-history-substring-search`).

**Decision:** home-manager also creates `~/dotfiles` as a symlink to the flake
source in the Nix store. This single symlink makes `$DOTDIR` valid, so the plugin
loader — and any other `$DOTDIR`/`$HOME/dotfiles`-relative reference — works
**unchanged**. Most faithful to the desktop setup, least surgery, no divergence
from the source files. (Alternative considered: patch `DOTDIR`/plugin paths in
Nix — rejected for more surgery and source divergence.)

## Mechanism

Symlink the existing stow (`dot-`) files into place via home-manager
(`home.file` / `xdg.configFile`), encoding the `dot-` → `.` mapping in Nix.
Sources are the flake's store paths (immutable: push to GitHub + rebuild to
update). Rejected alternatives: rewriting every config as native HM `programs.*`
options (huge effort, second source of truth that drifts), and running `stow` in
an activation script (fights HM's own file management, needs a writable
checkout).

## Components

### 1. New reusable module `nixos/modules/home/dotfiles.nix`

A home-manager module (importable into any user's HM config) that materializes
the `setup-core` packages. Paths are relative to the repo root.

`home.file` entries:
- `.zshrc`            ← `zsh/dot-zshrc`
- `.zshenv`           ← `zsh/dot-zshenv`
- `.local/share/zsh/` ← `zsh/dot-local/share/zsh` (recursive — the plugins)
- `.tmux.conf`        ← `tmux/dot-tmux.conf`
- `.local/bin/tmux-pick-session` ← `tmux/dot-local/bin/tmux-pick-session`
- `.vimrc`            ← `vim/dot-vimrc`
- `.vim/`             ← `vim/dot-vim` (recursive)
- `.git-templates/`   ← `git/dot-git-templates` (recursive)
- `dotfiles`          ← repo root (the `~/dotfiles` symlink for `$DOTDIR`)

`xdg.configFile` entries:
- `nvim/`         ← `nvim/dot-config/nvim` (recursive)
- `atuin/`        ← `atuin/dot-config/atuin` (recursive)
- `lazygit/`      ← `lazygit/dot-config/lazygit` (recursive)
- `jj/`           ← `jj/dot-config/jj` (recursive)
- `zellij/`       ← `zellij/dot-config/zellij` (recursive)
- `starship.toml` ← `starship/dot-config/starship.toml`
- `rustic.toml`   ← `rustic/dot-config/rustic.toml`

Made reusable so `nr` could later drop manual stow too — out of scope for this
change.

### 2. Update `nixos/modules/users/snock.nix`

- `home-manager.users.snock.imports = [ ../home/dotfiles.nix ../cli.nix ]`
  (aligns packages with `cli.nix` as chosen).
- Keep server extras not present in `cli.nix`: `ttyd`, `just`, `ack`,
  `syncthing`. Drop entries now redundant with `cli.nix` (`atuin`, `fzf`,
  `direnv`, `entr`, `gh`, `lazygit`, `nodejs`, `asdf-vm`).
- **Remove** the HM `programs.{zsh,atuin,starship,direnv}` enables — `.zshrc`
  already runs `eval "$(starship init zsh)"`, `atuin init zsh`,
  `direnv hook zsh`, `zoxide init zsh`, `fzf --zsh` itself. Keeping the HM
  integrations would double-init and clash with the symlinked `~/.zshrc`. Tool
  **binaries** come from `cli.nix`/packages.
  - Note `cli.nix` sets `programs.zoxide.enableZshIntegration = true`; with no
    HM-managed zshrc this is a harmless no-op, but verify it produces no eval
    error/warning on rebuild. If it does, set `enableZshIntegration = false`
    there or override for snock.
- Keep system-level `programs.zsh.enable = true` (NixOS) so zsh is a valid login
  shell.
- Keep `home.stateVersion = "24.11"`.

## Data flow

Push to GitHub → `studio/infra` bumps the `dotfiles` flake input
(`nix flake update dotfiles`) → `nixos-rebuild switch --flake .#ada` (or `#edk`)
→ home-manager materializes the symlinks. No stow, no manual steps.

## Testing / verification

- `nix flake check` / `nixos-rebuild build` on a host (`ada`/`edk`) evaluates and
  builds the `snock` HM generation against **nixos-26.05**.
- Manual smoke test after switch: `su - snock`, confirm `~/.zshrc`, `~/.zshenv`,
  `~/.config/nvim`, `~/dotfiles` symlinks resolve into the store; open a login
  shell and confirm plugins load (no "Plugin X has no ..." warnings), `starship`
  prompt renders, `atuin`/`zoxide`/`fzf`/`direnv` are on `PATH` and initialized,
  `nvim` starts and bootstraps baggage.nvim into its data dir.

## Known follow-ups (non-blocking)

- `dot-zshenv` hardcodes `EDITOR=/usr/local/bin/nvim` (invalid on NixOS), used
  for non-interactive git commits. Make portable later (e.g. `command -v nvim`).
- `cli.nix` must evaluate on **nixos-26.05** (consumer's pin), not just unstable
  — e.g. `asdf-vm`, `nodejs`, `terraform` package availability. Verify on first
  rebuild; adjust per-package if needed.
- Config symlinks are read-only. nvim/atuin/lazygit/jj write to their *data/state*
  dirs (not the symlinked config dir), so this is fine; revisit if any tool needs
  to write back into its config path.
