# User configuration for 'nr' (primary desktop user)
{ pkgs, ... }: {
  users.users.nr = {
    isNormalUser = true;
    description = "nils riedemann";
    extraGroups = ["networkmanager" "openrazer" "wheel" "video" "input" "docker"];
  };

  home-manager.users.nr = {
    imports = [
      ../cli.nix
      ../home-desktop.nix
    ];
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.permittedInsecurePackages = [
      "electron-39.8.10"
    ];
    home.stateVersion = "25.05";
  };
}
