{config, ...} : {
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
  networking.firewall.allowedTCPPorts = [ 47984 47987 47989 48010 ];
  networking.firewall.allowedUDPPorts = [ 47998 47999 48000 48002 48010 ];

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
