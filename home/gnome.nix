{ pkgs, ... }:

{
  
  home.packages = with pkgs;
  [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.gsconnect
    gnomeExtensions.caffeine
    gnomeExtensions.dash-to-dock
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.desktop-icons-ng-ding
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
            gnomeExtensions.clipboard-indicator.extensionUuid
            gnomeExtensions.desktop-icons-ng-ding.extensionUuid
          ];
        };
      };
    };
}