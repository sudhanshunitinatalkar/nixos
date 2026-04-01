{
  flake.nixosModules.lenovo-ideapad-gaming3-nvidia = { config, ... }:
  {
    # This option was renamed.
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;

    boot.kernelParams = [
      "nvidia.NVreg_PreserveVideoMemoryAllocations=0"
    ];

    # Load drivers for both AMD iGPU and NVIDIA dGPU.sduo 
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
      package = config.boot.kernelPackages.nvidiaPackages.beta;

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
  };


  flake.nixosModules.nixos-wsl-nvidia = { config, pkgs, ... }:
  {
    # Let WSL pass through the Windows GPU driver into the container.
    # This replaces ALL manual driver installation — do not set
    # services.xserver.videoDrivers or hardware.nvidia here.
    wsl.useWindowsDriver = true;

    # hardware.graphics still needs to be enabled so that
    # OpenGL/Vulkan userspace libraries are present for apps to link against.
    hardware.graphics.enable = true;

    # CUDA support — the stub library lets CUDA apps discover the GPU
    # through the Windows driver passthrough.
    environment.systemPackages = with pkgs; [
      cudaPackages.cudatoolkit
    ];

    # Tell CUDA where to find the paravirtualized driver libs that WSL
    # mounts at /usr/lib/wsl/lib at runtime.
    environment.sessionVariables = {
      LD_LIBRARY_PATH = "/usr/lib/wsl/lib:$LD_LIBRARY_PATH";
    };
  };
}