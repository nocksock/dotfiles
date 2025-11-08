{
  lib,
  pkgs,
  ...
} @ inputs: let
  inherit (pkgs.stdenv.hostPlatform) system;
in {
  imports = [];

  virtualisation.docker = {
    enable = true;
  };

  # System {{{
  # Boot {{{

  boot.kernelParams = ["button.lid_init_state=open"];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  # }}}
  # Nix {{{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true; # eg. for tableplus
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-users = ["nr" "root"];
  nix.extraOptions = ''
    extra-substituters = https://devenv.cachix.org
    extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  # }}}
  # Network {{{

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    # sunshine/moonlight
    47984
    47987
    47989
    48010
    # syncthing
    22000
  ];
  networking.firewall.allowedUDPPorts = [
    # sunshine/moonlight
    47998
    47999
    48000
    48002
    48010

    # syncthing
    22000
    21027
  ];

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.hosts = {
    "188.245.39.71" = ["blpblp.io" "budget.blpblp.io"];
  };

  # }}}
  # locale {{{

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

  # }}}
  # GPU {{{

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.open = true;
  hardware.nvidia.nvidiaSettings = true;

  # }}}
  # Audio {{{

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # }}}
  # }}}
  # System Level Packages {{{
  environment.systemPackages = with pkgs; [
    # Core system utilities
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
    mako # notification daemon

    # Hardware control
    pamixer
    playerctl
    brightnessctl
    powertop
    blueberry # bluetooth manager
  ];

  # }}}
  # User Setup {{{

  users.users.nr = {
    isNormalUser = true;
    description = "nils riedemann";
    extraGroups = ["networkmanager" "openrazer" "wheel" "video" "input" "docker"];
  };

  home-manager.users.nr = {
    imports = [
      ./home/cli.nix
      ./home/desktop.nix
    ];
    nixpkgs.config.allowUnfree = true;
    home.stateVersion = "25.05";
  };

  # }}}
  # Fonts {{{

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    dina-font
    fira-code
    fira-code-symbols
    fira-sans
    ibm-plex
    liberation_ttf
    mplus-outline-fonts.githubRelease
    nerd-fonts.caskaydia-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    proggyfonts
  ];

  # }}}
  # Niri {{{

  programs.niri.enable = true;

  # }}}
  # Gnome {{{

  console.useXkbConfig = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    options = "ctrl:nocaps";
  };

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # services.gnome.core-apps.enable = false;
  # services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  # environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];

  # }}}
  # 1Password {{{

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "1password-gui"
      "1password"
    ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = ["nr"];
  };

  # }}}

  # Miscellaneous

  services.tailscale.enable = true;
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  programs.xwayland.enable = true;
  programs.hyprland.enable = true;
  programs.nix-ld.enable = true;
  security.rtkit.enable = true;
  hardware.bluetooth.enable = true;
  services.flatpak.enable = true;

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "niri-session";
        user = "nr";
      };

      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
      };
    };
  };
}
