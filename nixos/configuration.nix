# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, ... } @ inputs: {
  imports = [
    ./config/1password.nix
    ./config/locale.nix
    ./config/audio.nix
    ./config/network.nix
    ./users/nr.nix
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.extraOptions = ''
    extra-substituters = https://devenv.cachix.org
    extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
  '';

  nixpkgs.config.allowUnfree = true;
  security.rtkit.enable = true;

  hardware.bluetooth.enable = true;

  environment.systemPackages = with pkgs; [
    zsh
    git
    jujutsu
    links2
    vim

    blueberry
    libnotify
    wl-clipboard

    # language tools
    gcc
    zig
    gnumake
    cargo
    rustc
    nodejs
    python3
    alejandra

    # cli utils
    unzip
    ripgrep
    fd
    curl
    wget
    tmux
    fzf
    rsync
    entr
    tree

    starship
    eza
    zoxide
    kitty
    alacritty
    ghostty

    # ui
    powertop
    mako
    ibm-plex

    # todo: settle on one
    fuzzel wofi tofi rofi

    # Desktop
    playerctl
    pavucontrol
    brightnessctl
    pamixer
    bitwarden
    _1password-gui
    _1password
    xwayland
    xwayland-satellite
    firefox
  ];

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri-session";
      };
    };
  };

  services.tailscale.enable = true;
  users.defaultUserShell = pkgs.zsh;

  programs.xwayland.enable = true;
  programs.niri.enable = true;
  programs.zsh.enable = true;
    # enable = true;
    # # TODO: tag after build? (to mitigate drift)
    # shellAliases = {
    #   nixos-rebuild = "nixos-rebuild-and-tag";
    # };
    # initExtra = ''
    #   nixos-rebuild-and-tag() {
    #     sudo nixos-rebuild "$@" \
    #   }
    # '';


  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    nerd-fonts.caskaydia-mono
  ];

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # services.gnome.core-apps.enable = false;
  # services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  # environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
