{
  config,
  pkgs,
  nix-colors,
  ...
}: {
  config = {
    home.file = {
      ".zshrc".source = config.home-manager.users.nr.lib.file.mkOutOfStoreSymlink "/home/nr/code/dotfiles/zsh/.zshrc";
      ".zshenv".source = config.home-manager.users.nr.lib.file.mkOutOfStoreSymlink "/home/nr/code/dotfiles/zsh/.zshenv";
    };
  };
}
