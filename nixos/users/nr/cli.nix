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

    # File managers (TUI)
    nnn
    yazi

    # Dev tools
    devenv
    direnv
    lazydocker
    neovim
    lazygit
    gh
    jq
    jujutsu

    # Server utilities
    rsync
    unzip
    curl
    wget
  ];

  programs.direnv.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
