# Caddy reverse proxy for local development
{ ... }: {
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
    virtualHosts."studio.localhost".extraConfig = ''
      reverse_proxy localhost:8102
    '';
  };
}
