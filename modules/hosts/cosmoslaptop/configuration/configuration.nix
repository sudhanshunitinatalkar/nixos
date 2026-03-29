{
  flake.nixosModules.cosmoslaptop = { inputs, pkgs, ... }:
  {
    nix.settings = 
    {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "sudha" ];
    };
    system.stateVersion = "25.11";
    nixpkgs.config.allowUnfree = true;

    boot =
    {
      
      binfmt.emulatedSystems = [ "aarch64-linux" ];
      kernelPackages = pkgs.linuxPackages_latest;
      
      loader =
      {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
        timeout = 0;
      };

      initrd = {
        # 1. Enable systemd in initrd for a much faster, modern boot sequence
        systemd.enable = true; 
        
        # 2. Force the AMD driver to load at the absolute earliest moment
        kernelModules = [ "amdgpu" ];
        availableKernelModules = [ "amdgpu" ];
      };

      # Silent boot and speed parameters
      consoleLogLevel = 0; # Set to 0 to suppress almost all kernel text
      initrd.verbose = false;
      
      kernelParams = [
        "quiet"
        "splash"           # Explicitly trigger the splash screen
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_level=3"
        "fbcon=nodefer"    # Prevents delay in framebuffer initialization
        "reboot=pci"       # Your Lenovo reboot fix
        "vt.global_cursor_default=0" # Hides the blinking cursor during boot
      ];
    };

    hardware.bluetooth.enable = true;

    networking =
    {
      hostName = "cosmoslaptop";
      networkmanager.enable = true;
      firewall.enable = false;
      # firewall.allowedTCPPorts = [ ];
      # firewall.allowedUDPPorts = [ ];
    };

    users.users.sudha = 
    {
      isNormalUser = true;
      extraGroups = [ "wheel" "dialout" "docker"];
      
    };

    time = {
      timeZone = "Asia/Kolkata";
    };
    
    services =
    {
      printing.enable = true;
      ollama = {
        enable = true;
        package = pkgs.ollama-cuda;
      };

      pipewire =
      {
        enable = true;
        pulse.enable = true;
      };
      timesyncd.enable = true;
      openssh.enable = true;
    };

    environment.systemPackages = with pkgs;
    [
      tree
      util-linux
      vim
      wget
      curl
      git
      gptfdisk
      htop
      pciutils
      home-manager
    ];

    i18n.defaultLocale = "en_US.UTF-8";
    console =
    {
      keyMap = "us";
    }; 

  };
}
