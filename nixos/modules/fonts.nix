# System font packages
{ pkgs, ... }: {
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
}
