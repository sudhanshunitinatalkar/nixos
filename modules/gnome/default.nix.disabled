{
  # Added 'inputs' to the argument list so Home Manager can inherit it
  flake.nixosModules.gnome = { config, pkgs, inputs, ... }: 
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
      atomix 
      cheese 
      epiphany 
      evince 
      geary 
      gedit 
      gnome-characters
      gnome-music
      gnome-photos
      gnome-terminal
      gnome-tour
      hitori 
      iagno 
      tali 
      totem 
      gnome-weather
      gnome-contacts
      gnome-maps
      showtime
    ]);

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs; };
      users.sudha = {
        home.packages = with pkgs; [
          gnomeExtensions.gsconnect
          gnomeExtensions.caffeine
          gnomeExtensions.dash-to-dock
          gnomeExtensions.clipboard-indicator
        ];
        dconf = {
          enable = true;
          settings = {
            "org/gnome/shell" = {
              disable-user-extensions = false;
              enabled-extensions = [
                pkgs.gnomeExtensions.gsconnect.extensionUuid
                pkgs.gnomeExtensions.caffeine.extensionUuid
                pkgs.gnomeExtensions.dash-to-dock.extensionUuid
                pkgs.gnomeExtensions.clipboard-indicator.extensionUuid
              ];
            };
          };
        };
      };
    };
  }; 
}