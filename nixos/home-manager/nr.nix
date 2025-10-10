{
  config,
  pkgs,
  nix-colors,
  home-manager,
  ...
} @ attrs: {
  imports = [
    # TODO: I'm certain this can be done more elegantly
    (import ./waybar.nix attrs)
    (import ./zsh.nix attrs)
    (import ./wofi.nix attrs)
    (import ./fonts.nix attrs)
  ];

  home.packages = with pkgs; [
    atuin
    btop
    clipse
    ffmpeg

    # dev-tools
    devenv
    direnv
    lazydocker
    neovim
    lazygit
    gh
    jq

    # gui tools
    brave
    nautilus
    zeal
    discord
    obsidian
    syncthing
  ];

  programs.direnv.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  systemd.user.tmpfiles.rules = [
    "L+ /home/nr/.config/niri - - - - /home/nr/code/nixos/config/niri"
  ];

  home.stateVersion = "25.05";
}
