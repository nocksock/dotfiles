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
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
        monospace = ["Caskaydia Mono Nerd Font"];
      };
    };
  };
}
