# GNOME desktop environment
{ pkgs, ... }: {
  services.desktopManager.gnome.enable = true;

  # Uncomment to use GDM as display manager
  # services.displayManager.gdm.enable = true;

  # Uncomment to disable unwanted GNOME components
  # services.gnome.core-apps.enable = false;
  # services.gnome.core-developer-tools.enable = false;
  # services.gnome.games.enable = false;
  # environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];
}
