# Base NixOS configuration for desktop machines
{
  lib,
  pkgs,
  ...
}: {
  # Boot
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = ["button.lid_init_state=open"];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  # Nix
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-users = ["nr" "root"];
  nix.extraOptions = ''
    extra-substituters = https://devenv.cachix.org https://vicinae.cachix.org
    extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw= vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=
  '';
  system.stateVersion = "25.05";

  # Networking
  networking.networkmanager.enable = true;
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [
    # # sunshine/moonlight
    # 47984
    # 47987
    # 47989
    # 48010 
    # syncthing
    22000 
    4000
    # localsend
    53317 
  ];
  networking.firewall.allowedUDPPorts = [
    # # sunshine/moonlight
    # 47998
    # 47999
    # 48000
    # 48002
    # 48010 
    # syncthing
    4000
    22000
    21027 
    # localsend
    53317 
  ];

  # Locale
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Keyboard
  services.xserver.xkb = {
    layout = "eu";
    options = "ctrl:nocaps";
  };
  console.useXkbConfig = true;

  # Shell
  users.defaultUserShell = pkgs.zsh;

  # Wayland/X11
  programs.xwayland.enable = true;
  services.xserver.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-wlr];
  };

  # Hardware
  hardware.opentabletdriver.enable = true;

  # Core system packages
  environment.systemPackages = with pkgs; [
    zsh
    git
    vim
    curl
    wget
    rsync
    unzip
    starship
    xwayland
    xwayland-satellite
    libnotify
    wl-clipboard
    darkman
    mako
    brightnessctl
    powertop

    hyprlock
    hypridle
    hyprpicker
    grimblast
    gpu-screen-recorder
    hyprsunset
  ];


  programs.gpu-screen-recorder.enable = true; 
  programs.hyprland.enable = true;
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.mullvad-vpn.enable = true;
}
