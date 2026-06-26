# snock Dotfiles via home-manager — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make `dotfiles.nixosModules.user-snock` deploy nr's core CLI dotfiles and an aligned package set to the `snock` user via home-manager, so a consuming flake (`studio/infra`) gets the full setup on `nixos-rebuild` with no stow.

**Architecture:** Add a reusable home-manager module that symlinks the existing stow (`dot-`) files into snock's home (encoding `dot-` → `.` in Nix, sourced from the flake's store paths), plus a `~/dotfiles` symlink so the shell config's `$DOTDIR` plugin loader works unchanged. Wire that module + `cli.nix` into `snock.nix` and drop the now-conflicting `programs.*` integrations.

**Tech Stack:** Nix flakes, home-manager (as a NixOS module), zsh/nvim/tmux/etc. dotfiles.

**No commits:** This session is set to no-commit. Use checkpoints; do not run `git commit` unless the user explicitly asks.

**Reference spec:** `docs/superpowers/specs/2026-06-26-snock-dotfiles-home-manager-design.md`

---

## File Structure

- **Create** `nixos/modules/home/dotfiles.nix` — reusable HM module; symlinks core dotfiles + `~/dotfiles`. One responsibility: materialize the `setup-core` config files into a home.
- **Modify** `nixos/modules/users/snock.nix` — import `dotfiles.nix` + `cli.nix`, trim packages to server-only extras, remove conflicting `programs.*`.

Path note: `nixos/modules/home/dotfiles.nix` is three directories below the repo root, so the repo root is `../../..` from inside that file. `nixos/modules/users/snock.nix` imports the new module as `../home/dotfiles.nix` and the existing CLI module as `../cli.nix`.

---

### Task 1: Create the reusable dotfiles home-manager module

**Files:**
- Create: `nixos/modules/home/dotfiles.nix`

- [ ] **Step 1: Create the module file**

Create `nixos/modules/home/dotfiles.nix` with exactly this content:

```nix
# Reusable home-manager module: deploys the core CLI dotfiles
# (the `setup-core` stow set) by symlinking the repo's `dot-` files into
# the user's home. Sources resolve to the flake's store paths (immutable;
# push + rebuild to update). Also provides a `~/dotfiles` symlink so shell
# config that references `$DOTDIR` (e.g. the zshenv plugin loader) works.
{...}: let
  # repo root, relative to this file (nixos/modules/home/dotfiles.nix)
  root = ../../..;
in {
  home.file = {
    ".zshrc".source = root + "/zsh/dot-zshrc";
    ".zshenv".source = root + "/zsh/dot-zshenv";
    ".local/share/zsh" = {
      source = root + "/zsh/dot-local/share/zsh";
      recursive = true;
    };

    ".tmux.conf".source = root + "/tmux/dot-tmux.conf";
    ".local/bin/tmux-pick-session" = {
      source = root + "/tmux/dot-local/bin/tmux-pick-session";
      executable = true;
    };

    ".vimrc".source = root + "/vim/dot-vimrc";
    ".vim" = {
      source = root + "/vim/dot-vim";
      recursive = true;
    };

    ".git-templates" = {
      source = root + "/git/dot-git-templates";
      recursive = true;
    };

    # ~/dotfiles -> flake source in the store, satisfies $DOTDIR references
    "dotfiles".source = root;
  };

  xdg.configFile = {
    "nvim" = {
      source = root + "/nvim/dot-config/nvim";
      recursive = true;
    };
    "atuin" = {
      source = root + "/atuin/dot-config/atuin";
      recursive = true;
    };
    "lazygit" = {
      source = root + "/lazygit/dot-config/lazygit";
      recursive = true;
    };
    "jj" = {
      source = root + "/jj/dot-config/jj";
      recursive = true;
    };
    "zellij" = {
      source = root + "/zellij/dot-config/zellij";
      recursive = true;
    };
    "starship.toml".source = root + "/starship/dot-config/starship.toml";
    "rustic.toml".source = root + "/rustic/dot-config/rustic.toml";
  };
}
```

- [ ] **Step 2: Confirm every referenced source path exists in the repo**

Run from the repo root:

```bash
for p in \
  zsh/dot-zshrc zsh/dot-zshenv zsh/dot-local/share/zsh \
  tmux/dot-tmux.conf tmux/dot-local/bin/tmux-pick-session \
  vim/dot-vimrc vim/dot-vim git/dot-git-templates \
  nvim/dot-config/nvim atuin/dot-config/atuin lazygit/dot-config/lazygit \
  jj/dot-config/jj zellij/dot-config/zellij \
  starship/dot-config/starship.toml rustic/dot-config/rustic.toml; do
  [ -e "$p" ] && echo "OK   $p" || echo "MISS $p"
done
```

Expected: every line prints `OK ...`. If any prints `MISS`, stop and fix the path in `dotfiles.nix` before continuing.

- [ ] **Step 3: Parse-check the new module**

Run:

```bash
nix-instantiate --parse nixos/modules/home/dotfiles.nix >/dev/null && echo "parse ok"
```

Expected: prints `parse ok` (no syntax errors).

---

### Task 2: Wire the module into snock and trim packages

**Files:**
- Modify: `nixos/modules/users/snock.nix`

- [ ] **Step 1: Replace the `home-manager.users.snock` block**

In `nixos/modules/users/snock.nix`, replace the entire `home-manager.users.snock = {pkgs, ...}: { ... };` block (the `home.packages`, the `programs = { ... }`, and `home.stateVersion` lines) with:

