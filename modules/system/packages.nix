# modules/system/packages.nix
{ pkgs, ... }: {
  # List packages installed in system profile.
  environment.systemPackages = with pkgs; 
  [
    home-manager
    vim
    wget
    curl
    git
    kdePackages.sddm-kcm
  ];

  programs.firefox.enable = true;
  programs.kdeconnect.enable = true;
}