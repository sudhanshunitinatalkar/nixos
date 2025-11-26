{ config, pkgs, ... }:
{
      # Enable the X11 windowing system.
   services.displayManager.gdm.enable = true;
   services.desktopManager.gnome.enable = true;

   programs.dconf.settings = 
    {
        "org/gnome/mutter" = 
        {
            experimental-features = [ "scale-monitor-framebuffer" ];
        };
    };
    
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



}