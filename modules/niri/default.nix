{
  # --------------------------------------------------------
  # System-Level Configuration (NixOS)
  # --------------------------------------------------------
  flake.nixosModules.niri = { pkgs, ... }: {
    # Enable the Niri Wayland compositor system-wide.
    # This automatically adds the Niri session to SDDM.


    services.displayManager.ly = {
      enable = true;
    };
    
    programs.niri.enable = true;

    # Polkit is required for GUI apps to ask for sudo passwords
    security.polkit.enable = true;

    # A fallback polkit authentication agent (GNOME's is very reliable)
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # --------------------------------------------------------
  # User-Level Configuration (Home Manager)
  # --------------------------------------------------------
  flake.homeModules.niri = { pkgs, ... }: {
    home.packages = with pkgs; [
      nerd-fonts.fira-code
      ironbar       # The top status bar
      fuzzel       # Fast, Wayland-native application launcher
      swaybg       # Super lightweight wallpaper utility
      mako         # Notification daemon
      wl-clipboard # You already have this, but good to ensure it's here
      alacritty    # A GPU-accelerated terminal written in Rust
    ];

    # We will let Home Manager manage the directory structure, 
    # but we will write the config file in the next step.
    xdg.configFile."niri/config.kdl".source = ./config.kdl;
    xdg.configFile."ironbar/config.json".source = ./ironbar/config.json;
    xdg.configFile."ironbar/style.css".source = ./ironbar/style.css;
  };
}