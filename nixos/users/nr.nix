{
  pkgs,
  home-manager,
  ...
} @ inputs: {
  users.users.nr = {
    isNormalUser = true;
    description = "nils riedemann";
    extraGroups = ["networkmanager" "wheel" "video" "input"];
  };

  # services.immich.enable = true;
  # services.immich.port = 2283;

  home-manager.users.nr = {
    imports = [
      ./nr/wofi.nix
      ./nr/fonts.nix
    ];

    home.packages = with pkgs; [
      # cli
      atuin
      btop
      htop
      killall
      ffmpeg

      # dev-tools
      devenv
      direnv
      lazydocker
      neovim
      lazygit
      gh
      jq
      jujutsu

      zeal
      obsidian
      lmstudio
      discord
      gimp
      krita
      cider-2
      tableplus

      _1password-gui
      _1password

      # misc
      syncthing
      icloudpd
      libheif
    ];

    programs.direnv.enable = true;
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    # TODO: define path in flake.nix
    home.activation.stowDotfiles = home-manager.lib.hm.dag.entryAfter ["writeBoundary"] ''
      cd ~/code/dotfiles
      ${pkgs.stow}/bin/stow --target $HOME --no-folding \
        stow zsh kitty nvim wofi niri vim git jj atuin \
        lazygit starship rofi waybar services
    '';

    home.stateVersion = "25.05";
  };
}
