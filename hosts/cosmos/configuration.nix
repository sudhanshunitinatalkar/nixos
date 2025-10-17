{ config, lib, pkgs, ... }:

{

  system.stateVersion = "25.11";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  imports =
  [ 
    ./hardware-configuration.nix
  ];

  home-manager = 
  {
    useGlobalPkgs = true;
    useUserPackages = true;
  };


  boot = 
  {
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
    hostName = "cosmos";
    networkmanager.enable = true;
    firewall.enable = false;
    # firewall.allowedTCPPorts = [ ];
    # firewall.allowedUDPPorts = [ ];
  };
  
  programs = 
  {
    firefox.enable = true;
    mtr.enable = true;
    gnupg.agent = 
    {
      enable = true;
      enableSSHSupport = true;
    };
  };

  services = 
  {
    printing.enable = true;
    libinput.enable = true;
    openssh.enable = true;

    pipewire = 
    {
      enable = true;
      pulse.enable = true;
    };

    cloudflared.enable = true;
    postgresql.enable = true;
    ollama =
    {
      enable = true;
      acceleration = "cuda";
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
    home-manager
  ];

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";
  console = 
  {
    font = "Lat2-Terminus16";
    keyMap = "us";
    #useXkbConfig = true;
  };

}

