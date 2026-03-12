{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # TPM2 support for LUKS auto-unlock
  boot.initrd.systemd.enable = true;
  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true;
  security.tpm2.tctiEnvironment.enable = true;

  # Resume from swapfile for hibernate
  boot.resumeDevice = "/dev/disk/by-uuid/ec443945-1428-4406-89e6-07eadb63a71d";
  boot.kernelParams = [
    "resume_offset=9150464"
  ];

  environment.systemPackages = with pkgs; [
    nvitop
    amdgpu_top
    radeontop
    localsend
  ];
  services.flatpak.enable = true;

  services.printing = {
    enable = true;
    drivers = with pkgs; [splix];
  };

  services.mullvad-vpn.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;
  # Suspend-then-hibernate: quick suspend for fast resume,
  # auto-hibernate after 15min for full encryption at rest
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "suspend-then-hibernate";
    HandleLidSwitchDocked = "lock";
    HandleSuspendKey = "suspend-then-hibernate";
  };

  # Hibernate delay configuration
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=15min
  '';

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
