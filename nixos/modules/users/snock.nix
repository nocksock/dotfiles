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
