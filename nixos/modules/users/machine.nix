{pkgs, ...}: let
  keys = import ../globals/keys.nix;
in {
  users.users.machine = {
    isNormalUser = true;
    uid = 1001;
    home = "/home/machine";
    createHome = true;
    extraGroups = ["docker" "machine"];
    openssh.authorizedKeys.keys = [keys.users.machine.publicKey];
    shell = pkgs.bash;
    description = "Machine user for running Docker containers";
  };

  home-manager.users.machine = {pkgs, ...}: {
    home.packages = with pkgs; [
      docker-compose
      curl
      wget
      git
      jq
    ];

    programs = {
      bash.enable = true;
      git = {
        enable = true;
        userName = "Machine User";
        userEmail = "machine@localhost";
      };
    };

    home.stateVersion = "24.11";
  };
}
