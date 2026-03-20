{ inputs, config, lib, pkgs, ... }:
{
  flake.homeModules.sudha = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;

    # REQUIRED for standalone Home Manager
    home.username = "sudha";
    home.homeDirectory = "/home/sudha";
    home.stateVersion = "25.11";

    programs.home-manager.enable = true;

    home.packages = with pkgs; [
      tree 
      util-linux 
      vim 
      wget 
      curl 
      git 
      gptfdisk 
      htop 
      fastfetch
      android-tools 
      sops 
      pciutils 
      mosquitto 
      nixd 
      nil
      cloudflared 
      prusa-slicer 
      libreoffice-fresh 
      telegram-desktop
      vlc 
      obs-studio 
      cachix 
      vscode 
      python3 
      stm32cubemx 
      minicom 
      freecad 
      impression
    ];

    programs.git = {
      enable = true;
      settings.user = {
        name = "sudhanshunitinatalkar";
        email = "atalkarsudhanshu@proton.me";
      };
    };

    programs.plasma = {
      enable = true;
      overrideConfig = true;
      
      # Dark Mode setup
      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
        colorScheme = "BreezeDark";
      };

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
        {
          location = "bottom";
          widgets = [
            # The application launcher (start menu)
            "org.kde.plasma.kickoff"
            # Virtual desktop pager
            "org.kde.plasma.pager"
            
            # The taskbar / icon tasks widget
            {
              iconTasks = {
                launchers = [
                  "applications:org.kde.konsole.desktop"             # Terminal
                  "applications:org.kde.plasma-systemmonitor.desktop" # System Monitor
                  "applications:code.desktop"                        # VSCode
                ];
              };
            }
            
            # Separator pushes the following widgets to the right
            "org.kde.plasma.marginsseparator"
            # System tray (wifi, bluetooth, volume, etc.)
            "org.kde.plasma.systemtray"
            # Clock
            "org.kde.plasma.digitalclock"
            # Show desktop button
            "org.kde.plasma.showdesktop"
          ];
        }
      ];
    };
  };
}