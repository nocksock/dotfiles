{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Terminal emulators
    kitty
    ghostty
    
    # Desktop environment components
    fuzzel wofi tofi rofi dmenu

    waybar
    swaybg
    wtype
    clipse
    cliphist
    flameshot
    apple-cursor
    iwmenu
    pwmenu
    bzmenu
    
    # GUI file managers & utilities
    nautilus
    kdePackages.dolphin
    gnome-font-viewer
    loupe
    gradia
    planify
    pavucontrol
    
    # Browsers
    firefox
    brave
    ungoogled-chromium
    qutebrowser
    
    # Password managers
    _1password
    _1password-gui
    bitwarden
    
    # Creative apps
    blender
    gimp
    krita
    darktable
    digikam
    
    # Communication
    discord
    signal-desktop
    signal-cli
    
    # AI/ML tools
    ollama-cuda
    lmstudio
    
    # Other apps
    zeal
    obsidian
    cider-2
    syncthing
    icloudpd

    # libraries, file formats
    libheif
  ];
}
