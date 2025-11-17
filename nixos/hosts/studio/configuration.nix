{...}: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "studio";
  networking.domain = "";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKvwpMNCPRDapiEGHKpvCpQvrDPtQMbAONFB/J7MEoPO''];
  system.stateVersion = "23.11";

  systemd.tmpfiles.rules = [
    "d /var/lib/studio 0777 machine docker - -"
    "d /var/lib/studio/content 0777 machine docker - -"
    "f /var/lib/studio/studio_prod.db 0666 machine docker - -"
    "Z /var/lib/studio/content 0777 machine docker - -"
  ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 22 443 8080 4000];
  };
}
