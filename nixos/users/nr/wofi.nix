{ ... }:  {
  config = {
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
