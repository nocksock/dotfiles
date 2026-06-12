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
    shell = pkgs.nushell;
  };

  programs.zsh.enable = true;

  home-manager.users.snock = {pkgs, ...}: {
    home.packages = with pkgs; [
      atuin
      ack
      fzf
      ttyd

      direnv
      entr
      just

      gh
      lazygit
      syncthing

      asdf-vm
      nodejs # default LTS; nodejs_23 was removed from nixpkgs
    ];

    programs = {
      atuin = {
        enable = true;
        flags = ["--disable-up-arrow"];
      };

      direnv.enable = true;
      zsh.enable = true;
      zsh.initExtra = ''
        export VISUAL=vim
        export EDITOR="$VISUAL"
      '';

      starship.enable = true;
    };

    home.stateVersion = "24.11";
  };
}
