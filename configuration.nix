{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./nvidia.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "cosmos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  hardware.bluetooth.enable = true;
 
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";


  users.users.cosmicdust = 
  {
    isNormalUser = true;
    extraGroups = [ "wheel"];
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; 
  [
    vim
    wget
    curl
    git
    gptfdisk
    util-linux
    cloudflared
    android-tools
    kdePackages.sddm-kcm
  ];



  programs.firefox.enable = true;
  programs.kdeconnect.enable = true;

  # List services that you want to enable:
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.printing.enable = true;
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  services.openssh.enable = true;
  services.cloudflared.enable = true;
  services.postgresql.enable = true;
  services.ollama =
  {
    enable = true;
    acceleration = "cuda";
  };

  programs.steam = 
  {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
  # networking.firewall.allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
  # Or disable the firewall altogether.
   networking.firewall.enable = false;

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05"; # Did you read the comment?

}

