{ pkgs, ... }:

{
  
  home.packages = with pkgs;
  [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.gsconnect
    gnomeExtensions.caffeine
    gnomeExtensions.dash-to-dock
  ];
  
  dconf = {
      enable = true;
      settings = {
        "org/gnome/shell" = {
          # disable-user-extensions = true; # Optionally disable user extensions entirely
          enabled-extensions = with pkgs;
          [
            gnomeExtensions.gsconnect.extensionUuid
            gnomeExtensions.caffeine.extensionUuid
            gnomeExtensions.blur-my-shell.extensionUuid
            gnomeExtensions.dash-to-dock.extensionUuid
          ];
        };
      };
    };
}