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

  # The shared zshrc forces TERM=xterm-kitty (a kitty assumption from the
  # desktop); ship kitty's terminfo so SSH sessions resolve it instead of
  # erroring with "can't find terminal definition for xterm-kitty".
  environment.systemPackages = [pkgs.kitty.terminfo];

  # On a server previously set up with stow, pre-existing dotfiles would block
  # activation. Back them up (e.g. ~/dotfiles -> ~/dotfiles.hm-bak) instead of
  # failing; harmless on a fresh server where nothing conflicts.
  home-manager.backupFileExtension = "hm-bak";

  home-manager.users.snock = {pkgs, ...}: {
    imports = [
      ../home/dotfiles.nix
      ../cli.nix
    ];

    # cli.nix pulls in unfree packages (e.g. terraform); allow them here so
    # `user-snock` stays self-contained for any consuming flake. Mirrors nr.nix.
    nixpkgs.config.allowUnfree = true;

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
