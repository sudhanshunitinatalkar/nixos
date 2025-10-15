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
      grub.enable = true;
      grub.device = "/dev/sda";
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

    displayManager = 
    {
      defaultSession = "xfce";
      # Add this block for automatic login
      autoLogin = 
      {
        enable = true;
        user = "pbr";
      };
    };
    printing.enable = true;
    libinput.enable = true;
    openssh.enable = true;

    pipewire = 
    {
      enable = true;
      pulse.enable = true;
    };
    
    cloudflared = 
    {
      enable = true;
      tunnels = 
      {
        "af58ebe4-56c0-46a6-9281-367d1c68aff5" = 
        {
          credentialsFile = "${config.sops.secrets.cloudflared-creds.path}";
          default = "http_status:404";
          ingress =
          {
            "pbrlocal.eltros.in" = 
            {
            service = "ssh://localhost:22";
            };
          };
        };
      };
    };

    openssh.settings.Macs = 
    [
      "hmac-sha2-512-etm@openssh.com"
      "hmac-sha2-256-etm@openssh.com"
      "umac-128-etm@openssh.com"
      "hmac-sha2-256" # The required addition
    ];

    

    postgresql.enable = true;
    ollama =
    {
      enable = true;
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

  users.users.shreeyash = 
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
    sops-nix
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

  sops.secrets.cloudflared-creds = 
    {
      owner = config.services.cloudflared.user;
      group = config.services.cloudflared.group;
    };

}

