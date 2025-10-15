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
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;

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

  users.users.cosmicdust = 
  {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; 
  [
    
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

