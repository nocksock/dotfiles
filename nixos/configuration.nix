{ lib, pkgs, ... } @inputs: let
  inherit (pkgs.stdenv.hostPlatform) system;
in {
  imports = [
    ./users/nr.nix
  ];
# System {{{
  # Boot {{{

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  # boot.plymouth.enable = true;

  # }}}
  # Nix {{{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true; # eg. for tableplus
  nix.settings.experimental-features = ["nix-command" "flakes"];
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

  networking.hostName = "nixos"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [47984 47987 47989 48010];
  networking.firewall.allowedUDPPorts = [47998 47999 48000 48002 48010];

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

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
    zsh
    nushell
    runit

    kitty ghostty

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
    git
    links2
    vim
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
    stow
    nnn
    yazi

    iwmenu
    pwmenu
    bzmenu

    # Desktop
    xwayland xwayland-satellite
    fuzzel wofi tofi rofi # TODO: settle on one
    waybar
    swaybg
    blueberry
    libnotify
    wl-clipboard clipse
    wtype
    darkman
    apple-cursor

    # Common GUI Apps
    nautilus
    gnome-font-viewer
    loupe
    gradia
    planify
    cliphist
    flameshot

    bitwarden
    _1password _1password-gui
    firefox brave ungoogled-chromium
    blender
    gnome-calendar

    pamixer
    playerctl
    pavucontrol
    brightnessctl
    mako # notifications
    powertop # *top for power consumption
  ];

  # }}}
  # Fonts {{{

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    noto-fonts
    ibm-plex
    noto-fonts-emoji
    fira-code
    fira-sans
    nerd-fonts.caskaydia-mono
  ];

  # }}}
  # Niri {{{

  programs.niri.enable = true;

  # }}}
  # Gnome {{{


  services.xserver ={
    enable = true;
    xkb.layout = "eu";
    xkbOptions = "compose:ralt";

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

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
  programs.nix-ld.enable = true;
  security.rtkit.enable = true;
  hardware.bluetooth.enable = true;
  services.flatpak.enable = true;

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      # # uncomment to auto-login (eg. for remote reboot)
      initial_session = {
        command = "niri-session";
        user = "nr";
      };

      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri-session";
      };
    };
  };
}
