{ ... }: {
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
      ./nr/cli.nix
      ./nr/desktop.nix
    ];
    nixpkgs.config.allowUnfree = true;

    home.stateVersion = "25.05";
  };
}
