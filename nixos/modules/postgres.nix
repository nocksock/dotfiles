{ pkgs, ... }: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;
    enableTCPIP = false;

    ensureUsers = [
      {
        name = "nr";
        ensureClauses = {
          superuser = true;
          createdb = true;
          createrole = true;
          login = true;
          replication = true;
        };
      }
    ];
  };

  environment.systemPackages = [ pkgs.postgresql_17 ];
}
