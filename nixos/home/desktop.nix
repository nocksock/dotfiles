{
  config,
  pkgs,
  inputs,
  ...
}: let
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
in {
  config = {
    services.syncthing = {
      enable = true;
    };

    home.pointerCursor = let
      getFrom = url: hash: name: {
        gtk.enable = true;
        x11.enable = true;
        name = name;
        size = 48;
        package = pkgs.runCommand "moveUp" {} ''
          mkdir -p $out/share/icons
          ln -s ${pkgs.fetchzip {
            url = url;
            hash = hash;
          }} $out/share/icons/${name}
        '';
      };
    in
      getFrom
      "https://github.com/ful1e5/fuchsia-cursor/releases/download/v2.0.0/Fuchsia-Pop.tar.gz"
      "sha256-BvVE9qupMjw7JRqFUj1J0a4ys6kc9fOLBPx2bGaapTk="
      "Fuchsia-Pop";

    home.packages = with pkgs; [
      # Terminal emulators
      kitty
      ghostty

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

      # Browsers etc
      firefox
      brave
      ungoogled-chromium
      qutebrowser
      thunderbird

      # Password managers
      _1password-cli
      _1password-gui
      bitwarden-desktop

      # Creative apps
      blender
      gimp
      krita
      darktable
      digikam

      # Communication
      discord
      signal-desktop
      signal-cli
      teams-for-linux

      # AI/ML tools
      ollama-cuda
      n8n
      crush
      lmstudio
      open-webui

      # Other apps
      zeal
      obsidian
      cider-2
      syncthing
      icloudpd
      obs-studio
      wl-mirror
      appimage-run

      # libraries, file formats
      libheif
      pnpm
    ];

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
        monospace = ["Caskaydia Mono Nerd Font"];
      };
    };

    xdg.desktopEntries = {
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

      fastmail = mkPWA {
        name = "Fastmail";
        url = "https://www.fastmail.com/";
        icon = ./icons/fastmail.com.png;
      };

      tableplus = {
        name = "TablePlus";
        type = "Application";
        terminal = false;
        exec = "${pkgs.appimage-run}/bin/appimage-run ${config.home.homeDirectory}/.local/bin/TablePlus-x64.AppImage";
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
