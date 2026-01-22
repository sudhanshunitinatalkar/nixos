{ pkgs, ... }:

{
  
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
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
    
    postgresql = 
        {
          enable = true;
          authentication = pkgs.lib.mkOverride 10 ''
            #type database  DBuser  auth-method
            local all       all     trust
            # Allow ThingsBoard (and other apps) to connect via TCP/IP
            host  all       all     127.0.0.1/32   scram-sha-256
            host  all       all     ::1/128        scram-sha-256
          '';
        };
        
        avahi = {
            enable = true;
            nssmdns4 = true; # <--- THIS IS THE KEY
            openFirewall = true; # Optional, but helps if you have a firewall on the laptop
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
  
  virtualisation.docker = {
    enable = true;
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
