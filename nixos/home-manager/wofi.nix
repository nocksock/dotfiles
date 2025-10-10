{
  config,
  pkgs,
  nix-colors,
  ...
}: let
  palette = nix-colors.colorSchemes.dracula.palette;
  convert = nix-colors.lib.conversions.hexToRGBString;
  backgroundRgb = "rgb(${convert ", " palette.base00})";
  foregroundRgb = "rgb(${convert ", " palette.base03})";
in {
  config = {
    home.file = {
      ".config/wofi/" = {
        source = ../config/wofi;
        recursive = true;
      };
    };
    programs.wofi = {
      enable = true;
      settings = {
        width = 600;
        height = 350;
        location = "center";
        show = "drun";
        prompt = "Search...";
        filter_rate = 100;
        allow_markup = true;
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
