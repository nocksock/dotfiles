{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # shells
    zsh
    bash
    nushell
    stow
    starship

    # development
    tmux
    vim
    neovim
    git
    jj
    curl
    wget
    jq
    tree
    coreutils
    moreutils
    btop
    ripgrep
    fd

    inotify-tools
    libnotify

    # networking
    mosh
    fail2ban
    rsync
  ];

  services.atd.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  environment.variables = {
    SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
    ERL_SSL_PATH = "${pkgs.cacert}/etc/ssl/certs";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };

  nix = {
    settings = {
      trusted-users = ["root" "@wheel"];
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  services.fail2ban = {
    enable = true;
    maxretry = 3;
    ignoreIP = ["100.0.0.0/10"]; # Ignore Tailscale IPs
  };

  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      PasswordAuthentication = false; # only allow login via SSH publickey
      # PermitRootLogin = "no"; # disable any kind of root login
    };
    extraConfig = ''
      PubkeyAuthentication yes
      MaxAuthTries 10
      LoginGraceTime 30
    '';
  };

  # services.tailscale = {
  #   openFirewall = true;
  #   extraUpFlags = [ "--ssh" ];
  # };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      "insecure-registries" = ["repo.hamster-climb.ts.net" "repo.bleepbloop.studio"];
      "log-driver" = "json-file";
      "log-opts" = {
        "max-size" = "10m";
        "max-file" = "3";
      };
    };
  };
}
