{
  config,
  pkgs,
  ...
}: {
  config = {

    services.syncthing = {
        enable = true;
    };

    home.packages = with pkgs; [
      # Terminal emulators
      kitty
      ghostty

      # Desktop environment components
      fuzzel
      wofi
      tofi
      rofi
      dmenu

      waybar
      swaybg
      wtype
      clipse
      cliphist
      flameshot
      apple-cursor
      iwmenu
      pwmenu
      bzmenu

      zenity
      pkg-config

      # GUI file managers & utilities
      nautilus
      kdePackages.dolphin
      gnome-font-viewer
      loupe
      gradia
      planify
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
      bitwarden

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

      # AI/ML tools
      ollama-cuda
      lmstudio

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
      tableplus = {
        name = "TablePlus";
        type = "Application";
        terminal = false;
        exec = "${pkgs.appimage-run}/bin/appimage-run ${config.home.homeDirectory}/apps/TablePlus-x64.AppImage";
      };

      excalidraw = {
        name = "Excalidraw";
        type = "Application";
        terminal = false;
        exec = "${pkgs.brave}/bin/brave --app=https://excalidraw.com";
        icon = "${pkgs.brave}/share/icons/hicolor/128x128/apps/brave.png";
      };

      fastmail = {
        name = "Fastmail";
        type = "Application";
        terminal = false;
        exec = "${pkgs.brave}/bin/brave --app=https://www.fastmail.com/";
        icon = "${pkgs.brave}/share/icons/hicolor/128x128/apps/chromium.png";
      };

      btop = {
        name = "btop";
        type = "Application";
        terminal = false;
        exec = "${pkgs.kitty}/bin/kitty --class=column.lg ${pkgs.btop}/bin/btop";
      };
    };

    programs.wofi = {
      enable = true;
      settings = {
        width = 800;
        height = 350;
        location = "center";
        show = "drun";
        prompt = "Search...";
        filter_rate = 100;
        allow_markup = true;
        matching = "fuzzy";
        no_actions = true;
        halign = "fill";
        orientation = "vertical";
        content_halign = "fill";
        insensitive = true;
        allow_images = true;
        image_size = 40;
        gtk_dark = true;
      };
    };
  };
}
