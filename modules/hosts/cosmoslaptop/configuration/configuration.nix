{
  flake.nixosModules.cosmos-laptop = { inputs, pkgs, lib, config,  ... }:
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
      };
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


      # Make virtual camera and audio drivers available to the kernel
    boot.extraModulePackages = with config.boot.kernelPackages; [ 
      v4l2loopback 
    ];
  
    # Force the kernel to load them at boot
    boot.kernelModules = [ 
      "v4l2loopback" 
      "snd-aloop" 
    ];

  };
}
