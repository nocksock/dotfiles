# NVIDIA GPU configuration with PRIME offload (AMD iGPU + NVIDIA dGPU)
{ pkgs, ... }: {
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Use open kernel modules (good support for RTX 50-series)
    open = true;

    # Enable nvidia-settings GUI tool
    nvidiaSettings = true;

    # CRITICAL: Enable kernel modesetting (required for Wayland)
    modesetting.enable = true;

    # CRITICAL: Enable power management (fixes suspend/resume)
    powerManagement.enable = true;

    # Enable fine-grained power management (experimental)
    # Allows NVIDIA GPU to fully power off (0W) when not in use
    powerManagement.finegrained = true;

    # Configure PRIME offload (AMD primary, NVIDIA on-demand)
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;

      # PCI Bus IDs (c4:00.0 = 196:0:0, c5:00.0 = 197:0:0 in decimal)
      nvidiaBusId = "PCI:196:0:0";
      amdgpuBusId = "PCI:197:0:0";
    };
  };

  # Force DPM=3 for full D3cold suspend
  boot.extraModprobeConfig = ''
    options nvidia "NVreg_DynamicPowerManagement=0x03"
  '';
}
