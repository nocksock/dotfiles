# GNOME desktop environment
{pkgs, ...}: {
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  environment.systemPackages = with pkgs; [
    gnome-tweaks
  ];

  programs.dconf.profiles.user.databases = [
    {
      lockAll = true; # prevents overriding
      settings = {
        "org/gnome/desktop/input-sources" = {
          # xkb-options = ["ctrl:nocaps"];
          xkb-options = ["ctrl:nocaps,altwin:swap_lalt_lwin"];
        };
      };
    }
  ];

  # Uncomment to disable unwanted GNOME components
  # services.gnome.core-apps.enable = false;
  # services.gnome.core-developer-tools.enable = false;
  # services.gnome.games.enable = false;
  # environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];
}
