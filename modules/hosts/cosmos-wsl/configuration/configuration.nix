
# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  flake.nixosModules.cosmos-wsl = { config, lib, pkgs, ... }:

  {

    nixpkgs.config.allowUnfree = true; 

    nix.settings = 
    {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "sudha" ];
    };


    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];


    # imports = [
    #   <nixos-wsl/modules>
    # ];
  
    wsl = {
      enable = true;
      defaultUser = "sudha";
      
      # 1. This is the "Normal NixOS" secret:
      # It ensures systemd is the primary init, which helps D-Bus 
      # and other services stay alive properly.
      wslConf.boot.systemd = true;

      # 2. Fixes the GPU/OpenGL issues for your RTX 3050 
      # more cleanly than the LD_LIBRARY_PATH hack.
      useWindowsDriver = true;

      # 3. Allows you to run Windows .exe files from NixOS
      interop.register = true;
    };

    # 4. Force the user session to stay active (D-Bus Fix)
    users.users.sudha.linger = true;

    networking =
    {
      hostName = "cosmos-wsl";
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

    services =
    {
      # ollama = {
      #   enable = true;
      #   package = pkgs.ollama-cuda;
      # };
      openssh.enable = true;

      avahi = {
        enable = true;
        nssmdns4 = true; # Allow resolving .local addresses
        # Important: This allows the datalogger to also BE FOUND 
        # as protos.local if you want to SSH into it via name.
        publish = {
          enable = true;
          addresses = true;
          workstation = true;
        };
      };

      services.resolved = {
        enable = true;
        llmnr = "true"; # Enable Windows-style resolution
      };
    };

    time = {
      timeZone = "Asia/Kolkata";
    };
      

    programs.nix-ld.enable = true;

    services.dbus.enable = true;
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

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It's perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11"; # Did you read the comment?
  };
}
