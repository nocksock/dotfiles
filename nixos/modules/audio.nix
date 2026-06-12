{ pkgs, ... }: {
  security.rtkit.enable = true;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };
  
  environment.systemPackages = with pkgs; [
    pavucontrol
    wiremix
    pamixer
    sox
    alsa-utils
    playerctl
  ];
}
