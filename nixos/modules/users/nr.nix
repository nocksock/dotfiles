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
    home.stateVersion = "25.05";
  };
}
