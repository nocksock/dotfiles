{
  pkgs,
  home-manager,
  ...
}: {
  users.users.nr = {
    isNormalUser = true;
    description = "nils riedemann";
    extraGroups = ["networkmanager" "wheel" "video" "input"];
  };
  services.immich.enable = true;
  services.immich.port = 2283;

  home-manager.users.nr = {
    imports = [
      ./nr/wofi.nix
      ./nr/fonts.nix
    ];

    home.packages = with pkgs; [
      # wayland
      clipse

      # cli
      atuin
      btop
      ffmpeg
      stow

      # dev-tools
      devenv
      direnv
      lazydocker
      neovim
      lazygit
      gh
      jq

      # launcher
      # todo: settle on one
      fuzzel
      wofi
      tofi
      rofi

      # gui tools
      playerctl
      pavucontrol
      brightnessctl
      pamixer
      xwayland
      xwayland-satellite
      waybar
      swaybg
      powertop
      mako
      ibm-plex

      firefox
      brave
      nautilus
      zeal
      discord
      obsidian
      lmstudio

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
        lazygit starship rofi waybar
    '';

    systemd.user.services.icloudpd = {
      Unit = {
        Description = "iCloudPD Photo Downloader";
        After = ["network-online.target"];
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.icloudpd}/bin/icloudpd --username moin@nilsriedemann.de --directory %h/Pictures/Photos --watch-with-interval 3600";
        Restart = "on-failure";
        RestartSec = 60;
      };

      Install = {
        WantedBy = ["default.target"];
      };
    };

    home.stateVersion = "25.05";
  };
}
