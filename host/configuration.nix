{ config, lib, pkgs, inputs, ... }:

let
  unstable = import inputs.nixpkgs-unstable 
  {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings = 
  {
    substituters = 
    [
      "https://cuda-maintainers.cachix.org"
    ];
    trusted-public-keys = 
    [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

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
      enable = true;
      acceleration = "cuda";
      package = unstable.ollama;
    };


    cloudflared = {
      enable = true;
      tunnels = {
        "89889c44-3d02-4b7e-830e-40ead7cfc02c" = {
          credentialsFile = "/home/sudhanshu/.cloudflared/89889c44-3d02-4b7e-830e-40ead7cfc02c.json";
          ingress = {
            "test.eltros.in" = "http://localhost:8080";
          };
          default = "http_status:404";
        };
      };
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

    wineWowPackages.stable

    wine

    (wine.override { wineBuild = "wine64"; })

    # support 64-bit only
    wine64

    # wine-staging (version with experimental features)
    wineWowPackages.staging

    # winetricks (all versions)
    winetricks

    # native wayland support (unstable)
    wineWowPackages.waylandFull
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  console = 
  {
    font = "Lat2-Terminus16";
    keyMap = "us";
    #useXkbConfig = true;
  };

}

