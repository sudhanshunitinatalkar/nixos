{
  flake.nixosModules.plasma = { pkgs, inputs, ... }:
  let
    sddm-theme = pkgs.sddm-astronaut.override {
      themeConfig = {
        background = "${./gargantua-black-5200x3250-9621.jpg}";
      };
    };
  in

  {
  services = {
    desktopManager.plasma6.enable = true;

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
      extraPackages = [ sddm-theme ];
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
      kdePackages.sddm-kcm # Configuration module for SDDM
      kdiff3 # Compares and merges 2 or 3 files or directories
      kdePackages.isoimagewriter # Optional: Program to write hybrid ISO files onto USB disks
      kdePackages.partitionmanager # Optional: Manage the disk devices, partitions and file systems on your computer
      # Non-KDE graphical packages
      hardinfo2 # System information and benchmarks for Linux systems
      wayland-utils # Wayland utilities
      wl-clipboard # Command-line copy/paste utilities for Wayland
      kdePackages.isoimagewriter
      kdePackages.filelight
      kdePackages.sddm-kcm
      kdePackages.kdeconnect-kde
      (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
        [General]
        background=${./gargantua-black-5200x3250-9621.jpg}
      '')
    ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  flake.homeModules.plasma = { inputs, ... }: {
    # Import plasma-manager locally to this module
    imports = [
      inputs.plasma-manager.homeModules.plasma-manager
    ];
    programs.plasma = {
      enable = true;
      overrideConfig = true;
      
      # Dark Mode setup
      workspace = {
        theme = "breeze-dark";      # Sets the Plasma Desktop/Panel theme
        colorScheme = "BreezeDark"; # Sets the Application colors

        # Disable launch feedback
        cursor = {
          cursorFeedback = "None";
          taskManagerFeedback = false;
        };
        # Disable splash screen
        splashScreen.theme = "None";

        wallpaper = ./gargantua-black-5200x3250-9621.jpg;
      };

      kscreenlocker.appearance.wallpaper = ./gargantua-black-5200x3250-9621.jpg;

       
      # Natural scrolling for the trackpad
      input.touchpads = [
        {
          enable = true;
          name = "SYNA0001:00 06CB:CE78 Touchpad";
          vendorId = "06cb"; # 1739 in hex
          productId = "ce78"; # 52856 in hex
          naturalScroll = true;
        }
      ];

      # Disable Session Restore
      session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

      # Magic Lamp animation for window minimize
      kwin.effects.minimization.animation = "magiclamp";

      # Write Xwayland scaling direct to kwinrc (120%)
      configFile.kwinrc.Xwayland.Scale = 1.2;

      panels = [
        # --- 1. Top Panel (Status Bar) ---
        {
          location = "top";
          height = 28;
          widgets = [
            "org.kde.plasma.appmenu" 
            "org.kde.plasma.panelspacer" 
            {
              digitalClock = {
                date = {
                  position = "besideTime";
                };
              };
            }
            "org.kde.plasma.panelspacer" 
            "org.kde.plasma.pager"
            "org.kde.plasma.systemtray"
            "org.kde.plasma.showdesktop"
          ];
        }

        # --- 2. Bottom Panel (Centered Dock) ---
        {
          location = "bottom";
          height = 54;
          floating = true;
          alignment = "center";
          lengthMode = "fit"; 
          hiding = "dodgewindows"; 
          widgets = [
            "org.kde.plasma.kickoff"
            {
              iconTasks = {
                launchers = [
                  "applications:org.kde.konsole.desktop"
                  "applications:org.kde.dolphin.desktop" 
                  "applications:zen.desktop"             
                  "applications:code.desktop"                       
                  "applications:org.kde.plasma-systemmonitor.desktop" 
                  "applications:systemsettings.desktop"
                ];
              };
            }
          ];
        }
      ];
    };
  };
}