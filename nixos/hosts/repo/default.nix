{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
  ];

  age.secrets = {
    gitlab-db-password = {
      file = ./gitlab-db-password.age;
      owner = "gitlab";
    };
    gitlab-root-password = {
      file = ./gitlab-root-password.age;
      owner = "gitlab";
    };
    gitlab-secret = {
      file = ./gitlab-secret.age;
      owner = "gitlab";
    };
    gitlab-otp = {
      file = ./gitlab-otp.age;
      owner = "gitlab";
    };
    gitlab-db-secret = {
      file = ./gitlab-db-secret.age;
      owner = "gitlab";
    };
    gitlab-jws = {
      file = ./gitlab-jws.age;
      owner = "gitlab";
    };
    gitlab-ar-primary-key = {
      file = ./gitlab-ar-primary-key.age;
      owner = "gitlab";
    };
    gitlab-ar-deterministic-key = {
      file = ./gitlab-ar-deterministic-key.age;
      owner = "gitlab";
    };
    gitlab-ar-salt = {
      file = ./gitlab-ar-salt.age;
      owner = "gitlab";
    };
  };

  services.gitlab = {
    enable = true;
    databasePasswordFile = config.age.secrets.gitlab-db-password.path;
    host = "gitlab.bleepbloop.studio";
    initialRootPasswordFile = config.age.secrets.gitlab-root-password.path;
    secrets = {
      secretFile = config.age.secrets.gitlab-secret.path;
      otpFile = config.age.secrets.gitlab-otp.path;
      dbFile = config.age.secrets.gitlab-db-secret.path;
      jwsFile = config.age.secrets.gitlab-jws.path;

      activeRecordPrimaryKeyFile = config.age.secrets.gitlab-ar-primary-key.path;
      activeRecordDeterministicKeyFile = config.age.secrets.gitlab-ar-deterministic-key.path;
      activeRecordSaltFile = config.age.secrets.gitlab-ar-salt.path;
    };
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "gitlab.bleepbloop.studio" = {
        forceSSL = true;
        enableACME = true;
        locations."/".proxyPass = "http://unix:/run/gitlab/gitlab-workhorse.socket";
      };
    };
  };

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "repo";
  networking.domain = "";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKvwpMNCPRDapiEGHKpvCpQvrDPtQMbAONFB/J7MEoPO''];
  system.stateVersion = "23.11";

  security.acme = {
    acceptTerms = true;
    defaults.email = "nils@bleepbloop.studio";
  };

  services.dockerRegistry = {
    enable = true;
    listenAddress = "0.0.0.0:5000";
    storagePath = "/var/lib/registry";
    extraConfig = {
      storage.delete.enabled = true;
      http.addr = "0.0.0.0:5000";
      auth = {
        htpasswd = {
          realm = "Registry Realm";
          path = "/var/lib/registry/htpasswd";
        };
      };
    };
  };

  # Create htpasswd file for Docker registry authentication
  systemd.services.docker-registry-auth = {
    description = "Create Docker registry htpasswd file";
    wantedBy = ["docker-registry.service"];
    before = ["docker-registry.service"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      User = "root";
    };
    script = ''
                  mkdir -p /var/lib/registry
      # Create htpasswd with default user 'admin' and password 'registry123'
                  ${pkgs.apacheHttpd}/bin/htpasswd -cbB /var/lib/registry/htpasswd admin registry123
                  chown docker-registry:docker-registry /var/lib/registry/htpasswd
                  chmod 640 /var/lib/registry/htpasswd
    '';
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 22 443 5000];
  };
}
