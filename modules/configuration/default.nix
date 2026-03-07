{
  flake.nixosModules.configuration = { inputs, pkgs, ... }:
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
      kernelPackages = pkgs.linuxPackages;
      loader =
      {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

    };

    hardware.bluetooth.enable = true;

    networking =
    {
      hostName = "cosmos";
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
      hardwareClockInLocalTime = true;
    };
    
    services =
    {
      printing.enable = true;
      pipewire =
      {
        enable = true;
        pulse.enable = true;
      };
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
    ];

    i18n.defaultLocale = "en_US.UTF-8";
    console =
    {
      font = "Lat2-Terminus16";
      keyMap = "us";
    };   

  };
}
