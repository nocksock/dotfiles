# Caddy reverse proxy for local development
{ ... }: {
  networking.hosts = {
    "127.0.0.1" = ["www.edeka.de.localhost" "verbund.edeka.localhost" "cms.edeka.localhost"];
  };

  services.caddy = {
    enable = true;
    virtualHosts."www.edeka.de.localhost".extraConfig = ''
      reverse_proxy localhost:4000
    '';
    virtualHosts."verbund.edeka.localhost".extraConfig = ''
      reverse_proxy localhost:4000
    '';
    virtualHosts."cms.edeka.localhost".extraConfig = ''
      reverse_proxy localhost:8001
    '';
  };
}
