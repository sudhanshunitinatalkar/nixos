# modules/system/packages.nix
{ pkgs, ... }: {
  # List packages installed in system profile.
  environment.systemPackages = with pkgs; 
  [
    vim
    wget
    curl
    git
    kdePackages.sddm-kcm
  ];

  programs.firefox.enable = true;
  programs.kdeconnect.enable = true;
}