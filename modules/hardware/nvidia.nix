# nvidia.nix
{ config, pkgs, ... }:

{
  # This option was renamed.
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  # Load drivers for both AMD iGPU and NVIDIA dGPU.
  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];

  hardware.nvidia =
  {
    # Modesetting is required for Wayland and modern Xorg.
    modesetting.enable = true;

    # Use the opensource NVIDIA driver.
    open = true;

    # Power management is essential for laptops to turn off the dGPU when not in use.
    powerManagement.enable = true;
    powerManagement.finegrained = true;

    dynamicBoost.enable = true;

    # Enable the NVIDIA settings menu, accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Select the latest stable driver.
    package = config.boot.kernelPackages.nvidiaPackages.latest;

    # This is the most important section for your laptop!
    prime =
    {
      # Enable PRIME Render Offload.
      offload.enable = true;

      # This automatically creates the `nvidia-offload` command.
      offload.enableOffloadCmd = true;

      # Bus IDs for your Lenovo IdeaPad Gaming
      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}