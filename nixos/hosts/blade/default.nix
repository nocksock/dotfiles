{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./home-manager.nix
  ];

  environment.systemPackages = with pkgs; [
    nvitop
  ];

  services.printing = {
    enable = true;
    drivers = with pkgs; [splix];
  };

  services.logind.lidSwitch = "suspend-then-hibernate";
  services.logind.lidSwitchExternalPower = "suspend-then-hibernate";
  services.logind.lidSwitchDocked = "lock";
  # one of "ignore", "poweroff", "reboot", "halt", "kexec", "suspend", "hibernate", "hybrid-sleep", "suspend-then-hibernate", "lock"

  hardware.openrazer.enable = true;
  services.thermald.enable = true;
  powerManagement.powertop.enable = true;
  powerManagement.enable = true;

  # # Wrap brightnessctl to use amdgpu_bl1.
  # nixpkgs.config.packageOverrides = pkgs: {
  #   brightnessctl = pkgs.symlinkJoin {
  #     name = "brightnessctl";
  #     paths = [pkgs.brightnessctl];
  #     buildInputs = [pkgs.makeWrapper];
  #     postBuild = ''
  #       wrapProgram $out/bin/brightnessctl \
  #           --add-flags "-d amdgpu_bl1"
  #     '';
  #   };
  # };

  # services.tlp = {
  #   enable = true;
  #   settings = {
  #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
  #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  #
  #     CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
  #     CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
  #
  #     CPU_MIN_PERF_ON_AC = 0;
  #     CPU_MAX_PERF_ON_AC = 100;
  #     CPU_MIN_PERF_ON_BAT = 0;
  #     CPU_MAX_PERF_ON_BAT = 20;
  #
  #     # Optional helps save long term battery health
  #     START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
  #     STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
  #   };
  # };
  #
}
