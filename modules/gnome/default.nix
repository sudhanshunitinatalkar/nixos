{
    flake.nixosModules.gnome = { config, pkgs, ... }:

    {
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome = {
        enable = true;
        extraGSettingsOverrides = ''
          [org.gnome.mutter]
          experimental-features=['scale-monitor-framebuffer']
        '';
    };

    environment.gnome.excludePackages = (with pkgs; [
        atomix # puzzle game
        cheese # webcam tool
        epiphany # web browser
        evince # document viewer
        geary # email reader
        gedit # text editor
        gnome-characters
        gnome-music
        gnome-photos
        gnome-terminal
        gnome-tour
        hitori # sudoku game
        iagno # go game
        tali # poker game
        totem # video player
        gnome-weather
        gnome-contacts
        gnome-maps
        showtime
        ]);
    };
    
}