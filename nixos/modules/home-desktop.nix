# Home Manager configuration for desktop services and applications
{
  config,
  pkgs,
  inputs,
  ...
}: let
  servicesDir = ../../linux-desktop/dot-local/services;
  mkPWA = {
    name,
    url,
    icon,
    categories ? ["Network"],
  }: {
    inherit name categories;
    exec = "${pkgs.brave}/bin/brave --app=${url} --class=${pkgs.lib.toLower name}";
    icon = icon;
  };

  mkApp = {
    name,
    appImage
  }: {
    inherit name;
    type = "Application";
    terminal = false;
    exec = "${pkgs.appimage-run}/bin/appimage-run ${appImage}";
  };

  # Wrap a package to use NVIDIA GPU via PRIME offload
  wrapWithNvidia = pkg: pkgs.symlinkJoin {
    name = "${pkg.pname or pkg.name}-nvidia";
    paths = [ pkg ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      for bin in $out/bin/*; do
        if [ -f "$bin" ] && [ -x "$bin" ]; then
          wrapProgram "$bin" \
            --set __NV_PRIME_RENDER_OFFLOAD 1 \
            --set __VK_LAYER_NV_optimus NVIDIA_only \
            --set __GLX_VENDOR_LIBRARY_NAME nvidia
        fi
      done
    '';
  };

  # Packages that should use the NVIDIA GPU by default
  nvidiaPackages = [
    (wrapWithNvidia pkgs.ollama)
    (wrapWithNvidia pkgs.blender)
    (wrapWithNvidia pkgs.darktable)
    (wrapWithNvidia pkgs.krita)
  ];
in {
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  config = {
    services.syncthing = {
      enable = true;
    };

    services.vicinae = {
      enable = true;
      systemd = {
        enable = true;
        autoStart = true;
        environment = {
          USE_LAYER_SHELL = "1";
        };
      };
    };

    systemd.user.services = {
      # Lock screen before sleep
      lock-before-sleep = {
        Unit = {
          Description = "Lock screen before sleep";
          Before = [ "sleep.target" ];
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${pkgs.swaylock}/bin/swaylock -f";
        };
        Install = {
          WantedBy = [ "sleep.target" ];
        };
      };

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

      waybar = {
        Unit = {
          Description = "Waybar status bar";
          PartOf = ["graphical-session.target"];
          After = ["graphical-session.target"];
        };
        Service = {
          Type = "simple";
          ExecStart = "${servicesDir}/waybar/run";
          Restart = "always";
          RestartSec = 3;
        };
        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };

      mako = {
        Unit = {
          Description = "Mako notification daemon";
          PartOf = ["graphical-session.target"];
          After = ["graphical-session.target"];
          ConditionEnvironment = "WAYLAND_DISPLAY";
        };
        Service = {
          Type = "simple";
          ExecStart = "${servicesDir}/mako/run";
          Restart = "always";
          RestartSec = 3;
        };
        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };

      ollama = {
        Unit = {
          Description = "Ollama AI service";
          After = ["network.target"];
        };
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.ollama}/bin/ollama serve";
          Restart = "always";
          RestartSec = 3;
          Environment = [
            "__NV_PRIME_RENDER_OFFLOAD=1"
            "__VK_LAYER_NV_optimus=NVIDIA_only"
            "__GLX_VENDOR_LIBRARY_NAME=nvidia"
          ];
        };
        Install = {
          WantedBy = ["default.target"];
        };
      };
    };

    # home.pointerCursor = {
    #   gtk.enable = true;
    #   x11.enable = true;
    #   name = "apple-cursor";
    #   size = 48;
    #   package = pkgs.stdenv.mkDerivation {
    #     pname = "apple-cursor";
    #     version = "2.0.1";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "ful1e5";
    #       repo = "apple_cursor";
    #       rev = "v2.0.1";
    #       sha256 = "sha256-gWdumtTFeTOu//APtaf255v9Hx61H1KtCfWZ39wPkFo=";
    #     };
    #     installPhase = ''
    #       mkdir -p $out/share/icons/apple
    #       cp -r * $out/share/icons/apple/
    #     '';
    #   };
    # };

    # home.pointerCursor = let
    #   getFrom = url: hash: name: {
    #     gtk.enable = true;
    #     x11.enable = true;
    #     name = name;
    #     size = 48;
    #     package = pkgs.runCommand "moveUp" {} ''
    #       mkdir -p $out/share/icons
    #       ln -s ${pkgs.fetchzip {
    #         url = url;
    #         hash = hash;
    #       }} $out/share/icons/${name}
    #     '';
    #   };
    # in
    #   getFrom
    #   "https://github.com/ful1e5/fuchsia-cursor/releases/download/v2.0.0/Fuchsia-Pop.tar.gz"
    #   "sha256-BvVE9qupMjw7JRqFUj1J0a4ys6kc9fOLBPx2bGaapTk="
    #   "Fuchsia-Pop";

    home.packages = with pkgs; [
      # Terminal emulators
      kitty
      ghostty

      # Screen locker
      swaylock

      # Desktop environment components
      fuzzel
      tofi
      zenity

      waybar
      swaybg
      wtype
      clipse
      cliphist
      apple-cursor
      pkg-config

      inputs.quickshell.packages.${system}.default
      inputs.noctalia.packages.${system}.default

      # GUI file managers & utilities
      nautilus
      gnome-font-viewer
      loupe
      gradia
      pavucontrol

      wiremix
      bluetui

      # Browsers etc
      firefox
      brave
      ungoogled-chromium
      qutebrowser

      # Password managers
      _1password-cli
      _1password-gui
      bitwarden-desktop

      # Creative apps (GPU apps in nvidiaPackages below)
      gimp
      digikam

      # Communication
      discord
      teams-for-linux
      beeper

      # Other apps
      zeal
      obsidian
      cider-2
      syncthing
      icloudpd
      wl-mirror
      appimage-run
      figma-linux
      transmission_4
      sox
      hyprland

      # libraries, file formats
      libheif
      pnpm
    ] ++ nvidiaPackages;

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
        monospace = ["Caskaydia Mono Nerd Font"];
      };
    };

    xdg.desktopEntries = {
      # reminder: there is ./icons/get-icon.sh <url>

      devdocs = mkPWA {
        name = "Feedbin";
        url = "https://devdocs.com";
        icon = ./icons/devdocs.io.png;
      };

      feedbin = mkPWA {
        name = "Feedbin";
        url = "https://feedbin.com";
        icon = ./icons/feedbin.com.png;
      };

      excalidraw = mkPWA {
        name = "Excalidraw";
        url = "https://excalidraw.com";
        icon = ./icons/excalidraw.com.png;
      };

      whatsapp = mkPWA {
        name = "WhatsApp";
        url = "https://web.whatsapp.com";
        icon = ./icons/web.whatsapp.com.png;
      };

      fastmail = mkPWA {
        name = "Fastmail";
        url = "https://www.fastmail.com/";
        icon = ./icons/fastmail.com.png;
      };

      notion = mkPWA {
        name = "Notion";
        url = "https://notion.so/";
        icon = ./icons/notion-logo.png;
      };

      notion-calendar = mkPWA {
        name = "Notion Calendar";
        url = "https://calendar.notion.so/";
        icon = ./icons/notion-logo.png;
      };

      tidewave = mkApp {
        name = "Tidewave";
        appImage = "${config.home.homeDirectory}/.local/bin/tidewave-app-amd64.AppImage";
      };

      polypane = mkApp {
        name = "Polypane";
        appImage = "${config.home.homeDirectory}/.local/bin/Polypane-27.0.2.AppImage";
      };

      tableplus = mkApp {
        name = "TablePlus";
        appImage = "${config.home.homeDirectory}/.local/bin/TablePlus-x64.AppImage";
      };

      horse = mkApp {
        name = "Horse";
        appImage = "${config.home.homeDirectory}/.local/bin/Horse-0.75.2-x64.AppImage";
      };

      btop = {
        name = "btop";
        type = "Application";
        terminal = false;
        exec = "${pkgs.kitty}/bin/kitty  ${pkgs.btop}/bin/btop";
      };
    };
  };
}
