{ ... }: {
  hardware.bluetooth.enable = true;

  environment.systemPackages = with pkgs; [
    bluetui
    blueman
  ];

  # services.udev.extraRules = ''
  #   ACTION=="add", SUBSYSTEM=="input", ENV{ID_BUS}=="bluetooth", ENV{ID_INPUT_KEY}=="1", RUN+="/home/nr/dotfiles/bin/on-bluetooth-connect"
  # '';
}
