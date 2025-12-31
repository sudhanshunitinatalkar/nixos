{ pkgs, ... }:

{
      # Enable the X11 windowing system.
   services.displayManager.gdm.enable = true;
   services.desktopManager.gnome.enable = true;

    programs.dconf.profiles.user.databases = 
    [
        {
            settings = 
            {
                "org/gnome/mutter" = 
                {
                    experimental-features =
                    [
                        "scale-monitor-framebuffer" # Enables fractional scaling (125% 150% 175%)
                        "xwayland-native-scaling" # Scales Xwayland applications to look crisp on HiDPI screens
                    ];
                };
            };
        }
    ];

    
   environment.gnome.excludePackages = 
    (with pkgs; [
        epiphany # web browser
        evince # document viewer
        geary # email reader
        gnome-music
        gnome-photos
        gnome-tour
        totem # video player
        gnome-maps
        gnome-weather
        gnome-contacts
        decibels
    ]);


    environment.systemPackages = with pkgs; [
        gnomeExtensions.blur-my-shell
        gnomeExtensions.caffeine
        gnomeExtensions.gsconnect
    ];



}