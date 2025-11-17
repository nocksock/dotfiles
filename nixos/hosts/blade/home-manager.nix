{
  config,
  pkgs,
  home-manager,
  ...
}: let
  servicesDir = ../../../linux-desktop/dot-local/services;
in {
  home-manager.users.nr = {
    imports = [
      ../../modules/cli.nix
      ../../modules/desktop.nix
    ];
    nixpkgs.config.allowUnfree = true;
    home.stateVersion = "25.05";

    # Enable systemd user services for desktop environment
    systemd.user.services = {
      wallpaper = {
        Unit = {
          PartOf = ["graphical-session.target"];
          After = ["graphical-session.target"];
        };
        Service = {
          Type = "simple";
          ExecStart = "${servicesDir}/wallpaper/run";
          Restart = "on-failure";
          RestartSec = 3;
        };
        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };

      # waybar = {
      #   Unit = {
      #     Description = "Waybar status bar";
      #     PartOf = ["graphical-session.target"];
      #     After = ["graphical-session.target"];
      #   };
      #   Service = {
      #     Type = "simple";
      #     ExecStart = "${servicesDir}/waybar/run";
      #     Restart = "always";
      #     RestartSec = 3;
      #   };
      #   Install = {
      #     WantedBy = ["graphical-session.target"];
      #   };
      # };

      cliphist = {
        Unit = {
          PartOf = ["graphical-session.target"];
          After = ["graphical-session.target"];
          ConditionEnvironment = "WAYLAND_DISPLAY";
        };
        Service = {
          Type = "simple";
          ExecStart = "${servicesDir}/cliphist/run";
          Restart = "on-failure";
          RestartSec = 3;
        };
        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };

      color-scheme-watch = {
        Unit = {
          PartOf = ["graphical-session.target"];
          After = ["graphical-session.target"];
        };
        Service = {
          Type = "simple";
          ExecStart = "${servicesDir}/color-scheme-watch/run";
          Restart = "on-failure";
          RestartSec = 3;
        };
        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };

      icloudpd = {
        Unit = {
          Description = "iCloud Photos downloader";
          After = ["network-online.target"];
          Wants = ["network-online.target"];
        };
        Service = {
          Type = "simple";
          ExecStart = "${servicesDir}/icloudpd/run";
          Restart = "on-failure";
          RestartSec = 60;
        };
        Install = {
          WantedBy = ["default.target"];
        };
      };
    };
  };
}