```nix
  home-manager.users.snock = {pkgs, ...}: {
    imports = [
      ../home/dotfiles.nix
      ../cli.nix
    ];

    # Server-only extras not already provided by cli.nix
    home.packages = with pkgs; [
      ttyd
      just
      ack
      syncthing
    ];

    home.stateVersion = "24.11";
  };
```

Leave the `users.users.snock = { ... };` block and the top-level `programs.zsh.enable = true;` line untouched — the system-level zsh stays enabled so it remains a valid login shell.

- [ ] **Step 2: Verify the resulting file**

The full file should now read:

```nix
# User configuration for 'snock' (primary admin user on servers)
{pkgs, ...}: let
  keys = import ../keys.nix;
in {
  users.users.snock = {
    isNormalUser = true;
    home = "/home/snock";
    createHome = true;
    extraGroups = ["wheel" "snock"];
    openssh.authorizedKeys.keys = [keys.users.snock.publicKey];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  home-manager.users.snock = {pkgs, ...}: {
    imports = [
      ../home/dotfiles.nix
      ../cli.nix
    ];

    # Server-only extras not already provided by cli.nix
    home.packages = with pkgs; [
      ttyd
      just
      ack
      syncthing
    ];

    home.stateVersion = "24.11";
  };
}
```

Confirm the file matches (note: the `programs.{atuin,direnv,zsh,starship}` block and the long old package list are now gone; `.zshrc` itself runs `starship init` / `atuin init` / `direnv hook` / `zoxide init`, so those HM integrations are intentionally dropped to avoid double-init and clashing with the symlinked `~/.zshrc`).

- [ ] **Step 3: Parse-check the modified file**

Run:

```bash
nix-instantiate --parse nixos/modules/users/snock.nix >/dev/null && echo "parse ok"
```

Expected: prints `parse ok`.

---

### Task 3: Evaluate and build the snock home-manager generation

This validates that the whole thing evaluates and that every symlink source resolves — caught locally before pushing. `coworker` is the `x86_64-linux` host in this flake that imports `snock.nix`, so we build snock's HM generation through it. (This builds against this repo's `nixpkgs-unstable`; the consumer's `nixos-26.05` build is verified separately on the real server — see the spec's known follow-ups.)

- [ ] **Step 1: Confirm the file list home-manager will manage**

Run:

```bash
nix eval --json \
  '.#nixosConfigurations.coworker.config.home-manager.users.snock.home.file' \
  --apply builtins.attrNames
```

Expected: a JSON array including at least
`".zshrc"`, `".zshenv"`, `".local/share/zsh"`, `".tmux.conf"`,
`".local/bin/tmux-pick-session"`, `".vimrc"`, `".vim"`, `".git-templates"`,
and `"dotfiles"`. If evaluation errors, fix the reported file/attr before
continuing.

- [ ] **Step 2: Build the snock activation package**

Run:

```bash
nix build --no-link --print-out-paths \
  '.#nixosConfigurations.coworker.config.home-manager.users.snock.home.activationPackage'
```

Expected: succeeds and prints a `/nix/store/...-home-manager-generation` path.
A failure here that mentions a missing source path means a `dot-` mapping in
`dotfiles.nix` is wrong — fix and rebuild. A failure mentioning an
`assertion`/option collision means a leftover `programs.*` conflicts with the
symlinked files — re-check Task 2 Step 1.

- [ ] **Step 3: Spot-check the realized symlinks in the generation**

Run (uses the out path from Step 2; re-run the build to capture it if needed):

```bash
gen=$(nix build --no-link --print-out-paths \
  '.#nixosConfigurations.coworker.config.home-manager.users.snock.home.activationPackage')
ls -l "$gen/home-files/.zshrc" "$gen/home-files/dotfiles" \
      "$gen/home-files/.config/nvim" "$gen/home-files/.config/starship.toml"
```

Expected: each is a symlink pointing into `/nix/store/...` (the flake source).
`.zshrc` → the `dot-zshrc` store path, `dotfiles` → the repo source store path,
`.config/nvim` → the nvim config store path.

---

## Post-implementation: real-server verification (manual, on the server)

Not part of the local task loop — do this after the change is pushed and the
consumer flake input is bumped:

1. In `~/projects/studio/infra`: `nix flake update dotfiles` then
   `sudo nixos-rebuild switch --flake .#ada` (or `.#edk`). This is the
   authoritative **nixos-26.05** build.
2. `su - snock`; open a login shell. Confirm:
   - No `Huh? Plugin X has no ...` warnings (plugin loader found `$DOTDIR`).
   - `starship` prompt renders; `atuin`, `zoxide`, `fzf`, `direnv` are on `PATH`
     and initialized.
   - `nvim` starts and bootstraps baggage.nvim into its data dir.
   - `~/.zshrc`, `~/.zshenv`, `~/.config/nvim`, `~/dotfiles` resolve into the
     store.

---

## Self-Review notes

- **Spec coverage:** dotfiles.nix mappings (Task 1) cover every `home.file` /
  `xdg.configFile` entry and the `~/dotfiles` symlink from the spec; snock.nix
  changes (Task 2) cover the `cli.nix` import, server extras, and removal of the
  conflicting `programs.*`; local eval/build + manual server steps (Task 3 +
  post-impl) cover the spec's testing section and the nixos-26.05 follow-up.
- **Placeholders:** none — all file contents and commands are concrete.
- **Naming consistency:** `root = ../../..`, attribute keys (`".zshrc"`,
  `"dotfiles"`, `"starship.toml"`, …) and the `coworker` eval/build attribute
  path are used identically across tasks.
