{ config, lib, pkgs, inputs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports =
  [ 
    ./hardware-configuration.nix
  ];

  boot = 
  {
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

    ollama =
    {
      enable = false;
    };


    # cloudflared = {
    #   enable = true;
    #   tunnels = {
    #     "38eb42ff-0229-46cf-8cee-7b8a501f4f38" = {
    #       credentialsFile = "/home/sudha/.cloudflared/38eb42ff-0229-46cf-8cee-7b8a501f4f38.json";
    #       ingress = {
    #         "test.eltros.in" = "http://localhost:5000";
    #       };
    #       default = "http_status:404";
    #     };
    #   };
    # };
    
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
    #useXkbConfig = true;
  };

}

