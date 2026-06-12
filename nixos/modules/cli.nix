# Home Manager module for CLI tools and development packages
{pkgs, ...}: {
  home.packages = with pkgs; [
    # Shells
    nushell

    # Language toolchains
    gcc
    zig
    gnumake
    cargo
    rustc
    nodejs
    python3
    alejandra

    asdf-vm

    # CLI utilities
    atuin
    btop
    htop
    killall
    ffmpeg
    lolcat
    boxes
    ripgrep
    fd
    tmux
    fzf
    entr
    tree
    starship
    eza
    zoxide
    stow
    links2
    yt-dlp
    moreutils

    # File managers (TUI)
    nnn
    yazi

    # Dev tools
    direnv
    lazydocker
    neovim
    lazygit
    gh
    jq
    htmlq
    jujutsu
    podman
    cloudflared
    terraform

    # Server utilities
    rsync
    unzip
    curl
    wget
    icu
  ];

  programs.direnv.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
