{
  pkgs,
  config,
  home-manager,
  lib,
  ...
} @ inputs: {
  users.users.nr = {
    isNormalUser = true;
    description = "nils riedemann";
    extraGroups = ["networkmanager" "wheel" "video" "input" ];
  };

  home-manager.users.nr = {
    imports = [
      # TODO: I'm certain this can be done more elegantly
      (import ./nr/waybar.nix inputs)
      (import ./nr/wofi.nix inputs)
      (import ./nr/fonts.nix inputs)
    ];

    home.packages = with pkgs; [
      atuin
      btop
      clipse
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

    # TODO: define path in flake.nix
    home.activation.stowDotfiles = home-manager.lib.hm.dag.entryAfter ["writeBoundary"] ''
      cd ~/code/dotfiles
      ${pkgs.stow}/bin/stow --target $HOME --no-folding \
        stow zsh kitty nvim wofi niri vim git jj atuin \
        lazygit starship rofi
    '';

    home.stateVersion = "25.05";
  };
}
