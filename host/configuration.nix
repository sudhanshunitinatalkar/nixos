{ config, lib, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;
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

    cloudflared.enable = true;
    ollama =
    {
      enable = true;
      acceleration = "cuda";
    };

    # nixos/host/configuration.nix

    postgresql = {
      enable = true;
      # Ensure standard authentication methods are set:
      # - 'local all all peer': Allows users to connect via socket if their OS username matches the DB username.
      # - 'host all all 127.0.0.1/32 scram-sha-256': Requires password for TCP connections (used by ThingsBoard).
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser  auth-method
        local all       all     peer
        host  all       all     127.0.0.1/32   scram-sha-256
        host  all       all     ::1/128        scram-sha-256
      '';
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

  i18n.defaultLocale = "en_US.UTF-8";
  console = 
  {
    font = "Lat2-Terminus16";
    keyMap = "us";
    #useXkbConfig = true;
  };

}

