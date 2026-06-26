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
