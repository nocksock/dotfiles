# System76 COSMIC desktop environment
{ ... }: {
  imports = [
    ./greeter.nix
  ];

  services.desktopManager.cosmic.enable = true;
}
