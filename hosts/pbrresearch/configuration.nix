{ config, lib, pkgs, ... }:

{

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports =
  [ 
    ./hardware-configuration.nix
  ];

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
    hostName = "pbrresearch";
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
    xserver = 
    {
      enable = true;
      desktopManager = 
      {
        xterm.enable = false;
        xfce.enable = true;
      };
    };
    displayManager.defaultSession = "xfce";

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

  users.users.pbr = 
  {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  users.users.cosmicdust = 
  {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
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
    cloudflared
    kdePackages.sddm-kcm
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

