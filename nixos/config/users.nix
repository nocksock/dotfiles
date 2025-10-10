{ inputs, pkgs, ...}: {
  users.defaultUserShell = pkgs.zsh;
  users.users.nr = {
    isNormalUser = true;
    description = "nils riedemann";
    extraGroups = ["networkmanager" "wheel" "video" "input" ];
    packages = with pkgs; [ 
      zsh
    ];

    shell = pkgs.zsh;
  };

  home-manager.users.nr = import ./users/nr.nix inputs;
}
