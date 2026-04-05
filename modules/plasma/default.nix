{
  flake.nixosModules.plasma = { pkgs, inputs, ... }:

  {
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      
      # Enforce the default Plasma 6 theme
      theme = "breeze";
      
      # Run the SDDM greeter natively under Wayland instead of X11
      wayland.enable = true; 
      
      # Inject Qt scaling environment variables directly into the SDDM greeter
      settings = {
        General = {
          GreeterEnvironment = "QT_SCALE_FACTOR=1.2";
        };
      };
    };
  };

  environment.systemPackages = with pkgs;
    [
      # KDE
      kdePackages.plasma-browser-integration
      kdePackages.kcalc # Calculator
      kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
      kdePackages.kclock # Clock app
      kdePackages.kcolorchooser # A small utility to select a color
      kdePackages.kolourpaint # Easy-to-use paint program
      kdePackages.ksystemlog # KDE SystemLog Application
      kdiff3 # Compares and merges 2 or 3 files or directories
      kdePackages.isoimagewriter # Optional: Program to write hybrid ISO files onto USB disks
      kdePackages.partitionmanager # Optional: Manage the disk devices, partitions and file systems on your computer
      hardinfo2 # System information and benchmarks for Linux systems
      wayland-utils # Wayland utilities
      wl-clipboard # Command-line copy/paste utilities for Wayland
      kdePackages.isoimagewriter
      kdePackages.filelight
      kdePackages.kdeconnect-kde
      kdePackages.ktorrent
    ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };

}